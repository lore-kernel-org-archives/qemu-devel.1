Received: from eggs.gnu.org ([2001:4830:134:3::10]:35720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFn8M-0002jy-KM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFn8L-0008VX-EZ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:48:50 -0400
Date: Tue, 30 May 2017 16:48:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530194838.GQ32274@thinpad.lan.raisama.net>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] numa: code consolidation and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, May 30, 2017 at 06:23:55PM +0200, Igor Mammedov wrote:
> changelog since v2:
>   (Eduardo)
>      - keep original logic in when moving numa part into helper
>         numa: consolidate cpu_preplug fixups/checks for pc/arm/spapr
>      - drop "numa: fallback to default NUMA node instead of node 0"
>      - split out monitor hunk into separate patch
>      - split out spapr_fixup_cpu_numa_dt refactoring into separate patch
>      - add extra patch to make default node-id calculation more robust
> changelog since v1:
>   (Eduardo)
>      - user error_abort in numa_cpu_pre_plug()
>      - make default_mapping boolean
>      - redo default mapping detection loop as a combo of for/if
>      - return back lost TODO comment
>      - new patch removing numa_node from generic CPUState
>   - drop silence test patch as it's already in pull req on list
>   - new patch [3/5] to fix missing _PXM/fdt nodes for implicitly mapped CPUs
>   - new patch dropping fallback to node 0
> 
> 
> git repo for testing:
>    https://github.com/imammedo/qemu.git cphp_numa_cfg_follow_up_v3_cleanups_v3
> 
> CC: qemu-arm@nongnu.org
> CC: qemu-ppc@nongnu.org
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Andrew Jones <drjones@redhat.com>
> 
> 
> Igor Mammedov (7):
>   numa: consolidate cpu_preplug fixups/checks for pc/arm/spapr
>   numa: move default mapping init to machine
>   numa: make sure that all cpus have has_node_id set if numa is enabled
>   numa: make hmp 'info numa' fetch numa nodes from qmp_query_cpus()
>     result
>   numa: move numa_node from CPUState into target specific classes
>   spapr: cleanup spapr_fixup_cpu_numa_dt() usage
>   numa: cpu: calculate/set default node-ids after all -numa CLI options
>     are parsed

Patches 1-6 queued on numa-next.  Thanks.

-- 
Eduardo
