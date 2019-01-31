Received: from eggs.gnu.org ([209.51.188.92]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmo-0001wF-Tr
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmo-0006QV-1Z
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:46 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 31 Jan 2019 14:53:25 +0100
Message-Id: <1548942810-22942-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Kconfig dependencies for ppc machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com

Here's now my stab at expressing the ppc machine dependencies with
Kconfig. I've carefully stepped through the dependencies and tried to
built each machine separately (which should be possible now, apart
from some few quirks like the RTAS dependency in qtest.c which I will
address later).

v2: Adressed review feedback from v1

Based-on: 1548410831-19553-1-git-send-email-pbonzini@redhat.com

Thomas Huth (5):
  ppc64: Express dependencies of 'pseries' and 'powernv' machines with
    kconfig
  ppc: Express dependencies of the 'prep' and '40p' machines with
    kconfig
  ppc: Express dependencies of the Mac machines with kconfig
  ppc: Express dependencies of the Sam460EX machines with kconfig
  ppc: Express dependencies of the embedded machines with kconfig

 default-configs/ppc-softmmu.mak   | 51 +++------------------------------=
--
 default-configs/ppc64-softmmu.mak |  8 ------
 hw/display/Kconfig                |  1 +
 hw/intc/Kconfig                   |  6 ++---
 hw/mem/Kconfig                    |  1 +
 hw/misc/Kconfig                   |  6 +++++
 hw/net/Kconfig                    |  2 ++
 hw/nvram/Kconfig                  |  2 ++
 hw/pci-host/Kconfig               |  4 ++-
 hw/ppc/Kconfig                    | 57 +++++++++++++++++++++++++++++++++=
+++---
 hw/usb/Kconfig                    |  2 +-
 11 files changed, 75 insertions(+), 65 deletions(-)

--=20
1.8.3.1
