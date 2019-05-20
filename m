Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B20C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4552171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4552171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43415 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrYB-0004s7-2A
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQY-0006y9-1M
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQW-0007uW-Ij
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:42 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:40791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQW-0007tv-Ev
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:40 -0400
Received: by mail-qt1-f180.google.com with SMTP id k24so18365919qtq.7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=voePSIxqf20B3MWBtRpLvFwWOODzNWBdVt83CkIEzBU=;
	b=AeC3TjmkaeieCh8rV3m7tdaH6rMdAg8petDzKHLWOliYmtF3EN3gyBCDglp59wqeTR
	F+a6QIfi1NRfTof2a7VWPnNG/GVfshUAT5nhq5Poh4phTyrD7l2+9rj3qAF1ODTvf7uw
	e800DaORFnvjPOn1rYB+RWDtwP+gjgGtsFwZzRnsT/AT+C2KzfEYjwC1Zvii+xGMDYeG
	tdwqT6Z70/DKLCVjj/FFbesKxncJCccdYPXhEdF7Za99Si41at+AJYxkICZ+cxi9zPVs
	Dfe1V8R4KS9M5d05KtCxwpS8aNLLqyIh+UrMEwB755IRKOojkEcdnWnurcrg6jZ9b6WY
	iV5A==
X-Gm-Message-State: APjAAAVCC1o32YZKWd24pCWqqpwVAWg20Hd+G7jN0VWl9wcUEQ8Yw6m9
	dGHi4I6m6e8DekwyIFcIbtFfh+dhVRw=
X-Google-Smtp-Source: APXvYqwKxfQfie6xRNkvxHhPVivYonvvtevjxvoa69fTkKwMCdMGj5ccW3wcLGItNHXwndNVLH54NA==
X-Received: by 2002:ac8:5399:: with SMTP id x25mr63856797qtp.147.1558393838669;
	Mon, 20 May 2019 16:10:38 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	s28sm12290266qtc.81.2019.05.20.16.10.37
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:37 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-3-xieyongji@baidu.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.180
Subject: [Qemu-devel] [PULL v2 05/36] virtio: Use started flag in
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
Message-ID: <20190520231036.FAX6XPS8NSb-B4PBf0XUMWur5V0iVVlTirkbZSdqRFY@z>

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
index 5d533ac74e..4805727b53 100644
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


