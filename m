Received: from eggs.gnu.org ([2001:4830:134:3::10]:39797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1fq02y-00081J-TT
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 13:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1fq02v-0001iT-7f
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 13:57:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1fq02u-0001gR-U8
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 13:57:25 -0400
From: prasad.singamsetty@oracle.com
Date: Wed, 15 Aug 2018 13:57:04 -0400
Message-Id: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
Subject: [Qemu-devel] [PATCH 1/1] kvm: add call to qemu_add_opts() for
 -overcommit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: konrad.wilk@oracle.com, mark.kanda@oracle.com, Prasad Singamsetty <prasad.singamsetty@oracle.com>

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

qemu command fails to process -overcommit option. Add the missing
call to qemu_add_opts() in vl.c.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 16b913f9d5..12d27fa028 100644
--- a/vl.c
+++ b/vl.c
@@ -2987,6 +2987,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_object_opts);
     qemu_add_opts(&qemu_tpmdev_opts);
     qemu_add_opts(&qemu_realtime_opts);
+    qemu_add_opts(&qemu_overcommit_opts);
     qemu_add_opts(&qemu_msg_opts);
     qemu_add_opts(&qemu_name_opts);
     qemu_add_opts(&qemu_numa_opts);
-- 
2.14.0-rc1
