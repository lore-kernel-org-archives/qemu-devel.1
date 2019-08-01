Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C787C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB46C20838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VebUyt8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB46C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htBrP-0005RY-7z
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htBqz-00050B-NS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htBqx-00043x-TD
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:14:49 -0400
Received: from mail-eopbgr770099.outbound.protection.outlook.com
 ([40.107.77.99]:17739 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1htBqx-00043N-Ja
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv/HxqHXEHtApBXi3BcXwGyKoDy3cUIISFWti5B4FG4TxjQuHiyXU7vCEt9/nIDeK7bxl832GBQGLtW1dmcplh/KoHRJZHec1Mc8yDZ/5o0AodTpcR7VWNMHyTfnXkTEHe/mCvLVfYd+mTZDY9kr35gKYCQoAIRRetIAMscK5z1e8cXjX3YXlT7JdOrA7/7orpv2zH45gPZcPTKq0w2v2VEqYsMutriU0cDUqTzpQFpbQK3Hx6l0RAYJFLCBatXGcCI6zD/GnIGdFYO8AXedja9uJ86rGP8xu6aYvr0Qv88+zOumDF2aHx41dH3X7JtamNNcLK87JJn3HGqBBVB5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTdqe4v4PRm9CUiYg/P30MYOUWMe5LX0z7lwMjYOWF8=;
 b=W4vfsWvhFn3gxoZboTw4jczv06MsxTnsspa6vCwsmmXNyKMG9TCjKoeH7MZnz/tmmsmNmHp648TRijQDqKcllnbPKLjTPxv3aDNyqBghutV3a+mhrVU2Kj/TSHJr3dUs6ZGGVsHU/tFd/W2eDtVlGRGTJ7u3Jiq/FbmPfmIllJJHD/VpV9+0G2XPuMVHV2MKd+4mPbAk8Z2VYL6Qx6lTsEKoLdciKcDp9YhYnB2M66l20GJB5AEQJI8DQ4s8AcIxMsQJMs7x3whPTNmwjrps8uFlBKHBraZ5ht57asL/5258BHCT6c68HfNx/9it9GOfnVrQYOKLPNe5Z0GPZlHM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=os.amperecomputing.com;dmarc=pass action=none
 header.from=os.amperecomputing.com;dkim=pass
 header.d=os.amperecomputing.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTdqe4v4PRm9CUiYg/P30MYOUWMe5LX0z7lwMjYOWF8=;
 b=VebUyt8H1JMzIS3h0QI2rpA1wdFNwNt01+NTNDR/Ubi23htHDO5VbVjckRJCNDGv3Fz9GT514/YWSpMtboti43YTiMoprMyWh3hveg5qj4kAAWGanufVZLKvP/lHb/iHLSzebNYNCiszMDcalbt/SDd+UF0weJzdZ2Oe8dtOjds=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB4684.prod.exchangelabs.com (20.177.217.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 14:14:43 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807%7]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 14:14:43 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [PATCH  v4 24/54] plugins: implement helpers for resolving hwaddr
Thread-Index: AQHVR7yN48iU1aXBCUeeGvORnrwZJabmV3UA
Date: Thu, 1 Aug 2019 14:14:43 +0000
Message-ID: <20190801141431.GK5034@quinoa.localdomain>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-25-alex.bennee@linaro.org>
In-Reply-To: <20190731160719.11396-25-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:903:77::23) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a7cddbd-ed1f-4c8d-df5e-08d7168a99a7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB4684; 
x-ms-traffictypediagnostic: DM6PR01MB4684:
x-microsoft-antispam-prvs: <DM6PR01MB4684734D5416787189E011F38ADE0@DM6PR01MB4684.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39830400003)(396003)(346002)(376002)(189003)(199004)(66574012)(99286004)(6512007)(8676002)(68736007)(305945005)(71190400001)(76176011)(9686003)(52116002)(6436002)(1076003)(71200400001)(14454004)(53936002)(66476007)(316002)(8936002)(66446008)(66946007)(256004)(81156014)(66556008)(478600001)(6246003)(6916009)(64756008)(6116002)(3846002)(486006)(81166006)(54906003)(25786009)(33656002)(7736002)(6486002)(229853002)(186003)(66066001)(386003)(86362001)(446003)(26005)(476003)(102836004)(5660300002)(4326008)(11346002)(6506007)(2906002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB4684;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tUJlz6l/cjxpvAxUjtzcjBx0a1RUbVsuYY4tT+Cdkr1Oe82AivBkss5ezva2QEaMoUb4PlUAxyWDOfXoT8xGwSzB5w3Qs12n3gBUUr702Bru6dqKJXJjfzVG2MAc/dyxnEWfgo2UVItGECiVIsvJteTxqNDdZ5JmaWkNLLJG60OywEaCYM0Zi4wf0Xj0o0q4HDfvpFITA1Cb+xRbgyoG7KXbHFk9QxeudNj2GvRR/NENBwgOyNVuwdHNYmtUsgoDWjfbSkIzLR7yLc+3Xh+tUgtkgsLpNFfe29Su2XDTYYHmP/AFzFDpsj3yWyd1Vhxphi68ESwCXy2f6dNXQunwkl3dP/Th42K/TiodRxy1X25K3tfuh6O+GJsfFVae/ZMP7yJ6Xz/5oGbl3xGGngsiw9EshDqcmtFPwt4/hbx3YVQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <62A0768D712AE04F9E753EA8EAF0308D@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7cddbd-ed1f-4c8d-df5e-08d7168a99a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 14:14:43.7366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4684
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.99
Subject: Re: [Qemu-devel] [PATCH v4 24/54] plugins: implement helpers for
 resolving hwaddr
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 31 17:06, Alex Benn=E9e wrote:
> We need to keep a local per-cpu copy of the data as other threads may
> be running. We use a automatically growing array and re-use the space
> for subsequent queries.

[...]

> +bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
> +                       bool is_store, struct qemu_plugin_hwaddr *data)
> +{
> +    CPUArchState *env =3D cpu->env_ptr;
> +    CPUTLBEntry *tlbe =3D tlb_entry(env, mmu_idx, addr);
> +    target_ulong tlb_addr =3D is_store ? tlb_addr_write(tlbe) : tlbe->ad=
dr_read;
> +
> +    if (tlb_hit(tlb_addr, addr)) {
> +        if (tlb_addr & TLB_MMIO) {
> +            data->hostaddr =3D 0;
> +            data->is_io =3D true;
> +            /* XXX: lookup device */
> +        } else {
> +            data->hostaddr =3D addr + tlbe->addend;
> +            data->is_io =3D false;
> +        }
> +        return true;
> +    }
> +    return false;
> +}

