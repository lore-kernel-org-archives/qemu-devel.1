Received: from eggs.gnu.org ([2001:4830:134:3::10]:49295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcQ-0007W8-6B
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcP-00050V-9q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcP-00050D-3C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:14 -0500
Message-Id: <20180327143014.1767669-15-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] hmp.c: Revert hmp_info_cpus output format
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Commit 137b5cb6 refactored 'info cpus' output, changing
'thread_id' to 'thread-id'.  While HMP is not a stable
interface, it is trivial to keep the spelling consistent
for test frameworks that have not yet updated to using QMP.

This patch just reverts back output format to 'thread_id'.

CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Message-Id: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[eblake: improve commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 679467d85aa..a25c7bd9a81 100644
--- a/hmp.c
+++ b/hmp.c
@@ -381,7 +381,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)

         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
     }

     qapi_free_CpuInfoFastList(cpu_list);
-- 
2.14.3
