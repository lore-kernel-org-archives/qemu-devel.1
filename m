Received: from eggs.gnu.org ([209.51.188.92]:39658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2HNN-0001AS-Qd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2HNN-0003OS-3Z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:25:33 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  8 Mar 2019 16:25:09 +0100
Message-Id: <20190308152511.10882-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] machine: Move nvdimms state into struct
 MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com, philmd@redhat.com

As NVDIMM support is looming for ARM and SPAPR, let's
move the acpi_nvdimm_state to the generic machine struct
instead of duplicating the same code in several machines.

nvdimm and nvdimm-persistence become generic machine options.
They become guarded by a nvdimm_supported machine class member.

Best regards

Eric

https://github.com/eauger/qemu/tree/nvdimms_state_v3

Eric Auger (2):
  nvdimm: Rename AcpiNVDIMMState into NVDIMMState
  machine: Move nvdimms state into struct MachineState

 hw/acpi/nvdimm.c        | 18 ++++++------
 hw/core/machine.c       | 65 +++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c    |  6 ++--
 hw/i386/pc.c            | 57 ++++--------------------------------
 hw/i386/pc_piix.c       |  4 +--
 hw/i386/pc_q35.c        |  4 +--
 include/hw/boards.h     |  2 ++
 include/hw/i386/pc.h    |  4 ---
 include/hw/mem/nvdimm.h | 10 +++----
 9 files changed, 93 insertions(+), 77 deletions(-)

--=20
2.20.1
