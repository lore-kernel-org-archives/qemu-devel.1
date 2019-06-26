Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC5DC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A7F20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qgnGBhVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A7F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38575 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg54t-00034F-Qq
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46381)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hg4uZ-0003Qz-9H
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hg4uQ-0000tJ-QI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:12:19 -0400
Received: from mail-eopbgr750090.outbound.protection.outlook.com
 ([40.107.75.90]:30436 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hg4uP-0000po-0g
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX3ej4Q1TeABOzPouS4tUU2r01UQxVc2pZLWkql8eGg=;
 b=qgnGBhVQiwTilyb7Cr/6UnHwCBlq6cnhuUgZev0oPxCveUUJlOIJRg2zt4Yf9PPfOBLdPFu4mquy57+cbq3oCjbjAIy7tcHq2d49rr2vM4KSKAJgwg7z6l6Uxcl63kryFQRVeq8TLrPQXrQ67tygrVXZjXClp5bTbSxxnbkkaEU=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0028.namprd22.prod.outlook.com (10.168.174.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Wed, 26 Jun 2019 10:12:06 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 10:12:06 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v6 7/8] tests/tcg: target/mips: Fix some test cases for
 pack MSA instructions
Thread-Index: AQHVLAb1f5hwYW/sSkWa77DXuMEs1KattlI8
Date: Wed, 26 Jun 2019 10:12:06 +0000
Message-ID: <DM5PR22MB1658ECB96B23D5C9DB2ABB6ED2E20@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561543629-20327-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1561543629-20327-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561543629-20327-8-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e11a79ce-ef69-4c20-4f17-08d6fa1ebdff
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0028; 
x-ms-traffictypediagnostic: DM5PR22MB0028:
x-microsoft-antispam-prvs: <DM5PR22MB00285DA1872145FB9D286FC1D2E20@DM5PR22MB0028.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(366004)(39850400004)(396003)(189003)(199004)(81156014)(73956011)(66446008)(446003)(68736007)(71200400001)(71190400001)(476003)(6436002)(11346002)(229853002)(30864003)(52536014)(81166006)(8676002)(7736002)(2906002)(486006)(4326008)(478600001)(25786009)(19627405001)(74316002)(33656002)(99286004)(186003)(53546011)(6116002)(2501003)(9686003)(6506007)(76176011)(53946003)(6246003)(110136005)(102836004)(76116006)(7696005)(256004)(54896002)(3846002)(26005)(55236004)(14454004)(66556008)(6606003)(55016002)(66066001)(8936002)(53936002)(5660300002)(66946007)(66476007)(86362001)(64756008)(91956017)(107886003)(316002)(579004)(559001)(569006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0028;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Yu9I1eN7MASnWHVB3fZ1ZEK8SekO0VBf06APaeommSUO6frwCbKfQxZgv7coD+47fZSS8jmO8b73pF9ZQbQEhs0eL4d7T3BrQmrkto4rYwfLGWf91p1V6acGIhOwHrB3teEcou0UwQe9RWqrc/1ee2Dfe+XKUOHwAPk02qywBRSJI1s1b/6ZWy7WXbd5O3E6XZ/VRC2xLt3VNLrkNNnLjW1WgJfMtKpQ79esyCQES+wEsRZ7FLIbHfC34GAz4PLpXVycdiVM59on9oYOwnjs2XKW3EJdOMKp+ZKtpQRJRhpqgE1H27lqHDTxQmh1AnE6A+s1fdt0ozX3yK42jxRbT4S0YEneaXJF3ZLalbG+eJFj3+XeX48gIIU36dxGHfvtgNtmoplBefjmf1TxeMA6xWPvGSaiPFszK7l49GYnnk=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11a79ce-ef69-4c20-4f17-08d6fa1ebdff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 10:12:06.0344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0028
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.90
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 7/8] tests/tcg: target/mips: Fix some
 test cases for pack MSA instructions
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, June 26, 2019 12:07 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v6 7/8] tests/tcg: target/mips: Fix some test cases for p=
ack MSA instructions
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix certian test cases for MSA pack instructions.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 64 +++++++++++-----=
------
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 64 +++++++++++-----=
------
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 64 +++++++++++-----=
------
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 64 +++++++++++-----=
------
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 64 +++++++++++-----=
------
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 64 +++++++++++-----=
------
>  12 files changed, 384 insertions(+), 384 deletions(-)
>
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
> index 4a4c9d6..2f4ffd9 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0xf71a3ffcbe639308ULL, 0xf1d842a04f4d314eULL, },
>          { 0xd8ff2b145aaacf80ULL, 0xf1d842a04f4d314eULL, },
>          { 0xf1d842a04f4d314eULL, 0xf1d842a04f4d314eULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x675e7b0c6acc6240ULL, 0xd8a04d4ed8a04d4eULL, },    /*  80  */
> +        { 0xf71a3ffcbe639308ULL, 0xa04ea04e5e0ccc40ULL, },
> +        { 0xd8ff2b145aaacf80ULL, 0x4e4e0c401afc6308ULL, },
> +        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
> +        { 0x675e7b0c6acc6240ULL, 0x40081480d8a04d4eULL, },
> +        { 0xf71a3ffcbe639308ULL, 0x0880a04e5e0ccc40ULL, },
> +        { 0xd8ff2b145aaacf80ULL, 0x804e0c401afc6308ULL, },
> +        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
> +        { 0x675e7b0c6acc6240ULL, 0x40081480d8a04d4eULL, },    /*  88  */
> +        { 0xf71a3ffcbe639308ULL, 0x0880a04e5e0ccc40ULL, },
> +        { 0xd8ff2b145aaacf80ULL, 0x804e0c401afc6308ULL, },
> +        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
> +        { 0x675e7b0c6acc6240ULL, 0x40081480d8a04d4eULL, },
> +        { 0xf71a3ffcbe639308ULL, 0x0880a04e5e0ccc40ULL, },
> +        { 0xd8ff2b145aaacf80ULL, 0x804e0c401afc6308ULL, },
> +        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
> +        { 0x40081480d8a04d4eULL, 0x675e7b0c6acc6240ULL, },    /*  96  */
> +        { 0x5e0ccc400880a04eULL, 0x675e7b0c6acc6240ULL, },
> +        { 0x5e0ccc400c40804eULL, 0x675e7b0c6acc6240ULL, },
> +        { 0x5e0ccc400c40404eULL, 0x675e7b0c6acc6240ULL, },
> +        { 0x5e0ccc400c40404eULL, 0xf71a3ffcbe639308ULL, },
> +        { 0x1afc63080c40404eULL, 0xf71a3ffcbe639308ULL, },
> +        { 0x1afc6308fc08404eULL, 0xf71a3ffcbe639308ULL, },
> +        { 0x1afc6308fc08084eULL, 0xf71a3ffcbe639308ULL, },
> +        { 0x1afc6308fc08084eULL, 0xd8ff2b145aaacf80ULL, },    /* 104  */
> +        { 0xff14aa80fc08084eULL, 0xd8ff2b145aaacf80ULL, },
> +        { 0xff14aa801480084eULL, 0xd8ff2b145aaacf80ULL, },
> +        { 0xff14aa801480804eULL, 0xd8ff2b145aaacf80ULL, },
> +        { 0xff14aa801480804eULL, 0xf1d842a04f4d314eULL, },
> +        { 0xd8a04d4e1480804eULL, 0xf1d842a04f4d314eULL, },
> +        { 0xd8a04d4ea04e804eULL, 0xf1d842a04f4d314eULL, },
> +        { 0xd8a04d4ea04e4e4eULL, 0xf1d842a04f4d314eULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
> index 67df606..3f0bd47 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0xfbbe00634d93c708ULL, 0x704f164d5e31e24eULL, },
>          { 0xac5aaeaab9cf8b80ULL, 0x704f164d5e31e24eULL, },
>          { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },    /*  80  */
> +        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },
> +        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },    /*  88  */
> +        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },
> +        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },    /*  96  */
> +        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
> +        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
> +        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
> +        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },    /* 104  */
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
> +        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
> +        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
> +        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
> index 22d043c..2eae01f 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0xbb1a52fc0063c708ULL, 0x88d8e2a0164de24eULL, },
>          { 0xc6ff2514aeaa8b80ULL, 0x88d8e2a0164de24eULL, },
>          { 0x88d8e2a0164de24eULL, 0x88d8e2a0164de24eULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x0b5eb00ce6cc5540ULL, 0xe2a0e24ee2a0e24eULL, },    /*  80  */
> +        { 0xbb1a52fc0063c708ULL, 0xe24ee24eb00c5540ULL, },
> +        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
> +        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
> +        { 0x0b5eb00ce6cc5540ULL, 0xc7088b80e2a0e24eULL, },
> +        { 0xbb1a52fc0063c708ULL, 0x8b80e24eb00c5540ULL, },
> +        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
> +        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
> +        { 0x0b5eb00ce6cc5540ULL, 0xc7088b80e2a0e24eULL, },    /*  88  */
> +        { 0xbb1a52fc0063c708ULL, 0x8b80e24eb00c5540ULL, },
> +        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
> +        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
> +        { 0x0b5eb00ce6cc5540ULL, 0xc7088b80e2a0e24eULL, },
> +        { 0xbb1a52fc0063c708ULL, 0x8b80e24eb00c5540ULL, },
> +        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
> +        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
> +        { 0xc7088b80e2a0e24eULL, 0x0b5eb00ce6cc5540ULL, },    /*  96  */
> +        { 0xb00c55408b80e24eULL, 0x0b5eb00ce6cc5540ULL, },
> +        { 0xb00c55405540e24eULL, 0x0b5eb00ce6cc5540ULL, },
> +        { 0xb00c55405540e24eULL, 0x0b5eb00ce6cc5540ULL, },
> +        { 0xb00c55405540e24eULL, 0xbb1a52fc0063c708ULL, },
> +        { 0x52fcc7085540e24eULL, 0xbb1a52fc0063c708ULL, },
> +        { 0x52fcc708c708e24eULL, 0xbb1a52fc0063c708ULL, },
> +        { 0x52fcc708c708e24eULL, 0xbb1a52fc0063c708ULL, },
> +        { 0x52fcc708c708e24eULL, 0xc6ff2514aeaa8b80ULL, },    /* 104  */
> +        { 0x25148b80c708e24eULL, 0xc6ff2514aeaa8b80ULL, },
> +        { 0x25148b808b80e24eULL, 0xc6ff2514aeaa8b80ULL, },
> +        { 0x25148b808b80e24eULL, 0xc6ff2514aeaa8b80ULL, },
> +        { 0x25148b808b80e24eULL, 0x88d8e2a0164de24eULL, },
> +        { 0xe2a0e24e8b80e24eULL, 0x88d8e2a0164de24eULL, },
> +        { 0xe2a0e24ee24ee24eULL, 0x88d8e2a0164de24eULL, },
> +        { 0xe2a0e24ee24ee24eULL, 0x88d8e2a0164de24eULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
> index 1a9c2df..f7215d0 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x153f52fc4d93c708ULL, 0xa942e2a05e31e24eULL, },
>          { 0xab2b2514b9cf8b80ULL, 0xa942e2a05e31e24eULL, },
>          { 0xa942e2a05e31e24eULL, 0xa942e2a05e31e24eULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0xfe7bb00c28625540ULL, 0x5e31e24e5e31e24eULL, },    /*  80  */
> +        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
> +        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
> +        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
> +        { 0xfe7bb00c28625540ULL, 0xb9cf8b805e31e24eULL, },
> +        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
> +        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
> +        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
> +        { 0xfe7bb00c28625540ULL, 0xb9cf8b805e31e24eULL, },    /*  88  */
> +        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
> +        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
> +        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
> +        { 0xfe7bb00c28625540ULL, 0xb9cf8b805e31e24eULL, },
> +        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
> +        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
> +        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
> +        { 0xb9cf8b805e31e24eULL, 0xfe7bb00c28625540ULL, },    /*  96  */
> +        { 0x286255405e31e24eULL, 0xfe7bb00c28625540ULL, },
> +        { 0x286255405e31e24eULL, 0xfe7bb00c28625540ULL, },
> +        { 0x286255405e31e24eULL, 0xfe7bb00c28625540ULL, },
> +        { 0x286255405e31e24eULL, 0x153f52fc4d93c708ULL, },
> +        { 0x4d93c7085e31e24eULL, 0x153f52fc4d93c708ULL, },
> +        { 0x4d93c7085e31e24eULL, 0x153f52fc4d93c708ULL, },
> +        { 0x4d93c7085e31e24eULL, 0x153f52fc4d93c708ULL, },
> +        { 0x4d93c7085e31e24eULL, 0xab2b2514b9cf8b80ULL, },    /* 104  */
> +        { 0xb9cf8b805e31e24eULL, 0xab2b2514b9cf8b80ULL, },
> +        { 0xb9cf8b805e31e24eULL, 0xab2b2514b9cf8b80ULL, },
> +        { 0xb9cf8b805e31e24eULL, 0xab2b2514b9cf8b80ULL, },
> +        { 0xb9cf8b805e31e24eULL, 0xa942e2a05e31e24eULL, },
> +        { 0x5e31e24e5e31e24eULL, 0xa942e2a05e31e24eULL, },
> +        { 0x5e31e24e5e31e24eULL, 0xa942e2a05e31e24eULL, },
> +        { 0x5e31e24e5e31e24eULL, 0xa942e2a05e31e24eULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
> index 15ef377..6355338 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x12bb1552fb004dc7ULL, 0x8d88a9e270165ee2ULL, },
>          { 0x27c6ab25acaeb98bULL, 0x8d88a9e270165ee2ULL, },
>          { 0x8d88a9e270165ee2ULL, 0x8d88a9e270165ee2ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x4b0bfeb088e62855ULL, 0x8da9705e8da9705eULL, },    /*  80  */
> +        { 0x12bb1552fb004dc7ULL, 0x8d708d704bfe8828ULL, },
> +        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
> +        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
> +        { 0x4b0bfeb088e62855ULL, 0x8d1227ac8da9705eULL, },
> +        { 0x12bb1552fb004dc7ULL, 0x8d278d704bfe8828ULL, },
> +        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
> +        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
> +        { 0x4b0bfeb088e62855ULL, 0x8d1227ac8da9705eULL, },    /*  88  */
> +        { 0x12bb1552fb004dc7ULL, 0x8d278d704bfe8828ULL, },
> +        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
> +        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
> +        { 0x4b0bfeb088e62855ULL, 0x8d1227ac8da9705eULL, },
> +        { 0x12bb1552fb004dc7ULL, 0x8d278d704bfe8828ULL, },
> +        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
> +        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
> +        { 0x8d1227ac8da9705eULL, 0x4b0bfeb088e62855ULL, },    /*  96  */
> +        { 0x4bfe88288d278d70ULL, 0x4b0bfeb088e62855ULL, },
> +        { 0x4bfe88284b888d8dULL, 0x4b0bfeb088e62855ULL, },
> +        { 0x4bfe88284b884b8dULL, 0x4b0bfeb088e62855ULL, },
> +        { 0x4bfe88284b884b4bULL, 0x12bb1552fb004dc7ULL, },
> +        { 0x1215fb4d4b884b4bULL, 0x12bb1552fb004dc7ULL, },
> +        { 0x1215fb4d12fb4b4bULL, 0x12bb1552fb004dc7ULL, },
> +        { 0x1215fb4d12fb124bULL, 0x12bb1552fb004dc7ULL, },
> +        { 0x1215fb4d12fb1212ULL, 0x27c6ab25acaeb98bULL, },    /* 104  */
> +        { 0x27abacb912fb1212ULL, 0x27c6ab25acaeb98bULL, },
> +        { 0x27abacb927ac1212ULL, 0x27c6ab25acaeb98bULL, },
> +        { 0x27abacb927ac2712ULL, 0x27c6ab25acaeb98bULL, },
> +        { 0x27abacb927ac2727ULL, 0x8d88a9e270165ee2ULL, },
> +        { 0x8da9705e27ac2727ULL, 0x8d88a9e270165ee2ULL, },
> +        { 0x8da9705e8d702727ULL, 0x8d88a9e270165ee2ULL, },
> +        { 0x8da9705e8d708d27ULL, 0x8d88a9e270165ee2ULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
> index e3997cd..ac75526 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
>          { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
>          { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },    /*  80  */
> +        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },    /*  88  */
> +        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x4b670b5efe7bb00cULL, },    /*  96  */
> +        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },
> +        { 0x4b670b5efe7bb00cULL, 0x12f7bb1a153f52fcULL, },
> +        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
> +        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
> +        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
> +        { 0x12f7bb1a153f52fcULL, 0x27d8c6ffab2b2514ULL, },    /* 104  */
> +        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
> +        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
> +        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
> index 2a29ac0..12c1fa1 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x12f7153ffbbe4d93ULL, 0x8df1a942704f5e31ULL, },
>          { 0x27d8ab2bac5ab9cfULL, 0x8df1a942704f5e31ULL, },
>          { 0x8df1a942704f5e31ULL, 0x8df1a942704f5e31ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x4b67fe7b886a2862ULL, 0x8df1704f8df1704fULL, },    /*  80  */
> +        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
> +        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
> +        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
> +        { 0x4b67fe7b886a2862ULL, 0x8df127d88df1704fULL, },
> +        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
> +        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
> +        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
> +        { 0x4b67fe7b886a2862ULL, 0x8df127d88df1704fULL, },    /*  88  */
> +        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
> +        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
> +        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
> +        { 0x4b67fe7b886a2862ULL, 0x8df127d88df1704fULL, },
> +        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
> +        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
> +        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
> +        { 0x8df127d88df1704fULL, 0x4b67fe7b886a2862ULL, },    /*  96  */
> +        { 0x4b67886a8df18df1ULL, 0x4b67fe7b886a2862ULL, },
> +        { 0x4b67886a4b678df1ULL, 0x4b67fe7b886a2862ULL, },
> +        { 0x4b67886a4b674b67ULL, 0x4b67fe7b886a2862ULL, },
> +        { 0x4b67886a4b674b67ULL, 0x12f7153ffbbe4d93ULL, },
> +        { 0x12f7fbbe4b674b67ULL, 0x12f7153ffbbe4d93ULL, },
> +        { 0x12f7fbbe12f74b67ULL, 0x12f7153ffbbe4d93ULL, },
> +        { 0x12f7fbbe12f712f7ULL, 0x12f7153ffbbe4d93ULL, },
> +        { 0x12f7fbbe12f712f7ULL, 0x27d8ab2bac5ab9cfULL, },    /* 104  */
> +        { 0x27d8ac5a12f712f7ULL, 0x27d8ab2bac5ab9cfULL, },
> +        { 0x27d8ac5a27d812f7ULL, 0x27d8ab2bac5ab9cfULL, },
> +        { 0x27d8ac5a27d827d8ULL, 0x27d8ab2bac5ab9cfULL, },
> +        { 0x27d8ac5a27d827d8ULL, 0x8df1a942704f5e31ULL, },
> +        { 0x8df1704f27d827d8ULL, 0x8df1a942704f5e31ULL, },
> +        { 0x8df1704f8df127d8ULL, 0x8df1a942704f5e31ULL, },
> +        { 0x8df1704f8df18df1ULL, 0x8df1a942704f5e31ULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/=
tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
> index a3fbe25..b8979c3 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x12f7bb1afbbe0063ULL, 0x8df188d8704f164dULL, },
>          { 0x27d8c6ffac5aaeaaULL, 0x8df188d8704f164dULL, },
>          { 0x8df188d8704f164dULL, 0x8df188d8704f164dULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },    /*  80  */
> +        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
> +        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
> +        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
> +        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },
> +        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
> +        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
> +        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
> +        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },    /*  88  */
> +        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
> +        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
> +        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
> +        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },
> +        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
> +        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
> +        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
> +        { 0x8df188d88df188d8ULL, 0x4b670b5e886ae6ccULL, },    /*  96  */
> +        { 0x4b670b5e8df188d8ULL, 0x4b670b5e886ae6ccULL, },
> +        { 0x4b670b5e4b670b5eULL, 0x4b670b5e886ae6ccULL, },
> +        { 0x4b670b5e4b670b5eULL, 0x4b670b5e886ae6ccULL, },
> +        { 0x4b670b5e4b670b5eULL, 0x12f7bb1afbbe0063ULL, },
> +        { 0x12f7bb1a4b670b5eULL, 0x12f7bb1afbbe0063ULL, },
> +        { 0x12f7bb1a12f7bb1aULL, 0x12f7bb1afbbe0063ULL, },
> +        { 0x12f7bb1a12f7bb1aULL, 0x12f7bb1afbbe0063ULL, },
> +        { 0x12f7bb1a12f7bb1aULL, 0x27d8c6ffac5aaeaaULL, },    /* 104  */
> +        { 0x27d8c6ff12f7bb1aULL, 0x27d8c6ffac5aaeaaULL, },
> +        { 0x27d8c6ff27d8c6ffULL, 0x27d8c6ffac5aaeaaULL, },
> +        { 0x27d8c6ff27d8c6ffULL, 0x27d8c6ffac5aaeaaULL, },
> +        { 0x27d8c6ff27d8c6ffULL, 0x8df188d8704f164dULL, },
> +        { 0x8df188d827d8c6ffULL, 0x8df188d8704f164dULL, },
> +        { 0x8df188d88df188d8ULL, 0x8df188d8704f164dULL, },
> +        { 0x8df188d88df188d8ULL, 0x8df188d8704f164dULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/t=
cg/mips/user/ase/msa/pack/test_msa_vshf_b.c
> index eedb7d8..1839a26 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>          { 0x8080808080808080ULL, 0x8080808080808080ULL, },
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x4040404040404040ULL, 0x4040404040404040ULL, },    /*  80  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x4040404040404040ULL, 0x4040404040404040ULL, },    /*  88  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/t=
cg/mips/user/ase/msa/pack/test_msa_vshf_d.c
> index 85a8f0d..ebc198f 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>          { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  80  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  88  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/t=
cg/mips/user/ase/msa/pack/test_msa_vshf_h.c
> index 8d416bc..a724013 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>          { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x5540554055405540ULL, 0x5540554055405540ULL, },    /*  80  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x5540554055405540ULL, 0x5540554055405540ULL, },    /*  88  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>      };
>
>      reset_msa_registers();
> diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/t=
cg/mips/user/ase/msa/pack/test_msa_vshf_w.c
> index fd8f02d..607ac4f 100644
> --- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
> +++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
> @@ -123,38 +123,38 @@ int32_t main(void)
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>          { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
>          { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
> -        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
> -        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
> -        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
> -        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
> -        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
> -        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
> -        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
> -        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
> -        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
> -        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
> -        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
> -        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
> -        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
> -        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
> -        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
> +        { 0x2862554028625540ULL, 0x2862554028625540ULL, },    /*  80  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x2862554028625540ULL, 0x2862554028625540ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x2862554028625540ULL, 0x2862554028625540ULL, },    /*  88  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x2862554028625540ULL, 0x2862554028625540ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
> +        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
>      };
>
>      reset_msa_registers();
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

