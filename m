Received: from eggs.gnu.org ([2001:4830:134:3::10]:60054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG95-00037Y-Ss
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG92-000648-Ju
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfG92-00063v-DL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:50:48 -0400
Date: Wed, 9 Aug 2017 04:50:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502241852-6302-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/5] pc, vhost: fixes for rc3
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

The following changes since commit 54affb3a3623b1d36c95e34faa722a5831323a74:

  Update version for v2.10.0-rc2 release (2017-08-08 19:07:46 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 24dd1e17696fbd11b3df50718dddcbdfe2c45f24:

  libqtest: always set up signal handler for SIGABRT (2017-08-09 04:22:14 +0300)

----------------------------------------------------------------
pc, vhost: fixes for rc3

Fix up bugs and warnings in tests. Revert an experimental commit that I
put in by mistake: harmless but useless.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jens Freimann (3):
      net: fix -netdev socket,fd= for UDP sockets
      libvhost-user: quit when no more data received
      libqtest: always set up signal handler for SIGABRT

Michael S. Tsirkin (2):
      acpi-test: update expected DSDT files
      Revert "cpu: add APIs to allocate/free CPU environment"

 include/qom/cpu.h                     |  31 ----------------------------
 contrib/libvhost-user/libvhost-user.c |   4 +++-
 net/socket.c                          |  37 +++++++++++++++++-----------------
 qom/cpu.c                             |  34 -------------------------------
 tests/libqtest.c                      |   2 +-
 tests/acpi-test-data/q35/DSDT         | Bin 7782 -> 7782 bytes
 tests/acpi-test-data/q35/DSDT.bridge  | Bin 7799 -> 7799 bytes
 tests/acpi-test-data/q35/DSDT.cphp    | Bin 8245 -> 8245 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt  | Bin 7857 -> 7857 bytes
 tests/acpi-test-data/q35/DSDT.memhp   | Bin 9147 -> 9147 bytes
 10 files changed, 22 insertions(+), 86 deletions(-)
