Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2721C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 03:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B9E20709
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 03:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B9E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU06w-0006Yu-GE
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 23:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jU06I-00060H-Bi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 23:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jU06G-0003SB-U4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 23:43:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:62068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jU06G-0003Rx-DI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 23:43:00 -0400
IronPort-SDR: QSOJUMhqdOfDEIy/L8lYxU1yT/dwmTppuGqyjkl72Rr6KnY8lO6qR74uwV3IUvVZNpGy+ymKRX
 QnXwGbAjxwTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 20:42:54 -0700
IronPort-SDR: m0BUJncbxPfXyWaHVQQ0EZT3x1PX6WfWEt5xRUTjDcU95UX3133kTs9Z/09b9GcUyPo0Ba0ayS
 bn58geh4kutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
 d="scan'208,217";a="276380133"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.213.246])
 ([10.254.213.246])
 by orsmga002.jf.intel.com with ESMTP; 29 Apr 2020 20:42:51 -0700
Subject: Re: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
 <20200428012810.10877-3-vishal.l.verma@intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <a6aa8f4d-7c19-fc8b-6f1f-7db808ae251f@intel.com>
Date: Thu, 30 Apr 2020 11:42:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428012810.10877-3-vishal.l.verma@intel.com>
Content-Type: multipart/alternative;
 boundary="------------5C6A772E3EF45D09E0C2257E"
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jingqi.liu@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:42:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5C6A772E3EF45D09E0C2257E
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2020 9:28 AM, Verma, Vishal L wrote:
> NVDIMMs can belong to their own proximity domains, as described by the
> NFIT. In such cases, the SRAT needs to have Memory Affinity structures
> in the SRAT for these NVDIMMs, otherwise Linux doesn't populate node
> data structures properly during NUMA initialization. See the following
> for an example failure case.
>
> https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/
>
> Fix this by adding device address range and node information from
> NVDIMMs to the SRAT in build_srat().
>
> The relevant command line options to exercise this are below. Nodes 0-1
> contain CPUs and regular memory, and nodes 2-3 are the NVDIMM address
> space.
>
>    -numa node,nodeid=0,mem=2048M,
>    -numa node,nodeid=1,mem=2048M,
>    -numa node,nodeid=2,mem=0,
>    -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=128M
>    -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=2
>    -numa node,nodeid=3,mem=0,
>    -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=128M
>    -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=3
>
> Cc: Jingqi Liu <jingqi.liu@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>   hw/i386/acpi-build.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 23c77eeb95..b0da67de0e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -48,6 +48,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/mem/memory-device.h"
>   #include "hw/mem/nvdimm.h"
> +#include "qemu/nvdimm-utils.h"
>   #include "sysemu/numa.h"
>   #include "sysemu/reset.h"
>   
> @@ -2429,6 +2430,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                                 MEM_AFFINITY_ENABLED);
>           }
>       }
> +
> +    if (machine->nvdimms_state->is_enabled) {
> +        GSList *device_list = nvdimm_get_device_list();
> +
> +        for (; device_list; device_list = device_list->next) {
> +            DeviceState *dev = device_list->data;
> +            int node = object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,
> +                                               NULL);
> +            uint64_t addr = object_property_get_uint(OBJECT(dev),
> +                                                     PC_DIMM_ADDR_PROP, NULL);
> +            uint64_t size = object_property_get_uint(OBJECT(dev),
> +                                                     PC_DIMM_SIZE_PROP, NULL);
> +
> +            numamem = acpi_data_push(table_data, sizeof *numamem);
> +            build_srat_memory(numamem, addr, size, node,
> +                              MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
> +        }
> +    }
> +

Looks good for me.
Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>

Thanks,
Jingqi

>       slots = (table_data->len - numa_start) / sizeof *numamem;
>       for (; slots < pcms->numa_nodes + 2; slots++) {
>           numamem = acpi_data_push(table_data, sizeof *numamem);

--------------5C6A772E3EF45D09E0C2257E
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
  </head>
  <body>
    <div class="moz-cite-prefix">On 4/28/2020 9:28 AM, Verma, Vishal L
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200428012810.10877-3-vishal.l.verma@intel.com">
      <pre class="moz-quote-pre" wrap="">NVDIMMs can belong to their own proximity domains, as described by the
NFIT. In such cases, the SRAT needs to have Memory Affinity structures
in the SRAT for these NVDIMMs, otherwise Linux doesn't populate node
data structures properly during NUMA initialization. See the following
for an example failure case.

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/">https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/</a>

Fix this by adding device address range and node information from
NVDIMMs to the SRAT in build_srat().

The relevant command line options to exercise this are below. Nodes 0-1
contain CPUs and regular memory, and nodes 2-3 are the NVDIMM address
space.

  -numa node,nodeid=0,mem=2048M,
  -numa node,nodeid=1,mem=2048M,
  -numa node,nodeid=2,mem=0,
  -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=128M
  -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=2
  -numa node,nodeid=3,mem=0,
  -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=128M
  -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=3

Cc: Jingqi Liu <a class="moz-txt-link-rfc2396E" href="mailto:jingqi.liu@intel.com">&lt;jingqi.liu@intel.com&gt;</a>
Cc: Michael S. Tsirkin <a class="moz-txt-link-rfc2396E" href="mailto:mst@redhat.com">&lt;mst@redhat.com&gt;</a>
Signed-off-by: Vishal Verma <a class="moz-txt-link-rfc2396E" href="mailto:vishal.l.verma@intel.com">&lt;vishal.l.verma@intel.com&gt;</a>
---
 hw/i386/acpi-build.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 23c77eeb95..b0da67de0e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -48,6 +48,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "qemu/nvdimm-utils.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 
@@ -2429,6 +2430,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
                               MEM_AFFINITY_ENABLED);
         }
     }
+
+    if (machine-&gt;nvdimms_state-&gt;is_enabled) {
+        GSList *device_list = nvdimm_get_device_list();
+
+        for (; device_list; device_list = device_list-&gt;next) {
+            DeviceState *dev = device_list-&gt;data;
+            int node = object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,
+                                               NULL);
+            uint64_t addr = object_property_get_uint(OBJECT(dev),
+                                                     PC_DIMM_ADDR_PROP, NULL);
+            uint64_t size = object_property_get_uint(OBJECT(dev),
+                                                     PC_DIMM_SIZE_PROP, NULL);
+
+            numamem = acpi_data_push(table_data, sizeof *numamem);
+            build_srat_memory(numamem, addr, size, node,
+                              MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
+        }
+    }
+</pre>
    </blockquote>
    <pre>Looks good for me.
Reviewed-by: Jingqi Liu <a class="moz-txt-link-rfc2396E" href="mailto:jingqi.liu@intel.com">&lt;jingqi.liu@intel.com&gt;</a>

Thanks,
Jingqi
</pre>
    <blockquote type="cite"
      cite="mid:20200428012810.10877-3-vishal.l.verma@intel.com">
      <pre class="moz-quote-pre" wrap="">
     slots = (table_data-&gt;len - numa_start) / sizeof *numamem;
     for (; slots &lt; pcms-&gt;numa_nodes + 2; slots++) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
</pre>
    </blockquote>
  </body>
</html>

--------------5C6A772E3EF45D09E0C2257E--

