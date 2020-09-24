Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB70BC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4632023741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek6qp9mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4632023741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLpP-0006p6-8T
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kLLoH-0005Za-Ql
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:36:57 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kLLoG-00010d-9G
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:36:57 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t7so1224650pjd.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4LZY9AT6Mymy8OX4vUPbotCOlkEO5KtdgcPTjzUYABc=;
 b=Ek6qp9mceIet51Zx4shE0d7G8CH+kX+WdEj/6oh5DMQBDLfHjN2dzq3U5SArCQ6IRo
 SwTCYJNf+xzmEvz0q/c0k5MdursbQXkBUsYQmCzl+TW480RXZMDwtz9JTGam92z2OJmn
 fswXOIM9VsXVYrSpznhemgkkzLGOc/l9F1rGSnbf9oAzwFAE0bPT7nrzoHY/Tu+tDtH9
 A0gbLY0euNRq5Jm7e87Inntc3yyVW9gG1CQaDBawUYzqdi6E7zoQxYQIHd9aqrabsyCL
 5nLj0unC5Vx5SciMhiviYKslpVI3p+e4N1Iw9iYbBEhAuYKXpqRE1FzYmIBtjQTfRxj5
 5BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4LZY9AT6Mymy8OX4vUPbotCOlkEO5KtdgcPTjzUYABc=;
 b=WsIIdt0vaFEWfS2MS2WJhg11qQi8qn+DUUc3r4hLSReDXvI+iUbLZJC3yOXThDVVzA
 MdhgCjy65gh8DPx8AyiRsHlUEEHVXESDFw7MPGyU9EG+jilkMD6d7MR6NetQV4p8WJWO
 sq3VTSJMAJyrLLmtRV0sfZXrdxxKJf6l7tgGuKULCt2uvqbXUo2KScc2BQGgczNWZ+QG
 SA6k5jrYRr+v2l+oPu+zUs28Q7AaZPjHwznj0HsjgPrFFDQ7wo4K5S1N/6a302AORln8
 MvvWonJJK4Jqz65pB1zKOi2dDmHpQEJ6mgEu7h7rnC5Vek2Jl/q+OASSHBxoT2rHX5Wf
 229g==
X-Gm-Message-State: AOAM5310f0TcCjsJZJBHi9fv5FHzP8EuxItLD9JdhFS2LQApjQa2FjVq
 CHQy/Nvfqzunb1ZN5/vMW0M=
X-Google-Smtp-Source: ABdhPJy4VD/+1zS2O/xqUyf8irtqSQlh2ErXRSxLv2+wApn74JE3zEVJAg+X4qIDbMkOdQ5Y9MKT0w==
X-Received: by 2002:a17:90a:ec06:: with SMTP id
 l6mr2893121pjy.66.1600933014928; 
 Thu, 24 Sep 2020 00:36:54 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id x13sm1777864pfj.199.2020.09.24.00.36.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Sep 2020 00:36:54 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V11 1/8] linux-headers: Update MIPS KVM type defintition
Date: Thu, 24 Sep 2020 15:35:49 +0800
Message-Id: <1600932956-11642-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600932956-11642-1-git-send-email-chenhc@lemote.com>
References: <1600932956-11642-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1041.google.com
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
index a28c366737..36a480fd77 100644
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
2.17.2


