Received: from eggs.gnu.org ([209.51.188.92]:54085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqYE-0002nx-0W
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqYD-0005hj-1M
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:57:45 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 10 Feb 2019 15:57:26 +0100
Message-Id: <20190210145736.1486-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/10] iotests: Fix some issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

No fundamental changes from v2, so if you=E2=80=99re new to this series, =
the
cover letter is here:

http://lists.nongnu.org/archive/html/qemu-block/2019-01/msg01123.html


Otherwise, these are the changes:

v3:
- Patch 10: Rebased onto 039be85c410bfb4b53cdee2083b4245e0d4e4181


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/10:[----] [--] 'iotests: Re-add filename filters'
002/10:[----] [--] 'iotests: Fix 237 for Python 2.x'
003/10:[----] [--] 'iotests: Remove superfluous rm from 232'
004/10:[----] [--] 'iotests: Fix 232 for LUKS'
005/10:[----] [--] 'iotests: Fix 207 to use QMP filters for qmp_log'
006/10:[----] [--] 'iotests.py: Add is_str()'
007/10:[----] [--] 'iotests.py: Filter filename in any string value'
008/10:[----] [--] 'iotests: Filter SSH paths'
009/10:[----] [--] 'iotests: Let 045 be run concurrently'
010/10:[0012] [FC] 'iotests.py: s/_/-/g on keys in qmp_log()'


Max Reitz (10):
  iotests: Re-add filename filters
  iotests: Fix 237 for Python 2.x
  iotests: Remove superfluous rm from 232
  iotests: Fix 232 for LUKS
  iotests: Fix 207 to use QMP filters for qmp_log
  iotests.py: Add is_str()
  iotests.py: Filter filename in any string value
  iotests: Filter SSH paths
  iotests: Let 045 be run concurrently
  iotests.py: s/_/-/g on keys in qmp_log()

 scripts/qemu.py               |  5 ++--
 tests/qemu-iotests/045        |  2 +-
 tests/qemu-iotests/206.out    | 56 +++++++++++++++++------------------
 tests/qemu-iotests/207        | 10 +++++--
 tests/qemu-iotests/207.out    | 18 +++++------
 tests/qemu-iotests/210        |  5 ++--
 tests/qemu-iotests/210.out    | 28 +++++++++---------
 tests/qemu-iotests/211        |  5 ++--
 tests/qemu-iotests/211.out    | 26 ++++++++--------
 tests/qemu-iotests/212        |  5 ++--
 tests/qemu-iotests/212.out    | 44 +++++++++++++--------------
 tests/qemu-iotests/213        |  5 ++--
 tests/qemu-iotests/213.out    | 46 ++++++++++++++--------------
 tests/qemu-iotests/232        |  5 +++-
 tests/qemu-iotests/237        |  7 +++--
 tests/qemu-iotests/237.out    | 54 ++++++++++++++++-----------------
 tests/qemu-iotests/common.rc  |  1 +
 tests/qemu-iotests/iotests.py | 14 +++++++--
 18 files changed, 178 insertions(+), 158 deletions(-)

--=20
2.20.1
