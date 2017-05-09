Received: from eggs.gnu.org ([2001:4830:134:3::10]:51404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d82oL-0004c2-2M
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d82oH-0004RN-W2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d82oH-0004R8-PR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 572478047C
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 10:56:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 12:56:02 +0200
Message-Id: <1494327362-30727-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1494327362-30727-1-git-send-email-armbru@redhat.com>
References: <1494327362-30727-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio-scsi-test: Use scsi-hd instead of
 legacy scsi-disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/virtio-scsi-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 0eabd56..27ef7c0 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -149,7 +149,7 @@ static QVirtIOSCSI *qvirtio_scsi_pci_init(int slot)
 
     vs->qs = qvirtio_scsi_start("-drive file=blkdebug::null-co://,"
                                 "if=none,id=dr1,format=raw,file.align=4k "
-                                "-device scsi-disk,drive=dr1,lun=0,scsi-id=1");
+                                "-device scsi-hd,drive=dr1,lun=0,scsi-id=1");
     dev = qvirtio_pci_device_find(vs->qs->pcibus, VIRTIO_ID_SCSI);
     vs->dev = (QVirtioDevice *)dev;
     g_assert(dev != NULL);
-- 
2.7.4
