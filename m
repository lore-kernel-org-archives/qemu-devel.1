Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA23C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B827021855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AH51CaKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B827021855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCOYf-0000d5-Us
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 09:07:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hCOXW-0008IX-Mz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hCOXS-0002EP-Iv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:05:50 -0400
Received: from mail-bgr052101130032.outbound.protection.outlook.com
	([52.101.130.32]:4078
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hCOXP-00028W-4u
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=W/zAQO+9In5sCUyOls4HjQjOhOE4wp5ZD59VYx81UEA=;
	b=AH51CaKUH4x3wiqhtUkQqRVqwMTpewcBL//GR8Dplh0ycO0Jx3rOtaeS0Gr4VJ7yA0YPbJ7q6rmlt9Y9MBUB2nGLVDCqkCXekGtmAM2Mo8uoDPoDGAIu1Zf6f+c6RkeaG+roNmo1abj7QIMVLU0qREsx3KWAxrsrjEtMk5svEUs=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.9.147) by
	DB8PR08MB5082.eurprd08.prod.outlook.com (10.255.18.94) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Fri, 5 Apr 2019 13:05:28 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
	([fe80::b84d:109a:be51:13f]) by DB8PR08MB4092.eurprd08.prod.outlook.com
	([fe80::b84d:109a:be51:13f%4]) with mapi id 15.20.1771.016;
	Fri, 5 Apr 2019 13:05:27 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Thread-Topic: [PATCH 1/8] i386/kvm: add support for KVM_GET_SUPPORTED_HV_CPUID
Thread-Index: AQHU5jpQdzRMYyeFDU2k8zNtFf+mE6Ytk/oA
Date: Fri, 5 Apr 2019 13:05:27 +0000
Message-ID: <20190405130518.GA20411@rkaganb.sw.ru>
References: <20190329141832.22882-1-vkuznets@redhat.com>
	<20190329141832.22882-2-vkuznets@redhat.com>
In-Reply-To: <20190329141832.22882-2-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.3 (2019-02-01)
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
x-clientproxiedby: HE1PR0502CA0017.eurprd05.prod.outlook.com
	(2603:10a6:3:e3::27) To DB8PR08MB4092.eurprd08.prod.outlook.com
	(2603:10a6:10:a6::19)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4942c31-43c6-4f12-6e85-08d6b9c75f8c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB8PR08MB5082; 
x-ms-traffictypediagnostic: DB8PR08MB5082:|DB8PR08MB5082:
x-microsoft-antispam-prvs: <DB8PR08MB508224FBD0A882011829E9C6C9510@DB8PR08MB5082.eurprd08.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(346002)(376002)(366004)(39850400004)(396003)(136003)(199004)(189003)(6506007)(6436002)(33656002)(99286004)(53946003)(9686003)(97736004)(305945005)(68736007)(58126008)(54906003)(6512007)(6486002)(8676002)(53936002)(316002)(7736002)(105586002)(81156014)(106356001)(6916009)(8936002)(81166006)(229853002)(14454004)(52116002)(36756003)(6116002)(14444005)(256004)(30864003)(102836004)(66066001)(6246003)(446003)(86362001)(76176011)(386003)(4326008)(3846002)(5660300002)(486006)(1076003)(25786009)(71190400001)(2906002)(476003)(11346002)(186003)(26005)(478600001)(71200400001)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5082;
	H:DB8PR08MB4092.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: waWz/N8yncxC/3jltBZIG+o2hPjvGlaZVLE5ppEzEkVa4gznX0SqJuYyxetRb+Xb9BJ5kStqo1gbtX+3Iw5JJYQeMf4EiKVn6YLIRTDWNupDZkgCPL1Y2XaYr2mW3h1+GDbmFP+ecXrcpt0nW9Zr3kjcbm2gY5n5wzyD9D4rCWfhh+S+NCf3lsnRx6MbgRoc7dhV8YN+Nx/g9gIBaKGfJaAYUvGWclXTtfDqdg/7pNmFbWQz2H5cqrvmn6gDRUVY543j3TR05LPoA9R3388KORIUluWNvucIHOCuXBL7Glxm0OBF0TjgZo5jCKz4pNDtsxoWxj67uWN5iVcrn1zp4F1uwDaBWI/XB2PxsTwvr8sjh911cV0rg7P93J1tnrzZuun7z3udlR1UTp6U+X2aDlSrhPb4Y0rKpf/pZVSY7UMojWn+2OhWzoEQrdTWOEDzuKJj0aeamMKMu0YyKoVrh+2o5zhj85wvkIGh1xsJPO7FFtxEaQC8x0t1oEe1L2EM
Content-Type: text/plain; charset="UTF-8"
Content-ID: <65C60AAED7BF8A4DAC82514FD9574E8A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4942c31-43c6-4f12-6e85-08d6b9c75f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 13:05:27.7337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5082
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.130.32
Subject: Re: [Qemu-devel] [PATCH 1/8] i386/kvm: add support for
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405130527.51hMnrPm6Jcj_p_7lewS8Uqb4oZfcb7O8371zKHW4Ec@z>

On Fri, Mar 29, 2019 at 03:18:25PM +0100, Vitaly Kuznetsov wrote:
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
>  target/i386/kvm.c | 487 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 372 insertions(+), 115 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b29ce5c0d..9abee81998 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -700,141 +700,360 @@ static bool tsc_is_stable_and_known(CPUX86State *=
env)
>          || env->user_tsc_khz;
>  }
> =20
> -static int hyperv_handle_properties(CPUState *cs)
> +static struct {
> +    const char *name;
> +    const char *desc;
> +    struct {
> +        uint32_t fw;
> +        uint32_t bits;
> +    } flags[2];
> +} kvm_hyperv_properties[] =3D {
> +    {
> +        .name =3D "hv-relaxed",
> +        .desc =3D "relaxed timing",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_HYPERCALL_AVAILABLE},
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_RELAXED_TIMING_RECOMMENDED}
> +        }
> +    },
> +    {
> +        .name =3D "hv-vapic",
> +        .desc =3D "virtual APIC",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE=
},
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_APIC_ACCESS_RECOMMENDED}
> +        }
> +    },
> +    {
> +        .name =3D "hv-time",
> +        .desc =3D "clocksources",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILA=
BLE |
> +             HV_REFERENCE_TSC_AVAILABLE},
> +            {0}

