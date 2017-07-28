Received: from eggs.gnu.org ([2001:4830:134:3::10]:47248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxwo-0003sA-T6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxwl-0002mZ-JH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:35:23 -0300
Message-Id: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/47] add missing entries in MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi,

I first prepared this series thinking about 2.10 but then realized if someone
is calling ./scripts/get_maintainer.pl he better is using an updated git
clone :)

Distribs do provide docs/ files in /usr/share/doc/qemu* but not the
MAINTAINERS file so no hurry for this series.

I provided the script I used in the last patch, I plan to improve it so
patchew/travis can start to use it: if a new file is added to the repository
without being covered in MAINTAINERS the script remember the submitter about
it and eventually he'll resend his patch, I think this is a good practice and
help the next contributors (anyway this is a valuable experience to look at a
file history to see who has been hacking around when there is no MAINTAINERS
entry).

I don't want to overburden current maintainers, so the last patches add
Orphans entries but I tried to select relevant commiters and include them in
each patch.

The criteria I used is "If I change this file, who should I notify? Who would
be interested?"

Regards,

Phil.

Philippe Mathieu-Daudé (47):
  MAINTAINERS: add missing entry for documentation
  MAINTAINERS: add missing ARM entries
  MAINTAINERS: add missing STM32 entry
  MAINTAINERS: add missing USB entry
  MAINTAINERS: add missing KVM entry
  MAINTAINERS: add missing entry for vhost
  MAINTAINERS: add missing entry for vfio/ccw
  MAINTAINERS: add missing entry for virtio
  MAINTAINERS: add missing entry for virtio/9p
  MAINTAINERS: add missing entry for virtio/blk
  MAINTAINERS: add missing entry for virtio/ccw
  MAINTAINERS: add missing entry for virtio/input
  MAINTAINERS: add missing entry for virtio/rng
  MAINTAINERS: add missing entry for virtio/crypto
  MAINTAINERS: add missing VMWare entry
  MAINTAINERS: add missing entry for gdb
  MAINTAINERS: add missing guest-agent entries
  MAINTAINERS: add missing TCG entry
  MAINTAINERS: add missing qcow2 entry
  MAINTAINERS: add missing PCI entries
  MAINTAINERS: add missing CRIS entry
  MAINTAINERS: add missing M68k entry
  MAINTAINERS: add missing LM32 entry
  MAINTAINERS: add missing MicroBlaze entry
  MAINTAINERS: add missing MIPS entry
  MAINTAINERS: add missing NiosII entry
  MAINTAINERS: add missing OpenRISC entry
  MAINTAINERS: add missing PowerPC entry
  MAINTAINERS: add missing SH-4 entry
  MAINTAINERS: add missing SPARC entry
  MAINTAINERS: add missing TriCore entry
  MAINTAINERS: add missing UniCore32 entry
  MAINTAINERS: add missing Xtensa entry
  MAINTAINERS: add missing X86 entries
  MAINTAINERS: add missing entries for throttling infra
  MAINTAINERS: add missing entry test for megasas
  MAINTAINERS: update docs/devel/ entries
  MAINTAINERS: update docs/interop/ entries
  RFC MAINTAINERS: add missing SSI entries
  RFC MAINTAINERS: add missing entry for AIO
  RFC MAINTAINERS: add missing I2C entries
  RFC MAINTAINERS: add missing Bluetooth entries
  RFC MAINTAINERS: add missing TPM entries
  RFC MAINTAINERS: add missing entry for tilegx
  RFC MAINTAINERS: add missing entries for loader
  RFC MAINTAINERS: add missing entries for Coccinelle scripts
  MAINTAINERS: script to find outdated entry

 MAINTAINERS                 | 102 ++++++++++++++++++++++++++++++++++++++++----
 scripts/check_maintainer.sh |  21 +++++++++
 2 files changed, 114 insertions(+), 9 deletions(-)
 create mode 100755 scripts/check_maintainer.sh

-- 
2.13.3
