Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA30C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC490206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt9EsJjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC490206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfwsH-0000WQ-09
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 22:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwrZ-00088s-Do
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:41:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwrW-00065u-S5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:41:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id n9so742200plk.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 19:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=soFLUgc7s8ufP5GpQjZZS52HTsQjlqodCA9Yt2Ak578=;
 b=tt9EsJjfu4e+I2ROCwer2lLItBVLAy5qgeiGmS3dRgBYaiM0goAwO0yTlt9KN5RrW7
 //bSG1Z/KcnbX7oYncwRJrMQZyGjFGHOtDG6dYaRgMnxTEBjiv88d+gHiaZskKC+TZ3P
 tjd//3a3v7OsW386E+oth83xmS2cfevuQHcr5fc4AceElZWLeabzYuk61VOoiskveVwL
 Kq0WHUYTQaMBCu1DbsLpa9ez6NAVYwpMrL9PlJ2FggwTaB1w6A+2Y7+QeK/UhdZ2xV3g
 fpGkG8akPD52LRak46VcMYlBROa9E6NvfhVeLSWTicAvQK+4Q54YRT1vpFXYA0hTg9a/
 P7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=soFLUgc7s8ufP5GpQjZZS52HTsQjlqodCA9Yt2Ak578=;
 b=ZKpTs8bVqdZCYdUAuRlqdaLdv7lbLeDHkD20Rzdmyx4kOMNLQtPjxjdO9zQKhZ1fWZ
 rG3/khNUD3dgzia6LI72xRUqTp3TdOpP3CDbD1qrqmdtwcs6O9xunNnA+o624MWnjcd0
 IhKeB+WcxJdbno0I9Bz0N5uYAu5FxGZkQgfzNMBTxQWMLjctAR/jH/FI55vcecy8tNzv
 ym1Cdew6Lv0ZCjuJRQ2aq6iDdl2hIn420GMaqWpbWKl3dIsG29GYA+XWj2liN6RKX+Tb
 BTsKNYVajT5Y9TM/arTOe6l1nmru9e7mSJZjl3/d8ljIj9r9CFLHPMzxJLj12WOrY6S6
 QMPg==
X-Gm-Message-State: AOAM532avx8hRoewWP7XTH0xEiPTVefro22SNdGmmubCL1TbIRW3stxu
 mWxVM6UFp6mcyWNb8Ot4coc=
X-Google-Smtp-Source: ABdhPJzQGMX8ZrdnyTp8wlJb30Oc/8zPEthcwk2WL8YGVHfLgi/dXqDfbgSr5js5Jt74NzjvCZt5JQ==
X-Received: by 2002:a17:90a:248a:: with SMTP id
 i10mr2961900pje.174.1591065669652; 
 Mon, 01 Jun 2020 19:41:09 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id j186sm630761pfb.220.2020.06.01.19.41.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 19:41:09 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V4 4/4] MAINTAINERS: Add myself as Loongson-3
 maintainer
Date: Tue,  2 Jun 2020 10:39:17 +0800
Message-Id: <1591065557-9174-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x641.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0944d9c..c42a218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1092,6 +1092,11 @@ F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
+Loongson-3
+M: Huacai Chen <chenhc@lemote.com>
+S: Maintained
+F: hw/mips/mips_loongson3.c
+
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-- 
2.7.0


