Received: from eggs.gnu.org ([2001:4830:134:3::10]:52062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6Y-0002Ey-I8
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6R-0003bn-4P
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG6Q-0003bV-U0
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:39 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 09:44:29 -0500
Message-Id: <20180201144430.14441-6-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-1-pbonzini@redhat.com>
References: <20180201144430.14441-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] cpus: hvf: unregister thread with RCU
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
index 9f48ccad9e..03b4533b7d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1542,6 +1542,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     cpu->created = false;
     qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
2.14.3
