Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AF6206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Qi3xia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AF6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF77-0000S7-6m
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIEZT-000391-2M; Tue, 15 Sep 2020 13:16:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIEZR-0003La-8M; Tue, 15 Sep 2020 13:16:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so4147442wrx.7;
 Tue, 15 Sep 2020 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qr6f9AT2xXhs7lC//zas/UKV7xxcJifoLxVHcysah5k=;
 b=h1Qi3xiaYt8prZdLYkoydt/Ts2EM/G81Oy/MYE8D0ME+3m+3yljn0uRaAybQUIMh3W
 Nado6YZSGhB6ZhYcwQQsT03cdYsLVnOM2Htd2lbhWpNMkhjbwdq8aS36w8hhHYz54BqG
 bSzbDIu8Vj87fQu7FrCvNXmqG9Kjj/B2CpNGDbp0KBpEpdbbSNItezPYZ2I+ORhvzSEX
 vnWttrnxe+sseZq81/iSYEDkcReIVN1RW1OI7U8mvO5JSvId+DrWQpqou5p9cD+B1ZGt
 VP3F//bK1ztqVu6CPs8EgCQ3/kwvCJ5hDHmJ1A1nXGEB6GngIad6oNl+1hkVY5AQa87R
 /Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Qr6f9AT2xXhs7lC//zas/UKV7xxcJifoLxVHcysah5k=;
 b=GBjxLUlR8eWpfuvXbeWkG5PMD/L69eiZ2bNjppaihi0zdFeiWzdJoNRwbXRi4wzrCV
 PMImlzdsxmiQJoJ0D2lmtSAWNngIhbRD7PyMynueixooeGOH1xH0RiDUD4mFfzzhLZH1
 1F41X3FoyTO/Q6plhYYBcxTC3sb9BIJq+5v4mSwpoPA/rmAk5tyYwywf4w73+6gvkQzl
 nyRFLyo49i4VHCQq36HpRPuEHd8Ac4bUbdc2JHCer/CefatYqxWg1I56ilYQ0X0Eorf5
 8pXKDsVtRS6yHEPt3NmcZrEZrjhQd0sJvN8cqufxbWN6DkiImyRw4wPcNuqzP50r9eOk
 aLrA==
X-Gm-Message-State: AOAM5323QgqlBWnDzYr4i676FaVXOmaLwpZ8baDFv6+z5wGCtV1AbWWl
 +iFi9VBTEhRCI9PidvYBeQIZg2VEaWc=
X-Google-Smtp-Source: ABdhPJzv9Uh7vN0JyTqaVwcOozqvpudOawvj0Dv9nDBILhgiPRmUiaMsC8e0z1zxRWLIQBKrZjb5dQ==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr23499726wru.90.1600190202502; 
 Tue, 15 Sep 2020 10:16:42 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m23sm397726wmi.19.2020.09.15.10.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:16:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/block/nand: Decommission the NAND museum
Date: Tue, 15 Sep 2020 19:16:39 +0200
Message-Id: <20200915171639.1355800-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the QEMU equivalent of this Linux commit (but 7 years later):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7025a43a9da2

    The MTD subsystem has its own small museum of ancient NANDs
    in a form of the CONFIG_MTD_NAND_MUSEUM_IDS configuration option.
    The museum contains stone age NANDs with 256 bytes pages, as well
    as iron age NANDs with 512 bytes per page and up to 8MiB page size.

    It is with great sorrow that I inform you that the museum is being
    decommissioned. The MTD subsystem is out of budget for Kconfig
    options and already has too many of them, and there is a general
    kernel trend to simplify the configuration menu.

    We remove the stone age exhibits along with closing the museum,
    but some of the iron age ones are transferred to the regular NAND
    depot. Namely, only those which have unique device IDs are
    transferred, and the ones which have conflicting device IDs are
    removed.

The machine using this device are:
- axis-dev88
- tosa (via tc6393xb_init)
- spitz based (akita, borzoi, terrier)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Peter, as 4 of the 5 machines are ARM-based, can this go via your tree?
---
 hw/block/nand.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 5c8112ed5a4..5f01ba2bc44 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -138,7 +138,7 @@ static void mem_and(uint8_t *dest, const uint8_t *src, size_t n)
 # define ADDR_SHIFT		16
 # include "nand.c"
 
-/* Information based on Linux drivers/mtd/nand/nand_ids.c */
+/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
 static const struct {
     int size;
     int width;
@@ -154,15 +154,14 @@ static const struct {
     [0xe8] = { 1,	8,	8, 4, 0 },
     [0xec] = { 1,	8,	8, 4, 0 },
     [0xea] = { 2,	8,	8, 4, 0 },
-    [0xd5] = { 4,	8,	9, 4, 0 },
     [0xe3] = { 4,	8,	9, 4, 0 },
     [0xe5] = { 4,	8,	9, 4, 0 },
-    [0xd6] = { 8,	8,	9, 4, 0 },
 
-    [0x39] = { 8,	8,	9, 4, 0 },
-    [0xe6] = { 8,	8,	9, 4, 0 },
-    [0x49] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
-    [0x59] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
+    [0x6b] = { 4,        8,        9, 4, 0 },
+    [0xe3] = { 4,        8,        9, 4, 0 },
+    [0xe5] = { 4,        8,        9, 4, 0 },
+    [0xd6] = { 8,        8,        9, 4, 0 },
+    [0xe6] = { 8,        8,        9, 4, 0 },
 
     [0x33] = { 16,	8,	9, 5, 0 },
     [0x73] = { 16,	8,	9, 5, 0 },
-- 
2.26.2


