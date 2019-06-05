Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F0C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0822070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0822070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcII-0005C5-PX
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:13:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5Y-0003EL-Kw
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5S-0005o0-Pr
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:46 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5O-0005dU-Vl
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:39 -0400
Received: by mail-qt1-f176.google.com with SMTP id m29so18882qtu.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=+Ua4MZswQW6oblrgifdLgsm6Vm0TDh310FALHECFhNU=;
	b=ASrpd1xtDOC4tmzuEqcHBfOMXU4XzegDKFQSN8Nnf4j39QdJG9CnSacTMzq2aM69OJ
	O5dAVvwUEjqHoZ2MlxJmXSuZpcmt3VoTlJdEQ39TWFcpk6DM60HidmI4QeXe2lpkdbPI
	8DtcNCtZyiWzEs3RG/ZL3gWJI6zVCsB2FpCsdsPT6F7sU8CweuxzbuL+AXBURb/tGCbk
	n0Kbidw2w7q/5820GeY2R/eewYsc51aCbC71Gy0I+t6D9nHpR1745TTTnqy9lfnyr4Dh
	y2CqPmoiaSC5PQu6nV+E/aAQFIBA/Lxhtvq2KnDiD0bIIo9rbbUBtbIm602xVsm/B0RZ
	0Mtg==
X-Gm-Message-State: APjAAAXtTLz3pQscK8KCUQIZ8TU+bVR6h7IF7DJIqXGNgnMQUOv9vqik
	oDXJpLq/0yvzlND/aR2jkDkYO6HEmGs=
X-Google-Smtp-Source: APXvYqx0cG5W84jVUAsSyYc2nUqnzRlmTH4d28aUnFm6H/CGt6Oy/n116Rh2cz7tGbMRbW5UY1Ao+Q==
X-Received: by 2002:ac8:2318:: with SMTP id a24mr35565211qta.60.1559764836944; 
	Wed, 05 Jun 2019 13:00:36 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	m5sm13359433qke.25.2019.06.05.13.00.35
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:36 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190416125912.44001-3-liran.alon@oracle.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.176
Subject: [Qemu-devel] [PULL v3 12/17] vhost-scsi: Add VMState descriptor
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
	Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Nir Weiner <nir.weiner@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190605200035.Meocic3uRMygyixQjFsjIO7FIH2VJjTVC6jiyQyq0AU@z>

From: Nir Weiner <nir.weiner@oracle.com>

As preparation of enabling migration of vhost-scsi device,
define it’s VMState. Note, we keep the convention of
verifying in the pre_save() method that the vhost backend
must be stopped before attempting to save the device
state. Similar to how it is done for vhost-vsock.

Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Nir Weiner <nir.weiner@oracle.com>
Message-Id: <20190416125912.44001-3-liran.alon@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/vhost-scsi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ca42cff1b9..eb0cf9e131 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -139,6 +139,28 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
 
+static int vhost_scsi_pre_save(void *opaque)
+{
+    VHostSCSICommon *vsc = opaque;
+
+    /* At this point, backend must be stopped, otherwise
+     * it might keep writing to memory. */
+    assert(!vsc->dev.started);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_vhost_scsi = {
+    .name = "virtio-vhost_scsi",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+    .pre_save = vhost_scsi_pre_save,
+};
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -256,6 +278,7 @@ static void vhost_scsi_class_init(ObjectClass *klass, void *data)
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(klass);
 
     dc->props = vhost_scsi_properties;
+    dc->vmsd = &vmstate_virtio_vhost_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_scsi_realize;
     vdc->unrealize = vhost_scsi_unrealize;
-- 
MST


