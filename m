Received: from eggs.gnu.org ([2001:4830:134:3::10]:55237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhgYn-0003vb-KX
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhgYj-0001I3-IB
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:31:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fhgYj-0001He-DJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:31:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jul 2018 16:31:43 -0300
Message-Id: <20180723193145.24705-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 0/2] ACPI type safety cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

Small cleanup to make the ACPI callback functions harder to
misuse.

Eduardo Habkost (2):
  acpi: Improve acpi_send_event() type safety
  acpi: Decouple ACPI hotplug callbacks from HotplugHandler

 include/hw/acpi/acpi_dev_interface.h |  2 +-
 include/hw/acpi/cpu.h                |  5 ++---
 include/hw/acpi/cpu_hotplug.h        |  2 +-
 include/hw/acpi/memory_hotplug.h     |  4 ++--
 include/hw/acpi/pcihp.h              |  4 ++--
 include/hw/mem/nvdimm.h              |  3 ++-
 hw/acpi/acpi_interface.c             |  5 ++---
 hw/acpi/cpu.c                        |  8 ++++----
 hw/acpi/cpu_hotplug.c                |  4 ++--
 hw/acpi/ich9.c                       | 14 ++++++++------
 hw/acpi/memory_hotplug.c             |  8 ++++----
 hw/acpi/nvdimm.c                     |  4 ++--
 hw/acpi/pcihp.c                      |  8 ++++----
 hw/acpi/piix4.c                      | 18 ++++++++++--------
 hw/acpi/vmgenid.c                    |  2 +-
 15 files changed, 47 insertions(+), 44 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
