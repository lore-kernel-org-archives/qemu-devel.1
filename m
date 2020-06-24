Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DDC2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIGa3aOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DDC2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2vc-0003ei-8i
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jo2uX-000272-Fv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:45:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jo2uV-000828-Ns
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:45:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id a127so981720pfa.12
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dYpAwmxzkvZdFtH5PUKaA7YkdGli1btcQ6lQGV7cfYc=;
 b=WIGa3aOOZiLkHusDt2uNN/83Uw5DP8nrotPeAIxvUUL4XTzFtURyzb3wQc8ss59kFZ
 oVdCLr8/Ut72AU9h7uutAznTDOjkfxLTDCD2urt2z/RVGAskTa8CNS6eNwJjPwUHwcSH
 YDX4zcQ4anEK2CDIPcYemrzYdgd+4zbVeFEZszT9gSi1wEodrnPYsXCBOYCm41wz5t6b
 rIGgo6ojWk2r5Jh+tPiEkew0e0e2DpK39T9FHalpU4eDxIDRtSd4cijxPvBrsVIIjM6u
 qS8DaN/U5fYlStApGJARZl2fwDJJDllxzaL02Q5LFrTyMNOvb1tBgHnfhvWZgBhlQtNY
 mtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dYpAwmxzkvZdFtH5PUKaA7YkdGli1btcQ6lQGV7cfYc=;
 b=P8b/rdKQq/PXGMOUt1Pj05W0791FZjcjagqWX8uyS00Os3CVjEUejTd/9MLzjaP8wZ
 /Qoxj+7ef/4vTSOftVcxP45L/JQCzyi7H0ldo6fIHJt4Vct/38ngAOn6Z696uDDD57lj
 WUleTFp2LVktlX+4f5Ck0ouCG1nj4/WQHeyk/vUjV/xJcM0zj/tlw36Xup2pbMW5X/5w
 9yhrhawBbf0o8AlncW3JI3O4S4rMHtPkXPmiCHXtFd1ZMlx0EMOJRMHn+j5jJvF8CHZy
 GQGM/w59bTAG35F4lmuXwHQSnile8qi78O9UC1DGXkE0ggJYqFnDsV8cvEqdGHW8d9Ch
 ad0A==
X-Gm-Message-State: AOAM533nfP+3bT0QcnHQvBvMpK8QwsJ4CqcR/GYk8FnaMZzi5M7vSGcg
 NSTB7nFBivr66I6tKEEQOyE=
X-Google-Smtp-Source: ABdhPJyJ5X4MWdwZotpWV7yRIyNXrXDsdgSg4l5pbZXm3y6d3QuiRmRx7rHSbS0ShHiiqjfnkDehzw==
X-Received: by 2002:aa7:96d7:: with SMTP id h23mr30170934pfq.320.1592995542010; 
 Wed, 24 Jun 2020 03:45:42 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id q6sm19772395pff.163.2020.06.24.03.45.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 03:45:41 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V6 4/4] MAINTAINERS: Add Loongson-3 maintainer and reviewer
Date: Wed, 24 Jun 2020 18:45:31 +0800
Message-Id: <1592995531-32600-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add myself as a maintainer of Loongson-3 virtual platform, and also add
Jiaxun Yang as a reviewer.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51a4570..0226a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1095,6 +1095,13 @@ F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
+Loongson-3 Virtual Platform
+M: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
+S: Maintained
+F: hw/mips/loongson3_virt.c
+F: hw/intc/loongson_liointc.c
+
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-- 
2.7.0


