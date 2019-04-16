Received: from eggs.gnu.org ([209.51.188.92]:55774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGP4H-0008Ss-Rt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGP4G-00034L-Vu
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:28:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 16 Apr 2019 16:28:01 +0200
Message-Id: <20190416142802.11990-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] qcow2: Fix potential corruption with
 external data file
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

The following changes since commit a9b305ba291fb74f7ff732b3d7b8f4c812431d=
df:

  socket: allow wait=3Dfalse for client socket (2019-04-16 10:40:43 +0100=
)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 93e32b3e2012a668e4da1c2566d2935c24060435:

  qcow2: Fix preallocation bdrv_pwrite to wrong file (2019-04-16 16:23:24=
 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2: Fix potential corruption for preallocated resize with external d=
ata file

----------------------------------------------------------------
Kevin Wolf (1):
      qcow2: Fix preallocation bdrv_pwrite to wrong file

 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
