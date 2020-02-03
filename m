Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74525C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70402080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gfeGQSg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70402080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV4h-00080V-Ob
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxZ-0002us-2H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxS-0002jS-GJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:48 -0500
Received: from ozlabs.org ([203.11.71.1]:32889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxR-0002cT-H5; Mon, 03 Feb 2020 01:11:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBq0ZzNz9sSZ; Mon,  3 Feb 2020 17:11:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710291;
 bh=9vfuq3Pt8p0OO2vMbqtQTPn8S+3Ztyw7AsWGda7qqYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gfeGQSg7ZN1vWR2865TmsxoEVcVgea9vW6bOYT0yRL5Yk/Ig4lk+39W3NNlnjuWsF
 uqerdMW1T0rBO2X4U/0Clw5X+SecNJxDyMYQrP9eNIA1jLPKwueFcEfubclGyY5mWR
 U8PMuvm80CXsmX+cTWA4tDiuM4HbWttlLLGGa5P8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/35] docs/specs/tpm: reST-ify TPM documentation
Date: Mon,  3 Feb 2020 17:11:06 +1100
Message-Id: <20200203061123.59150-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20200121152935.649898-7-stefanb@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
+ +-------------+--------+--------+--------------------------------------=
-----+
+ |  Field      | Length | Offset | Description                          =
     |
+ +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
+ | ``func``    |  0x100 |  0x000 | Firmware sets values for each support=
ed   |
+ |             |        |        | operation. See defined values below. =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``ppin``    |   0x1  |  0x100 | SMI interrupt to use. Set by firmware=
.    |
+ |             |        |        | Not supported.                       =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``ppip``    |   0x4  |  0x101 | ACPI function index to pass to SMM co=
de.  |
+ |             |        |        | Set by ACPI. Not supported.          =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``pprp``    |   0x4  |  0x105 | Result of last executed operation. Se=
t by |
+ |             |        |        | firmware. See function index 5 for va=
lues.|
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``pprq``    |   0x4  |  0x109 | Operation request number to execute. =
See  |
+ |             |        |        | 'Physical Presence Interface Operatio=
n    |
+ |             |        |        | Summary' tables in specs. Set by ACPI=
.    |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``pprm``    |   0x4  |  0x10d | Operation request optional parameter.=
     |
+ |             |        |        | Values depend on operation. Set by AC=
PI.  |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``lppr``    |   0x4  |  0x111 | Last executed operation request numbe=
r.   |
+ |             |        |        | Copied from pprq field by firmware.  =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``fret``    |   0x4  |  0x115 | Result code from SMM function.       =
     |
+ |             |        |        | Not supported.                       =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``res1``    |  0x40  |  0x119 | Reserved for future use              =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ |``next_step``|   0x1  |  0x159 | Operation to execute after reboot by =
     |
+ |             |        |        | firmware. Used by firmware.          =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+ | ``movv``    |   0x1  |  0x15a | Memory overwrite variable            =
     |
+ +-------------+--------+--------+--------------------------------------=
-----+
+
+The following values are supported for the ``func`` field. They
+correspond to the values used by ACPI function index 8.
+
+ +----------+-----------------------------------------------------------=
--+
+ | Value    | Description                                               =
  |
+ +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+ | 0        | Operation is not implemented.                             =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 1        | Operation is only accessible through firmware.            =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 2        | Operation is blocked for OS by firmware configuration.    =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 3        | Operation is allowed and physically present user required.=
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 4        | Operation is allowed and physically present user is not   =
  |
+ |          | required.                                                 =
  |
+ +----------+-----------------------------------------------------------=
--+
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
+Command line to start QEMU with the TPM passthrough device using the hos=
t's
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
+The following commands start the swtpm with a UnixIO control channel ove=
r
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
+    -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddri=
ve-virtio-disk0,id=3Dvirtio-disk0 \
+    -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk=
0
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
+In a 1st terminal start an instance of a swtpm using the following comma=
nd:
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
+   directories on the source and destination swtpm (--tpmstate dir=3D...=
)
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
+   https://trustedcomputinggroup.org/pc-client-work-group-pc-client-spec=
ific-tpm-interface-specification-tis/
+
+.. _CRB specification:
+   https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-pro=
file-ptp-specification/
+
+
+.. _ACPI specification:
+   https://trustedcomputinggroup.org/tcg-acpi-specification/
+
+.. _PPI specification:
+   https://trustedcomputinggroup.org/resource/tcg-physical-presence-inte=
rface-specification/
+
+.. _SWTPM protocol:
+   https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioct=
ls.pod
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
-The QEMU TPM emulation implements a TPM TIS hardware interface following=
 the
