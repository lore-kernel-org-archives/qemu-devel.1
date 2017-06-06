Received: from eggs.gnu.org ([2001:4830:134:3::10]:41398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI90F-0007ew-QK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI90F-0001S0-67
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dI90E-0001RX-WB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AB2A81F01
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 07:34:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B8BA4F9A6
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 07:34:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Jun 2017 09:34:05 +0200
Message-Id: <1496734448-19256-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1496734448-19256-1-git-send-email-armbru@redhat.com>
References: <1496734448-19256-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] block: Clarify documentation of BlockInfo
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

Say "SCSI except scsi-generic" instead of "scsi-disk", because
scsi-disk could mean either scsi-disk.c (which is correct) or device
model scsi-disk (which would be incorrect).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1494327362-30727-2-git-send-email-armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/block-core.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 88a7471..f85c223 100644
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
2.7.5
