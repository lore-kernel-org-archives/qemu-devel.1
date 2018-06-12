Received: from eggs.gnu.org ([2001:4830:134:3::10]:46872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn1-0002oI-Px
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn0-0007wc-Ul
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:39 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:29 +0200
Message-Id: <20180612104430.25745-8-kraxel@redhat.com>
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] usb-hcd-xhci-test: add a test for ccid
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180531195119.22021-5-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/usb-hcd-xhci-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 9c14e3053a..5b1b681bf2 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -35,6 +35,15 @@ static void test_usb_uas_hotplug(void)
     qtest_qmp_device_del("uas");
 }
=20
+static void test_usb_ccid_hotplug(void)
+{
+    qtest_qmp_device_add("usb-ccid", "ccid", NULL);
+    qtest_qmp_device_del("ccid");
+    /* check the device can be added again */
+    qtest_qmp_device_add("usb-ccid", "ccid", NULL);
+    qtest_qmp_device_del("ccid");
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -44,6 +53,7 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/init", test_xhci_init);
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
+    qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
=20
     qtest_start("-device nec-usb-xhci,id=3Dxhci"
                 " -drive id=3Ddrive0,if=3Dnone,file=3Dnull-co://,format=3D=
raw");
--=20
2.9.3
