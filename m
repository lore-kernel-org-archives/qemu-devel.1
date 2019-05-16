Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E968C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D677C20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D677C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFSF-0005YP-3C
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:25:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFL3-00083p-EN
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFL0-0001E5-DQ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:21 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:42535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFL0-0001DY-Aa
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:18 -0400
Received: by mail-qt1-f174.google.com with SMTP id j53so3528537qta.9
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=HrOZwE3FDYeiNFgv3sHw3Ymz87pEo3Esn14Kx/+BhQw=;
	b=g3nvRUo+WolpxQGGmggG1K/4GnPlckuxzHxWfcdwfiUilAGf8fmwxsocKR5/VVBKIc
	EBeoZMH6M3I6aX0bEwsOWTbVOc5bBXCQIhZuE4/4KBbKyjqDaIkCyjzF/PXaJPnWAuxp
	50vdercn5Fee2XMDmNyl4XZrubVY7lJe+5Od/WcR78a3vpqP4OHep/E5bpkCz3FSjqxH
	/z8gP2tDaXBYbi5RAsUZ1hJV4w+oCqUWyVWqfH/5BQaPbcb5SDjWsxbKXz7Ay3o6UlcL
	vNg3jlNQu/dWtvM2oSLXt8h1F8yWoStMHHUv0Z5ylzzA/djzyucR0WH9P/o9yHtf+9WB
	Cf1Q==
X-Gm-Message-State: APjAAAUEemBJLc9usmjM98TJtx8P05Un35HGvGN6g4rHyLd4+LyjF6ND
	djcyMekHLLRvK9aCNXWS5oQGjbE4EC0=
X-Google-Smtp-Source: APXvYqwRV4tZXUT/qBLCC7FHoExcM8H9vOVCEVxv6SAdU+fC0hONp5AGyIImvPN0fba33Zc02iFPNA==
X-Received: by 2002:a0c:d642:: with SMTP id e2mr38994723qvj.5.1558009097408;
	Thu, 16 May 2019 05:18:17 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id 74sm2382755qta.15.2019.05.16.05.18.15
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:16 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-3-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.174
Subject: [Qemu-devel] [PULL 05/37] virtio: Use started flag in
 virtio_vmstate_change()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
	Zhang Yu <zhangyu31@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

Currently, we use DRIVER_OK status bit to check whether guest
driver has started the device in virtio_vmstate_change(). But it's
not the case for virtio 1.0 transitional devices. If migration completes
between kicking virtqueue and setting VIRTIO_CONFIG_S_DRIVER_OK, guest
may be hung. So here we use started flag to check guest state instead.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-3-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index af7b59b4ae..b8d36cd4b7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,7 +2291,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    bool backend_run = running && (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
+    bool backend_run = running && vdev->started;
     vdev->vm_running = running;
 
     if (backend_run) {
-- 
MST


