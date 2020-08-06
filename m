Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D54204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4sKZyfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D54204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3axu-0003xA-Dw
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3awy-0002Fh-H0; Thu, 06 Aug 2020 04:08:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3aww-0005ft-V9; Thu, 06 Aug 2020 04:08:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id g8so8021779wmk.3;
 Thu, 06 Aug 2020 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rq4yNdphOIo43q9Xr8hQFGdolus1VUdY6wY1oJGgT2Q=;
 b=Y4sKZyfhVIgYQSBnb5ToM2MgNHsGlJwXdbcrRG4A38e90jZYd7i+GpenAP8CSN3N+4
 9gxUOQpzsLOEL462xvTKtaWDZBmJ0t+asS+jlI+Z2gOX1WrWgEPOcfTi7B24XTmlZ4fE
 DnQ8x3v5coa3Le9LtCxODrFvy6OoNr7YyKjdII5VC2nRaEwRt9h5JdBdhCTX9TE5Ljpe
 HfGUd3ZIXCCTBOD3MmskUVjDYufmpAtt+LdGZnYun1fSM3CLGOuM1zuhDsahQXHB1cgf
 FoQxDmYIXRo7ESl6ipy4aXzMTaJxOTYw7H6wIm6EPz5S7gWDOyG2/08yOdBYRfiAjTKz
 63JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Rq4yNdphOIo43q9Xr8hQFGdolus1VUdY6wY1oJGgT2Q=;
 b=jzsCFS0GWIT16xxeHS1Z9gdsDWAblU/YRH2gpGOQjS4otYd9PQMvu+tK4fsycomc0y
 AWZv0YLDU8EPpDEPteuX0JJcVYZ769uNkRaWz4xtoBGODX9KdP9ccefFAGYK82xXl4uU
 wMBeOB7ic09THHs0ly4RuiHGSBcKaM2S0UXLgZzTh7FANyHZb7jyWksDf+aN2ndd3Fke
 bDwqoe4WjAnU4IET/3SWThbgRf3UuWxugoGaLjJuyaN2locNov7+yV2AtoeHWKshon3s
 sCIDNd1c8bemlQIkB5shMOqJl5kIypvrqs2R36b8SIo23YKuIUYnwsnTxcZHBTS+Q2Zl
 DaTA==
X-Gm-Message-State: AOAM533UKweDcCoWLmpAlG5wXIAlthqPh2A6Cszl+i8X3cb4lFU18Fjv
 2PpF1wBMxEJmJzwZfBa+UZO7GVQY
X-Google-Smtp-Source: ABdhPJwQbqVFaRYfTEhE0ucxwIP57z1qC374zgUltvP1FF+yVb3HepGMYJcO4COGnfhxeRNCgoqA2Q==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr6690408wme.27.1596701308456; 
 Thu, 06 Aug 2020 01:08:28 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/7] hw/block/fdc: Let sector count be unsigned
Date: Thu,  6 Aug 2020 10:08:18 +0200
Message-Id: <20200806080824.21567-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806080824.21567-1-f4bug@amsat.org>
References: <20200806080824.21567-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sectors count can not be negative, make it unsigned.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index e9ed3eef45..2cec7568c1 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -245,14 +245,14 @@ static void fd_init(FDrive *drv)
 
 #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
 
-static int fd_sector_calc(uint8_t head, uint8_t track, uint8_t sect,
-                          uint8_t last_sect, uint8_t num_sides)
+static uint32_t fd_sector_calc(uint8_t head, uint8_t track, uint8_t sect,
+                               uint8_t last_sect, uint8_t num_sides)
 {
     return (((track * num_sides) + head) * last_sect) + sect - 1;
 }
 
 /* Returns current position, in sectors, for given drive */
-static int fd_sector(FDrive *drv)
+static uint32_t fd_sector(FDrive *drv)
 {
     return fd_sector_calc(drv->head, drv->track, drv->sect, drv->last_sect,
                           NUM_SIDES(drv));
-- 
2.21.3


