Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cal-0001bS-O5
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cak-0001CF-U6
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:19 +0200
Message-Id: <1493411622-5343-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/34] qemu-iotests: Remove PERL_PROG and BC_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

We test for the presence of perl and bc and save their path in the
variables PERL_PROG and BC_PROG, but never actually make use of them.
Remove the checks and assignments so qemu-iotests can run even when
bc isn't installed.

Reported-by: Yash Mankad <ymankad@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/common.config | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index c4b51b3..5ee00a1 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -75,18 +75,12 @@ _fatal()
     exit 1
 }
 
-export PERL_PROG="`set_prog_path perl`"
-[ "$PERL_PROG" = "" ] && _fatal "perl not found"
-
 export AWK_PROG="`set_prog_path awk`"
 [ "$AWK_PROG" = "" ] && _fatal "awk not found"
 
 export SED_PROG="`set_prog_path sed`"
 [ "$SED_PROG" = "" ] && _fatal "sed not found"
 
-export BC_PROG="`set_prog_path bc`"
-[ "$BC_PROG" = "" ] && _fatal "bc not found"
-
 export PS_ALL_FLAGS="-ef"
 
 if [ -z "$QEMU_PROG" ]; then
-- 
1.8.3.1
