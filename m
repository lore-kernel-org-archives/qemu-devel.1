Received: from eggs.gnu.org ([2001:4830:134:3::10]:44228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0i-0004rE-M6
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0e-0005Sm-2h
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:00 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Sun, 23 Dec 2018 10:59:36 +0800
Message-Id: <20181223025939.15775-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/3] dmg: fixing reading in dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>

There are two bugs in dmg reading.

First, it may hang in binary search. this problem is solved by patch 1.
Second, because of lacking zero chunk table, reading zero sector will
return EIO. thie problem is solved by patch 2 and 3.

Thanks

v1 - >v2:
* fix typos in patch 1
* add patch 2 and patch 3

yuchenlin (3):
  dmg: fix binary search
  dmg: use enumeration type instead of hard coding number
  dmg: don't skip zero chunk

 block/dmg.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.17.1
