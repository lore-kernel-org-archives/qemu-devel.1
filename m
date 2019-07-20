Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD348C76196
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCB02084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joaipStD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCB02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hor8w-0007Vt-Cc
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8R-0005oH-9D
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8Q-00085d-42
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8P-000858-U0
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id c2so31816173wrm.8
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQLl5pe9XLgrjyvZkhfrZn2lNfT/vPI403Fp6t7gA2M=;
 b=joaipStDf5rp95HabufaQ3UIZCkLx+jsndLAci9cYg1T3aclvb/VXFpX/bqfZNTuNk
 n6ORjfUhM8wf46HuLBiGfab6E2esukD4zzK9g28pUHX8H7VaTPl7mBE2eS9ZS6ytRNAt
 H9iGHw2A4KLAgWywAXW7tu0BIFy/g+C+Y0fw4Cv5sys25Q9edx6/EMMH8C5/v+47exHf
 UoBQvDAtFjHpIDxYmWhLl2a3LIYaWivoPqMBMpJlu0GVHGq5cx5Z+kEf/mkQGLfsIhZD
 nVyQzNjoBEgFhHzzI85RxGb099oO7CdvXzJfjCqoRurK58Pd+E+naoCFpb26taoNOkuU
 18FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SQLl5pe9XLgrjyvZkhfrZn2lNfT/vPI403Fp6t7gA2M=;
 b=X2dBiAODLRgNVK0RUAca1XcdXnoNMm+sDF/ncSABX+JBD2c2ByCp1qoU1p5KEwwrVn
 btjcSGVSM6cXvZxt+c/6jg6dvdFIpqjehVVZJRJuqLjKT4J3M3PZ7olGh+jzypy2CWjc
 02HxHMiuAmdDgH43JtbPdLRhiDJRThcO4RWbE1CEsOSi0997QRALsioVQ/9eCgJ8gOvU
 aUb98wruxYmKq3xhV72/xm2/pu9tQHgNTSRPscgmKHE6Tbm1ZsgdlXVCdp+a7GE5fxCr
 yhVSDpMWzUWCYwGfe5vLjMbawwUIdsXp/6Tek2nguodRghnvSO3/0s2BTKY3TRezzhLO
 ZRvw==
X-Gm-Message-State: APjAAAWDhbYnx4FfeKsu2SFaiYlKJy/8CU4JXJT+R08ryTQ2wmPd1vB9
 IxqeyoLXa7aGwTxyFC9tAAR070ONvZQ=
X-Google-Smtp-Source: APXvYqwEahsoqXZFULB70OGYgD877L3lTAVmB6k+zGbC4AVyWEzGUSZ60Hd2+JSjzcT3ieh5zeyKnQ==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr60874914wro.60.1563635932596; 
 Sat, 20 Jul 2019 08:18:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:37 +0200
Message-Id: <20190720151846.7450-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 03/12] virtio-scsi: remove unused argument to
 virtio_scsi_common_realize
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The argument is not used and passing it clutters error propagation in the
callers.  So, get rid of it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-scsi.c            | 2 +-
 hw/scsi/vhost-user-scsi.c       | 2 +-
 hw/scsi/virtio-scsi.c           | 4 ++--
 include/hw/virtio/virtio-scsi.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 4090f99..76bb875 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -262,7 +262,7 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
     vhost_dev_cleanup(&vsc->dev);
     g_free(vqs);
 
-    virtio_scsi_common_unrealize(dev, errp);
+    virtio_scsi_common_unrealize(dev);
 }
 
 static Property vhost_scsi_properties[] = {
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a9fd8ea..a0b69fb 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -125,7 +125,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
     vhost_dev_cleanup(&vsc->dev);
     g_free(vqs);
 
-    virtio_scsi_common_unrealize(dev, errp);
+    virtio_scsi_common_unrealize(dev);
     vhost_user_cleanup(&s->vhost_user);
 }
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 61ce365..d0bdbff 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -922,7 +922,7 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     virtio_scsi_dataplane_setup(s, errp);
 }
 
-void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp)
+void virtio_scsi_common_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -936,7 +936,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
 
     qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
-    virtio_scsi_common_unrealize(dev, errp);
+    virtio_scsi_common_unrealize(dev);
 }
 
 static Property virtio_scsi_properties[] = {
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 4c0bcdb..122f7c4 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -145,7 +145,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
                                 VirtIOHandleOutput cmd,
                                 Error **errp);
 
-void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp);
+void virtio_scsi_common_unrealize(DeviceState *dev);
 bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq);
 bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq);
 bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq);
-- 
1.8.3.1



