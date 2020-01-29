Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD841C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DFF20663
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livekentac.onmicrosoft.com header.i=@livekentac.onmicrosoft.com header.b="rknjO8zY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DFF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmPw-0006YE-OT
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iwmKj-00063k-Vb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iwmKh-0005lq-37
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:20:37 -0500
Received: from mail-db8eur05on2055.outbound.protection.outlook.com
 ([40.107.20.55]:18944 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iwmKg-0005gH-OI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:20:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8rUHdlnFNgUlJwfaE6oNMshWx4YvUlwT425IxYeuT/3hwIQf6aDUMRDr2BPz2BTKpHAlF05CyVI0snzZpNZee+It2YoHbe0shitRGM2AfVkx593x+rvzIvzNQUm33uH55uyu0iATM6jcSVu91+IiiVsvyM6KX1LnZo7VfcgFEpbVPwjZqwkBqh7Ac9p/qnzP+X5fLHkG5Po2f3UGmAhEl4R49PA10JjNOZ7h3jdlA6PtzBx0zl8mFRfggYYJKL8GaotPHJpu4Na6itk1YjH9zDH8YwdgL0gyFZPOY9ibKGPfD2KvQGfaX0OBGEpBB7JqgEbGS7BsSBsBsG5lzb5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXy1+bG7IhcmJv5H1qw+LUc0sxg0u+2kezRpgLpUK3k=;
 b=LlXkVohpD2dvmX6641RyWMzt4eluB1ldl9BcN/UrcvpKI+Qu7nKWjHkWO7s+uUYf4jOS21RygX4C0a9/78W9uu71Y2iICzFU7zwdOviEPE7mtqd7P/qrf/yqdeFxd7jETpXmK2/4V3XqP1Lmjr0KTcyXgm9oryJ2br9jMLulf0cHR0xldF02OTEiOJQXZo+rRy1ffRVCiQyART59XceYCs9QEUrhNloAYOeGMT8UsL/P7Jo8EprTkGKaB/I7cHFGPcTx2hU0cClbTCCfIg47gG4uvv+AETqrmRP+Ur4Rk+NI9CwWwU76cKw4ddjKZW/mvDXzQEXpV2Rwzg69FIfVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kent.ac.uk; dmarc=pass action=none header.from=kent.ac.uk;
 dkim=pass header.d=kent.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livekentac.onmicrosoft.com; s=selector2-livekentac-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXy1+bG7IhcmJv5H1qw+LUc0sxg0u+2kezRpgLpUK3k=;
 b=rknjO8zYzrfZvgZlitLlYMXZYSgUK+4oFp3jydK+9f03eExipY3MnMMsxdku1uQ4KRHFcJ4XPWKco0c39d+egf6xjz3lfwC2t/rDSyIQYnRmW+fdKLbgwUGHzyBn+jwAkfFLXSIMoXmK/BMfgEFpqzH7a934SBcdLzqRLJZdelE=
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com (52.135.135.22) by
 DB7PR01MB4888.eurprd01.prod.exchangelabs.com (20.177.194.30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Wed, 29 Jan 2020 12:20:32 +0000
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::8072:b37a:57c5:7d6a]) by DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::8072:b37a:57c5:7d6a%7]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 12:20:31 +0000
Received: from cadance (129.12.219.226) by
 LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 12:20:31 +0000
