Received: from eggs.gnu.org ([2001:4830:134:3::10]:38941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cq0l1-0000Ib-Px
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cq0kw-0006ck-Tb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cq0kw-0006cI-Jo
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:06:06 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Mon, 20 Mar 2017 18:05:55 +0100
Message-Id: <20170320170557.15645-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] some remaining vmgenid tweaks for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

V2 changes are documented per patch.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Laszlo Ersek (2):
  hw/acpi/vmgenid: prevent device realization on pre-2.5 machine types
  hw/acpi/vmgenid: prevent more than one vmgenid device

 include/hw/acpi/vmgenid.h |  2 ++
 include/hw/compat.h       |  4 ++++
 hw/acpi/vmgenid.c         | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)

-- 
2.9.3
