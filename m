Received: from eggs.gnu.org ([209.51.188.92]:55925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP84-0000CJ-23
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP81-0004Qp-Rn
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Feb 2019 16:28:00 +0100
Message-Id: <20190206152807.31896-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-patches-pull-request

for you to fetch changes up to e67e91b4b55331973f783ca89790ee9f7861ced1:

  hw/input/tsc210x: Fix building with no verbosity (2019-02-06 15:57:06 +0100)

----------------------------------------------------------------
Trivial patches:
* Update copyright
* Fix LGPL in target/moxie
* configure portability fix
* Drop useless inclusion of "hw/i386/pc.h"
* Mark the cpu-cluster device with user_creatable = false
* tsc210x: Fix building with no verbosity

----------------------------------------------------------------

Eric Blake (1):
  configure: Avoid non-portable 'test -o/-a'

Peter Maydell (1):
  qemu-common.h: Update copyright string for 2019

Philippe Mathieu-Daudé (3):
  hw/sparc64/sun4u: Drop useless inclusion of "hw/i386/pc.h"
  hw/unicore32/puv3: Drop useless inclusion of "hw/i386/pc.h"
  hw/input/tsc210x: Fix building with no verbosity

Thomas Huth (2):
  target/moxie: Fix LGPL information in the file headers
  hw/cpu/cluster: Mark the cpu-cluster device with user_creatable =
    false

 configure                | 63 +++++++++++++++++++++-------------------
 hw/cpu/cluster.c         |  3 ++
 hw/input/tsc210x.c       | 18 ++++--------
 hw/sparc64/sun4u.c       |  1 -
 hw/unicore32/puv3.c      |  1 -
 include/qemu-common.h    |  2 +-
 target/moxie/cpu.c       |  2 +-
 target/moxie/cpu.h       |  4 +--
 target/moxie/helper.c    |  4 +--
 target/moxie/mmu.c       |  4 +--
 target/moxie/translate.c |  4 +--
 11 files changed, 52 insertions(+), 54 deletions(-)

-- 
2.20.1
