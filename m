Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ECDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3D22073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVHj98uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3D22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrCJ7-0000L4-Lr
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 23:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCH2-0006jd-68; Thu, 02 Jul 2020 23:22:00 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCH0-0006rR-6l; Thu, 02 Jul 2020 23:21:59 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u8so12983867pje.4;
 Thu, 02 Jul 2020 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=/HM5zEb2R72OqiDbPriYiqvc3Xj//HmllZogpWwviMU=;
 b=lVHj98ujvz7a1OVn4fX6kupsC6eS4MyWiOSEd7CwkYv17FOAl2GPb3cYQ7za5GoTGh
 NR2zh/QQM+tVmGMzbQ1NZYdJWwD83lhCx1QlJ29G7SDr72/SSMV4mYwzy3IQ4qOdRHXA
 KMBYfEQ+LENwfBBlssIFzyV2uJMk/gP4rBFLIiZFFja8piGyyUIAPBpp7urlGOS1GCdt
 YtZqRonojdcUwEEqc7un4HP6qpeCO88LuZr1CazQbqeih4Tu8eQu36Y3+fWDztDzV9Qo
 d3el9WFsk8slRIQ0b63suga+1/mADgxMhUuE5877W8BdwvShBHJ/WyjMrQZpzlWiNu/a
 y95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/HM5zEb2R72OqiDbPriYiqvc3Xj//HmllZogpWwviMU=;
 b=dsE+cH+TKPBI0860C7pE5YbXmaVjdwrzRNOGilmSlwPEHA3GQoq/yhCjuQGTdIBpnI
 ZOxfcckSHxwc3JGg8yS1Fwzz2521B8y5DfdsD8+Fd6mlTPKwSUUQzQ1UaPmSJwOGfWVB
 rZx13C1Cp5tTKBYVehKh6lmuE57W7qBo2eXCQB8k4ij9wQc2IwfWjaxSOZDVMLSldTB3
 GzKfCmEg0V7DsMdWofMinO97S2Ac/uFxOAhpVQbzADC3RmSEsx+bNOzRUMZSSNW/Cy5U
 Jcgdq6IeWLVZtRSoMTtXEqUF+FY9mqN7ZE1eSgljFgLYri6jcTjgviDp5wafugiWt04J
 2loA==
X-Gm-Message-State: AOAM530Hr50FiAgVgkFNYnnLieFZ2Gxm2EqMzKvv0y/T3yG4ydNevsq7
 C3Vwm7EiBpEK6FkK3MWLmCqsnfJA
X-Google-Smtp-Source: ABdhPJwx00FH1i1K7c1L3IlpE5Bpz9vkfRnzmZVBU+9niohzfwFMktj8Rr7Nj7EdBJMbBD8BXQG28A==
X-Received: by 2002:a17:90a:b891:: with SMTP id
 o17mr20617230pjr.202.1593746516542; 
 Thu, 02 Jul 2020 20:21:56 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i128sm10341987pfe.74.2020.07.02.20.21.55
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 02 Jul 2020 20:21:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] hw/riscv: virt: Sort the SoC memmap table entries
Date: Thu,  2 Jul 2020 20:21:51 -0700
Message-Id: <1593746511-19517-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Adjust the PCIe memory maps to follow the order.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5ca49c5..aacfbda 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -57,14 +57,14 @@ static const struct MemmapEntry {
     [VIRT_TEST] =        {   0x100000,        0x1000 },
     [VIRT_RTC] =         {   0x101000,        0x1000 },
     [VIRT_CLINT] =       {  0x2000000,       0x10000 },
+    [VIRT_PCIE_PIO] =    {  0x3000000,       0x10000 },
     [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
     [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
-    [VIRT_DRAM] =        { 0x80000000,           0x0 },
-    [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
-    [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
     [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
+    [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
+    [VIRT_DRAM] =        { 0x80000000,           0x0 },
 };
 
 #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
-- 
2.7.4


