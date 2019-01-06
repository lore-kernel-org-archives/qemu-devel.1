Received: from eggsout.gnu.org ([209.51.188.92]:46089 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gg160-0000v4-Gp
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 00:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gg15w-0004KC-AV
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 00:35:36 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17757
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gg15u-0004Df-DB
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 00:35:32 -0500
From: Fam Zheng <fam@euphon.net>
Message-ID: <20190106053409.10712-1-fam@euphon.net>
Date: Sun,  6 Jan 2019 13:34:06 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Block and testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <fam@euphon.net>

The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fdea=
:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into=
 staging (2018-12-22 11:25:31 +0000)

are available in the git repository at:

  https://famz@github.com/famz/qemu tags/block-and-testing-pull-request

for you to fetch changes up to 3baa6942169cce0f58b88484ad010742c382480a:

  tests: vm: auto_install OpenBSD (2019-01-02 20:51:15 +0800)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Fam Zheng (1):
  tests: vm: auto_install OpenBSD

Li Feng (1):
  block/nvme: optimize the performance of nvme driver based on vfio-pci

Philippe Mathieu-Daud=C3=A9 (1):
  docker: Use a stable snapshot for Debian Sid

 block/nvme.c                               | 16 +++---
 tests/docker/dockerfiles/debian-sid.docker |  4 ++
 tests/vm/basevm.py                         |  6 +--
 tests/vm/openbsd                           | 85 +++++++++++++++++++++++++-=
----
 4 files changed, 86 insertions(+), 25 deletions(-)

--=20
2.11.0
