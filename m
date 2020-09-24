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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F6C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A223206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1DjzpkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A223206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLxc-0000ou-9v
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kLLsl-0003Oy-6M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:41:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:38548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kLLsi-0001UW-Tl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:41:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id l126so1377933pfd.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VaLsq131cxSFLLb9dWpm2TOUowIQwdWIbjnurwZZe5I=;
 b=T1DjzpkWvRKUUlzRIAvj4S4WeTOfRaFENcQaIE4uKJYflwz8fLcA0c/iI0A7tNjFRO
 qcTEFp7XtcruFQJbCq1TX9suVSNyYOXaXdzr3Wkbxz57cZHKHD9maAVdbjyJs1GEeVn7
 wRqXpMIPwVCX+0QUtPN35m2P9Jx7RE+yDpPZnG5MhbHFMsImZo8Hi8kmc1kw0mU4IV56
 cmX7Mc4177LM+rKwFGelsbu2nSZxNzw5WW2KT/nE+fvXM6qn+NOcK9mBKrQD5H/EoV2F
 yHpWvwvdhonTSE2nzt2GuL05qKtlBiRm4RuyqXEwrmxpBJfIeUtjr34oIrHeWg/eMPNe
 n2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VaLsq131cxSFLLb9dWpm2TOUowIQwdWIbjnurwZZe5I=;
 b=fmFQsQ5sSMqQKa+0aAM8DeKKhvEXLTyr1uTVPfe4hSchgK5TS93vxsyv1fHFmt8wj+
 PkAiwPsJaks0gHwZNDD9yaKyEqhF3chwCxqA2W0D1eBvMnfGGsVPJTxigW3JOc4hItdP
 Zvy1FAkYgHHyzintNaCxRsE5tC7qVtWnkHnwlsRfVO69RDDSJw7VCbNygaXfAPUqsfDU
 aV11g39XPuRU1pnIznbF29v3nA7UtHlRxiM5NMtNHNs+w8cyC/S189tLQZ5GaYc98npZ
 Xd25JAKrjkmvq9jTEoMXppqkYRrZ6X03x4+LD0GikORsjUZBdHebi5U1EYPRte7i14SS
 /j1w==
X-Gm-Message-State: AOAM530w002W56bsnreo+HieAYY3Pz3rqfgIAY4fL1OMIvxZE2SILs7t
 uM1tk1ldYK32D/xbrRXRXA4=
X-Google-Smtp-Source: ABdhPJyDzt9YJZZqAnIIYIlxrko2epbmZ8XZ7capl3pFVUXKvQxCK4cUyA+i0WruihxwRIAfJLdVXg==
X-Received: by 2002:a63:d56:: with SMTP id 22mr3005387pgn.286.1600933291570;
 Thu, 24 Sep 2020 00:41:31 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id x13sm1777864pfj.199.2020.09.24.00.41.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Sep 2020 00:41:31 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V11 8/8] docs/system: Update MIPS machine documentation
Date: Thu, 24 Sep 2020 15:35:56 +0800
Message-Id: <1600932956-11642-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600932956-11642-1-git-send-email-chenhc@lemote.com>
References: <1600932956-11642-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x429.google.com
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
index cd2a931edf..1f86ccb697 100644
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
2.17.2


