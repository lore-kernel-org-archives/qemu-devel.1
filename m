Received: from eggs.gnu.org ([209.51.188.92]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKSS-0006dz-JC
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKSR-0000YW-NS
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:20:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 13 Apr 2019 17:20:35 +0200
Message-Id: <20190413152037.6817-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 0/2] qemu-img: Make create hint at
 protocol options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1698863 reports that while
"qemu-img create -f raw" supports the "preallocation" option, it is not
listed under "-o help".

It turns out it is, but only if you specify a target filename.  Users
may not realize this, but a note should help.


Max Reitz (2):
  iotests: Perform the correct test in 082
  qemu-img: Make create hint at protocol options

 qemu-img.c                 | 13 ++++++++++++-
 tests/qemu-iotests/082     |  5 ++++-
 tests/qemu-iotests/082.out | 25 ++++++++++++++++++-------
 3 files changed, 34 insertions(+), 9 deletions(-)

--=20
2.20.1
