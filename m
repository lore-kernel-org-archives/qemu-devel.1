Received: from eggs.gnu.org ([2001:4830:134:3::10]:47257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gOgfh-00071i-Hk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gOgeP-0000oF-0t
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:19:30 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 19 Nov 2018 11:19:19 +0100
Message-Id: <20181119101921.31949-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-next? 0/2] qemu-img: Minor fixes to an
 amend error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

One of the amend error paths has two issues that are fixed by this
series.  Since they are relatively minor and have been present in 3.0
already, I think there is no need to get them into 3.1.  OTOH they are
bug fixes, so they could go into 3.1 if you, dear reader, insist.


Max Reitz (2):
  qemu-img: Fix typo
  qemu-img: Fix leak

 qemu-img.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.2
