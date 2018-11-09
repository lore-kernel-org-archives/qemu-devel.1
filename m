Received: from eggs.gnu.org ([2001:4830:134:3::10]:45367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLF1K-0006uy-HE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLF1E-00055O-QY
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:12:51 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 17:12:11 -0500
Message-Id: <20181109221213.7310-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The initial goal of this RFC is to get feedback on tests not specific
to the QEMU main binary, but specific to other components such as
qemu-img.

For this experiment, a small issue with the zero and negative number
of I/O operations given to the bench command was chosen.

Cleber Rosa (2):
  Acceptance Tests: add QemuImgTest base class
  qemu-img: consider a zero number of I/O requests an invalid count

 qemu-img.c                                  |   8 ++---
 tests/acceptance/avocado_qemu/__init__.py   |  20 ++++++++++++
 tests/acceptance/qemu_img_bench.py          |  34 ++++++++++++++++++++
 tests/acceptance/qemu_img_bench.py.data/img |   1 +
 tests/data/images/empty/raw                 | Bin 0 -> 1024 bytes
 5 files changed, 59 insertions(+), 4 deletions(-)
 create mode 100644 tests/acceptance/qemu_img_bench.py
 create mode 120000 tests/acceptance/qemu_img_bench.py.data/img
 create mode 100644 tests/data/images/empty/raw

--=20
2.19.1
