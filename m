Received: from eggs.gnu.org ([2001:4830:134:3::10]:51405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d82oL-0004c3-2K
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d82oI-0004RU-3U
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d82oH-0004RC-TQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 900768047F
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 10:56:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 12:56:01 +0200
Message-Id: <1494327362-30727-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1494327362-30727-1-git-send-email-armbru@redhat.com>
References: <1494327362-30727-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block: Clarify documentation of BlockInfo
 member io-status
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

Say "SCSI except scsi-generic" instead of "scsi-disk", because
scsi-disk could mean either scsi-disk.c (which is correct) or device
model scsi-disk (which would be incorrect).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 87fb747..b1dc848 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -449,7 +449,8 @@
 #
 # @io-status: @BlockDeviceIoStatus. Only present if the device
 #             supports it and the VM is configured to stop on errors
-#             (supported device models: virtio-blk, ide, scsi-disk)
+#             (supported device models: virtio-blk, IDE, SCSI except
+#             scsi-generic)
 #
 # @inserted: @BlockDeviceInfo describing the device if media is
 #            present
-- 
2.7.4
