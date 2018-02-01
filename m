Received: from eggs.gnu.org ([2001:4830:134:3::10]:52000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6R-00028f-Uk
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6N-0003ZW-36
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG6M-0003ZA-TK
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:35 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 09:44:26 -0500
Message-Id: <20180201144430.14441-3-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-1-pbonzini@redhat.com>
References: <20180201144430.14441-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] cpus: kvm: unregister thread with RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzc@zju.edu.cn

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cpus.c b/cpus.c
index 231550a0d8..789ff7897b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1206,6 +1206,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     cpu->created = false;
     qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
2.14.3
