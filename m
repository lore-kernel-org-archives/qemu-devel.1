Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B2C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCCE2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2KjR7sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCCE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzKz-0000FY-Hf
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 15:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5K-0007GI-LZ
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5J-0007WE-OA
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz5J-0007QN-JI
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so37607491pff.9
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1OFhZYB7REGpAAmdzyA7otQ/hGEth32oUJ6nOIibRSY=;
 b=Q2KjR7szqQzFJBEH2NX0Shzd0whUpZj611QA5mIAYhzgpKlRBh5ODsGM5FpzlG4XYN
 E60p6k7knFLoG/3l6e6jb7NjxMSe0Uv8+wqgGre6LtOAO8f9GbaDAC+QVVD/ZN5iyITN
 lGdwQcy388XZhoO0jJnjvMrs8PgL8MKY8f2zAiABXU4jRRFArYBaW2DC9HbECCXS3boA
 MVFaJlKA0Jjiem7h2Fc2fVhhL4udB+lpnGcgR8fnzJZy8uhg7VgTozjHaTNGGsA68nb+
 pNMQWGe5juX6arF/6MAQUZs+Ue9hikLMS6b4/+dUo5QLrj218JfX5gH9w7La9BbmqPbo
 yNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1OFhZYB7REGpAAmdzyA7otQ/hGEth32oUJ6nOIibRSY=;
 b=PiA56Qe461Ikjgo524YDH1tBp04+AV3VRRgNXiGQvkN7Yi5N6SeyQ2fUje4QgvDXRt
 uOMj9niWmdtcyy9v0T489aBsjEo5HQPX2dR449GR97yt0MF05PbqyrUik0KVGxVGzKfw
 EYUAWR2YkTCMOCehSHN6Xu3+4G8pYyXIcuF9lY44tC7occMjSfKZiMLEgIHWvxlwVvCp
 d3WC4AYge3u5p99XoIGTsY0+BnOWnYlXALLD4aekRpkDBgKsIBNBXa5uJ4DjiAV57CKP
 7vEOu+rl5I7gc/vEJqvr6XzjdsHmruap9M8bzXSkLLd4o1gVAGB8QjUwf4R9uAu/Yh6T
 eQBQ==
X-Gm-Message-State: APjAAAVEJHwRwsdPHVwFIIpIEUcLirj1kS1kpm2LIXQQ+R0hIeeL88aM
 a8i7F+w43qWGAi77C507n73S396lM+4=
X-Google-Smtp-Source: APXvYqwcpUfQm+lN0lAiyTvKZ+LKiZdqq8LkPAnYLxLczAXe8PepUtoBWVyUkepumSba4RRwsKQ6zg==
X-Received: by 2002:a62:ac11:: with SMTP id v17mr65823645pfe.236.1564858121535; 
 Sat, 03 Aug 2019 11:48:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:59 -0700
Message-Id: <20190803184800.8221-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 33/34] target/arm: check TGE and E2H flags
 for EL0 pauth traps
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from EL0
when TCG or E2H are 0.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 42c9141bb7..9fa002068e 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -371,7 +371,9 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
     if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         bool trap = !(hcr & HCR_API);
-        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        if (el < 1) {
+            trap &= !(hcr & HCR_TGE) | !(hcr & HCR_E2H);
+        }
         /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
         if (trap) {
             pauth_trap(env, 2, ra);
-- 
2.17.1


