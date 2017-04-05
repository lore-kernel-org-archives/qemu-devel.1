Received: from eggs.gnu.org ([2001:4830:134:3::10]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmhb-00032r-6f
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmhY-0001gC-2s
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45392 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cvmhX-0001eX-OC
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:28 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  5 Apr 2017 18:18:23 +0300
Message-Id: <1491405505-31620-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH for 2.10 0/2] block: simple changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

First patch here is one we have agreed on during the initial discussion
about truncate() in parallels format driver, another one is simple
coding style change spotted by my student.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>

Denis V. Lunev (1):
  block: assert no image modification under BDRV_O_INACTIVE

Klim Kireev (1):
  block: fix obvious coding style mitakes in block_int.h

 block.c                   | 2 ++
 include/block/block_int.h | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.7.4
