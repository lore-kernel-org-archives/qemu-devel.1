Received: from eggs.gnu.org ([2001:4830:134:3::10]:43604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQ9y-0003fk-PM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQ9s-0002ms-WB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:10 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 16 Jan 2018 13:15:54 +0100
Message-Id: <1516104958-3881-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Clean up the ppc configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, BALATON Zoltan <balaton@eik.bme.hu>

ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset
of ppcemb-softmmu. But since the config files are currently independent
from each other, we missed to define some CONFIG switches in the super-
sets: CONFIG_SUNGEM is missing from the ppc64-softmmu config, and the
CONFIG_IDE_SII3112 switch is only defined in ppcemb-softmmu.

This patch series fixes these problems, together with cleaning up
the config- and make-files for better usability. qemu-system-ppcemb
is finally marked as deprecated since there is hardly any use case
for this separate build nowadays anymore (and if somebody really
still needs page sizes < 4k, we should likely rather use the dynamic
approach that is already done on the ARM boards instead).

v2:
 - Added patch to disable the PPC4xx boards in the hw/ppc/Makefile
 - Added patch to deprecate qemu-system-ppcemb

Thomas Huth (4):
  default-configs/ppc64-softmmu: Include 32-bit configs instead of
    copying them
  default-configs/ppc-softmmu: Restructure the switches according to the
    machines
  hw/ppc/Makefile: Add a way to disable the PPC4xx boards
  ppc: Deprecate qemu-system-ppcemb

 default-configs/ppc-softmmu.mak   | 59 ++++++++++++++++++++-----------------
 default-configs/ppc64-softmmu.mak | 61 +++++----------------------------------
 hw/ppc/Makefile.objs              |  4 +--
 qemu-doc.texi                     |  6 ++++
 target/ppc/translate_init.c       |  5 ++++
 5 files changed, 53 insertions(+), 82 deletions(-)

-- 
1.8.3.1
