Received: from eggs.gnu.org ([2001:4830:134:3::10]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fSNlN-00044f-7m
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fSNlG-0001DG-73
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:25:41 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:44102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vskytta@gmail.com>) id 1fSNlF-0001Ct-Q5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:25:34 -0400
Received: by mail-lf0-x22e.google.com with SMTP id 36-v6so30826567lfr.11
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 07:25:33 -0700 (PDT)
Received: from uncleman.com (dtcv1zycgh96w9vchdr3t-3.rev.dnainternet.fi.
	[2001:14ba:80a3:5a00:4537:752e:c446:1baf])
	by smtp.gmail.com with ESMTPSA id
	c67-v6sm6201074lfe.4.2018.06.11.07.25.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Jun 2018 07:25:30 -0700 (PDT)
Sender: =?UTF-8?Q?Ville_Skytt=C3=A4?= <vskytta@gmail.com>
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Mon, 11 Jun 2018 17:25:28 +0300
Message-Id: <20180611142528.11730-1-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 docs/colo-proxy.txt                  | 2 +-
 docs/config/mach-virt-graphical.cfg  | 2 +-
 docs/config/mach-virt-serial.cfg     | 2 +-
 docs/config/q35-emulated.cfg         | 2 +-
 docs/config/q35-virtio-graphical.cfg | 2 +-
 docs/config/q35-virtio-serial.cfg    | 2 +-
 docs/devel/migration.rst             | 2 +-
 docs/devel/multi-thread-tcg.txt      | 2 +-
 docs/interop/qcow2.txt               | 4 ++--
 docs/interop/vhost-user.txt          | 4 ++--
 docs/memory-hotplug.txt              | 2 +-
 docs/multiseat.txt                   | 2 +-
 docs/qemu-block-drivers.texi         | 2 +-
 docs/qemupciserial.inf               | 2 +-
 docs/specs/acpi_nvdimm.txt           | 2 +-
 docs/specs/ppc-spapr-hcalls.txt      | 2 +-
 docs/specs/tpm.txt                   | 2 +-
 docs/usb2.txt                        | 2 +-
 18 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index 8b726ea094..1f8e4b4e77 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -145,7 +145,7 @@ and redirect indev's packet to filter.
 COLO-compare, we do packet comparing job.
 Packets coming from the primary char indev will be sent to outdev.
 Packets coming from the secondary char dev will be dropped after comparing.
-COLO-comapre need two input chardev and one output chardev:
+COLO-compare needs two input chardevs and one output chardev:
 primary_in=chardev1-id (source: primary send packet)
 secondary_in=chardev2-id (source: secondary send packet)
 outdev=chardev3-id
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
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 40f136f6be..6ed3fce061 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -37,7 +37,7 @@ over any transport.
 - tcp migration: do the migration using tcp sockets
 - unix migration: do the migration using unix sockets
 - exec migration: do the migration using the stdin/stdout through a process.
-- fd migration: do the migration using an file descriptor that is
+- fd migration: do the migration using a file descriptor that is
   passed to QEMU.  QEMU doesn't care how this file descriptor is opened.
 
 In addition, support is included for migration using RDMA, which
diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index a99b4564c6..ac485c8e62 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.txt
@@ -308,7 +308,7 @@ other cores sharing access to the memory. The classic example is the
 x86 cmpxchg instruction.
 
 The second type offer a pair of load/store instructions which offer a
-guarantee that an region of memory has not been touched between the
+guarantee that a region of memory has not been touched between the
 load and store instructions. An example of this is ARM's ldrex/strex
 pair where the strex instruction will return a flag indicating a
 successful store only if no other CPU has accessed the memory region
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 8e1547ded2..27732aa413 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -326,7 +326,7 @@ in the image file.
 It contains pointers to the second level structures which are called refcount
 blocks and are exactly one cluster in size.
 
-Given a offset into the image file, the refcount of its cluster can be obtained
+Given an offset into the image file, the refcount of its cluster can be obtained
 as follows:
 
     refcount_block_entries = (cluster_size * 8 / refcount_bits)
@@ -365,7 +365,7 @@ The L1 table has a variable size (stored in the header) and may use multiple
 clusters, however it must be contiguous in the image file. L2 tables are
 exactly one cluster in size.
 
-Given a offset into the virtual disk, the offset into the image file can be
+Given an offset into the virtual disk, the offset into the image file can be
 obtained as follows:
 
     l2_entries = (cluster_size / sizeof(uint64_t))
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index d51fd58242..f59667f498 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -108,12 +108,12 @@ Depending on the request type, payload can be:
    IOVA: a 64-bit I/O virtual address programmed by the guest
    Size: a 64-bit size
    User address: a 64-bit user address
-   Permissions: a 8-bit value:
+   Permissions: an 8-bit value:
     - 0: No access
     - 1: Read access
     - 2: Write access
     - 3: Read/Write access
-   Type: a 8-bit IOTLB message type:
+   Type: an 8-bit IOTLB message type:
     - 1: IOTLB miss
     - 2: IOTLB update
     - 3: IOTLB invalidate
