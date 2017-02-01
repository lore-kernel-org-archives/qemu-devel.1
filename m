Received: from eggs.gnu.org ([2001:4830:134:3::10]:49375)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cYrc3-00012H-HT
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cYrc0-0000cc-Fe
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:54:03 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:38699 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cYrc0-0000bE-30
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:54:00 -0500
From: Peter Lieven <pl@kamp.de>
Date: Wed,  1 Feb 2017 10:53:47 +0100
Message-Id: <1485942829-10756-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 0/2] fix segfault and naming of runtime opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, Peter Lieven <pl@kamp.de>

commit 94d6a7a accidently left the naming of runtime opts and QAPI
scheme inconsistent. Furthermore a NULL pointer dereference resulted
in a segfault when parsing URI parameters.

v1->v2: Patch 1: fixed type in commit msg [Eric]
        Patch 2: noted backwards incompatiblity with 2.8 [Eric]
v2->v3: Patch 2: also change names in nfs_refresh_filename [Max]
                 fix typo in commit msg [Eric]

Peter Lieven (2):
  block/nfs: fix NULL pointer dereference in URI parsing
  block/nfs: fix naming of runtime opts

 block/nfs.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

-- 
1.9.1
