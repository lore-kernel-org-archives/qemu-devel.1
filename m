Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1296FC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49992166E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="uknd7Onb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49992166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYbM-0008SJ-6s
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hpYb5-0007aO-Pi
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hpYb2-0007HR-Me
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:43:23 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com
 ([40.107.69.92]:29269 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hpYb2-0007Dg-9A
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:43:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDLH1tf5kmyGIlA7tdOgHRVlpjHm1AuhAoVnt83SBc41nN8NQw8NL/63QHdalXyNyDsgrvtMDXYyoPx4V05eeQt97nHvpTFULBZIFOQwuDxrT5a9auwTYjNFEA2V9QKqkDOlgEAgZYrdGbobPjjeRp4BTqCGX7qvWXw7SoLhsKGEIoY+phrIIz4QSigaQtJQZocugbKb46Srm3AELBLhYOAKYn8UB6spqFoNi4jdqQMegdg7b1gpFbeRYm3tIyCQyzxquo7ZVonvS6hpeukMq2EJgmfbXuNfNlSvxazmQXFXAbYeCYgNXJKFKB9/VuSLWe7T/Be6aiVMevLQTMF2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuHv8dWK2jwS4I/YFWDj5iwGyMw67Bh+pFgcpLTmS2Q=;
 b=j/mIFn6udygzQaVHpvst4pglh2PAatBxHbWI0nPPcxAFXJhW/F9bbbxfZFaB3PQGI6xIFutjUm+h4y7ecVRDrX+0ybjslms5a8JJw2q6TD/Pnn3kt26jD3sYsNru0EU6WLz7RFHXvTxuNE5F3omWXI0WYOXeV0ZCERBKXXkweoXrUIpHiN0tS2wlPusuvpXYKAfY+9zo0QCvNXk7S1vbE9OwRYvOtK5K5vhrsSfXLqGbGDHExKbGrTR2dpjQWP0YBIK1yn+CYp/igA/9k950BvdAc/wumg9L0LIgrR3reji99KNowBoZUqWRnbOgVLA/U5XMrxXmQiXUU2BiDVwuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector2-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuHv8dWK2jwS4I/YFWDj5iwGyMw67Bh+pFgcpLTmS2Q=;
 b=uknd7OnbetSdP8+gt8BhMW2hLYkaWKqWPckOI59ikTCreoPHuk8vP88jCO63yujAjhw/kIInsFCWpKE0u3z8ikWMWrNRSBVsPDFqUrynT4axGzTBJ296op4yoeozLsDSuqkT+JhBaS+1Q8EngtemFPFuSvDisLGlGTx8hGmHOmY=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0316.namprd22.prod.outlook.com (10.173.170.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 13:43:15 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::447b:e0b5:5b86:985b]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::447b:e0b5:5b86:985b%7]) with mapi id 15.20.2073.012; Mon, 22 Jul 2019
 13:43:15 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH for 4.1 v4 5/5] target/mips: Fix emulation of MSA pack
 instructions on big endian hosts
