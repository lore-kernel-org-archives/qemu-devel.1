Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB5C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1573D20684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1573D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2ez-0006b2-5b
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 01:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <daniel@linux.ibm.com>) id 1hx2eY-00069e-GQ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel@linux.ibm.com>) id 1hx2eW-0008Sq-O2
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:13:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21238
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <daniel@linux.ibm.com>)
 id 1hx2eW-0008S2-Hv
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:13:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7C5C8oT065483
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:13:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uatghu74d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:13:50 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <daniel@linux.ibm.com>;
 Mon, 12 Aug 2019 06:13:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Aug 2019 06:13:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7C5DiEd59834456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2019 05:13:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C06094C040;
 Mon, 12 Aug 2019 05:13:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BF354C044;
 Mon, 12 Aug 2019 05:13:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2019 05:13:44 +0000 (GMT)
Received: from volution.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 57EABA021B;
 Mon, 12 Aug 2019 15:13:43 +1000 (AEST)
Date: Mon, 12 Aug 2019 15:13:40 +1000
From: Daniel Black <daniel@linux.ibm.com>
To: Tao <tao3.xu@intel.com>
In-Reply-To: <20190809065731.9097-10-tao3.xu@intel.com>
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-10-tao3.xu@intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19081205-0008-0000-0000-00000308096E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081205-0009-0000-0000-00004A26171E
Message-Id: <20190812151340.567e1cb6@volution.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-12_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v9 09/11] numa: Extend the CLI to provide
 memory latency and bandwidth information
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, imammedo@redhat.com,
 dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Tao Xu, Liu Jingqi,

Thanks for doing these updates.

