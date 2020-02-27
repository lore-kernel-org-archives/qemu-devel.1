Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B8C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39532246A0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SZHnr/Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39532246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QjI-0003Tg-DH
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j7Qie-0002za-1D
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j7Qib-0005qU-Qc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:29:19 -0500
Received: from mail-co1nam11on2121.outbound.protection.outlook.com
 ([40.107.220.121]:34144 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j7Qib-0005oQ-CQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:29:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ4xWRKZrK/QyZmf8CThdQHNuKDB8m9NXqxMJqi59uyhPMF45q6DCvJl5a9l3lnXmkiA5sWK8lJGNM5VDTtxz3kZpnXbrg1ECV2wmqZ9jhARRJA+8q5Lc1hu+rOtCOAZMf7Jn/kG1Cmw/oMMfYGHurl0hNlJP+PLEmksxSmy1Q/jH4ZvvV8EadqRGkcErJxr/7nmeL79+Ab+ywrv31PYkne/d4BjD81+otvHzXAD6bdL3RmeV+EPn8HQihT9A3+8MKvM8r0YBY8+uAHh1A6r4uHFqtQKsnSbXpfld/QjMLawP/MJPyXVYvvz7lkhfda+gCXeTpk5TGDyrb7ajwb4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYP6obvtA+Rk1wwCRlFeTkvmlCWok0i0tynIxUSC4i8=;
 b=ZT5AvAD1IHkQlebiqgGbbyJkeuq128fehLb9F2kvjyVp9jAVECWNhStC3zbRi6zN04DVpSZtMWOqvZ8htFpbS9A7RLe0kjzVRvhwJvebpD1VXrrUUydn+K53AjbDKXP9+inlEXuke39JS2E5tVpmMf5n3nefKPgUWE+NMfIqzlz7Jp1Tp5VyYdrHMRCFG3Xavzk3Lm3b2pqojvj0CdVpTW6fngGqCNnuiAuM0dCUNrqJUdZCEr8c06hRjckWmQtukoMW0ZSWf2npgpAk63/yeJfxD4JLSV1HtCMhFmDuvRjGF6Sc1su/jdEg8Mrt4+JfC56cR2Rk8V6i1Wh/kir5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYP6obvtA+Rk1wwCRlFeTkvmlCWok0i0tynIxUSC4i8=;
 b=SZHnr/VuS+pS/nZEe1B0jqMjI9PR8obzNIPuCtbIVgKI5jbD+86qn1e0jQiUbfwZ6FZII/ZOmmHnsJTKZRZT0LlhlpA0Gj18NmHGlK9vsgqDIdPyOQPgLzFZ1PMiFnuTDU6a+KPezP8mopq8uaWbU330cmYXXPQsWt1yBgYmGyU=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0815.namprd21.prod.outlook.com
 (2603:10b6:803:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5; Thu, 27 Feb
 2020 21:29:14 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%8]) with mapi id 15.20.2793.003; Thu, 27 Feb 2020
 21:29:14 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Eduardo Habkost <ehabkost@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>
Subject: RE: [EXTERNAL] Re: [PATCH] WHPX: Use QEMU values for trapped CPUID
Thread-Topic: [EXTERNAL] Re: [PATCH] WHPX: Use QEMU values for trapped CPUID
Thread-Index: AdXtsNoeJNEkd+WMTCOFtkYfkkG5GwAAWEOAAACNp/A=
Date: Thu, 27 Feb 2020 21:29:14 +0000
Message-ID: <SN4PR2101MB0880BBB072EC47CA988B79E9C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20200227210943.GJ4440@habkost.net>
In-Reply-To: <20200227210943.GJ4440@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:3028:825f:ab03:1fb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50629f5d-4e58-490b-2e4e-08d7bbcc17ec
x-ms-traffictypediagnostic: SN4PR2101MB0815:
x-microsoft-antispam-prvs: <SN4PR2101MB08150C508F43EE23C36E07CEC0EB0@SN4PR2101MB0815.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(71200400001)(66476007)(10290500003)(64756008)(316002)(478600001)(66946007)(81166006)(54906003)(81156014)(5660300002)(8936002)(66446008)(66556008)(76116006)(86362001)(8676002)(186003)(8990500004)(6916009)(6506007)(53546011)(52536014)(33656002)(2906002)(4326008)(55016002)(9686003)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0815;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mny1yCs5BA0rYlxPmRIlrzXLcFVMb+sxHpHS7OzCJQdJEMP7pXB9cJQ1T0LNNny5JfkBHPkadzKtUyi08vYJIxRPNB9ubAznSVPCrxpKRmlzzFVR45dIn0D26HyelXVeZIhBbzm03724GKkEJ2Vigtp+cyhnIwBzRTFF5qlpLyFt690abHChbX81+74PcYZHrJ9+5IchJMwb2jfsJLIkyVsuKY8aSd74+cWMT/xdrc3KsemavY6I1zWylrGmncDOOWaYCwMy7TCBqTyIwsNwuKC1qldK8y4BSJ0ciGAoQkDKnhPL1egh6Zk+P5a4w07+95wytb6aFTv2Wjcntr7A0tVNY22B2aLxuSoB7TSvAWYq7jkDn6TGPnJmVgWtNtcapjrc3NLqsPiLEIf/1G5SKwJEufSfkEC5DDppm/MH4ijpoppU/Okb/XDjQyz6r/SN
x-ms-exchange-antispam-messagedata: DblRxHl2jDa+d2uEMW1rw7MiKuAtstBwPq8cz0+Uy4j1aFdXRQ6DwdKHR/EwGdP8VRfzRDQkdbaN/vqM4cAWXpktGVcjor33Eg+Uyv50djFaNfPqcgvfBrshNHlk6+GH2fB7cYthfe3+O3KqT0fBsojsIbdZxSS8V5gwXxz+HglRI1RPqaw/MVSX93QqG71msGFku3rsK1WSx2u/XshjlA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50629f5d-4e58-490b-2e4e-08d7bbcc17ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 21:29:14.3702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bANlJgOPPBEQJMscHogQjhYYSu53j//ghG257a5cZwEiil4phHzgyOVgu8g15A2ohIaWD0xF4xLxK8AY/wl9EMh9JlMmKAuV4Il6TE3sSQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0815
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.121
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Thursday, February 27, 2020 1:10 PM
> To: Sunil Muthuswamy <sunilmut@microsoft.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.n=
et>; qemu-devel@nongnu.org; Stefan Weil
> <sw@weilnetz.de>
> Subject: [EXTERNAL] Re: [PATCH] WHPX: Use QEMU values for trapped CPUID
>=20
> On Thu, Feb 27, 2020 at 09:01:04PM +0000, Sunil Muthuswamy wrote:
> > Currently, WHPX is using some default values for the trapped CPUID
> > functions. These were not in sync with the QEMU values because the
> > CPUID values were never set with WHPX during VCPU initialization.
> > Additionally, at the moment, WHPX doesn't support setting CPUID
> > values in the hypervisor at runtime (i.e. after the partition has
> > been setup). That is needed to be able to set the CPUID values in
> > the hypervisor during VCPU init.
> > Until that support comes, use the QEMU values for the trapped CPUIDs.
> >
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>=20
> I like the change, but I wonder if any if your users would still
> prefer to use the default result chosen by WHPX instead of the
> ones chosen by QEMU.
>=20

