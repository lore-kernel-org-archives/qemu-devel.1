Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64703C5DF60
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 00:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029792087E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 00:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IZAei4Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029792087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS91G-0003cj-9w
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 19:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iS90M-0003AD-ED
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iS90L-0005aV-3L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:16:58 -0500
Received: from mail-eopbgr740083.outbound.protection.outlook.com
 ([40.107.74.83]:42400 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iS90K-0005Ys-PN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:16:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyAwhfYKZ6hbb2CqIlLTC+O+G2pa0+gwuXgPE8Uf3HJlLeKoTigXDdqJOHoasEskfEmSa7WIUa477kpaq9pORa0lpABewzF6BJuVBYspdsfRjmeRPvrFS2uLinEU4cDhCxp07hYIcwDBkkg/RS1LMbFpYeH7BvrKgFK2yOQjw7pRYAdL2NBD0MjaR5snzNJro0bu55DKViCTvoALUbqgiQOmu2+ovgltALrcppzQcMxnqRgJ8dx9XQ5W9BkBvLApLCogD75tsQvfMB7Vg5mSnVndphNMOCIhfSSm4vVoJzn4Ns2k3XTMQE3HGTdZlqoO05fWDGbOyfXsK0eTVLtdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGJCqsrj/RFnliSpnwU5j9PruCy7eyW/Zr/U6F5qTuo=;
 b=TyUBfuIfgiW5hSI4DfGAXnNAlyuniLFLc6cYeW2CxaPVGs7Twuq9lAvvZoPz3GCWZ4ZvYSoDksxPIMODEMUg4Rb9f7CEY9ektNIU9HokpGlbuB8Bdd8+vOatC6vjlL8RU0JrMoc/Wo9lwwWRn22gBpiaRbeZRMjCCGBRJQSJseJSegy5dIUN6HUFc5ez/WDXJtPL9dN4ds0lXpHcCwJ6MQIl1k0Y3VHkEP/4I/3vKNqYnczvvBEf9JpR+o5GgF0AgphSvL761QkX/3a10HzTr4AODOm3OuHOwZ5KP0cx4qr3nMF4g8RdU6yT3GA0AdGeN4z2tALag1GfOCHRCdC15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGJCqsrj/RFnliSpnwU5j9PruCy7eyW/Zr/U6F5qTuo=;
 b=IZAei4Fxl7Iw25vawM01FmIAtiiKvCa4NXIq2bmO3YrJ21HH3Ay7eNkAiPEDeX49QfsUSdFBEYMBd8NOu6Qv3+TJbb+BiCJW5sMlpa+Pa06jBKYEPQGBlw9LJaKZ4FKlLIVzFTuL72GZOmZsYsb5gorrV5wCfqXEGRyP4/oUUqc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2406.namprd12.prod.outlook.com (52.132.142.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 00:16:54 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c5a3:6a2e:8699:1999]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c5a3:6a2e:8699:1999%6]) with mapi id 15.20.2408.025; Wed, 6 Nov 2019
 00:16:54 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
Thread-Topic: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
Thread-Index: AQHVlB5u/QshhXRmbESG6YL51EBKfad9G92AgAApkdA=
Date: Wed, 6 Nov 2019 00:16:53 +0000
Message-ID: <DM5PR12MB247163587352C674296256A795790@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <157298859935.17394.17194072829278152009.stgit@naples-babu.amd.com>
 <157298864859.17394.12763030347823834590.stgit@naples-babu.amd.com>
 <20191105214325.GL3812@habkost.net>
In-Reply-To: <20191105214325.GL3812@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:3c22:a355:85db:c9f9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da0c0c4f-04cf-47b3-2f58-08d7624ea0e8
x-ms-traffictypediagnostic: DM5PR12MB2406:
x-microsoft-antispam-prvs: <DM5PR12MB2406DACCAA5412128F0F1D2E95790@DM5PR12MB2406.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(13464003)(189003)(199004)(14454004)(2906002)(66446008)(66556008)(66476007)(74316002)(64756008)(76116006)(5660300002)(99286004)(71190400001)(71200400001)(9686003)(6916009)(54906003)(6246003)(102836004)(53546011)(55016002)(52536014)(6116002)(6506007)(86362001)(186003)(7736002)(33656002)(305945005)(478600001)(486006)(316002)(76176011)(25786009)(446003)(8936002)(81166006)(8676002)(14444005)(229853002)(4326008)(81156014)(11346002)(6436002)(46003)(66946007)(256004)(476003)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2406;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZX+pxKwMnHYZvohlecEjJ9oI21G+y4giLO032syJnhP2+vWfQDRNBphX3NNoYMKMB+jfe64LKMk6FRyDS877n0ZUXJhzIRuKEUqzBZzf0UmadOV4H6etuh4u36LvdflzmMlqYqxXNzZ3SV8YnBrxOs5YtlFG2Ax7BBRnxMB/1pkI6d7LDS+2SLIqf/zArLi50ZcydNVxq7dKJ4d8dxpdaC8zicTqd33atZmqUrQV2l/PXKCZCIULWc8ZiuPvUxpM7/EbHyhzCW9g+pptMM12REK0qqzevnhvMsc6pTBmhLvPS2NNuheTQSn0Y5hq7InnY9/IMcaGNPSIjmYmXBdm+WqFPda2Gyya6gogHP9CgJgSQU6buByNkiZdxKXaEDX1TPcjXFbkgjbDQvDN8fTVngpIxIeS2pTCUY5g+m5tKpjzZlECc3c5vIBetGOOBUyl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0c0c4f-04cf-47b3-2f58-08d7624ea0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 00:16:54.0797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+LsTh9AIPsJxVcHIm+NL8xQ6ds9zNAI9QfPzRL/I/oXT2DxsA89E192V4bMynmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2406
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.83
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Tuesday, November 5, 2019 3:43 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; qemu-devel@nongnu.org
> Subject: Re: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
>=20
> On Tue, Nov 05, 2019 at 09:17:30PM +0000, Moger, Babu wrote:
> > Adds the following missing CPUID bits:
> > perfctr-core : core performance counter extensions support. Enables the=
 VM
