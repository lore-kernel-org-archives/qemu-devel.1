Received: from eggs.gnu.org ([2001:4830:134:3::10]:38292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGPlH-0005q3-Hn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGPlE-0004Be-Dj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGPlE-0004BX-8n
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:03:32 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Jun 2017 17:03:21 +0400
Message-Id: <20170601130325.6433-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] dump: add vmcoreinfo note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, qiaonuohan@cn.fujitsu.com, anderson@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

In previously sent series "[PATCH 00/21] WIP: dump: add kaslr support
(for after 2.9)", I proposed a qemu-ga change to provide kaslr-related
details to qemu, and other patches to append the vmcoreinfo note to
the various dump format and tools.

Although it remains still undecided how to pass the guest details to
qemu (the latest proposal is a vmcoreinfo ACPI device), we can still
review the rest of the series dealing with the dump and vmcoreinfo
note manipulation.

cheers

Marc-Andr=C3=A9 Lureau (4):
  dump: add DumpInfo structure
  dump: add vmcoreinfo ELF note
  kdump: add vmcoreinfo
  scripts/dump-guest-memory.py: add vmcoreinfo

 scripts/dump-guest-memory.py |  52 ++++++++++++
 include/sysemu/dump-info.h   |  18 +++++
 include/sysemu/dump.h        |   2 +
 dump.c                       | 184 +++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 252 insertions(+), 4 deletions(-)
 create mode 100644 include/sysemu/dump-info.h

--=20
2.13.0.91.g00982b8dd
