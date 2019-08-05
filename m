Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2580BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E482F208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXmSi3M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E482F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufcP-0004cR-7k
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufQ7-0000qg-24
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufQ3-0003Dx-S1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPw-00037u-U2; Mon, 05 Aug 2019 12:01:03 -0400
Received: by mail-pg1-x541.google.com with SMTP id d1so7152707pgp.4;
 Mon, 05 Aug 2019 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=+v3Lns0tEiQptfKd7eot6+jH+9+BuMFTgvR4ejTal9Y=;
 b=vXmSi3M4kb1OkhnHlLrwa7kGRZ/YaMwvlUMNa1XDfTVgarDrKhLCWYn804pWZP6flA
 6kiKcTUY3SVU4dHNA0aYgyIWrJYEfrZsUbHjlc71X8PYTFfcHwtAVN2uYVovp55Z6tr9
 i7fzM/j6OYQQLIJiP1PEcGae6lcQjDL3Q+MVOIFMkFeuDeQPpnbY7XWdwAJROqjRHcDU
 rIa1Gbmfmu7xnvqOcZ+UgFTXs0sjh8DN4BeIxgvclwclKYgCod98n8ZtPlELAXqvEtwl
 EEqA4ZgLqT7cvJNKFQGQ2dK3I7b/v0LulPiEHiRXVK2RFiqupd7j4NoMSza0lMQA8xsA
 9Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=+v3Lns0tEiQptfKd7eot6+jH+9+BuMFTgvR4ejTal9Y=;
 b=JmF/BLWuBLPRjW0ae5Xq8AmRH1Qbj+dQISJWu/vUbvTMUH4lKreZAlBuz6lmoZkM+D
 I6RPXvEhB0+dzs9y3LGV4dSgm4d3/yEchijBPhHR+ygrp+qaaeRLoJ527u0EfbNTpUtZ
 kQcfq3g6xWa2ciT7zcY6GqYqUS0oACxynl/DxJ7wCfTtRdN5f2ih88CL5MA6e6oJ4SOx
 jzuP1PirslDMbUzipzTiAsvHOjaC12o4uPQ2ETjAfTbsrAGXWgrFfyper0dd9RdnUmeu
 iPiqyYHmkCr8+YihPH9PY8CwnA7E2Y0ns84NwmmEYiAm8fMbZWk/u/LVcuhP/DNKmUQY
 NWFQ==
X-Gm-Message-State: APjAAAVmyzEA9yNMt4Gmrr9o+1vp8egXa8fJUUYcLASI3YqdzsbtaD/I
 Z2rk80Q09aU03ty7nP6MzO4Wpmur
X-Google-Smtp-Source: APXvYqyf7Pql9GEuY6fyWeStjofS4aMQrOYppK1Zc8HSpQjVjD7+DQwzYxFsxQRta3qq2mERnpNohg==
X-Received: by 2002:a17:90a:d14b:: with SMTP id
 t11mr18806309pjw.79.1565020858375; 
 Mon, 05 Aug 2019 09:00:58 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.57
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:57 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:23 -0700
Message-Id: <1565020823-24223-29-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 28/28] riscv: sifive_u: Update model and
 compatible strings in device tree
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

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5ded3a0..b7d4b4f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -94,8 +94,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.7.4


