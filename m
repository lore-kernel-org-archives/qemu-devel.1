Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD30C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 03:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F351721929
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 03:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F351721929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIldx-0000N7-4V
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 23:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIlcy-0008JY-5v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 23:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIlct-0000FB-Sf
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 23:30:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIlct-0000Da-Ib
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 23:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6B77307D88C;
 Fri, 11 Oct 2019 03:29:57 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A09CF5D717;
 Fri, 11 Oct 2019 03:29:54 +0000 (UTC)
Date: Fri, 11 Oct 2019 00:29:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 07/16] hw/386: Add new epyc mode
 topology decoding functions
Message-ID: <20191011032953.GD29387@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779714362.21957.2682347975717100335.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156779714362.21957.2682347975717100335.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 11 Oct 2019 03:29:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ssg.sos.staff" <ssg.sos.staff@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 07:12:25PM +0000, Moger, Babu wrote:
> These functions add support for building new epyc mode topology
> given smp details like numa nodes, cores, threads and sockets.
> Subsequent patches will use these functions to build the topology.
>=20
> The topology details are available in Processor Programming Reference (=
PPR)
> for AMD Family 17h Model 01h, Revision B1 Processors.
> It is available at https://www.amd.com/en/support/tech-docs
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/topology.h |  174 ++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 174 insertions(+)
>=20
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 5a61d53f05..6fd4184f07 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -62,6 +62,22 @@ typedef struct X86CPUTopoInfo {
>      unsigned nr_threads;
>  } X86CPUTopoInfo;
> =20
> +/*
> + * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
> + * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual =
Volume 3.
> + * Define the constants to build the cpu topology. Right now, TOPOEXT
> + * feature is enabled only on EPYC. So, these constants are based on
> + * EPYC supported configurations. We may need to handle the cases if
> + * these values change in future.
> + */
> +
> +/* Maximum core complexes in a node */
> +#define MAX_CCX                  2

I suggest a more explicit name like MAX_CCX_IN_NODE.

> +/* Maximum cores in a core complex */
> +#define MAX_CORES_IN_CCX         4
> +/* Maximum cores in a node */
> +#define MAX_CORES_IN_NODE        8
> +

Having limits isn't necessarily bad, but if we look at the code
that use those constants below:

[...]
> +/*
> + * Figure out the number of nodes required to build this config.
> + * Max cores in a nodes is 8
> + */
> +static inline int nodes_in_pkg(X86CPUTopoInfo *topo_info)
> +{
> +    /*
> +     * Create a config with user given (nr_nodes > 1) numa node config=
,
> +     * else go with a standard configuration
> +     */
> +    if (topo_info->numa_nodes > 1) {
> +        return DIV_ROUND_UP(topo_info->numa_nodes, topo_info->nr_socke=
ts);
> +    } else {
> +        return DIV_ROUND_UP(topo_info->nr_cores, MAX_CORES_IN_NODE);
> +    }
> +}

Here we are trying to choose a default value for the number of
nodes, but it's better to let the CPU or machine code choose it.
Otherwise, this will be very painful to maintain if new CPUs with
different limits appear.  I would just let the number of nodes
per package to be configurable in the command-line.

> +
> +/*
> + * Decide the number of cores in a core complex with the given nr_core=
s using
> + * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_DIE=
 and
> + * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
> + * L3 cache is shared across all cores in a core complex. So, this wil=
l also
> + * tell us how many cores are sharing the L3 cache.
> + */
> +static inline int cores_in_ccx(X86CPUTopoInfo *topo_info)
> +{
> +    int nodes;
> +
> +    /* Get the number of nodes required to build this config */
> +    nodes =3D nodes_in_pkg(topo_info);
> +
> +    /*
> +     * Divide the cores accros all the core complexes
> +     * Return rounded up value
> +     */
> +    return DIV_ROUND_UP(topo_info->nr_cores, nodes * MAX_CCX);
> +}

Same here.  This will become painful to maintain if CPUs with a
different CCX-per-node limit appear.  I suggest just letting the
number of cores per CCX to be configurable in the command-line.
The "cores" option is already defined as "cores per die" when
nr_dies > 1.  We can easily define it to mean "cores per CCX"
when nr_ccxs > 1.

If you still want to impose limits to some of those parameters, I
suggest placing those limits in the CPU model table, not in
global constants.


