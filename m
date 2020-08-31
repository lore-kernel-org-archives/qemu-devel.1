Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEEDC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B462073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BHTWGZ7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B462073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCtNM-00043j-O9
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1kCtMe-0003aB-Kl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:37:28 -0400
Received: from mail-sn1nam02on0709.outbound.protection.outlook.com
 ([2a01:111:f400:fe44::709]:49577
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1kCtMb-0008TE-PF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:37:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPXTjnzPY1reKylep3VQcazHCkUngf48e9v/TX3z6+xr8wzvp6Wp0WNBDl/Dg54pHi9axXnyZ3VtHZ0OFXXlNgO+g+dATQUSi1WnsDp9UK+Nlw+RfnGI6TXFxp4ijtUpv8ygXsG0I1fMn0vIsZlu41U2jgs/zI+/dExxDCRToX0UZucOvWgmJmiTCxEA5LtDE5K1k6kkKHXPs0jqvkVlRU+irCYm+2zkLmkCBZJPfZ253EXmPs8HuxYneH1CnJ1vgz2ynhcqT859wzNfYTFBJIiIIPpl2eCMKQDbu/VFIW4K/ts0gPuv4XhzSsXv2KuuaHxD7yPJb2QQpO+IG9YB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DsiTMT33P62fBwPvhROtt+T01qe1lXwINGtzxV2e1A=;
 b=Rrz3jaA2PI6M8SekC/qoRq3Djs35HmnyqUUiKf8Ee3EVfaH7VXGl2aEMrSIldR7dJMFsBBtyoi4AzXQEz3Pqa4kozhE8DfvQ2QoZ2XqVEtJLgsSlGNiCnMAnO8uLoc1Rn3oN7c49LLZ/jIYwgaJWg/omd50J/T3d03HncDYEdAQNcnXpUlLCvQtb50HwX3TdzgjcE4V1fXF/QoW6BIAaaWJnPE0kixrI4R08NR8F/nb2JYXt6OzbY4eiHezbM1zbN2zw7bl7c2ZvW2hm7OXIyS/xbTLOnb62pnfHYJ6uyUGFqgrplScn2Ufu8mcm7IMRiiufyiG1Nye20IP4h3yrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DsiTMT33P62fBwPvhROtt+T01qe1lXwINGtzxV2e1A=;
 b=BHTWGZ7R5Ott/u+/1NBcSvGKOTdUNJpzrQsKYnMThy0nblEdqmevlmXgF+lPQGe581/jHTRG1bWRkDYUd4SlGgApsjwonll8Z3knxQgmdfml73Mr0M5T3z40WmC5BP+RIbsb4NJa06q8z5kagzBqlC9VoQHxd333q4z3efj4Pho=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1054.namprd21.prod.outlook.com
 (2603:10b6:805:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.6; Mon, 31 Aug
 2020 23:32:21 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953%9]) with mapi id 15.20.3326.016; Mon, 31 Aug 2020
 23:32:21 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: RE: [PATCH] WHPX: vmware cpuid leaf for tsc and apic frequency
