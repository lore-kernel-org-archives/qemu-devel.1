Received: from eggs.gnu.org ([2001:4830:134:3::10]:54229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stweil@ub-blade-01.bib.uni-mannheim.de>)
	id 1fdhwy-0000cJ-Om
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stweil@ub-blade-01.bib.uni-mannheim.de>)
	id 1fdhwv-0002jP-Hd
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:12:28 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Thu, 12 Jul 2018 22:01:52 +0200
Message-Id: <20180712200152.28569-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] docs: Fix some typos (most found by codespell)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 docs/COLO-FT.txt                     | 2 +-
 docs/config/mach-virt-graphical.cfg  | 2 +-
 docs/config/mach-virt-serial.cfg     | 2 +-
 docs/config/q35-emulated.cfg         | 2 +-
 docs/config/q35-virtio-graphical.cfg | 2 +-
 docs/config/q35-virtio-serial.cfg    | 2 +-
 docs/interop/vhost-user.txt          | 4 ++--
 docs/replay.txt                      | 2 +-
 docs/specs/tpm.txt                   | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index d7c7dcda8f..70cfb9ce7d 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -104,7 +104,7 @@ Primary side.
 COLO Proxy:
 Delivers packets to Primary and Seconday, and then compare the responses from
 both side. Then decide whether to start a checkpoint according to some rules.
-Please refer to docs/colo-proxy.txt for more informations.
+Please refer to docs/colo-proxy.txt for more information.
 
 Note:
 HeartBeat has not been implemented yet, so you need to trigger failover process
diff --git a/docs/config/mach-virt-graphical.cfg b/docs/config/mach-virt-graphical.cfg
index 0fdf6846dd..d6d31b17f5 100644
--- a/docs/config/mach-virt-graphical.cfg
+++ b/docs/config/mach-virt-graphical.cfg
@@ -185,7 +185,7 @@
 # attached to it.
 #
 # We also create an optical disk, mostly for installation
-# purposes: once the guest OS has been succesfully
+# purposes: once the guest OS has been successfully
 # installed, the guest will no longer boot from optical
 # media. If you don't want, or no longer want, to have an
 # optical disk in the guest you can safely comment out
diff --git a/docs/config/mach-virt-serial.cfg b/docs/config/mach-virt-serial.cfg
index aee9f1c5a1..18a7c83731 100644
--- a/docs/config/mach-virt-serial.cfg
+++ b/docs/config/mach-virt-serial.cfg
@@ -191,7 +191,7 @@
 # attached to it.
 #
 # We also create an optical disk, mostly for installation
-# purposes: once the guest OS has been succesfully
+# purposes: once the guest OS has been successfully
 # installed, the guest will no longer boot from optical
 # media. If you don't want, or no longer want, to have an
 # optical disk in the guest you can safely comment out
diff --git a/docs/config/q35-emulated.cfg b/docs/config/q35-emulated.cfg
index c6416d6545..99ac918e78 100644
--- a/docs/config/q35-emulated.cfg
+++ b/docs/config/q35-emulated.cfg
@@ -130,7 +130,7 @@
 # it to that controller so that the guest can use it.
 #
 # We also create an optical disk, mostly for installation
-# purposes: once the guest OS has been succesfully
+# purposes: once the guest OS has been successfully
 # installed, the guest will no longer boot from optical
 # media. If you don't want, or no longer want, to have an
 # optical disk in the guest you can safely comment out
diff --git a/docs/config/q35-virtio-graphical.cfg b/docs/config/q35-virtio-graphical.cfg
index 28bde2fc57..4207f11e4f 100644
--- a/docs/config/q35-virtio-graphical.cfg
+++ b/docs/config/q35-virtio-graphical.cfg
@@ -136,7 +136,7 @@
 # attached to it.
 #
 # We also create an optical disk, mostly for installation
-# purposes: once the guest OS has been succesfully
+# purposes: once the guest OS has been successfully
 # installed, the guest will no longer boot from optical
 # media. If you don't want, or no longer want, to have an
 # optical disk in the guest you can safely comment out
diff --git a/docs/config/q35-virtio-serial.cfg b/docs/config/q35-virtio-serial.cfg
index c33c9cc07a..d2830aec5e 100644
--- a/docs/config/q35-virtio-serial.cfg
+++ b/docs/config/q35-virtio-serial.cfg
@@ -141,7 +141,7 @@
 # attached to it.
 #
 # We also create an optical disk, mostly for installation
-# purposes: once the guest OS has been succesfully
+# purposes: once the guest OS has been successfully
 # installed, the guest will no longer boot from optical
 # media. If you don't want, or no longer want, to have an
 # optical disk in the guest you can safely comment out
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index d51fd58242..0d8aa3ba7d 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -666,12 +666,12 @@ Master message types
       Equivalent ioctl: VHOST_SET_VRING_ENDIAN
       Master payload: vring state description
 
-      Set the endianess of a VQ for legacy devices. Little-endian is indicated
+      Set the endianness of a VQ for legacy devices. Little-endian is indicated
       with state.num set to 0 and big-endian is indicated with state.num set
       to 1. Other values are invalid.
       This request should be sent only when VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
       has been negotiated.
-      Backends that negotiated this feature should handle both endianesses
+      Backends that negotiated this feature should handle both endiannesses
       and expect this message once (per VQ) during device configuration
       (ie. before the master starts the VQ).
 
diff --git a/docs/replay.txt b/docs/replay.txt
index 2e21e9ccb0..3497585f5a 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -320,7 +320,7 @@ Here is the list of events that are written into the log:
    async event id from the following list:
      - REPLAY_ASYNC_EVENT_BH. Bottom-half callback. This event synchronizes
        callbacks that affect virtual machine state, but normally called
-       asyncronously.
+       asynchronously.
        Argument: 8-byte operation id.
      - REPLAY_ASYNC_EVENT_INPUT. Input device event. Contains
        parameters of keyboard and mouse input operations
diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 70ad4a0cba..0e9bbebe1d 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -252,7 +252,7 @@ swtpm socket --tpmstate dir=/tmp/mytpm1 \
   --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
   --log level=20 --tpm2
 
-In the 2nd terminal restore the state of the VM using the additonal
+In the 2nd terminal restore the state of the VM using the additional
 '-incoming' option.
 
 qemu-system-x86_64 -display sdl -accel kvm \
-- 
2.11.0
