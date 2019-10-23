Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50773CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197D820679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBY+uoi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197D820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIrY-0005ma-Id
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8u-00089H-AU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001Fi-Cf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:43 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-00019G-5g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qk1-x742.google.com with SMTP id u184so20055030qkd.4
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iym+ywFHjEBpwuu12wdHsU0gouX4jDUf3/+DDNH9pyk=;
 b=JBY+uoi/+fsxKtaVdEUfo1r3jJJ5rjOraTo2FNLPBuEm++0n3Useh7V3OBM7lNWtVl
 BwFFrYx2/65n8V4wsrimWFSkDg9Rx0yhIz1U7FMqv10Faud1dPXihm+aY02nZEUx0li7
 YLYjtbsHzXvhKxikF+MJnDRIz888rOYaPOaAgFn+afBbHBEtzY+hORHnaIT/IeXFuE9Q
 WYVHfnlckqHzjRAJ948RWqES6iMm5PEUob0LAYQukgTP8flk3E1bZPMTquIaSSWBQb5+
 p2JZStIJfYpkIaR39moIqnwOQO0Ve9CJUuLvdN0p5Et8aCCFiixR0g21GcXhIveVA3EP
 3VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iym+ywFHjEBpwuu12wdHsU0gouX4jDUf3/+DDNH9pyk=;
 b=fDfArEoMbuOpMPHO3yZ1LmciQC7OcA/gIALOEnzOnnzHHymCPEZLGD5/uT4OLfZJ0z
 MB7HNMACr3QGtxb1/PYBXsH1fBRG1CaQedLZ2sBhn2se7Y7055+CzJG6OBLHvpk2QCjo
 NBtjcA5om8aYiuL9P8kFbnJDQxNqcdjgW4RSRU36Qib72BJM7JxE41aGNuhdkHZ5hwkK
 siyrQ9+MzNdIu8GoheE525EtuA0ovHfe4B7zkj/oOelJVUaoxxVi/Z90Jk7W4JZ2/rAh
 PxLv3k3OWhpxBUFTTIdlf7Edys5L77AqJ76u0YzlkLTEMkBcHWbA5Jkrqa/LFPMj1rbY
 zCVA==
X-Gm-Message-State: APjAAAWFCZT7JN4mrGB1nF2dQLSSyAUp6YIioDMVaIODhzR8u0pO7Epo
 LILovL4nIiw1jY54a5PuQPNBBX5P+W8=
X-Google-Smtp-Source: APXvYqwVLYygu3aZa5y8PikWE9QpbG4d78hexpVHPahE5sDQBPTYv8jX5EFgGDYbZBpcJoLPsBSoPg==
X-Received: by 2002:a05:620a:20d2:: with SMTP id
 f18mr8909266qka.474.1571842886526; 
 Wed, 23 Oct 2019 08:01:26 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 18/24] target/arm: Rebuild hflags at CPSR writes
Date: Wed, 23 Oct 2019 11:00:51 -0400
Message-Id: <20191023150057.25731-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ccc2cecb46..b529d6c1bf 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -224,6 +224,7 @@ uint32_t HELPER(usat16)(CPUARMState *env, uint32_t x, uint32_t shift)
 void HELPER(setend)(CPUARMState *env)
 {
     env->uncached_cpsr ^= CPSR_E;
+    arm_rebuild_hflags(env);
 }
 
 /* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
@@ -387,6 +388,8 @@ uint32_t HELPER(cpsr_read)(CPUARMState *env)
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     cpsr_write(env, val, mask, CPSRWriteByInstr);
+    /* TODO: Not all cpsr bits are relevant to hflags.  */
+    arm_rebuild_hflags(env);
 }
 
 /* Write the CPSR for a 32-bit exception return */
-- 
2.17.1


