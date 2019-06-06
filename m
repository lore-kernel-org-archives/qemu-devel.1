Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A66C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC490207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC490207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqPu-0001SQ-03
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:18:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFd-0000d2-E9
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFc-00042R-Au
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFU-0003nF-Ly; Thu, 06 Jun 2019 07:08:00 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MxVbb-1gbVHP18Jd-00xp3V; Thu, 06 Jun 2019 13:06:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:21 +0200
Message-Id: <20190606110625.32127-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tp+rYBTeSmojRMJaBdyBwiM6HZA7HXAoWJTNrbm/XbfsIZGyr5c
	bFYNMuwa8UFRYcuI0xeaWvVMG6ikGk+Tabzw/180r2IsFGYPc9kGQnqkFYJr3vvoCyA2Hmc
	O/SFmaoC+qo6bhpQJNqtzbQI16lQV2XRXTH8vDtSVLfm/gsHc9Oa1EXXSd9Ac/+2w6KOU9R
	AfXaqJjyRtyWkTYfZ0EpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UNc6Ohb4JzQ=:yLxa3ypR43F8VyTpKGx8Hz
	dDldjE5xQnZPw0Fr9CbW6skDAsDFZckP05CZoGNm0A4B8DhI0oW/K2uj3y9TPCkto3sFLTJFS
	24vU6c/aVrik6hAec0EUbP/npG2hpttLjzrSiiEFLPgIsHSZz9tnLEq02Fyi9+AC7LamlgL8w
	iYMjNI43aEaHJ690EAWQXeU5zaUrH/rPh8XGxcPm+imaw1jFf8q2nckH1SHg6dbbdLaoBZfHh
	raxNvD1/YvwTtFk79ElS5PvIasEI/XlL3NvxqhLVNICsHwmX+bKnS6xx1/n4mqLBuDNTwUwWT
	eO9ZzAAwJxsk4lYdR17r2CwM2zaZVB+gmHOA8axs1Q9kcYPEgAh6bExU6aH9olCJnorA+x8OD
	atycWsH7UsSvMRv2mFd3SzQwOMGeH+VBj8jKgWjfcnLYfepxvXg2I+brl/ACHigfLFw8mnhSk
	8fRxLEdVDchrQbNAFWN4DM3oxjyq5icy4GUGf3LFQHU5LvB/wh/F+uI0iHDJeDuhTQWLCu64c
	U+emYNHRcolYJqumF2AMK4cfkW6aN/Z1KZO609s0n83x3fKKTlRIpP/r6oRnK48EprgWAOSzr
	/XWF5gcQ+rVeNoJuYU+Xo6oICNNhtI63eVVNBsnoqNDdDasPDsid1Aerdg1AFmsKWKdiKVpih
	K5CKbsDT0WnkHrQb32/08g7WX3ru4WlJsqinxgIU4Vk6ZDsGJUjpU8x6AXyAFrxkvLIthpqc/
	azZ7K1eMvzsAYX+1Wlv5lprGNq8rRlSBYbfwZVli2gl4bmmNhDp1jMFldDs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 12/16] hw/vfio/pci: Use the QOM DEVICE() macro
 to access DeviceState.qdev
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
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Rather than looking inside the definition of a DeviceState with
"s->qdev", use the QOM prefered style: "DEVICE(s)".

This patch was generated using the following Coccinelle script:

    // Use DEVICE() macros to access DeviceState.qdev
    @use_device_macro_to_access_qdev@
    expression obj;
    identifier dev;
    @@
    -&obj->dev.qdev
    +DEVICE(obj)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <20190528164020.32250-10-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8e555db12ec0..2a4091d216e2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2717,7 +2717,7 @@ static void vfio_req_notifier_handler(void *opaque)
         return;
     }
 
-    qdev_unplug(&vdev->pdev.qdev, &err);
+    qdev_unplug(DEVICE(vdev), &err);
     if (err) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
@@ -2839,7 +2839,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vdev->vbasedev.name = g_path_get_basename(vdev->vbasedev.sysfsdev);
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
-    vdev->vbasedev.dev = &vdev->pdev.qdev;
+    vdev->vbasedev.dev = DEVICE(vdev);
 
     tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
-- 
2.21.0


