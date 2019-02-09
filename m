Received: from eggs.gnu.org ([209.51.188.92]:46575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gsJq7-00011G-2q
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gsJq5-0000JW-4O
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:02:02 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  8 Feb 2019 23:01:30 -0500
Message-Id: <20190209040132.25573-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] qemu-iotests: add a Travis job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>

Besides the obvious reasons of testing more, and somewhat for free,
running the qemu-iotests along the other tests on Travis also makes
sure that changes to shared code such as "scripts/qemu.py" and the
like won't break other users of the same code.

Cleber Rosa (2):
  qemu-iotests: only enable kvm if the host seems to support it
  qemu-iotests: add "make check-block" job to Travis

 .travis.yml            | 8 ++++++++
 tests/qemu-iotests/235 | 5 +++--
 tests/qemu-iotests/238 | 5 +++--
 3 files changed, 14 insertions(+), 4 deletions(-)

--=20
2.20.1
