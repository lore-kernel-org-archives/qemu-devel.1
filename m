Received: from eggs.gnu.org ([2001:4830:134:3::10]:39570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJykL-0005qp-NU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJyWO-0005Eg-Hn
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 11:23:29 +0100
Message-Id: <20181106102335.20027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] Introducing QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Trying to fill the need to be more finegrained on support status.

v2:
 - reduce the number of support states, add documentation for them.
 - move QemuSupportState to ObjectClass, to simplify introspection
   integration (not done yet).
 - add UsageHints.

Gerd Hoffmann (6):
  move ObjectClass to typedefs.h
  add QemuSupportState
  Use QemuSupportState for machine types.
  Warn on obsolete and deprecated devices.
  tag cirrus as obsolete
  add UsageHints to QemuSupportState

 include/hw/boards.h          |  3 ---
 include/qemu/support-state.h | 18 +++++++++++++
 include/qemu/typedefs.h      |  1 +
 include/qom/object.h         |  4 ++-
 hw/core/qdev.c               |  8 +++++-
 hw/display/cirrus_vga.c      |  3 +++
 hw/display/cirrus_vga_isa.c  |  3 +++
 hw/i386/pc_piix.c            |  5 +++-
 hw/ppc/prep.c                |  5 +++-
 qdev-monitor.c               |  9 +++++++
 util/support-state.c         | 26 +++++++++++++++++++
 vl.c                         |  7 ++---
 qapi/common.json             | 61 ++++++++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs           |  1 +
 14 files changed, 144 insertions(+), 10 deletions(-)
 create mode 100644 include/qemu/support-state.h
 create mode 100644 util/support-state.c

-- 
2.9.3
