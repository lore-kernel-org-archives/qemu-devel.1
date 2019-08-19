Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BCAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059272070D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="YDwXZYqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059272070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzip9-0007uk-8d
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hzioS-0007UT-P1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hzioQ-0005VF-DJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:39:12 -0400
Received: from mail-eopbgr770122.outbound.protection.outlook.com
 ([40.107.77.122]:33766 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hzioQ-0005Uk-3K
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:39:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mApEcuEC5Fn5pZslddpNEKMVlNG8KT/XHR47XELQ22lzn+F8QoDqsdiW4cUw+DlcvHWMfQCWRO82ARJZ2+8/Uk+rOBj8f4IB2Sygn64U0Q0UdK3KY9Su1KN6rvhsFqVM9wkgcCoxDgSLICT2tFe9n7PX/hXlfMU7SsGeANYMSgAHEbYVEvEGkHHzNK/aA6KvF4fDAkySrpn0H4MRNncKoJVVWt457wH+V7i8b4cBVG6ycehu0CdOAHy2LuwlcGchJ/PxzEu2N0/3CD2aEsbB/E5Tq9It0SIl8AJ+dU7I+P1kb5UrWCrMGSL25KiN2kCi1uGHlKG+bCu21jy2sR640g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/KI2C/YAEHadsdhl0u41LeAuj+9+blKGwTNWCGYSCo=;
 b=XIYSWdLDh+h6Vj2at9Dom5d7PubzQC8n502wG0xOp3qH+JDBrYPi0aCjfjQx/yaDYvjR9hrQDdMa5B93XvTvx/HwCObWSI0o8NM1EQgMtK2DAFgwdexzvGHqczKrF5oXf2Q/aI1uVRRAotdQ1aO2QRCVrH2gpFHwH6AKLJRk8okq6ATRj9LteuiQD3pTUJtj2aE68qTCPwNZRNH4Kfw2z8Mr0yFydykB0IaNZh5bBzF+CK0zV5EPTcU0AVkJG6G8GQA6giiboriV0al+SAwpIV30JDPcBkZPxdgmYtkFj2eEWBTm1BU+Xpld2WQzr2YoHsuMluyEoHYpZ9soIC8dkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/KI2C/YAEHadsdhl0u41LeAuj+9+blKGwTNWCGYSCo=;
 b=YDwXZYqEU3T0DJWzbUAtBIdy4pzZMOBAB5+dH3FYFL8bqa/4prIQu1/4ZpFGX5JxMs7aAh302TAObshcm3ctO8rdD20j1MCS0PsK9zVF6SMm8pVKg9RCxZlOBDbmg4wwfkz4Zd7PXLr1eWc//mVVJafI7uzzy7/FgAKnx3fKnLI=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0220.namprd22.prod.outlook.com (10.168.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:39:07 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:39:07 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 03/37] target/mips: Amend CP0 MemoryMapID
 register implementation
Thread-Index: AQHVVobRGKms4lxPE0SFUhHsIxCGyqcCiltO
Date: Mon, 19 Aug 2019 14:39:07 +0000
Message-ID: <DM5PR22MB1658F49DA64A9771F0027D3ED2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-4-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84d3c63b-e642-4435-9b8a-08d724b2fddf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0220; 
x-ms-traffictypediagnostic: DM5PR22MB0220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB02202AB03338F56226CEF8A8D2A80@DM5PR22MB0220.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(396003)(136003)(366004)(199004)(189003)(476003)(14454004)(54906003)(66066001)(6606003)(316002)(446003)(11346002)(25786009)(110136005)(66946007)(8936002)(52536014)(54896002)(486006)(3846002)(6116002)(66556008)(66476007)(5660300002)(76176011)(64756008)(66446008)(81156014)(8676002)(76116006)(91956017)(6436002)(9686003)(7696005)(86362001)(55016002)(256004)(2906002)(26005)(229853002)(71200400001)(6506007)(71190400001)(33656002)(53546011)(55236004)(102836004)(81166006)(186003)(99286004)(4326008)(7736002)(74316002)(19627405001)(2501003)(107886003)(478600001)(53936002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0220;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4iNclaU1byWpen5vXMJ2xHHeaO12c5hJBZ1vPonLTz1o8pCTZjqSqikywPgbhkau4PQQuEqvbUYWHD46epOFwA6Y/YK0N5FmmSnTAJBYlVXZ9Gb+uGYKqqWLPPVboQKlVD+g1/W94m02upErG/a6C6OroeR1F+Tg48QCNt5Xro/qqLbhVmhBbhRRwqhG3ju290HDDo2xJBG8Nfi9AaCeTNaukMHOwtZfpoub46vQwL+Rh5Q47w/CmmlnSL469ELNfJuhgOCTfjNKhLuIeelkAO12WSrCpfVGxAQ2HfCsSVqMr4bgUp2+a2q0UocWuH9eR4zFV6pIRxSD/LtWtChXeI7wpyomxRdZg1tAcN73kEcwE5e/PHEmJqi9TLjfDIyX6CRuHdqZiIgQiwE5tAFQtjIXT6Ot+4qOJbPm+UJ4teE=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d3c63b-e642-4435-9b8a-08d724b2fddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:39:07.7613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMV+dMivUTW3jjSFwo6pxCb8y0HBceFjnQz2DMQzYWGzVThrJcceSCQnUR9NTkYF1lE+RIbUVVb3GSAl2L4YLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0220
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.122
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 03/37] target/mips: Amend CP0
 MemoryMapID register implementation
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 19, 2019 2:07 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <amarkovic=
@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v8 03/37] target/mips: Amend CP0 MemoryMapID re=
gister implementation
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add migration support and fix preprocessor constant name for
> MemoryMapID register.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h     | 2 +-
>  target/mips/machine.c | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 6406ba8..eda8350 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -290,7 +290,7 @@ typedef struct mips_def_t mips_def_t;
>  #define CP0_REG04__CONTEXT         0
>  #define CP0_REG04__USERLOCAL       2
>  #define CP0_REG04__DBGCONTEXTID    4
> -#define CP0_REG00__MMID            5
> +#define CP0_REG04__MEMORYMAPID     5
>  /* CP0 Register 05 */
>  #define CP0_REG05__PAGEMASK        0
>  #define CP0_REG05__PAGEGRAIN       1
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index c3e52f8..e23b767 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -137,6 +137,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size=
,
>      qemu_get_betls(f, &v->VPN);
>      qemu_get_be32s(f, &v->PageMask);
>      qemu_get_be16s(f, &v->ASID);
> +    qemu_get_be32s(f, &v->MMID);
>      qemu_get_be16s(f, &flags);
>      v->G =3D (flags >> 10) & 1;
>      v->C0 =3D (flags >> 7) & 3;
> @@ -162,6 +163,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size=
,
>      r4k_tlb_t *v =3D pv;
>
>      uint16_t asid =3D v->ASID;
> +    uint32_t mmid =3D v->MMID;
>      uint16_t flags =3D ((v->EHINV << 15) |
>                        (v->RI1 << 14) |
>                        (v->RI0 << 13) |
> @@ -178,6 +180,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size=
,
>      qemu_put_betls(f, &v->VPN);
>      qemu_put_be32s(f, &v->PageMask);
>      qemu_put_be16s(f, &asid);
> +    qemu_put_be32s(f, &mmid);
>      qemu_put_be16s(f, &flags);
>      qemu_put_be64s(f, &v->PFN[0]);
>      qemu_put_be64s(f, &v->PFN[1]);
> @@ -199,8 +202,8 @@ const VMStateInfo vmstate_info_tlb =3D {
>
>  const VMStateDescription vmstate_tlb =3D {
>      .name =3D "cpu/tlb",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),
>          VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),
> --
> 2.7.4
>

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

