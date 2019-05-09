Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F5C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE0920675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrDHAzPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE0920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcDP-0001pe-R4
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:07:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc90-00060E-P0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8z-00076C-TX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:02 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8z-00075e-O6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id bi2so569437plb.13
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=LalWeSz9ng8LqvlpCLkBR/VeSiQbsSOHCzC5F7gQNl0=;
	b=mrDHAzPDpq/tACi3a/mKPm1H2VHzt9ENozJkeOpEyK8BW8XnVI9Eg1C5wJo0noDkhp
	Z8J8BJSI4e9yUJ8x5Sm97GM2XznfXGZEwhNikGi86fAmawegO92wilF7YXKuSRCiqPEd
	jc8dR7WengPlr+TITuovCi/kvN/aQmlzlkFXsGg4Ux3FSm8icd0T6DCAHpzq/pf45Hpo
	XTk7SOl1CCwJuNHfNYtyCTAZJwJlVW2Kw/xAvZB5TiW01OliSkJlG2N6pkuFRCZIi7C2
	JFoXDgeZ9bY155QQTZutmdWVj6neTyn43ZA9TNMa1ujdSJTZF1KMDImIQ/JBfW03goOL
	MlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=LalWeSz9ng8LqvlpCLkBR/VeSiQbsSOHCzC5F7gQNl0=;
	b=DI2R534zD9ZjrqBgYNNNmtJuDihvNxltkZAicl+4C6p3Wd+JEYyV6RJpMeFFzmezAF
	H6z5qPl9fwlWVwZzFMh3RfRXH0V3UdX6RTe6LQ5Adkm/74Os7Ar/nKRX9jlTze2MrWBA
	tLDwQ19VF4T1M110ED2aqgDAq1dZthwVVerMtmlwjTbxbqyrHYP2ZUMOItWenDw3M3TO
	3airahqgP6i/pINeEluSdIKgNjHKHEsdqckW22J+p1rpuTPXXsgFzSDOX0Dbam+FXPPk
	B+z2gtny120+XMT9YxKgM3QcWUJHVAt6+hh+jdJe4uutDIFOy8KMz0QZi9LWnuk4fAkE
	usOg==
X-Gm-Message-State: APjAAAXucc+RTSsAXVV25gTKbP8TL9siGl+Lko3g4NLsPbHdHA0fIT4o
	yuSX4fOx+rni5XBmJr0WOdHb683n05E=
X-Google-Smtp-Source: APXvYqyqYfjk5U78oNv+A59db0EPCcMmhv3jaYAefvZq6KKTMGbQOTOCkc1kVp8oW6697P6kp8Rv0w==
X-Received: by 2002:a17:902:e00a:: with SMTP id
	ca10mr2838928plb.18.1557381780456; 
	Wed, 08 May 2019 23:03:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:29 -0700
Message-Id: <20190509060246.4031-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 10/27] target/mips: Pass a valid error to
 raise_mmu_exception for user-only
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

At present we give ret = 0, or TLBRET_MATCH.  This gets matched
by the default case, which falls through to TLBRET_BADADDR.
However, it makes more sense to use a proper value.  All of the
tlb-related exceptions are handled identically in cpu_loop.c,
so TLBRET_BADADDR is as good as any other.  Retain it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index c44cdca3b5..cc7be7703a 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -884,7 +884,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     int prot;
     int access_type;
 #endif
-    int ret = 0;
+    int ret = TLBRET_BADADDR;
 
 #if 0
     log_cpu_state(cs, 0);
-- 
2.17.1


