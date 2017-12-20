Received: from eggs.gnu.org ([2001:4830:134:3::10]:56100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy1-0004Hv-Sa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy1-000710-0l
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:41 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy0-00070U-QZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:40 -0500
Received: by mail-wr0-x242.google.com with SMTP id h1so22876955wre.12
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:18 +0100
Message-Id: <1513790098-9815-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/46] scsi-block: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Scsi-block doesn't use the DEFINE_BLOCK_PROPERTIES() macro so it didn't
gain the share-rw back when it was added to all other storage devices.
This option is meaningful here, and need to be used when attaching a
shared storage to guest.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20171205071928.30242-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 870d9ae..e58833a 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3004,6 +3004,7 @@ static const TypeInfo scsi_cd_info = {
 static Property scsi_block_properties[] = {
     DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
+    DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
1.8.3.1
