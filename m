Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1413AC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5869208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPZ2VhFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5869208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbisZ-0000oW-T9
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hbieL-0004hV-GP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hbiZ7-0000nP-2R
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:09 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hbiZ6-0000mw-TF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so1084997pfe.11
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uXimO1fIrN/suCveCkDvGhUQ6cXgmIUR+zvZ/sjAqMA=;
 b=JPZ2VhFsJRluFjtUxMi88kSfvo4YX+asIgRqnRZfntfVdBfPUonLJGXY8+2C6zaTj/
 pu3EzrAoCZp1y/j2RkUMdpY9GYagH8UgRdLG0Nw6W/o0qELz8rTn+giJBxD4dmROZDVb
 maHECFWkeYHC/BzpaTD2cic/DuWnKufJlv3SGTRKJD7+Q9DDDmQG8SBo0b8wM09kK+xh
 FXIXUMU7FXV/tFcHCFKbqkKoPpsmLtLHUvFVAYVyHfGXrH21vdtvh9LLp93UDwLAQL+6
 DkYnl6rxkbjfNCZ48SamO9i42zGAyfXoEuxvbvMb9ew58bK2WevIsmBsl2K0nfwySx1m
 rnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uXimO1fIrN/suCveCkDvGhUQ6cXgmIUR+zvZ/sjAqMA=;
 b=JAdqxnx2EP8Wt8Hbq/7DSOQv/H7BuDdRkYzXo8MeSOJzlbaHkzSiEeKyYUXLYQxgMP
 I6ARETIEhXoMo1H8UwDoCBHkJzljAl2Tpx1p8QDpaPyiHfTUnOAnSs0boRLjYWvtcspG
 3dAeEMIURVWfTcwbYqO4Ugy1bzt6M6xIqb9xBcqUoq+zNxgsZPi4Ea3j02N5dl8n/vmo
 I3yrcF4OAeK/0l0fNKYvWlzrwTz7WVOW2FOS5JXYhoXsD/cvqjS/pBLVckDLVA6T25dL
 PofYyyI+XFSEqbPb+RdiGnFjir4GFoCY4gGNRUwB61sh4ZLIhY0cOTtQ8JyE3kbS9z8P
 SWIg==
X-Gm-Message-State: APjAAAW/du5q1Az/KpXEj6/P3m2A4S5pcTnSTi9eJXgokHNJD7oOPNYb
 9Ntg/rMDK3s/1z+JX9tcJhY=
X-Google-Smtp-Source: APXvYqw+VlBZU72y/mvqwSUeSEPehB3IAora8db+7KXnXe3oL8o2zJtQ5UsrWviP9ycV2/GXenJbtw==
X-Received: by 2002:a65:510c:: with SMTP id f12mr33622507pgq.92.1560504727855; 
 Fri, 14 Jun 2019 02:32:07 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id j8sm2134156pfi.148.2019.06.14.02.32.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Jun 2019 02:32:07 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Fri, 14 Jun 2019 17:31:18 +0800
Message-Id: <20190614093121.5580-3-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614093121.5580-1-xieyongji@baidu.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 2/5] virtio: Set "start_on_kick" for legacy
 devices
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
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@baidu.com>,
 dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

Besides virtio 1.0 transitional devices, we should also
set "start_on_kick" flag for legacy devices (virtio 0.9).

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c         | 6 ++----
 include/hw/virtio/virtio.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 19062fbb96..473881e9ec 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1212,8 +1212,7 @@ void virtio_reset(void *opaque)
         k->reset(vdev);
     }
 
-    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
-                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
+    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
     vdev->started = false;
     vdev->broken = false;
     vdev->guest_features = 0;
@@ -2325,8 +2324,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
     }
 
-    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
-                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
+    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
     vdev->started = false;
     vdev->device_id = device_id;
     vdev->status = 0;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 15d5366939..b189788cb2 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -107,7 +107,7 @@ struct VirtIODevice
     bool broken; /* device in invalid state, needs reset */
     bool use_started;
     bool started;
-    bool start_on_kick; /* virtio 1.0 transitional devices support that */
+    bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
-- 
2.17.1


