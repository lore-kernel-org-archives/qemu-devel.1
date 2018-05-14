Received: from eggs.gnu.org ([2001:4830:134:3::10]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fIC5n-0002Vt-9Z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fIC5j-0000g3-5r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:56:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2614 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fIC5i-0000Zo-Pa
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:56:35 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 14 May 2018 19:55:57 +0800
Message-ID: <20180514115557.13524-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] cpus: remove useless cond signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>

commit dbadee4 removed qemu_cond_wait in cpu_remove_sync, so it is
useless to keep qemu_cond_signal here.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/cpus.c b/cpus.c
index 5bcd3ecf38..c7262484f3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1222,7 +1222,6 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
 
     qemu_kvm_destroy_vcpu(cpu);
     cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
-- 
2.12.2.windows.2