diff --git a/docs/memory-hotplug.txt b/docs/memory-hotplug.txt
index d96397c1af..6aa5e17e26 100644
--- a/docs/memory-hotplug.txt
+++ b/docs/memory-hotplug.txt
@@ -62,7 +62,7 @@ It's also possible to start a guest with memory cold-plugged into the
 hotpluggable memory slots. This might seem counterintuitive at first,
 but this allows for a lot of flexibility when using the file backend.
 
-In the following command-line example, a 8GB guest is created where 6GB
+In the following command-line example, an 8GB guest is created where 6GB
 comes from regular RAM, 1GB is a 1GB hugepage page and 256MB is from
 2MB pages. Also, the guest has additional memory slots to hotplug more
 2GB if needed:
diff --git a/docs/multiseat.txt b/docs/multiseat.txt
index 807518c8af..fb7e790b22 100644
--- a/docs/multiseat.txt
+++ b/docs/multiseat.txt
@@ -62,7 +62,7 @@ to its own window so you can see both display devices side-by-side.
 
 For vnc some additional configuration on the command line is needed.
 We'll create two vnc server instances, and bind the second one to the
-second seat, simliar to input devices:
+second seat, similar to input devices:
 
 	-display vnc=:1,id=primary \
 	-display vnc=:2,id=secondary,display=video.2
diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index f1793692bb..38e9f34cc9 100644
--- a/docs/qemu-block-drivers.texi
+++ b/docs/qemu-block-drivers.texi
@@ -524,7 +524,7 @@ You can create a cloned image from the existing snapshot.
 @example
 qemu-img create -b sheepdog:///@var{base}#@var{tag} sheepdog:///@var{image}
 @end example
-where @var{base} is a image name of the source snapshot and @var{tag}
+where @var{base} is an image name of the source snapshot and @var{tag}
 is its tag name.
 
 You can use an unix socket instead of an inet socket:
diff --git a/docs/qemupciserial.inf b/docs/qemupciserial.inf
index 6f7eef49cc..7ca766745d 100644
--- a/docs/qemupciserial.inf
+++ b/docs/qemupciserial.inf
@@ -1,7 +1,7 @@
 ; qemupciserial.inf for QEMU, based on MSPORTS.INF
 
 ; The driver itself is shipped with Windows (serial.sys).  This is
-; just a inf file to tell windows which pci id the serial pci card
+; just an inf file to tell windows which pci id the serial pci card
 ; emulated by qemu has, and to apply a name tag to it which windows
 ; will show in the device manager.
 
diff --git a/docs/specs/acpi_nvdimm.txt b/docs/specs/acpi_nvdimm.txt
index 3f322e6f55..4da2d44534 100644
--- a/docs/specs/acpi_nvdimm.txt
+++ b/docs/specs/acpi_nvdimm.txt
@@ -72,7 +72,7 @@ for NVDIMM ACPI.
 
 Memory:
    QEMU uses BIOS Linker/loader feature to ask BIOS to allocate a memory
-   page and dynamically patch its into a int32 object named "MEMA" in ACPI.
+   page and dynamically patch its into an int32 object named "MEMA" in ACPI.
 
    This page is RAM-based and it is used to transfer data between _DSM
    method and QEMU. If ACPI has control, this pages is owned by ACPI which
diff --git a/docs/specs/ppc-spapr-hcalls.txt b/docs/specs/ppc-spapr-hcalls.txt
index 5bd8eab78f..93fe3da91b 100644
--- a/docs/specs/ppc-spapr-hcalls.txt
+++ b/docs/specs/ppc-spapr-hcalls.txt
@@ -10,7 +10,7 @@ calls which are mostly used as a private interface between the firmware
 running in the guest and QEMU.
 
 All those hypercalls start at hcall number 0xf000 which correspond
-to a implementation specific range in PAPR.
+to an implementation specific range in PAPR.
 
 - H_RTAS (0xf000)
 
diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index c230c4c93e..575a267611 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -252,7 +252,7 @@ swtpm socket --tpmstate dir=/tmp/mytpm1 \
   --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
   --log level=20 --tpm2
 
-In the 2nd terminal restore the state of the VM using the additonal
+In the 2nd terminal restore the state of the VM using the additional
 '-incoming' option.
 
 qemu-system-x86_64 -display sdl -enable-kvm \
diff --git a/docs/usb2.txt b/docs/usb2.txt
index 09df45b5b1..9e47169f45 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -15,7 +15,7 @@ the PIIX3 chipset.  The USB 1.1 bus will carry the name "usb-bus.0".
 
 You can use the standard -device switch to add a EHCI controller to
 your virtual machine.  It is strongly recommended to specify an ID for
-the controller so the USB 2.0 bus gets a individual name, for example
+the controller so the USB 2.0 bus gets an individual name, for example
 '-device usb-ehci,id=ehci".  This will give you a USB 2.0 bus named
 "ehci.0".
 
-- 
2.14.1
