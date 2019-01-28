Received: from eggs.gnu.org ([209.51.188.92]:43919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go7tZ-0000Sa-7z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go7tY-0006Il-H0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:28:17 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Date: Mon, 28 Jan 2019 17:27:46 +0300
Message-Id: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] block: add blk_lookup() for getting device
 by node_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, Anton Kuchin <antonkuchin@yandex-team.ru>

Some HMP and QMP commands are targeting BlockBackend but
for hotplugged devices name of BB is deprecated, instead
name of root BlockDriverState is set. These patches add
functions to search BB by attached root BDS name.

This approach isn't perfect, but I couldn't invent a better
one and I belive it's more convinient than accessing BB
by QOM path.

Anton Kuchin (2):
  block: add functions to search BlockBackend by root BDS name
  block: migrate callers from blk_by_name to blk_lookup

 block/block-backend.c          | 29 +++++++++++++++++++++++++++++
 blockdev-nbd.c                 |  2 +-
 blockdev.c                     |  6 +++---
 hmp.c                          |  2 +-
 include/sysemu/block-backend.h |  7 +++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

--=20
2.19.1
