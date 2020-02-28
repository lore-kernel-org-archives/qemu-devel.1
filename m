Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93795C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF6C246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jlya9Pmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF6C246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7moD-0000nZ-FZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j7mmi-0008K6-Qp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j7mmg-0004Fo-5O
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:03:00 -0500
Received: from mail-co1nam11on2108.outbound.protection.outlook.com
 ([40.107.220.108]:42080 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j7mmf-0004D3-JH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:02:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+UUgLqIpVpZcLAAU+RlkZ+fZN+/cSxtt7bcx/q7jnSqcZvZ2YIcoGDuTgmpOt2rHNLt4qExXrLR/zCMdfySJmxl7eutYUAj3lfdfSUbdsWiXcCmHzHvpaW/W/SAJROroBkiuo5QNSwYxRRg/dHJGJXOuKgP1Fu9PGGi5X9uaG3udCyutyMHbwjQjrOnw+e9ee1URxxhDFQOaoYLns1OCYSUcEAF9BgmFZMa/YOgPyKxh2aocudpfa0JS6rDZHsAf3oyMgC4Tf07WR2ztIbQkzzNFzskcOEblRFsCzvHMHdsokvlUMNCg51LL/h4PxY1hA40c6KE/dig8pTum4b5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60NBAnTsOteywgzKNQDd4EjCf8gdSztjAPfypzU/Pfw=;
 b=oHOksxLDJkB1/QgcOsdtPkPYFUeT9BM7uov/mOHToWf9hFAqfGG9UV73s67kO0nMexCbL3g2E8pskGYwEBZslQqrZ85qJusSB4/17GcUW2gNPdlKUAjYZgKmFzBYxvJe5JFRV1Ms1ua6ofk9AOZSc9ygxzaPmpzF7u5DaAJN1x/wEnv2+202srtPAeWOqUb5XVDAO2XNZ61jW7+uRhwTr+knymkN6yYGZoaqyjRjhOnLh4C/h7MovOUAImsJFO8/KzGctHPmtsYMQV17zwbRTqdtRNuNMeZA7G0EdFdj9WnaKskZSKtbsgfKyCD69pKFcfvlqGUrfj5J4bMlFWESLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60NBAnTsOteywgzKNQDd4EjCf8gdSztjAPfypzU/Pfw=;
 b=jlya9PmoDo8XSJg9fTPwveGIfn2VJ5o/yfLtWfutk9qUBgC1ggzaHK4V4XVbMcqNuwnzlFyE1UqH02bwGN2yGdpc3BWVGznTJtnZHBt1PpFtWaGNwm6YOan5nkSgF9eUruHgVMCITSOJkDuO1ZFeJBDINGcTmMV4Ab/SJ0mUEcU=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0877.namprd21.prod.outlook.com
 (2603:10b6:803:46::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.9; Fri, 28 Feb
 2020 21:02:54 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%8]) with mapi id 15.20.2793.003; Fri, 28 Feb 2020
 21:02:54 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: RE: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Topic: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Index: AdXs5oCBJsjFayPuQg++a0KvVJgCQQBPaQ8AABVvfKA=
