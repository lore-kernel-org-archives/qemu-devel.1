Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1E2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9526214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9526214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAG1P-0004SU-AS
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iAFue-00008F-C1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iAFuc-0004va-Tu
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iAFuc-0004vM-Lu
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 045068667D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 16:01:06 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-53.ams2.redhat.com
 [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE576012E;
 Tue, 17 Sep 2019 16:01:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	cohuck@redhat.com,
	mst@redhat.com
Date: Tue, 17 Sep 2019 17:00:55 +0100
Message-Id: <20190917160057.11847-2-dgilbert@redhat.com>
In-Reply-To: <20190917160057.11847-1-dgilbert@redhat.com>
References: <20190917160057.11847-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 17 Sep 2019 16:01:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/3] virtio: Add virito_fs linux headers
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
Cc: mszeredi@redhat.com, vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pull in the virtio_fs.h linux header and the constant for the virtiofs
ID.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/standard-headers/linux/virtio_fs.h  | 41 +++++++++++++++++++++
 include/standard-headers/linux/virtio_ids.h |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_fs.h

diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standar=
d-headers/linux/virtio_fs.h
new file mode 100644
index 0000000000..00bd7a6fa7
--- /dev/null
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -0,0 +1,41 @@
+#ifndef _LINUX_VIRTIO_FS_H
+#define _LINUX_VIRTIO_FS_H
+/* This header is BSD licensed so anyone can use the definitions to impl=
ement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this softw=
are
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS `=
`AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
+ * SUCH DAMAGE. */
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
index 32b2f94d1f..73fc004807 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,6 +43,7 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
--=20
2.21.0


