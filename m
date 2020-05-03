Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A67C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10898206A5
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpN/Pyh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10898206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBXy-0004a9-5j
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBX7-0003MR-8t
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:07:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBX6-0006m7-JU
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:07:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id t11so7091652pgg.2
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8nxdgRcKM19fcM+rPWLhG14M7DWM4NBsZlKsa3VM4rQ=;
 b=ZpN/Pyh8jgDlcVAP+Zm995766QQ2OE8dLcS8OyvRqHICwXLezx8Stp7yWixH/5YmYh
 S//AlCI/eUoyNkcOQr8d1MPl7J+chdUCwOP3av5QEcWQ7H/meb+6ZWu9Re+PaaRZeNIR
 bQUMErOg1GRiV2AE7LpRm4BvBnjfXDOx5pWujyKpRtu/Z9UE91KkOHuCLxhwuGfn45vy
 2bFMzMFxoPMTFqKLeYis+V+YIsUYUb2LJor9tqau+kzVy8BBcdvtxLhdHMcDxY5/42kg
 oBENAMxrZM6orPq7RCF6jOgieNkatuN3+N4lkbKAXt0q2mTYfnliq5czkFMK2xp1H/Bu
 eD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8nxdgRcKM19fcM+rPWLhG14M7DWM4NBsZlKsa3VM4rQ=;
 b=TgRVIg2dvadBY9ECORSoDYdiUNhvdmyeFZhkmj7h5nH7dsQ00GwUcIjUAXZ7a3EdSv
 QK7j6sH+XSnsHJ3kPRZWrQyUZxhJ60gSIAalCMuPoDXDGWl2A+q7pqe8e7Olw4kE64VJ
 3dJMVcMmOtmM0ZJqYX/siOo4+zkC4r9rZPX2VoKQqWJ0Yg0q094ALZPKDGbvDf0B4zql
 jmbSrMGKK7PYzEP7Wb97VGDTP+vLnAXMOr5t5BTPaggn3Ay6GxBcj/uOms8cVypEqy7m
 1f5JYGDWp0S9cGgVaWBzWIRXxXcfJFOBsLt6WWar4ajMYtAQv7fBV7uQKdZTmlBCFnTi
 4l2g==
X-Gm-Message-State: AGi0PuZPHVS4kWHeDplCpw1UQhl5ujxwWyHsAob8TD/nR6fyXdKu9mh4
 YIyz38sZIvdWo9h4ga5jAgo=
X-Google-Smtp-Source: APiQypIzotBeRon7oxlBO4yIrbf8EUAWEp+oSCqBmePTdSGLwWv/6/lE4N2UbFE6dpM7IvDijapmuw==
X-Received: by 2002:a62:808d:: with SMTP id j135mr11757046pfd.53.1588500454894; 
 Sun, 03 May 2020 03:07:34 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.07.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:07:34 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 02/14] KVM: MIPS: Fix VPN2_MASK definition for variable
 cpu_vmbits
Date: Sun,  3 May 2020 18:05:55 +0800
Message-Id: <1588500367-1056-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=chenhuacai@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, stable@vger.kernel.org,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org, Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xing Li <lixing@loongson.cn>

If a CPU support more than 32bit vmbits (which is true for 64bit CPUs),
VPN2_MASK set to fixed 0xffffe000 will lead to a wrong EntryHi in some
functions such as _kvm_mips_host_tlb_inv().

The cpu_vmbits definition of 32bit CPU in cpu-features.h is 31, so we
still use the old definition.

Cc: stable@vger.kernel.org
Signed-off-by: Xing Li <lixing@loongson.cn>
[Huacai: Improve commit messages]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/kvm_host.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a01cee9..caa2b936 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -274,7 +274,11 @@ enum emulation_result {
 #define MIPS3_PG_SHIFT		6
 #define MIPS3_PG_FRAME		0x3fffffc0
 
+#if defined(CONFIG_64BIT)
+#define VPN2_MASK		GENMASK(cpu_vmbits - 1, 13)
+#else
 #define VPN2_MASK		0xffffe000
+#endif
 #define KVM_ENTRYHI_ASID	cpu_asid_mask(&boot_cpu_data)
 #define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_G)
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
-- 
2.7.0


