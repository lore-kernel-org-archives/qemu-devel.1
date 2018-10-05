Received: from eggs.gnu.org ([2001:4830:134:3::10]:38118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8Lnj-0000VC-Rx
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8Lit-0003TN-2j
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:44:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g8Lis-0003RZ-PH
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D71F86674
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 08:44:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 Oct 2018 10:44:27 +0200
Message-Id: <1538729067-7944-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/device-crash-test: Remove devices that
 are not user_creatable anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Devices that are derived from TYPE_SYS_BUS_DEVICE are not user_creatable
anymore by default, and some others have been marked as non-user_creatable
manually, so we can remove these devices from the "ignore"-list in the
device-crash-test script.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/device-crash-test | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 6ed1f32..4ded1f3 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -73,21 +73,6 @@ ERROR_WHITELIST = [
     # devices that don't work out of the box because they require extra options to "-device DEV":
     #            DEVICE                                    | ERROR MESSAGE
     {'device':'.*-(i386|x86_64)-cpu', 'expected':True},    # CPU socket-id is not set
-    {'device':'ARM,bitband-memory', 'expected':True},      # source-memory property not set
-    {'device':'arm.cortex-a9-global-timer', 'expected':True}, # a9_gtimer_realize: num-cpu must be between 1 and 4
-    {'device':'arm_mptimer', 'expected':True},             # num-cpu must be between 1 and 4
-    {'device':'armv7m', 'expected':True},                  # memory property was not set
-    {'device':'aspeed.scu', 'expected':True},              # Unknown silicon revision: 0x0
-    {'device':'aspeed.sdmc', 'expected':True},             # Unknown silicon revision: 0x0
-    {'device':'bcm2835-dma', 'expected':True},             # bcm2835_dma_realize: required dma-mr link not found: Property '.dma-mr' not found
-    {'device':'bcm2835-fb', 'expected':True},              # bcm2835_fb_realize: required vcram-base property not set
-    {'device':'bcm2835-mbox', 'expected':True},            # bcm2835_mbox_realize: required mbox-mr link not found: Property '.mbox-mr' not found
-    {'device':'bcm2835-peripherals', 'expected':True},     # bcm2835_peripherals_realize: required ram link not found: Property '.ram' not found
-    {'device':'bcm2835-property', 'expected':True},        # bcm2835_property_realize: required fb link not found: Property '.fb' not found
-    {'device':'bcm2835_gpio', 'expected':True},            # bcm2835_gpio_realize: required sdhci link not found: Property '.sdbus-sdhci' not found
-    {'device':'bcm2836', 'expected':True},                 # bcm2836_realize: required ram link not found: Property '.ram' not found
-    {'device':'cfi.pflash01', 'expected':True},            # attribute "sector-length" not specified or zero.
-    {'device':'cfi.pflash02', 'expected':True},            # attribute "sector-length" not specified or zero.
     {'device':'icp', 'expected':True},                     # icp_realize: required link 'xics' not found: Property '.xics' not found
     {'device':'ics', 'expected':True},                     # ics_base_realize: required link 'xics' not found: Property '.xics' not found
     # "-device ide-cd" does work on more recent QEMU versions, so it doesn't have expected=True
@@ -109,7 +94,6 @@ ERROR_WHITELIST = [
     {'device':'pc-dimm', 'expected':True},                 # 'memdev' property is not set
     {'device':'pci-bridge', 'expected':True},              # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'pci-bridge-seat', 'expected':True},         # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
-    {'device':'pxa2xx-dma', 'expected':True},              # channels value invalid
     {'device':'pxb', 'expected':True},                     # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'scsi-block', 'expected':True},              # drive property not set
     {'device':'scsi-disk', 'expected':True},               # drive property not set
@@ -146,7 +130,6 @@ ERROR_WHITELIST = [
     {'device':'virtio-input-host-pci', 'expected':True},   # evdev property is required
     {'device':'xen-pvdevice', 'expected':True},            # Device ID invalid, it must always be supplied
     {'device':'vhost-vsock-ccw', 'expected':True},         # guest-cid property must be greater than 2
-    {'device':'ALTR.timer', 'expected':True},              # "clock-frequency" property must be provided
     {'device':'zpci', 'expected':True},                    # target must be defined
     {'device':'pnv-(occ|icp|lpc)', 'expected':True},       # required link 'xics' not found: Property '.xics' not found
     {'device':'powernv-cpu-.*', 'expected':True},          # pnv_core_realize: required link 'xics' not found: Property '.xics' not found
-- 
1.8.3.1
