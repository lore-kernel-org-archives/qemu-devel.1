Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DAEC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC80021855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC80021855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEtLo-00089c-Fe
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iEtHP-0004Hj-Ho
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iEtHO-0003fC-9F
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iEtHO-0003em-3O
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:51:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 539EF308FC22
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 10:51:45 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0388D5D9C3;
 Mon, 30 Sep 2019 10:51:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Subject: [PATCH v4 1/3] virtio: Add virtio_fs linux headers
Date: Mon, 30 Sep 2019 11:51:33 +0100
Message-Id: <20190930105135.27244-2-dgilbert@redhat.com>
In-Reply-To: <20190930105135.27244-1-dgilbert@redhat.com>
References: <20190930105135.27244-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 30 Sep 2019 10:51:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: mszeredi@redhat.com, cohuck@redhat.com, vgoyal@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pull in the virtio_fs.h linux header and the constant for the virtiofs
ID; by running scripts/update-linux-headers.sh against
Linus's tree 97f9a3c4eee55b0178b518ae7114a6a53372913d.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/standard-headers/linux/virtio_fs.h  | 19 +++++++++++++++++++
 include/standard-headers/linux/virtio_ids.h |  2 ++
 2 files changed, 21 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_fs.h

diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standar=
d-headers/linux/virtio_fs.h
new file mode 100644
index 0000000000..9d88817a6b
--- /dev/null
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause) */
+
+#ifndef _LINUX_VIRTIO_FS_H
+#define _LINUX_VIRTIO_FS_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_types.h"
+
+struct virtio_fs_config {
+	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
+	uint8_t tag[36];
+
+	/* Number of request queues */
+	uint32_t num_request_queues;
+} QEMU_PACKED;
+
+#endif /* _LINUX_VIRTIO_FS_H */
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
index 32b2f94d1f..585e07b273 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,6 +43,8 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+#define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
--=20
2.21.0


