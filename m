Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D98C742CA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383E020863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383E020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxbz-0001FA-14
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hlxbL-0007A6-Nn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hlxbK-0003tE-JC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:36:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hlxbK-0003sT-DJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:36:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89E9230C62A9;
 Fri, 12 Jul 2019 15:36:45 +0000 (UTC)
Received: from redhat.com (ovpn-116-209.ams2.redhat.com [10.36.116.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 361E85DE82;
 Fri, 12 Jul 2019 15:36:41 +0000 (UTC)
Date: Fri, 12 Jul 2019 11:36:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190712073554.21918-3-pagupta@redhat.com>
References: <20190712153504.14937-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190712153504.14937-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 12 Jul 2019 15:36:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/8] virtio pmem: remove memdev null check
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
Message-ID: <20190712153641.zoK6kep8gjSxeILA76zpXVCVQpB9RsW13z630PKoMPs@z>

From: Pankaj Gupta <pagupta@redhat.com>

Coverity reports that when we're assigning vi->size we handle the
"pmem->memdev is NULL" case; but we then pass it into
object_get_canonical_path(), which unconditionally dereferences it
and will crash if it is NULL. If this pointer can be NULL then we
need to do something else here.

We are removing 'pmem->memdev' null check here as memdev will never
be null in this function.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Message-Id: <20190712073554.21918-3-pagupta@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/virtio/virtio-pmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index adbfb603ab..17c196d107 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -134,8 +134,8 @@ static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
                                          VirtioPMEMDeviceInfo *vi)
 {
     vi->memaddr = pmem->start;
-    vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
-    vi->memdev = object_get_canonical_path(OBJECT(pmem->memdev));
+    vi->size    = memory_region_size(&pmem->memdev->mr);
+    vi->memdev  = object_get_canonical_path(OBJECT(pmem->memdev));
 }
 
 static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
-- 
MST


