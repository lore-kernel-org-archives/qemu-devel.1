Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE30C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487A42087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE1lIF6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487A42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaCU-0006Od-Dg
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy7-0005Hb-1u
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy6-0008OA-2E
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:34 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZy4-0008Di-2b; Mon, 19 Aug 2019 01:12:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id d3so387369plr.1;
 Sun, 18 Aug 2019 22:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=MvSkQU6bhA/+oaRWx/y6yV72/doXJtPy4m3hYqxahYs=;
 b=CE1lIF6Zim0VLZ2DTWb5xq65xb+kj0tw3CVJyVEyf8jKcsqCdzvnzF9nSDAZn7RzG/
 bkpp1GY2edaFx66lHhMdfqh64mdmbGLmZDTz9akl8RUdVSz9v7vYOi2MyD+V5OqV02gf
 Kf/D1C5uL3sPBZ00ASqLxFLO1Vo3BpLihmZdqlIufKmtBGD92Cpy4tpd3iMhU3cjcGju
 hR7ZikhwFZRl1WocMXEDiU5aSRS0sPEebAPZyRuyb6G9tNkQunj77IKyN/LoIT5RtSpz
 uPmCE5KnL1CBObGJTAFSBxqn1Q3Rk782IRHtM0GGq/4lmPz3ZItXnmImfn6ajhlrJvry
 IaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=MvSkQU6bhA/+oaRWx/y6yV72/doXJtPy4m3hYqxahYs=;
 b=tTTCnK3vedNNzPc9ipHIsXblxm9atNZhoNSULfkt1kjr/6L+10aRJ7M7zp9rLEu2GV
 Hjpj7R5lIZtlhgt2xsnUGsmVcZBCQwshr5y/UIe8sHklMvt6E5DXBsY+5t4aQXgOGHhI
 GabzgUDo5HGN5PkPfTlepZIUohrwIrAr4LB9N4mDT5HolDz4lq6xpY0oNbPGzTir1kQO
 vUZrl5kfL6bxhQza15XKebI177rIcHyyYhAFrENywtOz8RK/6B8k0gaUNv2me/9XWwte
 nc8GCHIEft1y9GYsKbV+D23WOisZgG2e3+ZR6O3P+6eOx9iUQnE1Bzt5rDQFRxk0AKsi
 z1Pg==
X-Gm-Message-State: APjAAAXeRwS0r67WdN97I+rA5kn0PIRFysrv3+dS4zMrnzmZear5AZ2Z
 bLn0kKqGkXs0KS+f7df9+ak=
X-Google-Smtp-Source: APXvYqy2WS5rm14cGtRSWYfk+9tmqyBE0Ohn5HTKli31TXQhp99Rqm7UFJTd+X+JIBMK9BZIYLB+CA==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr5655942plb.305.1566191550639; 
 Sun, 18 Aug 2019 22:12:30 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.29
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:55 -0700
Message-Id: <1566191521-7820-23-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 22/28] riscv: sifive_u: Change UART node
 name in device tree
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

OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
use this information to locate the serial node and probe its driver.
However currently we generate the UART node name as "/soc/uart@...",
causing U-Boot fail to find the serial node in DT.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a85db77..8f16028 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -288,7 +288,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.7.4


