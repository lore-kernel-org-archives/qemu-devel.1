Received: from eggs.gnu.org ([2001:4830:134:3::10]:59670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fnF5a-0005g1-NH
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fnF5X-0004A3-IT
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:24:46 -0400
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:44868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fnF5X-00049g-Ci
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:24:43 -0400
Received: by mail-yw1-xc29.google.com with SMTP id l9-v6so550901ywc.11
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 20:24:43 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <153369867013.4449.6363841208074107078@sif>
Date: Tue, 07 Aug 2018 22:24:30 -0500
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 3.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.0.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-3.0.0-rc4.tar.xz.sig

Note:

  Due to the need for this additional release candidate, the final
  release is now planned for next week, August 14th (assuming no serious
  bugs are found).

You can help improve the quality of the QEMU 3.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.0

Please add entries to the ChangeLog for the 3.0 release below:

  http://wiki.qemu.org/ChangeLog/3.0

Thank you to everyone involved!

Changes since rc3:

6ad9080538: Update version for v3.0.0-rc4 release (Peter Maydell)
93f874fe9d: virtio-gpu: fix crashes upon warm reboot with vga mode (Marc-An=
dr=C3=A9 Lureau)
09b94ac0f2: slirp: Correct size check in m_inc() (Peter Maydell)
09d98b6980: target/xtensa/cpu: Set owner of memory region in xtensa_cpu_ini=
tfn (Thomas Huth)
341823c172: hw/intc/arm_gicv3_common: Move gicd shift bug handling to gicv3=
_post_load (Peter Maydell)
326049cc8e: hw/intc/arm_gicv3_common: Move post_load hooks to top-level VMS=
D (Peter Maydell)
7b69454a12: target/arm: Add dummy needed functions to M profile vmstate sub=
sections (Peter Maydell)
adc4fda6d5: hw/intc/arm_gicv3_common: Combine duplicate .subsections in vms=
tate_gicv3_cpu (Peter Maydell)
78e9ddd75e: hw/intc/arm_gicv3_common: Give no-migration-shift-bug subsectio=
n a needed function (Peter Maydell)
1fb57da72a: tcg/optimize: Do not skip default processing of dup_vec (Richar=
d Henderson)
1c707d6990: tests/acpi: update tables after memory hotplug changes (Michael=
 S. Tsirkin)
10efd7e108: pc: acpi: fix memory hotplug regression by reducing stub SRAT e=
ntry size (Igor Mammedov)
16e2841d20: tests/acpi-test: update ACPI tables test blobs (Dou Liyang)
16b4226363: hw/acpi-build: Add a check for memory-less NUMA nodes (Dou Liya=
ng)
388a86df9c: vhost: check region type before casting (Tiwei Bie)
6484ab3dff: sam460ex: Fix PCI interrupts with multiple devices (BALATON Zol=
tan)
1069a3c6e1: hw/misc/macio: Fix device introspection problems in macio devic=
es (Thomas Huth)