Date: Fri, 28 Feb 2020 21:02:54 +0000
Message-ID: <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
In-Reply-To: <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:3028:825f:ab03:1fb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffb27fd3-4b37-4d9d-98c0-08d7bc9194d2
x-ms-traffictypediagnostic: SN4PR2101MB0877:
x-microsoft-antispam-prvs: <SN4PR2101MB0877057DD79C4318414D18F7C0E80@SN4PR2101MB0877.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(8990500004)(33656002)(7696005)(52536014)(86362001)(30864003)(5660300002)(316002)(54906003)(110136005)(66556008)(9686003)(4326008)(55016002)(8936002)(81166006)(186003)(53546011)(10290500003)(6506007)(8676002)(81156014)(478600001)(76116006)(2906002)(66946007)(66476007)(64756008)(66446008)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0877;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MH5REMl5wKvnHOtXU7AXUuD/yZtbb+sb45XgVy07mQSVcvUrORJhmg+XHOQUuVzLbGxJKMEnTYntDiDtN0tTzjU21jErnmMzNo/zgKz5i6h3plRsMem3F53RqRtSh9c60ZyqwizPPcyhs/R4g5IdEXqNID3PwwsLLnSuKrK2/1LiryOONE02vgVnrk5piJlZ6fRKpxvGGE0BPeGVYeanJqv6/+fa7n25rw8//wm5hKft99FiG528JRVWZb1NmYrHwIebTBnwpKHt+8WWIk5fUOXOT6jcG5proo6lZ6t9cXH3bLi5mjxCWO9nXZlDJuvFjNl19RZFc3z2xaSEPw6KZ/CPTdapgsVGKvO4FnelM3LDw+NaKWAK+5ytdedM87EDwTuUdshOoJFhSWeah+Vk+G6zok1RuGFkbap0Z5Uz24Cnvw2AcCZi6gB1Ued9xMnR
x-ms-exchange-antispam-messagedata: 8s4mjxmVOh8g36/NXPcE1/7ySZUUcXQRCq0cR0MowuM+ogweykl+txvI8HqzejJQtzzpYnlCakYDPBYl+dbvUWyheVLkmBZUB0WpAwLFku0WyBGGVEyhhz1gLF3B80em5TTQ2SSxvOGZs/ijsNQzwfLqI+xsyaRmgjxHHfNLVVV6UTv8iRbLqBGk0ui2kk43qDaMtihXyBHEY6IKGLNBgw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb27fd3-4b37-4d9d-98c0-08d7bc9194d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 21:02:54.8374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMFt4hRUGljFUj856GbtUuNpAOiIzdx5vqi1aXYdbX7gYXj4ElRPCxdZwZoLcWjZfGwUoo0zv5tt0K8dInWg5hsZshUTzuXwOqXshI9nS0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0877
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.108
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
> From: Paolo Bonzini <pbonzini@redhat.com>
> Sent: Friday, February 28, 2020 2:45 AM
> To: Sunil Muthuswamy <sunilmut@microsoft.com>; Richard Henderson <rth@twi=
ddle.net>; Eduardo Habkost
> <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org; Stefan Weil <sw@weilnetz.de>
> Subject: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent =
on VM state
>=20
> On 26/02/20 21:54, Sunil Muthuswamy wrote:
> > Currently, TSC is set as part of the VM runtime state. Setting TSC at
> > runtime is heavy and additionally can have side effects on the guest,
> > which are not very resilient to variances in the TSC. This patch uses
> > the VM state to determine whether to set TSC or not. Some minor
> > enhancements for getting TSC values as well that considers the VM state=
.
> >
> > Additionally, while setting the TSC, the partition is suspended to
> > reduce the variance in the TSC value across vCPUs.
> >
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>=20
> Looks good.  Do you want me to queue this until you can have your GPG
> key signed?  (And also, I can help you sign it of course).
>=20

Yes, please. Thanks.

I haven't used GPG keys before. What would I be using it for?
=20
> Thanks,
>=20
> > ---
> >  include/sysemu/whpx.h      |   7 +++
> >  target/i386/whp-dispatch.h |   9 ++++
> >  target/i386/whpx-all.c     | 103 +++++++++++++++++++++++++++++++++----
> >  3 files changed, 110 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
> > index 4794e8effe..a84b49e749 100644
> > --- a/include/sysemu/whpx.h
> > +++ b/include/sysemu/whpx.h
> > @@ -35,4 +35,11 @@ int whpx_enabled(void);
> >
> >  #endif /* CONFIG_WHPX */
> >
> > +/* state subset only touched by the VCPU itself during runtime */
> > +#define WHPX_SET_RUNTIME_STATE   1
> > +/* state subset modified during VCPU reset */
> > +#define WHPX_SET_RESET_STATE     2
> > +/* full state set, modified during initialization or on vmload */
> > +#define WHPX_SET_FULL_STATE      3
> > +
> >  #endif /* QEMU_WHPX_H */
> > diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
> > index 87d049ceab..e4695c349f 100644
> > --- a/target/i386/whp-dispatch.h
> > +++ b/target/i386/whp-dispatch.h
> > @@ -23,6 +23,12 @@
> >    X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Pa=
rtition, UINT32 VpIndex, const
> WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALU=
E* RegisterValues)) \
> >    X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Pa=
rtition, UINT32 VpIndex, const
> WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTE=
R_VALUE* RegisterValues)) \
> >
> > +/*
> > + * These are supplemental functions that may not be present
> > + * on all versions and are not critical for basic functionality.
> > + */
> > +#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(X) \
> > +  X(HRESULT, WHvSuspendPartitionTime, (WHV_PARTITION_HANDLE Partition)=
) \
> >
> >  #define LIST_WINHVEMULATION_FUNCTIONS(X) \
> >    X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS*=
 Callbacks, WHV_EMULATOR_HANDLE*
