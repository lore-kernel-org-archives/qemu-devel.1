Received: from eggs.gnu.org ([209.51.188.92]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1XuT-0002xN-Ra
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1XuS-0006Vn-HF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:52:41 -0500
Date: Wed, 6 Mar 2019 15:52:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306145230.GI6818@localhost.localdomain>
References: <1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1551694120-768127-4-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551694120-768127-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: check whitelisted formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com

Am 04.03.2019 um 11:08 hat Andrey Shinkevich geschrieben:
> Some test cases require specific formats. The method decorator
> skip_if_unsupported() checks if requested formats are whitelisted.
> The test #139 was selected for a sample output:
> 
> 137 3s ...
> 138 0s ...
> 139 2s ...
>     [case not run] testBlkVerify (__main__.TestBlockdevDel): formats ['blkverify'] are not whitelisted
>     [case not run] testQuorum (__main__.TestBlockdevDel): formats ['quorum'] are not whitelisted
> 140 0s ...
> Not run: 131 135 136
> Some cases not run in: 139
> Passed all 137 tests
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Would you mind squashing in this hunk for v3?

Kevin

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index cb970294d3..933b45121a 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -325,6 +325,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         # FIXME mirror0 disappears, drive-mirror doesn't take a reference
         #self.delBlockDriverState('mirror0')
 
+    @iotests.skip_if_unsupported(['blkdebug'])
     def testBlkDebug(self):
         self.addBlkDebug('debug0', 'node0')
         # 'node0' is used by the blkdebug node
