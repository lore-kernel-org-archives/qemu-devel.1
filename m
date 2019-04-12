Received: from eggs.gnu.org ([209.51.188.92]:44031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyg1-0004d9-9x
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyfy-0002HT-VB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Apr 2019 18:04:56 +0200
Message-Id: <20190412160458.23920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block layer patches for 4.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 13c24edaa742181af8d9c6b027ee366b04de1e=
a1:

  qemu-img: fix .hx and .texi disparity (2019-04-12 14:17:10 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 9749636b005d118259810afb92482df2fe0ae2ad:

  iotest: Fix 241 to run in generic directory (2019-04-12 18:03:01 +0200)

----------------------------------------------------------------
Block layer patches:

- iotests fixes

----------------------------------------------------------------
Eric Blake (1):
      iotest: Fix 241 to run in generic directory

Max Reitz (1):
      iotests: Let 245 pass on tmpfs

 tests/qemu-iotests/241     |  4 +++-
 tests/qemu-iotests/241.out |  6 +++---
 tests/qemu-iotests/245     | 10 ++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)
