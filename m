Received: from eggs.gnu.org ([209.51.188.92]:48861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gm16k-00067h-IE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gm16c-0006il-SG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:49:08 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 22 Jan 2019 13:51:31 +0100
Message-Id: <20190122125133.1191-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] s390x/pci: PCI bridge plugging fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Hotplugging of PCI bridges is right now pretty much broken. Coldplugging
and hotplugging will assign wrong primary bus numbers in some scenarios.

I base my knowledge on how this is supposed to work on
http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html

I did a couple of tests, building whole hierarchies of bridges, both
hot and coldplugged. "info pci" as well as the Linux guests showed
what I was expecting.

David Hildenbrand (2):
  s390x/pci: Fix primary bus number for PCI bridges
  s390x/pci: Fix hotplugging of PCI bridges

 hw/s390x/s390-pci-bus.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.17.2
