Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005DDC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EAA2075E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfW8TG5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EAA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLxtc-0002w3-Vf
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 18:40:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs2-0001z9-DM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs0-0007xf-5i
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLxrw-0007vK-Lo
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id z8so81149pln.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9sfstqLaMMWEwl1aQWTCXX6WCI6EEx8P/cSgyaZCh2g=;
	b=PfW8TG5vCgwE0WZhx28oQW45e6pNSyMH4yOpjZI0IUCMFD/AzQEYssF6P/mxaPRy15
	rx4YY/mCy0SpQXm8BodXqWudaYZWZOMLI72ZSWLu8BAab6BcmrjfkWu1ZtL9eJhH49OR
	F9sn30eDHc5oUZf+2+Dp3ii+AlSmpx7B5O6HJAUdhdDyAABcmDVkSlEGknMuCcKazEVH
	y5lrmWo+UzTWf5wuOoCQ+BVPk9RwLLXntbyXyJGIrPUVSOWA/bNHhVyayi+YMaaVOoow
	phaYbwTRfc2FBf2DY+3onmG9zfFXPuA8TOwU4DywdpoZfj5YVKIvrobjAnbbn25B7q1H
	EJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9sfstqLaMMWEwl1aQWTCXX6WCI6EEx8P/cSgyaZCh2g=;
	b=OdEhRcB6r8Yt2TCnNQpPfLH9PwBQ0SBohGy6R3TLsXmkjWPAxO38IYm2efZ1arei3S
	8tq5VX6yw5RD6eMKZ0OihRRD3JUOY3psEbZ3F4+RZ+EuLmXuyqACdQ1em3MoPIWL/YZz
	IYW9S5HEcXx+ci0FViTwMozA60E3DUpNH2BMrqIqYIGi1GaJYK8M/lPOFDJewT+agS0u
	6k8UPA1uGBQhGaJUYVBuChztTrcVTtgRVm6+Lnvm5IbMetfUPyO0JLoAI5i44+Kjl3dJ
	lQWFXkP1yrV+SRInOgKKCEPjO4JOaCQJW+Ya75TNlYEzJp02LXr3su7oa5C/Gv9AYT30
	Wmdg==
X-Gm-Message-State: APjAAAWUkSgKQbfrJkewfbhbpsCEWP7iq1medvIN/c0s2XmCNWVoGqsu
	tJIotwF5lhvLoJtjnYJpnx21kcCvPUg=
X-Google-Smtp-Source: APXvYqwct8opWhxPh25W9eCdF7qvSp30mSSjrVrtecVKsOH1/6j5eo2spdlsGqGbh0Mpu4j0ruJliA==
X-Received: by 2002:a17:902:2cc1:: with SMTP id
	n59mr179947plb.22.1556750303796; 
	Wed, 01 May 2019 15:38:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	s85sm70603354pfa.23.2019.05.01.15.38.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 15:38:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 15:38:19 -0700
Message-Id: <20190501223819.8584-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501223819.8584-1-richard.henderson@linaro.org>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 2/2] configure: Use quotes around uses of
 $CPU_CFLAGS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501223819.5HXerhf01KLMoQeA1nNpbD3fclSHGcfqrNKXz1iLiZ4@z>

About half of the values to which CPU_CFLAGS is set
have multiple space separated arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 234cb929ca..16bd4375d1 100755
--- a/configure
+++ b/configure
@@ -1543,37 +1543,37 @@ case "$cpu" in
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_ppc64=$cc
-           cross_cc_cflags_ppc64=$CPU_CFLAGS
+           cross_cc_cflags_ppc64="$CPU_CFLAGS"
            ;;
     sparc)
            CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
            LDFLAGS="-m32 -mv8plus $LDFLAGS"
            cross_cc_sparc=$cc
-           cross_cc_cflags_sparc=$CPU_CFLAGS
+           cross_cc_cflags_sparc="$CPU_CFLAGS"
            ;;
     sparc64)
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_sparc64=$cc
-           cross_cc_cflags_sparc64=$CPU_CFLAGS
+           cross_cc_cflags_sparc64="$CPU_CFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
            LDFLAGS="-m31 $LDFLAGS"
            cross_cc_s390=$cc
-           cross_cc_cflags_s390=$CPU_CFLAGS
+           cross_cc_cflags_s390="$CPU_CFLAGS"
            ;;
     s390x)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_s390x=$cc
-           cross_cc_cflags_s390x=$CPU_CFLAGS
+           cross_cc_cflags_s390x="$CPU_CFLAGS"
            ;;
     i386)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
            cross_cc_i386=$cc
-           cross_cc_cflags_i386=$CPU_CFLAGS
+           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
@@ -1582,13 +1582,13 @@ case "$cpu" in
            CPU_CFLAGS="-m64 -mcx16"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_x86_64=$cc
-           cross_cc_cflags_x86_64=$CPU_CFLAGS
+           cross_cc_cflags_x86_64="$CPU_CFLAGS"
            ;;
     x32)
            CPU_CFLAGS="-mx32"
            LDFLAGS="-mx32 $LDFLAGS"
            cross_cc_i386=$cc
-           cross_cc_cflags_i386=$CPU_CFLAGS
+           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     # No special flags required for other host CPUs
 esac
-- 
2.17.1


