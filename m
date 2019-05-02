Received: from eggs.gnu.org ([209.51.188.92]:34743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF7-0002Ga-9W
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF6-0008M6-9N
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:21 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 16:58:25 +0300
Message-Id: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qemu-img: rebase: Improve/optimize
 rebase operation
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

v2:

 - Added missing g_free in
   "qemu-img: rebase: Reuse in-chain BlockDriverState"*

Sam Eiderman (3):
  qemu-img: rebase: Reuse parent BlockDriverState
  qemu-img: rebase: Reduce reads on in-chain rebase
  qemu-img: rebase: Reuse in-chain BlockDriverState

 qemu-img.c | 85 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 27 deletions(-)

-- 
2.13.3
