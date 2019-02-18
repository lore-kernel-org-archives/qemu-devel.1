Received: from eggs.gnu.org ([209.51.188.92]:58243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf81-0001sL-SD
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf81-0002ey-6g
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:21 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 10:21:56 +0100
Message-Id: <20190218092202.26683-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] tests: Add device unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

This is a set of tests to test basic device unplugging functionality for
- some PCI implementations
- CCW devices on s390x
- spapr memory and cpu core devices

I plaed with ACPI CPU unplug but getting that to run with qtest is more
involved. (remove devices on reset, trick cpu-hotplug-legacy property,
somehow create cpu hotplug state objects ...). Well we no have at least
one unplug test for DIMMs and one for CPUs.

v2 -> v3:
- Use a smaller DIMM for spapr memory unplug request test
- Combine both spapr test registrations in a single if statement
- Use "-" instead of "_" in test names
- Add a huge load of r-b/a-b :) hpe I didn't forget some.

v1 -> v2:
- Tests for CCW, spapr memory and spapr cpu core unplug added
- Fix a deadlock when unplugging dummy CPUs
- Style fixes / simplifications (Thomas)
- Don't use the global_qtest variable (Thomas)
- Fix double-free (Greg)

David Hildenbrand (6):
  cpus: Properly release the iothread lock when killing a dummy VCPU
  spapr: support memory unplug for qtest
  tests/device-plug: Add a simple PCI unplug request test
  tests/device-plug: Add CCW unplug test for s390x
  tests/device-plug: Add CPU core unplug request test for spapr
  tests/device-plug: Add memory unplug request test for spapr

 cpus.c                   |   1 +
 hw/ppc/spapr_ovec.c      |   6 ++
 tests/Makefile.include   |   4 +
 tests/device-plug-test.c | 162 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 tests/device-plug-test.c

-- 
2.17.2
