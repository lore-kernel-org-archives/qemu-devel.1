Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E610FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34B1204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwoTuFlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34B1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3azI-0007J8-3Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax0-0002Il-IV; Thu, 06 Aug 2020 04:08:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3awy-0005gD-S3; Thu, 06 Aug 2020 04:08:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id a5so33116377wrm.6;
 Thu, 06 Aug 2020 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aNqGoj9XEuK6FXLTe1Hk7gTK5CIz55oFAjsctzZx5hc=;
 b=YwoTuFlWhAhJ1u06Ry7qUkbdpDuuky9kAz6KS7zMs1BIw6Sb19k4aAcd9sbZXqXVJ7
 IoTPR42VSGyi0GHH/CzCwstaBTuWAR52Cd/88iyqTZjCUIs5g0UM4BKsJlggWBfqDjTL
 lkksyd1wRvDf6elv3HqBhTS6df7FH1eDdosoKqT+XhaMKjvoCVYzB80mxeNyr4pr+HWl
 ggYVMf8cnMKGa7MfndxljT9IdGD9kxUzQsq9IrOKC7gtSR9cHmjDtROpe72j5VULcBKm
 /XZbtGEw4xMgq5LtQEz6sAygMTK/kau3N3GAjNyHJvT6Kv8AEN33E91SaG/1uEUUmMMr
 Xtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aNqGoj9XEuK6FXLTe1Hk7gTK5CIz55oFAjsctzZx5hc=;
 b=EfuUZaaJO0ajoNlJUz22wOYdwGrYDcklFQljOpINvR1q7AflMzU9jv4oBbRMNB+p1D
 6zOM8tgVaTm/HB3kPqbsHvVyrHz/eBuGQ9THMpyoreeQkePdv+35rwmfwj+AYYEpTVqM
 FnLaYYDZ1Gku+l+pUm7seRD6b/NoGJic01467FAlusNnv16v+JRNJRbn1N59yCNDG4ip
 sdeNHw67S4vfxGh2O/SbhXfJwlzZi5sW5jOTWCZZI9droygvdpa3LXm5fXWnSMC6xB7I
 HJ93mYmNDnSVbRf1yAvViGmQo5yDh9RAMxB93QzR6BHx5SJZSFLC2zZVHtcJ8olU6PZH
 NSXQ==
X-Gm-Message-State: AOAM532o7bVs5TnCUFOckglPjNTlBC4ysAf71GqMGW/Vjj8DPyO/TgVP
 DB2XBKYzx5Nr3+yZy7/IAlXY53Ef
X-Google-Smtp-Source: ABdhPJy8uhbLGRzwvC20F0yyO8FoOirgX8AyP2EB1JUr8RoP52AwKxS5ooSCWR2kHcPNGk1QSw1iXw==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr6378477wrw.148.1596701310699; 
 Thu, 06 Aug 2020 01:08:30 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/7] hw/block/fdc: Use warn_report() instead of debug
 FLOPPY_DPRINTF() calls
Date: Thu,  6 Aug 2020 10:08:20 +0200
Message-Id: <20200806080824.21567-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806080824.21567-1-f4bug@amsat.org>
References: <20200806080824.21567-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
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

Use warn_report() instead of debug FLOPPY_DPRINTF() calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index c91ed7ee2d..ee45ec0b27 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -395,12 +395,10 @@ static int pick_geometry(FDrive *drv)
     if (match == -1) {
         if (size_match != -1) {
             parse = &fd_formats[size_match];
-            FLOPPY_DPRINTF("User requested floppy drive type '%s', "
-                           "but inserted medium appears to be a "
-                           "%"PRId64" sector '%s' type\n",
-                           FloppyDriveType_str(drv->drive),
-                           nb_sectors,
-                           FloppyDriveType_str(parse->drive));
+            warn_report("User requested floppy drive type '%s', but inserted "
+                        "medium appears to be a %"PRId64" sector '%s' type",
+                        FloppyDriveType_str(drv->drive), nb_sectors,
+                        FloppyDriveType_str(parse->drive));
         }
         assert(type_match != -1 && "misconfigured fd_format");
         match = type_match;
@@ -1805,8 +1803,8 @@ static int fdctrl_transfer_handler (void *opaque, int nchan,
             /* READ & SCAN commands and realign to a sector for WRITE */
             if (blk_pread(cur_drv->blk, fd_offset(cur_drv),
                           fdctrl->fifo, BDRV_SECTOR_SIZE) < 0) {
-                FLOPPY_DPRINTF("Floppy: error getting sector %d\n",
-                               fd_sector(cur_drv));
+                warn_report("Floppy: error getting sector %" PRIu32,
+                            fd_sector(cur_drv));
                 /* Sure, image size is too small... */
                 memset(fdctrl->fifo, 0, FD_SECTOR_LEN);
             }
@@ -1833,8 +1831,8 @@ static int fdctrl_transfer_handler (void *opaque, int nchan,
                            fdctrl->data_pos, len);
             if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv),
                            fdctrl->fifo, BDRV_SECTOR_SIZE, 0) < 0) {
-                FLOPPY_DPRINTF("error writing sector %d\n",
-                               fd_sector(cur_drv));
+                warn_report("error writing sector %" PRIu32,
+                            fd_sector(cur_drv));
                 fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM | FD_SR0_SEEK, 0x00, 0x00);
                 goto transfer_error;
             }
@@ -1911,8 +1909,8 @@ static uint32_t fdctrl_read_data(FDCtrl *fdctrl)
         if (pos == 0) {
             if (fdctrl->data_pos != 0)
                 if (!fdctrl_seek_to_next_sect(fdctrl, cur_drv)) {
-                    FLOPPY_DPRINTF("error seeking to next sector %d\n",
-                                   fd_sector(cur_drv));
+                    warn_report("error seeking to next sector %" PRIu32,
+                                fd_sector(cur_drv));
                     return 0;
                 }
             if (blk_pread(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
@@ -1997,7 +1995,7 @@ static void fdctrl_format_sector(FDCtrl *fdctrl)
     if (cur_drv->blk == NULL ||
         blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
                    BDRV_SECTOR_SIZE, 0) < 0) {
-        FLOPPY_DPRINTF("error formatting sector %d\n", fd_sector(cur_drv));
+        warn_report("error formatting sector %" PRIu32, fd_sector(cur_drv));
         fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM | FD_SR0_SEEK, 0x00, 0x00);
     } else {
         if (cur_drv->sect == cur_drv->last_sect) {
@@ -2421,13 +2419,13 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint32_t value)
             cur_drv = get_cur_drv(fdctrl);
             if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
                            BDRV_SECTOR_SIZE, 0) < 0) {
-                FLOPPY_DPRINTF("error writing sector %d\n",
-                               fd_sector(cur_drv));
+                warn_report("error writing sector %" PRIu32,
+                            fd_sector(cur_drv));
                 break;
             }
             if (!fdctrl_seek_to_next_sect(fdctrl, cur_drv)) {
-                FLOPPY_DPRINTF("error seeking to next sector %d\n",
-                               fd_sector(cur_drv));
+                warn_report("error seeking to next sector %" PRIu32,
+                            fd_sector(cur_drv));
                 break;
             }
         }
-- 
2.21.3


