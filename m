Received: from eggs.gnu.org ([209.51.188.92]:43195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg2v-0001cu-S1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg2v-0006AJ-14
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:56:53 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 12 Feb 2019 22:48:23 +0100
Message-Id: <20190212214827.30543-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/4] numa,
 spapr: add thread-id in the possible_cpus list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

There are inconsistencies between the command line using
"-numa node,cpus=3DXX" and what is checked internally:
the XX is supposed to be a CPU number, but for SPAPR
it's taken as a core number, ignoring the threads.
(See the description message of PATCH 1 for more details)

This series fixes this problem by introducing the threads
in the possible_cpus list instead of only the cores.
To avoid inconsistent topology, it doesn't allow anymore to
have an incomplete CPU NUMA config on the command line
(there was already a message announcing it will be absoleted
for 2 years).

Laurent Vivier (4):
  numa,spapr: add thread-id in the possible_cpus list
  numa: exit on incomplete CPU mapping
  numa: move cpu_slot_to_string() upper in the function
  numa: check threads of the same core are on the same node

 hw/core/machine.c | 115 ++++++++++++++++++++++++++--------------------
 hw/ppc/spapr.c    |  33 ++++++-------
 tests/numa-test.c |  24 +---------
 3 files changed, 81 insertions(+), 91 deletions(-)

--=20
2.20.1
