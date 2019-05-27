Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DAFC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1074206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aUZkdN3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1074206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47457 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVHwW-0007g3-VX
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 11:53:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hVHva-0007MP-Fm
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hVHvY-0008GN-8b
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:52:46 -0400
Received: from mail-bgr052101135066.outbound.protection.outlook.com
	([52.101.135.66]:40502
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hVHvY-0008Fq-27
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hQz23BovcS43dVdN4sS4MmBG0UNoUjCm5GyJfQSRarE=;
	b=aUZkdN3w9SzUiFfNzULQH1jMZ3lmu1XZsDfslc3d4frn9M9vyusk/YGINHqULePr2ozzmSc3ggg8w/B6TGWBBsYaP4wxMsrOsaBqnaUfEqNR6fTTR/U76j2opG0TzViLa2mTJFXQ2yKOGsDVEMxrGmu4Rv2Lg2V6ElfpsGfxLIY=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4540.eurprd08.prod.outlook.com (20.179.44.145) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Mon, 27 May 2019 15:52:34 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1922.021;
	Mon, 27 May 2019 15:52:34 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Thread-Topic: [PATCH v2 2/9] i386/kvm: add support for
	KVM_GET_SUPPORTED_HV_CPUID
Thread-Index: AQHVDLuPR8/P/4m4tkapnVzEeNR8W6Z/LuuA
Date: Mon, 27 May 2019 15:52:34 +0000
Message-ID: <20190527155231.GB2362@rkaganb.sw.ru>
References: <20190517141924.19024-1-vkuznets@redhat.com>
	<20190517141924.19024-3-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-3-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
	=09Vitaly_Kuznetsov_<vk?=
	=?iso-8859-1?Q?uznets@redhat.com>, _qemu-devel@nongnu.org,
	=09Paolo_Bonzini?= =?iso-8859-1?Q?_<pbonzini@redhat.com>,
	=09Richard_Henderson_<rth@twiddle.n?=
	=?iso-8859-1?Q?et>, =09Eduardo_Habkost_<ehabkost@redhat.com>,
	=09Marcelo_To?= =?iso-8859-1?Q?satti_<mtosatti@redhat.com>,
	=09"Dr_._David_Alan_Gilbert"_<?=
	=?iso-8859-1?Q?dgilbert@redhat.com>,
	=09Daniel_P_._Berrang=E9_<berrange@re?=
	=?iso-8859-1?Q?dhat.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::20)
	To DBBPR08MB4854.eurprd08.prod.outlook.com
	(2603:10a6:10:da::13)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 585fa3fc-ff1b-48ac-0231-08d6e2bb55c4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DBBPR08MB4540; 
