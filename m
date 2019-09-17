Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6239C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB63721881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63721881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFE6-0006ks-DT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8S-0002r1-JP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF8R-0000Vt-AX
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF8R-0000Ve-1q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:19 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A0DD8553D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:11:18 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id b67so4582009qkc.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z+GrB4OsuKWsPCn93GzyHPdMpDZ0x8xOsHVIaXoGtYw=;
 b=etmGLb0Lyb0BFK6lJ0yyzxF4RUxcD3V6z8ahoNhjVgJFfS06w6TAGwM0A4/IQQp42C
 /y5o8HEai7aSe6OFz9jnBLJCOmOGgPnDSEHoVdFTC3V/+tX9mvOXEXQRly1jW4GEQQ1z
 jtysuZFA2Lum5z2A7sTvlhzurllSzHvGzqYyiOdIbsL+RsQWA8zpSEe5YLJqNvIcg7du
 hpyKQVysMXZxKOXhU4l9crYgmanFXpTAfSuCfWD66me8wQ7jQtg6tmXCPPVIzZ13/K28
 2hmU6hmGaokBXW+5y9d8wtvb9ocJLwTzqnjCx4usEwxU1KIZaNtrdnyKwzbb1zZdcplp
 GAng==
X-Gm-Message-State: APjAAAWk9VmTnppZOc3c5QSJSXMRSRqIReyaw7dn/89AjgT2UdwbSo1p
 ykhdunlmfSyJn/puaHSSycVsuz58feCVnuRRwNC9WQZOQ5t8Rgt74AVnyzryOw0NQG0cO10FmDO
 PKaGi3C7pSL11FWk=
X-Received: by 2002:aed:208e:: with SMTP id 14mr4098951qtb.199.1568733077302; 
 Tue, 17 Sep 2019 08:11:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqytwd4w7rUw8gmpUNTcX9Ba+UYBFdr1yNI9tXtx1sByE8efBh/Q1slnfHa8u4uOhnDEUGcaZg==
X-Received: by 2002:aed:208e:: with SMTP id 14mr4098923qtb.199.1568733077094; 
 Tue, 17 Sep 2019 08:11:17 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id v5sm1529227qtk.66.2019.09.17.08.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:11:16 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:11:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190821121624.5382-1-pagupta@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/10] virtio pmem: user document
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Pankaj Gupta <pagupta@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151113.bPpt7GYbdbtvLOpN3KQ6aOn_sXRojXyHFTvGi4BOBlo@z>

From: Pankaj Gupta <pagupta@redhat.com>

This patch documents the steps to use virtio pmem.
It also documents other useful information about
virtio pmem e.g use-case, comparison with Qemu NVDIMM
backend and current limitations.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Message-Id: <20190821121624.5382-1-pagupta@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/virtio-pmem.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 docs/virtio-pmem.rst

diff --git a/docs/virtio-pmem.rst b/docs/virtio-pmem.rst
new file mode 100644
index 0000000000..e77881b26f
--- /dev/null
+++ b/docs/virtio-pmem.rst
@@ -0,0 +1,75 @@
+
+========================
+QEMU virtio pmem
+========================
+
+ This document explains the setup and usage of the virtio pmem device
+ which is available since QEMU v4.1.0.
+
+ The virtio pmem device is a paravirtualized persistent memory device
+ on regular (i.e non-NVDIMM) storage.
+
+Usecase
+--------
+
+  Virtio pmem allows to bypass the guest page cache and directly use
+  host page cache. This reduces guest memory footprint as the host can
+  make efficient memory reclaim decisions under memory pressure.
+
+o How does virtio-pmem compare to the nvdimm emulation supported by QEMU?
+
+  NVDIMM emulation on regular (i.e. non-NVDIMM) host storage does not
+  persist the guest writes as there are no defined semantics in the device
+  specification. The virtio pmem device provides guest write persistence
+  on non-NVDIMM host storage.
+
+virtio pmem usage
+-----------------
+
+  A virtio pmem device backed by a memory-backend-file can be created on
+  the QEMU command line as in the following example:
+
+  -object memory-backend-file,id=mem1,share,mem-path=./virtio_pmem.img,size=4G
+  -device virtio-pmem-pci,memdev=mem1,id=nv1
+
+   where:
+   - "object memory-backend-file,id=mem1,share,mem-path=<image>, size=<image size>"
+     creates a backend file with the specified size.
+
+   - "device virtio-pmem-pci,id=nvdimm1,memdev=mem1" creates a virtio pmem
+     pci device whose storage is provided by above memory backend device.
+
+  Multiple virtio pmem devices can be created if multiple pairs of "-object"
+  and "-device" are provided.
+
+Hotplug
+-------
+
+Virtio pmem devices can be hotplugged via the QEMU monitor. First, the
+memory backing has to be added via 'object_add'; afterwards, the virtio
+pmem device can be added via 'device_add'.
+
+For example, the following commands add another 4GB virtio pmem device to
+the guest:
+
+ (qemu) object_add memory-backend-file,id=mem2,share=on,mem-path=virtio_pmem2.img,size=4G
+ (qemu) device_add virtio-pmem-pci,id=virtio_pmem2,memdev=mem2
+
+Guest Data Persistence
+----------------------
+
+ Guest data persistence on non-NVDIMM requires guest userspace applications
+ to perform fsync/msync. This is different from a real nvdimm backend where
+ no additional fsync/msync is required. This is to persist guest writes in
+ host backing file which otherwise remains in host page cache and there is
+ risk of losing the data in case of power failure.
+
+ With virtio pmem device, MAP_SYNC mmap flag is not supported. This provides
+ a hint to application to perform fsync for write persistence.
+
+Limitations
+------------
+- Real nvdimm device backend is not supported.
+- virtio pmem hotunplug is not supported.
+- ACPI NVDIMM features like regions/namespaces are not supported.
+- ndctl command is not supported.
-- 
MST


