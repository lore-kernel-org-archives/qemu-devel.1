Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMi-0001iL-Bj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMh-00066d-MV
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:28 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  9 Aug 2018 13:44:13 +0200
Message-Id: <20180809114417.28718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Hannes Reinecke <hare@suse.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

A series of leaks spotted by ASAN. Some of them might be worth for 3.0...

Marc-Andr=C3=A9 Lureau (4):
  tests: fix crumple/recursive leak
  tests: fix bdrv-drain leak
  monitor: fix oob command leak
  RFC: fix megasas leak

 hw/scsi/megasas.c         | 1 +
 monitor.c                 | 2 ++
 tests/check-block-qdict.c | 1 +
 tests/test-bdrv-drain.c   | 1 +
 4 files changed, 5 insertions(+)

--=20
2.18.0.547.g1d89318c48