From: Sarah Harris <seh53@kent.ac.uk>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
Thread-Topic: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
Thread-Index: AQHV1J47a4uND1pADE+dzwZXZENV4agBk+IA
Date: Wed, 29 Jan 2020 12:20:31 +0000
Message-ID: <20200129122058.3714c0c4195afc62fc0ce297@kent.ac.uk>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=S.E.Harris@kent.ac.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [129.12.219.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b4cc1ad-d967-4e49-b111-08d7a4b5a23f
x-ms-traffictypediagnostic: DB7PR01MB4888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR01MB48885E8894A59C48BF0319B9F7050@DB7PR01MB4888.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(52116002)(6496006)(66946007)(66556008)(66476007)(64756008)(66446008)(71200400001)(478600001)(4326008)(16526019)(2906002)(186003)(1076003)(36756003)(81166006)(81156014)(8936002)(8676002)(316002)(26005)(6916009)(786003)(966005)(6486002)(5660300002)(54906003)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR01MB4888;
 H:DB7PR01MB4348.eurprd01.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: kent.ac.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YIga75DhMdfU89uG4cLMJy9EPZbYRfieqOuVWqPNLVPRjs+sYKvSN0g4fiWlcjbcF96jsbqgd1rjAiHCORvBj9EpR0k+8MZrWzkbCaTf2Ma/HmkAIqKskirl8BhWmC05ofsWQIueLSW587vRhQlNArEwAxfxqmTNTb0jjdH4kzzX3KSg0tSAmXUOZp8BVxARwlmWH3ampuLh9xB9IDHzvWEzYZx2/SDVbh0ey2cWyUqcqrUoAjtIuJQvtFDScQJpn9k2zlV50zQxHZDFkJXzYS7AcTNe04W0sv8G6foTyRPvuCksV6ovOt9nyTzYhn4Fy2ioAQSMlx4AgNJ4QIz5TH4AbfkMb8arQ2PbcQ5owy9/fLXmnONflTtcXBOyfGEFxzb423qrX3h0TqK1ZlZbhizrQMxSm0UVzj1cA4QuHYus4ieG9ICHF40woHDpou8W8Gn+xWXZs6KKTFxCkpRXk+48CW7u2wDXKODbLewZBvaKcA6yb3kL3jx6mhrJVul6TgRbIBlqiRbe0G6N9C4kQ==
x-ms-exchange-antispam-messagedata: ZeEtfc/EeyjpKsTpN1mgoR9UkRNBUnHiCO60j+g5/pGxhmsV6iBS8UG4WTeeelM08f5AVJOm1SeWthiSRQHnMx6CL6GfafbYjcitnAvj/Y4bwCHPtGH+u44/ImZR/w2pj/mbqfthMxuVZTrxyvMouw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34D86D2205855B4A8107B77683831B4B@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kent.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4cc1ad-d967-4e49-b111-08d7a4b5a23f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 12:20:31.7717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 51a9fa56-3f32-449a-a721-3e3f49aa5e9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Jw/MtYQPZrMc3vYX/ATnvMa5Msie79e6dMq7cL0XIyqmQ+WFfepRTsMQCcAgJ98uU+6VvFIgjVHRdOnGI1M+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4888
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.55
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "S.Harris" <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I think I've found a minor bug: the stack pointer should be initialised to =
the size of SRAM in some or most cases.
Currently, SP is initialised to zero.

It seems modern AVRs set SP to the size of SRAM (RAMEND) at power-on, thoug=
h a few older ones initialise to zero.
The ATmega328 (from 2009) [1], ATmega2560 (from 2005) [2], ATtiny2313 (from=
 2003) [6], and ATtiny85 (from 2005) [3] all use RAMEND.
The ATmega8 (from 2001) [4], ATmega8535 (from 2002) [5], and AT90S8535 (fro=
m 1998) [7] use zero.
I haven't found a list of which AVRs use which value (other than reading ev=
ery datasheet).

Given that GCC performs this initialisation in software anyway (so what the=
 hardware does doesn't matter), I think this is a minor issue.
It will only affect hand written assembly programs that don't do their own =
initialisation (which seems to be discouraged as not all resets are power-o=
n events).
I'm not sure what, if anything, needs to be done about it but it might be w=
orth fixing now we're emulating specific chips.

Kind regards,
Sarah Harris

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-M=
icrocontrollers-ATmega328P_Datasheet.pdf (section 6.5.1)
[2] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Mi=
crocontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf (section 7.6)
[3] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Mi=
crocontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf (section 4.6.1)
[4] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2486-8-bit-AVR-mi=
crocontroller-ATmega8_L_datasheet.pdf (page 13)
[5] http://ww1.microchip.com/downloads/en/DeviceDoc/doc2502.pdf (page 12)
[6] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2543-AVR-ATtiny23=
13_Datasheet.pdf (page 11)
[7] http://ww1.microchip.com/downloads/en/DeviceDoc/doc1041.pdf (page 20)

On Sun, 26 Jan 2020 23:54:43 +0100
Aleksandar Markovic <aleksandar.markovic@rt-rk.com> wrote:

> +static void avr_cpu_reset(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    mcc->parent_reset(cs);
> +
> +    env->pc_w =3D 0;
> +    env->sregI =3D 1;
> +    env->sregC =3D 0;
> +    env->sregZ =3D 0;
> +    env->sregN =3D 0;
> +    env->sregV =3D 0;
> +    env->sregS =3D 0;
> +    env->sregH =3D 0;
> +    env->sregT =3D 0;
> +
> +    env->rampD =3D 0;
> +    env->rampX =3D 0;
> +    env->rampY =3D 0;
> +    env->rampZ =3D 0;
> +    env->eind =3D 0;
> +    env->sp =3D 0;
> +
> +    env->skip =3D 0;
> +
> +    memset(env->r, 0, sizeof(env->r));
> +
> +    tlb_flush(cs);
> +}

