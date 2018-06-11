Received: from eggs.gnu.org ([2001:4830:134:3::10]:54310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSSPw-0005uv-At
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSSPr-0005OC-Cw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSSPr-0005NG-8K
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:23:47 -0400
Date: Mon, 11 Jun 2018 22:23:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611192206.339122-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/2] pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c74a:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-11' into staging (2018-06-11 15:31:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 11c39b5cd966ddc067a1ca0c5392ec9b666c45b7:

  nvdimm: make persistence option symbolic (2018-06-11 22:19:57 +0300)

----------------------------------------------------------------
pc: fixes

A couple of fixes to acpi and nvdimm.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ross Zwisler (2):
      hw/i386: Update SSDT table used by "make check"
      nvdimm: make persistence option symbolic

 docs/nvdimm.txt                       |  31 ++++++++++++-------------------
 include/hw/i386/pc.h                  |   2 +-
 include/hw/mem/nvdimm.h               |   3 ++-
 hw/acpi/nvdimm.c                      |   4 ++--
 hw/i386/pc.c                          |  33 ++++++++++++++++-----------------
 tests/bios-tables-test.c              |   2 +-
 tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 685 -> 685 bytes
 7 files changed, 34 insertions(+), 41 deletions(-)
