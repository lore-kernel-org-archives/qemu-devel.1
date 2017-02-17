Received: from eggs.gnu.org ([2001:4830:134:3::10]:57413)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1celZ1-00063Q-J9
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1celYy-0004Tx-HF
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:39:19 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:48850 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1celYy-0004RB-6K
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:39:16 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri, 17 Feb 2017 17:38:59 +0100
Message-Id: <1487349541-10201-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 0/2] block/nfs optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, Peter Lieven <pl@kamp.de>

Peter Lieven (2):
  block/nfs: convert to preadv / pwritev
  block/nfs: try to avoid the bounce buffer in pwritev

 block/nfs.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
1.9.1
