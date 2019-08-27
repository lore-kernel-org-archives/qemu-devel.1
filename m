Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8084AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF77214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFwnrJBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF77214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2d7Q-0006Wi-Ok
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwL-0003NP-FH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwH-0003mC-T6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:19 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwE-0003kj-KR; Tue, 27 Aug 2019 10:59:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id w11so11460134plp.5;
 Tue, 27 Aug 2019 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=4iYtTwKnL9L1t7ZggPRWTntToQMd8o1RWJMYHgQ22bs=;
 b=lFwnrJBus6x+S1p8pp3GS4L56iXiSkFEMKj501XEo0FJoAGvY6j1aDZsTQaQ0vYgLf
 RovRvgcj5UkViYGZsni2hHpaSxi2VIY8E1gpKnW1y+BjTQusimHI+Xhc3W8pw1UGZGfp
 +AY8/XtBonGZ7Xl2PrfZPoztdcaZ8G3rjitkamNC43Dnb7oTC9f0MLY+Hi1J4XP4sst4
 4+DVgAB6/Ujv6CuvHENG4CkiEb/8X+77uwvJjSHg0zWYZU5wD3LVPwnOclTbZrap7vVb
 iGjjc4d8It1rCoQyVDVlUZiMMQNW+9zwowUTnunCoUq6MbXmCAgJ9VgBMRoHOd0yU1Nb
 qBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=4iYtTwKnL9L1t7ZggPRWTntToQMd8o1RWJMYHgQ22bs=;
 b=eQmsdXfYEnLjuKCPqneSXGOJ1cMbVTwUGyIvTD8Wbyf4MSkIn1sPyzNmUbwsEhgnFX
 BC6/0XvwMrtpsLR7XiOzwjSYr/jhj9kh5JVfJ0I3NG9Pw75MnrlTJhZiEdgBbI3yLaZl
 7JpSEbk3AZf0yRyc/kAdoFHyZeLvUGrux3VpvwwQORaZ1zFsN7/j3AoL/7zo9NiE4a8s
 ohOtETYSwIk5E4Iz0DHbqItKWtO1z8L/ic9Lxkjov3haQUosQ1IRRQV/Sb8ianFuKVWl
 qm1K/Sc6xqhEaDDWhCMLNU1emKC4ps7cdB0mKuQJazegKrLd/9ljcdS8cCy3M6/iVCj5
 5eLg==
X-Gm-Message-State: APjAAAUQ+2YGhHfwqnXRZ5i6+jQa5n1sAXf8q9TJrRoOG9J6qyINSJd8
 g5jjtzE/gc8Px3ZjONyj/Oc=
X-Google-Smtp-Source: APXvYqw+sMiN/1l03sByPMRgYQc/sV8+Co3t17fAF65whGNoaMQFXuQgvfKIrqcaBFc0jPxSKB7HLw==
X-Received: by 2002:a17:902:8345:: with SMTP id
 z5mr9710660pln.29.1566917952650; 
 Tue, 27 Aug 2019 07:59:12 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.59.11
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:59:12 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:33 -0700
Message-Id: <1566917919-25381-25-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v6 24/30] riscv: sifive_u: Change UART node
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

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c7b9f96..d970037 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -286,7 +286,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.7.4