On Fri,  9 Aug 2019 14:57:29 +0800
Tao <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
> 
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  hw/acpi/hmat.h        |   3 +
>  hw/core/numa.c        | 185
> ++++++++++++++++++++++++++++++++++++++++++ include/sysemu/numa.h |
> 2 + qapi/machine.json     |  95 +++++++++++++++++++++-
>  qemu-options.hx       |  44 +++++++++-
>  5 files changed, 326 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
> index 6c32f12e78..b7c1e02cf0 100644
> --- a/hw/acpi/hmat.h
> +++ b/hw/acpi/hmat.h
> @@ -42,6 +42,9 @@
>  
>  #define HMAT_IS_LATENCY(type) (type <= HMAT_LB_DATA_WRITE_LATENCY)
>  
> +#define PICO_PER_USEC 1000000
> +#define PICO_PER_NSEC 1000
> +
>  struct HMAT_LB_Info {
>      /*
>       * Indicates total number of Proximity Domains
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index cfb6339810..9a494145f3 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -37,6 +37,7 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
> +#include "hw/acpi/hmat.h"
>  
>  QemuOptsList qemu_numa_opts = {
>      .name = "numa",
> @@ -183,6 +184,184 @@ void parse_numa_distance(MachineState *ms,
> NumaDistOptions *dist, Error **errp)
> ms->numa_state->have_numa_distance = true; }
>  
> +void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
> +                        Error **errp)
> +{
..

Optional; you could support not connected (0xffff) for latency/bandwidth in
this parsing.

> +        if (*endptr == '\0') {
> +            base_lat = 1;
> +        } else if (*(endptr + 1) == 's') {
> +            switch (*endptr) {
> +            case 'p':
> +                base_lat = 1;
> +                break;
> +            case 'n':
> +                base_lat = PICO_PER_NSEC;
> +                break;
> +            case 'u':

Glad you picked up my mismatch of "u/micro".

> +        } else {
> +            error_setg(errp, "Invalid latency unit %s,"
> +                "vaild units are \"ps\" \"ns\" \"us\"",
>node->latency);

typo "valid"

> +        } else if (hmat_lb->base_lat != base_lat) {
> +            error_setg(errp, "Invalid latency unit %s,"
> +                " please unify the units.", node->latency);

This error is misleading. Should be something like "all latencies must be
specified in the same units"

> +        switch (toupper(*endptr)) {
> +        case '\0':
> +        case 'M':
> +            base_bw = 1;
> +            break;
> +        case 'G':
> +            base_bw = UINT64_C(1) << 10;
> +            break;

There was one more gap - Terra.

        case 'T':
           base_bw = UINT64_C(1) << 20;
           break;

> +        case 'P':
> +            base_bw = UINT64_C(1) << 20;
and:
               base_bw = UINT64_C(1) << 30;

> +            break;
> +        }


Currently Linux 5.3.0-rc3+ doesn't cope with real corrected "bandwidth=2P" so
maybe not worth it.

[    2.092060] HMAT: Locality: Flags:00 Type:Access Bandwidth Initiator
Domains:1 Target Domains:2 Base:1073741824 [    2.092326]   Initiator-Target[0-0]:-2147483648 MB/s

On values, testing for overflow is required. e.g:

 -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=4096T
bandwidth=4096T

[    2.047676] HMAT: Locality: Flags:00 Type:Access Bandwidth Initiator Domains:1 Target Domains:2 Base:1048576
[    2.048084]   Initiator-Target[0-0]:0 MB/s

Technically ACPI could support up to 4P with base/offset but you'd need to be a
lot trickier (i.e. base is highest common multiple of all entries and then see
if entry/base > 2^32-2 ) with base/entry values to arrive at this number.

+docs/commit message propagation of this.


> +        } else if (hmat_lb->base_lat != base_lat) {

Bug: Incorrectly copied - base_lat should be base_bw (twice)

> +            error_setg(errp, "Invalid bandwidth unit %s,"
> +                " please unify the units.", node->bandwidth);

This error is misleading. Should be something like "all bandwidths must be
specified in the same units"

> diff --git a/qemu-options.hx b/qemu-options.hx
> index c480781992..cda4607f3a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx

> +@example
> +-m 2G \
> +-object memory-backend-ram,size=1024M,policy=bind,host-nodes=0,id=ram-node0 -numa node,nodeid=0,memdev=ram-node0 \
> +-object memory-backend-ram,size=1024M,policy=bind,host-nodes=1,id=ram-node1 -numa node,nodeid=1,memdev=ram-node1 \
> +-smp 2 \
> +-numa cpu,node-id=0,socket-id=0 \
> +-numa cpu,node-id=0,socket-id=1 \
> +-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5ns \
> +-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10ns \
> +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
> +@end example

nit: remove slash on last line

Is this a valid example? I get

qemu-system-x86_64: -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=11us: Invalid target=1, it hasn't a valid initiator proximity domain.

(I tested with host-nodes=1 changed to 0 as local machine is single node)

Technically on [PATCH v9 07/11]
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index abf99b1adc..431818dc82 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -67,11 +67,81 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
     build_append_int_noprefix(table_data, 0, 8);
 }
 
+/*
+ * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+ * Structure: Table 5-142

nit: 5-146

Test as follows:

qemu-system-x86_64   -kernel /home/dan/repos/linux/vmlinux   -nographic -append  console=ttyS0  \
   -m 2G -object memory-backend-ram,size=1024M,policy=bind,host-nodes=0,id=ram-node0 \
   -numa node,nodeid=0,memdev=ram-node0 \
   -object memory-backend-ram,size=1024M,policy=bind,host-nodes=0,id=ram-node1 \
   -numa node,nodeid=1,memdev=ram-node1 -smp 2 -numa cpu,node-id=0,socket-id=0 \
   -numa cpu,node-id=0,socket-id=1  \
   -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=123us \
   -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
   -numa hmat-cache,node-id=0,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8 \
   -numa hmat-cache,node-id=1,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8 \
| grep -A 5 HMAT


[    0.038912] ACPI: HMAT 0x000000007FFE16C5 000118 (v02 BOCHS  BXPCHMAT 00000001 BXPC 00000001)
[    0.040954] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.040999] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.041189] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.041250] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x3fffffff]
[    0.041276] ACPI: SRAT: Node 1 PXM 1 [mem 0x40000000-0x7fffffff]
--
[    1.984572] HMAT: Memory Flags:0001 Processor Domain:0 Memory Domain:0
[    1.984792] HMAT: Memory Flags:0000 Processor Domain:0 Memory Domain:1
[    1.985435] HMAT: Locality: Flags:00 Type:Access Latency Initiator Domains:1 Target Domains:2 Base:1000000
[    1.986424]   Initiator-Target[0-0]:123000 nsec
[    1.986664]   Initiator-Target[0-1]:0 nsec
[    1.986910] HMAT: Locality: Flags:00 Type:Access Bandwidth Initiator Domains:1 Target Domains:2 Base:1
[    1.987229]   Initiator-Target[0-0]:200 MB/s
[    1.987356]   Initiator-Target[0-1]:0 MB/s
[    1.987549] HMAT: Cache: Domain:0 Size:131072 Attrs:00081111 SMBIOS Handles:0
[    1.988393] HMAT: Cache: Domain:1 Size:131072 Attrs:00081111 SMBIOS Handles:0

Leaving default latency/bw as 0 if ok as spec says '0: the corresponding latency
or bandwidth information is not provided.'. Potentially the kernel could display this better.

Also note https://marc.info/?l=linux-acpi&m=156506549410279&w=2 submitted as
hmat_build_table_structs only calls build_hmat_mpda with flags=0 or HMAT_PROX_INIT_VALID (0x1) which is right looking at ACPI-6.3. An Ack/(Nack if I'm wrong) there would be good to have both kernel and this patch series working together.

for entire series:

Reviewed-by: Daniel Black <daniel@linux.ibm.com>


