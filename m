Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03AEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A7A2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXY96mGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A7A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPxz-0004vu-48
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 10:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ifPwj-0004Ic-Ke
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ifPwe-0003JY-DG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:00:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ifPwe-0003GE-6F
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576162798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vnVhDsAoCDSDO8iHCwT0hVJkYAheC4ZX4/Tma4eo2fA=;
 b=NXY96mGwbxyTQt3PuDGENp0sUYprRfpWHBlbOOVVU3eNYvhuaQdRg71yaiA+AAs+C1kYPF
 bjIT5xdeCZy/NjtKdtO2EuFx/7aLLUM78gk5SVgFRj4PqjpWRC+TNyUsxQDGUuKtm86KN+
 vqh/MjsWHW2JQ0wkbZQtaZG8T9CWZNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-SGTxJJSuNZ2bnYh7zf8Uqg-1; Thu, 12 Dec 2019 09:59:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4689092ED0;
 Thu, 12 Dec 2019 14:59:54 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6402560BF3;
 Thu, 12 Dec 2019 14:59:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/specs/tpm: reST-ify TPM documentation
Date: Thu, 12 Dec 2019 18:59:44 +0400
Message-Id: <20191212145944.1921866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: SGTxJJSuNZ2bnYh7zf8Uqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/specs/index.rst |   1 +
 docs/specs/tpm.rst   | 503 +++++++++++++++++++++++++++++++++++++++++++
 docs/specs/tpm.txt   | 445 --------------------------------------
 3 files changed, 504 insertions(+), 445 deletions(-)
 create mode 100644 docs/specs/tpm.rst
 delete mode 100644 docs/specs/tpm.txt

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 984ba44029..de46a8b5e7 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -13,3 +13,4 @@ Contents:
    ppc-xive
    ppc-spapr-xive
    acpi_hw_reduced_hotplug
+   tpm
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
new file mode 100644
index 0000000000..2bdf637f55
--- /dev/null
+++ b/docs/specs/tpm.rst
@@ -0,0 +1,503 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+QEMU TPM Device
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Guest-side hardware interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+TIS interface
+-------------
+
+The QEMU TPM emulation implements a TPM TIS hardware interface
+following the Trusted Computing Group's specification "TCG PC Client
+Specific TPM Interface Specification (TIS)", Specification Version
+1.3, 21 March 2013. (see the `TIS specification`_, or a later version
+of it).
+
+The TIS interface makes a memory mapped IO region in the area
+0xfed40000-0xfed44fff available to the guest operating system.
+
+QEMU files related to TPM TIS interface:
+ - ``hw/tpm/tpm_tis.c``
+ - ``hw/tpm/tpm_tis.h``
+
+CRB interface
+-------------
+
+QEMU also implements a TPM CRB interface following the Trusted
+Computing Group's specification "TCG PC Client Platform TPM Profile
+(PTP) Specification", Family "2.0", Level 00 Revision 01.03 v22, May
+22, 2017. (see the `CRB specification`_, or a later version of it)
+
+The CRB interface makes a memory mapped IO region in the area
+0xfed40000-0xfed40fff (1 locality) available to the guest
+operating system.
+
+QEMU files related to TPM CRB interface:
+ - ``hw/tpm/tpm_crb.c``
+
+SPAPR interface
+---------------
+
+pSeries (ppc64) machines offer a tpm-spapr device model.
+
+QEMU files related to the SPAPR interface:
+ - ``hw/tpm/tpm_spapr.c``
+
+fw_cfg interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The bios/firmware may read the ``"etc/tpm/config"`` fw_cfg entry for
+configuring the guest appropriately.
+
+The entry of 6 bytes has the following content, in little-endian:
+
+.. code-block:: c
+
+    #define TPM_VERSION_UNSPEC          0
+    #define TPM_VERSION_1_2             1
+    #define TPM_VERSION_2_0             2
+
+    #define TPM_PPI_VERSION_NONE        0
+    #define TPM_PPI_VERSION_1_30        1
+
+    struct FwCfgTPMConfig {
+        uint32_t tpmppi_address;         /* PPI memory location */
+        uint8_t tpm_version;             /* TPM version */
+        uint8_t tpmppi_version;          /* PPI version */
+    };
+
+ACPI interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT
+and passes it into the guest through the fw_cfg device. The device
+description contains the base address of the TIS interface 0xfed40000
+and the size of the MMIO area (0x5000). In case a TPM2 is used by
+QEMU, a TPM2 ACPI table is also provided.  The device is described to
+be used in polling mode rather than interrupt mode primarily because
+no unused IRQ could be found.
+
+To support measurement logs to be written by the firmware,
+e.g. SeaBIOS, a TCPA table is implemented. This table provides a 64kb
+buffer where the firmware can write its log into. For TPM 2 only a
+more recent version of the TPM2 table provides support for
+measurements logs and a TCPA table does not need to be created.
+
+The TCPA and TPM2 ACPI tables follow the Trusted Computing Group
+specification "TCG ACPI Specification" Family "1.2" and "2.0", Level
+00 Revision 00.37. (see the `ACPI specification`_, or a later version
+of it)
+
+ACPI PPI Interface
+------------------
+
+QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and
+TPM 2. This interface requires ACPI and firmware support. (see the
+`PPI specification`_)
+
+PPI enables a system administrator (root) to request a modification to
+the TPM upon reboot. The PPI specification defines the operation
+requests and the actions the firmware has to take. The system
+administrator passes the operation request number to the firmware
+through an ACPI interface which writes this number to a memory
+location that the firmware knows. Upon reboot, the firmware finds the
+number and sends commands to the TPM. The firmware writes the TPM
+result code and the operation request number to a memory location that
+ACPI can read from and pass the result on to the administrator.
+
+The PPI specification defines a set of mandatory and optional
+operations for the firmware to implement. The ACPI interface also
+allows an administrator to list the supported operations. In QEMU the
+ACPI code is generated by QEMU, yet the firmware needs to implement
+support on a per-operations basis, and different firmwares may support
+a different subset. Therefore, QEMU introduces the virtual memory
+device for PPI where the firmware can indicate which operations it
+supports and ACPI can enable the ones that are supported and disable
+all others. This interface lies in main memory and has the following
+layout:
+
+ +-------------+--------+--------+----------------------------------------=
---+
+ |  Field      | Length | Offset | Description                            =
   |