IIRC explicit zero initializer can be omitted here: all fields that have
no explicit initializers are zeroed.

> +        }
> +    },
> +    {
> +        .name =3D "hv-frequencies",
> +        .desc =3D "frequency MSRs",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_ACCESS_FREQUENCY_MSRS},
> +            {.fw =3D FEAT_HYPERV_EDX,
> +             .bits =3D HV_FREQUENCY_MSRS_AVAILABLE}
> +        }
> +    },
> +    {
> +        .name =3D "hv-crash",
> +        .desc =3D "crash MSRs",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EDX,
> +             .bits =3D HV_GUEST_CRASH_MSR_AVAILABLE},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-reenlightenment",
> +        .desc =3D "Reenlightenment MSRs",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_ACCESS_REENLIGHTENMENTS_CONTROL},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-reset",
> +        .desc =3D "reset MSR",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_RESET_AVAILABLE},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-vpindex",
> +        .desc =3D "VP_INDEX MSR",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_VP_INDEX_AVAILABLE},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-runtime",
> +        .desc =3D "VP_RUNTIME MSR",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_VP_RUNTIME_AVAILABLE},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-synic",
> +        .desc =3D "SynIC",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_SYNIC_AVAILABLE},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-stimer",
> +        .desc =3D "timers",
> +        .flags =3D {
> +            {.fw =3D FEAT_HYPERV_EAX,
> +             .bits =3D HV_SYNTIMERS_AVAILABLE},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-tlbflush",
> +        .desc =3D "TLB flush support",
> +        .flags =3D {
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_REMOTE_TLB_FLUSH_RECOMMENDED |
> +             HV_EX_PROCESSOR_MASKS_RECOMMENDED},
> +            {0}
> +        }
> +    },
> +    {
> +        .name =3D "hv-ipi",
> +        .desc =3D "IPI send support",
> +        .flags =3D {
> +            {.fw =3D FEAT_HV_RECOMM_EAX,
> +             .bits =3D HV_CLUSTER_IPI_RECOMMENDED |
> +             HV_EX_PROCESSOR_MASKS_RECOMMENDED},
> +            {0}
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
> +    while ((cpuid =3D try_get_hv_cpuid(cs, max)) =3D=3D NULL) {
> +        max++;
> +    }

If you didn't drop kernel-provided cpuid->nent on the floor in the
previous function you wouldn't need to iterate more than once.

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
> +
> +    entry_recomm =3D &cpuid->entries[1];
> +    entry_recomm->function =3D HV_CPUID_ENLIGHTMENT_INFO;
> =20
> -    if (cpu->hyperv_relaxed_timing) {
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0) {
> +        entry_feat->eax |=3D HV_HYPERCALL_AVAILABLE;
> +        entry_feat->eax |=3D HV_APIC_ACCESS_AVAILABLE;
> +        entry_feat->edx |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
> +        entry_recomm->eax |=3D HV_RELAXED_TIMING_RECOMMENDED;
> +        entry_recomm->eax |=3D HV_APIC_ACCESS_RECOMMENDED;
>      }
> -    if (cpu->hyperv_vapic) {
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_APIC_ACCESS_AVAILABLE;
> +
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) > 0) {
> +        entry_feat->eax |=3D HV_TIME_REF_COUNT_AVAILABLE;
> +        entry_feat->eax |=3D HV_REFERENCE_TSC_AVAILABLE;
>      }
> -    if (cpu->hyperv_time) {
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
> -    if (cpu->hyperv_frequencies) {
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
> -    if (cpu->hyperv_crash) {
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
> -    if (cpu->hyperv_reenlightenment) {
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
> -    if (cpu->hyperv_reset) {
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
> -    if (cpu->hyperv_vpindex) {
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
> -    if (cpu->hyperv_runtime) {
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
> -    if (cpu->hyperv_synic) {
> -        unsigned int cap =3D KVM_CAP_HYPERV_SYNIC;
> -        if (!cpu->hyperv_synic_kvm_only) {
> -            if (!cpu->hyperv_vpindex) {
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
> -    if (cpu->hyperv_stimer) {
> -        if (!has_msr_hv_stimer) {
> -            fprintf(stderr, "Hyper-V timers aren't supported by kernel\n=
");
> -            return -ENOSYS;
> -        }
> -        env->features[FEAT_HYPERV_EAX] |=3D HV_SYNTIMERS_AVAILABLE;
> +
> +    if (kvm_check_extension(cs->kvm_state,
> +                            KVM_CAP_HYPERV_SEND_IPI) > 0) {
> +        entry_recomm->eax |=3D HV_CLUSTER_IPI_RECOMMENDED;
> +        entry_recomm->eax |=3D HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>      }
> -    if (cpu->hyperv_relaxed_timing) {
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_RELAXED_TIMING_RECOMME=
NDED;
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
> -    if (cpu->hyperv_vapic) {
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_APIC_ACCESS_RECOMMENDE=
D;
> -    }
> -    if (cpu->hyperv_tlbflush) {
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
> +    entry =3D cpuid_find_entry(cpuid, func, 0);
> +    if (!entry) {
> +        return -ENOENT;
>      }
> -    if (cpu->hyperv_ipi) {
> -        if (kvm_check_extension(cs->kvm_state,
> -                                KVM_CAP_HYPERV_SEND_IPI) <=3D 0) {
> -            fprintf(stderr, "Hyper-V IPI send support "
> -                    "(requested by 'hv-ipi' cpu flag) "
> -                    " is not supported by kernel\n");
> -            return -ENOSYS;
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
> +                                  const char *name, bool flag)
> +{
> +    X86CPU *cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &cpu->env;
> +    uint32_t r, fw, bits;;
> +    int i, j;
> +
> +    if (!flag) {
> +        return 0;
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(kvm_hyperv_properties); i++) {
> +        if (strcmp(kvm_hyperv_properties[i].name, name)) {
> +            continue;
>          }
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_CLUSTER_IPI_RECOMMENDE=
D;
> -        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
> +
> +        for (j =3D 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j+=
+) {
> +            fw =3D kvm_hyperv_properties[i].flags[j].fw;
> +            bits =3D kvm_hyperv_properties[i].flags[j].bits;
> +
> +            if (!fw) {
> +                continue;
> +            }
> +
> +            if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) !=3D bits) =
{
> +                fprintf(stderr,
> +                        "Hyper-V %s (requested by '%s' cpu flag) "
> +                        "is not supported by kernel\n",
> +                        kvm_hyperv_properties[i].desc,
> +                        kvm_hyperv_properties[i].name);
> +                return 1;
> +            }
> +
> +            env->features[fw] |=3D bits;
> +        }
> +
> +        return 0;
>      }
> +
> +    /* the requested feature is undefined in kvm_hyperv_properties */
> +    return 1;
> +}
> +
> +static int hyperv_handle_properties(CPUState *cs)
> +{
> +    X86CPU *cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &cpu->env;
> +    struct kvm_cpuid2 *cpuid;
> +    int r =3D 0;
> +
>      if (cpu->hyperv_evmcs) {
>          uint16_t evmcs_version;
> =20
> @@ -849,7 +1068,45 @@ static int hyperv_handle_properties(CPUState *cs)
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
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-relaxed",
> +                                cpu->hyperv_relaxed_timing);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-vapic", cpu->hyperv_vap=
ic);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-time", cpu->hyperv_time=
);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-frequencies",
> +                                cpu->hyperv_frequencies);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-crash", cpu->hyperv_cra=
sh);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-reenlightenment",
> +                                cpu->hyperv_reenlightenment);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-reset", cpu->hyperv_res=
et);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-vpindex", cpu->hyperv_v=
pindex);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-runtime", cpu->hyperv_r=
untime);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-synic", cpu->hyperv_syn=
ic);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-stimer", cpu->hyperv_st=
imer);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush", cpu->hyperv_=
tlbflush);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", cpu->hyperv_ipi);

So this duplicates the link between the properties and their names,
originally established by DEFINE_PROP_BOOL(...).  Not good.

The property names are also duplicated in your kvm_hyperv_properties
array.  Not good either.

I'm wondering if a better solution could be to replace the boolean
properties with bit properties within a single 64bit word, and to have
the bit position of property be also the index into the property
descriptor array.  This should allow to DRY when defining the cpu
properties and then validating for their presence.  Besides this will
allow to easily express their interdependencies: every property will
just get an extra field with the mask of prerequisite properties.

I'll see if I can prototype something along these lines early next week
unless you beat me to it.

Anyway this mess that has accumulated around hyperv-related properties
is in need for a spring cleanup since long; thanks a lot for looking
into it!

Roman.

