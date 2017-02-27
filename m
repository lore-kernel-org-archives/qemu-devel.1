Received: from eggs.gnu.org ([2001:4830:134:3::10]:43673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6n-0007nN-J0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6m-00059w-LS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6m-00058y-Fr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:08 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:51 -0300
Message-Id: <20170227162501.29280-2-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] i386: Unset
 cannot_destroy_with_object_finalize_yet on "host" model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

The class is now safe because the assert(kvm_enabled()) line was
removed by commit e435601058e656e6d24e3e87b187e5518f7bf16a.

Message-Id: <20170119210449.11991-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6f157dca3..2adee42035 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1571,8 +1571,6 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
      */
 
     dc->props = host_x86_cpu_properties;
-    /* Reason: host_x86_cpu_initfn() dies when !kvm_enabled() */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static void host_x86_cpu_initfn(Object *obj)
-- 
2.11.0.259.g40922b1
