Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5751BC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E84206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKjjQI7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E84206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhWw-0002Qr-Ty
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:35:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV5-0000xO-1B
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV2-0001EU-VC
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:46467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhV0-0001CZ-W6
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:33:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id bi2so6693377plb.13
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=3IcDqOxNxFpx6A0tMNvu47gM3lLo8oZJFxC0ZgDmPNI=;
	b=oKjjQI7XVRe+sFhrMIATJOL1VyUY+fzx97cMBhwu57e9IPvhP/GSvaazc9Td3vfuEq
	WzCBcx1EBJXNwmeAkEmX4FSZq8F606fSiynWx4V5g22ZSdG+n/7Z5VwbkSQjH4jtnoCa
	mvMyDQmv/spUO+bejio3bvbJo3ilzQgkZuJJlUPRwT98ubZzZRY7CJ0dIDZi05MjXW5m
	xzbxVbl++L1EvLlAglY7Jw0DGGFFFfjnfEJrKBeLbKY6Oikt3oujCBkrwKNTqWX07uOZ
	k2A6uWHAb69W7UdtXBTHEEJp+dHAupyu9WvvRIajrj7GmN1S+z3bWzXt40sKDkHWXEk2
	WGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=3IcDqOxNxFpx6A0tMNvu47gM3lLo8oZJFxC0ZgDmPNI=;
	b=SceXMgQ7JRHlq160tbrN15DlQ4drdp8aMsqgngvK9saoCVP6DCvneHvtaqKgIkgyob
	/X7hE8Ny6Vf/w+2K5mqeGZT74XLsOnQ6YByh2Gmr5W3fJtaLuGuGGpBqqO9nr/HByWw4
	GU3yuVGb5KqsdZlR9n4D0mq5vDn7D3tGuqASB5htAiOmb0RtyEf/raEN1f5S52/suIU6
	8IFkO3C0Q4e26t10/JGuuevl+jcXlNX7ov8t92/4dfsdXzHUKK2Snx6wQO5H1TxjMsGU
	gQlfE+jORkNWWn3/jDiYl7aWUzF0+J7c5UW+dicrG1b99P2jwSrDuT2C0caHDOyB43Jy
	PTNg==
X-Gm-Message-State: APjAAAW/k+C+FfrIrZdjYsUzsPnnFCcvzj1LV6Z4E90twIaAuBXrjZai
	ZUkHikAuazJ/t/3+2j6zHQyxSRIUmJE=
X-Google-Smtp-Source: APXvYqxHRF9Jaw5bKlHjuKKlvJAckzuGgmhoyML4DNok2H30Fas9aGJuWefEMh9zpNq9vDHNwrghwg==
X-Received: by 2002:a17:902:5982:: with SMTP id
	p2mr1790959pli.197.1557164036766; 
	Mon, 06 May 2019 10:33:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.33.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:30 -0700
Message-Id: <20190506173353.32206-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::631
Subject: [Qemu-devel] [PATCH v4 01/24] configure: Link test before
 auto-enabling gnutls
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least ubuntu 18.04 does not package static gnutls libraries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 5b183c2e39..daadfe9ad4 100755
--- a/configure
+++ b/configure
@@ -2784,17 +2784,24 @@ fi
 # GNUTLS probe
 
 if test "$gnutls" != "no"; then
+    pass="no"
     if $pkg_config --exists "gnutls >= 3.1.18"; then
         gnutls_cflags=$($pkg_config --cflags gnutls)
         gnutls_libs=$($pkg_config --libs gnutls)
-        libs_softmmu="$gnutls_libs $libs_softmmu"
-        libs_tools="$gnutls_libs $libs_tools"
-	QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
-        gnutls="yes"
-    elif test "$gnutls" = "yes"; then
+        # Packaging for the static libraries is not always correct.
+        # At least ubuntu 18.04 ships only shared libraries.
+        write_c_skeleton
+        if compile_prog "" "$gnutls_libs" ; then
+            libs_softmmu="$gnutls_libs $libs_softmmu"
+            libs_tools="$gnutls_libs $libs_tools"
+            QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
+            pass="yes"
+        fi
+    fi
+    if test "$pass" = "no" && test "$gnutls" = "yes"; then
 	feature_not_found "gnutls" "Install gnutls devel >= 3.1.18"
     else
-        gnutls="no"
+        gnutls="$pass"
     fi
 fi
 
-- 
2.17.1


