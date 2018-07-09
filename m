Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcaAl-0005PA-0h
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcaAh-0006qN-3G
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcaAg-0006qF-TU
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:41:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Jul 2018 14:41:52 -0300
Message-Id: <20180709174154.9470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Machine/NUMA fixes for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 7747abf114874537e898c60ff863828a4e82201d:

  hw/machine: Remove the Zero check of nb_numa_nodes for numa_complete_configuration() (2018-07-09 14:37:48 -0300)

----------------------------------------------------------------
Machine/NUMA fixes for -rc0

* Properly free device_memory at machine_finalize()
* Fix implicit NUMA initialization regression (for machines with
  auto_enable_numa_with_memhp=true)

----------------------------------------------------------------

Queue for Machine Core patches


David Hildenbrand (1):
  machine: properly free device_memory

Dou Liyang (1):
  hw/machine: Remove the Zero check of nb_numa_nodes for
    numa_complete_configuration()

 hw/core/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