-Trusted Computing Group's specification "TCG PC Client Specific TPM Inte=
rface
-Specification (TIS)", Specification Version 1.3, 21 March 2013. This
-specification, or a later version of it, can be accessed from the follow=
ing
-URL:
-
-https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specifi=
c-tpm-interface-specification-tis/
-
-The TIS interface makes a memory mapped IO region in the area 0xfed40000=
 -
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
-https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profil=
e-ptp-specification/
-
-The CRB interface makes a memory mapped IO region in the area 0xfed40000=
 -
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
-The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and=
 passes
-it into the guest through the fw_cfg device. The device description cont=
ains
-the base address of the TIS interface 0xfed40000 and the size of the MMI=
O area
-(0x5000). In case a TPM2 is used by QEMU, a TPM2 ACPI table is also prov=
ided.
-The device is described to be used in polling mode rather than interrupt=
 mode
-primarily because no unused IRQ could be found.
-
-To support measurement logs to be written by the firmware, e.g. SeaBIOS,=
 a TCPA
-table is implemented. This table provides a 64kb buffer where the firmwa=
re can
-write its log into. For TPM 2 only a more recent version of the TPM2 tab=
le
-provides support for measurements logs and a TCPA table does not need to=
 be
-created.
-
-The TCPA and TPM2 ACPI tables follow the Trusted Computing Group specifi=
cation
-"TCG ACPI Specification" Family "1.2" and "2.0", Level 00 Revision 00.37=
. This
-specification, or a later version of it, can be accessed from the follow=
ing
-URL:
-
-https://trustedcomputinggroup.org/tcg-acpi-specification/
-
-=3D=3D ACPI PPI Interface =3D=3D
-
-QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and TPM =
2. This
-interface requires ACPI and firmware support. The specification can be f=
ound at
-the following URL:
-
-https://trustedcomputinggroup.org/resource/tcg-physical-presence-interfa=
ce-specification/
-
-PPI enables a system administrator (root) to request a modification to t=
he
-TPM upon reboot. The PPI specification defines the operation requests an=
d the
-actions the firmware has to take. The system administrator passes the op=
eration
-request number to the firmware through an ACPI interface which writes th=
is
-number to a memory location that the firmware knows. Upon reboot, the fi=
rmware
-finds the number and sends commands to the TPM. The firmware writes the =
TPM
-result code and the operation request number to a memory location that A=
CPI can
-read from and pass the result on to the administrator.
-
-The PPI specification defines a set of mandatory and optional operations=
 for
-the firmware to implement. The ACPI interface also allows an administrat=
or to
-list the supported operations. In QEMU the ACPI code is generated by QEM=
U, yet
-the firmware needs to implement support on a per-operations basis, and
-different firmwares may support a different subset. Therefore, QEMU intr=
oduces
-the virtual memory device for PPI where the firmware can indicate which
-operations it supports and ACPI can enable the ones that are supported a=
nd
-disable all others. This interface lies in main memory and has the follo=
wing
-layout:
-
- +----------+--------+--------+-----------------------------------------=
--+
- |  Field   | Length | Offset | Description                             =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | func     |  0x100 |  0x000 | Firmware sets values for each supported =
  |
- |          |        |        | operation. See defined values below.    =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | ppin     |   0x1  |  0x100 | SMI interrupt to use. Set by firmware.  =
  |
- |          |        |        | Not supported.                          =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | ppip     |   0x4  |  0x101 | ACPI function index to pass to SMM code.=
  |
- |          |        |        | Set by ACPI. Not supported.             =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | pprp     |   0x4  |  0x105 | Result of last executed operation. Set b=
y |
- |          |        |        | firmware. See function index 5 for value=
s.|
- +----------+--------+--------+-----------------------------------------=
--+
- | pprq     |   0x4  |  0x109 | Operation request number to execute. See=
  |
- |          |        |        | 'Physical Presence Interface Operation  =
  |
- |          |        |        | Summary' tables in specs. Set by ACPI.  =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | pprm     |   0x4  |  0x10d | Operation request optional parameter.   =
  |
- |          |        |        | Values depend on operation. Set by ACPI.=
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | lppr     |   0x4  |  0x111 | Last executed operation request number. =
  |
- |          |        |        | Copied from pprq field by firmware.     =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | fret     |   0x4  |  0x115 | Result code from SMM function.          =
  |
- |          |        |        | Not supported.                          =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | res1     |  0x40  |  0x119 | Reserved for future use                 =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | next_step|   0x1  |  0x159 | Operation to execute after reboot by    =
  |
- |          |        |        | firmware. Used by firmware.             =
  |
- +----------+--------+--------+-----------------------------------------=
--+
- | movv     |   0x1  |  0x15a | Memory overwrite variable               =
  |
- +----------+--------+--------+-----------------------------------------=
--+
-
-   The following values are supported for the 'func' field. They corresp=
ond
-   to the values used by ACPI function index 8.
-
- +----------+-----------------------------------------------------------=
--+
- | value    | Description                                               =
  |
- +----------+-----------------------------------------------------------=
--+
- | 0        | Operation is not implemented.                             =
  |
- +----------+-----------------------------------------------------------=
--+
- | 1        | Operation is only accessible through firmware.            =
  |
