Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F977C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1E820866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBGpfMcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1E820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Zeh-0007DZ-I4
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6Ze8-0006oK-HR; Fri, 14 Aug 2020 09:21:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6Ze6-0000IJ-TZ; Fri, 14 Aug 2020 09:21:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id p20so8355890wrf.0;
 Fri, 14 Aug 2020 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KX6DJ+Ei+Qrvb3oO254QYRvydw3ZRBmD8xqPfn8fpEQ=;
 b=XBGpfMcMOvUvxAyohxZjFG9AMkoBANlBf1hKUORiwOSSDj2Rr+JxjR8dATADKi2Bb6
 KeVBuzmXue4BVYGraUpGpfMSy+HtuccLvKN0dbLbkIJjs2XRanJhGjuJapvoIojDEeeE
 Qn+qdCRPP3HkDk3YmXHtVkIEsYxw6clQ22hk5SpDYBbVZ5heDna8yy9rId8p1z6ygVl0
 R2rMbtwgyysVnKuXeMjzHx/N47DROAyEIlNiy4XwYJaM5vY6nwcVze4mW1zvIU7vkzht
 B3oMIBz5JiyZnhzMrrvGPVcgek5qoGiF/qjYoARwgDG6rINl+c7QUNFxBQpAOKvi2mNv
 mRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KX6DJ+Ei+Qrvb3oO254QYRvydw3ZRBmD8xqPfn8fpEQ=;
 b=TM+xslHcSlwlNMX33z0/KJxeVztn4tX5Ya/RwxRO9X2ath1Vqv7ws5xiARJziFNCCb
 hiiqznWb6MmJFRax8NO7MLGnpM1h9r+93kwdvVtylod3I8jHOH1EMjGnuMZ2WbkhDq/I
 KVZreH6x5/BF/FXdg6jLfmTqu1Lt1Z/8p/qo2Afh9i3cpeGJcuhTyCrpDDS6bXzKgLNc
 KcXOZa8gpxsBVzDCryZzxUoaBj934/PDdbCcY0V3J1lW8WlFc5fhDfHpt0DVzokuFDcI
 rGBfJchDJ0T+AVJ9Mk9yxonDZ2JxREI86imFTUcYNap2s0pruYIi1EAvFfpK9WQ11Fyg
 FVJA==
X-Gm-Message-State: AOAM533agS/IZ0V6CpKVyD6VvU+XIXXoJxWsyVXq/vezdlmWJ7+lT/+K
 m0guwgdGUg07bpPKVwvdRspLWJXvVak=
X-Google-Smtp-Source: ABdhPJyOmPWb36pOE7uI4ozo2u5VknifaRkPQQLRofmNbecF7x4PZkSSHnuZ19tFx8myqeoGD5rLPQ==
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr2624675wrr.48.1597411280593; 
 Fri, 14 Aug 2020 06:21:20 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t25sm14199667wmj.18.2020.08.14.06.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 06:21:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nand: Decommission the NAND museum
Date: Fri, 14 Aug 2020 15:21:18 +0200
Message-Id: <20200814132118.12450-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/nand.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 654e0cb5d1..7d7ccc9aa4 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -137,7 +137,7 @@ static void mem_and(uint8_t *dest, const uint8_t *src, size_t n)
 # define ADDR_SHIFT		16
 # include "nand.c"
 
-/* Information based on Linux drivers/mtd/nand/nand_ids.c */
+/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
 static const struct {
     int size;
     int width;
@@ -153,15 +153,14 @@ static const struct {
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
2.21.3


