Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FAC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A1B22BED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUclFCIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A1B22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGgs-0006L2-35
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdo-0000xm-Lw
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdm-00084J-Dv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdm-00082x-70; Wed, 07 Aug 2019 03:45:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay6so39529321plb.9;
 Wed, 07 Aug 2019 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=rJ9o3PjetsKa5rb+xZapTTjmCu2Ub9mNF6ud1wfYiP0=;
 b=LUclFCIr+qCYp8G5hGe8bvlyBqgoGcDJaI7DTlMlCScFTdx7zyXoQw6+7LmQW0xMcr
 fh7/AGlFw/58V7CqAlM43SyYcVqIylSwgkTGu5cXQNBPtl0K6Yx+k4P1/Rdpp5NYEwvT
 sBtHPER+LKWBZ8HrXcv6ztI77VhgOkvB8b8b5t7QSW0aKxBt0G0u4pyHFkJT3xtn8KeR
 wLH8aQojKSHBIMtnQJ+5gHbc1gRKq3AksmIDxsIPnItaO0K8Hn8G+Bugj72D6dkJEuWL
 UFCUFK+ikzGYZIPLYNX1RXLs1Bn8U/KrFIzbryCNme0svZtRPUg2Mom9HJJ6gfVEKq9c
 wL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=rJ9o3PjetsKa5rb+xZapTTjmCu2Ub9mNF6ud1wfYiP0=;
 b=iZdJ9EQiIJ7a8OrRehalHI9wtj6HyWNGKsXNIL2vtM6pE3nz/CX+5DOv9VKXP7HcS2
 jbDUjNbR+51gcv4dAx5aIHdqzttwUOWXCmfCKTGTIUNmQvRTSCvSQAl+eDmiYu0FmAQT
 YFcfWyy74QjhrTeCKzZyardOcl1gXfRaDJ6B0ibGIRcapdgl8I3QZ8F4Jif2Taokhqvq
 MAxK/PnLo00aNQXHVkFxQAI+qx4cgE1QjavvHO/qwbO8gAJ2xuSiCgg43RZyyuqXWqw8
 oNtc/5d225xAmQn/QxBDp2o1/m+zywrl5wccMuKuRIa+NaDHH9PB7SpcY91ZDK/iWSZW
 qW/A==
X-Gm-Message-State: APjAAAVnOcsHcQUtYqqIDTu6oY0YnoJa1WE0ExAqM/WeHE8oLImmj2FE
 Vtd1WBHemFoXY0DVTmFOQbE=
X-Google-Smtp-Source: APXvYqxboaP56WvyUfWBtqd6lBlGDV5tOX2cOBUI0SeayM/f6RjLyHllS/5Xf06ZPOVBfdqj6Zb4rQ==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr6545857pgc.276.1565163943744; 
 Wed, 07 Aug 2019 00:45:43 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.42
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:43 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:08 -0700
Message-Id: <1565163924-18621-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 12/28] riscv: sifive_e: prci: Fix a typo of
 hfxosccfg register programming
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It should use SIFIVE_PRCI_HFXOSCCFG_RDY and SIFIVE_PRCI_HFXOSCCFG_EN
for hfxosccfg register programming.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v2: None

 hw/riscv/sifive_e_prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index acb914d..c906f11 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -89,7 +89,7 @@ static void sifive_prci_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
-    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_PRCI_HFXOSCCFG_RDY | SIFIVE_PRCI_HFXOSCCFG_EN);
     s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
                 SIFIVE_PRCI_PLLCFG_LOCK);
     s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
-- 
2.7.4


