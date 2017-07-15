Received: from eggs.gnu.org ([2001:4830:134:3::10]:43288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8B-0003ft-0z
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8A-0002yH-4s
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:11 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 15 Jul 2017 15:28:37 +0200
Message-Id: <20170715132841.9865-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] vvfat: some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Hi,

This patchset is a follow-up for patch series sent here:
http://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05017.html

Patches 1 and 2 define and use some constants to make the code more clear=
.
Patch 3 make read-write mode work when using non-ASCII filenames.
Patch 4 fixes the last problem reported by MS Scandisk.

Herv=C3=A9

Herv=C3=A9 Poussineau (4):
  vvfat: add constants for special values of name[0]
  vvfat: add a constant for bootsector name
  vvfat: correctly parse non-ASCII short and long file names
  vvfat: initialize memory after allocating it

 block/vvfat.c | 85 +++++++++++++++++++++++++++++++++++++++--------------=
------
 1 file changed, 56 insertions(+), 29 deletions(-)

--=20
2.11.0
