Received: from eggs.gnu.org ([2001:4830:134:3::10]:42714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkl-0005jt-Lt
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkk-00060S-M7
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:23:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKkk-00060E-GE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:23:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:22:09 +0100
Message-Id: <20170831082210.8362-15-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 14/15] qemu-doc: Add UUID support in
 initiator name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fred Rolland <rollandf@gmail.com>, Fred Rolland <frolland@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fred Rolland <rollandf@gmail.com>

Update doc with the usage of UUID for initiator name.

Related-To: https://bugzilla.redhat.com/1006468
Signed-off-by: Fred Rolland <frolland@redhat.com>
Message-id: 20170823084830.30500-1-frolland@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-doc.texi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 9811476ac1..4076226f39 100644
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
2.13.5
