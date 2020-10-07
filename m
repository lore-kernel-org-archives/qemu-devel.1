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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6861C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28A221D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzoYvzXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28A221D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5BK-0008R0-Is
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQ54O-0001VW-7F
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:45:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:44491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQ54M-0002qd-0U
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:45:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id h2so641305pll.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/nx0v7Y3v/7WYmx+DAfRIR0wl6I4NLnpVoOUzG4A1dE=;
 b=OzoYvzXWXwq6bFmDSH1I/cH8AMdDYSUudNlRSXcqogV/6mYWReyrufMboM8/MzMOpW
 ZKLT3ySCOBvQSnH1wLdoTzYlBn3sRpTjQSyXHBO9EW6SQZJ8rT9hRwRZEneg1EGCQqUt
 FbHlI41GRmiSPS2pARVxyhWCCf5YurFP/u7wgMdSo8xeEUy4/NxEr5hG2/GtHsvldwLX
 rTDgUlOJ7bxYxiH+eo1ddeEGoumlt0sTr1kU0SWm8aj6lgodJO+keYh5fj59aoWU/Vxz
 N2KtEj46cvTHcJcje4DdjXFs1c+iKnpLU+rUZcm6adQ4UozyeVI3Pt5rQDt8yCkJXefb
 YDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/nx0v7Y3v/7WYmx+DAfRIR0wl6I4NLnpVoOUzG4A1dE=;
 b=lHwUwug13usI84M+gS9KaBVn1jugx2crXgDs27wYhxBIlvaMQPocBk2v0hYNzoiqys
 a5HoVej7Mvsl3MKBpu6wEZkMhA3wOdtLEGTU1E6kbdXIEmD+raCGB5i+a5PFC/ZmozNY
 clHijSZf0z/cKHGSn0MjLl0H2LKMmbJhW7tJOk/uv4KX+rut0bRON5Z8AIiSCvOVXWF1
 hWFkvzauO++Vv4/pwWViZJP0XwtvVT1zreppS68IYqv0LsW/EH4XKZnAw8ZQn+CQHP2I
 KOxfHAgV9iFcHjRs1liBapxikm7P4PHK0Y+Gz8iZ5UCS2swWGsY1+jKwlUcO6fK7JG0U
 NiJw==
X-Gm-Message-State: AOAM530zJSVX1tB4dYOeKR62AaK6D7wwWFolM3hKwcxmmkx1aqRx+l3k
 1GTXdUKnqeil2C5ZOBcGYik=
X-Google-Smtp-Source: ABdhPJz7XdFOD71Jd9WIGGiNAcdvT+xy26LeaH+dd2+mhFb96OD7x8ZPnQ/lp+vsbJBitidWhbU2sQ==
X-Received: by 2002:a17:902:c40a:b029:d3:d448:98a8 with SMTP id
 k10-20020a170902c40ab02900d3d44898a8mr1921446plk.29.1602060303610; 
 Wed, 07 Oct 2020 01:45:03 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id i9sm1999692pfq.53.2020.10.07.01.45.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:45:02 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V13 9/9] docs/system: Update MIPS machine documentation
Date: Wed,  7 Oct 2020 16:39:35 +0800
Message-Id: <1602059975-10115-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x635.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
index 499b5b6..02cc4bb 100644
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
index cd2a931..1f86ccb 100644
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
+-  GPEX and virtio as variable devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.7.0


