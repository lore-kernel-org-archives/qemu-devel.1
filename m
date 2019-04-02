Received: from eggs.gnu.org ([209.51.188.92]:34595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBM7w-0007aY-7t
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBM7v-0006YK-F5
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBM7v-0006Xr-7I
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 18:18:57 +0200
Message-Id: <20190402161900.7374-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] acpi: More trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com

I wrote these patches to help me debug an unplug failure.  I expect
them to be helpful for others, too.

Markus Armbruster (3):
  acpi/piix4: Convert debug printf()s to trace events
  acpi/pcihp: Convert debug printf()s to trace events
  acpi/pcihp: Add a few more trace points related to unplug

 hw/acpi/pcihp.c      | 32 +++++++++++++++-----------------
 hw/acpi/piix4.c      | 14 +++-----------
 hw/acpi/trace-events | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 28 deletions(-)

-- 
2.17.2
