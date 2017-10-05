Received: from eggs.gnu.org ([2001:4830:134:3::10]:54569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l6-00031p-O6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l3-0003N9-It
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e03l3-0003Lq-DP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B995C0587E8
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:52:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 11:51:53 +0100
Message-Id: <20171005105157.10831-2-dgilbert@redhat.com>
In-Reply-To: <20171005105157.10831-1-dgilbert@redhat.com>
References: <20171005105157.10831-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] hmp: Missing handle_errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

hmp_info_memdev && hmp_info_memory_devices were missing
hmp_handle_error calls.  Add them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170817104216.29150-2-dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hmp.c b/hmp.c
index ace729d03f..739d330f4e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2394,6 +2394,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\n");
 
     qapi_free_MemdevList(memdev_list);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
@@ -2432,6 +2433,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     }
 
     qapi_free_MemoryDeviceInfoList(info_list);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
-- 
2.13.6
