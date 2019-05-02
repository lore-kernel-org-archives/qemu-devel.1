Received: from eggs.gnu.org ([209.51.188.92]:51995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hM7R4-0000W6-MO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hM7R3-0000YH-Fd
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:51:22 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 11:50:26 +0300
Message-Id: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH 0/3] qemu-img: rebase: Improve/optimize rebase
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: shmuel.eiderman@oracle.com, eyal.moscovici@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com, liran.alon@oracle.com, arbel.moshe@oracle.com

This patch series aims to improve the speed of qemu-img rebase.

1. Mainly by removing unnecessary reads when rebasing on the same
   chain.
2. But also by minimizing the number of bdrv_open calls rebase
   requires.