Note that the current patch only applies to the trapped CPUIDs, which for
WHPX are currently only {1, 0x80000001}. WHPX will still provide most
of the values.

> On the KVM side I have always wondered if we should have a mode
> where all CPUID leaves are the ones chosen by KVM, making no
> KVM_SET_CPUID calls.  It would be useful for experimentation and
> debugging of KVM/QEMU defaults.
>=20
Agreed. I think such an option could be useful debugging tool.

>=20
> > ---
> >  target/i386/whpx-all.c | 42 ++++++++++++++++++------------------------
> >  1 file changed, 18 insertions(+), 24 deletions(-)
> >
> > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> > index 35601b8176..4fe5a78b29 100644
> > --- a/target/i386/whpx-all.c
> > +++ b/target/i386/whpx-all.c
> > @@ -980,38 +980,32 @@ static int whpx_vcpu_run(CPUState *cpu)
> >              WHV_REGISTER_VALUE reg_values[5];
> >              WHV_REGISTER_NAME reg_names[5];
> >              UINT32 reg_count =3D 5;
> > -            UINT64 rip, rax, rcx, rdx, rbx;
> > +            UINT64 cpuid_fn, rip =3D 0, rax =3D 0, rcx =3D 0, rdx =3D =
0, rbx =3D 0;
> > +            X86CPU *x86_cpu =3D X86_CPU(cpu);
> > +            CPUX86State *env =3D &x86_cpu->env;
> >
> >              memset(reg_values, 0, sizeof(reg_values));
> >
> >              rip =3D vcpu->exit_ctx.VpContext.Rip +
> >                    vcpu->exit_ctx.VpContext.InstructionLength;
> > -            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> > -            case 1:
> > -                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> > -                /* Advertise that we are running on a hypervisor */
> > -                rcx =3D
> > -                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
> > -                    CPUID_EXT_HYPERVISOR;
> > -
> > -                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > -                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> > -                break;
> > +            cpuid_fn =3D vcpu->exit_ctx.CpuidAccess.Rax;
> > +
> > +            /*
> > +             * Ideally, these should be supplied to the hypervisor dur=
ing VCPU
> > +             * initialization and it should be able to satisfy this re=
quest.
> > +             * But, currently, WHPX doesn't support setting CPUID valu=
es in the
> > +             * hypervisor once the partition has been setup, which is =
too late
> > +             * since VCPUs are realized later. For now, use the values=
 from
> > +             * QEMU to satisfy these requests, until WHPX adds support=
 for
> > +             * being able to set these values in the hypervisor at run=
time.
> > +             */
> > +            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)=
&rbx,
> > +                (UINT32 *)&rcx, (UINT32 *)&rdx);
> > +            switch (cpuid_fn) {
> >              case 0x80000001:
> > -                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> >                  /* Remove any support of OSVW */
> > -                rcx =3D
> > -                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
> > -                    ~CPUID_EXT3_OSVW;
> > -
> > -                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > -                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> > +                rcx &=3D ~CPUID_EXT3_OSVW;
> >                  break;
> > -            default:
> > -                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> > -                rcx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> > -                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > -                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> >              }
> >
> >              reg_names[0] =3D WHvX64RegisterRip;
> > --
> > 2.17.1
> >
>=20
> --
> Eduardo


