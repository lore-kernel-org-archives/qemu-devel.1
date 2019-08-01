Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045DC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF8B2064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mIxsrA+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF8B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGyU-0007ns-Oj
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Babu.Moger@amd.com>) id 1htGtN-0005sU-El
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1htGtL-0004oR-AT
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:37:37 -0400
Received: from mail-eopbgr750071.outbound.protection.outlook.com
 ([40.107.75.71]:65344 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1htGtH-0004kh-NR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a30gzQS94k7jyFOnrZ7dAEUkp4CEHk7wQ3XOboC3AJeJfqcirkWOPCjhkU7AmEr/994qbDMeWvuWZMqYcAlvd0MZsYMB1XBgobdEaipdcRp7gtMg58pI3xhs4upFca1PfmrzVxcMyUEAIOQP+yaZlbcz4f9R6O5dZFTINOJevH0bXehFvhUiNqfie5iV30qQu0n8TLy+7Y0m3oh+VYoK4RcD54cMuaJjxdQMu15mf6OL2jQVTeBOs4uqO2T8KnGW86o7V4vD8cT+xAC2cOd8Mmgt70u1kshx2AQxmX+LkSya1DV1MRfSCJRK/cLxIJG1joGpWFspHen0+0sZza9HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFPMsenD4vKSTowE/ANGmey+FAvy7Bg/vu2YsmZgGDk=;
 b=ct47lhDrEE0Ng/h54bMGqHK3gnQxRDzS+z+o/JGB5HqJwPvl4vCABCbOI9ulpQhZBvgccZpo42f5Y3nsFJ9oK+NHJ4mnyZb/5TjSXKVeCuki+uCgl06HM4W9ONEVe3vIWvl3scGM86Mby5ONsM0wH5NndcJ6yRN1S6pcNa9iTo+C8+PnqLDu9EdOKQjooGVj9my0NZcTshbCosGS/Obskcra4ItB8oso+qBbgCBAl8L77qLBi9CspsNoScn+zKPTAvlFJpqzon3C4NKKHrBCokgbRxWSaL1LAhqzA7B8OBO+bkYY3ug6FFhR3ycq0HtxLLQydVuMAyMWTywh23no6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFPMsenD4vKSTowE/ANGmey+FAvy7Bg/vu2YsmZgGDk=;
 b=mIxsrA+srBqtTRrCtYxyqzdmpQz2Ds/DCGgAeNYSdygyr1mE6l5kJSjRZxDRAMdLuojwHO7ULEUf/blWZj4J8Jq5RTmd4XurkKkFNuX94YliLUMJaxtAygrlE3X1TijFk7dMxSye2NP8VXuCbC5rKPZ56eDpuEuGgJ6C0HEXSzk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1881.namprd12.prod.outlook.com (10.175.89.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Thu, 1 Aug 2019 19:37:27 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67%7]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 19:37:27 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Thread-Topic: [RFC PATCH 4/5] hw/i386: Generate apicid based on cpu_type
Thread-Index: AQHVR/aXbkLSW+hCAEaO8Uc/WmhXT6bmrqwAgAACfYA=
Date: Thu, 1 Aug 2019 19:37:26 +0000
Message-ID: <49a81bf5-5dbe-adc6-10a3-a8f89e808fbe@amd.com>
References: <20190731232032.51786-1-babu.moger@amd.com>
 <20190731232032.51786-5-babu.moger@amd.com>
 <20190801192830.GD20035@habkost.net>
In-Reply-To: <20190801192830.GD20035@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0017.namprd06.prod.outlook.com
 (2603:10b6:803:2f::27) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d8ce59d-b4e9-4af9-0934-08d716b7af17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1881; 
x-ms-traffictypediagnostic: DM5PR12MB1881:
x-microsoft-antispam-prvs: <DM5PR12MB18817255A20631B5F08D638595DE0@DM5PR12MB1881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(51914003)(13464003)(86362001)(71190400001)(3846002)(6486002)(66066001)(6436002)(446003)(71200400001)(68736007)(6512007)(2616005)(2906002)(6116002)(486006)(53936002)(11346002)(8676002)(14454004)(8936002)(256004)(6246003)(7736002)(99286004)(229853002)(25786009)(31686004)(305945005)(6916009)(36756003)(31696002)(81156014)(66476007)(476003)(66946007)(4326008)(81166006)(478600001)(66446008)(54906003)(64756008)(52116002)(76176011)(53546011)(5660300002)(186003)(26005)(386003)(66556008)(102836004)(6506007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1881;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A3kl0pZvaQJ2nvNdCvyZv+qMIDWYHuR1FyMBjP82t6x3gBM9jh6GKx6Yw4qOHA8F2StNwc5HQ1nd+tgjZcF359xKZb1QHGApFLFlf+7e1yCe01YSZPL5jBREQ/4weEzf3EC06Ed+ed1qynSZY9ncST1y20/TOlrFRy1R/ltrnKjmvTvXX0kmQQuGCRn/+pQnxKU7dE67Gwbb1FC2Bq0bMcPAXel1n2HfeamhAh9O907XEDw5zWKcRuB2W0XVN1Civa1mtX0JZYIjxhQbDD0bu+3iGXZ7fnD8A/3yW5nXgCaj+PTLOaZKosiGD6LpEwvumh5evx4tTl4U2ZR4Dm/nhMISlHw1db8aM1v1jbmKuwswEQmTYzTQ1eK/iBSdLm2rbX3mIWkoxN1G0+ALAenWQHA5cKs9JaoHXr87B5LZmZU=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <45C5709737F6B8458AFFD5C25951C69A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8ce59d-b4e9-4af9-0934-08d716b7af17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 19:37:26.9892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.71
Subject: Re: [Qemu-devel] [RFC PATCH 4/5] hw/i386: Generate apicid based on
 cpu_type
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,
  Thanks for the quick comments. I will look into your comments closely
and will let you know if I have questions.

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Thursday, August 1, 2019 2:29 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: marcel.apfelbaum@gmail.com; mst@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; imammedo@redhat.com; qemu-devel@nongnu.org
> Subject: Re: [RFC PATCH 4/5] hw/i386: Generate apicid based on cpu_type
>=20
> Thanks for the patches.
>=20
> I still haven't looked closely at all patches in the series, but
> patches 1-3 seem good on the first look.  A few comments on this
> one:
>=20
> On Wed, Jul 31, 2019 at 11:20:50PM +0000, Moger, Babu wrote:
> > Check the cpu_type before calling the apicid functions
> > from topology.h.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> [...]
> > @@ -2437,16 +2478,26 @@ static void pc_cpu_pre_plug(HotplugHandler
> *hotplug_dev,
> >          topo.die_id =3D cpu->die_id;
> >          topo.core_id =3D cpu->core_id;
> >          topo.smt_id =3D cpu->thread_id;
> > -        cpu->apic_id =3D apicid_from_topo_ids(pcms->smp_dies, smp_core=
s,
> > -                                            smp_threads, &topo);
> > +	if (!strncmp(ms->cpu_type, "EPYC", 4)) {
>=20
> Please don't add semantics to the CPU type name.  If you want
> some behavior to be configurable per CPU type, please do it at
> the X86CPUDefinition struct.
>=20
> In this specific case, maybe the new APIC ID calculation code
> could
> be conditional on:
>   (vendor =3D=3D AMD) && (env->features[...] & TOPOEXT).
>=20
> Also, we must keep compatibility with the old APIC ID calculation
> code on older machine types.  We need a compatibility flag to
> enable the existing APIC ID calculation.
>=20
>=20
> > +            x86_topo_ids_from_idx_epyc(nb_numa_nodes, smp_sockets,
> smp_cores,
> > +                                       smp_threads, idx, &topo);
> > +            cpu->apic_id =3D apicid_from_topo_ids_epyc(smp_cores,
> smp_threads,
> > +                                                     &topo);
> > +	} else
>=20
> There's a tab character here.  Please use spaces instead of tabs.
>=20
> > +            cpu->apic_id =3D apicid_from_topo_ids(pcms->smp_dies, smp_=
cores,
> > +                                                smp_threads, &topo);
>=20
> I see you are duplicating very similar logic in 3 different
> places, to call apicid_from_topo_ids() and
> x86_topo_ids_from_apicid().
>=20
> Also, apicid_from_topo_ids() and x86_topo_ids_from_apicid() have very
> generic
> names, and people could call them expecting them to work for every CPU
> model
> (which they don't).  This makes the topology API very easy to misuse.
>=20
> Why don't we make the existing generic
> apicid_from_topo_ids()/x86_topo_ids_from_apicid() functions work
> on all cases?  If they need additional input to handle EPYC and
> call EPYC-specific functions, we can make them get additional
> arguments.  This way we'll be sure that we'll never call the
> wrong implementation by accident.
>=20
> This might make the list of arguments for
> x86_topo_ids_from_apicid() and apicid_from_topo_ids() become
> large.  We can address this by making them get a CpuTopology
> argument.
>=20
>=20
> In other words, the API could look like this:
>=20
>=20
> static inline apic_id_t apicid_from_topo_ids(const X86CPUTopology *topo,
>                                              const X86CPUTopologyIds *ids=
)
> {
>     if (topo->epyc_mode) {
>         return apicid_from_topo_ids_epyc(topo, ids);
>     }
>=20
>     /* existing QEMU 4.1 logic: */
>     return (ids->pkg_id  << apicid_pkg_offset(topo)) |
>            (ids->die_id  << apicid_die_offset(topo)) |
>            (ids->core_id << apicid_core_offset(topo)) |
>            ids->smt_id;
> }
>=20
> static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>                                             const X86CPUTopology *topo,
>                                             X86CPUTopologyIds *ids)
> {
>     if (topo->epyc_mode) {
>         x86_topo_ids_from_apicid_epyc(apicid, topo, ids);
>         return;
>     }
>=20
>     /* existing QEMU 4.1 logic: */
>     ids->smt_id =3D
>             apicid &
>             ~(0xFFFFFFFFUL << apicid_smt_width(topo));
>     ids->core_id =3D
>             (apicid >> apicid_core_offset(topo)) &
>             ~(0xFFFFFFFFUL << apicid_core_width(topo));
>     ids->die_id =3D
>             (apicid >> apicid_die_offset(topo)) &
>             ~(0xFFFFFFFFUL << apicid_die_width(topo));
>     ids->pkg_id =3D apicid >> apicid_pkg_offset(topo);
> }
>=20
>=20
> >      }
> >
> >      cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> >      if (!cpu_slot) {
> >          MachineState *ms =3D MACHINE(pcms);
> >
> > -        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> > -                                 smp_cores, smp_threads, &topo);
> > +        if(!strncmp(ms->cpu_type, "EPYC", 4))
> > +            x86_topo_ids_from_apicid_epyc(cpu->apic_id, pcms->smp_dies=
,
> > +                                          smp_cores, smp_threads, &top=
o);
> > +        else
> > +            x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> > +                                     smp_cores, smp_threads, &topo);
> >          error_setg(errp,
> >              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] w=
ith"
> >              " APIC ID %" PRIu32 ", valid index range 0:%d",
> > @@ -2874,10 +2925,18 @@ static const CPUArchIdList
> *pc_possible_cpu_arch_ids(MachineState *ms)
> >
> >          ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
> >          ms->possible_cpus->cpus[i].vcpus_count =3D 1;
> > -        ms->possible_cpus->cpus[i].arch_id =3D
> x86_cpu_apic_id_from_index(pcms, i);
> > -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> > -                                 pcms->smp_dies, ms->smp.cores,
> > -                                 ms->smp.threads, &topo);
> > +	if(!strncmp(ms->cpu_type, "EPYC", 4)) {
> > +            ms->possible_cpus->cpus[i].arch_id =3D
> > +                            x86_cpu_apic_id_from_index_epyc(pcms, i);
> > +            x86_topo_ids_from_apicid_epyc(ms->possible_cpus-
> >cpus[i].arch_id,
> > +                                          pcms->smp_dies, ms->smp.core=
s,
> > +					  ms->smp.threads, &topo);
> > +	} else {
> > +            ms->possible_cpus->cpus[i].arch_id =3D
> x86_cpu_apic_id_from_index(pcms, i);
> > +            x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_i=
d,
> > +                                     pcms->smp_dies, ms->smp.cores,
> > +                                     ms->smp.threads, &topo);
> > +	}
> >          ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
> >          ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
> >          ms->possible_cpus->cpus[i].props.has_die_id =3D true;
> > --
> > 2.20.1
> >
>=20
> --
> Eduardo

