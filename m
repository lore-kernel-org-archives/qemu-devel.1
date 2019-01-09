Received: from eggs.gnu.org ([209.51.188.92]:48061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghGtT-0000I9-Oi
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghGtR-000599-BM
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:39:51 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 Jan 2019 17:39:34 +0100
Message-Id: <1547051976-13982-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org

Different versions of GCC and Clang use different versions of the C
standard by default. To avoid compilation problems with different
compilers in the future, we should enforce one language level
for all compilers. Since "gnu99" is the only usable option right now
(later versions are still marked as experimental in GCC v4.8),
we enforce compiling with -std=gnu99 now (in the second patch).
This caused some new warnings/erros to appear with clang, which are
fixed by the first patch now.

Thomas Huth (2):
  include/hw/ppc: Fix compilation with clang -std=gnu99
  configure: Force the C standard to gnu99

 configure                   | 5 ++++-
 include/hw/ppc/spapr.h      | 4 ++--
 include/hw/ppc/spapr_xive.h | 2 +-
 include/hw/ppc/xics.h       | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.1