Thread-Index: AQHVO0gJ09CtK9UB5Uy4T/kGZCD/6qbWr76Q
Date: Mon, 22 Jul 2019 13:43:14 +0000
Message-ID: <DM5PR22MB1658727F0297DA356C56EE8CD2C40@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1563220847-14630-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1563220847-14630-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1563220847-14630-6-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 910b42e9-1cbc-490a-177a-08d70eaa8c01
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0316; 
x-ms-traffictypediagnostic: DM5PR22MB0316:
x-microsoft-antispam-prvs: <DM5PR22MB0316F845DD24419750D11515D2C40@DM5PR22MB0316.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(396003)(346002)(376002)(366004)(189003)(199004)(68736007)(52536014)(64756008)(66556008)(66946007)(107886003)(102836004)(66476007)(6246003)(7736002)(14454004)(2906002)(53546011)(6506007)(55236004)(86362001)(3846002)(5660300002)(99286004)(486006)(76116006)(91956017)(66066001)(66446008)(6116002)(256004)(2501003)(110136005)(55016002)(316002)(54896002)(33656002)(478600001)(19627405001)(6436002)(76176011)(53936002)(7696005)(54906003)(11346002)(6606003)(71200400001)(71190400001)(8936002)(74316002)(229853002)(4326008)(476003)(25786009)(9686003)(186003)(81166006)(81156014)(8676002)(26005)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0316;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1g4PTlS6zihsI3ZEyD2BsLrC9qwvvsJmdpKMO1oJxKpYSJAocgNNfrb92YgLZQMtZ82Hq58myaWEaExurwbwzhCm77Z/1GYSe/yxeKYtE4qyBWELF7uPx0gzZ9dqQ3aj999KHVvjUU6VuVKYbOu9B2cHVEpjo8iiW1JrJXmu85q7+IIHfRkSu53m05XkSeldj0pcdZXmpBdYQcUgzE3qoC9kidmi/fY1GQQtafVMW/LyzHt5DzwEzJ8b/ggB+WV5qbD3/2DqYg3iguwOC9wlaWdslldr5lz2xPbhVSWgCqoaKVcwYAk0AOvUWlOAmAGiAvlbknhXbvvumSBp8FkDg9d7CYvNiEyM1aOPd0a1DNKpR1M8t+lMv5z5zlifW1Tw89OBKynql5DIlVNl/cbEPvVvY/X7myKztM7oUGuOP0o=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910b42e9-1cbc-490a-177a-08d70eaa8c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:43:14.9866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0316
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.92
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH for 4.1 v4 5/5] target/mips: Fix emulation
 of MSA pack instructions on big endian hosts
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
Cc: "sw@weilnetz.de" <sw@weilnetz.de>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, July 15, 2019 10:00 PM
> To: qemu-devel@nongnu.org
> Cc: sw@weilnetz.de; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH for 4.1 v4 5/5] target/mips: Fix emulation of MSA pack in=
structions on big endian hosts
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix emulation of MSA pack instructions on big endian hosts.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/msa_helper.c | 74 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index a383c40..27560ac 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -2113,6 +2113,24 @@ void helper_msa_pckev_df(CPUMIPSState *env, uint32=
_t df, uint32_t wd,
>
>      switch (df) {
>      case DF_BYTE:
> +#if defined(HOST_WORDS_BIGENDIAN)
> +        pwd->b[8]  =3D pws->b[9];
> +        pwd->b[10] =3D pws->b[13];
> +        pwd->b[12] =3D pws->b[1];
> +        pwd->b[14] =3D pws->b[5];
> +        pwd->b[0]  =3D pwt->b[9];
> +        pwd->b[2]  =3D pwt->b[13];
> +        pwd->b[4]  =3D pwt->b[1];
> +        pwd->b[6]  =3D pwt->b[5];
> +        pwd->b[9]  =3D pws->b[11];
> +        pwd->b[13] =3D pws->b[3];
> +        pwd->b[1]  =3D pwt->b[11];
> +        pwd->b[5]  =3D pwt->b[3];
> +        pwd->b[11] =3D pws->b[15];
> +        pwd->b[3]  =3D pwt->b[15];
> +        pwd->b[15] =3D pws->b[7];
> +        pwd->b[7]  =3D pwt->b[7];
> +#else
>          pwd->b[15] =3D pws->b[14];
>          pwd->b[13] =3D pws->b[10];
>          pwd->b[11] =3D pws->b[6];
> @@ -2129,8 +2147,19 @@ void helper_msa_pckev_df(CPUMIPSState *env, uint32=
_t df, uint32_t wd,
>          pwd->b[4]  =3D pwt->b[8];
>          pwd->b[8]  =3D pws->b[0];
>          pwd->b[0]  =3D pwt->b[0];
> +#endif
>          break;
>      case DF_HALF:
> +#if defined(HOST_WORDS_BIGENDIAN)
> +        pwd->h[4] =3D pws->h[5];
> +        pwd->h[6] =3D pws->h[1];
> +        pwd->h[0] =3D pwt->h[5];
> +        pwd->h[2] =3D pwt->h[1];
> +        pwd->h[5] =3D pws->h[7];
> +        pwd->h[1] =3D pwt->h[7];
> +        pwd->h[7] =3D pws->h[3];
> +        pwd->h[3] =3D pwt->h[3];
> +#else
>          pwd->h[7] =3D pws->h[6];
>          pwd->h[5] =3D pws->h[2];
>          pwd->h[3] =3D pwt->h[6];
> @@ -2139,12 +2168,20 @@ void helper_msa_pckev_df(CPUMIPSState *env, uint3=
2_t df, uint32_t wd,
>          pwd->h[2] =3D pwt->h[4];
>          pwd->h[4] =3D pws->h[0];
>          pwd->h[0] =3D pwt->h[0];
> +#endif
>          break;
>      case DF_WORD:
> +#if defined(HOST_WORDS_BIGENDIAN)
> +        pwd->w[2] =3D pws->w[3];
> +        pwd->w[0] =3D pwt->w[3];
> +        pwd->w[3] =3D pws->w[1];
> +        pwd->w[1] =3D pwt->w[1];
> +#else
>          pwd->w[3] =3D pws->w[2];
>          pwd->w[1] =3D pwt->w[2];
>          pwd->w[2] =3D pws->w[0];
>          pwd->w[0] =3D pwt->w[0];
> +#endif
>          break;
>      case DF_DOUBLE:
>          pwd->d[1] =3D pws->d[0];
> @@ -2164,6 +2201,24 @@ void helper_msa_pckod_df(CPUMIPSState *env, uint32=
_t df, uint32_t wd,
>
>      switch (df) {
>      case DF_BYTE:
> +#if defined(HOST_WORDS_BIGENDIAN)
> +        pwd->b[7]  =3D pws->b[6];
> +        pwd->b[5]  =3D pws->b[2];
> +        pwd->b[3]  =3D pws->b[14];
> +        pwd->b[1]  =3D pws->b[10];
> +        pwd->b[15] =3D pwt->b[6];
> +        pwd->b[13] =3D pwt->b[2];
> +        pwd->b[11] =3D pwt->b[14];
> +        pwd->b[9]  =3D pwt->b[10];
> +        pwd->b[6]  =3D pws->b[4];
> +        pwd->b[2]  =3D pws->b[12];
> +        pwd->b[14] =3D pwt->b[4];
> +        pwd->b[10] =3D pwt->b[12];
> +        pwd->b[4]  =3D pws->b[0];
> +        pwd->b[12] =3D pwt->b[0];
> +        pwd->b[0]  =3D pws->b[8];
> +        pwd->b[8]  =3D pwt->b[8];
> +#else
>          pwd->b[0]  =3D pwt->b[1];
>          pwd->b[2]  =3D pwt->b[5];
>          pwd->b[4]  =3D pwt->b[9];
> @@ -2180,8 +2235,19 @@ void helper_msa_pckod_df(CPUMIPSState *env, uint32=
_t df, uint32_t wd,
>          pwd->b[11] =3D pws->b[7];
>          pwd->b[7]  =3D pwt->b[15];
>          pwd->b[15] =3D pws->b[15];
> +#endif
>          break;
>      case DF_HALF:
> +#if defined(HOST_WORDS_BIGENDIAN)
> +        pwd->h[3] =3D pws->h[2];
> +        pwd->h[1] =3D pws->h[6];
> +        pwd->h[7] =3D pwt->h[2];
> +        pwd->h[5] =3D pwt->h[6];
> +        pwd->h[2] =3D pws->h[0];
> +        pwd->h[6] =3D pwt->h[0];
> +        pwd->h[0] =3D pws->h[4];
> +        pwd->h[4] =3D pwt->h[4];
> +#else
>          pwd->h[0] =3D pwt->h[1];
>          pwd->h[2] =3D pwt->h[5];
>          pwd->h[4] =3D pws->h[1];
> @@ -2190,12 +2256,20 @@ void helper_msa_pckod_df(CPUMIPSState *env, uint3=
2_t df, uint32_t wd,
>          pwd->h[5] =3D pws->h[3];
>          pwd->h[3] =3D pwt->h[7];
>          pwd->h[7] =3D pws->h[7];
> +#endif
>          break;
>      case DF_WORD:
> +#if defined(HOST_WORDS_BIGENDIAN)
> +        pwd->w[1] =3D pws->w[0];
> +        pwd->w[3] =3D pwt->w[0];
> +        pwd->w[0] =3D pws->w[2];
> +        pwd->w[2] =3D pwt->w[2];
> +#else
>          pwd->w[0] =3D pwt->w[1];
>          pwd->w[2] =3D pws->w[1];
>          pwd->w[1] =3D pwt->w[3];
>          pwd->w[3] =3D pws->w[3];
> +#endif
>          break;
>      case DF_DOUBLE:
>          pwd->d[0] =3D pwt->d[1];
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

