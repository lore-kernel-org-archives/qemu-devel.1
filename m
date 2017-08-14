Received: from eggs.gnu.org ([2001:4830:134:3::10]:44977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dhEaD-0000Q6-E5
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dhEaB-0000hO-VB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dhEaB-0000gR-PF
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:34:59 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2017 20:34:50 +0800
Message-Id: <1502714090-5629-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1502714090-5629-1-git-send-email-jasowang@redhat.com>
References: <1502714090-5629-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V3] qemu-doc: Mention host_net_add/-remove in
 the deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: cohuck@redhat.com, Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The two HMP commands host_net_add and -remove have recently been
marked as deprecated, too, so we should now mention them in the
chapter of deprecated features.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-doc.texi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index aeb7bc5..92d50f1 100644
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
+The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
+
 @subsection usb_add (since 2.10.0)
 
 The ``usb_add'' command is replaced by the ``device_add'' command.
-- 
2.7.4