+ +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
+ | ``func``    |  0x100 |  0x000 | Firmware sets values for each supported=
   |
+ |             |        |        | operation. See defined values below.   =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``ppin``    |   0x1  |  0x100 | SMI interrupt to use. Set by firmware. =
   |
+ |             |        |        | Not supported.                         =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``ppip``    |   0x4  |  0x101 | ACPI function index to pass to SMM code=
.  |
+ |             |        |        | Set by ACPI. Not supported.            =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``pprp``    |   0x4  |  0x105 | Result of last executed operation. Set =
by |
+ |             |        |        | firmware. See function index 5 for valu=
es.|
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``pprq``    |   0x4  |  0x109 | Operation request number to execute. Se=
e  |
+ |             |        |        | 'Physical Presence Interface Operation =
   |
+ |             |        |        | Summary' tables in specs. Set by ACPI. =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``pprm``    |   0x4  |  0x10d | Operation request optional parameter.  =
   |
+ |             |        |        | Values depend on operation. Set by ACPI=
.  |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``lppr``    |   0x4  |  0x111 | Last executed operation request number.=
   |
+ |             |        |        | Copied from pprq field by firmware.    =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``fret``    |   0x4  |  0x115 | Result code from SMM function.         =
   |
+ |             |        |        | Not supported.                         =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``res1``    |  0x40  |  0x119 | Reserved for future use                =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ |``next_step``|   0x1  |  0x159 | Operation to execute after reboot by   =
   |
+ |             |        |        | firmware. Used by firmware.            =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+ | ``movv``    |   0x1  |  0x15a | Memory overwrite variable              =
   |
