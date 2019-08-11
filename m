Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DFC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE03208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NphMvKVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE03208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwj43-0006gn-NN
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit6-0006m3-Ua
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit5-00048k-To
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwit5-00047w-NM; Sun, 11 Aug 2019 04:07:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id n4so6248893pgv.2;
 Sun, 11 Aug 2019 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=QT2ESK7fCnpMmH4ZapU9n1gxphlyVmLj0S6WAA5M8Cs=;
 b=NphMvKVb0V94733aGvUzd2uZRNFJJfK+rPsEt9eQ9OVo/SMnVc64gqLrOres3DD3yi
 LbJQ0W7kSXBKlFilI2fOpR+WycozsaAlRx9mGOMuQX3TyCuAHZVU64glhj5SEjv/9ask
 4Vw6qOBHlEMdBmxkHbffVl6MAuMrazdaQc1kut9gsWlZfvKYcN2Gkc644cmJjKV/57Co
 NtpB6S2SHnefdjiuH6pkrR7YrfrNLga7ZWnlHT2fDLaP9Lc5gF6dfCoZGCGwEvet3tMG
 YPim5QfGQmb3SW4swf9cKdTBuXGHZ6PeiLUbiqFBqDpFUnHtfR1WDGcVSzT85L61CRSa
 LjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=QT2ESK7fCnpMmH4ZapU9n1gxphlyVmLj0S6WAA5M8Cs=;
 b=dOyNxejjtkdhUpneTBlRov7Yr9DTj6CzmbPR5ETV9zj+g2ElKs1/cqPdxkUwSnROae
 FrNBZ4dxiIX50rqek4B065uWWceijkWfh7B3My9hdWEgPYpWD8j3H8TEJLXwiIsEbxxT
 bLhWEMraC2mHHC+gz9oR7ONbYbRXkVzDPUALAf6e/9RJA+kGXLPNX+uOFd40qL2V+ANW
 ZDMLAkdvAKC3eeLSAr/IiteOxv9OdDQ6KdPUfVJHoX/ULs0VhDb1j545EE5XEDVhciYW
 wJkaxmQVpCqgiqnGErfdQemYor3K8XSwdpioSz0GceXcQ8d4ZXn38LK9xLe8VjzUoTzt
 r25A==
X-Gm-Message-State: APjAAAXVcshofoDSlVDcePsl1HbGf2UlPqueYM/mqaM5gmgbTbSqDmVi
 LRfpZ9eAuWzxCpy/x3mjUWg=
X-Google-Smtp-Source: APXvYqxAK4saH8tv5oP1KfNctoudWgExU7VUQd1Ar6o7ezAeAXU6y9+TDxmp+wlAORDonJ96/5pzNw==
X-Received: by 2002:a62:6d84:: with SMTP id
 i126mr29701055pfc.129.1565510855043; 
 Sun, 11 Aug 2019 01:07:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.34
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:34 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:58 -0700
Message-Id: <1565510821-3927-26-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 25/28] riscv: hw: Remove not needed PLIC
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

Changes in v3: None
Changes in v2:
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up

 hw/riscv/sifive_u.c | 2 --
 hw/riscv/virt.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b0026aa..8801ee2 100644
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


