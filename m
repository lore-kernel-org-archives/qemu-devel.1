Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F7A21852
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLxdJ2xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F7A21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1JO-00060Y-5U
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iX1Hw-00055S-GB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iX1Ht-00040E-Nw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:03:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iX1Ht-0003zZ-Fg
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574161393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjluwWqFspokwTY1b2ig/4hZNJuFshSN1maGW5YAEkw=;
 b=SLxdJ2xAIdVm6YwjWV0HoprQZ0Zv4ZF4AupbAuKt4oObatvnhfgA7+uucW7fLPMhD+bn6P
 A0h61HHZSWaF3zOXn6WKhkkULYhYYJCvufymTueqj8bwdE4gjDvLTW8NXqY2qsVwI09hJ8
 CnpnuN3/Hyi8r66pcSHDhXIJGbNe4wE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-K4W0tRgdOfOVdqQdSoXqAA-1; Tue, 19 Nov 2019 06:03:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE5D7DC20;
 Tue, 19 Nov 2019 11:03:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 413EB691A2;
 Tue, 19 Nov 2019 11:03:04 +0000 (UTC)
Date: Tue, 19 Nov 2019 12:03:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v16 08/14] numa: Extend CLI to provide memory latency
 and bandwidth information
Message-ID: <20191119120302.6ff9e61e@redhat.com>
In-Reply-To: <20191115075352.17734-9-tao3.xu@intel.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-9-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: K4W0tRgdOfOVdqQdSoXqAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 15:53:46 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>=20
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

looks good to me, so

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


PS:
also see question below