In what cases do you expect tlb_hit() should not evaluate to true here?
Will returns of false only be in error cases, or do you expect it can
occur during normal operation? In particular, I'm interested in ensuring
this is as reliable as possible, since some plugins may require physical
addresses.

> +struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t =
info,
> +                                                  uint64_t vaddr)
> +{
> +    CPUState *cpu =3D current_cpu;
> +    unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
> +    struct qemu_plugin_hwaddr *hwaddr;
> +
> +    /* Ensure we have memory allocated for this work */
> +    if (!hwaddr_refs) {
> +        hwaddr_refs =3D g_array_sized_new(false, true,
> +                                        sizeof(struct qemu_plugin_hwaddr=
),
> +                                        cpu->cpu_index + 1);
> +    } else if (cpu->cpu_index >=3D hwaddr_refs->len) {
> +        hwaddr_refs =3D g_array_set_size(hwaddr_refs, cpu->cpu_index + 1=
);
> +    }

Are there one or more race conditions with the allocations here? If so,
could they be solved by doing the allocations at plugin initialization
and when the number of online cpu's changes, instead of lazily?

>  uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *ha=
ddr)

I was at first confused about the utility of this function until I
(re-?)discovered you had to convert first to hwaddr and then raddr to
get a "true" physical address. Perhaps that could be added to a comment
here or in the API definition in the main plugin header file.

-Aaron

