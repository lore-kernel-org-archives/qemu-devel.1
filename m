Received: from eggs.gnu.org ([2001:4830:134:3::10]:51631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwn-0002TS-Uc
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwm-0006YO-Sg
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:26 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:07 +0200
Message-Id: <20170809215510.22802-10-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/12] qemu-iotests: do not search for binaries
 in the current directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

Looking in the build root is enough.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 5b9c0c8ade..e5d1ae3d92 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -86,17 +86,17 @@ then
     fi
 fi
 
-if [[ -z $QEMU_IMG_PROG && -x "$build_root/qemu-img" && ! -x './qemu-img' ]]
+if [[ -z $QEMU_IMG_PROG && -x "$build_root/qemu-img" ]]
 then
     export QEMU_IMG_PROG="$build_root/qemu-img"
 fi
 
-if [[ -z $QEMU_IO_PROG && -x "$build_root/qemu-io" && ! -x './qemu-io' ]]
+if [[ -z $QEMU_IO_PROG && -x "$build_root/qemu-io" ]]
 then
     export QEMU_IO_PROG="$build_root/qemu-io"
 fi
 
-if [[ -z $QEMU_NBD_PROG && -x "$build_root/qemu-nbd" && ! -x './qemu-nbd' ]]
+if [[ -z $QEMU_NBD_PROG && -x "$build_root/qemu-nbd" ]]
 then
     export QEMU_NBD_PROG="$build_root/qemu-nbd"
 fi
-- 
2.13.3
