Received: from eggs.gnu.org ([2001:4830:134:3::10]:44935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSV-0004hU-GM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSU-00056W-SZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:43 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSU-000562-L5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:42 -0500
Received: by mail-wr0-x244.google.com with SMTP id s5so30857966wra.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:42 -0800 (PST)
Received: from 640k.lan ([82.84.122.246]) by smtp.gmail.com with ESMTPSA id
	g8sm20029891wra.18.2018.02.05.11.29.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 05 Feb 2018 11:29:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:45 +0100
Message-Id: <1517858941-5538-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/47] cpus: kvm: unregister thread with RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cpus.c b/cpus.c
index 08a8462..1063dac 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1205,6 +1205,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     cpu->created = false;
     qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
1.8.3.1
