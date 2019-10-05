Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64735C4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FE320862
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FE320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsUV-0004QY-P1
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs60-0005oT-HV
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5z-0004fX-6i
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5y-0004ea-Ug
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:11 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C5588E3C0
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 22:00:10 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id 10so10686909qka.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 15:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L6COg8vHdvYRIvqPWLhLuhWyNWi99JbdUCTQsLNAmdA=;
 b=EyRtF4oP4AxpIc2aYLCkc3BZJo27GC2PQ8wD9FLSz87yAslZjcTyA+laaqlTkIsPD+
 oZTh9B+Szm5pdHvV5fSlfW4Zaywx6e2KNW6tARMmebfDCoL+jVFbaSsx7d8UXEt9QFvG
 K97Vyu8W4AnA59C0N0Qp6gUruut10qnxD3xX2bXaZRHE2Oj0oKx4EmrXiIB8c5fM6jNA
 TIlE6JcqeY6piH9ZHHGBRFU/+POqbwRTYanjsF18PxMZ7jlx8OvUoG4ZcwRTyS0xi+Fs
 348K2E4jFN6H4A7T6HoUGM03UE6lwYG7e0lCwW7njIG3APSaS0tGlt8sw0+ckqqh0J9r
 9pig==
X-Gm-Message-State: APjAAAWKfaK4q5EX/0jExf+d+SVyNGfau9XcfgVg00tGDD2qJUh29mcx
 iV43Zkv8GLjOHoCmpEPiFWjACWeuQ3nXjVEdwvOUKmUviFnzSAgv2YgJlv5izrIw3RNT/FuA/oQ
 SVl0CroIuYxT5QrE=
X-Received: by 2002:a0c:e785:: with SMTP id x5mr21044863qvn.71.1570312808627; 
 Sat, 05 Oct 2019 15:00:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynJXnNx6EEeUDxQU2Q527xQmKnx8fDuY/Tr3qccFMZi7T9XFbN2MgW8IWzYwG9bXzWx6zZHg==
X-Received: by 2002:a0c:e785:: with SMTP id x5mr21044851qvn.71.1570312808341; 
 Sat, 05 Oct 2019 15:00:08 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 t17sm8512542qtt.57.2019.10.05.15.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 15:00:07 -0700 (PDT)
Date: Sat, 5 Oct 2019 18:00:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] virtio: Add virtio_fs linux headers
Message-ID: <20190930105135.27244-2-dgilbert@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Miklos Szeredi <mszeredi@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005220003.D7TNsLc_uDE6_PF-PQRK1T2NbCaysdgafVCE7gs_Buw@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pull in the virtio_fs.h linux header and the constant for the virtiofs
ID; by running scripts/update-linux-headers.sh against
Linus's tree 97f9a3c4eee55b0178b518ae7114a6a53372913d.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Message-Id: <20190930105135.27244-2-dgilbert@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/linux/virtio_fs.h  | 19 +++++++++++++++++++
 include/standard-headers/linux/virtio_ids.h |  2 ++
 2 files changed, 21 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_fs.h

diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-headers/linux/virtio_fs.h
new file mode 100644
index 0000000000..9d88817a6b
--- /dev/null
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
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
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
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
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
MST


