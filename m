Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF9C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919C621848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECamR/ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919C621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4Sg-0005pE-Oy
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iT4Pg-0004F1-Q2
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iT4Pe-0004NQ-Ql
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:34:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iT4Pe-0004N3-LX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573220092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6H1bXF77Y1RJevxvaQffO445fxUCa+pnK4eNcQEb5wA=;
 b=ECamR/oxuJqapVtgVQzzWyEcLj30zhry27cFI9jBaRi4AS4JkP07LB+noAhVACV01PIrwq
 ktga4j9NwLU7yfFu+aBQvtmlxsVT9AR4+wTcm4xgA56advLTePWMAjmCLv74ARFVpEtwjG
 NPx+H+SGnR9EUllSl9kd7ShhaZQE89k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-zMWt1RCgNVOdoXh95y7e9Q-1; Fri, 08 Nov 2019 08:34:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881661005502;
 Fri,  8 Nov 2019 13:34:49 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38B2D60856;
 Fri,  8 Nov 2019 13:34:44 +0000 (UTC)
Date: Fri, 8 Nov 2019 14:34:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 08/12] numa: Extend CLI to provide memory side cache
 information
Message-ID: <20191108143442.5c4a6cae@redhat.com>
In-Reply-To: <20191107074511.14304-9-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-9-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zMWt1RCgNVOdoXh95y7e9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 mdroth@linux.vnet.ibm.com, Daniel Black <daniel@linux.ibm.com>,
 armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  7 Nov 2019 15:45:07 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> Add -numa hmat-cache option to provide Memory Side Cache Information.
> These memory attributes help to build Memory Side Cache Information
> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
>=20
> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v15:
>     - Change the QAPI version tag to 5.0 (Eric)
>=20
> No changes in v14.
>=20
> Changes in v13:
>     - Drop the total_levels option.
>     - Use readable cache size (Igor)
> ---
>  hw/core/numa.c        | 66 ++++++++++++++++++++++++++++++++++++
>  include/sysemu/numa.h | 31 +++++++++++++++++
>  qapi/machine.json     | 78 +++++++++++++++++++++++++++++++++++++++++--
>  qemu-options.hx       | 16 +++++++--
>  4 files changed, 187 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 523dd80822..165b38d74b 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -321,6 +321,59 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaH=
matLBOptions *node,
>      }
>  }
> =20
> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> +                           Error **errp)
> +{
> +    int nb_numa_nodes =3D ms->numa_state->num_nodes;
> +    HMAT_Cache_Info *hmat_cache =3D NULL;
> +
> +    if (node->node_id >=3D nb_numa_nodes) {
> +        error_setg(errp, "Invalid node-id=3D%" PRIu32
> +                   ", it should be less than %d.",
> +                   node->node_id, nb_numa_nodes);
> +        return;
> +    }
> +
> +    if (node->level > MAX_HMAT_CACHE_LEVEL) {
> +        error_setg(errp, "Invalid level=3D%" PRIu8
> +                   ", it should be less than or equal to %d.",
> +                   node->level, MAX_HMAT_CACHE_LEVEL);
> +        return;
> +    }
> +    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
> +        error_setg(errp, "Duplicate configuration of the side cache for =
"
> +                   "node-id=3D%" PRIu32 " and level=3D%" PRIu8 ".",
> +                   node->node_id, node->level);
> +        return;
> +    }
> +
> +    if ((node->level > 1) &&
> +        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> +        (node->size >=3D
> +            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->=
size)) {
> +        error_setg(errp, "Invalid size=3D0x%" PRIx64
> +                   ", the size of level=3D%" PRIu8
> +                   " should be less than the size(0x%" PRIx64
> +                   ") of level=3D%" PRIu8 ".",
> +                   node->size, node->level,
> +                   ms->numa_state->hmat_cache[node->node_id]
> +                                             [node->level - 1]->size,
> +                   node->level - 1);
> +        return;
> +    }
> +
> +    hmat_cache =3D g_malloc0(sizeof(*hmat_cache));
> +
> +    hmat_cache->proximity =3D node->node_id;
> +    hmat_cache->size =3D node->size;
> +    hmat_cache->level =3D node->level;
> +    hmat_cache->associativity =3D node->assoc;
> +    hmat_cache->write_policy =3D node->policy;
> +    hmat_cache->line_size =3D node->line;
> +
> +    ms->numa_state->hmat_cache[node->node_id][node->level] =3D hmat_cach=
e;
> +}
>=20
looking at spec we need a cross check hmat_lb data.
 * Id could be done at numa_complete_configuration() time
 * or force user to enter hmat-cache only after all hmat-lb were specified
   and check against current state of hmat_lb.
   It later practically means error out on any hmat-lb option if at least
   one hmat-cache option has been processed.