> >                to use extended performance counter support. It enables =
six
> >                programmable counters instead of 4 counters.
> > clzero       : instruction zeroes out the 64 byte cache line specified =
in RAX.
> > xsaveerptr   : XSAVE, XSAVE, FXSAVEOPT, XSAVEC, XSAVES always save erro=
r
> >                pointers and FXRSTOR, XRSTOR, XRSTORS always restore err=
or
> >                pointers.
> > ibpb         : Indirect Branch Prediction Barrie.
> > xsaves       : XSAVES, XRSTORS and IA32_XSS supported.
> >
> > Depends on:
> > 40bc47b08b6e ("kvm: x86: Enumerate support for CLZERO instruction")
> > 504ce1954fba ("KVM: x86: Expose XSAVEERPTR to the guest")
> > 52297436199d ("kvm: svm: Update svm_xsaves_supported")
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  hw/i386/pc.c      |    8 +++++++-
> >  target/i386/cpu.c |   11 +++++------
> >  2 files changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 51b72439b4..a72fe1db31 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -105,7 +105,13 @@ struct hpet_fw_config hpet_cfg =3D {.count =3D
> UINT8_MAX};
> >  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> >  static size_t pvh_start_addr;
> >
> > -GlobalProperty pc_compat_4_1[] =3D {};
> > +GlobalProperty pc_compat_4_1[] =3D {
> > +    { "EPYC" "-" TYPE_X86_CPU, "perfctr-core", "off" },
> > +    { "EPYC" "-" TYPE_X86_CPU, "clzero", "off" },
> > +    { "EPYC" "-" TYPE_X86_CPU, "xsaveerptr", "off" },
> > +    { "EPYC" "-" TYPE_X86_CPU, "ibpb", "off" },
> > +    { "EPYC" "-" TYPE_X86_CPU, "xsaves", "off" },
> > +};
>=20
> machine-type-based CPU compatibility was now replaced by
> versioned CPU models.  Please use the X86CPUDefinition.versions
> field to add a new version of EPYC instead.

Ok. Did  you mean like this commit  below?
fd63c6d1a5f77d68 ("i386: Add Cascadelake-Server-v2 CPU model")

>=20
> >  const size_t pc_compat_4_1_len =3D G_N_ELEMENTS(pc_compat_4_1);
> >
> >  GlobalProperty pc_compat_4_0[] =3D {};
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 07cf562d89..71233e6310 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3110,19 +3110,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D =
{
> >              CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
> >              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM
> |
> >              CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
> > -            CPUID_EXT3_TOPOEXT,
> > +            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
> > +        .features[FEAT_8000_0008_EBX] =3D
> > +            CPUID_8000_0008_EBX_CLZERO |
> CPUID_8000_0008_EBX_XSAVEERPTR |
> > +            CPUID_8000_0008_EBX_IBPB,
> >          .features[FEAT_7_0_EBX] =3D
> >              CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> CPUID_7_0_EBX_AVX2 |
> >              CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
> CPUID_7_0_EBX_RDSEED |
> >              CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
> CPUID_7_0_EBX_CLFLUSHOPT |
> >              CPUID_7_0_EBX_SHA_NI,
> > -        /* Missing: XSAVES (not supported by some Linux versions,
> > -         * including v4.1 to v4.12).
> > -         * KVM doesn't yet expose any XSAVES state save component.
> > -         */
> >          .features[FEAT_XSAVE] =3D
> >              CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> > -            CPUID_XSAVE_XGETBV1,
> > +            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
> >          .features[FEAT_6_EAX] =3D
> >              CPUID_6_EAX_ARAT,
> >          .features[FEAT_SVM] =3D
> >
>=20
> --
> Eduardo


