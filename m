Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC133C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFFE20679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKM8Yzdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFFE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjnx-0007Yz-UW
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjms-00066p-0J
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmr-000559-8E
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id f5so11220662wmh.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jkTOq2PXmEwc1GxRKr+8vq1tSIfxuDyzzjRCTdzClcU=;
 b=eKM8Yzdu9FFGC8WYSLPmvD9/ddR+KkjdNCSYUWRHAgoqQ+Vm6+/sfZcj8BrsG1kO1E
 SxD1cKTOj4H7ryjkU2JyoCSsr96Y2JV3Bt0T1y1b6TVx7MerkBu1WbhSSLG72S+LyQik
 WLvi7SaKAaMCKrXlkD460nbp91HdOgd+ck89oezYH/LGtHnjpoasDKRTUbRhDCj6yFob
 GLQ/NxmRxpQN/l5eOA6lxAnB40aX2AKhA7XxqE5i21AhwbfpqfH2qFEh5+tjYa7Hj9U9
 tDzOmY/ZQFO+IQaY0PvTFwUVpsHnqATIT85zNydwDbjv369EXZZlK5+Too/NEoYA4uyg
 NrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jkTOq2PXmEwc1GxRKr+8vq1tSIfxuDyzzjRCTdzClcU=;
 b=iPSP7Cn+zrklbThwNyjB6BakYivi8gU/qFlRvDFjdLrZUdmkWxhMit55TktWwqKIDp
 P3zTcbaUxvS6q8FscWSu/AyfMZaviADJwDpUT1ICqrm0e6nJH1CGOUM3lrH95sSaJKd9
 JZHpe5ggKIjVq5DotN/kB31tdktfHeltCU1TfrqW8rtqKgnO0p8kW7bqRHebcfw5s3VY
 TwrqNWExfXl7RfsADv+Cb6jxUaLua7KZS9X8QwRktHsXyg5VIPOg1dqcExsR5/4NjVOB
 JTnDi40C5DYEFxWYCSIykXV1nWek4zj7WvQ8CipeMvArQ6AZ0QkE+VSwPT3xFNJjUYfq
 OMhA==
X-Gm-Message-State: AOAM530A8nKhYJuaQb1HaaMefRaO8vcDe+E+czlk3K/rFRjLsMKy8ubF
 H9QEMMpt+qhCBogosjcHCPcD/oikuk4=
X-Google-Smtp-Source: ABdhPJyp31wQS7iMbHzaBxuNBH6b65gtxM0nMCiVCgsiQs0gmhb0qpjgCdMMdYJQKnM0Pk70zQd9TQ==
X-Received: by 2002:a1c:7fc5:: with SMTP id a188mr22838975wmd.59.1591015407752; 
 Mon, 01 Jun 2020 05:43:27 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id n23sm10948474wmc.0.2020.06.01.05.43.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:43:27 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] configure: Add KVM target support for MIPS64
Date: Mon,  1 Jun 2020 14:43:21 +0200
Message-Id: <1591015405-19651-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Preparing for Loongson-3 virtualization, add KVM target support for
MIPS64 in configure script.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1588501221-1205-2-git-send-email-chenhc@lemote.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index af2ba83..f087d2b 100755
--- a/configure
+++ b/configure
@@ -198,7 +198,7 @@ supported_kvm_target() {
         arm:arm | aarch64:aarch64 | \
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
-        mips:mips | mipsel:mips | \
+        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
         ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
         s390x:s390x)
             return 0
-- 
2.7.4


