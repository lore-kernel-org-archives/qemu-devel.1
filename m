Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21113C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BB52064C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkCtbHku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BB52064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueMZ-0000Cd-Om
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrQ-00053K-T1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrP-0003SD-Oz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrP-0003Ps-Ii
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:27 -0500
Received: by mail-wm1-x332.google.com with SMTP id q9so2635473wmj.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+U+IhI9S2shiMvtu75gJowqZ/s3WgewzmHW03jb/rC4=;
 b=XkCtbHkuWGN/UMK5R4mByTDuNLFXQnpP1hKyudOLDUPAlHjV3lYPfjQyFVXuyZENNr
 Wo++6EkWtjXbO5UrjRBnVVj3PwpE+AAJuj3KiQ56k3IZ1AgPIphVtzoIS1YAAhnguiV4
 Mi9XwoBZDEMIN0FkJNSMmCwI7OR/00Kd01pWVepo76XvP6/+qT0e7hhI1OM86aorNwqp
 mtSsLBqKla92VyijvS8hjFjFIZ+fB8jxV5PWJSWFn6OpepUg+fEYFi7Hf0t8kI2iX9Lv
 5SL3+TvL1gykIqrU0fml6gBgdsJSeEN0w/4cNbt+UzV9nScJ+TiacbpbthVSsM9+MmGT
 b68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=+U+IhI9S2shiMvtu75gJowqZ/s3WgewzmHW03jb/rC4=;
 b=l2smaxIgTbHJCYZyBrDe5nKEa00pp5OhP0rZLXgso1JxFqlNPi0CNtGz1nsZmsYTJE
 ObueWORHPabJRraSOaMWrvDgezVQ9Cri4l2NFXZfWH5WlffHb5Ho/oWFabuDtF7z7uj2
 1F+XEWoPfIraBPB6rQksK3+K/6GsdrM2f7ocgo1CpPZn36Xrsz5+jdKFFTr9DHyvJm34
 45YQmM3WhcGqHP6cUuWtyKYa9shGAUs5flEgJPhmA0GBL1ul1e4sXZmyCb2YRpLQ/mpT
 IFcp6dP8g1mzE7rJlVsc+PjzGZK4NS0OerUbBiGvrxt59+/Fejj9hakCd35jZaiY/spZ
 H9IA==
X-Gm-Message-State: APjAAAW3QJVmSvUtjYS8WrSbeTyK/0lVWQT2fGTigZlVAzwLO+DjfnmZ
 3oOUPme5Yr6AueI9O17Sttpo9XUL
X-Google-Smtp-Source: APXvYqxvtoehS1A+AMWeedPNn6Sjr/W437HQSZVz8NYb4nDK4unxNP+7yiE01GRXOeVUtjqzB/9cmA==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr4455975wmo.48.1579787366368; 
 Thu, 23 Jan 2020 05:49:26 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/59] virtio-scsi: convert to new virtio_delete_queue
Date: Thu, 23 Jan 2020 14:48:25 +0100
Message-Id: <1579787342-27146-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Use virtio_delete_queue to make it more clear.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200117075547.60864-3-pannengyuan@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 858b3aa..d3af42e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -945,10 +945,10 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     int i;
 
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vs->ctrl_vq);
+    virtio_delete_queue(vs->event_vq);
     for (i = 0; i < vs->conf.num_queues; i++) {
-        virtio_del_queue(vdev, i + 2);
+        virtio_delete_queue(vs->cmd_vqs[i]);
     }
     g_free(vs->cmd_vqs);
     virtio_cleanup(vdev);
-- 
1.8.3.1



