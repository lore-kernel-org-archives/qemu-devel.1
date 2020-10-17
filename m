Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2E020704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG4eVTOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2E020704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmyh-0000Bf-Nb
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqO-0005AI-N5
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqN-000481-6w
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id j7so2490165wrt.9
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R9s97XnziS84CJxznkT3kO4RYyRvIgTfNhbxkGtnHzo=;
 b=hG4eVTOk6zCSy18itUnW6ZxoR+0pESltx329gRiPl46Lcw7JCaC6Un2mW08yfvptZ/
 XkBwYkHzggsj6hWAsNzQreCJW9XUQCEbcUu6quxdKm9NAdvzN645J+j/ZrCRG0BSwENo
 FPKmIv61NXdZQ3VSqjEl/lr40VHOmvUr998cqTjZ5MThJyoYEAPvEvVcnlG/xawXTkfP
 wUZlSOeEFM2XCgQfXuW4vu/iTlcE/TARubHOY92xeibjCEogB+9epT66QH4rLKNwwcSq
 P1EhG/fRtN1iF4qtr4pnubLFxJj1wGU96krIrJG6CrYMl4FztLWMAvnIgt9WRG7+v+HF
 Sbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=R9s97XnziS84CJxznkT3kO4RYyRvIgTfNhbxkGtnHzo=;
 b=GiEX1GveKvRFw3mkjvVls1rxlTYxGs4o4tRgWXzzl28WmhDyWUudCvq9ZjAmMx3yfB
 tBlrEwXmrFSwmH0awMsZ54y0HT5+Rp2Mt9LRwm7wA0cbfkTbDChJJaT43PCIU2U4scxP
 PFY9k36ikp14dWSwLFUC47QL6rgXHFRYVRUEjBmr2diCVPe/v4MeNSnhsS9tZtZKSFVX
 a4oVHjklP44Vv4jvEvwPvzxCunJzw0XeUqcv/rtRqKBkZjoLVeiWKWJ2Xdk5JSbuO228
 zPBnoWECOLJnvCsWMIn1HxrlScKYF+XMTHcasVJjhk7acv5cjk+KPy9K9kE/THw3Xgx3
 MjfA==
X-Gm-Message-State: AOAM530dvGB9v5VyZCRwocqTc5j/KMNxFAr3XtxHAkubMkJlH4G8s7Pq
 hG6V3zvec6Zs7o261FMvnrbOJLuo+w8=
X-Google-Smtp-Source: ABdhPJz2rhwkZtWTcrx1wuwnvRrMbVqU9sV+wM14dQmGQLencTRZKYVhefo8rWyE0T78eDVCuUtSog==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr10265454wrn.102.1602943557355; 
 Sat, 17 Oct 2020 07:05:57 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id m1sm7386347wmm.34.2020.10.17.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/44] MAINTAINERS: Put myself forward for MIPS target
Date: Sat, 17 Oct 2020 16:02:40 +0200
Message-Id: <20201017140243.1078718-42-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid the MIPS target being orphan, volunteer to keep an eye
on it and put together pull requests.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201013101659.3557154-2-f4bug@amsat.org>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b91bd754d16..50fb9fda34d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -220,10 +220,11 @@ F: hw/microblaze/
 F: disas/microblaze.c
 
 MIPS TCG CPUs
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Odd Fixes
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
@@ -2817,11 +2818,12 @@ F: tcg/i386/
 F: disas/i386.c
 
 MIPS TCG target
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Huacai Chen <chenhc@lemote.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Odd Fixes
 F: tcg/mips/
 
 PPC TCG target
-- 
2.26.2