> Emulator)) \
> > @@ -40,10 +46,12 @@
> >  /* Define function typedef */
> >  LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
> >  LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
> > +LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
> >
> >  struct WHPDispatch {
> >      LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
> >      LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
> > +    LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
> >  };
> >
> >  extern struct WHPDispatch whp_dispatch;
> > @@ -53,6 +61,7 @@ bool init_whp_dispatch(void);
> >  typedef enum WHPFunctionList {
> >      WINHV_PLATFORM_FNS_DEFAULT,
> >      WINHV_EMULATION_FNS_DEFAULT,
> > +    WINHV_PLATFORM_FNS_SUPPLEMENTAL
> >  } WHPFunctionList;
> >
> >  #endif /* WHP_DISPATCH_H */
> > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> > index 35601b8176..6a885c0fb3 100644
> > --- a/target/i386/whpx-all.c
> > +++ b/target/i386/whpx-all.c
> > @@ -114,7 +114,6 @@ static const WHV_REGISTER_NAME whpx_register_names[=
] =3D {
> >      WHvX64RegisterXmmControlStatus,
> >
> >      /* X64 MSRs */
> > -    WHvX64RegisterTsc,
> >      WHvX64RegisterEfer,
> >  #ifdef TARGET_X86_64
> >      WHvX64RegisterKernelGsBase,
> > @@ -215,7 +214,44 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEG=
MENT_REGISTER *hs)
> >      return qs;
> >  }
> >
> > -static void whpx_set_registers(CPUState *cpu)
> > +static int whpx_set_tsc(CPUState *cpu)
> > +{
> > +    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
> > +    WHV_REGISTER_NAME tsc_reg =3D WHvX64RegisterTsc;
> > +    WHV_REGISTER_VALUE tsc_val;
> > +    HRESULT hr;
> > +    struct whpx_state *whpx =3D &whpx_global;
> > +
> > +    /*
> > +     * Suspend the partition prior to setting the TSC to reduce the va=
riance
> > +     * in TSC across vCPUs. When the first vCPU runs post suspend, the
> > +     * partition is automatically resumed.
> > +     */
> > +    if (whp_dispatch.WHvSuspendPartitionTime) {
> > +
> > +        /*
> > +         * Unable to suspend partition while setting TSC is not a fata=
l
> > +         * error. It just increases the likelihood of TSC variance bet=
ween
> > +         * vCPUs and some guest OS are able to handle that just fine.
> > +         */
> > +        hr =3D whp_dispatch.WHvSuspendPartitionTime(whpx->partition);
> > +        if (FAILED(hr)) {
> > +            warn_report("WHPX: Failed to suspend partition, hr=3D%08lx=
", hr);
> > +        }
> > +    }
> > +
> > +    tsc_val.Reg64 =3D env->tsc;
> > +    hr =3D whp_dispatch.WHvSetVirtualProcessorRegisters(
> > +        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
> > +    if (FAILED(hr)) {
> > +        error_report("WHPX: Failed to set TSC, hr=3D%08lx", hr);
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void whpx_set_registers(CPUState *cpu, int level)
> >  {
> >      struct whpx_state *whpx =3D &whpx_global;
> >      struct whpx_vcpu *vcpu =3D get_whpx_vcpu(cpu);
> > @@ -230,6 +266,14 @@ static void whpx_set_registers(CPUState *cpu)
> >
> >      assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
> >
> > +    /*
> > +     * Following MSRs have side effects on the guest or are too heavy =
for
> > +     * runtime. Limit them to full state update.
> > +     */
> > +    if (level >=3D WHPX_SET_RESET_STATE) {
> > +        whpx_set_tsc(cpu);
> > +    }
> > +
> >      memset(&vcxt, 0, sizeof(struct whpx_register_set));
> >
> >      v86 =3D (env->eflags & VM_MASK);
> > @@ -330,8 +374,6 @@ static void whpx_set_registers(CPUState *cpu)
> >      idx +=3D 1;
> >
> >      /* MSRs */
> > -    assert(whpx_register_names[idx] =3D=3D WHvX64RegisterTsc);
> > -    vcxt.values[idx++].Reg64 =3D env->tsc;
> >      assert(whpx_register_names[idx] =3D=3D WHvX64RegisterEfer);
> >      vcxt.values[idx++].Reg64 =3D env->efer;
> >  #ifdef TARGET_X86_64
> > @@ -379,6 +421,25 @@ static void whpx_set_registers(CPUState *cpu)
> >      return;
> >  }
> >
> > +static int whpx_get_tsc(CPUState *cpu)
> > +{
> > +    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
> > +    WHV_REGISTER_NAME tsc_reg =3D WHvX64RegisterTsc;
> > +    WHV_REGISTER_VALUE tsc_val;
> > +    HRESULT hr;
> > +    struct whpx_state *whpx =3D &whpx_global;
> > +
> > +    hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
> > +        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
> > +    if (FAILED(hr)) {
> > +        error_report("WHPX: Failed to get TSC, hr=3D%08lx", hr);
> > +        return -1;
> > +    }
> > +
> > +    env->tsc =3D tsc_val.Reg64;
> > +    return 0;
> > +}
> > +
> >  static void whpx_get_registers(CPUState *cpu)
> >  {
> >      struct whpx_state *whpx =3D &whpx_global;
> > @@ -394,6 +455,11 @@ static void whpx_get_registers(CPUState *cpu)
> >
> >      assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
> >
> > +    if (!env->tsc_valid) {
> > +        whpx_get_tsc(cpu);
> > +        env->tsc_valid =3D !runstate_is_running();
> > +    }
> > +
> >      hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
> >          whpx->partition, cpu->cpu_index,
> >          whpx_register_names,
> > @@ -492,8 +558,6 @@ static void whpx_get_registers(CPUState *cpu)
> >      idx +=3D 1;
> >
> >      /* MSRs */
> > -    assert(whpx_register_names[idx] =3D=3D WHvX64RegisterTsc);
> > -    env->tsc =3D vcxt.values[idx++].Reg64;
> >      assert(whpx_register_names[idx] =3D=3D WHvX64RegisterEfer);
> >      env->efer =3D vcxt.values[idx++].Reg64;
> >  #ifdef TARGET_X86_64
> > @@ -896,7 +960,7 @@ static int whpx_vcpu_run(CPUState *cpu)
> >
> >      do {
> >          if (cpu->vcpu_dirty) {
> > -            whpx_set_registers(cpu);
> > +            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
> >              cpu->vcpu_dirty =3D false;
> >          }
> >
> > @@ -1074,14 +1138,14 @@ static void do_whpx_cpu_synchronize_state(CPUSt=
ate *cpu, run_on_cpu_data arg)
> >  static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
> >                                                 run_on_cpu_data arg)
> >  {
> > -    whpx_set_registers(cpu);
> > +    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
> >      cpu->vcpu_dirty =3D false;
> >  }
> >
> >  static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
> >                                                run_on_cpu_data arg)
> >  {
> > -    whpx_set_registers(cpu);
> > +    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
> >      cpu->vcpu_dirty =3D false;
> >  }
> >
> > @@ -1123,6 +1187,15 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *c=
pu)
> >
> >  static Error *whpx_migration_blocker;
> >
> > +static void whpx_cpu_update_state(void *opaque, int running, RunState =
state)
> > +{
> > +    CPUX86State *env =3D opaque;
> > +
> > +    if (running) {
> > +        env->tsc_valid =3D false;
> > +    }
> > +}
> > +
> >  int whpx_init_vcpu(CPUState *cpu)
> >  {
> >      HRESULT hr;
> > @@ -1178,6 +1251,7 @@ int whpx_init_vcpu(CPUState *cpu)
> >
> >      cpu->vcpu_dirty =3D true;
> >      cpu->hax_vcpu =3D (struct hax_vcpu_state *)vcpu;
> > +    qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_p=
tr);
> >
> >      return 0;
> >  }
> > @@ -1367,6 +1441,10 @@ static bool load_whp_dispatch_fns(HMODULE *handl=
e,
> >
> >      #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
> >      #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
> > +    #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signat=
ure) \
> > +        whp_dispatch.function_name =3D \
> > +            (function_name ## _t)GetProcAddress(hLib, #function_name);=
 \
> > +
> >      #define WHP_LOAD_FIELD(return_type, function_name, signature) \
> >          whp_dispatch.function_name =3D \
> >              (function_name ## _t)GetProcAddress(hLib, #function_name);=
 \
> > @@ -1394,6 +1472,11 @@ static bool load_whp_dispatch_fns(HMODULE *handl=
e,
> >          WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
> >          LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
> >          break;
> > +
> > +    case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
> > +        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
> > +        LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIO=
NAL)
> > +        break;
> >      }
> >
> >      *handle =3D hLib;
> > @@ -1554,6 +1637,8 @@ bool init_whp_dispatch(void)
> >          goto error;
> >      }
> >
> > +    assert(load_whp_dispatch_fns(&hWinHvPlatform,
> > +        WINHV_PLATFORM_FNS_SUPPLEMENTAL));
> >      whp_dispatch_initialized =3D true;
> >
> >      return true;
> >