at the end of ACPI6.3: 5.2.27.5
"
If the Memory Side Cache Information
Structure is present, the System Locality Latency and Bandwidth Information=
 Structure shall contain
latency and bandwidth information for each memory side cache level.
"

>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
>  {
>      Error *err =3D NULL;
> @@ -372,6 +425,19 @@ void set_numa_options(MachineState *ms, NumaOptions =
*object, Error **errp)
>              goto end;
>          }
>          break;
> +    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
> +        if (!ms->numa_state->hmat_enabled) {
> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table =
"
> +                       "(HMAT) is disabled, enable it with -machine hmat=
=3Don "
> +                       "before using any of hmat specific options.");
> +            return;
> +        }
> +
> +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
> +        if (err) {
> +            goto end;
> +        }
> +        break;
>      default:
>          abort();
>      }
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 36e1b4dece..50554709e7 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -37,6 +37,8 @@ enum {
>  #define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
>  #define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
> =20
> +#define MAX_HMAT_CACHE_LEVEL    HMAT_LB_MEM_CACHE_3RD_LEVEL
> +
>  struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
> @@ -91,6 +93,30 @@ struct HMAT_LB_Info {
>  };
>  typedef struct HMAT_LB_Info HMAT_LB_Info;
> =20
> +struct HMAT_Cache_Info {
> +    /* The memory proximity domain to which the memory belongs. */
> +    uint32_t    proximity;
> +
> +    /* Size of memory side cache in bytes. */
> +    uint64_t    size;
> +

> +    /* Total cache levels for this memory proximity domain. */
> +    uint8_t     total_levels;
this isn't used anymore and without it you do not need custom structure as
QAPI already generates exactly this type for you
  "struct NumaHmatCacheOptions"


> +
> +    /* Cache level described in this structure. */
> +    uint8_t     level;
> +
> +    /* Cache Associativity: None/Direct Mapped/Comple Cache Indexing */
> +    uint8_t     associativity;
> +
> +    /* Write Policy: None/Write Back(WB)/Write Through(WT) */
> +    uint8_t     write_policy;
> +
> +    /* Cache Line size in bytes. */
> +    uint16_t    line_size;
> +};
> +typedef struct HMAT_Cache_Info HMAT_Cache_Info;
> +
>  struct NumaState {
>      /* Number of NUMA nodes */
>      int num_nodes;
> @@ -106,6 +132,9 @@ struct NumaState {
> =20
>      /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
>      HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
> +
> +    /* Memory Side Cache Information Structure */
> +    HMAT_Cache_Info *hmat_cache[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
>  };
>  typedef struct NumaState NumaState;
> =20
> @@ -113,6 +142,8 @@ void set_numa_options(MachineState *ms, NumaOptions *=
object, Error **errp);
>  void parse_numa_opts(MachineState *ms);
>  void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
>                          Error **errp);
> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> +                           Error **errp);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
>  extern QemuOptsList qemu_numa_opts;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index da4d2c2cfc..ce1f8e7dab 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -428,10 +428,12 @@
>  #
>  # @hmat-lb: memory latency and bandwidth information (Since: 5.0)
>  #
> +# @hmat-cache: memory side cache information (Since: 5.0)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
> =20
>  ##
>  # @NumaOptions:
> @@ -447,7 +449,8 @@
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
>      'cpu': 'NumaCpuOptions',
> -    'hmat-lb': 'NumaHmatLBOptions' }}
> +    'hmat-lb': 'NumaHmatLBOptions',
> +    'hmat-cache': 'NumaHmatCacheOptions' }}
> =20
>  ##
>  # @NumaNodeOptions:
> @@ -647,6 +650,77 @@
>      '*latency': 'time',
>      '*bandwidth': 'size' }}
> =20
> +##
> +# @HmatCacheAssociativity:
> +#
> +# Cache associativity in the Memory Side Cache
> +# Information Structure of HMAT
> +#
> +# For more information of @HmatCacheAssociativity see
> +# the chapter 5.2.27.5: Table 5-143 of ACPI 6.3 spec.
> +#
> +# @none: None
> +#
> +# @direct: Direct Mapped
> +#
> +# @complex: Complex Cache Indexing (implementation specific)
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatCacheAssociativity',
> +  'data': [ 'none', 'direct', 'complex' ] }
> +
> +##
> +# @HmatCacheWritePolicy:
> +#
> +# Cache write policy in the Memory Side Cache
> +# Information Structure of HMAT
> +#
> +# For more information of @HmatCacheWritePolicy see
> +# the chapter 5.2.27.5: Table 5-143: Field "Cache Attributes" of ACPI 6.=
3 spec.
> +#
> +# @none: None
> +#
> +# @write-back: Write Back (WB)
> +#
> +# @write-through: Write Through (WT)
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'HmatCacheWritePolicy',
> +  'data': [ 'none', 'write-back', 'write-through' ] }
> +
> +##
> +# @NumaHmatCacheOptions:
> +#
> +# Set the memory side cache information for a given memory domain.
> +#
> +# For more information of @NumaHmatCacheOptions see
> +# the chapter 5.2.27.5: Table 5-143: Field "Cache Attributes" of ACPI 6.=
3 spec.

