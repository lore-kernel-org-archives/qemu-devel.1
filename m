Received: from eggs.gnu.org ([2001:4830:134:3::10]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WK5-0001p5-U1
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WK0-0006s2-76
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e9WK0-0006em-07
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WJr-0007GV-3p
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:11:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 13:11:24 +0000
Message-Id: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just small stuff. I expect/hope to get the "report attributes
in PAR register" fix from Andrew in, but will either send another
pull or just apply it as a single patch once it's been reviewed.
(I think we can call it a bugfix anyway, since it fixes booting
of Windows on ARM.)

thanks
-- PMM


The following changes since commit abf6e752e55b2f5afb48303429dea2db7c3a62de:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20171030' into staging (2017-10-30 13:02:45 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171031

for you to fetch changes up to 168df2dea701bbf3118bdfea7794369dfa694d3d:

  hw/pci-host/gpex: Improve INTX to gsi routing error checking (2017-10-31 11:50:52 +0000)

----------------------------------------------------------------
target-arm queue:
 * fix instruction-length bit in syndrome for WFI/WFE traps
 * xlnx-zcu102: Specify the max number of CPUs
 * msf2: Remove dead code reported by Coverity
 * msf2: Wire up SYSRESETREQ in SoC for system reset
 * hw/pci-host/gpex: Improve INTX to gsi routing error checking

----------------------------------------------------------------
Alistair Francis (1):
      xlnx-zcu102: Specify the max number of CPUs

Eric Auger (1):
      hw/pci-host/gpex: Improve INTX to gsi routing error checking

Stefano Stabellini (1):
      fix WFI/WFE length in syndrome register

Subbaraya Sundeep (2):
      msf2: Remove dead code reported by Coverity
      msf2: Wire up SYSRESETREQ in SoC for system reset

 target/arm/helper.h        |  2 +-
 target/arm/internals.h     |  3 ++-
 hw/arm/msf2-soc.c          | 11 +++++++++++
 hw/arm/xlnx-zcu102.c       |  1 +
 hw/pci-host/gpex.c         | 10 ++++++++--
 hw/ssi/mss-spi.c           | 18 ++++++++++++++----
 target/arm/op_helper.c     |  7 ++++---
 target/arm/psci.c          |  2 +-
 target/arm/translate-a64.c |  7 ++++++-
 target/arm/translate.c     | 10 +++++++++-
 10 files changed, 57 insertions(+), 14 deletions(-)
