Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1914C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC422053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al+XA779"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC422053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIjb-0005Bf-Ud
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbi-0001QL-G4; Mon, 08 Jun 2020 10:18:34 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbh-0004WS-I3; Mon, 08 Jun 2020 10:18:34 -0400
Received: by mail-pg1-x542.google.com with SMTP id u5so8816080pgn.5;
 Mon, 08 Jun 2020 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LHxwDr0kzk7/A3rA8MbAL70MOcYV99ZL1ednJrPZlKw=;
 b=Al+XA779jimVcMocXb2e94/89jjJ95gaPWM+EsSN5fG/PL5PaD3hHMpY90fRkIGmMD
 5UpG8W24Vgk+Q3DfCLdr58HVkdE2oQM3dd/GpVJOVEHiW/WQIC7JfcfojiyyJqHNu1Kx
 5ERz561XN7Xi3bWEsBGyExwfz+ElU1o192gLbb9tgWn4Gvb2QbEPSDsvJ1udkvidR/ti
 dwGt5PUwwVqXsh/SXAqBXYxGUgBj7t4E2X+qt9y4azWoaauKRuspqfq/hr819wsMvm8Y
 QAfcutDh+mOrIfHsKFK1ersp20maKyiIflMGSdIPWm6WZmHyuw0F1MjSICLaddGLkfff
 CfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LHxwDr0kzk7/A3rA8MbAL70MOcYV99ZL1ednJrPZlKw=;
 b=YR3i4JENi69nPb20Bb0f7F2K4yp7EnOk3FYfWZMjD2QXqNY6jQt3GkDLpb2chF0xrx
 8FL4ylVhYDVQCWIQSGT1qqlq/7yaP3nA7lwLNMTaVrjjrGdHi2IedZVRzs8RY/juQEi5
 Li4omqyuizC2YnbhwemRlis3bwpAlsXqBvdGvJDnV/zc4ja/18J8cLO3lAJhzFWw44zt
 DxRWdCPGwAWuYlWoZjYJeiJXGP3luY8cdL0z/hSOXR2N+GnetoEe2Pxus9K3ZgW0vIi3
 yu42gcQe/tZf9d9qmBlkJa4mhYjD3S/01XeAoEyFKWMbtWGJzSuJRGBLn5Nxy09wtDIN
 1E+g==
X-Gm-Message-State: AOAM5313ls/cPdNTH0st4O2+FnN1fEKEw1PEAHK5y8l5BrFI2x6VlkKx
 Io16JeMD6dasMLkPXPtvvLc=
X-Google-Smtp-Source: ABdhPJzON1bA9vX5vXm53A2vaJ8y83QgISLMON/dMaYzpJN65f25cOLS5MEEiwCFuWsyxrV+rZ0+UQ==
X-Received: by 2002:a62:cdc7:: with SMTP id
 o190mr21272658pfg.292.1591625911944; 
 Mon, 08 Jun 2020 07:18:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.31
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 14/15] hw/riscv: sifive_u: Sort the SoC memmap table entries
Date: Mon,  8 Jun 2020 07:17:43 -0700
Message-Id: <1591625864-31494-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x542.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Move the flash and DRAM to the end of the SoC memmap table.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f64aa52..c94ff6f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -80,10 +80,10 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
-    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
-    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
+    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
+    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
 };
 
 #define OTP_SERIAL          1
-- 
2.7.4


