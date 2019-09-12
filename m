Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B8C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 18:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B1D2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 18:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B1D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8U1r-0005ZN-9s
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 14:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1i8U0p-0004Lw-MD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1i8U0o-0003AM-LE
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:40:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1i8U0o-0003AF-FP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:40:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB75F19D381;
 Thu, 12 Sep 2019 18:40:09 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2AFC5D704;
 Thu, 12 Sep 2019 18:40:04 +0000 (UTC)
Date: Thu, 12 Sep 2019 15:41:46 +0100
From: Alex Williamson <alex.williamson@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Message-ID: <20190912154146.64f82358@x1.home>
In-Reply-To: <95584103-950c-2870-b0a1-1108d54190f2@huawei.com>
References: <95584103-950c-2870-b0a1-1108d54190f2@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 12 Sep 2019 18:40:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] hw/vfio/pci: duplicated invocation of
 vfio_msix_vector_release() in vfio_msix_disable()
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
Cc: wanghaibin 00208455 <wanghaibin.wang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 19:01:22 +0800
Guoheyi <guoheyi@huawei.com> wrote:

> Hi folks,
> 
> Recently we found there are 2 invocations of vfio_msix_vector_release() 
> in vfio_msix_disable(). The 1st one is in msix_unset_vector_notifiers(), 
> for we set device's msix_vector_release_notifier to 
> vfio_msix_vector_release() in vfio_msix_enable(), while the 2nd is the 
> explicit one in vfio_msix_disable(). Both invocations switch VFIO to use 
> the non-bypass eventfd.
> 
> Is there any special reason for doing this? Or can we remove one of them?

The comment certainly suggests there is, and git blame trivially finds:

commit 3e40ba0faf0822fa78336fe6cd9d677ea9b14f1b
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Fri Dec 6 11:16:40 2013 -0700

    vfio-pci: Release all MSI-X vectors when disabled
    
    We were relying on msix_unset_vector_notifiers() to release all the
    vectors when we disable MSI-X, but this only happens when MSI-X is
    still enabled on the device.  Perform further cleanup by releasing
    any remaining vectors listed as in-use after this call.  This caused
    a leak of IRQ routes on hotplug depending on how the guest OS prepared
    the device for removal.
    
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
    Cc: qemu-stable@nongnu.org

diff --git a/hw/misc/vfio.c b/hw/misc/vfio.c
index f367537737d2..9aecaa82bc34 100644
--- a/hw/misc/vfio.c
+++ b/hw/misc/vfio.c
@@ -905,8 +905,20 @@ static void vfio_disable_msi_common(VFIODevice *vdev)
 
 static void vfio_disable_msix(VFIODevice *vdev)
 {
+    int i;
+
     msix_unset_vector_notifiers(&vdev->pdev);
 
+    /*
+     * MSI-X will only release vectors if MSI-X is still enabled on the
+     * device, check through the rest and release it ourselves if necessary.
+     */
+    for (i = 0; i < vdev->nr_vectors; i++) {
+        if (vdev->msi_vectors[i].use) {
+            vfio_msix_vector_release(&vdev->pdev, i);
+        }
+    }
+
     if (vdev->nr_vectors) {
         vfio_disable_irqindex(vdev, VFIO_PCI_MSIX_IRQ_INDEX);
     }

