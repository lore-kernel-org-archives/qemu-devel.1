Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E88C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A45C2461F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A45C2461F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrX1-0000zH-Mi
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:18:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOP-0002Bs-1M
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOO-0000nP-1O
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:09 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:42188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrON-0000mP-T4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:07 -0400
Received: by mail-qt1-f179.google.com with SMTP id s15so10505583qtk.9
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=+Ua4MZswQW6oblrgifdLgsm6Vm0TDh310FALHECFhNU=;
	b=jabGmNcVCWNumbTnGx1vA3EAiHvASiUbeFb6po5B2cMtohY6WIlcijIJXlPKQHekt7
	cUWvtyZSboqe08pq9Pblu+BwxNIMoGSR+1ztcYptf0a0FG1YhPC+4mMbYnjRy9B8oJo+
	20dglrAaxD6MOhgFavWK6H6LxuxjndDF9tnsVQJy5frhGpilXZTm+UThLVaomZLuatuZ
	t8ITH19w3CaacJHX3dw4eJPXC1gI/f7ehXUTQH/gV4231tpvPz5yDncK51JXRJYa7a+O
	hMXW9E+x+Dbf7qF/rGsBDnqQBL/kEwWyUE2TdoIbO8Pu2at2NQJ81B5LMzW10HuG6kxe
	Long==
X-Gm-Message-State: APjAAAXLNXXIusDG5+FmwhSJt6oSOw7OH5293WfmxwoDmfQcVn3qtvxE
	gBpqn6i0thuhu/5bdKHVpkPN0iR67M0=
X-Google-Smtp-Source: APXvYqzoGn+XF0gXJznhgMFWnXcVBrDl2/Wr+y+tiHMBB1W6qsnrAz6awSbA46eRO6t34pg2A45l+A==
X-Received: by 2002:ac8:3613:: with SMTP id m19mr23976182qtb.193.1559585346850;
	Mon, 03 Jun 2019 11:09:06 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	n10sm4064219qtp.81.2019.06.03.11.09.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:09:06 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190416125912.44001-3-liran.alon@oracle.com>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.179
Subject: [Qemu-devel] [PULL v2 12/14] vhost-scsi: Add VMState descriptor
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
Message-ID: <20190603180904.s5YQ8OEyYZrCYFySffQZko-h1Uo18YYgWlROUQ9fKKw@z>

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


