Received: from eggs.gnu.org ([2001:4830:134:3::10]:53658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRyC-0000xq-IN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRy9-00085R-3j
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 12:13:44 +0100
Message-Id: <20181030111348.14713-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Introducing QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Trying to fill the need to be more finegrained on support status ...

Any hints/patches how to hook that into introspection so we get
machine type / device support status to libvirt are welcome.

Gerd Hoffmann (4):
  add QemuSupportState
  add QemuSupportState to DeviceClass
  tag cirrus as obsolete
  switch machine types to QemuSupportState

 include/hw/boards.h          |  5 ++---
 include/hw/qdev-core.h       |  2 ++
 include/qemu/support-state.h | 17 +++++++++++++++++
 hw/core/qdev.c               |  8 +++++++-
 hw/display/cirrus_vga.c      |  3 +++
 hw/display/cirrus_vga_isa.c  |  3 +++
 hw/i386/pc_piix.c            |  3 ++-
 hw/ppc/prep.c                |  3 ++-
 qdev-monitor.c               |  7 +++++++
 util/support-state.c         | 23 +++++++++++++++++++++++
 vl.c                         |  6 +++---
 qapi/common.json             | 16 ++++++++++++++++
 util/Makefile.objs           |  1 +
 13 files changed, 88 insertions(+), 9 deletions(-)
 create mode 100644 include/qemu/support-state.h
 create mode 100644 util/support-state.c

-- 
2.9.3
