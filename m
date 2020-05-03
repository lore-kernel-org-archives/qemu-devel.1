Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C5C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E869B206A5
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYszNZZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E869B206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBd9-0004Eq-4s
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBcJ-0002bq-6g
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:12:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBcI-0001of-IX
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:12:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id l20so7080449pgb.11
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1g+QKsylunTzCpyzZnzy9jIrZoy724tgHbkXEIPo/IQ=;
 b=VYszNZZ/FEQevLFks5IkRGKPtWwALxnnbwjxgJQAB0H4oF86VgIMysU87+uOJf/C0h
 0/qsTZo4VhNmNXT4Edehgs/IPxCyoR+kRdh2dJ0pQaPL7hFKIowsemETOM0GA6DrMWQh
 dPvMHwYqaj2zXOMjAiwzyTvzuT94gRXeqUPpGRjI081L80daOQUz8/seDbqfG17ZudYx
 tjVBxuz/BvKNlqDkFrEF01oVqnX41HyeAElmb/J5BFq9Wq41XZIeCMtauGXXOA/xiOYC
 UwSy0KNQ8qRHzBGO5Z2EK+Kww9axNZVtEQSyYxzdGWspuOSp64XzFtcWX+VxQQ+GCZ76
 inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=1g+QKsylunTzCpyzZnzy9jIrZoy724tgHbkXEIPo/IQ=;
 b=CprbzxHIw4zcXQ420S0vHWq+I/TjAOE3sv463TjH/ijFM+d3dkaiFY20fvuAZ6q+Fp
 h32rhE6iCsg+THyluv4b3BpDHg2GquLQ/ahpiJ9Ji62TBXMDzHsknGK14URQN2ddTYp8
 nVLIIDXQ9Xvo/zn1LukJ+bi9dGMQrXGDStBZBvIKPsBzGQMSxlmtbhrJ6wTJA8GmztzZ
 IHmtWZYFa5ZEBfTeYGdeLyJtePx7KJKY7DtoFNOLBHXBnwUYNZtaKH2WxeABOHsj8hJr
 thyfJme3t4tbnX28BSCEICWhHJsZKKQq7QBA7/8aPY4yh/YT8AVo0ntCy1pzeSc1HssV
 heEA==
X-Gm-Message-State: AGi0Pua41sDZzwiL3f7bFUppgkjFOYux0gFJ80PRf+t2S3Q10aIws3Aa
 H76W2RKMAyw7hL3kfClXH4M=
X-Google-Smtp-Source: APiQypKAitL7UnUt0qbGyf3ym/haLf6qtFe8doUu95dV0GzP2+bKpAL/SmkVdnWiePIQT/0HogRKBg==
X-Received: by 2002:a62:5289:: with SMTP id
 g131mr13034730pfb.318.1588500777201; 
 Sun, 03 May 2020 03:12:57 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.12.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:12:56 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 07/14] KVM: MIPS: Use root tlb to control guest's CCA for
 Loongson-3
Date: Sun,  3 May 2020 18:06:00 +0800
Message-Id: <1588500367-1056-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chenhuacai@gmail.com; helo=mail-pg1-x544.google.com
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM guest has two levels of address translation: guest tlb translates
GVA to GPA, and root tlb translates GPA to HPA. By default guest's CCA
is controlled by guest tlb, but Loongson-3 maintains all cache coherency
by hardware (including multi-core coherency and I/O DMA coherency) so it
prefers all guest mappings be cacheable mappings. Thus, we use root tlb
to control guest's CCA for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/vz.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 422cd06..f9fbbc16 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2871,6 +2871,12 @@ static int kvm_vz_hardware_enable(void)
 	if (cpu_has_guestctl2)
 		clear_c0_guestctl2(0x3f << 10);
 
+#ifdef CONFIG_CPU_LOONGSON64
+	/* Control guest CCA attribute */
+	if (cpu_has_csr())
+		csr_writel(csr_readl(0xffffffec) | 0x1, 0xffffffec);
+#endif
+
 	return 0;
 }
 
-- 
2.7.0


