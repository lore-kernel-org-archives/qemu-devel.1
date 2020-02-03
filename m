Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA88C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84FE2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTsJhItL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84FE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydVe-0002IH-0M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iydUX-0001ea-5L
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iydUV-0000N8-H6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:18:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iydUV-0000MB-BL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580743101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fr1qo0tcKlU0XkMFTfSUDUM4OoABRenZmWRLVTdXpos=;
 b=XTsJhItL+OHz7beIIadSCvz05HeYA0WIOMPlC1r+TMfASYePGGlAY3bBy2g2dhrnbwnTnb
 AEyJLt/Rw3nH3LpAtso1hH7GCKwLfFT1rXfwf8F1E0ATbTrB/Qo+Fi0Awo/6aXUFNKIPOX
 pUQCFya3emE8FX7RnMU4EM8Dfp2QnG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-jOP7rcctNvOIOH3rPdc0mg-1; Mon, 03 Feb 2020 10:18:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7655108839E;
 Mon,  3 Feb 2020 15:18:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A19C290F5D;
 Mon,  3 Feb 2020 15:17:59 +0000 (UTC)
Date: Mon, 3 Feb 2020 16:17:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
Message-ID: <20200203161758.3eb85046@redhat.com>
In-Reply-To: <b75928ec-c062-7edf-bc24-8dc0ccd7439b@amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
 <b75928ec-c062-7edf-bc24-8dc0ccd7439b@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jOP7rcctNvOIOH3rPdc0mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 10:17:11 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 1/29/20 3:14 AM, Igor Mammedov wrote:
> > On Tue, 28 Jan 2020 13:45:31 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> >> On 1/28/20 10:29 AM, Igor Mammedov wrote: =20
> >>> On Tue, 03 Dec 2019 18:37:42 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>    =20
> >>>> Add a new function init_apicid_fn in MachineClass to initialize the =
mode
> >>>> specific handlers to decode the apic ids.
> >>>>
> >>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>>> ---
> >>>>  include/hw/boards.h |    1 +
> >>>>  vl.c                |    3 +++
> >>>>  2 files changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >>>> index d4fab218e6..ce5aa365cb 100644
> >>>> --- a/include/hw/boards.h
> >>>> +++ b/include/hw/boards.h
> >>>> @@ -238,6 +238,7 @@ struct MachineClass {
> >>>>                                                           unsigned c=
pu_index);
> >>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *mac=
hine);
> >>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int =
idx);
> >>>> +    void (*init_apicid_fn)(MachineState *ms);   =20
> >>> it's x86 specific, so why it wasn put into PCMachineClass?   =20
> >>
> >> Yes. It is x86 specific for now. I tried to make it generic function s=
o
> >> other OSes can use it if required(like we have done in
> >> possible_cpu_arch_ids). It initializes functions required to build the
> >> apicid for each CPUs. We need these functions much early in the
> >> initialization. It should be initialized before parse_numa_opts or
> >> machine_run_board_init(in v1.c) which are called from generic context.=
 We
> >> cannot use PCMachineClass at this time. =20
> >=20
> > could you point to specific patches in this series that require
> > apic ids being initialized before parse_numa_opts and elaborate why?
> >=20
> > we already have possible_cpu_arch_ids() which could be called very
> > early and calculates APIC IDs in x86 case, so why not reuse it? =20
>=20
>=20
> The current code(before this series) parses the numa information and then
> sequentially builds the apicid. Both are done together.
>=20
> But this series separates the numa parsing and apicid generation. Numa
> parsing is done first and after that the apicid is generated. Reason is w=
e
> need to know the number of numa nodes in advance to decode the apicid.
>=20
> Look at this patch.
> https://lore.kernel.org/qemu-devel/157541988471.46157.6587693720990965800=
.stgit@naples-babu.amd.com/
>=20
> static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_in=
fo,
> +                                                  const X86CPUTopoIDs
> *topo_ids)
> +{
> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> +           (topo_ids->llc_id << apicid_llc_offset_epyc(topo_info)) |
> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> +           topo_ids->smt_id;
> +}
>=20
>=20
> The function apicid_from_topo_ids_epyc builds the apicid. New decode adds
> llc_id(which is numa id here) to the current decoding. Other fields are
> mostly remains same.

If llc_id is the same as numa id, why not reuse CpuInstanceProperties::node=
-id
instead of llc_id you are adding in previous patch 6/18?


>=20
>=20
> Details from the bug https://bugzilla.redhat.com/show_bug.cgi?id=3D172816=
6
>=20
> Processor Programming Reference (PPR) for AMD Family 17h Model 01h,
> Revision B1 Processors:
>=20
> """
> 2.1.10.2.1.3
> ApicId Enumeration Requirements
> Operating systems are expected to use
> Core::X86::Cpuid::SizeId[ApicIdCoreIdSize], the number of least
> significant bits in the Initial APIC ID that indicate core ID within a
> processor, in constructing per-core CPUID
> masks. Core::X86::Cpuid::SizeId[ApicIdCoreIdSize] determines the maximum
> number of cores (MNC) that the
> processor could theoretically support, not the actual number of cores tha=
t
> are actually implemented or enabled on
> the processor, as indicated by Core::X86::Cpuid::SizeId[NC].
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> =E2=80=A2 ApicId[6] =3D Socket ID.
> =E2=80=A2 ApicId[5:4] =3D Node ID.
> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} :
> {1'b0,LogicalCoreID[1:0]}.
> """
>=20
> >  =20
> >> =20
> >>>
> >>>    =20
> >>>>  };
> >>>> =20
> >>>>  /**
> >>>> diff --git a/vl.c b/vl.c
> >>>> index a42c24a77f..b6af604e11 100644
> >>>> --- a/vl.c
> >>>> +++ b/vl.c
> >>>> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
> >>>>      current_machine->cpu_type =3D machine_class->default_cpu_type;
> >>>>      if (cpu_option) {
> >>>>          current_machine->cpu_type =3D parse_cpu_option(cpu_option);
> >>>> +        if (machine_class->init_apicid_fn) {
> >>>> +            machine_class->init_apicid_fn(current_machine);
> >>>> +        }
> >>>>      }
> >>>>      parse_numa_opts(current_machine);
> >>>> =20
> >>>>
> >>>>   =20
> >>>    =20
> >> =20
> >  =20
>=20


