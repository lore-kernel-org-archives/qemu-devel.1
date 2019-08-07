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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C917BC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999432199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxcMQeAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999432199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGm6-0002gn-SW
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGe0-0001P9-M4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdz-0008GC-LM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:46:00 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdz-0008Fe-Ef; Wed, 07 Aug 2019 03:45:59 -0400
Received: by mail-pl1-x643.google.com with SMTP id a93so39421854pla.7;
 Wed, 07 Aug 2019 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=5yv5CdOFuxZYetYZHajkKH0g9WGo0eAwO4vJ1GVM74E=;
 b=rxcMQeAtSU3j5P0tzdOIXFGgZXyA9ioDYNkKey3MM/7mGgost+HUPmgB4S84wncJUI
 +s4VcOnUTE0HVYVJXvglLdRkX84tlX+uPxW01DKon6D5iawwBDLX4gLHnVNdpJUIjh0z
 b9P1gGYa1pXYafGBUlksoU7odwG5ZylKyuyJC16fzXYTR4PwDnr/SlFKkq7w/QFgBPov
 LanzVmYzCjgQ7W26W4+UpZ/2pnHfvEAjVkLeI1dMDI4JN8YULrDHiGXfjlogaoTcsU8f
 LgypqYs3LadMQF2x+gPBTh9/uBV51ol3bMn2hUqIRUp2MmjAPlaR2zUihCmNindXZC5L
 WM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=5yv5CdOFuxZYetYZHajkKH0g9WGo0eAwO4vJ1GVM74E=;
 b=fX0BkRFgkZnNxm5kFlrP6NNplgJF97KUBRnDbBpj5db/yXv+9Z1/0tBueSSGnGSuE8
 VbsjCUgchmq9Q14nATWIoh6iSER3quwBJpXR05scGVooW6+wElJ5jlUKE6Vh3bsCnOcT
 CavH+UXCXY76ZntJINtIbntLK+Xpk3Bvu9eP1suc9rK0u9Q8LVl3Fb07csw9savKZTb4
 YC7ZBIG16trIY2gca8Nfxmvu115XAf6Fy0yN2xj6pRo9gZ7PyoP+8xUFxf8pqXC/VJoy
 +56tS/K0YrWuWB/Zm39oWm5Tb0KJaF+MPZiSzGNCIppKjMKLkRxS17lQZrVjU+JQZGrJ
 +ykQ==
X-Gm-Message-State: APjAAAWDV3Fe37NCu6y2T54zBEESx4WJzVszEqD8v9+h7d7A9UXrmOtI
 goruEtNzZEF8ITKdBRA1gsk=
X-Google-Smtp-Source: APXvYqxIwP3lWtryoHmqTe/Yzx5gZAnOwRceOuyCA24MTBAyVmkAUAM4ujIAOQUCrj5VozOGIqksYQ==
X-Received: by 2002:a17:902:f095:: with SMTP id
 go21mr7130477plb.58.1565163958734; 
 Wed, 07 Aug 2019 00:45:58 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.57
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:58 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:21 -0700
Message-Id: <1565163924-18621-26-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 25/28] riscv: hw: Remove not needed PLIC
 properties in device tree
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
PLIC node from device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>

---

Changes in v2:
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up

 hw/riscv/sifive_u.c | 2 --
 hw/riscv/virt.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 30e6c43..d7a4aae 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -238,8 +238,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 127f005..2f75195 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -244,8 +244,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
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