> +
> +/*
> + * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> + *
> + * The caller must make sure core_id < nr_cores and smt_id < nr_thread=
s.
> + */
> +static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *=
topo_info,
> +                                                  const X86CPUTopoIDs =
*topo_ids)
> +{
> +    unsigned nr_ccxs =3D MAX_CCX;

I suggest adding nr_ccxs to X86CPUTopoInfo, instead of making it
fixed.

> +    unsigned nr_nodes =3D nodes_in_pkg(topo_info);

Same here: isn't it better to have a nr_nodes_per_pkg field in
X86CPUTopoInfo, and make it configurable in the command-line?

> +    unsigned nr_cores =3D MAX_CORES_IN_CCX;

nr_cores is already in X86CPUTopoInfo, why aren't you using it?

Similar questions at x86_topo_ids_from_apicid_epyc() [1].

> +    unsigned nr_threads =3D topo_info->nr_threads;
> +
> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(nr_nodes, nr_c=
cxs,
> +                                                        nr_cores, nr_t=
hreads)) |
> +           (topo_ids->node_id  << apicid_node_offset(nr_ccxs, nr_cores=
,
> +                                                     nr_threads)) |
> +           (topo_ids->ccx_id  << apicid_ccx_offset(nr_cores, nr_thread=
s)) |
> +           (topo_ids->core_id << apicid_core_offset(nr_threads)) |
> +           topo_ids->smt_id;
> +}
> +
> +static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_inf=
o,
> +                                              unsigned cpu_index,
> +                                              X86CPUTopoIDs *topo_ids)
> +{
> +    unsigned nr_cores =3D topo_info->nr_cores;

Is nr_cores cores-per-ccx?  cores-per-node?  cores-per-pkg?


> +    unsigned nr_threads =3D topo_info->nr_threads;
> +    unsigned core_index =3D cpu_index / nr_threads % nr_cores;

It's hard to understand what this variable means.  Is it a unique
identifier for a core inside the whole system?  Is it unique
inside a package?  Unique inside a node?  Unique inside a ccx?


> +    unsigned ccx_cores =3D cores_in_ccx(topo_info);
> +
> +    topo_ids->smt_id =3D cpu_index % nr_threads;
> +    topo_ids->core_id =3D core_index % ccx_cores; /* core id inside th=
e ccx */
> +    topo_ids->ccx_id =3D (core_index % (ccx_cores * MAX_CCX)) / ccx_co=
res;
> +    topo_ids->node_id =3D core_index / (ccx_cores * MAX_CCX);

It looks like we have one extra constraint we must ensure
elsewhere in the code: we need to make sure the node topology in
topo->node_id matches the node topology defined using -numa,
don't we?


> +    topo_ids->pkg_id =3D cpu_index / (nr_cores * nr_threads);

Now, these calculations are over my head.  It's hard to
understand what "nr_cores" mean, or what "ccx_cores * MAX_CCX" is
calculating.

I will try to compare with the existing x86_topo_ids_from_idx()
function, to see if we can make the hierarchy clearer:

Existing code is:

    topo->pkg_id =3D cpu_index / (nr_dies * nr_cores * nr_threads);
    topo->die_id =3D cpu_index / (nr_cores * nr_threads) % nr_dies;
    topo->core_id =3D cpu_index / nr_threads % nr_cores;
    topo->smt_id =3D cpu_index % nr_threads;

The code is hierarchical, but not 100% clear.  Let's try to make
it clearer:

    unsigned threads_per_core =3D topo->nr_threads;
    unsigned   cores_per_die  =3D topo->nr_cores;
    unsigned    dies_per_pkg  =3D topo->nr_dies;

    unsigned threads_per_die  =3D threads_per_core * cores_per_die;
    unsigned threads_per_pkg  =3D threads_per_die  *  dies_per_pkg;

    unsigned thread_index =3D cpu_index;
    unsigned   core_index =3D cpu_index / threads_per_core;
    unsigned    die_index =3D cpu_index / threads_per_die;
    unsigned    pkg_index =3D cpu_index / threads_per_pkg;

    topo-> smt_id =3D thread_index % threads_per_core;
    topo->core_id =3D   core_index %   cores_per_die;
    topo-> die_id =3D    die_index %    dies_per_pkg;
    topo-> pkg_id =3D    pkg_index;

The logic above should be equivalent to the existing
x86_topo_ids_from_idx() function.

Can we make it better for the smt/core/ccx/node/pkg case too?
Let's try:

    unsigned threads_per_core =3D topo->nr_threads;
    unsigned   cores_per_ccx  =3D topo->nr_cores;
    unsigned    ccxs_per_node =3D topo->nr_ccxs;
    unsigned   nodes_per_pkg  =3D topo->nodes_per_pkg;

    unsigned threads_per_ccx  =3D threads_per_core * cores_per_ccx;
    unsigned threads_per_node =3D threads_per_ccx  *  ccxs_per_node;
    unsigned threads_per_pkg  =3D threads_per_node * nodes_per_pkg;

    unsigned thread_index =3D cpu_index;
    unsigned   core_index =3D cpu_index / threads_per_core;
    unsigned    ccx_index =3D cpu_index / threads_per_ccx;
    unsigned   node_index =3D cpu_index / threads_per_node;
    unsigned    pkg_index =3D cpu_index / threads_per_pkg;

    topo-> smt_id =3D thread_index % threads_per_core;
    topo->core_id =3D   core_index %   cores_per_ccx;
    topo-> ccx_id =3D    ccx_index %    ccxs_per_node;
    topo->node_id =3D   node_index %   nodes_per_pkg;
    topo-> pkg_id =3D    pkg_index;

The logic above probably isn't equivalent to the code you wrote.
The point here is that each variable is very clearly defined with
a "per_*" suffix to avoid confusion, and all parameters are
coming from X86CPUTopoInfo.

> +}
> +
> +/*
> + * Calculate thread/core/package IDs for a specific topology,
> + * based on APIC ID
> + */
> +static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
> +                                            X86CPUTopoInfo *topo_info,
> +                                            X86CPUTopoIDs *topo_ids)
> +{
> +    unsigned nr_nodes =3D nodes_in_pkg(topo_info);
> +    unsigned nr_cores =3D MAX_CORES_IN_CCX;
> +    unsigned nr_threads =3D topo_info->nr_threads;
> +    unsigned nr_ccxs =3D MAX_CCX;

Same questions as in x86_apicid_from_topo_ids_epyc() [1]:
shouldn't nr_cores, nr_ccxs and nr_nodes come from
X86CPUTopoInfo?

> +
> +    topo_ids->smt_id =3D apicid &
> +                   ~(0xFFFFFFFFUL << apicid_smt_width(nr_threads));
> +
> +    topo_ids->core_id =3D (apicid >> apicid_core_offset(nr_threads)) &
> +                   ~(0xFFFFFFFFUL << apicid_core_width(nr_cores));
> +
> +    topo_ids->ccx_id =3D (apicid >> apicid_ccx_offset(nr_cores, nr_thr=
eads)) &
> +                   ~(0xFFFFFFFFUL << apicid_ccx_width(nr_ccxs));
> +
> +    topo_ids->node_id =3D (apicid >> apicid_node_offset(nr_ccxs, nr_co=
res,
> +                                                      nr_threads)) &
> +                   ~(0xFFFFFFFFUL << apicid_node_width(nr_nodes));
> +
> +    topo_ids->pkg_id =3D apicid >> apicid_pkg_offset_epyc(nr_nodes, nr=
_ccxs,
> +                                                        nr_cores, nr_t=
hreads);
> +}
> +
> +/*
> + * Make APIC ID for the CPU 'cpu_index'
> + *
> + * 'cpu_index' is a sequential, contiguous ID for the CPU.
> + */
> +static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *t=
opo_info,
> +                                                     unsigned cpu_inde=
x)
> +{
> +    X86CPUTopoIDs topo_ids;
> +    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> +    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
> +}

If we make nodes_per_pkg=3D=3D1 by default, treat nr_ccxs and nr_dies
as synonyms, and make all parameters come from X86CPUTopoInfo,
can't we reuse exactly the same topology code for both EPYC and
non-EPYC?  It would be better than having two separate sets of
functions.

I have one additional request: please add unit tests for the
functions above to test-x86-cpuid.c.  There may be opportunities
for refactoring this code later, and unit tests will be important
to make sure we don't break anything.

> +
>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_thread=
s.
>=20

--=20
Eduardo

