Received: from eggs.gnu.org ([2001:4830:134:3::10]:56206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDdOn-0003IJ-31
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDdOm-00024d-87
	for qemu-devel@nongnu.org; Tue, 01 May 2018 18:05:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 00:05:07 +0200
Message-Id: <20180501220509.14152-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] block/mirror: Make cancel always cancel
 pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Currently, you cannot cancel a mirror job without the @force flag set.
This is intentional once source and target are in sync, but probably not
so much before that happens.  The main reason for me thinking this is
because it is an undocumented change in 2.12.0 in respect to 2.11.

(b76e4458b1eb3c32e9824fe6aa51f67d2b251748 only notes a behavior change
 after READY, but not before.)


This series depends on Stefan=E2=80=99s patch =E2=80=9Cblock/mirror: hono=
r ratelimit
again=E2=80=9D (which is in Jeff=E2=80=99s queue).

Based-on: <20180424123527.19168-1-stefanha@redhat.com>


Max Reitz (2):
  block/mirror: Make cancel always cancel pre-READY
  iotests: Add test for cancelling a mirror job

 block/mirror.c             |   4 +-
 tests/qemu-iotests/218     | 138 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/218.out |  30 ++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/218
 create mode 100644 tests/qemu-iotests/218.out

--=20
2.14.3
