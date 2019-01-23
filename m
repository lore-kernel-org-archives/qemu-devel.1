Received: from eggs.gnu.org ([209.51.188.92]:48225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJnG-0007tE-DQ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJnF-0008Re-Hu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:18 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:01 +0100
Message-Id: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/9] iotests: Fix some issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

A couple of iotests for not-so-common formats/protocols are broken for
me, so this series fixes them.

The last patch in this series is not required, but it seemed like a good
thing to do to me.

As a side note, I have many issues with iotests that are rather flaky,
I'll have to investigate those separately (093 and 136, among others).
Maybe I should just stop trying to run tests in parallel...


Max Reitz (9):
  iotests: Re-add filename filters
  iotests: Remove superfluous rm from 232
  iotests: Fix 232 for LUKS
  iotests: Fix 207 to use QMP filters for qmp_log
  iotests: Fix 237 for Python 2.x
  iotests.py: Add is_str()
  iotests.py: Filter filename in any string value
  iotests: Filter SSH paths
  iotests.py: s/_/-/g on keys in qmp_log()

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
 16 files changed, 175 insertions(+), 154 deletions(-)

--=20
2.20.1
