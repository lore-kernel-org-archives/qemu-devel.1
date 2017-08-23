Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rollandf@gmail.com>) id 1dkRLF-0008UI-A7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rollandf@gmail.com>) id 1dkRLC-0003PT-8j
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:49 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rollandf@gmail.com>) id 1dkRLC-0003Ol-11
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:46 -0400
Received: by mail-wm0-x242.google.com with SMTP id q189so1634612wmd.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 01:48:44 -0700 (PDT)
From: Fred Rolland <rollandf@gmail.com>
Date: Wed, 23 Aug 2017 11:48:30 +0300
Message-Id: <20170823084830.30500-1-frolland@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Add UUID support in initiator name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fred Rolland <frolland@redhat.com>

Update doc with the usage of UUID for initiator name.

Related-To: https://bugzilla.redhat.com/1006468
Signed-off-by: Fred Rolland <frolland@redhat.com>
---
 qemu-doc.texi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 9811476..4076226 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1066,10 +1066,11 @@ in a configuration file provided via '-readconfig' or directly on the
 command line.
 
 If the initiator-name is not specified qemu will use a default name
-of 'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
+of 'iqn.2008-11.org.linux-kvm[:<uuid>'] where <uuid> is the UUID of the
+virtual machine. If the UUID is not specified qemu will use
+'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
 virtual machine.
 
-
 @example
 Setting a specific initiator name to use when logging in to the target
 -iscsi initiator-name=iqn.qemu.test:my-initiator
-- 
2.9.5
