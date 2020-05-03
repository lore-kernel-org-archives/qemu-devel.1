Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F00FC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199B1206A5
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xks75GZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199B1206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBZA-0006x1-BV
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBY1-00057L-4K
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:08:33 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:41430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBY0-0007iu-Fa
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:08:32 -0400
Received: by mail-pg1-x52e.google.com with SMTP id o18so1851804pgg.8
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Apq9sucfBmwOGXvj0V67gdzCLVL91nlJK5leKBoTGWw=;
 b=Xks75GZfQ0X6QBtjXLWiC70RvNKvpA7JjnKscIdVbrnnx6Yjrs4aV+D1ELgi9JfsIh
 M4nLVDw9slUZGMEL8mA9ym2MLviKXQVGK5xbme2G1ke+DVNspIX5ZCAX8bCb/dnPJpRO
 4ZLmcRjgJITfgV4d0XXPSFtLDrztQ8f8R/i9Rmgk8eVhcv9kMbc0FSG440Zqlw2WD2rn
 HKYqgfKLsLTotPkPbJJDsCRUOE6kqpUflXNH3SSWtJXoGw0A0j461pWMgBRIu+UKNm1P
 In0k8V8jvXwvnKMjo78NyStMzPZ6N+ERx/qKnGJx7xtpZn1jmS35pGAvvhiFoZWzpJXI
 oe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Apq9sucfBmwOGXvj0V67gdzCLVL91nlJK5leKBoTGWw=;
 b=LP/QSipbWhEk1xgLu8zHMBfJ/JnBuKay6nYj0245GnsSpYK6I5+2mlTeY6l3TSraGF
 R8ZY/eBa7SNG0DtyhPaRnBXC5Hiq4cA8zYBgqd98NHo/jsFmdMRxFBGF/aO0etW/Rgf0
 y8guQSY7OESnURSWMTC528n707efzF0iQt75nuAOJZEgUGZvlNaqWuR8qK3z6FO3XvOT
 BT5eUEBYib0COxBpWAoo+i618F2A8mrhfQTy59ER8DeTXZtVSFlFzoARLUoUUxvTnTKO
 7msZF0d4TDySJlgTKgv1Bemrl6w9sEHOTqbwm7DxkSy2mWLuMQQXT6RJkPWV7SauxFt/
 e3+g==
X-Gm-Message-State: AGi0PuYJTXlkOvk2bUg0vfpLF2zbhF6HxZNbuQM+D03+D3eOC9q6R7cW
 EN90P+0cBwaAAuel+6Amhco=
X-Google-Smtp-Source: APiQypI2CbwfAI9/oWf5WDwYq3eUe5P+QBD7gAlrAddN5Qjv2hJyYr/2z5tfeFRn4cKRK5JWcYOEbg==
X-Received: by 2002:a65:6417:: with SMTP id a23mr13042369pgv.204.1588500511198; 
 Sun, 03 May 2020 03:08:31 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.08.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:08:30 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 03/14] KVM: MIPS: Increase KVM_MAX_VCPUS and
 KVM_USER_MEM_SLOTS to 16
Date: Sun,  3 May 2020 18:05:56 +0800
Message-Id: <1588500367-1056-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=chenhuacai@gmail.com; helo=mail-pg1-x52e.google.com
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

Loongson-3 based machines can have as many as 16 CPUs, and so does
memory slots, so increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/kvm_host.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index caa2b936..a7758c0 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -78,8 +78,8 @@
 #define KVM_REG_MIPS_CP0_KSCRATCH6	MIPS_CP0_64(31, 7)
 
 
-#define KVM_MAX_VCPUS		8
-#define KVM_USER_MEM_SLOTS	8
+#define KVM_MAX_VCPUS		16
+#define KVM_USER_MEM_SLOTS	16
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS	0
 
-- 
2.7.0


