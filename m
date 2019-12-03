Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7535C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3832206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWY8UutO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3832206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyUX-0002uf-PC
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 22:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxL-0003Ox-NU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxJ-0000CT-Rw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxH-00009T-PR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:24 -0500
Received: by mail-pj1-x1043.google.com with SMTP id n96so827406pjc.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xGOB5EQSs+V4ihLVGdiYuoWjXTTUG1ZoRZwPeuW4pjQ=;
 b=yWY8UutOM1aWN3UdwO8zmSuevfvz90bKyIvRBwd3shDuVuWKfjCH2V0HzTxsVjUSM8
 3cgLtg2yMmrn/RoQUelFUOeKgnADU5662U7JK00wf9Ta1ayanpGkpOEK+c6a2xjBb5xA
 vUBzgBl2RPPkBM1gbDD+dTpi2tm8ZPurkiawJB9V5K+7D9pQ5/gTIn/F3ZECby+C6mgN
 NUgzrrFUc9iURDGOVKYqMbyWaGrW92Kg8/8YVB+Qt/mjVF3Mkl2+tJf+AeHCXAaFq8jQ
 OgD44PIb2G6ebwWfrWdm/XyJRTYQ0yaIdbuwzlrqGeufjxwFKTD7ppvfJlFcy+2JvpJb
 OV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xGOB5EQSs+V4ihLVGdiYuoWjXTTUG1ZoRZwPeuW4pjQ=;
 b=koDpkUcTXFTEy0zkMJsZiS6y3eExhDU6YdJ+5D039KbFMhYrWOpATID1UsKARVk0sD
 q1lcia42tyNvA5RdGRcb3/XL7BikDKGXT9v0euJWhpTGC45OLVWUgBpFUtDjhvdicJoF
 UsxuiGexijnGuD+oVvVYaysx+v554oxzmmLDtnqwnKi8d+fEUss8Z8ni3Nrtjq+chTXd
 pDkx6rcF7QIj8AIdtdqo1Lu70cOqeRh4av1kz+X1R8lwRhmjc9qAfnakbRwATuoL/4Bp
 XtqNUA1cbyCsDbsF7yXkAoauLuzzKIGmm9wHZrNtY45eVJ6Q3FFDOQrsIYveojPzS+UM
 Pmrg==
X-Gm-Message-State: APjAAAXns7g6GzBXYUjGqPlEYLBjztLx+ny8gmSgQoNcehOqGDNhtCiz
 jCHcLYuok2opQmRrscq4VeqSzg1wm30=
X-Google-Smtp-Source: APXvYqzjRnTMEQQPxOnOWcId9GNa20E/wvrg4sePmR50nyWqgGKkUZIatCUPJVIZZ8IOJX3VJ1w24g==
X-Received: by 2002:a17:902:8508:: with SMTP id
 bj8mr2625098plb.178.1575340221229; 
 Mon, 02 Dec 2019 18:30:21 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 33/40] target/arm: check TGE and E2H flags for EL0 pauth
 traps
Date: Mon,  2 Dec 2019 18:29:30 -0800
Message-Id: <20191203022937.1474-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from the EL1&0 regime.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 42c9141bb7..c3cb7c8d52 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -371,7 +371,10 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
     if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         bool trap = !(hcr & HCR_API);
-        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        if (el == 0) {
+            /* Trap only applies to EL1&0 regime.  */
+            trap &= (hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE);
+        }
         /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
         if (trap) {
             pauth_trap(env, 2, ra);
-- 
2.17.1


