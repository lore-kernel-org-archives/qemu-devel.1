Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A198DFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F72C2245B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ1StNj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F72C2245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2g0-0007qR-HC
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iT2fC-0007S1-BH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iT2f9-0002qP-3t
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:42:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iT2f8-0002pv-Un
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573213366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oO7tTJsNWjHt9d9vrLxda9lf8Z2oIpgP9Gq137gmJbQ=;
 b=BZ1StNj9RwOhW8fNYagq9++dKazAthrfcycRXYW31LcVRBo3SdEksz2PTei/tKBbXETn0U
 7MmUsPnJqrTBVdAhSNxPz5Gd0SX+cv4tI247B3BJBqoOyJwFmdO3Ecejyizyo3RVGnWkmW
 hoU4np1P+Cn9ieTy7JbU4OgwpmEgvA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-sUjqnAqNMViZ-NhqAG1PAA-1; Fri, 08 Nov 2019 06:42:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B04477;
 Fri,  8 Nov 2019 11:42:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1C3A608B3;
 Fri,  8 Nov 2019 11:42:35 +0000 (UTC)
Date: Fri, 8 Nov 2019 12:42:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 06/12] numa: Extend CLI to provide memory latency
 and bandwidth information
Message-ID: <20191108124234.5ec21c98@redhat.com>
In-Reply-To: <20191107074511.14304-7-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-7-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sUjqnAqNMViZ-NhqAG1PAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Thu,  7 Nov 2019 15:45:05 +0800
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
> ---
>=20
> Changes in v15:
>     - Change the QAPI version tag to 5.0 (Eric)
>=20
> Changes in v14:
>     - Use qemu ctz64 and clz64 instead of builtin function
>     - Improve help message in qemu-options.hx
>=20
> Changes in v13:
>     - Reuse Garray to store the raw bandwidth and bandwidth data
>     - Calculate common base unit using range bitmap (Igor)
> ---
>  hw/core/numa.c        | 136 ++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/numa.h |  68 +++++++++++++++++++++
>  qapi/machine.json     |  94 ++++++++++++++++++++++++++++-
>  qemu-options.hx       |  49 ++++++++++++++-
>  4 files changed, 344 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index eba66ab768..f391760c20 100644
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
> @@ -198,6 +199,128 @@ void parse_numa_distance(MachineState *ms, NumaDist=
Options *dist, Error **errp)
>      ms->numa_state->have_numa_distance =3D true;
>  }
> =20
> +void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
> +                        Error **errp)
> +{
> +    int first_bit, last_bit;
> +    uint64_t max_latency, temp_base_la;
> +    NodeInfo *numa_info =3D numa_state->nodes;
> +    HMAT_LB_Info *hmat_lb =3D
> +        numa_state->hmat_lb[node->hierarchy][node->data_type];
> +    HMAT_LB_Data lb_data;
maybe
  HMAT_LB_Data lb_data =3D {};
to make sure that no members are left un-initialized=20

> +
> +    /* Error checking */
> +    if (node->initiator >=3D numa_state->num_nodes) {
> +        error_setg(errp, "Invalid initiator=3D%d, it should be less than=
 %d.",
error_setg(), shouldn't have "." at the end
see include/qapi/error.h:error_setg() description

this applies to all such uses with this series.

> +                   node->initiator, numa_state->num_nodes);
> +        return;
> +    }
> +    if (node->target >=3D numa_state->num_nodes) {
> +        error_setg(errp, "Invalid target=3D%d, it should be less than %d=
.",
> +                   node->target, numa_state->num_nodes);
> +        return;
> +    }
> +    if (!numa_info[node->initiator].has_cpu) {
> +        error_setg(errp, "Invalid initiator=3D%d, it isn't an "
> +                   "initiator proximity domain.", node->initiator);
> +        return;
> +    }
> +    if (!numa_info[node->target].present) {
> +        error_setg(errp, "Invalid target=3D%d, it hasn't a valid NUMA no=
de.",
s/\..*\./the target should point to an existing node"/

> +                   node->target);
> +        return;
> +    }
> +
> +    if (!hmat_lb) {
> +        hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
> +        numa_state->hmat_lb[node->hierarchy][node->data_type] =3D hmat_l=
b;
> +        hmat_lb->latency =3D g_array_new(false, true, sizeof(HMAT_LB_Dat=
a));
> +        hmat_lb->bandwidth =3D g_array_new(false, true, sizeof(HMAT_LB_D=
ata));
> +    }
> +    hmat_lb->hierarchy =3D node->hierarchy;
> +    hmat_lb->data_type =3D node->data_type;
> +    lb_data.initiator =3D node->initiator;
> +    lb_data.target =3D node->target;
> +
> +    /* Input latency data */
> +    if (node->data_type <=3D HMATLB_DATA_TYPE_WRITE_LATENCY) {
> +        if (!node->has_latency) {
> +            error_setg(errp, "Missing 'latency' option.");
> +            return;
> +        }
> +        if (node->has_bandwidth) {
> +            error_setg(errp, "Invalid option 'bandwidth' since "
> +                       "the data type is latency.");
> +            return;
> +        }
> +
> +        if (hmat_lb->base_latency =3D=3D 0) {
> +            hmat_lb->base_latency =3D UINT64_MAX;
> +        }
> +
> +        /* Calculate the temporary base and compressed latency */
> +        max_latency =3D node->latency;
> +        temp_base_la =3D 1;
> +        while (QEMU_IS_ALIGNED(max_latency, 10)) {
> +            max_latency /=3D 10;
> +            temp_base_la *=3D 10;
> +        }
> +
> +        /* Calculate the max compressed latency */
> +        hmat_lb->base_latency =3D MIN(hmat_lb->base_latency, temp_base_l=
a);
> +        max_latency =3D node->latency / hmat_lb->base_latency;
> +        hmat_lb->max_entry_la =3D MAX(hmat_lb->max_entry_la, max_latency=
);
> +
> +        if (hmat_lb->max_entry_la >=3D UINT16_MAX) {
> +            error_setg(errp, "Latency %" PRIu64 " between initiator=3D%d=
 and "
> +                       "target=3D%d should not differ from previously en=
tered "
> +                       "values on more than %d.", node->latency,
s/values/min/max values/

> +                       node->initiator, node->target, UINT16_MAX - 1);
> +            return;
> +        }
> +
> +        lb_data.rawdata =3D node->latency;
> +        g_array_append_val(hmat_lb->latency, lb_data);
> +    }
I'd use ... else if ... here and then below

> +
> +    /* Input bandwidth data */
> +    if (node->data_type >=3D HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
> +        if (!node->has_bandwidth) {
> +            error_setg(errp, "Missing 'bandwidth' option.");
> +            return;
> +        }
> +        if (node->has_latency) {
> +            error_setg(errp, "Invalid option 'latency' since "
> +                       "the data type is bandwidth.");
> +            return;
> +        }
> +        if (!QEMU_IS_ALIGNED(node->bandwidth, MiB)) {
> +            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=3D=
%d and "
> +                       "target=3D%d should be 1MB aligned.", node->bandw=
idth,
> +                       node->initiator, node->target);
> +            return;
> +        }
> +
> +        hmat_lb->range_bitmap_bw |=3D node->bandwidth;
> +
> +        first_bit =3D ctz64(hmat_lb->range_bitmap_bw);
> +        hmat_lb->base_bandwidth =3D UINT64_C(1) << first_bit;
> +        last_bit =3D 64 - clz64(hmat_lb->range_bitmap_bw);
> +        if ((last_bit - first_bit) > UINT16_BITS ||
> +            (MAKE_64BIT_MASK(first_bit, UINT16_BITS) =3D=3D node->bandwi=
dth)) {
> +            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=3D=
%d and "
> +                       "target=3D%d should not differ from previously en=
tered "
> +                       "values on more than %d.", node->bandwidth,
> +                       node->initiator, node->target, UINT16_MAX - 1);
> +            return;
> +        }
> +
> +        hmat_lb->base_bandwidth =3D UINT64_C(1) << first_bit;
> +        lb_data.rawdata =3D node->bandwidth;
> +        g_array_append_val(hmat_lb->bandwidth, lb_data);
> +    }
else {
   assert()
}


