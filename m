Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035A0C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CC220665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK8x2Zr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CC220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmy9N-0000sz-Rw
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hmy98-0000Ig-D7
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hmy97-00081p-H5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:23:50 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hmy97-00080i-BB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:23:49 -0400
Received: by mail-pl1-x641.google.com with SMTP id ay6so8064928plb.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7p2G/91PqJ8RuOo5lhHUra5YVPwP+D+LVK4urSQ4OpA=;
 b=bK8x2Zr8/rJFONtuAaOfrtOkNr+LN0fAHst74lyaoE/b4xJoshc32toRLNjbp7t4b+
 fR53E6LnIEU91KEH/9bNUCIUCkFeIBLGNtI/5PlrzRNqns85E9HDpzd0D/GKUzqkRS3C
 /2LRkWsDx9ZeZcbSGssQm7/2Jg/1xvs37r5qx9m/83+bzVu7N5aAZxf3Ma1CBaVpAYot
 PsKkszco34qXXLlMQphUIJG0hyHboF50ZAFjCHYidCTUkd9rUE7KVaeX6V/KJ/f82Wjv
 3H03CVi2ZZZiWBhcztYJIDxUZIXirtXUfLxUKLfqZVxWscHLZYzXLsBkVP7X7QnILPuH
 ooUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7p2G/91PqJ8RuOo5lhHUra5YVPwP+D+LVK4urSQ4OpA=;
 b=SCHnylV0bVnPnfc9VOvEO/PlyKyj2T3/DaGc4iWQaw31nybpDJO9ZFWDTAKhpcC5au
 4+PrlJxnOGGrZjqOJafMRk0NG5MPYoWmkKIvvw40f4FynnFNfeiVke7ZdvVyQpnEZwbG
 0Qcr7SMvOd0rhPJzApk6s1om+mMG01nDRv8jIKkIai+rWHvSim1VblOaJfwxyL1udcHO
 RpzqgZNN9rrPPZjJyOZJkjdktpz7HxFHPjSWTSDDSMVW4nifwlW9JSeQGi+JDXZuDsu0
 O0ZvMTVc+27+CnflDHLUPhWuhMx4r6lbzIj0xRpkTWec3bWdmq/t3aow/ONn9hLQOHNE
 ny7w==
X-Gm-Message-State: APjAAAWrJo0Pcw44sMNWujN6rSqtVWmXcoM5/tW0RlV0r3WgFfXnLmN/
 GD0eW5QkKj6qITHS5i+u/T0=
X-Google-Smtp-Source: APXvYqw9SB3SBYrMcDya6hs0EDVcdlmoLhSkZ6Jbt01rgAl+Zm4S0dJYhRxYG4WEYGb3zPHVuB2VHg==
X-Received: by 2002:a17:902:6b85:: with SMTP id
 p5mr25069625plk.225.1563186227723; 
 Mon, 15 Jul 2019 03:23:47 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id m9sm31381908pgr.24.2019.07.15.03.23.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Jul 2019 03:23:47 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, fam@euphon.net
Date: Mon, 15 Jul 2019 18:23:25 +0800
Message-Id: <20190715102326.2805-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 1/2] vhost-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

This avoids memory leak when device hotplug is failed.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/scsi/vhost-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 4090f99ee4..db4a090576 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -210,7 +210,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         if (err) {
             error_propagate(errp, err);
             error_free(vsc->migration_blocker);
-            goto close_fd;
+            goto free_virtio;
         }
     }
 
@@ -240,6 +240,8 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         migrate_del_blocker(vsc->migration_blocker);
     }
     g_free(vsc->dev.vqs);
+ free_virtio:
+    virtio_scsi_common_unrealize(dev, errp);
  close_fd:
     close(vhostfd);
     return;
-- 
2.17.1


