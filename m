Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D9C76194
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E522E21921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="uAxDGDLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E522E21921
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYcz-0000wZ-1P
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hpYcl-0000Xq-KO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hpYck-0000Ct-Eg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:45:07 -0400
Received: from mail-eopbgr710136.outbound.protection.outlook.com
 ([40.107.71.136]:60056 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hpYck-0000C3-7F
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxZ72AVKp2qnxN0p32lxeusa71vcsYH44XSlt+VLRgMvXZ5EGj/0h106/UlMJc7lu4Kqg4OeXuwM3g2g/7CakOVceWLDqS44SGZ7V/L6YkN0MsyV3zhtyTGngkQDTw4YdSRJPKxXYs3P7LutpeBY9wvYBCSAwkZgz8uP2A7I2n0SrahHGKFJ2qWhr4Lx6InHLU/r14fvJ5VsBMWcX0QK0YDHesSWH8V5ONolXoAiovWMSGzuacrh0o1VQl0H17vLeYPsmHGw/6Ul2GKunRnr+cDbVrjtg05J/SdnA2tXlcMLFvmt31ZccDOJEgW5er+oQiZina8bsbma8V815zw07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKnMRXuRBaQNeZENukaECpfeisq5zDPLpCFEx4fmVOk=;
 b=UIOImYTnY/mw6rL0akLz3u1v+31GWrkzaJvyHMAuoIqjNNAdPfh0bDXlz0rZe7j4jN8KiSIH1VxPsKKtcmBDJni/1pDeHPJMKNXJY6bUMqDoS5OZgnKi9IS3UUGZr8xaPXmf2hL6fjnDt0qW+J4/BIfJVtPM1zvGrvvf2T16Pd4oYVIUXJvWViFGEacprD4KtlqzbGL/bILHiFGBFAlI3tlTpmXpA0lqraPp1t9CpNyhRXoifKdbzitH6r2fubkRnmnEnVLkzyYAOpyOPvFEAY4kX5gq6JXLKldUhGc93nBBo0SWuAGeOXDwbl5XCNnz1dSOmZQYgqPAV2LmMVHL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector2-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKnMRXuRBaQNeZENukaECpfeisq5zDPLpCFEx4fmVOk=;
 b=uAxDGDLes1brqwJYRspjeq/AOc3Dd40B0Qe8r/hD4Fvs7ljF7BIt11WZZyTXS39tZ50SI8GPoZM5GQZE2sbNyG42c+AurZngqJmKM11nvzaCCBm4rJldZBYWbsvqy1ApV4MGgIKiLljTk14d+QtPLFwuBbf67N++7R2Yg5cSUxs=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0682.namprd22.prod.outlook.com (10.172.187.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Mon, 22 Jul 2019 13:45:04 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::447b:e0b5:5b86:985b]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::447b:e0b5:5b86:985b%7]) with mapi id 15.20.2073.012; Mon, 22 Jul 2019
 13:45:04 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH for 4.1 v4 1/5] target/mips: Add 'fall through' comments
 for handling nanoMips' SHXS, SWXS
Thread-Index: AQHVO0gF5o4b5GnknUauMd63uzPwX6bWsEyJ
Date: Mon, 22 Jul 2019 13:45:03 +0000
Message-ID: <DM5PR22MB1658003954D6EEADE15FFDBBD2C40@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1563220847-14630-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1563220847-14630-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1563220847-14630-2-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c10c079-ecca-411a-2aee-08d70eaacce4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0682; 
x-ms-traffictypediagnostic: DM5PR22MB0682:
x-microsoft-antispam-prvs: <DM5PR22MB06829EBEAD88629383785E8BD2C40@DM5PR22MB0682.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39840400004)(136003)(366004)(376002)(199004)(189003)(2906002)(76116006)(64756008)(66446008)(2501003)(66556008)(66476007)(54906003)(256004)(25786009)(7696005)(66946007)(110136005)(91956017)(6506007)(53546011)(55236004)(478600001)(76176011)(5660300002)(26005)(4326008)(186003)(486006)(102836004)(71190400001)(71200400001)(476003)(11346002)(99286004)(446003)(6246003)(8936002)(6436002)(33656002)(7736002)(107886003)(74316002)(53936002)(229853002)(68736007)(81166006)(3846002)(19627405001)(86362001)(81156014)(6606003)(14454004)(316002)(54896002)(66066001)(9686003)(6116002)(8676002)(52536014)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0682;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O/7BoDhuZad+hs794Y/QPBuvjwdWA20kgK6XMXTHSMwZdXC9S2nqV0lCcYI5zHpGE1lm0oGsoO+/R6E8Fs5UEITzOkwLuoVDWiDhN+e6tZM8EUahXDX3bV0SctYftZEE+IeJHSwUP7Ycf2dFVXRdHQU0lxu4h4hFHWniWiS1aPBZMrm+dJigyaHJY/nczbQrhsXZNC1NnOn6ai5ysPC1SUkMOsrhAUHh1yEsEihGR9EHsNvrP8XGYDedollEW0w39AuNVWZBu2FaSrz3nyzZ642Mx1c4ea+NBznfC74FYrEJrF6tOyd9tZmzYiDKru8apiE+85D8YBwhMHiRGkMWLE+u+HAoWfbJd6fPSDxrFfP7Jr58/g4GuENB3IofTWu1nWZjfAQSmEQKsMfcq88cGr3RbSNyHDBsQu0F4XvaDVQ=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c10c079-ecca-411a-2aee-08d70eaacce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:45:03.9789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0682
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.136
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH for 4.1 v4 1/5] target/mips: Add 'fall
 through' comments for handling nanoMips' SHXS, SWXS
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
> Subject: [PATCH for 4.1 v4 1/5] target/mips: Add 'fall through' comments =
for handling nanoMips' SHXS, SWXS
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This was found by GCC 8.3 static analysis.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f96f141..2be5e2d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20136,12 +20136,14 @@ static void gen_p_lsx(DisasContext *ctx, int rd=
, int rs, int rt)
>          switch (extract32(ctx->opcode, 7, 4)) {
>          case NM_SHXS:
>              check_nms(ctx);
> +            /* fall through */
>          case NM_LHXS:
>          case NM_LHUXS:
>              tcg_gen_shli_tl(t0, t0, 1);
>              break;
>          case NM_SWXS:
>              check_nms(ctx);
> +            /* fall through */
>          case NM_LWXS:
>          case NM_LWC1XS:
>          case NM_SWC1XS:
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

