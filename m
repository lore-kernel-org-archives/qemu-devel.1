Received: from eggs.gnu.org ([2001:4830:134:3::10]:42053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1fzeBG-0003YE-IO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1fzeBD-00069E-Cr
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:37:54 -0400
From: Ma Haocong <mahaocong_work@163.com>
Date: Tue, 11 Sep 2018 16:37:05 +0800
Message-Id: <20180911083706.5378-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v1 0/1] qemu-img: add new function to remove
 bitmap in image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Ma Haocong <mahaocong_work@163.com>

Hello,

In our scene, we need to delete dirty-bitmap created by using qmp command 
'block-dirty-bitmap-add'. we can use qmp command 'block-dirty-bitmap-remove'
to remove bitmap. Then I think that we should add a new function in qemu-img
to do the same work. 

The command format is: qemu-img removebmp file-name bitmap-name

I test the function by using qmp command to create a named dirty-bitmap in
qcow2 image, then shutdown the vm and using qemu-img to remove it. Then I
test to remove a bitmap with 'IN_USE' flags in qcow2 file, and it works.
I alse test to do the same job to the qcow2 image encrypted by luks.

Please help to review. Thanks.

mahaocong (1):
  Add new command 'removebmp' to remove bitmap in qcow2 file. The format
    is: qemu-img removebmp qcow2-file-name bitmap-name

 qemu-img-cmds.hx |   6 +++
 qemu-img.c       | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

-- 
2.14.1
