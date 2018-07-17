Received: from eggs.gnu.org ([2001:4830:134:3::10]:48546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZR-0005I6-7A
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZQ-0007La-7G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZQ-0007LC-1x
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:20 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:55 +0200
Message-Id: <1531840015-28804-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] Document command line options with single
 dash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

QEMU options have a single dash (but also work as double dash for
convenience and compatibility). Most options are listed with single
dash in command line help but some were listed with two dashes.
Normalize these to have the same format as the others.

Left --preconfig as that is mentioned as double dash everywhere so I
assume that is the preferred form for that.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20180716193312.A5BA17456B9@zero.eik.bme.hu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 654e69c..1a186fb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -471,7 +471,7 @@ STEXI
 @item -balloon virtio[,addr=@var{addr}]
 @findex -balloon
 Enable virtio balloon device, optionally with PCI address @var{addr}. This
-option is deprecated, use @option{--device virtio-balloon} instead.
+option is deprecated, use @option{-device virtio-balloon} instead.
 ETEXI
 
 DEF("device", HAS_ARG, QEMU_OPTION_device,
@@ -2005,7 +2005,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
     "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
 DEF("nic", HAS_ARG, QEMU_OPTION_nic,
-    "--nic [tap|bridge|"
+    "-nic [tap|bridge|"
 #ifdef CONFIG_SLIRP
     "user|"
 #endif
@@ -2024,7 +2024,7 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "socket][,option][,...][mac=macaddr]\n"
     "                initialize an on-board / default host NIC (using MAC address\n"
     "                macaddr) and connect it to the given host network backend\n"
-    "--nic none      use it alone to have zero network devices (the default is to\n"
+    "-nic none       use it alone to have zero network devices (the default is to\n"
     "                provided a 'user' network connection)\n",
     QEMU_ARCH_ALL)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
@@ -3338,7 +3338,7 @@ mlocking qemu and guest memory can be enabled via @option{mlock=on}
 ETEXI
 
 DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
-    "--overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
+    "-overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
     "                run qemu with overcommit hints\n"
     "                mem-lock=on|off controls memory lock support (default: off)\n"
     "                cpu-pm=on|off controls cpu power management (default: off)\n",
-- 
1.8.3.1
