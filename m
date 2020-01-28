Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9FEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E2E2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObuXBYwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E2E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwX7G-00058g-7O
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iwX6W-0004Py-6D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iwX6U-0000nt-8P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:04:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iwX6U-0000nS-2B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580241892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7bCFxvNKqGWZaRmzy6i1/yeza7khpgZ2XyWUi53CFM=;
 b=ObuXBYwt3UOI9Ek0oASdcCEFn3xYBVgamzM7yK38xiYvrORLKxvwUtg/GHAt87UQAF9nTo
 NKFF8eXJ79PYJIenLxArR0J5mtOA0MsnipUHEP9N/KUtqYB1jARv4iDMnTiaoG/8hGN9kS
 U0cxu3EBspk3l79Yd0eJGX9oT2o2wlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-nSDy3yMcPoy7rv2ofSE-rg-1; Tue, 28 Jan 2020 15:04:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0F81137865;
 Tue, 28 Jan 2020 20:04:42 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8918119E9C;
 Tue, 28 Jan 2020 20:04:39 +0000 (UTC)
Date: Tue, 28 Jan 2020 15:04:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 16/18] hw/i386: Introduce EPYC mode function handlers
Message-ID: <20200128200438.GJ18770@habkost.net>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541992659.46157.18191224973398213624.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <157541992659.46157.18191224973398213624.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nSDy3yMcPoy7rv2ofSE-rg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry for taking so long.  I was away from the office for a
month, and now I'm finally back.

On Tue, Dec 03, 2019 at 06:38:46PM -0600, Babu Moger wrote:
> Introduce following handlers for new epyc mode.
> x86_apicid_from_cpu_idx_epyc: Generate apicid from cpu index.
> x86_topo_ids_from_apicid_epyc: Generate topo ids from apic id.
> x86_apicid_from_topo_ids_epyc: Generate apicid from topo ids.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c               |   12 ++++++++++++
>  include/hw/i386/topology.h |    4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e6c8a458e7..64e3658873 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2819,6 +2819,17 @@ static bool pc_hotplug_allowed(MachineState *ms, D=
eviceState *dev, Error **errp)
>      return true;
>  }
> =20
> +static void pc_init_apicid_fn(MachineState *ms)
> +{
> +    PCMachineState *pcms =3D PC_MACHINE(ms);
> +
> +    if (!strncmp(ms->cpu_type, "EPYC", 4)) {

Please never use string comparison to introduce device-specific
behavior.  I had already pointed this out at
https://lore.kernel.org/qemu-devel/20190801192830.GD20035@habkost.net/

If you need a CPU model to provide special behavior,
you have two options:

* Add a method pointer to X86CPUClass and/or X86CPUDefinition
* Add a QOM property to enable/disable special behavior, and
  include the property in the CPU model definition.

The second option might be preferable long term, but might
require more work because the property would become visible in
query-cpu-model-expansion and in the command line.  The first
option may be acceptable to avoid extra user-visible complexity
in the first version.



> +        pcms->apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx_epyc;
> +        pcms->topo_ids_from_apicid =3D x86_topo_ids_from_apicid_epyc;
> +        pcms->apicid_from_topo_ids =3D x86_apicid_from_topo_ids_epyc;

Why do you need to override the function pointers in
PCMachineState instead of just looking up the relevant info at
X86CPUClass?

If both machine-types and CPU models are supposed to override the
APIC ID calculation functions, the interaction between
machine-type and CPU model needs to be better documented
(preferably with simple test cases) to ensure we won't break
compatibility later.

> +    }
> +}
> +
>  static void pc_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -2847,6 +2858,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
>      mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
> +    mc->init_apicid_fn =3D pc_init_apicid_fn;
>      mc->auto_enable_numa_with_memhp =3D true;
>      mc->has_hotpluggable_cpus =3D true;
>      mc->default_boot_order =3D "cad";
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index b2b9e93a06..f028d2332a 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -140,7 +140,7 @@ static inline unsigned apicid_pkg_offset_epyc(X86CPUT=
opoInfo *topo_info)
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>   */
> -static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_i=
nfo,
> +static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *to=
po_info,
>                                                    const X86CPUTopoIDs *t=
opo_ids)
>  {
>      return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> @@ -200,7 +200,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx_epyc(=
X86CPUTopoInfo *topo_info,
>  {
>      X86CPUTopoIDs topo_ids;
>      x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> -    return apicid_from_topo_ids_epyc(topo_info, &topo_ids);
> +    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
>  }
>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>   *
>=20
>=20

--=20
Eduardo


