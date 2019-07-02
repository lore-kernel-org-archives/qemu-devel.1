Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9049C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEBA2089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEBA2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEZS-0007AD-Tn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57671)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hiEV1-0003hN-2E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hiEUz-0007aA-3v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:50:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:4884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hiEUv-0007Va-GX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:50:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 01:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; d="scan'208";a="171718768"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2019 01:50:35 -0700
Date: Tue, 2 Jul 2019 16:50:12 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190702085012.GB25987@richard>
References: <20190619094907.10131-1-pagupta@redhat.com>
 <20190619094907.10131-6-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619094907.10131-6-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: kwolf@redhat.com, aarcange@redhat.com, nilal@redhat.com,
 xiaoguangrong.eric@gmail.com, mst@redhat.com, rth@twiddle.net,
 cohuck@redhat.com, david@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
 riel@surriel.com, lcapitulino@redhat.com, dan.j.williams@intel.com,
 dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 03:19:05PM +0530, Pankaj Gupta wrote:
>From: David Hildenbrand <david@redhat.com>
>
>Print the memory device info just like for PCDIMM/NVDIMM.
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

This one not apply on latest code. Need to rebase it.

>---
> hmp.c | 27 +++++++++++++++------------
> 1 file changed, 15 insertions(+), 12 deletions(-)
>
>diff --git a/hmp.c b/hmp.c
>index 92941142af..e1866bc7f1 100644
>--- a/hmp.c
>+++ b/hmp.c
>@@ -2650,6 +2650,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>     Error *err = NULL;
>     MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>     MemoryDeviceInfoList *info;
>+    VirtioPMEMDeviceInfo *vpi;
>     MemoryDeviceInfo *value;
>     PCDIMMDeviceInfo *di;
> 
>@@ -2659,19 +2660,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>         if (value) {
>             switch (value->type) {
>             case MEMORY_DEVICE_INFO_KIND_DIMM:
>-                di = value->u.dimm.data;
>-                break;
>-
>             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
>-                di = value->u.nvdimm.data;
>-                break;
>-
>-            default:
>-                di = NULL;
>-                break;
>-            }
>-
>-            if (di) {
>+                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
>+                     value->u.dimm.data : value->u.nvdimm.data;
>                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>                                MemoryDeviceInfoKind_str(value->type),
>                                di->id ? di->id : "");
>@@ -2684,6 +2675,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                                di->hotplugged ? "true" : "false");
>                 monitor_printf(mon, "  hotpluggable: %s\n",
>                                di->hotpluggable ? "true" : "false");
>+                break;
>+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
>+                vpi = value->u.virtio_pmem.data;
>+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>+                               MemoryDeviceInfoKind_str(value->type),
>+                               vpi->id ? vpi->id : "");
>+                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
>+                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
>+                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
>+                break;
>+            default:
>+                g_assert_not_reached();
>             }
>         }
>     }
>-- 
>2.14.5
>

-- 
Wei Yang
Help you, Help me

