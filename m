Received: from eggs.gnu.org ([209.51.188.92]:44229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomPP-0002B9-GJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomPN-0004Z2-Ol
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:43:51 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 10:43:02 +0100
Message-Id: <1548841387-7670-1-git-send-email-thuth@redhat.com>
In-Reply-To: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/5] Kconfig dependencies for ppc machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org

Here's now my stab at expressing the ppc machine dependencies with
Kconfig. I've carefully stepped through the dependencies and tried to
built each machine separately (which should be possible now, apart
from some few quirks like the RTAS dependency in qtest.c which I will
address later).

Yang, unless there are complaints, could you please add these patches
to your Kconfig series? Thanks!

Thomas Huth (5):
  ppc64: Express dependencies of 'pseries' and 'powernv' machines with
    kconfig
  ppc: Express dependencies of the 'prep' and '40p' machines with
    kconfig
  ppc: Express dependencies of the Mac machines with kconfig
  ppc: Express dependencies of the Sam460EX machines with kconfig
  ppc: Express dependencies of the embedded machines with kconfig

 default-configs/ppc-softmmu.mak   | 51 +++------------------------------=
------
 default-configs/ppc64-softmmu.mak |  7 ------
 hw/display/Kconfig                |  1 +
 hw/intc/Kconfig                   |  4 +--
 hw/mem/Kconfig                    |  1 +
 hw/misc/Kconfig                   |  8 ++++++
 hw/net/Kconfig                    |  2 ++
 hw/pci-host/Kconfig               |  4 ++-
 hw/ppc/Kconfig                    | 48 +++++++++++++++++++++++++++++++++=
+++
 hw/usb/Kconfig                    |  2 +-
 10 files changed, 69 insertions(+), 59 deletions(-)

--=20
1.8.3.1
