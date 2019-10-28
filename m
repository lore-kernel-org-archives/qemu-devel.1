Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D219CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18701208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E7Bv8nsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18701208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7aW-0007sl-SC
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7PX-0005BQ-OT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7PW-0003pA-D3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:27 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7PW-0003om-6R
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id l24so7144946pgh.10
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Wcazrf1d/6yq7xUtsUWqMfgOcS0Og4vhQQt08gFl/0k=;
 b=E7Bv8nszzqYRNDu0wJ0GehmOgmGOZ507uv3L5jUofx2a4PCFKaGL3TujuL514uP+Hm
 Y6gzyVya/vUMm6W0Ch8YvQ/vQN9j1ohUh7PWzWNtXiJL+9pMTe6L/ivadbZtAT7ArOkB
 RPoPhI5QBudqISQNA7euZOlodKygmOZEdSS8ckPKW4lkaQPn7K/c3ygP1tU700ZUQdYK
 0C90H+hghYx/5YxFY2J2fBxW47B6pnTjCKa+/tmwvES5sQN5NgrVZvzq0ErHQlqvm8Ei
 dtZiTbgNGPAFzS9YTMg9PJtbehEy+l29v+9Y0xnE797RaI1lHnIFMcwbj4e5mJ1KiSzP
 9uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Wcazrf1d/6yq7xUtsUWqMfgOcS0Og4vhQQt08gFl/0k=;
 b=Q+ekQOV9/6q9nHwa820HWK9ap1RrH4dkCg8U0fpYbOEDyoW1x5c1wtmyaX1kKxd3i8
 w+2gGf1aXfyC7Jg7Ia8q1zcP7/YAzIbEMNy/aWptbWP+9qornKOPi4FsAF0rVPG5CZpB
 BIe4PB+E1Od62/kOYcRrna1AoqS99c/qr5II2aR6GJe8SvGsJk7h+3ciyMgEcl0NoBWF
 5h3maS+qdYfPsWnwfX9GrM6W46uEQcfUsBy9RBPbRYxwULG9N1Cs9bRGetb93zwxODwr
 uwSnU3RCzHUbJjrNXzlYi/uzqJsjURn0cEL010DGhJ9NyaTAj0zOv3iIDgSMAGt1VinV
 P8BQ==
X-Gm-Message-State: APjAAAXo5/frVQ5svf6wgN7b3O+FAn8cvhcycD5vRCvbu8HPMJ8BQIUj
 p9ESq2s2okwmuOGAwzBNwKfsv8caD2ESsA==
X-Google-Smtp-Source: APXvYqzmrhPmJxA2AbMG1Lt+nDArHSJ0TD1DWwygocl6qh3nZ3wzPD1OQN2Rae9luzF5CgsarQ650A==
X-Received: by 2002:aa7:80c6:: with SMTP id a6mr20617068pfn.89.1572278304867; 
 Mon, 28 Oct 2019 08:58:24 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id i123sm13313009pfe.145.2019.10.28.08.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:24 -0700 (PDT)
Subject: [PULL 05/18] riscv: sifive_u: Add ethernet0 to the aliases node
Date: Mon, 28 Oct 2019 08:48:49 -0700
Message-Id: <20191028154902.32491-6-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

U-Boot expects this alias to be in place in order to fix up the mac
address of the ethernet node.

This is to keep in sync with Linux kernel commit below:
https://patchwork.kernel.org/patch/11133033/

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 02dd76176e..1ac51e3632 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -270,6 +270,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         s->soc.gem.conf.macaddr.a, ETH_ALEN);
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
+
+    qemu_fdt_add_subnode(fdt, "/aliases");
+    qemu_fdt_setprop_string(fdt, "/aliases", "ethernet0", nodename);
+
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
@@ -297,7 +301,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
 
-    qemu_fdt_add_subnode(fdt, "/aliases");
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
-- 
2.21.0


