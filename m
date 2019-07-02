Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F05C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB8220659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB8220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFss-0000Br-Ug
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hiFrG-0007bq-E5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hiFrB-0003OY-I4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hiFrB-0003OQ-9b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:17:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DD51308622E;
 Tue,  2 Jul 2019 10:17:38 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 820271001B38;
 Tue,  2 Jul 2019 10:17:36 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6592E1806B0F;
 Tue,  2 Jul 2019 10:17:35 +0000 (UTC)
Date: Tue, 2 Jul 2019 06:17:35 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <1593963842.38584773.1562062655041.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190702085012.GB25987@richard>
References: <20190619094907.10131-1-pagupta@redhat.com>
 <20190619094907.10131-6-pagupta@redhat.com> <20190702085012.GB25987@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.117.88, 10.4.195.21]
Thread-Topic: Handle virtio-pmem when printing memory device infos
Thread-Index: L2dc8//MsPNgKQQURvMe/Qv+9BPkLg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 10:17:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/7] hmp: Handle virtio-pmem when
 printing memory device infos
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, aarcange@redhat.com,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, mst@redhat.com,
 cohuck@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, armbru@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com,
 riel@surriel.com, nilal@redhat.com, dan j williams <dan.j.williams@intel.com>,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> On Wed, Jun 19, 2019 at 03:19:05PM +0530, Pankaj Gupta wrote:
> >From: David Hildenbrand <david@redhat.com>
> >
> >Print the memory device info just like for PCDIMM/NVDIMM.
> >
> >Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> This one not apply on latest code. Need to rebase it.

Yes, 

Thanks,
Pankaj

> 
> >---
> > hmp.c | 27 +++++++++++++++------------
> > 1 file changed, 15 insertions(+), 12 deletions(-)
> >
> >diff --git a/hmp.c b/hmp.c
> >index 92941142af..e1866bc7f1 100644
> >--- a/hmp.c
> >+++ b/hmp.c
> >@@ -2650,6 +2650,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict
> >*qdict)
> >     Error *err = NULL;
> >     MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
> >     MemoryDeviceInfoList *info;
> >+    VirtioPMEMDeviceInfo *vpi;
> >     MemoryDeviceInfo *value;
> >     PCDIMMDeviceInfo *di;
> > 
> >@@ -2659,19 +2660,9 @@ void hmp_info_memory_devices(Monitor *mon, const
> >QDict *qdict)
> >         if (value) {
> >             switch (value->type) {
> >             case MEMORY_DEVICE_INFO_KIND_DIMM:
> >-                di = value->u.dimm.data;
> >-                break;
> >-
> >             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
> >-                di = value->u.nvdimm.data;
> >-                break;
> >-
> >-            default:
> >-                di = NULL;
> >-                break;
> >-            }
> >-
> >-            if (di) {
> >+                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
> >+                     value->u.dimm.data : value->u.nvdimm.data;
> >                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> >                                MemoryDeviceInfoKind_str(value->type),
> >                                di->id ? di->id : "");
> >@@ -2684,6 +2675,18 @@ void hmp_info_memory_devices(Monitor *mon, const
> >QDict *qdict)
> >                                di->hotplugged ? "true" : "false");
> >                 monitor_printf(mon, "  hotpluggable: %s\n",
> >                                di->hotpluggable ? "true" : "false");
> >+                break;
> >+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
> >+                vpi = value->u.virtio_pmem.data;
> >+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> >+                               MemoryDeviceInfoKind_str(value->type),
> >+                               vpi->id ? vpi->id : "");
> >+                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n",
> >vpi->memaddr);
> >+                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
> >+                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
> >+                break;
> >+            default:
> >+                g_assert_not_reached();
> >             }
> >         }
> >     }
> >--
> >2.14.5
> >
> 
> --
> Wei Yang
> Help you, Help me
> 
> 

