Received: from eggs.gnu.org ([2001:4830:134:3::10]:57484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ek1Fg-0004z9-TY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 00:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ek1Fg-0003xG-4k
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 00:29:36 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Feb 2018 13:29:12 +0800
Message-Id: <20180209052915.12855-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/3] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

v7: Tweak wording again "allowing concurrent writers" -> "allowing other QEMU
    processes to open it in write mode". [Eric, Stefan, Kevin]
    Add patch to document share-rw. [Stefan]

v6: Tweak wording ("concurrent writers"). [Max]

Fam Zheng (3):
  qemu-img.texi: Clean up parameter list
  qemu-img: Document --force-share / -U
  docs: Document share-rw property more thoroughly

 docs/qemu-block-drivers.texi | 10 ++++++
 qemu-img.texi                | 74 ++++++++++++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 27 deletions(-)

-- 
2.14.3
