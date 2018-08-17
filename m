Received: from eggs.gnu.org ([2001:4830:134:3::10]:57679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjWl-0001ko-AB
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjWh-0006NO-BU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqjWf-0006Mk-AX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 17 Aug 2018 15:30:24 -0300
Message-Id: <20180817183026.32662-2-ehabkost@redhat.com>
In-Reply-To: <20180817183026.32662-1-ehabkost@redhat.com>
References: <20180817183026.32662-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] machine: Fix coding style at
 machine_run_board_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Commit 7747abf11487 ("hw/machine: Remove the Zero check of
nb_numa_nodes for numa_complete_configuration()") removed the
curly brackets.  Re-add them.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-Id: <20180710105129.23296-1-douly.fnst@cn.fujitsu.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[ehabkost: rewrote commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a9aeb22f03..6b68e1218f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -793,8 +793,9 @@ void machine_run_board_init(MachineState *machine)
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     numa_complete_configuration(machine);
-    if (nb_numa_nodes)
+    if (nb_numa_nodes) {
         machine_numa_finish_cpu_init(machine);
+    }
 
     /* If the machine supports the valid_cpu_types check and the user
      * specified a CPU with -cpu check here that the user CPU is supported.
-- 
2.18.0.rc1.1.g3f1ff2140
