Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807CAC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C38A20735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="B9kLgXi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C38A20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNDp-0000Os-B7
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jGFe4-0007jz-Vs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 01:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jGFe3-0001UJ-IP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 01:29:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jGFe3-0001TS-6K
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 01:29:03 -0400
Received: by mail-pg1-x544.google.com with SMTP id d17so6049883pgo.0
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:to:cc:subject:date:message-id
 :content-transfer-encoding;
 bh=rn1rzPyZjU/1uasX4nLAsRBp6Z3yrACVS7w/C5ZCX9E=;
 b=B9kLgXi3vNJYNNkLfWhZnzynGcZLN8KTTOi8S+uISLsDOJcRwitaSnkEzROIMMeoLG
 58xy7wUshKtDWX0p3yk9rEFKtVu5tpJ6BANPa/D7Mxg9uDZce6unDBjZsxeRgr17ZmOu
 KmV7mLqlJLXMRbzmbgSR9gILYafA3hHaoxYmR5g5/w4UHDEM06P2ekTmi+xfxg9BdFmF
 NTx8fYak39FQyEcLGEV8F9X5/gUjkgikmgZyoXSQYhHUwXXZmH+cwKezXB3t/lDZj+1E
 0sJRbXvJy79ovmcsYirW4KiOYN10y+A5A7jQxr18/Am1cps9juRk/ZRP50aazcjJJ6NQ
 sWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :content-transfer-encoding;
 bh=rn1rzPyZjU/1uasX4nLAsRBp6Z3yrACVS7w/C5ZCX9E=;
 b=gD8qNpjyNB3a9xyA7D5EizXFF7KPkEphL1EaO6eh7akbMiKhViIbeYhwCRaq+GPP7J
 KwaLX4NInBFJuSHHkgeuXxJPuvu39nuphWBO8SHSCXZxWfm9yujdSiZLnR9/h0Qsxy2U
 iD5tZclcLk2u3QgSdpPCaBGsliJc1T7tfpKY2gcLq/XgzM/O/hDdcXMXDJ7JnCcWmWlZ
 +VGr6C3NOSZZeKSI2HmwYTQnOL4G8EwRmR8mcTUnKcVmh0YQTvgagTW9FAEqeTTus4nR
 jyo8+3KVJNC5REZsxGnj77/YgVHOpsWccNtBU0Y6ameGLsaImtVt9h1aPhKtJ5dgommG
 vI8A==
MIME-Version: 1.0
X-Gm-Message-State: ANhLgQ20QCZKqtRCMMJrkdFsGnAFoUieAbfHgi2em7nUzf8t8PGvEKmn
 +FluWJPE3aGpnhPbRbn41Ya9aYQdPIhv39Q9mOzpwr/VOYShGGOr/ZsnJmsRxgRkkuMjpcg8JbH
 OCRXduEEW
X-Google-Smtp-Source: ADFU+vv8MuenS8R5ry2qx46wBcwxJrWPxc3S3Nn2FVeAf73oMUwG6iP99FeBCSokK4B8UY/nHoPA8A==
X-Received: by 2002:aa7:8f3a:: with SMTP id y26mr22191464pfr.180.1584941341253; 
 Sun, 22 Mar 2020 22:29:01 -0700 (PDT)
Received: from 31_216.localdomain ([47.75.244.237])
 by smtp.gmail.com with ESMTPSA id o14sm7905195pfh.147.2020.03.22.22.28.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 22 Mar 2020 22:29:00 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] fix vhost_user_blk_watch crash
Date: Mon, 23 Mar 2020 13:29:24 +0800
Message-Id: <20200323052924.29286-1-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
X-Mailman-Approved-At: Mon, 23 Mar 2020 09:32:41 -0400
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

the G_IO_HUP is watched in tcp_chr_connect, and the callback
vhost_user_blk_watch is not needed, because tcp_chr_hup is registered as
callback. And it will close the tcp link.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c          | 19 -------------------
 include/hw/virtio/vhost-user-blk.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 12925a47ec..17df5338e7 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -349,18 +349,6 @@ static void vhost_user_blk_disconnect(DeviceState *dev=
)
     vhost_dev_cleanup(&s->dev);
 }
=20
-static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
-                                     void *opaque)
-{
-    DeviceState *dev =3D opaque;
-    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
-    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
-
-    qemu_chr_fe_disconnect(&s->chardev);
-
-    return true;
-}
-
 static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 {
     DeviceState *dev =3D opaque;
@@ -373,15 +361,9 @@ static void vhost_user_blk_event(void *opaque, QEMUChr=
Event event)
             qemu_chr_fe_disconnect(&s->chardev);
             return;
         }
-        s->watch =3D qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
-                                         vhost_user_blk_watch, dev);
         break;
     case CHR_EVENT_CLOSED:
         vhost_user_blk_disconnect(dev);
-        if (s->watch) {
-            g_source_remove(s->watch);
-            s->watch =3D 0;
-        }
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
@@ -428,7 +410,6 @@ static void vhost_user_blk_device_realize(DeviceState *=
dev, Error **errp)
=20
     s->inflight =3D g_new0(struct vhost_inflight, 1);
     s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
-    s->watch =3D 0;
     s->connected =3D false;
=20
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_even=
t,
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-u=
ser-blk.h
index 05ea0ad183..34ad6f0c0e 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -38,7 +38,6 @@ typedef struct VHostUserBlk {
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vqs;
     VirtQueue **virtqs;
-    guint watch;
     bool connected;
 } VHostUserBlk;
=20
--=20
2.11.0


--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=B1=BE=D3=CA=CF=E4=CE=AA=B1=B1=BE=A9=D6=BE=C1=E8=BA=A3=C4=C9=BF=C6=BC=BC=D3=
=D0=CF=DE=B9=AB=CB=BE=A3=A8SmartX=A3=A9=B9=A4=D7=F7=D3=CA=CF=E4. =C8=E7=B1=
=BE=D3=CA=CF=E4=B7=A2=B3=F6=B5=C4=D3=CA=BC=FE=D3=EB=B9=A4=D7=F7=CE=DE=B9=D8=
,=B8=C3=D3=CA=BC=FE=CE=B4=B5=C3=B5=BD=B1=BE=B9=AB=CB=BE=C8=CE=BA=CE=B5=C4=
=C3=F7=CA=BE=BB=F2=C4=AC=CA=BE=B5=C4=CA=DA=C8=A8.