for each case we also should check that compressed into 16bits lb_data.rawd=
ata
value won't be 0xFFFF.

> +}
> +
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
>  {
>      Error *err =3D NULL;
> @@ -236,6 +359,19 @@ void set_numa_options(MachineState *ms, NumaOptions =
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
> +                       "before using any of hmat specific options.");
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
> index 788cbec7a2..36e1b4dece 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -14,6 +14,29 @@ struct CPUArchId;
>  #define NUMA_DISTANCE_MAX         254
>  #define NUMA_DISTANCE_UNREACHABLE 255
> =20
> +/* the value of AcpiHmatLBInfo flags */
> +enum {
> +    HMAT_LB_MEM_MEMORY           =3D 0,
> +    HMAT_LB_MEM_CACHE_1ST_LEVEL  =3D 1,
> +    HMAT_LB_MEM_CACHE_2ND_LEVEL  =3D 2,
> +    HMAT_LB_MEM_CACHE_3RD_LEVEL  =3D 3,
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
> +};
> +
> +#define UINT16_BITS       16
> +
> +#define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
> +#define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
such separate defines tend to become un-synced from enum definitions,
leading to out of bound access if enums are grown later.

one can use following trick

enum {
  ...,
  HMAT_LB_TYPES /* must be the last entry */
}


>  struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
> @@ -28,6 +51,46 @@ struct NumaNodeMem {
>      uint64_t node_plugged_mem;
>  };
> =20
> +struct HMAT_LB_Data {
> +    uint8_t     initiator;
> +    uint8_t     target;
> +    uint64_t    rawdata;
just 'data' is sufficient,
raw is confusing as it rises question what is non-raw data and there is no =
answer in this patch to it.

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
> +    /* The max compressed latency for calculating common latency base */
> +    uint64_t    max_entry_la;
> +
> +    /* The range bitmap of bandwidth for calculating common bandwidth ba=
se */
> +    uint64_t    range_bitmap_bw;
> +
> +    /* The common base unit for latencies */
> +    uint64_t    base_latency;
> +
> +    /* The common base unit for bandwidths */
> +    uint64_t    base_bandwidth;
> +
> +    /* Array to store the compressed latencies */
> +    uint16_t    *entry_latency;
> +
> +    /* Array to store the compressed latencies */
> +    uint16_t    *entry_bandwidth;
> +
> +    /* Array to store the latencies */
> +    GArray      *latency;
> +
> +    /* Array to store the bandwidthes */
> +    GArray      *bandwidth;
> +};
> +typedef struct HMAT_LB_Info HMAT_LB_Info;
> +
>  struct NumaState {
>      /* Number of NUMA nodes */
>      int num_nodes;
> @@ -40,11 +103,16 @@ struct NumaState {
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
> index 27d0e37534..da4d2c2cfc 100644
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
> +# For more information of @HmatLBMemoryHierarchy see
s/of/about/

> +# the chapter 5.2.27.4: Table 5-142: Field "Flags" of ACPI 6.3 spec.
> +#
> +# @memory: the structure represents the memory performance
> +#
> +# @first-level: first level memory of memory side cached memory
maybe it should say
  "first level of memory side cache"

and similar for other cache levels?

> +#
> +# @second-level: second level memory of memory side cached memory
> +#
> +# @third-level: third level memory of memory side cached memory
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
> +# For more information of @HmatLBDataType see
s/of/about/

> +# the chapter 5.2.27.4: Table 5-142:  Field "Data Type" of ACPI 6.3 spec=
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
> +# For more information of @NumaHmatLBOptions see
s/of/about/

> +# the chapter 5.2.27.4: Table 5-142 of ACPI 6.3 spec.
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
> index cb0417b736..ec4ec37010 100644
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
> +@var{lat} of 'latency' is latency value, the possible value and units ar=
e
> +NUM[ns|us|ms] (nanosecond|microsecond|millisecond), the recommended unit=
 is 'ns'.
> +@var{bw} is bandwidth value, the possible value and units are NUM[M|G|T]=
, mean that
> +the bandwidth value are NUM MB/s, GB/s or TB/s. Note that for @var{lat} =
and @var{bw}
NUM byte (or MB/s, GB/s or TB/s depending on used suffix)
> +max NUM is 65534, if NUM is 0, means the corresponding latency or bandwi=
dth information
not sure that 'max' statement is valid one
for once I can specify 65534M or equivalent suffix-less 68717379584
another thing is that range is a sliding window so there isn't a single max=
 value
it's rather multiple values, where 0xFFFF-1 is shifted left or right within=
 64bit range.

I'd drop statement about max value.

> +is not provided. And if input numbers without any unit, the latency unit=
 will be 'ns'
> +and the bandwidth will be MB/s.
should be B/s


> +For example, the following option assigns NUMA node 0 and 1. Node 0 has =
2 cpus and
s/option assigns NUMA node 0 and 1/options describe 2 NUMA nodes/

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


