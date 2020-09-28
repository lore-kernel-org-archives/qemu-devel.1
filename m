Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37839C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E33204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT96BnQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E33204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMppe-0006w6-HI
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMpo4-00061A-HT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:50:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMpny-0006nY-7F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:50:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id u24so413802pgi.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UZo00x5e0PgCE56Mxc+bsaLI7WCxdZMfP8+4vb35TnY=;
 b=VT96BnQ25ZEaO67/P4hpxQIcMS8sr/4ZQWyu4nV2DFYU83SK/kSFvnM94mlzCVjWV5
 eTJ+o6XPXwaIHEs8WR8Rc3XtguWfMo+6kXL/O23O46XnMljoTwp8fbN967CAfxQx5AaQ
 59PmgQxgoVEtc7+rkttsS5Vq21DJRaSwG6sysFkA7p1uYGMGEyknhpjT/a4fSgLQMfRI
 eJLonKkDxlxNvs38ECqEDR4RuCW6cA7ttow5gF6DQgHgrxqq2ubHgXjyud768xThOF0z
 +lRJ3wjfGeEtw/ylk+uT0qG3wjwoGolbnJO7FgOmAU9TJldWq8tzJhiO9vjYdFdrNEVT
 ixPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UZo00x5e0PgCE56Mxc+bsaLI7WCxdZMfP8+4vb35TnY=;
 b=B6vRdao6pvPqEH7llRYSTkwZyqgf5FhJwmKoiw+uqDYnBs5COiUeW2v26ZfXXo7PJ4
 C8RqOp6NxJ0GL6nMkHwhOQgt1cBIcPtUW/WKr5VBZX1FMZL4KU6nHilVr39df9wkkupH
 7trmj4vZivDkm3remvb7Zc/f0KVhSNu4153ddOFV55tEorZ945h1Rk+o+gkm6QbcNVAl
 qGaWXfZv2gVb1sQ4an8rrURGv3CPhRerL3G6r97Ji4paJZ7/4VaOarQE1krPDU3hBh3H
 L/Y8sp+s1KAT22ZqA0hFJcgNPkCBaMi6DY5HVLKo+cZ/qAflyN59eStrueUL0NuNCzUg
 cVCg==
X-Gm-Message-State: AOAM5301XEHecaXvR1u31L4r70SknjmQmbEvOQQVf2E4AcwJk3UVu4ir
 Q1P2Q0RKPuNoR+OVo5gkEa4=
X-Google-Smtp-Source: ABdhPJyd9zM9vCbv1H9xPCfYLOsPSQ2+2zQH+VTXLrZTNcUIrxj6ufONXV0n2nR5C/dIMOiI0yTPGA==
X-Received: by 2002:aa7:8084:0:b029:13f:b82a:1725 with SMTP id
 v4-20020aa780840000b029013fb82a1725mr9548474pff.9.1601286644638; 
 Mon, 28 Sep 2020 02:50:44 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id j4sm865417pfj.143.2020.09.28.02.50.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 02:50:43 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V12 1/8] linux-headers: Update MIPS KVM type defintition
Date: Mon, 28 Sep 2020 17:49:39 +0800
Message-Id: <1601286586-1810-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
References: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update MIPS KVM type defintition from Linux 5.9-rc6.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 linux-headers/linux/kvm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a28c366..36a480f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -789,9 +789,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
-/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
-#define KVM_VM_MIPS_TE		0
+/* on MIPS, 0 indicates auto, 1 forces VZ ASE, 2 forces trap & emulate */
+#define KVM_VM_MIPS_AUTO	0
 #define KVM_VM_MIPS_VZ		1
+#define KVM_VM_MIPS_TE		2
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
-- 
2.7.0