x-ms-traffictypediagnostic: DBBPR08MB4540:|DBBPR08MB4540:
x-microsoft-antispam-prvs: <DBBPR08MB4540F13361650707987C4DF7C91D0@DBBPR08MB4540.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(39850400004)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(14454004)(25786009)(73956011)(476003)(68736007)(66946007)(102836004)(6512007)(6436002)(186003)(4326008)(66476007)(66556008)(64756008)(66446008)(76176011)(58126008)(6486002)(54906003)(486006)(52116002)(26005)(9686003)(6116002)(3846002)(6506007)(386003)(316002)(99286004)(6916009)(478600001)(229853002)(305945005)(7736002)(6246003)(53936002)(53946003)(36756003)(8676002)(81156014)(81166006)(8936002)(446003)(11346002)(1076003)(71200400001)(71190400001)(86362001)(14444005)(256004)(33656002)(5660300002)(30864003)(66066001)(2906002)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:DBBPR08MB4540;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sFgVprFEqQw2LL1dpWKBxS+L40LED6V0dPaXC9ou1ZPduS4DzhTDXEEXBerXni9GxlLsvNGhzhPpkX5DryxRlHoJFk+1HWrNriC1Kzr84LMUPqpH7ESwPcddzCEBsKG+p1xg4qUKxu8QZkfNm3vOzf2usrWNHoqM4RLq/G+xqR7fdaG9rWIPBudra3Vr23iQCykcZKTA5fB0ov2b42HlM/y/CKCJwrFYu7xEuqZtv2jVQfq7bhoAU1jWXC+gcg9VwgpZAdGt/LIG2x08S6ZKRDu/F9pKkc7cvlETpTXSs2jUBcaQqAb++nhKnRfJ35s/hcXuVxxflmDgTFumWjpRli7qOx0ybCWugRTON/cVBhPN0ekKbYRVVDhfDgsyYm+GJTfeF/OnivmsccEc/U1kvOQ9hur1/mnnu3zIetX/0aACmMDoAb9t2RK6YtEn8bWLt33B0vicsw/vVQfeqicl90Jp/ccj+ZblVpBJTH7eqG1vElqduk2U1JsgRukjVDhg
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DB5F524CE9D82241A7F7A927E7CE3A5A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585fa3fc-ff1b-48ac-0231-08d6e2bb55c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 15:52:34.7793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4540
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.135.66
Subject: Re: [Qemu-devel] [PATCH v2 2/9] i386/kvm: add support for
 KVM_GET_SUPPORTED_HV_CPUID
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 04:19:17PM +0200, Vitaly Kuznetsov wrote:
> KVM now supports reporting supported Hyper-V features through CPUID
> (KVM_GET_SUPPORTED_HV_CPUID ioctl). Going forward, this is going to be
> the only way to announce new functionality and this has already happened
> with Direct Mode stimers.
>=20
> While we could just support KVM_GET_SUPPORTED_HV_CPUID for new features,
> it seems to be beneficial to use it for all Hyper-V enlightenments when
> possible. This way we can implement 'hv-all' pass-through mode giving the
> guest all supported Hyper-V features even when QEMU knows nothing about
> them.
>=20
> Implementation-wise we create a new kvm_hyperv_properties structure
> defining Hyper-V features, get_supported_hv_cpuid()/
> get_supported_hv_cpuid_legacy() returning the supported CPUID set and
> a bit over-engineered hv_cpuid_check_and_set() which we will also be
> used to set cpu->hyperv_* properties for 'hv-all' mode.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/kvm.c | 474 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 356 insertions(+), 118 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3daac1e4f4..6ead422efa 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -684,156 +684,394 @@ static bool tsc_is_stable_and_known(CPUX86State *=
env)
>          || env->user_tsc_khz;
>  }
> =20
> -static int hyperv_handle_properties(CPUState *cs)
> +static struct {
> +    const char *desc;
> +    struct {
> +        uint32_t fw;
> +        uint32_t bits;
> +    } flags[2];
> +} kvm_hyperv_properties[] =3D {
> +    [HYPERV_FEAT_RELAXED] =3D {
> +        .desc =3D "relaxed timing (hv-relaxed)",

I'd still like to avoid repeating the feature names.

> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_HYPERCALL_AVAILABLE},
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_RELAXED_TIMING_RECOMMENDED}
> +        }
> +    },
> +    [HYPERV_FEAT_VAPIC] =3D {
> +        .desc =3D "virtual APIC (hv-vapic)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE=
},
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_APIC_ACCESS_RECOMMENDED}
> +        }
> +    },
> +    [HYPERV_FEAT_TIME] =3D {
> +        .desc =3D "clocksources (hv-time)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILA=
BLE |
> +             HV_REFERENCE_TSC_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_CRASH] =3D {
> +        .desc =3D "crash MSRs (hv-crash)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EDX,
> +             .bits =3D HV_GUEST_CRASH_MSR_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_RESET] =3D {
> +        .desc =3D "reset MSR (hv-reset)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_RESET_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_VPINDEX] =3D {
> +        .desc =3D "VP_INDEX MSR (hv-vpindex)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_VP_INDEX_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_RUNTIME] =3D {
> +        .desc =3D "VP_RUNTIME MSR (hv-runtime)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_VP_RUNTIME_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_SYNIC] =3D {
> +        .desc =3D "synthetic interrupt controller (hv-synic)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_SYNIC_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_STIMER] =3D {
> +        .desc =3D "synthetic timers (hv-stimer)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_SYNTIMERS_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_FREQUENCIES] =3D {
> +        .desc =3D "frequency MSRs (hv-frequencies)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_ACCESS_FREQUENCY_MSRS},
> +            {.fw =3D FEAT_HYPERV_EDX,
> +             .bits =3D HV_FREQUENCY_MSRS_AVAILABLE}
> +        }
> +    },
> +    [HYPERV_FEAT_REENLIGHTENMENT] =3D {
> +        .desc =3D "reenlightenment MSRs (hv-reenlightenment)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_ACCESS_REENLIGHTENMENTS_CONTROL}
> +        }
> +    },
> +    [HYPERV_FEAT_TLBFLUSH] =3D {
> +        .desc =3D "paravirtualized TLB flush (hv-tlbflush)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_REMOTE_TLB_FLUSH_RECOMMENDED |
> +             HV_EX_PROCESSOR_MASKS_RECOMMENDED}
> +        }
> +    },
> +    [HYPERV_FEAT_EVMCS] =3D {
> +        .desc =3D "enlightened VMCS (hv-evmcs)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_ENLIGHTENED_VMCS_RECOMMENDED}
> +        }
> +    },
> +    [HYPERV_FEAT_IPI] =3D {
> +        .desc =3D "paravirtualized IPI (hv-ipi)",
> +        .flags =3D {
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_CLUSTER_IPI_RECOMMENDED |
> +             HV_EX_PROCESSOR_MASKS_RECOMMENDED}
> +        }
> +    },
> +};
> +
> +static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
> +{
> +    struct kvm_cpuid2 *cpuid;
> +    int r, size;
> +
> +    size =3D sizeof(*cpuid) + max * sizeof(*cpuid->entries);
> +    cpuid =3D g_malloc0(size);
> +    cpuid->nent =3D max;
> +
> +    r =3D kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
> +    if (r =3D=3D 0 && cpuid->nent >=3D max) {
> +        r =3D -E2BIG;
> +    }
> +    if (r < 0) {
> +        if (r =3D=3D -E2BIG) {
> +            g_free(cpuid);
> +            return NULL;
> +        } else {
> +            fprintf(stderr, "KVM_GET_SUPPORTED_HV_CPUID failed: %s\n",
> +                    strerror(-r));
> +            exit(1);
> +        }
> +    }
> +    return cpuid;
> +}
> +
> +/*
> + * Run KVM_GET_SUPPORTED_HV_CPUID ioctl(), allocating a buffer large eno=
ugh
> + * for all entries.
> + */
> +static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
> +{
> +    struct kvm_cpuid2 *cpuid;
> +    int max =3D 7; /* 0x40000000..0x40000005, 0x4000000A */
> +
> +    /*
> +     * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails wi=
th
> +     * -E2BIG, however, it doesn't report back the right size. Keep incr=
easing
> +     * it and re-trying until we succeed.
> +     */

I'm still missing the idea of reiterating more than once: the ioctl
returns the actual size of the array.

> +    while ((cpuid =3D try_get_hv_cpuid(cs, max)) =3D=3D NULL) {
> +        max++;
> +    }
> +    return cpuid;
> +}
> +
> +/*
> + * When KVM_GET_SUPPORTED_HV_CPUID is not supported we fill CPUID featur=
e
> + * leaves from KVM_CAP_HYPERV* and present MSRs data.
> + */
> +static struct kvm_cpuid2 *get_supported_hv_cpuid_legacy(CPUState *cs)
>  {
>      X86CPU *cpu =3D X86_CPU(cs);
> -    CPUX86State *env =3D &cpu->env;
> +    struct kvm_cpuid2 *cpuid;
> +    struct kvm_cpuid_entry2 *entry_feat, *entry_recomm;
> +
> +    /* HV_CPUID_FEATURES, HV_CPUID_ENLIGHTMENT_INFO */
> +    cpuid =3D g_malloc0(sizeof(*cpuid) + 2 * sizeof(*cpuid->entries));
> +    cpuid->nent =3D 2;
> +
> +    /* HV_CPUID_VENDOR_AND_MAX_FUNCTIONS */
> +    entry_feat =3D &cpuid->entries[0];
> +    entry_feat->function =3D HV_CPUID_FEATURES;
> =20
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
> +    entry_recomm =3D &cpuid->entries[1];
> +    entry_recomm->function =3D HV_CPUID_ENLIGHTMENT_INFO;
> +    entry_recomm->ebx =3D cpu->hyperv_spinlock_attempts;
> +
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0) {
> +        entry_feat->eax |=3D HV_HYPERCALL_AVAILABLE;
> +        entry_feat->eax |=3D HV_APIC_ACCESS_AVAILABLE;
> +        entry_feat->edx |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
> +        entry_recomm->eax |=3D HV_RELAXED_TIMING_RECOMMENDED;
> +        entry_recomm->eax |=3D HV_APIC_ACCESS_RECOMMENDED;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_APIC_ACCESS_AVAILABLE;
> +
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) > 0) {
> +        entry_feat->eax |=3D HV_TIME_REF_COUNT_AVAILABLE;
> +        entry_feat->eax |=3D HV_REFERENCE_TSC_AVAILABLE;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TIME)) {
> -        if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <=3D=
 0) {
> -            fprintf(stderr, "Hyper-V clocksources "
> -                    "(requested by 'hv-time' cpu flag) "
> -                    "are not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_TIME_REF_COUNT_AVAILABLE;
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_REFERENCE_TSC_AVAILABLE;
> +
> +    if (has_msr_hv_frequencies) {
> +        entry_feat->eax |=3D HV_ACCESS_FREQUENCY_MSRS;
> +        entry_feat->edx |=3D HV_FREQUENCY_MSRS_AVAILABLE;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_FREQUENCIES)) {
> -        if (!has_msr_hv_frequencies) {
> -            fprintf(stderr, "Hyper-V frequency MSRs "
> -                    "(requested by 'hv-frequencies' cpu flag) "
> -                    "are not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_FREQUENCY_MSRS;
> -        env->features[FEAT_HYPERV_EDX] |=3D HV_FREQUENCY_MSRS_AVAILABLE;
> +
> +    if (has_msr_hv_crash) {
> +        entry_feat->edx |=3D HV_GUEST_CRASH_MSR_AVAILABLE;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
> -        if (!has_msr_hv_crash) {
> -            fprintf(stderr, "Hyper-V crash MSRs "
> -                    "(requested by 'hv-crash' cpu flag) "
> -                    "are not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EDX] |=3D HV_GUEST_CRASH_MSR_AVAILABLE=
;
> +
> +    if (has_msr_hv_reenlightenment) {
> +        entry_feat->eax |=3D HV_ACCESS_REENLIGHTENMENTS_CONTROL;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_REENLIGHTENMENT)) {
> -        if (!has_msr_hv_reenlightenment) {
> -            fprintf(stderr,
> -                    "Hyper-V Reenlightenment MSRs "
> -                    "(requested by 'hv-reenlightenment' cpu flag) "
> -                    "are not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_REENLIGHTENMENTS_C=
ONTROL;
> +
> +    if (has_msr_hv_reset) {
> +        entry_feat->eax |=3D HV_RESET_AVAILABLE;
>      }
> -    env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RESET)) {
> -        if (!has_msr_hv_reset) {
> -            fprintf(stderr, "Hyper-V reset MSR "
> -                    "(requested by 'hv-reset' cpu flag) "
> -                    "is not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_RESET_AVAILABLE;
> +
> +    if (has_msr_hv_vpindex) {
> +        entry_feat->eax |=3D HV_VP_INDEX_AVAILABLE;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
> -        if (!has_msr_hv_vpindex) {
> -            fprintf(stderr, "Hyper-V VP_INDEX MSR "
> -                    "(requested by 'hv-vpindex' cpu flag) "
> -                    "is not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_VP_INDEX_AVAILABLE;
> +
> +    if (has_msr_hv_runtime) {
> +        entry_feat->eax |=3D HV_VP_RUNTIME_AVAILABLE;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RUNTIME)) {
> -        if (!has_msr_hv_runtime) {
> -            fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
> -                    "(requested by 'hv-runtime' cpu flag) "
> -                    "is not supported by kernel\n");
> -            return -ENOSYS;
> +
> +    if (has_msr_hv_synic) {
> +        unsigned int cap =3D cpu->hyperv_synic_kvm_only ?
> +            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
> +
> +        if (kvm_check_extension(cs->kvm_state, cap) > 0) {
> +            entry_feat->eax |=3D HV_SYNIC_AVAILABLE;
>          }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_VP_RUNTIME_AVAILABLE;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
> -        unsigned int cap =3D KVM_CAP_HYPERV_SYNIC;
> -        if (!cpu->hyperv_synic_kvm_only) {
> -            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
> -                fprintf(stderr, "Hyper-V SynIC "
> -                        "(requested by 'hv-synic' cpu flag) "
> -                        "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
> -            return -ENOSYS;
> -            }
> -            cap =3D KVM_CAP_HYPERV_SYNIC2;
> -        }
> =20
> -        if (!has_msr_hv_synic || !kvm_check_extension(cs->kvm_state, cap=
)) {
> -            fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu =
flag) "
> -                    "is not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> +    if (has_msr_hv_stimer) {
> +        entry_feat->eax |=3D HV_SYNTIMERS_AVAILABLE;
> +    }
> =20
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_SYNIC_AVAILABLE;
> +    if (kvm_check_extension(cs->kvm_state,
> +                            KVM_CAP_HYPERV_TLBFLUSH) > 0) {
> +        entry_recomm->eax |=3D HV_REMOTE_TLB_FLUSH_RECOMMENDED;
> +        entry_recomm->eax |=3D HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_STIMER)) {
> -        if (!has_msr_hv_stimer) {
> -            fprintf(stderr, "Hyper-V timers aren't supported by kernel\n=
");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_SYNTIMERS_AVAILABLE;
> +
> +    if (kvm_check_extension(cs->kvm_state,
> +                            KVM_CAP_HYPERV_ENLIGHTENED_VMCS) > 0) {
> +        entry_recomm->eax |=3D HV_ENLIGHTENED_VMCS_RECOMMENDED;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_RELAXED_TIMING_RECOMME=
NDED;
> +
> +    if (kvm_check_extension(cs->kvm_state,
> +                            KVM_CAP_HYPERV_SEND_IPI) > 0) {
> +        entry_recomm->eax |=3D HV_CLUSTER_IPI_RECOMMENDED;
> +        entry_recomm->eax |=3D HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_APIC_ACCESS_RECOMMENDE=
D;
> -    }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
> -        if (kvm_check_extension(cs->kvm_state,
> -                                KVM_CAP_HYPERV_TLBFLUSH) <=3D 0) {
> -            fprintf(stderr, "Hyper-V TLB flush support "
> -                    "(requested by 'hv-tlbflush' cpu flag) "
> -                    " is not supported by kernel\n");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_REMOTE_TLB_FLUSH_RECOM=
MENDED;
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
> +
> +    return cpuid;
> +}
> +
> +static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r=
)
> +{
> +    struct kvm_cpuid_entry2 *entry;
> +    uint32_t func;
> +    int reg;
> +
> +    switch (fw) {
> +    case FEAT_HYPERV_EAX:
> +        reg =3D R_EAX;
> +        func =3D HV_CPUID_FEATURES;
> +        break;
> +    case FEAT_HYPERV_EDX:
> +        reg =3D R_EDX;
> +        func =3D HV_CPUID_FEATURES;
> +        break;
> +    case FEAT_HV_RECOMM_EAX:
> +        reg =3D R_EAX;
> +        func =3D HV_CPUID_ENLIGHTMENT_INFO;
> +        break;
> +    default:
> +        return -EINVAL;
>      }
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_IPI)) {
> -        if (kvm_check_extension(cs->kvm_state,
> -                                KVM_CAP_HYPERV_SEND_IPI) <=3D 0) {
> -            fprintf(stderr, "Hyper-V IPI send support "
> -                    "(requested by 'hv-ipi' cpu flag) "
> -                    " is not supported by kernel\n");
> -            return -ENOSYS;
> +
> +    entry =3D cpuid_find_entry(cpuid, func, 0);
> +    if (!entry) {
> +        return -ENOENT;
> +    }
> +
> +    switch (reg) {
> +    case R_EAX:
> +        *r =3D entry->eax;
> +        break;
> +    case R_EDX:
> +        *r =3D entry->edx;
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid=
,
> +                                  int feature)
> +{
> +    X86CPU *cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &cpu->env;
> +    uint32_t r, fw, bits;;
> +    int i;
> +
> +    if (!hyperv_feat_enabled(cpu, feature)) {
> +        return 0;
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); =
i++) {
> +        fw =3D kvm_hyperv_properties[feature].flags[i].fw;
> +        bits =3D kvm_hyperv_properties[feature].flags[i].bits;
> +
> +        if (!fw) {
> +            continue;
>          }
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_CLUSTER_IPI_RECOMMENDE=
D;
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
> +
> +        if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) !=3D bits) {
> +            fprintf(stderr,
> +                    "Hyper-V %s is not supported by kernel\n",
> +                    kvm_hyperv_properties[feature].desc);
> +            return 1;
> +        }
> +
> +        env->features[fw] |=3D bits;
>      }
> +
> +    return 0;
> +}
> +
> +static int hyperv_handle_properties(CPUState *cs)
> +{
> +    X86CPU *cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &cpu->env;
> +    struct kvm_cpuid2 *cpuid;
> +    int r =3D 0;
> +
>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
>          uint16_t evmcs_version;
> =20
>          if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
>                                  (uintptr_t)&evmcs_version)) {
> -            fprintf(stderr, "Hyper-V Enlightened VMCS "
> -                    "(requested by 'hv-evmcs' cpu flag) "
> -                    "is not supported by kernel\n");
> +            fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
> +                    kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
>              return -ENOSYS;
>          }
>          env->features[FEAT_HV_RECOMM_EAX] |=3D HV_ENLIGHTENED_VMCS_RECOM=
MENDED;
>          env->features[FEAT_HV_NESTED_EAX] =3D evmcs_version;
>      }
> =20
> -    return 0;
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
> +        cpuid =3D get_supported_hv_cpuid(cs);
> +    } else {
> +        cpuid =3D get_supported_hv_cpuid_legacy(cs);
> +    }
> +
> +    /* Features */
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RESET);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VPINDEX);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RUNTIME);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_SYNIC);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_FREQUENCIES);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_REENLIGHTENMENT=
);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);

Can't this be expressed by a regualr for() loop?

Thanks,
Roman.

> +
> +    /* Dependencies */
> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
> +        !cpu->hyperv_synic_kvm_only &&
> +        !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
> +        fprintf(stderr, "Hyper-V %s requires %s\n",
> +                kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
> +                kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
> +        r |=3D 1;
> +    }
> +
> +    /* Not exposed by KVM but needed to make CPU hotplug in Windows work=
 */
> +    env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
> +
> +    g_free(cpuid);
> +
> +    return r ? -ENOSYS : 0;
>  }
> =20
>  static int hyperv_init_vcpu(X86CPU *cpu)
> --=20
> 2.20.1
>=20

