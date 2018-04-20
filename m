Received: from eggs.gnu.org ([2001:4830:134:3::10]:39989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahW-0007lS-K5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahR-0007pp-NG
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9ahR-0007lu-Gq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:50 -0300
Message-Id: <20180420181951.7252-24-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 23/24] avocado_qemu: Force vmimage distro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Amador Pahim <apahim@redhat.com>

Not all distros will support cloudinit. Let's use Fedora, which is
proven to work.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_nec-usb-xhci.py | 2 +-
 tests/avocado/test_numa_hotplug.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/test_nec-usb-xhci.py b/tests/avocado/test_nec-usb-xhci.py
index d3a2716eb4..c29b5ebaa1 100644
--- a/tests/avocado/test_nec-usb-xhci.py
+++ b/tests/avocado/test_nec-usb-xhci.py
@@ -19,7 +19,7 @@ class TestNecUsbXhci(test.QemuTest):
 
     def setUp(self):
         self.vm_dst = None
-        self.image = vmimage.get()
+        self.image = vmimage.get('Fedora')
         self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
         self.vm.args.extend(['-machine', 'accel=kvm'])
 
diff --git a/tests/avocado/test_numa_hotplug.py b/tests/avocado/test_numa_hotplug.py
index 1993f9b159..256ec0f49f 100644
--- a/tests/avocado/test_numa_hotplug.py
+++ b/tests/avocado/test_numa_hotplug.py
@@ -21,7 +21,7 @@ class TestNumaHotplug(test.QemuTest):
     """
 
     def setUp(self):
-        self.image = vmimage.get()
+        self.image = vmimage.get('Fedora')
         self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
 
         self.vm.args.extend(['-machine', 'accel=kvm'])
-- 
2.14.3
