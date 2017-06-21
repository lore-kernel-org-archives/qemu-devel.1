Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dNgDF-0005C6-VR
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dNgDB-0004XP-37
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:02:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dNgDA-0004X7-Tn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F272685376
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 14:02:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Jun 2017 16:02:16 +0200
Message-Id: <20170621140219.4568-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/3] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new Linux-specific memory backend, similar to hostmem-file,
except that it doesn't need file path. It also try to enforce memory
sealing if available. It is thus slightly easier and secure, and is
compatible with transparent huge-pages since Linux 4.8.

v4:
- rebased, now that preliminary patches are merged

v3:
- make vhost-user-test use memfd only if possible
- rebased

v1->v2:
- make it linux-specific
- minor changes and commit message tweaks

Marc-Andr=C3=A9 Lureau (3):
  memfd: split qemu_memfd_alloc()
  Add memfd based hostmem
  tests: use memfd in vhost-user-test

 include/qemu/memfd.h     |  2 ++
 backends/hostmem-memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++++=
+++++
 tests/vhost-user-test.c  | 68 +++++++++++++++++++++++++++++++-----------=
------
 util/memfd.c             | 42 ++++++++++++++++++------------
 backends/Makefile.objs   |  2 ++
 qemu-options.hx          | 11 ++++++++
 6 files changed, 151 insertions(+), 41 deletions(-)
 create mode 100644 backends/hostmem-memfd.c

--=20
2.13.1.395.gf7b71de06
