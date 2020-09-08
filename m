Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C00C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218D221D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkAbbSsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218D221D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYly-0007L4-VH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYl9-0005ZS-0R
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:47 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:33595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYl7-0000QX-1i
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:46 -0400
Received: by mail-pg1-x531.google.com with SMTP id e33so9525557pgm.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+orWxGBa1SRb2nSQN/q2qViaNIRmFc8NrraWTotMcp4=;
 b=xkAbbSsMHL13QIEKseh5FvDJpbVn1+R2Sg1fgccSIWpkC58PzKCqMkM1NBtdSnWE++
 ipaKwJSL2vLp8dsX0n3pvml9YkcnEGputtAoaK/8rCSraQu60jc3FzpHS2eNrrT1sMXi
 FPMwomj4AQ6HKJQl9fd+eEg6m0sicxxuAHVG3+Qlfgnc0q/ss013jz7NS0cgpCPqn7sk
 jnlYhdfAwcoSB8ttZ9HaALVK1We1M95q5+JG5JpNWtQJF/I12lsT6TmkLimIMEfupF8n
 qj0QCkTy/H/dnaY09xmSvUu+9b0JR1BH8mfAH+hzZ4uXK5AkRwn2PpjMyAineTKNNh5U
 8H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+orWxGBa1SRb2nSQN/q2qViaNIRmFc8NrraWTotMcp4=;
 b=b5OOB2ggt6PFXYIHWq31TXUZgamSzytj8W8Twr/BBNHwABsb10ElMC0LPfstVhyZIg
 XgMYiu1NqUJEhae9EMn3C7FZGERBtpUDg81KfI7k7TM9cFuenl7/VE7x0fu6w0qX6pqo
 1lQnzvMZLVsgWVZvCapl/R/jFRQXSxZwb23abSDayM3i3PlexBlkjmS3a3IXcTLsa0xw
 PZUcmNuXkxLgfeEvPD0eLqYc6DHxV55ZlGZ2y4TVlYy1jl1XRrR9nIegqo8ER3PAF41X
 FdtGzKE1xkg4duqQvBSQkn06ImNmZ7wQfSoECc+S/sTZNexqTp4HPlLbPX0woqGEXiod
 soSw==
X-Gm-Message-State: AOAM5332vLMtxR8zAxzkg00P2J+5kgXXDgzaQ5Dvxshyaq2jCOkxiPXW
 mWCZeKZCuijYLa6UIfqoMTCv
X-Google-Smtp-Source: ABdhPJy29qU280DDR0dckE2cglije4N2FSPCY8YwHmYTKGvt5mOwGEtHUFVV6sFkDNnPWofYqbIYDg==
X-Received: by 2002:aa7:9aef:: with SMTP id y15mr2846154pfp.119.1599552823600; 
 Tue, 08 Sep 2020 01:13:43 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:43 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 01/12] update Linux headers with new vSPE macros
Date: Tue,  8 Sep 2020 08:13:19 +0000
Message-Id: <ca77b62934a54aeece900d4a0964a0da78ddf16d.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 linux-headers/asm-arm64/kvm.h | 4 ++++
 linux-headers/linux/kvm.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 9e34f0f875..802319ee02 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -106,6 +106,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
 #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
+#define KVM_ARM_VCPU_SPE_V1		7 /* Support guest SPEv1 */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -334,6 +335,9 @@ struct kvm_vcpu_events {
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
+#define KVM_ARM_VCPU_SPE_V1_CTRL	3
+#define   KVM_ARM_VCPU_SPE_V1_IRQ	0
+#define   KVM_ARM_VCPU_SPE_V1_INIT	1
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a28c366737..8840cbb01c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1031,6 +1031,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SECURE_GUEST 181
 #define KVM_CAP_HALT_POLL 182
 #define KVM_CAP_ASYNC_PF_INT 183
+#define KVM_CAP_ARM_SPE_V1 184
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.1