> ---
>=20
> Changes in v16:
>     - Initialize HMAT_LB_Data lb_data (Igor)
>     - Remove punctuation from error_setg (Igor)
>     - Correct some description (Igor)
>     - Drop statement about max value (Igor)
>     - Simplify struct HMAT_LB_Info and related code, unify latency
>       and bandwidth (Igor)
>=20
> Changes in v15:
>     - Change the QAPI version tag to 5.0 (Eric)
>=20
> Changes in v14:
>     - Use qemu ctz64 and clz64 instead of builtin function
>     - Improve help message in qemu-options.hx
> ---
>  hw/core/numa.c        | 174 ++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/numa.h |  53 +++++++++++++
>  qapi/machine.json     |  94 ++++++++++++++++++++++-
>  qemu-options.hx       |  49 +++++++++++-
>  4 files changed, 367 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index e60da99293..47c7a96863 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/sysemu.h"
> @@ -198,6 +199,166 @@ void parse_numa_distance(MachineState *ms, NumaDist=
Options *dist, Error **errp)
>      ms->numa_state->have_numa_distance =3D true;
>  }
> =20
> +void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
> +                        Error **errp)
> +{
> +    int i, first_bit, last_bit;
> +    uint64_t max_entry, temp_base_la;
> +    NodeInfo *numa_info =3D numa_state->nodes;
> +    HMAT_LB_Info *hmat_lb =3D
> +        numa_state->hmat_lb[node->hierarchy][node->data_type];
> +    HMAT_LB_Data lb_data =3D {};
> +    HMAT_LB_Data *lb_temp;
> +
> +    /* Error checking */
> +    if (node->initiator > numa_state->num_nodes) {
> +        error_setg(errp, "Invalid initiator=3D%d, it should be less than=
 %d",
> +                   node->initiator, numa_state->num_nodes);
> +        return;
> +    }
> +    if (node->target > numa_state->num_nodes) {
> +        error_setg(errp, "Invalid target=3D%d, it should be less than %d=
",
> +                   node->target, numa_state->num_nodes);
> +        return;
> +    }
> +    if (!numa_info[node->initiator].has_cpu) {
> +        error_setg(errp, "Invalid initiator=3D%d, it isn't an "
> +                   "initiator proximity domain", node->initiator);
> +        return;
> +    }
> +    if (!numa_info[node->target].present) {
> +        error_setg(errp, "The target=3D%d should point to an existing no=
de",
> +                   node->target);
> +        return;
> +    }
> +
> +    if (!hmat_lb) {
> +        hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
> +        numa_state->hmat_lb[node->hierarchy][node->data_type] =3D hmat_l=
b;
> +        hmat_lb->list =3D g_array_new(false, true, sizeof(HMAT_LB_Data))=
;
> +    }
> +    hmat_lb->hierarchy =3D node->hierarchy;
> +    hmat_lb->data_type =3D node->data_type;
> +    lb_data.initiator =3D node->initiator;
> +    lb_data.target =3D node->target;
> +
> +    if (node->data_type <=3D HMATLB_DATA_TYPE_WRITE_LATENCY) {
> +        /* Input latency data */
> +
> +        if (!node->has_latency) {
> +            error_setg(errp, "Missing 'latency' option");
> +            return;
> +        }
> +        if (node->has_bandwidth) {
> +            error_setg(errp, "Invalid option 'bandwidth' since "
> +                       "the data type is latency");
> +            return;
> +        }
> +
> +        /* Detect duplicate configuration */
> +        for (i =3D 0; i < hmat_lb->list->len; i++) {
> +            lb_temp =3D &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
> +
> +            if (node->initiator =3D=3D lb_temp->initiator &&
> +                node->target =3D=3D lb_temp->target) {
> +                error_setg(errp, "Duplicate configuration of the latency=
 for "
> +                    "initiator=3D%d and target=3D%d", node->initiator,
> +                    node->target);
> +                return;
> +            }
> +        }
> +
> +        hmat_lb->base =3D hmat_lb->base ? hmat_lb->base : UINT64_MAX;
> +
> +        /* Calculate the temporary base and compressed latency */
> +        max_entry =3D node->latency;
> +        temp_base_la =3D 1;
> +        while (QEMU_IS_ALIGNED(max_entry, 10)) {
> +            max_entry /=3D 10;
> +            temp_base_la *=3D 10;
> +        }
> +
> +        /* Calculate the max compressed latency */
> +        hmat_lb->base =3D MIN(hmat_lb->base, temp_base_la);
> +        max_entry =3D node->latency / hmat_lb->base;
> +        hmat_lb->range_bitmap =3D MAX(hmat_lb->range_bitmap, max_entry);
> +
> +        /*
> +         * For latency hmat_lb->range_bitmap record the max compressed l=
atency
> +         * which should be less than 0xFFFF (UINT16_MAX)
> +         */
> +        if (hmat_lb->range_bitmap >=3D UINT16_MAX) {
> +            error_setg(errp, "Latency %" PRIu64 " between initiator=3D%d=
 and "
> +                       "target=3D%d should not differ from previously en=
tered "
> +                       "min or max values on more than %d", node->latenc=
y,
> +                       node->initiator, node->target, UINT16_MAX - 1);
> +            return;
> +        }
> +
> +        /* Set lb_info_provided bit 0 as 1, latency information is provi=
ded */
> +        numa_info[node->target].lb_info_provided |=3D BIT(0);
> +        lb_data.data =3D node->latency;
> +    } else if (node->data_type >=3D HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
> +        /* Input bandwidth data */
> +
> +        if (!node->has_bandwidth) {
> +            error_setg(errp, "Missing 'bandwidth' option");
> +            return;
> +        }
> +        if (node->has_latency) {
> +            error_setg(errp, "Invalid option 'latency' since "
> +                       "the data type is bandwidth");
> +            return;
> +        }
> +        if (!QEMU_IS_ALIGNED(node->bandwidth, MiB)) {
> +            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=3D=
%d and "
> +                       "target=3D%d should be 1MB aligned", node->bandwi=
dth,
> +                       node->initiator, node->target);
> +            return;
> +        }
> +
> +        /* Detect duplicate configuration */
> +        for (i =3D 0; i < hmat_lb->list->len; i++) {
> +            lb_temp =3D &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
> +
> +            if (node->initiator =3D=3D lb_temp->initiator &&
> +                node->target =3D=3D lb_temp->target) {
> +                error_setg(errp, "Duplicate configuration of the bandwid=
th for "
> +                    "initiator=3D%d and target=3D%d", node->initiator,
> +                    node->target);
> +                return;
> +            }
> +        }
> +
> +        hmat_lb->range_bitmap |=3D node->bandwidth;
> +        first_bit =3D ctz64(hmat_lb->range_bitmap);
> +        hmat_lb->base =3D UINT64_C(1) << first_bit;
> +        max_entry =3D node->bandwidth / hmat_lb->base;
> +        last_bit =3D 64 - clz64(hmat_lb->range_bitmap);
> +
> +        /*
> +         * For bandwidth, first_bit record the base unit of bandwidth bi=
ts,
> +         * last_bit record the last bit of the max bandwidth. The max co=
mpressed
> +         * bandwidth should be less than 0xFFFF (UINT16_MAX)
> +         */
> +        if ((last_bit - first_bit) > UINT16_BITS || max_entry >=3D UINT1=
6_MAX) {
                                                       ^^^^^^^^^^^^^^^^^^^
what bandwidth combination is going to trigger above condition?

> +            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=3D=
%d and "
> +                       "target=3D%d should not differ from previously en=
tered "
> +                       "values on more than %d", node->bandwidth,
> +                       node->initiator, node->target, UINT16_MAX - 1);
> +            return;
> +        }
> +
> +        /* Set lb_info_provided bit 1 as 1, bandwidth information is pro=
vided */
> +        numa_info[node->target].lb_info_provided |=3D BIT(1);
> +        lb_data.data =3D node->bandwidth;
> +    } else {
> +        assert(0);
> +    }
> +
> +    g_array_append_val(hmat_lb->list, lb_data);
> +}
> +
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
>  {
>      Error *err =3D NULL;
> @@ -236,6 +397,19 @@ void set_numa_options(MachineState *ms, NumaOptions =
*object, Error **errp)
>          machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->=
u.cpu),
>                                    &err);
>          break;
> +    case NUMA_OPTIONS_TYPE_HMAT_LB:
> +        if (!ms->numa_state->hmat_enabled) {
> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table =
"
> +                       "(HMAT) is disabled, enable it with -machine hmat=
=3Don "
> +                       "before using any of hmat specific options");
> +            return;
> +        }
> +
> +        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, &err);
> +        if (err) {
> +            goto end;
> +        }
> +        break;
>      default:
>          abort();
>      }
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 788cbec7a2..70f93c83d7 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -14,11 +14,34 @@ struct CPUArchId;
>  #define NUMA_DISTANCE_MAX         254
>  #define NUMA_DISTANCE_UNREACHABLE 255
> =20
> +/* the value of AcpiHmatLBInfo flags */
> +enum {
> +    HMAT_LB_MEM_MEMORY           =3D 0,
> +    HMAT_LB_MEM_CACHE_1ST_LEVEL  =3D 1,
> +    HMAT_LB_MEM_CACHE_2ND_LEVEL  =3D 2,
> +    HMAT_LB_MEM_CACHE_3RD_LEVEL  =3D 3,
> +    HMAT_LB_LEVELS   /* must be the last entry */
> +};
> +
> +/* the value of AcpiHmatLBInfo data type */
> +enum {
> +    HMAT_LB_DATA_ACCESS_LATENCY   =3D 0,
> +    HMAT_LB_DATA_READ_LATENCY     =3D 1,
> +    HMAT_LB_DATA_WRITE_LATENCY    =3D 2,
> +    HMAT_LB_DATA_ACCESS_BANDWIDTH =3D 3,
> +    HMAT_LB_DATA_READ_BANDWIDTH   =3D 4,
> +    HMAT_LB_DATA_WRITE_BANDWIDTH  =3D 5,
> +    HMAT_LB_TYPES   /* must be the last entry */
> +};
> +
> +#define UINT16_BITS       16
> +
>  struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
>      bool has_cpu;
> +    uint8_t lb_info_provided;
>      uint16_t initiator;
>      uint8_t distance[MAX_NODES];
>  };
> @@ -28,6 +51,31 @@ struct NumaNodeMem {
>      uint64_t node_plugged_mem;
>  };
> =20
> +struct HMAT_LB_Data {
> +    uint8_t     initiator;
> +    uint8_t     target;
> +    uint64_t    data;
> +};
> +typedef struct HMAT_LB_Data HMAT_LB_Data;
> +
> +struct HMAT_LB_Info {
> +    /* Indicates it's memory or the specified level memory side cache. *=
/
> +    uint8_t     hierarchy;
> +
> +    /* Present the type of data, access/read/write latency or bandwidth.=
 */
> +    uint8_t     data_type;
> +
> +    /* The range bitmap of bandwidth for calculating common base */
> +    uint64_t    range_bitmap;
> +
> +    /* The common base unit for latencies or bandwidths */
> +    uint64_t    base;
> +
> +    /* Array to store the latencies or bandwidths */
> +    GArray      *list;
> +};
> +typedef struct HMAT_LB_Info HMAT_LB_Info;
> +
>  struct NumaState {
>      /* Number of NUMA nodes */
>      int num_nodes;
> @@ -40,11 +88,16 @@ struct NumaState {
> =20
>      /* NUMA nodes information */
>      NodeInfo nodes[MAX_NODES];
> +
> +    /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
> +    HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
>  };
>  typedef struct NumaState NumaState;
> =20
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p);
>  void parse_numa_opts(MachineState *ms);
> +void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
> +                        Error **errp);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
>  extern QemuOptsList qemu_numa_opts;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 27d0e37534..67f5910400 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -426,10 +426,12 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> +# @hmat-lb: memory latency and bandwidth information (Since: 5.0)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> =20
>  ##
>  # @NumaOptions:
> @@ -444,7 +446,8 @@
>    'data': {
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
> -    'cpu': 'NumaCpuOptions' }}
> +    'cpu': 'NumaCpuOptions',
> +    'hmat-lb': 'NumaHmatLBOptions' }}
> =20
>  ##
>  # @NumaNodeOptions:
> @@ -557,6 +560,93 @@
>     'base': 'CpuInstanceProperties',
>     'data' : {} }
> =20
> +##
> +# @HmatLBMemoryHierarchy:
> +#
> +# The memory hierarchy in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information about @HmatLBMemoryHierarchy see
> +# the chapter 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
> +#
> +# @memory: the structure represents the memory performance
> +#
> +# @first-level: first level of memory side cache
> +#
> +# @second-level: second level of memory side cache
> +#
> +# @third-level: third level of memory side cache
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatLBMemoryHierarchy',
> +  'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
> +
> +##
> +# @HmatLBDataType:
> +#
> +# Data type in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information about @HmatLBDataType see
> +# the chapter 5.2.27.4: Table 5-146:  Field "Data Type" of ACPI 6.3 spec=
.
> +#
> +# @access-latency: access latency (nanoseconds)
> +#
> +# @read-latency: read latency (nanoseconds)
> +#
> +# @write-latency: write latency (nanoseconds)
> +#
> +# @access-bandwidth: access bandwidth (B/s)
> +#
> +# @read-bandwidth: read bandwidth (B/s)
> +#
> +# @write-bandwidth: write bandwidth (B/s)
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatLBDataType',
> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
> +
> +##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information
> +# between Initiator and Target proximity Domains.
> +#
> +# For more information about @NumaHmatLBOptions see
> +# the chapter 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance
> +#             of memory or side cache.
> +#
> +# @data-type: presents the type of data, access/read/write
> +#             latency or hit latency.
> +#
> +# @latency: the value of latency from @initiator to @target proximity do=
main,
> +#           the latency unit is "ns(nanosecond)".
> +#
> +# @bandwidth: the value of bandwidth between @initiator and @target prox=
imity
> +#             domain, the bandwidth unit is "B(/s)".
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +    'data': {
> +    'initiator': 'uint16',
> +    'target': 'uint16',
> +    'hierarchy': 'HmatLBMemoryHierarchy',
> +    'data-type': 'HmatLBDataType',
> +    '*latency': 'time',
> +    '*bandwidth': 'size' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 63f6b33322..929d275450 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -168,16 +168,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
[,initiator=3Dnode]\n"
>      "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
> -    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n",
> +    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
> +    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
> +@itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarch=
y=3D@var{hierarchy},data-type=3D@var{tpye}[,latency=3D@var{lat}][,bandwidth=
=3D@var{bw}]
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> +Set the ACPI Heterogeneous Memory Attributes for the given nodes.
> =20
>  Legacy VCPU assignment uses @samp{cpus} option where
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> @@ -256,6 +259,50 @@ specified resources, it just assigns existing resour=
ces to NUMA
>  nodes. This means that one still has to use the @option{-m},
>  @option{-smp} options to allocate RAM and VCPUs respectively.
> =20
> +Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Informat=
ion
> +between initiator and target NUMA nodes in ACPI Heterogeneous Attribute =
Memory Table (HMAT).
> +Initiator NUMA node can create memory requests, usually it has one or mo=
re processors.
> +Target NUMA node contains addressable memory.
> +
> +In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{hierarchy} =
is the memory
> +hierarchy of the target NUMA node: if @var{hierarchy} is 'memory', the s=
tructure
> +represents the memory performance; if @var{hierarchy} is 'first-level|se=
cond-level|third-level',
> +this structure represents aggregated performance of memory side caches f=
or each domain.
> +@var{type} of 'data-type' is type of data represented by this structure =
instance:
> +if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latency o=
r 'access|read|write'
> +bandwidth of the target memory; if 'hierarchy' is 'first-level|second-le=
vel|third-level',
> +'data-type' is 'access|read|write' hit latency or 'access|read|write' hi=
t bandwidth of the
> +target memory side cache.
> +
> +@var{lat} is latency value, the possible value and units are NUM[ns|us|m=
s]
> +(nanosecond|microsecond|millisecond), the recommended unit is 'ns'. @var=
{bw} is
> +bandwidth value, the possible value and units are NUM[M|G|T], mean that =
the
> +bandwidth value are NUM byte (or MB/s, GB/s or TB/s depending on used su=
ffix).
> +Note that if NUM is 0, means the corresponding latency or bandwidth info=
rmation
> +is not provided. And if input numbers without any unit, the latency unit=
 will be
> +'ns' and the bandwidth will be B/s.
> +
> +For example, the following options describe 2 NUMA nodes. Node 0 has 2 c=
pus and
> +a ram, node 1 has only a ram. The processors in node 0 access memory in =
node
> +0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
> +The processors in NUMA node 0 access memory in NUMA node 1 with access-l=
atency 10
> +nanoseconds, access-bandwidth is 100 MB/s.
> +@example
> +-machine hmat=3Don \
> +-m 2G \
> +-object memory-backend-ram,size=3D1G,id=3Dm0 \
> +-object memory-backend-ram,size=3D1G,id=3Dm1 \
> +-smp 2 \
> +-numa node,nodeid=3D0,memdev=3Dm0 \
> +-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D1 \
> +-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D5ns \
> +-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D200M \
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D10ns \
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M
> +@end example
> +
>  ETEXI
> =20
>  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,


