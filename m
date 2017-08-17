Received: from eggs.gnu.org ([2001:4830:134:3::10]:37494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIFq-0003WB-HQ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIFo-0005D0-5I
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diIFn-0005Ci-V8
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF30878752
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 10:42:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 17 Aug 2017 11:42:15 +0100
Message-Id: <20170817104216.29150-2-dgilbert@redhat.com>
In-Reply-To: <20170817104216.29150-1-dgilbert@redhat.com>
References: <20170817104216.29150-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] hmp: Missing handle_errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

hmp_info_memdev && hmp_info_memory_devices were missing
hmp_handle_error calls.  Add them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hmp.c b/hmp.c
index 10400386e0..dc6cf7d583 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2395,6 +2395,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\n");
 
     qapi_free_MemdevList(memdev_list);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
@@ -2433,6 +2434,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     }
 
     qapi_free_MemoryDeviceInfoList(info_list);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
-- 
2.13.5
