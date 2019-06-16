Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A9C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357AB20657
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357AB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcbE4-0003jn-Fb
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 15:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcbCo-0002yZ-Cs
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcbCm-00005Z-TK
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:52:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcbCm-00004s-L8
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:52:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87C2E307D869;
 Sun, 16 Jun 2019 19:52:43 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC6F5C1B5;
 Sun, 16 Jun 2019 19:52:38 +0000 (UTC)
Date: Sun, 16 Jun 2019 21:52:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190616215234.685b8585@redhat.com>
In-Reply-To: <20190508061726.27631-10-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
 <20190508061726.27631-10-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sun, 16 Jun 2019 19:52:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 09/11] numa: Extend the command-line to
 provide memory side cache information
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 14:17:24 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
> 
> Add -numa hmat-cache option to provide Memory Side Cache Information.
> These memory attributes help to build Memory Side Cache Information
> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v4 -> v3:
>     - update the version tag from 4.0 to 4.1
> ---
>  numa.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json | 72 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 145 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 1aecb7a2e9..4866736fc8 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -300,6 +300,75 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>      }
>  }
>  
> +static
> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
> +                            Error **errp)
> +{
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
> +    HMAT_Cache_Info *hmat_cache = NULL;
> +
> +    if (node->node_id >= nb_numa_nodes) {
> +        error_setg(errp, "Invalid node-id=%" PRIu32
> +                   ", it should be less than %d.",
> +                   node->node_id, nb_numa_nodes);
> +        return;
> +    }
> +    if (!ms->numa_state->nodes[node->node_id].is_target) {
> +        error_setg(errp, "Invalid node-id=%" PRIu32
> +                   ", it isn't a target proximity domain.",
> +                   node->node_id);
> +        return;
> +    }
> +
> +    if (node->total > MAX_HMAT_CACHE_LEVEL) {
> +        error_setg(errp, "Invalid total=%" PRIu8
> +                   ", it should be less than or equal to %d.",
> +                   node->total, MAX_HMAT_CACHE_LEVEL);
> +        return;
> +    }
> +    if (node->level > node->total) {
> +        error_setg(errp, "Invalid level=%" PRIu8
> +                   ", it should be less than or equal to"
> +                   " total=%" PRIu8 ".",
> +                   node->level, node->total);
> +        return;
> +    }
> +    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
> +        error_setg(errp, "Duplicate configuration of the side cache for "
> +                   "node-id=%" PRIu32 " and level=%" PRIu8 ".",
> +                   node->node_id, node->level);
> +        return;
> +    }
> +
> +    if ((node->level > 1) &&
> +        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> +        (node->size >=
> +            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
> +        error_setg(errp, "Invalid size=0x%" PRIx64
> +                   ", the size of level=%" PRIu8
> +                   " should be less than the size(0x%" PRIx64
> +                   ") of level=%" PRIu8 ".",
> +                   node->size, node->level,
> +                   ms->numa_state->hmat_cache[node->node_id]
> +                                             [node->level - 1]->size,
> +                   node->level - 1);
> +        return;
> +    }
> +
> +    hmat_cache = g_malloc0(sizeof(*hmat_cache));
> +
> +    hmat_cache->mem_proximity = node->node_id;
> +    hmat_cache->size = node->size;
> +    hmat_cache->total_levels = node->total;
> +    hmat_cache->level = node->level;
> +    hmat_cache->associativity = node->assoc;
> +    hmat_cache->write_policy = node->policy;
> +    hmat_cache->line_size = node->line;
> +    hmat_cache->num_smbios_handles = 0;
> +
> +    ms->numa_state->hmat_cache[node->node_id][node->level] = hmat_cache;
> +}
> +
>  static
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>  {
> @@ -344,6 +413,12 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>              goto end;
>          }
>          break;
> +    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
> +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
> +        if (err) {
> +            goto end;
> +        }
> +        break;
>      default:
>          abort();
>      }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index d7fce75702..2b7e34b469 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2541,10 +2541,12 @@
>  #
>  # @hmat-lb: memory latency and bandwidth information (Since: 4.1)
>  #
> +# @hmat-cache: memory side cache information (Since: 4.1)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> +   'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
stray whitespace in front???


>  ##
>  # @NumaOptions:
> @@ -2560,7 +2562,8 @@
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
>      'cpu': 'NumaCpuOptions',
> -    'hmat-lb': 'NumaHmatLBOptions' }}
> +    'hmat-lb': 'NumaHmatLBOptions',
> +    'hmat-cache': 'NumaHmatCacheOptions' }}
>  
>  ##
>  # @NumaNodeOptions:
> @@ -2710,6 +2713,71 @@
>     '*latency': 'uint16',
>     '*bandwidth': 'uint16' }}
>  
> +##
> +# @HmatCacheAssociativity:
> +#
> +# Cache associativity in the Memory Side Cache
> +# Information Structure of HMAT
> +#
> +# @none: None
> +#
> +# @direct: Direct Mapped
> +#
> +# @complex: Complex Cache Indexing (implementation specific)
it would be good to add reference to spec, like we do for ACPI API functions.
So that reader would know where to look for values and their meaning.

PS:
It applies to all fields that come from spec (in this and previous patches that add QAPI structures)

> +#
> +# Since: 4.1
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
> +# @none: None
> +#
> +# @write-back: Write Back (WB)
> +#
> +# @write-through: Write Through (WT)
> +#
> +# Since: 4.1
> +##
> +{ 'enum': 'HmatCacheWritePolicy',
> +  'data': [ 'none', 'write-back', 'write-through' ] }
> +
> +##
> +# @NumaHmatCacheOptions:
> +#
> +# Set the memory side cache information for a given memory domain.
> +#
> +# @node-id: the memory proximity domain to which the memory belongs.
> +#
> +# @size: the size of memory side cache in bytes.
> +#
> +# @total: the total cache levels for this memory proximity domain.
> +#
> +# @level: the cache level described in this structure.
> +#
> +# @assoc: the cache associativity, none/direct-mapped/complex(complex cache indexing).
> +
> +# @policy: the write policy, none/write-back/write-through.
> +#
> +# @line: the cache Line size in bytes.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'NumaHmatCacheOptions',
> +  'data': {
> +   'node-id': 'uint32',
> +   'size': 'size',
> +   'total': 'uint8',
> +   'level': 'uint8',
> +   'assoc': 'HmatCacheAssociativity',
> +   'policy': 'HmatCacheWritePolicy',
> +   'line': 'uint16' }}
> +
>  ##
>  # @HostMemPolicy:
>  #


