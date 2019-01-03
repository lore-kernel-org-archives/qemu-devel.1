Received: from eggs.gnu.org ([208.118.235.92]:53035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gf1TJ-0000Ug-N2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gf1TG-0003QI-Je
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:47:33 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Thu,  3 Jan 2019 19:46:57 +0800
Message-Id: <20190103114700.9686-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH v3 0/3] dmg: fixing reading in dmg
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
return EIO. this problem is solved by patch 2 and 3.

Thanks

v2 -> v3:
* fix potential overflow (Thanks Stefan)
* add Reviewed tag in patch 2 and 3

v1 -> v2:
* fix typos in patch 1
* add patch 2 and patch 3

yuchenlin (3):
  dmg: fix binary search
  dmg: use enumeration type instead of hard coding number
  dmg: don't skip zero chunk

 block/dmg.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.17.1
