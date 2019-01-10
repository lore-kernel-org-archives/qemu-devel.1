Received: from eggs.gnu.org ([209.51.188.92]:33482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghWRD-00065u-3a
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghWRC-0006g1-Cj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:15:43 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 10 Jan 2019 10:15:33 +0100
Message-Id: <1547111736-3962-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/3] Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>

Different versions of GCC and Clang use different versions of the C
standard by default. To avoid compilation problems with different
compilers in the future, we should enforce one language level
for all compilers. Since "gnu99" is the only usable option right now
(later versions are still marked as experimental in GCC v4.8),
we enforce compiling with -std=3Dgnu99 now (in the third patch).
This caused some new warnings/erros to appear with clang, which are
fixed by the first two patches now.

v4:
 - Avoid circular inclusion of headers and introduce xics_spapr.h

v3:
 - Compile C++ code with -std=3Dgnu++98

v2:
 - Use gnu99 instead of gnu11

Thomas Huth (3):
  ppc: Move spapr-related prototypes from xics.h into a seperate header
    file
  ppc: Drop duplicated typedefs to be able to compile with Clang in
    gnu99 mode
  configure: Force the C standard to gnu99

 configure                   |  5 ++++-
 hw/intc/xics_kvm.c          |  1 +
 hw/intc/xics_spapr.c        |  1 +
 hw/ppc/spapr_irq.c          |  1 +
 include/hw/ppc/spapr.h      |  9 +++++----
 include/hw/ppc/spapr_xive.h |  3 +--
 include/hw/ppc/xics.h       |  7 -------
 include/hw/ppc/xics_spapr.h | 37 +++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h            |  9 +++++----
 9 files changed, 55 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/ppc/xics_spapr.h

--=20
1.8.3.1
