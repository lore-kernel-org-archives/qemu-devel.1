Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A0820851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A0820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33485 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlIu-00017P-CB
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:50:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hTkwc-0006zR-Oo
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hTkwb-0002Vv-Lt
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hTkwb-0002Vd-HT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:27:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF2D980C26;
	Thu, 23 May 2019 10:27:28 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-162.sin2.redhat.com
	[10.67.116.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03D6269181;
	Thu, 23 May 2019 10:27:08 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:54:47 +0530
Message-Id: <20190523102449.2642-6-pagupta@redhat.com>
In-Reply-To: <20190523102449.2642-1-pagupta@redhat.com>
References: <20190523102449.2642-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 23 May 2019 10:27:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/7] hmp: Handle virtio-pmem when printing
 memory device infos
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
	xiaoguangrong.eric@gmail.com, mst@redhat.com, pagupta@redhat.com,
	riel@surriel.com, david@redhat.com, armbru@redhat.com,
	ehabkost@redhat.com, lcapitulino@redhat.com, stefanha@redhat.com,
	pbonzini@redhat.com, imammedo@redhat.com,
	dan.j.williams@intel.com, nilal@redhat.com, dgilbert@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Print the memory device info just like for PCDIMM/NVDIMM.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hmp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/hmp.c b/hmp.c
index 92941142af..e1866bc7f1 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2650,6 +2650,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
     MemoryDeviceInfoList *info;
+    VirtioPMEMDeviceInfo *vpi;
     MemoryDeviceInfo *value;
     PCDIMMDeviceInfo *di;
 
@@ -2659,19 +2660,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
         if (value) {
             switch (value->type) {
             case MEMORY_DEVICE_INFO_KIND_DIMM:
-                di = value->u.dimm.data;
-                break;
-
             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
-                di = value->u.nvdimm.data;
-                break;
-
-            default:
-                di = NULL;
-                break;
-            }
-
-            if (di) {
+                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
+                     value->u.dimm.data : value->u.nvdimm.data;
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
                                MemoryDeviceInfoKind_str(value->type),
                                di->id ? di->id : "");
@@ -2684,6 +2675,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                                di->hotplugged ? "true" : "false");
                 monitor_printf(mon, "  hotpluggable: %s\n",
                                di->hotpluggable ? "true" : "false");
+                break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
+                vpi = value->u.virtio_pmem.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               vpi->id ? vpi->id : "");
+                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
+                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
+                break;
+            default:
+                g_assert_not_reached();
             }
         }
     }
-- 
2.14.5


