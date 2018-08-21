Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4X-0001vC-GM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4U-0006jj-NG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4R-0006I1-QT
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id g33-v6so6431169wrd.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:04 +0200
Message-Id: <1534870966-9287-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/74] kvm: add call to qemu_add_opts() for
 -overcommit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad Singamsetty <prasad.singamsetty@oracle.com>

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

qemu command fails to process -overcommit option. Add the missing
call to qemu_add_opts() in vl.c.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-Id: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index d2af8ed..5ba06ad 100644
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
1.8.3.1
