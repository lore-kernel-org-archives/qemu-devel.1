Received: from eggs.gnu.org ([2001:4830:134:3::10]:56507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpvyk-0003uF-VU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpvyh-0000Ms-UW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cpvyh-0000Lr-OQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:59:59 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Mon, 20 Mar 2017 12:59:49 +0100
Message-Id: <20170320115951.25345-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] some remaining vmgenid tweaks for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

We've discussed both of these earlier (multiple times), and I'd been
hoping that Ben would submit them. I guess I can send out a reminder
formatted as a patch series. (I don't intend to post several iterations
of this.)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>

Thanks
Laszlo

Laszlo Ersek (2):
  hw/acpi/vmgenid: prevent device realization on pre-2.9 machine types
  hw/acpi/vmgenid: prevent more than one vmgenid device

 include/hw/acpi/vmgenid.h |  1 +
 include/hw/compat.h       |  4 ++++
 hw/acpi/vmgenid.c         | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

-- 
2.9.3
