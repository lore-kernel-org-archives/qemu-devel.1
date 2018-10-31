Received: from eggs.gnu.org ([2001:4830:134:3::10]:42979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQJ-00027p-NG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQG-0003mc-5C
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:06 -0300
Message-Id: <20181031003120.26771-2-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] scripts/device-crash-test: Remove devices
 that are not user_creatable anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Devices that are derived from TYPE_SYS_BUS_DEVICE are not user_creatable
anymore by default, and some others have been marked as non-user_creatable
manually, so we can remove these devices from the "ignore"-list in the
device-crash-test script.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1538729067-7944-1-git-send-email-thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 930200b034..e93a7c0c84 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -72,21 +72,6 @@ ERROR_WHITELIST = [
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
@@ -108,7 +93,6 @@ ERROR_WHITELIST = [
     {'device':'pc-dimm', 'expected':True},                 # 'memdev' property is not set
     {'device':'pci-bridge', 'expected':True},              # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'pci-bridge-seat', 'expected':True},         # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
-    {'device':'pxa2xx-dma', 'expected':True},              # channels value invalid
     {'device':'pxb', 'expected':True},                     # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'scsi-block', 'expected':True},              # drive property not set
     {'device':'scsi-disk', 'expected':True},               # drive property not set
@@ -145,7 +129,6 @@ ERROR_WHITELIST = [
     {'device':'virtio-input-host-pci', 'expected':True},   # evdev property is required
     {'device':'xen-pvdevice', 'expected':True},            # Device ID invalid, it must always be supplied
     {'device':'vhost-vsock-ccw', 'expected':True},         # guest-cid property must be greater than 2
-    {'device':'ALTR.timer', 'expected':True},              # "clock-frequency" property must be provided
     {'device':'zpci', 'expected':True},                    # target must be defined
     {'device':'pnv-(occ|icp|lpc)', 'expected':True},       # required link 'xics' not found: Property '.xics' not found
     {'device':'powernv-cpu-.*', 'expected':True},          # pnv_core_realize: required link 'xics' not found: Property '.xics' not found
-- 
2.18.0.rc1.1.g3f1ff2140
