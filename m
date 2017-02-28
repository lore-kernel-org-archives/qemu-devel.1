Received: from eggs.gnu.org ([2001:4830:134:3::10]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cih9N-0003Xt-DV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cih9K-0001CR-BG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cih9K-0001C5-5k
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:02 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 28 Feb 2017 20:44:56 +0800
Message-Id: <20170228124458.31307-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Docker patches
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

The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea536=
06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-02-28 08:46:03 +0000)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/docker-pull-request

for you to fetch changes up to 1ed9251515382a1fc9c6187fee8d7d7bf141dc90:

  .shippable: add s390x-cross target (2017-02-28 20:31:01 +0800)

----------------------------------------------------------------

Two more test/build automation patches from Alex for the freeze. Theoreti=
cally
these are okay to merge even after freeze but on the other hand I see no =
reason
to delay them.

----------------------------------------------------------------

Alex Benn=C3=A9e (2):
  new: dockerfiles/debian-s390-cross
  .shippable: add s390x-cross target

 .shippable.yml                                     |  2 ++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 22 ++++++++++++++++=
++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-s390x-cross.docker

--=20
2.9.3