here and above referenced spec Table should be 5-147

> +#
> +# @node-id: the memory proximity domain to which the memory belongs.
> +#
> +# @size: the size of memory side cache in bytes.
> +#
> +# @level: the cache level described in this structure.
> +#
> +# @assoc: the cache associativity, none/direct-mapped/complex(complex ca=
che indexing).
> +#
> +# @policy: the write policy, none/write-back/write-through.
> +#
> +# @line: the cache Line size in bytes.
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'NumaHmatCacheOptions',
> +  'data': {
> +   'node-id': 'uint32',
> +   'size': 'size',
> +   'level': 'uint8',
> +   'assoc': 'HmatCacheAssociativity',
> +   'policy': 'HmatCacheWritePolicy',
> +   'line': 'uint16' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ec4ec37010..600cc5e656 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -169,7 +169,8 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
>      "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
> -    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",
> +    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n"
> +    "-numa hmat-cache,node-id=3Dnode,size=3Dsize,level=3Dlevel[,assoc=3D=
none|direct|complex][,policy=3Dnone|write-back|write-through][,line=3Dsize]=
\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
> @@ -177,6 +178,7 @@ STEXI
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
>  @itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarch=
y=3D@var{hierarchy},data-type=3D@var{tpye}[,latency=3D@var{lat}][,bandwidth=
=3D@var{bw}]
> +@itemx -numa hmat-cache,node-id=3D@var{node},size=3D@var{size},level=3D@=
var{level}[,assoc=3D@var{str}][,policy=3D@var{str}][,line=3D@var{size}]
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> @@ -282,11 +284,19 @@ max NUM is 65534, if NUM is 0, means the correspond=
ing latency or bandwidth info
>  is not provided. And if input numbers without any unit, the latency unit=
 will be 'ns'
>  and the bandwidth will be MB/s.
> =20
> +In @samp{hmat-cache} option, @var{node-id} is the NUMA-id of the memory =
belongs.
> +@var{size} is the size of memory side cache in bytes. @var{level} is the=
 cache
> +level described in this structure. @var{assoc} is the cache associativit=
y,
> +the possible value is 'none/direct(direct-mapped)/complex(complex cache =
indexing)'.
> +@var{policy} is the write policy. @var{line} is the cache Line size in b=
ytes.
> +
>  For example, the following option assigns NUMA node 0 and 1. Node 0 has =
2 cpus and
>  a ram, node 1 has only a ram. The processors in node 0 access memory in =
node
>  0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
>  The processors in NUMA node 0 access memory in NUMA node 1 with access-l=
atency 10
>  nanoseconds, access-bandwidth is 100 MB/s.
> +And for memory side cache information, NUMA node 0 and 1 both have 1 lev=
el memory
> +cache, size is 10KB, policy is write-back, the cache Line size is 8 byte=
s:
>  @example
>  -machine hmat=3Don \
>  -m 2G \
> @@ -300,7 +310,9 @@ nanoseconds, access-bandwidth is 100 MB/s.
>  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D5ns \
>  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D200M \
>  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D10ns \
> --numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M \
> +-numa hmat-cache,node-id=3D0,size=3D10K,level=3D1,assoc=3Ddirect,policy=
=3Dwrite-back,line=3D8 \
> +-numa hmat-cache,node-id=3D1,size=3D10K,level=3D1,assoc=3Ddirect,policy=
=3Dwrite-back,line=3D8
>  @end example
> =20
>  ETEXI