- +----------+-----------------------------------------------------------=
--+
- | 2        | Operation is blocked for OS by firmware configuration.    =
  |
- +----------+-----------------------------------------------------------=
--+
- | 3        | Operation is allowed and physically present user required.=
  |
- +----------+-----------------------------------------------------------=
--+
- | 4        | Operation is allowed and physically present user is not   =
  |
- |          | required.                                                 =
  |
- +----------+-----------------------------------------------------------=
--+
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
-The TPM implementation is split into two parts, frontend and backend. Th=
e
-frontend part is the hardware interface, such as the TPM TIS interface
-described earlier, and the other part is the TPM backend interface. The =
backend
-interfaces implement the interaction with a TPM device, which may be a p=
hysical
-or an emulated device. The split between the front- and backend devices =
allows
-a frontend to be connected with any available backend. This enables the =
TIS
-interface to be used with the passthrough backend or the (future) swtpm =
backend.
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
-In case QEMU is run on Linux as the host operating system it is possible=
 to
-make the hardware TPM device available to a single QEMU guest. In this c=
ase the
-user must make sure that no other program is using the device, e.g., /de=
v/tpm0,
-before trying to start QEMU with it.
-
-The passthrough driver uses the host's TPM device for sending TPM comman=
ds
-and receiving responses from. Besides that it accesses the TPM device's =
sysfs
-entry for support of command cancellation. Since none of the state of a
-hardware TPM can be migrated between hosts, virtual machine migration is
-disabled when the TPM passthrough driver is used.
-
-Since the host's TPM device will already be initialized by the host's fi=
rmware,
-certain commands, e.g. TPM_Startup(), sent by the virtual firmware for d=
evice
-initialization, will fail. In this case the firmware should not use the =
TPM.
-
-Sharing the device with the host is generally not a recommended usage sc=
enario
-for a TPM device. The primary reason for this is that two operating syst=
ems can
-then access the device's single set of resources, such as platform confi=
guration
-registers (PCRs). Applications or kernel security subsystems, such as th=
e
-Linux Integrity Measurement Architecture (IMA), are not expecting to sha=
re PCRs.
-
-
-QEMU files related to the TPM passthrough device:
- - hw/tpm/tpm_passthrough.c
- - hw/tpm/tpm_util.c
- - hw/tpm/tpm_util.h
-
-
-Command line to start QEMU with the TPM passthrough device using the hos=
t's
-hardware TPM /dev/tpm0:
-
-qemu-system-x86_64 -display sdl -accel kvm \
-  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
-  -tpmdev passthrough,id=3Dtpm0,path=3D/dev/tpm0 \
-  -device tpm-tis,tpmdev=3Dtpm0 test.img
-
-The following commands should result in similar output inside the VM wit=
h a
-Linux kernel that either has the TPM TIS driver built-in or available as=
 a
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
-must have been started before trying to access it through the TPM emulat=
or
-with QEMU.
-
-The TPM emulator implements a command channel for transferring TPM comma=
nds
-and responses as well as a control channel over which control commands c=
an
-be sent. The specification for the control channel can be found here:
-
-https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.=
pod
-
-
-The control channel serves the purpose of resetting, initializing, and
-migrating the TPM state, among other things.
-
-The swtpm program behaves like a hardware TPM and therefore needs to be
-initialized by the firmware running inside the QEMU virtual machine.
-One necessary step for initializing the device is to send the TPM_Startu=
p
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
-The following commands start the swtpm with a UnixIO control channel ove=
r
-a socket interface. They do not need to be run as root.
-
-mkdir /tmp/mytpm1
-swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
-  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
-  --log level=3D20
-
-Command line to start QEMU with the TPM emulator device communicating wi=
th
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
-  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0 \
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
-The following commands should result in similar output inside the VM wit=
h a
-Linux kernel that either has the TPM TIS driver built-in or available as=
 a
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
-The TPM emulator supports the following types of virtual machine migrati=
on:
-
-- VM save / restore (migration into a file)
-- Network migration
-- Snapshotting (migration into storage like QoW2 or QED)
-
-The following command sequences can be used to test VM save / restore.
-
-
-In a 1st terminal start an instance of a swtpm using the following comma=
nd:
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
-Verify that the attached TPM is working as expected using applications i=
nside
-the VM.
-
-To store the state of the VM use the following command in the QEMU monit=
or in
-the 2nd terminal:
-
-(qemu) migrate "exec:cat > testvm.bin"
-(qemu) quit
-
-At this point a file called 'testvm.bin' should exists and the swtpm and=
 QEMU
-processes should have ended.
-
-To test 'VM restore' you have to start the swtpm with the same parameter=
s
-as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now be
-passed again on the command line.
-
-In the 1st terminal restart the swtpm with the same command line as befo=
re:
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
-   directories on the source and destination swtpm (--tpmstate dir=3D...=
)
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
2.24.1


