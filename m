Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BBC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B00720797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OArBqD0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B00720797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ53E-0007vE-Hb
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQ50r-0006g5-VZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:41:30 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQ50l-0002TZ-Im
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:41:26 -0400
Received: by mail-pf1-x444.google.com with SMTP id f19so925504pfj.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gC/v3JT/r1lly+MtSlE0m/I9VM9pxF+ogvQS5ITK4ig=;
 b=OArBqD0Y9lvTx6HjyxXxvCH9A5lEPJemjoe0FpwnaqW3CNUvg+U+sFhrNto1FPMh/K
 yL+UtpC3mPLO7aJtO34XJg5OK5Y3nMWcwxp5r0jWX2v15xQ+5KtYjLy5xn8D55wNU7Js
 jXsG3NaHCCEPsR5URH1C/8So79saDwHvVv6f6pKdkyBqY+O375e+I/InP1H2yNerbB8v
 FSJ+YwK09l5KhTwNEHXvkq/cWRu5fnEqCOUkNg6P5hwoqKa+dOFu7zi30q/HFS2V0Nm7
 PxkcGgvrmGw5xSzSS1Qh5t/UsAa5lY/T+wepNuNUhMlAq0SKErU/0vghkleJDjSxuoMH
 o5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gC/v3JT/r1lly+MtSlE0m/I9VM9pxF+ogvQS5ITK4ig=;
 b=cFtbvUS4nXiZxr+1VEy9lpsJV7fXiHrgDDqayFsJ5UyS9zabwlZXrVU0tYWQJTZzZy
 L2oyrgKe2wIfjviCBRXzL5r9C9be292QTqIVH/h2/Xx3z1XoUGxcceUArjSBjSOsWePI
 8B97bEaZEG9VkMzkB2M4kPJ3Wrzeul/2Y5HXwbJe+dOGlvaS+AaQKRpy9bjI35EMZmXj
 mWsLYNm0y2e3ygg6FFzOZL1ZcJngnLQCzihJfxv7QB387+xQqRMwVv3hNMx7gv4/5wI2
 mfHx12nr7VbNsfcnrgug7W0TBGfUj5Ce57jtTU+4Vxgk8fH1ITF7TLSk0nnrkcATI2fp
 p+sw==
X-Gm-Message-State: AOAM531Ug8dicVbsrDQ8xXjZPI/+WmYpFPzhQ82T4DQVktKrufJ3UdWZ
 UbcJkuWDV3rU6ayW1kB4MA0=
X-Google-Smtp-Source: ABdhPJwRFeYfc/SN/hCkul6vzr1NWDm4pxwQhVmldkja1HdgK36gzqtGdhIQheSWq5Hu5iuHclnDrg==
X-Received: by 2002:a65:5ace:: with SMTP id d14mr2079354pgt.323.1602060079655; 
 Wed, 07 Oct 2020 01:41:19 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id i9sm1999692pfq.53.2020.10.07.01.41.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:41:18 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V13 2/9] meson.build: Re-enable KVM support for MIPS
Date: Wed,  7 Oct 2020 16:39:28 +0800
Message-Id: <1602059975-10115-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x444.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, aolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After converting from configure to meson, KVM support is lost for MIPS,
so re-enable it in meson.build.

Fixes: fdb75aeff7c212e1afaaa3a43 ("configure: remove target configuration")
Fixes: 8a19980e3fc42239aae054bc9 ("configure: move accelerator logic to meson")
Cc: aolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 17c89c8..b407ff4 100644
--- a/meson.build
+++ b/meson.build
@@ -59,6 +59,8 @@ elif cpu == 's390x'
   kvm_targets = ['s390x-softmmu']
 elif cpu in ['ppc', 'ppc64']
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
+elif cpu in ['mips', 'mips64']
+  kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
 else
   kvm_targets = []
 endif
-- 
2.7.0


