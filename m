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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD194C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5788A20651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckyEJiaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5788A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufbM-0002IV-Fd
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufQ3-0000p9-UH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPw-000392-8H
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPv-00034L-GX; Mon, 05 Aug 2019 12:00:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id t14so36622438plr.11;
 Mon, 05 Aug 2019 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=xEY3l8h0rhtRUd3NJGUWgEZIzETm5Q+o0eADRCDJ/Z4=;
 b=ckyEJiaLVW2LSabNkgs0leu0TRq/0UIC39t5qbWGhnsKKSXWgGD8czIBaw1MSY6sGd
 xmd5tXPcKeEQcp8AUA7aW6OMmLKVymeys2WOnfF4troqEqEBlE2ZNqu+196ZzA3TsOCj
 bPfeDAlYTDFedvpJlGH11SY6sdmWuo4ZEPkCBGI7c/JsyT16bBIe2KPopgP7ZRCpKMYW
 tKJ3g6eJ0S+cewr9ihUqB770coYez742xRwuJOEdb2LiZ4cF46ERTDXHhp8U03clP0e1
 zi7scN/LqiG1Ig4F+ofoDGAvLrsVaFJLTOl2zUYXNd86mT22FwgphJqIeppqFZJABHTD
 c48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=xEY3l8h0rhtRUd3NJGUWgEZIzETm5Q+o0eADRCDJ/Z4=;
 b=T9Ic/xjPB1lNKzCmo7TZIOsBFtACZFGTw4FJL10rixrN6dLXWRu8wr3hH9wIXQzTmY
 OXNdXzk7VslooIYUgxmPiBfI/do8Mt4hbx0nzSi1B9UYGTL8EMOWQoz8EwrGEvv1Kwfy
 IoZ+7d9fb0dTYz8K3FeJPh658ULNDO6ZPPr5N8SAgXnnBeewJ7rjdzuTAg95XlxHHYC6
 oBHKIhi2w9ldzFZdMp4fjqvAOraiXeB0qD7FqGmzXxQOkPg8YT+MI/ploY1nP7Xh5bZt
 vfMrgIT2ymmMIgLj+AIcIb2LEriEAht/BiXcS57lDgX8cXQv3PNxte6I+oYMLUO9PDaa
 ZZIQ==
X-Gm-Message-State: APjAAAUrKnHcNwLTFAtKl2UOlg0Nc1neJuuTRSBsNNkM9aBl3eh+MNz6
 tEEYbEzR80HfUvEFf8wN+fU=
X-Google-Smtp-Source: APXvYqy8hGtyM0+qyaxvPuYWnu6xmdCWI073fRAUnbjjJh1aaCb8taEVO1kjO3WvvD0AAaWOU9N97A==
X-Received: by 2002:a17:902:347:: with SMTP id
 65mr50129040pld.232.1565020856427; 
 Mon, 05 Aug 2019 09:00:56 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.55
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:55 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:21 -0700
Message-Id: <1565020823-24223-27-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 26/28] riscv: hw: Update PLIC device tree
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

This removes "reg-names" and "riscv,max-priority" properties of the
PLIC node from device tree, and updates its compatible string, to
keep in sync with the Linux kernel device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 4 +---
 hw/riscv/virt.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d77b3c3..5ded3a0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -229,15 +229,13 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         (long)memmap[SIFIVE_U_PLIC].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,plic-1.0.0");
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
         cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 127f005..f662100 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -237,15 +237,13 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
                           FDT_PLIC_ADDR_CELLS);
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
                           FDT_PLIC_INT_CELLS);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,plic-1.0.0");
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
         cells, s->soc.num_harts * sizeof(uint32_t) * 4);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_PLIC].base,
         0x0, memmap[VIRT_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
-- 
2.7.4


