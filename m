Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF2AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204A8206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrERmqA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204A8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTJgm-00041k-44
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 02:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kTJdb-0000eD-Gg
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:54:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:45241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kTJdZ-0000zj-P0
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:54:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id e7so906596pfn.12
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zetwN2GOiqmJys9dmvvyOf4Mhj+Is5SOMtMxf9odPEE=;
 b=PrERmqA4VfuarF/egla+4ys1tBmucFdlF/s8ahpJpKDJhc/IceuHlF1U5BPvuHfDOy
 gDTu0IyM+vC5l5hqc15rIbL1DCXLWU5W02yUPMJocTFBiZXrp2I5fcUK+zQ0j9U8W0ay
 MYVAgMw4pcbToC9hW8qddInVe2yXX76QJJNLXuSJpud6BMNobYYY3Hx3oYqjmNYaXlRF
 keLJW/xIAWTbd2WKVxQVzK1j8p+3VBJMXn4NqHG1BZz27n5NBRfRVzk0rVNtZDRT622c
 0d73xB/NNXOhvoIIKIBXtCx1zbF8mG4toN9sEamIkU5L4Tl71+eNJpQisaztbmYV9uOq
 FbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zetwN2GOiqmJys9dmvvyOf4Mhj+Is5SOMtMxf9odPEE=;
 b=bkJ6ApaMuydLr9hnoaMzOC07YBJlqKbwObdZBLWrqizHkhtZ6R+W2Xfsyu46Rmhdx2
 QD/cAPdpfCzuutCIvZqRmLW8GOHKOeawshMBQj2EMUXb9ZUuM9/j6FqV9Fh7BIrwMvgv
 M+LBCOlnmbPjadqojKlUvemSzCUiZ/6NOLaPfjxCkNmf6K6Eicr3Ca4nZ3RhcVhEvklz
 tGeHzPbB0TroSe93g2MAE7wqmFctTDxxxXU8cQarPKxzWEQ5EhN/A6ySDCOO/H7TbjbI
 z+larFrZgYd6UDRC92Lpd+rf5I/pN0sB5NPI6bFm1p1RkgmFwtKe55Y8Fzu1uJerRed2
 mWqA==
X-Gm-Message-State: AOAM531D+v3BcVuER2xJcLSHi/ROSR5jXzj9Y1JIobfJS5Jg9yTe70fy
 94Gf2q7EPdNmGswAR2sY+dDyg4FPgPvofA==
X-Google-Smtp-Source: ABdhPJzmo4Nvbc3yZvfDIEi76UT6M0fvCCadvI553e+QxY69zqxA70jPr30fzXkxL0umiSEi6hn7vw==
X-Received: by 2002:a62:92c8:0:b029:152:1703:2da9 with SMTP id
 o191-20020a6292c80000b029015217032da9mr2295941pfd.60.1602831288436; 
 Thu, 15 Oct 2020 23:54:48 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v21sm1552200pjg.44.2020.10.15.23.54.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Oct 2020 23:54:47 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V14 8/8] docs/system: Update MIPS machine documentation
Date: Fri, 16 Oct 2020 14:52:00 +0800
Message-Id: <1602831120-3377-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x436.google.com
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

Add Loongson-3A CPU models and Loongson-3 based machine description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
 docs/system/target-mips.rst         | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models-mips.rst.inc
index 499b5b6fed..02cc4bb884 100644
--- a/docs/system/cpu-models-mips.rst.inc
+++ b/docs/system/cpu-models-mips.rst.inc
@@ -48,11 +48,17 @@ across all desired hosts.
 ``I6400``
     MIPS64 Processor (Release 6, 2014)
 
+``Loongson-2E``
+    MIPS64 Processor (Loongson 2, 2006)
+
 ``Loongson-2F``
     MIPS64 Processor (Loongson 2, 2008)
 
-``Loongson-2E``
-    MIPS64 Processor (Loongson 2, 2006)
+``Loongson-3A1000``
+    MIPS64 Processor (Loongson 3, 2010)
+
+``Loongson-3A4000``
+    MIPS64 Processor (Loongson 3, 2018)
 
 ``mips64dspr2``
     MIPS64 Processor (Release 2, 2006)
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index cd2a931edf..138441bdec 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
 
 -  RTL8139D as a network card chipset
 
+The Loongson-3 virtual platform emulation supports:
+
+-  Loongson 3A CPU
+
+-  LIOINTC as interrupt controller
+
+-  GPEX and virtio as peripheral devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.17.2


