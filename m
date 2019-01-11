Received: from eggs.gnu.org ([209.51.188.92]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghs0y-0003Ra-S9
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghs0x-0007GK-5l
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:18:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Jan 2019 09:17:49 +0100
Message-Id: <1547194672-24169-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/3] Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Different versions of GCC and Clang use different versions of the C
standard by default. To avoid compilation problems with different
compilers in the future, we should enforce one language level
for all compilers. Since "gnu99" is the only usable option right now
(later versions are still marked as experimental in GCC v4.8),
we enforce compiling with -std=3Dgnu99 now (in the third patch).
This caused some new warnings/erros to appear with clang, which are
fixed by the first two patches.

v5:
 - Prefer to include headers instead of plain struct forward declarations
   in the second patch.

v4:
 - Avoid circular inclusion of headers and introduce xics_spapr.h

v3:
 - Compile C++ code with -std=3Dgnu++98

v2:
 - Use gnu99 instead of gnu11

Thomas Huth (3):
  ppc: Move spapr-related prototypes from xics.h into a seperate header
    file
  ppc: Fix duplicated typedefs to be able to compile with Clang in gnu99
    mode
  configure: Force the C standard to gnu99

 configure                   |  5 ++++-
 hw/intc/xics_kvm.c          |  1 +
 hw/intc/xics_spapr.c        |  1 +
 hw/ppc/spapr_irq.c          |  1 +
 include/hw/ppc/spapr.h      |  5 +++--
 include/hw/ppc/spapr_xive.h |  2 --
 include/hw/ppc/xics.h       |  7 -------
 include/hw/ppc/xics_spapr.h | 37 +++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h            | 13 +++++++++----
 9 files changed, 56 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/ppc/xics_spapr.h

--=20
1.8.3.1