Thread-Topic: [PATCH] WHPX: vmware cpuid leaf for tsc and apic frequency
Thread-Index: AdZmvkwMdobd7GWITmu6pdxDKVKTrwZMI2GA
Date: Mon, 31 Aug 2020 23:32:21 +0000
Message-ID: <SN4PR2101MB0880639FEAA957A1A3FE26ECC0510@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08808DFDDC3F442BBEAADFF4C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB08808DFDDC3F442BBEAADFF4C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:3924:9b24:397f:b829]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fafe428d-ae69-4fce-db3b-08d84e061bfb
x-ms-traffictypediagnostic: SN6PR2101MB1054:
x-microsoft-antispam-prvs: <SN6PR2101MB1054FAB51ED8D81DF9D23243C0510@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6f3tr24lPmea6rVMl41V8luV1BBysaUlZvyeko2f66pizrKgLTU1iMVUjirar4rMUAFmg0AHBjbltPqNqXdfK3nq37cvRj8b+NOXqX47AW4+Gneo3HxJdW9ym16T1tmAmGeZIrIw4OVQuLpwIYUGz7yxhXOlNPB5ZCVudqa2uMhD0ktNZbrVLZBFgwNzVvcxku764q36dsWh84mz9brQH7+V1MGFLPgJOvnC1kbHGjmGtOZD9qc2WVO41aR0EqFKqwM/RvL+5KEgeeYIuD5ycuhhboQPXCySihLnDTLePuL9yur/AORz4HDf4mkcndj/CO7lw4bhsXJF3XN555R7ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(53546011)(7696005)(6506007)(10290500003)(186003)(8936002)(66446008)(64756008)(5660300002)(83380400001)(66946007)(66476007)(8676002)(76116006)(86362001)(66556008)(2906002)(9686003)(55016002)(52536014)(110136005)(82960400001)(478600001)(54906003)(82950400001)(33656002)(8990500004)(316002)(4326008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kXYrPzYg6Hwfut2dt6pUxx4+lGfVecY/NCchOPXJLjxbnAQqq94T376OJDA0Rz7onSA6jB8uzq7cpyj/R8S3uJgPCDJFXstw55UzoLfsr35gd4LsTjXWLeGMt/7K0hXJTINt93B6Nwg4+k1Vu0vXu/Q1oOGu5lNRdeah4Y/odit2RCo9x/j6h03404hrb60wh+bog7dLpEfe9noK5X+2mxVoe+l7a3P85DvhIkDvLVAhbsn5ruzfAnFzhkdhqx9DpYYdCqtJdZ9B9VCNcu/QbnxJYON4eVoufwp3thicv2rIcpkmY5zL5ijg0D473Citc6VNPTKzZ9Z+0+HVwSB4aHKi+0n05bfgJqABpOQd1F6TUzgDpO+AzqeCi7MD77VnpLutsuljKHvZcRLO7yQaXPh1zCb7+puOpxbJ3sVHHFDbRVQsUS6L5gdMTLudoSKG8IDN0yFxB35hajxkcukwsLL7Zgrc9mmIx5KQGME4k0BXrFPSeInZLkZsL+qB5ZSv0IHAMY2/EveWToK9T570riCNGeihYWTNtvlXQDNVmIDkLKFHh9SFdzLqHr+grTdUpmKANo/0sniIJMXjU9Wn+FcyZ14X9auILTLryu6uVGOlzfCxmzvQm0YroO08nDxt6G/v9pn8YjSFl4qdZwNvfbbn8lyKZ0MjnmBqC6CqHTKv5FN3EYbCV3001mzB9TF1gvZQXndVuYWVxZN4JijvmQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe428d-ae69-4fce-db3b-08d84e061bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 23:32:21.8366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhu717CSKqI/hpbjL9fOrjaYkz1oPITOUz9bfxfxsenV7CNXATyp89xABzyRYGFijCy3Xhz7L5L/6zw/dPnUgz3D+eXkUco+ripFA4JuehI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Received-SPF: pass client-ip=2a01:111:f400:fe44::709;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Can I please get some eyes on this?

> -----Original Message-----
> From: Sunil Muthuswamy
> Sent: Thursday, July 30, 2020 3:11 PM
> To: Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.n=
et>; Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org; Stefan Weil <sw@weilnetz.de>
> Subject: [PATCH] WHPX: vmware cpuid leaf for tsc and apic frequency
>=20
> Newer versions of WHPX provide the capability to query the tsc
> and apic frequency. Expose these through the vmware cpuid leaf.
> This patch doesnt support setting the tsc frequency; that will
> come as a separate fix.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  target/i386/whp-dispatch.h |  3 +-
>  target/i386/whpx-all.c     | 94 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 86 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
> index e4695c349f..b18aba20ed 100644
> --- a/target/i386/whp-dispatch.h
> +++ b/target/i386/whp-dispatch.h
> @@ -2,10 +2,11 @@
>  #define WHP_DISPATCH_H
>=20
>  #include <windows.h>
> -
>  #include <WinHvPlatform.h>
>  #include <WinHvEmulation.h>
>=20
> +#define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
> +
>  #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
>    X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID=
* CapabilityBuffer, UINT32
> CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
>    X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index c78baac6df..da4c135925 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -27,6 +27,8 @@
>  #include <WinHvPlatform.h>
>  #include <WinHvEmulation.h>
>=20
> +#define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
> +
>  struct whpx_state {
>      uint64_t mem_quota;
>      WHV_PARTITION_HANDLE partition;
> @@ -1061,6 +1063,18 @@ static int whpx_vcpu_run(CPUState *cpu)
>              cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&r=
bx,
>                  (UINT32 *)&rcx, (UINT32 *)&rdx);
>              switch (cpuid_fn) {
> +            case 0x40000000:
> +                /* Expose the vmware cpu frequency cpuid leaf */
> +                rax =3D 0x40000010;
> +                rbx =3D rcx =3D rdx =3D 0;
> +                break;
> +
> +            case 0x40000010:
> +                rax =3D env->tsc_khz;
> +                rbx =3D env->apic_bus_freq / 1000; /* Hz to KHz */
> +                rcx =3D rdx =3D 0;
> +                break;
> +
>              case 0x80000001:
>                  /* Remove any support of OSVW */
>                  rcx &=3D ~CPUID_EXT3_OSVW;
> @@ -1193,6 +1207,10 @@ int whpx_init_vcpu(CPUState *cpu)
>      struct whpx_state *whpx =3D &whpx_global;
>      struct whpx_vcpu *vcpu;
>      Error *local_error =3D NULL;
> +    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
> +    X86CPU *x86_cpu =3D X86_CPU(cpu);
> +    UINT64 freq =3D 0;
> +    int ret;
>=20
>      /* Add migration blockers for all unsupported features of the
>       * Windows Hypervisor Platform
> @@ -1207,7 +1225,8 @@ int whpx_init_vcpu(CPUState *cpu)
>              error_report_err(local_error);
>              migrate_del_blocker(whpx_migration_blocker);
>              error_free(whpx_migration_blocker);
> -            return -EINVAL;
> +            ret =3D -EINVAL;
> +            goto error;
>          }
>      }
>=20
> @@ -1215,7 +1234,8 @@ int whpx_init_vcpu(CPUState *cpu)
>=20
>      if (!vcpu) {
>          error_report("WHPX: Failed to allocte VCPU context.");
> -        return -ENOMEM;
> +        ret =3D -ENOMEM;
> +        goto error;
>      }
>=20
>      hr =3D whp_dispatch.WHvEmulatorCreateEmulator(
> @@ -1224,8 +1244,8 @@ int whpx_init_vcpu(CPUState *cpu)
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to setup instruction completion suppo=
rt,"
>                       " hr=3D%08lx", hr);
> -        g_free(vcpu);
> -        return -EINVAL;
> +        ret =3D -EINVAL;
> +        goto error;
>      }
>=20
>      hr =3D whp_dispatch.WHvCreateVirtualProcessor(
> @@ -1234,17 +1254,72 @@ int whpx_init_vcpu(CPUState *cpu)
>          error_report("WHPX: Failed to create a virtual processor,"
>                       " hr=3D%08lx", hr);
>          whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
> -        g_free(vcpu);
> -        return -EINVAL;
> +        ret =3D -EINVAL;
> +        goto error;
>      }
>=20
> -    vcpu->interruptable =3D true;
> +    /*
> +     * vcpu's TSC frequency is either specified by user, or use the valu=
e
> +     * provided by Hyper-V if the former is not present. In the latter c=
ase, we
> +     * query it from Hyper-V and record in env->tsc_khz, so that vcpu's =
TSC
> +     * frequency can be migrated later via this field.
> +     */
> +    if (!env->tsc_khz) {
> +        hr =3D whp_dispatch.WHvGetCapability(
> +            WHvCapabilityCodeProcessorClockFrequency, &freq, sizeof(freq=
),
> +                NULL);
> +        if (hr !=3D WHV_E_UNKNOWN_CAPABILITY) {
> +            if (FAILED(hr)) {
> +                printf("WHPX: Failed to query tsc frequency, hr=3D0x%08l=
x\n", hr);
> +            } else {
> +                env->tsc_khz =3D freq / 1000; /* Hz to KHz */
> +            }
> +        }
> +    }
>=20
> +    env->apic_bus_freq =3D HYPERV_APIC_BUS_FREQUENCY;
> +    hr =3D whp_dispatch.WHvGetCapability(
> +        WHvCapabilityCodeInterruptClockFrequency, &freq, sizeof(freq), N=
ULL);
> +    if (hr !=3D WHV_E_UNKNOWN_CAPABILITY) {
> +        if (FAILED(hr)) {
> +            printf("WHPX: Failed to query apic bus frequency hr=3D0x%08l=
x\n", hr);
> +        } else {
> +            env->apic_bus_freq =3D freq;
> +        }
> +    }
> +
> +    /*
> +     * If the vmware cpuid frequency leaf option is set, and we have a v=
alid
> +     * tsc value, trap the corresponding cpuid's.
> +     */
> +    if (x86_cpu->vmware_cpuid_freq && env->tsc_khz) {
> +        UINT32 cpuidExitList[] =3D {1, 0x80000001, 0x40000000, 0x4000001=
0};
> +
> +        hr =3D whp_dispatch.WHvSetPartitionProperty(
> +                whpx->partition,
> +                WHvPartitionPropertyCodeCpuidExitList,
> +                cpuidExitList,
> +                RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
> +
> +        if (FAILED(hr)) {
> +            error_report("WHPX: Failed to set partition CpuidExitList hr=
=3D%08lx",
> +                        hr);
> +            ret =3D -EINVAL;
> +            goto error;
> +        }
> +    }
> +
> +    vcpu->interruptable =3D true;
>      cpu->vcpu_dirty =3D true;
>      cpu->hax_vcpu =3D (struct hax_vcpu_state *)vcpu;
>      qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr=
);
>=20
>      return 0;
> +
> +error:
> +    g_free(vcpu);
> +
> +    return ret;
>  }
>=20
>  int whpx_vcpu_exec(CPUState *cpu)
> @@ -1493,6 +1568,7 @@ static int whpx_accel_init(MachineState *ms)
>      WHV_CAPABILITY whpx_cap;
>      UINT32 whpx_cap_size;
>      WHV_PARTITION_PROPERTY prop;
> +    UINT32 cpuidExitList[] =3D {1, 0x80000001};
>=20
>      whpx =3D &whpx_global;
>=20
> @@ -1551,7 +1627,6 @@ static int whpx_accel_init(MachineState *ms)
>          goto error;
>      }
>=20
> -    UINT32 cpuidExitList[] =3D {1, 0x80000001};
>      hr =3D whp_dispatch.WHvSetPartitionProperty(
>          whpx->partition,
>          WHvPartitionPropertyCodeCpuidExitList,
> @@ -1579,14 +1654,13 @@ static int whpx_accel_init(MachineState *ms)
>      printf("Windows Hypervisor Platform accelerator is operational\n");
>      return 0;
>=20
> -  error:
> +error:
>=20
>      if (NULL !=3D whpx->partition) {
>          whp_dispatch.WHvDeletePartition(whpx->partition);
>          whpx->partition =3D NULL;
>      }
>=20
> -
>      return ret;
>  }
>=20
> --
> 2.25.1


