Received: from eggs.gnu.org ([2001:4830:134:3::10]:42590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCrkB-0006Mo-Rr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCrkA-0000bz-WD
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:07:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 May 2017 20:07:33 +0200
Message-Id: <20170522180735.26677-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Fix backing paths for filenames
 with colons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

See here:
$ ./qemu-img create -f qcow2 backing.qcow2 64M
Formatting 'backing.qcow2', fmt=qcow2 size=67108864 encryption=off
    cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ ./qemu-img create -f qcow2 -b backing.qcow2 ./top:image.qcow2
qemu-img: ./top:image.qcow2: Could not open './top:backing.qcow2':
    No such file or directory

:-(

(See also: https://bugzilla.redhat.com/show_bug.cgi?id=1212715)


Max Reitz (2):
  block: Fix backing paths for filenames with colons
  iotests: Add test for colon handling

 block.c                    | 15 ++++++---
 tests/qemu-iotests/126     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/126.out | 16 ++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 103 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out

-- 
2.9.4
