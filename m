Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfiD2-0004AZ-ED
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfiD1-0008BB-Fs
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfiD1-0008A2-AF
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45D0F40431C
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 07:48:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 10 Aug 2017 09:48:43 +0200
Message-Id: <1502351323-15186-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] qemu-doc: Mention
 host_net_add/-remove in the deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

The two HMP commands host_net_add and -remove have recently been
marked as deprecated, too, so we should now mention them in the
chapter of deprecated features.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index aeb7bc5..7b62fdf 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -3283,6 +3283,14 @@ by the ``convert -l snapshot_param'' argument instead.
 
 @section System emulator human monitor commands
 
+@subsection host_net_add (since 2.10.0)
+
+The ``host_net_add'' command is replaced by the ``netdev_add'' command.
+
+@subsection host_net_remove (since 2.10.0)
+
+The ``host_net_remove'' command is replaced by the ``host_net_remove'' command.
+
 @subsection usb_add (since 2.10.0)
 
 The ``usb_add'' command is replaced by the ``device_add'' command.
-- 
1.8.3.1
