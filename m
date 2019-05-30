Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B31C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ABD25ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GE/5Njpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ABD25ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWPIE-00066j-Sb
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 13:56:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hWPHC-0005VF-1y
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hWPHA-0007mY-UG
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:55:42 -0400
Received: from mail-bgr052101128023.outbound.protection.outlook.com
	([52.101.128.23]:13605
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hWPHA-0007T5-4G
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=h3slpcrd1sKa7kz3j5X8C1/LPVZW7tENHiMLDn7ffJE=;
	b=GE/5NjpfuUe0jPgCL46qtm4olEEt8ntzD/2RlVaaa/LlLDaU8ZDdSWhruJcB5VBhsmgwlMfmwpcuvyQGS0iWDrFzEeOzcB59M3YJLqT26Gmh0GtBEaeu//C51j5c4yrptC3QaL8XX9l/C4Lbt2T9r+3Ue7gokQiHlkp2/Xsy1ck=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4521.eurprd08.prod.outlook.com (20.179.44.138) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.17; Thu, 30 May 2019 17:55:16 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1922.021;
	Thu, 30 May 2019 17:55:15 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Thread-Topic: [PATCH v2 2/9] i386/kvm: add support for
	KVM_GET_SUPPORTED_HV_CPUID
Thread-Index: AQHVDLuPR8/P/4m4tkapnVzEeNR8W6Z/LuuAgAANPICABMwIgA==
Date: Thu, 30 May 2019 17:55:15 +0000
Message-ID: <20190530175511.GA13965@rkaganb.sw.ru>
References: <20190517141924.19024-1-vkuznets@redhat.com>
	<20190517141924.19024-3-vkuznets@redhat.com>
	<20190527155231.GB2362@rkaganb.sw.ru>
	<87h89fn95y.fsf@vitty.brq.redhat.com>
In-Reply-To: <87h89fn95y.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
	=09Vitaly_Kuznetsov_<vk?= =?iso-8859-1?Q?uznets@redhat.com>,
	=09"qemu-devel@nongnu.org"_<qemu-devel@?=
	=?iso-8859-1?Q?nongnu.org>, =09Paolo_Bonzini_<pbonzini@redhat.com>,
	=09Rich?= =?iso-8859-1?Q?ard_Henderson_<rth@twiddle.net>,
	=09Eduardo_Habkost_<ehabko?=
	=?iso-8859-1?Q?st@redhat.com>, =09Marcelo_Tosatti_<mtosatti@redhat.com>,
	?=
	=?iso-8859-1?Q?=09"Dr_._David_Alan_Gilbert"_<dgilbert@redhat.com>,
	=09Dani?=
	=?iso-8859-1?Q?el_P_._Berrang=E9_<berrange@redhat.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0227.eurprd05.prod.outlook.com
	(2603:10a6:3:fa::27) To DBBPR08MB4854.eurprd08.prod.outlook.com
	(2603:10a6:10:da::13)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 849c767c-da3a-44e9-2fcf-08d6e527f7fc
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DBBPR08MB4521; 
x-ms-traffictypediagnostic: DBBPR08MB4521:|DBBPR08MB4521:
x-microsoft-antispam-prvs: <DBBPR08MB4521BD828E0AEBBCB1187082C9180@DBBPR08MB4521.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(366004)(396003)(39850400004)(376002)(346002)(136003)(199004)(189003)(256004)(1076003)(54906003)(73956011)(3846002)(6486002)(486006)(6436002)(11346002)(86362001)(446003)(476003)(6116002)(36756003)(2906002)(386003)(6506007)(53936002)(6512007)(6246003)(66556008)(316002)(186003)(66946007)(64756008)(14454004)(66476007)(9686003)(58126008)(26005)(66446008)(229853002)(5660300002)(102836004)(305945005)(99286004)(52116002)(8936002)(8676002)(66066001)(68736007)(76176011)(7736002)(33656002)(71200400001)(25786009)(478600001)(4326008)(6916009)(81156014)(81166006)(71190400001)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:DBBPR08MB4521;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IKA/zIUEr0qRq3I4XSK0EHwo6B1MGfjFUuJl5PT0OwH1vKM/NDjeN95NDl6uXZpBqgbHvjbPZuKkh+OBGDJu1+idVarClIBnDfGGI93Ffgdm+wkrMaxfibTYrJRbKnxT9zhvi9eL1WYj2Z3hESzPufPUotT///g2lQKAr6PR5q56leb6KXfAsFf15Q4R/vCWZR6ZLrNt8BWSKA+AaEiz1LyAw6lfCQj5ylAx1UphMRQ0NOnUoKj/WS4ffgA1Z+rUSrW0Sh/xqCx5kHFDI8sZEIPu/s9xr8W40b2OWXD6DINSCzfZMzIF7xWUd0+S01aP9SD2IJXop7A4uA7hzSBLEyJym3AMxJQufQWWSbTc3O6BihpU92Vnu/+vkgkAlXL6aq3Lm8GVKMTNusaO8SKQ7vwOxEjpfTrefMTl7uRMqTs7wNzg9SHgG7cH0V91O8eeqWM/l2P1P67W61g/Qo7c5VK1Tt/8F8nruzetQYyMNFHf/mHhxs4BK+/kLbMBD33f
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EA95BB2E4594954186AF7546FF2DB1A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849c767c-da3a-44e9-2fcf-08d6e527f7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 17:55:15.6823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4521
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.128.23
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

On Mon, May 27, 2019 at 06:39:53PM +0200, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> > On Fri, May 17, 2019 at 04:19:17PM +0200, Vitaly Kuznetsov wrote:
> >> +static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
> >> +{
> >> +    struct kvm_cpuid2 *cpuid;
> >> +    int r, size;
> >> +
> >> +    size =3D sizeof(*cpuid) + max * sizeof(*cpuid->entries);
> >> +    cpuid =3D g_malloc0(size);
> >> +    cpuid->nent =3D max;
> >> +
> >> +    r =3D kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
> >> +    if (r =3D=3D 0 && cpuid->nent >=3D max) {
> >> +        r =3D -E2BIG;
> >> +    }
> >> +    if (r < 0) {
> >> +        if (r =3D=3D -E2BIG) {
> >> +            g_free(cpuid);
> >> +            return NULL;
> >> +        } else {
> >> +            fprintf(stderr, "KVM_GET_SUPPORTED_HV_CPUID failed: %s\n"=
,
> >> +                    strerror(-r));
> >> +            exit(1);
> >> +        }
> >> +    }
> >> +    return cpuid;
> >> +}
> >> +
> >> +/*
> >> + * Run KVM_GET_SUPPORTED_HV_CPUID ioctl(), allocating a buffer large =
enough
> >> + * for all entries.
> >> + */
> >> +static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
> >> +{
> >> +    struct kvm_cpuid2 *cpuid;
> >> +    int max =3D 7; /* 0x40000000..0x40000005, 0x4000000A */
> >> +
> >> +    /*
> >> +     * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails=
 with
> >> +     * -E2BIG, however, it doesn't report back the right size. Keep i=
ncreasing
> >> +     * it and re-trying until we succeed.
> >> +     */
> >
> > I'm still missing the idea of reiterating more than once: the ioctl
> > returns the actual size of the array.
>=20
> Hm, I think I checked that and it doesn't seem to be the case.
>=20
> The code in kvm_vcpu_ioctl_get_hv_cpuid():
>=20
> 	if (cpuid->nent < nent)
> 		return -E2BIG;
>=20
> 	if (cpuid->nent > nent)
> 		cpuid->nent =3D nent;
>=20
> (I think I even ran a test after your comment on v1 and it it
> confirmed nent is not set on E2BIG). Am I missing something obvious?

Indeed, I saw kvm_vcpu_ioctl_get_cpuid2() always setting ->nent on
return and assumed so did kvm_vcpu_ioctl_get_hv_cpuid().  I stand
corrected, please disregard this comment.
(What was the reason for not following this pattern in
kvm_vcpu_ioctl_get_hv_cpuid BTW?)

Thanks, and sorry for confusion,
Roman.