+ +-------------+--------+--------+----------------------------------------=
---+
+
+The following values are supported for the ``func`` field. They
+correspond to the values used by ACPI function index 8.
+
+ +----------+-------------------------------------------------------------=
+
+ | Value    | Description                                                 =
|
+ +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+ | 0        | Operation is not implemented.                               =
|
+ +----------+-------------------------------------------------------------=
+
+ | 1        | Operation is only accessible through firmware.              =
|
+ +----------+-------------------------------------------------------------=
+
+ | 2        | Operation is blocked for OS by firmware configuration.      =
|
+ +----------+-------------------------------------------------------------=
+
+ | 3        | Operation is allowed and physically present user required.  =
|
+ +----------+-------------------------------------------------------------=
+
+ | 4        | Operation is allowed and physically present user is not     =
|
+ |          | required.                                                   =
|
+ +----------+-------------------------------------------------------------=
+
+
+The location of the table is given by the fw_cfg ``tpmppi_address``
+field.  The PPI memory region size is 0x400 (``TPM_PPI_ADDR_SIZE``) to
+leave enough room for future updates.
+
+QEMU files related to TPM ACPI tables:
+ - ``hw/i386/acpi-build.c``
+ - ``include/hw/acpi/tpm.h``
+
+TPM backend devices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The TPM implementation is split into two parts, frontend and
+backend. The frontend part is the hardware interface, such as the TPM
+TIS interface described earlier, and the other part is the TPM backend
+interface. The backend interfaces implement the interaction with a TPM
+device, which may be a physical or an emulated device. The split
+between the front- and backend devices allows a frontend to be
+connected with any available backend. This enables the TIS interface
+to be used with the passthrough backend or the swtpm backend.
+
+QEMU files related to TPM backends:
+ - ``backends/tpm.c``
+ - ``include/sysemu/tpm_backend.h``
+ - ``include/sysemu/tpm_backend_int.h``
+
+The QEMU TPM passthrough device
+-------------------------------
+
+In case QEMU is run on Linux as the host operating system it is
+possible to make the hardware TPM device available to a single QEMU
+guest. In this case the user must make sure that no other program is
+using the device, e.g., /dev/tpm0, before trying to start QEMU with
+it.
+
+The passthrough driver uses the host's TPM device for sending TPM
+commands and receiving responses from. Besides that it accesses the
+TPM device's sysfs entry for support of command cancellation. Since
+none of the state of a hardware TPM can be migrated between hosts,
+virtual machine migration is disabled when the TPM passthrough driver
+is used.
+
+Since the host's TPM device will already be initialized by the host's
+firmware, certain commands, e.g. ``TPM_Startup()``, sent by the
+virtual firmware for device initialization, will fail. In this case
+the firmware should not use the TPM.
+
+Sharing the device with the host is generally not a recommended usage
+scenario for a TPM device. The primary reason for this is that two
+operating systems can then access the device's single set of
+resources, such as platform configuration registers
+(PCRs). Applications or kernel security subsystems, such as the Linux
+Integrity Measurement Architecture (IMA), are not expecting to share
+PCRs.
+
+QEMU files related to the TPM passthrough device:
+ - ``hw/tpm/tpm_passthrough.c``
+ - ``hw/tpm/tpm_util.c``
+ - ``hw/tpm/tpm_util.h``
+
+
+Command line to start QEMU with the TPM passthrough device using the host'=
s
+hardware TPM ``/dev/tpm0``:
+
+.. code-block:: console
+
+  qemu-system-x86_64 -display sdl -accel kvm \
+  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
+  -tpmdev passthrough,id=3Dtpm0,path=3D/dev/tpm0 \
+  -device tpm-tis,tpmdev=3Dtpm0 test.img
+
+
+The following commands should result in similar output inside the VM
+with a Linux kernel that either has the TPM TIS driver built-in or
+available as a module:
+
+.. code-block:: console
+
+  # dmesg | grep -i tpm
+  [    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
+
+  # dmesg | grep TCPA
+  [    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
+      BXPCTCPA 0000001 BXPC 00000001)
+
+  # ls -l /dev/tpm*
+  crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
+
+  # find /sys/devices/ | grep pcrs$ | xargs cat
+  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
+  ...
+  PCR-23: 00 00 00 00 00 00 00 00 ...
+
+The QEMU TPM emulator device
+----------------------------
+
+The TPM emulator device uses an external TPM emulator called 'swtpm'
+for sending TPM commands to and receiving responses from. The swtpm
+program must have been started before trying to access it through the
+TPM emulator with QEMU.
+
+The TPM emulator implements a command channel for transferring TPM
+commands and responses as well as a control channel over which control
+commands can be sent. (see the `SWTPM protocol`_ specification)
+
+The control channel serves the purpose of resetting, initializing, and
+migrating the TPM state, among other things.
+
+The swtpm program behaves like a hardware TPM and therefore needs to
+be initialized by the firmware running inside the QEMU virtual
+machine.  One necessary step for initializing the device is to send
+the TPM_Startup command to it. SeaBIOS, for example, has been
+instrumented to initialize a TPM 1.2 or TPM 2 device using this
+command.
+
+QEMU files related to the TPM emulator device:
+ - ``hw/tpm/tpm_emulator.c``
+ - ``hw/tpm/tpm_util.c``
+ - ``hw/tpm/tpm_util.h``
+
+The following commands start the swtpm with a UnixIO control channel over
+a socket interface. They do not need to be run as root.
+
+.. code-block:: console
+
+  mkdir /tmp/mytpm1
+  swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
+    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
+    --log level=3D20
+
+Command line to start QEMU with the TPM emulator device communicating
+with the swtpm (x86):
+
+.. code-block:: console
+
+  qemu-system-x86_64 -display sdl -accel kvm \
+    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
+    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
+    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
+    -device tpm-tis,tpmdev=3Dtpm0 test.img
+
+In case a pSeries machine is emulated, use the following command line:
+
+.. code-block:: console
+
+  qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
+    -m 1024 -bios slof.bin -boot menu=3Don \
+    -nodefaults -device VGA -device pci-ohci -device usb-kbd \
+    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
+    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
+    -device tpm-spapr,tpmdev=3Dtpm0 \
+    -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
+    -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0 \
+    -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
+
+In case SeaBIOS is used as firmware, it should show the TPM menu item
+after entering the menu with 'ESC'.
+
+.. code-block:: console
+
+  Select boot device:
+  1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
+  [...]
+  5. Legacy option rom
+
+  t. TPM Configuration
+
+The following commands should result in similar output inside the VM
+with a Linux kernel that either has the TPM TIS driver built-in or
+available as a module:
+
+.. code-block:: console
+
+  # dmesg | grep -i tpm
+  [    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
+
+  # dmesg | grep TCPA
+  [    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
+      BXPCTCPA 0000001 BXPC 00000001)
+
+  # ls -l /dev/tpm*
+  crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
+
+  # find /sys/devices/ | grep pcrs$ | xargs cat
+  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
+  ...
+  PCR-23: 00 00 00 00 00 00 00 00 ...
+
+Migration with the TPM emulator
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+The TPM emulator supports the following types of virtual machine
+migration:
+
+- VM save / restore (migration into a file)
+- Network migration
+- Snapshotting (migration into storage like QoW2 or QED)
+
+The following command sequences can be used to test VM save / restore.
+
+In a 1st terminal start an instance of a swtpm using the following command=
:
+
+.. code-block:: console
+
+  mkdir /tmp/mytpm1
+  swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
+    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
+    --log level=3D20 --tpm2
+
+In a 2nd terminal start the VM:
+
+.. code-block:: console
+
+  qemu-system-x86_64 -display sdl -accel kvm \
+    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
+    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
+    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
+    -device tpm-tis,tpmdev=3Dtpm0 \
+    -monitor stdio \
+    test.img
+
+Verify that the attached TPM is working as expected using applications
+inside the VM.
+
+To store the state of the VM use the following command in the QEMU
+monitor in the 2nd terminal:
+
+.. code-block:: console
+
+  (qemu) migrate "exec:cat > testvm.bin"
+  (qemu) quit
+
+At this point a file called ``testvm.bin`` should exists and the swtpm
+and QEMU processes should have ended.
+
+To test 'VM restore' you have to start the swtpm with the same
+parameters as before. If previously a TPM 2 [--tpm2] was saved, --tpm2
+must now be passed again on the command line.
+
+In the 1st terminal restart the swtpm with the same command line as
+before:
+
+.. code-block:: console
+
+  swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
+    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
+    --log level=3D20 --tpm2
+
+In the 2nd terminal restore the state of the VM using the additional
+'-incoming' option.
+
+.. code-block:: console
+
+  qemu-system-x86_64 -display sdl -accel kvm \
+    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
+    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
+    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
+    -device tpm-tis,tpmdev=3Dtpm0 \
+    -incoming "exec:cat < testvm.bin" \
+    test.img
+
+Troubleshooting migration
+-------------------------
+
+There are several reasons why migration may fail. In case of problems,
+please ensure that the command lines adhere to the following rules
+and, if possible, that identical versions of QEMU and swtpm are used
+at all times.
+
+VM save and restore:
+
+ - QEMU command line parameters should be identical apart from the
+   '-incoming' option on VM restore
+
+ - swtpm command line parameters should be identical
+
+VM migration to 'localhost':
+
+ - QEMU command line parameters should be identical apart from the
+   '-incoming' option on the destination side
+
+ - swtpm command line parameters should point to two different
+   directories on the source and destination swtpm (--tpmstate dir=3D...)
+   (especially if different versions of libtpms were to be used on the
+   same machine).
+
+VM migration across the network:
+
+ - QEMU command line parameters should be identical apart from the
+   '-incoming' option on the destination side
+
+ - swtpm command line parameters should be identical
+
+VM Snapshotting:
+ - QEMU command line parameters should be identical
+
+ - swtpm command line parameters should be identical
+
+
+Besides that, migration failure reasons on the swtpm level may include
+the following:
+
+ - the versions of the swtpm on the source and destination sides are
+   incompatible
+
+   - downgrading of TPM state may not be supported
+
+   - the source and destination libtpms were compiled with different
+     compile-time options and the destination side refuses to accept the
+     state
+
+ - different migration keys are used on the source and destination side
+   and the destination side cannot decrypt the migrated state
+   (swtpm ... --migration-key ... )
+
+
+.. _TIS specification:
+   https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specif=
ic-tpm-interface-specification-tis/
+
+.. _CRB specification:
+   https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profi=
le-ptp-specification/
+
+
+.. _ACPI specification:
+   https://trustedcomputinggroup.org/tcg-acpi-specification/
+
+.. _PPI specification:
+   https://trustedcomputinggroup.org/resource/tcg-physical-presence-interf=
ace-specification/
+
+.. _SWTPM protocol:
+   https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls=
.pod
diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
deleted file mode 100644
index 9c3e67d8a7..0000000000
--- a/docs/specs/tpm.txt
+++ /dev/null
@@ -1,445 +0,0 @@
-QEMU TPM Device
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-=3D Guest-side Hardware Interface =3D
-
-The QEMU TPM emulation implements a TPM TIS hardware interface following t=
he
-Trusted Computing Group's specification "TCG PC Client Specific TPM Interf=
ace
-Specification (TIS)", Specification Version 1.3, 21 March 2013. This
-specification, or a later version of it, can be accessed from the followin=
g
-URL:
-
-https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-=
tpm-interface-specification-tis/
-
-The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
-0xfed44fff available to the guest operating system.
-
-
-QEMU files related to TPM TIS interface:
- - hw/tpm/tpm_tis.c
- - hw/tpm/tpm_tis.h
-
-
-QEMU also implements a TPM CRB interface following the Trusted Computing
-Group's specification "TCG PC Client Platform TPM Profile (PTP)
-Specification", Family "2.0", Level 00 Revision 01.03 v22, May 22, 2017.
-This specification, or a later version of it, can be accessed from the
-following URL:
-
-https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-=
ptp-specification/
-
-The CRB interface makes a memory mapped IO region in the area 0xfed40000 -
-0xfed40fff (1 locality) available to the guest operating system.
-
-QEMU files related to TPM CRB interface:
- - hw/tpm/tpm_crb.c
-
-
-pSeries (ppc64) machines offer a tpm-spapr device model.
-
-QEMU files related to the SPAPR interface:
- - hw/tpm/tpm_spapr.c
-
-=3D fw_cfg interface =3D
-
-The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
-configuring the guest appropriately.
-
-The entry of 6 bytes has the following content, in little-endian:
-
-    #define TPM_VERSION_UNSPEC          0
-    #define TPM_VERSION_1_2             1
-    #define TPM_VERSION_2_0             2
-
-    #define TPM_PPI_VERSION_NONE        0
-    #define TPM_PPI_VERSION_1_30        1
-
-    struct FwCfgTPMConfig {
-        uint32_t tpmppi_address;         /* PPI memory location */
-        uint8_t tpm_version;             /* TPM version */
-        uint8_t tpmppi_version;          /* PPI version */
-    };
-
-=3D ACPI Interface =3D
-
-The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and p=
asses
-it into the guest through the fw_cfg device. The device description contai=
ns
-the base address of the TIS interface 0xfed40000 and the size of the MMIO =
area
-(0x5000). In case a TPM2 is used by QEMU, a TPM2 ACPI table is also provid=
ed.
-The device is described to be used in polling mode rather than interrupt m=
ode
-primarily because no unused IRQ could be found.
-
-To support measurement logs to be written by the firmware, e.g. SeaBIOS, a=
 TCPA
-table is implemented. This table provides a 64kb buffer where the firmware=
 can
-write its log into. For TPM 2 only a more recent version of the TPM2 table
-provides support for measurements logs and a TCPA table does not need to b=
e
-created.
-
-The TCPA and TPM2 ACPI tables follow the Trusted Computing Group specifica=
tion
-"TCG ACPI Specification" Family "1.2" and "2.0", Level 00 Revision 00.37. =
This
-specification, or a later version of it, can be accessed from the followin=
g
-URL:
-
-https://trustedcomputinggroup.org/tcg-acpi-specification/
-
-=3D=3D ACPI PPI Interface =3D=3D
-
-QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and TPM 2.=
 This
-interface requires ACPI and firmware support. The specification can be fou=
nd at
-the following URL:
-
-https://trustedcomputinggroup.org/resource/tcg-physical-presence-interface=
-specification/
-
-PPI enables a system administrator (root) to request a modification to the
-TPM upon reboot. The PPI specification defines the operation requests and =
the
-actions the firmware has to take. The system administrator passes the oper=
ation
-request number to the firmware through an ACPI interface which writes this
-number to a memory location that the firmware knows. Upon reboot, the firm=
ware
-finds the number and sends commands to the TPM. The firmware writes the TP=
M
-result code and the operation request number to a memory location that ACP=
I can
-read from and pass the result on to the administrator.
-
-The PPI specification defines a set of mandatory and optional operations f=
or
-the firmware to implement. The ACPI interface also allows an administrator=
 to
-list the supported operations. In QEMU the ACPI code is generated by QEMU,=
 yet
-the firmware needs to implement support on a per-operations basis, and
-different firmwares may support a different subset. Therefore, QEMU introd=
uces
-the virtual memory device for PPI where the firmware can indicate which
-operations it supports and ACPI can enable the ones that are supported and
-disable all others. This interface lies in main memory and has the followi=
ng
-layout:
-
- +----------+--------+--------+-------------------------------------------=
+
- |  Field   | Length | Offset | Description                               =
|
- +----------+--------+--------+-------------------------------------------=
+
- | func     |  0x100 |  0x000 | Firmware sets values for each supported   =
|
- |          |        |        | operation. See defined values below.      =
|
- +----------+--------+--------+-------------------------------------------=
+
- | ppin     |   0x1  |  0x100 | SMI interrupt to use. Set by firmware.    =
|
- |          |        |        | Not supported.                            =
|
- +----------+--------+--------+-------------------------------------------=
+
- | ppip     |   0x4  |  0x101 | ACPI function index to pass to SMM code.  =
|
- |          |        |        | Set by ACPI. Not supported.               =
|
- +----------+--------+--------+-------------------------------------------=
+
- | pprp     |   0x4  |  0x105 | Result of last executed operation. Set by =
|
- |          |        |        | firmware. See function index 5 for values.=
|
- +----------+--------+--------+-------------------------------------------=
+
- | pprq     |   0x4  |  0x109 | Operation request number to execute. See  =
|
- |          |        |        | 'Physical Presence Interface Operation    =
|
- |          |        |        | Summary' tables in specs. Set by ACPI.    =
|
- +----------+--------+--------+-------------------------------------------=
+
- | pprm     |   0x4  |  0x10d | Operation request optional parameter.     =
|
- |          |        |        | Values depend on operation. Set by ACPI.  =
|
- +----------+--------+--------+-------------------------------------------=
+
- | lppr     |   0x4  |  0x111 | Last executed operation request number.   =
|
- |          |        |        | Copied from pprq field by firmware.       =
|
- +----------+--------+--------+-------------------------------------------=
+
- | fret     |   0x4  |  0x115 | Result code from SMM function.            =
|
- |          |        |        | Not supported.                            =
|
- +----------+--------+--------+-------------------------------------------=
+
- | res1     |  0x40  |  0x119 | Reserved for future use                   =
|
- +----------+--------+--------+-------------------------------------------=
+
- | next_step|   0x1  |  0x159 | Operation to execute after reboot by      =
|
- |          |        |        | firmware. Used by firmware.               =
|
- +----------+--------+--------+-------------------------------------------=
+
- | movv     |   0x1  |  0x15a | Memory overwrite variable                 =
|
- +----------+--------+--------+-------------------------------------------=
+
-
-   The following values are supported for the 'func' field. They correspon=
d
-   to the values used by ACPI function index 8.
-
- +----------+-------------------------------------------------------------=
+
- | value    | Description                                                 =
|
- +----------+-------------------------------------------------------------=
+
- | 0        | Operation is not implemented.                               =
|
- +----------+-------------------------------------------------------------=
+
- | 1        | Operation is only accessible through firmware.              =
|
- +----------+-------------------------------------------------------------=
+
- | 2        | Operation is blocked for OS by firmware configuration.      =
|
- +----------+-------------------------------------------------------------=
+
- | 3        | Operation is allowed and physically present user required.  =
|
- +----------+-------------------------------------------------------------=
+
- | 4        | Operation is allowed and physically present user is not     =
|
- |          | required.                                                   =
|
- +----------+-------------------------------------------------------------=
+
-
-The location of the table is given by the fw_cfg tpmppi_address field.
-The PPI memory region size is 0x400 (TPM_PPI_ADDR_SIZE) to leave
-enough room for future updates.
-
-
-QEMU files related to TPM ACPI tables:
- - hw/i386/acpi-build.c
- - include/hw/acpi/tpm.h
-
-
-=3D TPM backend devices =3D
-
-The TPM implementation is split into two parts, frontend and backend. The
-frontend part is the hardware interface, such as the TPM TIS interface
-described earlier, and the other part is the TPM backend interface. The ba=
ckend
-interfaces implement the interaction with a TPM device, which may be a phy=
sical
-or an emulated device. The split between the front- and backend devices al=
lows
-a frontend to be connected with any available backend. This enables the TI=
S
-interface to be used with the passthrough backend or the (future) swtpm ba=
ckend.
-
-
-QEMU files related to TPM backends:
- - backends/tpm.c
- - include/sysemu/tpm_backend.h
- - include/sysemu/tpm_backend_int.h
-
-
-=3D=3D The QEMU TPM passthrough device =3D=3D
-
-In case QEMU is run on Linux as the host operating system it is possible t=
o
-make the hardware TPM device available to a single QEMU guest. In this cas=
e the
-user must make sure that no other program is using the device, e.g., /dev/=
tpm0,
-before trying to start QEMU with it.
-
-The passthrough driver uses the host's TPM device for sending TPM commands
-and receiving responses from. Besides that it accesses the TPM device's sy=
sfs
-entry for support of command cancellation. Since none of the state of a
-hardware TPM can be migrated between hosts, virtual machine migration is
-disabled when the TPM passthrough driver is used.
-
-Since the host's TPM device will already be initialized by the host's firm=
ware,
-certain commands, e.g. TPM_Startup(), sent by the virtual firmware for dev=
ice
-initialization, will fail. In this case the firmware should not use the TP=
M.
-
-Sharing the device with the host is generally not a recommended usage scen=
ario
-for a TPM device. The primary reason for this is that two operating system=
s can
-then access the device's single set of resources, such as platform configu=
ration
-registers (PCRs). Applications or kernel security subsystems, such as the
-Linux Integrity Measurement Architecture (IMA), are not expecting to share=
 PCRs.
-
-
-QEMU files related to the TPM passthrough device:
- - hw/tpm/tpm_passthrough.c
- - hw/tpm/tpm_util.c
- - hw/tpm/tpm_util.h
-
-
-Command line to start QEMU with the TPM passthrough device using the host'=
s
-hardware TPM /dev/tpm0:
-
-qemu-system-x86_64 -display sdl -accel kvm \
-  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
-  -tpmdev passthrough,id=3Dtpm0,path=3D/dev/tpm0 \
-  -device tpm-tis,tpmdev=3Dtpm0 test.img
-
-The following commands should result in similar output inside the VM with =
a
-Linux kernel that either has the TPM TIS driver built-in or available as a
-module:
-
-#> dmesg | grep -i tpm
-[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
-
-#> dmesg | grep TCPA
-[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
-    BXPCTCPA 0000001 BXPC 00000001)
-
-#> ls -l /dev/tpm*
-crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
-
-#> find /sys/devices/ | grep pcrs$ | xargs cat
-PCR-00: 35 4E 3B CE 23 9F 38 59 ...
-...
-PCR-23: 00 00 00 00 00 00 00 00 ...
-
-
-=3D=3D The QEMU TPM emulator device =3D=3D
-
-The TPM emulator device uses an external TPM emulator called 'swtpm' for
-sending TPM commands to and receiving responses from. The swtpm program
-must have been started before trying to access it through the TPM emulator
-with QEMU.
-
-The TPM emulator implements a command channel for transferring TPM command=
s
-and responses as well as a control channel over which control commands can
-be sent. The specification for the control channel can be found here:
-
-https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.po=
d
-
-
-The control channel serves the purpose of resetting, initializing, and
-migrating the TPM state, among other things.
-
-The swtpm program behaves like a hardware TPM and therefore needs to be
-initialized by the firmware running inside the QEMU virtual machine.
-One necessary step for initializing the device is to send the TPM_Startup
-command to it. SeaBIOS, for example, has been instrumented to initialize
-a TPM 1.2 or TPM 2 device using this command.
-
-
-QEMU files related to the TPM emulator device:
- - hw/tpm/tpm_emulator.c
- - hw/tpm/tpm_util.c
- - hw/tpm/tpm_util.h
-
-
-The following commands start the swtpm with a UnixIO control channel over
-a socket interface. They do not need to be run as root.
-
-mkdir /tmp/mytpm1
-swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
-  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
-  --log level=3D20
-
-Command line to start QEMU with the TPM emulator device communicating with
-the swtpm (x86):
-
-qemu-system-x86_64 -display sdl -accel kvm \
-  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
-  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
-  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-  -device tpm-tis,tpmdev=3Dtpm0 test.img
-
-In case a pSeries machine is emulated, use the following command line:
-
-qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
-  -m 1024 -bios slof.bin -boot menu=3Don \
-  -nodefaults -device VGA -device pci-ohci -device usb-kbd \
-  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
-  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-  -device tpm-spapr,tpmdev=3Dtpm0 \
-  -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
-  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0 \
-  -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
-
-
-In case SeaBIOS is used as firmware, it should show the TPM menu item
-after entering the menu with 'ESC'.
-
-Select boot device:
-1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
-[...]
-5. Legacy option rom
-
-t. TPM Configuration
-
-
-The following commands should result in similar output inside the VM with =
a
-Linux kernel that either has the TPM TIS driver built-in or available as a
-module:
-
-#> dmesg | grep -i tpm
-[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
-
-#> dmesg | grep TCPA
-[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
-    BXPCTCPA 0000001 BXPC 00000001)
-
-#> ls -l /dev/tpm*
-crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
-
-#> find /sys/devices/ | grep pcrs$ | xargs cat
-PCR-00: 35 4E 3B CE 23 9F 38 59 ...
-...
-PCR-23: 00 00 00 00 00 00 00 00 ...
-
-
-=3D=3D=3D Migration with the TPM emulator =3D=3D=3D
-
-The TPM emulator supports the following types of virtual machine migration=
:
-
-- VM save / restore (migration into a file)
-- Network migration
-- Snapshotting (migration into storage like QoW2 or QED)
-
-The following command sequences can be used to test VM save / restore.
-
-
-In a 1st terminal start an instance of a swtpm using the following command=
:
-
-mkdir /tmp/mytpm1
-swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
-  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
-  --log level=3D20 --tpm2
-
-In a 2nd terminal start the VM:
-
-qemu-system-x86_64 -display sdl -accel kvm \
-  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
-  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
-  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-  -device tpm-tis,tpmdev=3Dtpm0 \
-  -monitor stdio \
-  test.img
-
-Verify that the attached TPM is working as expected using applications ins=
ide
-the VM.
-
-To store the state of the VM use the following command in the QEMU monitor=
 in
-the 2nd terminal:
-
-(qemu) migrate "exec:cat > testvm.bin"
-(qemu) quit
-
-At this point a file called 'testvm.bin' should exists and the swtpm and Q=
EMU
-processes should have ended.
-
-To test 'VM restore' you have to start the swtpm with the same parameters
-as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now be
-passed again on the command line.
-
-In the 1st terminal restart the swtpm with the same command line as before=
:
-
-swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
-  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
-  --log level=3D20 --tpm2
-
-In the 2nd terminal restore the state of the VM using the additional
-'-incoming' option.
-
-qemu-system-x86_64 -display sdl -accel kvm \
-  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
-  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
-  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-  -device tpm-tis,tpmdev=3Dtpm0 \
-  -incoming "exec:cat < testvm.bin" \
-  test.img
-
-
-Troubleshooting migration:
-
-There are several reasons why migration may fail. In case of problems,
-please ensure that the command lines adhere to the following rules and,
-if possible, that identical versions of QEMU and swtpm are used at all
-times.
-
-VM save and restore:
- - QEMU command line parameters should be identical apart from the
-   '-incoming' option on VM restore
- - swtpm command line parameters should be identical
-
-VM migration to 'localhost':
- - QEMU command line parameters should be identical apart from the
-   '-incoming' option on the destination side
- - swtpm command line parameters should point to two different
-   directories on the source and destination swtpm (--tpmstate dir=3D...)
-   (especially if different versions of libtpms were to be used on the
-   same machine).
-
-VM migration across the network:
- - QEMU command line parameters should be identical apart from the
-   '-incoming' option on the destination side
- - swtpm command line parameters should be identical
-
-VM Snapshotting:
- - QEMU command line parameters should be identical
- - swtpm command line parameters should be identical
-
-
-Besides that, migration failure reasons on the swtpm level may include
-the following:
-
- - the versions of the swtpm on the source and destination sides are
-   incompatible
-   - downgrading of TPM state may not be supported
-   - the source and destination libtpms were compiled with different
-     compile-time options and the destination side refuses to accept the
-     state
- - different migration keys are used on the source and destination side
-   and the destination side cannot decrypt the migrated state
-   (swtpm ... --migration-key ... )
--=20
2.24.0.308.g228f53135a


