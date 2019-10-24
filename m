Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA8FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABCF21A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ra5oxM+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABCF21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNkdT-00014S-2f
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 17:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iNkc9-0006p8-Sg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 17:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iNkc6-0005Oo-Q7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 17:25:49 -0400
Received: from mail-oln040092071049.outbound.protection.outlook.com
 ([40.92.71.49]:9981 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iNkc6-0005NB-5c; Thu, 24 Oct 2019 17:25:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKQoJwnYJP6p5HP1y05B2uqtwzrceA9lIcarCX6zxgNYYHexavwwLgLy/kzMNU7xRwfJy8RjMCOL0S5OUVdWzAAJE9PdbGZCYexF7K7JKYdU6NqesNkRzqiLjwi0TZ/8FKXGYnUm4tvy0oL1PfEpn2hhNycr7iw6O5UjEWT5DyK1MLoJhgmQWwTkdcNJp2C8jgWirKOtlXDMpIoSCiGzpjoTbXNF2EomikYRZBnvh6fJTp7hVNGjLpZviRd52As2TRuVZXHZpb72/ZIylHD/uHpj3J9+xljVvQFB8HFs1qbrAQtnQs94S/lm+UH1x9tmNfs5iDRVuGbYg1T3UZ7Slg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ywqw6eSGlXZ9KcB1J0WjQr1MqW9mA7VLNlL1FBv2a4=;
 b=MU8hXCTyzcJXFBXoSq+HBO+Qo5/B9tpiTnGofPZ/web71PhLytooSm177nE7vdDKJf2xOVnxj8CZk0awCMJ9bQutbqaELJAc+3ogd1l/i02O54rUf0s+1S7A3ZxXiBW/hRdSLja54XYdCDHcQ7lJymkQsba/rRU7N3F5TjQgBGCXYTSm/8rg66sNuCvTIaENQjzDxnzdnBQXenkfJdBFXSgTD1FeKhRuAWRahgRO+hOmvqg6ldzM2FRXHtL9v++jQBxukq82t19AwX7EhU/bGeycgyxCYEF7CYmxega0iWDyGGHlwAVQ1bahzVUANLvPrZysk1ge9i14l8eWK4I4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ywqw6eSGlXZ9KcB1J0WjQr1MqW9mA7VLNlL1FBv2a4=;
 b=Ra5oxM+p0HAy0wfcA97dg0FriusoI0fdrpqzr76hNZCm+q8fH4Ajpo7LZWsu182HWV73j6ej1Eo5s8wPHFbneoRV5f7dL+MR7fITSwlFSqTkFWjsyr3z86sUDm76zP510asElm0+GYgRWRiosDYZEzPrIskHikAPXlmZe039uGQ+XfUS/FaKm51OSbNNmsHtz+HTCK/npl+6/mFdK+OuuWJH5WxB1bSn8pmlfD5pUXIFJeGJBrV4VHS/FnYQnv5hcuzHfmks1nJK6XmbwFmTZthxYEQ4zbRwnB94lboEZybYcOUq7qT9lZcMzuEWMaitLGzWZkKs8Epb8YCOj8xoag==
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (10.152.20.60) by DB5EUR03HT085.eop-EUR03.prod.protection.outlook.com
 (10.152.20.187) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.23; Thu, 24 Oct
 2019 21:25:43 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.20.57) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Thu, 24 Oct 2019 21:25:43 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 21:25:43 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfzB7lc3mC9pr0OyFBE/io6S3g==
Date: Thu, 24 Oct 2019 21:25:43 +0000
Message-ID: <VI1PR03MB48145025FFB7F3C64F93ABFAA46A0@VI1PR03MB4814.eurprd03.prod.outlook.com>
References: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
 <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <73ddcea3-0e0a-45be-55e7-bca81076c12d@redhat.com>
 <VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0@VI1PR03MB4814.eurprd03.prod.outlook.c>
In-Reply-To: <VI1PR03MB48149BEC6D7D02A08EECDE9BA46A0@VI1PR03MB4814.eurprd03.prod.outlook.c
 om>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0064.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::28) To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:8C3B14CA07CCD76CACE0CC2CFC33F84EA7D5363A799008F1A55192C3B13A7776;
 UpperCasedChecksum:241EAA4E4BD45E1B5DC56229E4FBB55EB3A18330D402BC409EEAEBC18EF8DA30;
 SizeAsReceived:7840; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [j7jK4zNeyMcUpdY2SanbnQgGYzp1I472MVV8kQyTYgs=]
x-microsoft-original-message-id: <1571952340.2552.3@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: DB5EUR03HT085:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1uvPDY2FehokjKkDQQN2GQ2SiGpvhAXBVYjtPfwOyXa9v9L+gNs4e0LvFeyvI/E4WDvs/0UxncO3eIx5H+WqG3EL9QjGBU6EOXGqxZWcyNNVyig4WRWfBTRLfzyxWvu6yfDHFui2jyDADIEaE9x0SJYeHzBQviuXrX3ppo/8rAaGFJLa6prpNjicUJCmH5o
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F50C559CF5FAAA4E8FA04F9FC71B6CF5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: da0458e9-b6ee-4448-492c-08d758c8b995
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 21:25:43.1343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT085
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.71.49
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
Cc: Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BTW just to be clear, qemu is crashing in this scenario *only* if=20
iothread is enabled for the guest.
Without iothread enabled the operation is completed without any=20
problems.

On jue, oct 24, 2019 at 11:07 PM, Fernando Casas Sch=F6ssow=20
<casasfernando@outlook.com> wrote:
> Today I updated to qemu 4.0.1 since this was the latest version=20
> available for Alpine and I can confirm that I can repro the issue=20
> with this version as well.
> Not sure if relevant but I can also confirm that the problem happens=20
> with Windows Server 2012 R2 but also with Linux guests (it doesn't=20
> matter if the guest use uefi or bios firmware). I made this tests=20
> just to discard things.
>=20
> Also as discussed I compiled qemu with debug symbols, repro the=20
> problem, collected a core dump and run both through gdb. This is the=20
> result:
>=20
> (gdb) thread apply all bt
>=20
> Thread 42 (LWP 33704):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fee02380b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 41 (LWP 33837):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1ad5b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 40 (LWP 33719):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fee02266b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 39 (LWP 33696):
> #0 0x00007fee04233171 in syscall () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee02be8b64 in ?? ()
> #2 0x0000000000000030 in ?? ()
> #3 0x00007fee02be2540 in ?? ()
> #4 0x00007fee02be2500 in ?? ()
> #5 0x00007fee02be2548 in ?? ()
> #6 0x000055d7e4987f28 in rcu_gp_event ()
> #7 0x0000000000000000 in ?? ()
>=20
> Thread 38 (LWP 33839):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1a83b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 37 (LWP 33841):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1737b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 36 (LWP 33863):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8c83b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 35 (LWP 33842):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc170eb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 34 (LWP 33862):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8cacb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 33 (LWP 33843):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc16e5b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 32 (LWP 33861):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8cd5b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 31 (LWP 33844):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc16bcb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 30 (LWP 33858):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8e83b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 29 (LWP 33845):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1693b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 28 (LWP 33857):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8eacb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 27 (LWP 33846):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc166ab64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 26 (LWP 33856):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8ed5b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 25 (LWP 33847):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc142ab64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 24 (LWP 33855):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8efeb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 23 (LWP 33848):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedbd0feb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 22 (LWP 33854):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedbd031b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 21 (LWP 33849):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedbd0d5b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 20 (LWP 33852):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedbd05ab64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 19 (LWP 33850):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedbd0acb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 18 (LWP 33851):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedbd083b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 17 (LWP 33836):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1afeb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 16 (LWP 33835):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1c5ab64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 15 (LWP 33834):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1c83b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 14 (LWP 33833):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1cacb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 13 (LWP 33677):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x000055d7e516656c in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 12 (LWP 33832):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1cd5b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 11 (LWP 33831):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1cfeb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 10 (LWP 33829):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1e67b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 9 (LWP 33828):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1e90b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 8 (LWP 33827):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fee02a95b64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 7 (LWP 33732):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fee0223db64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 6 (LWP 33706):
> #0 0x00007fee0423263d in ioctl () from /lib/ld-musl-x86_64.so.1
> #1 0x0000000000000001 in ?? ()
> #2 0x00007fee00000010 in ?? ()
> #3 0x00007fee02351440 in ?? ()
> #4 0x00007fee02351400 in ?? ()
> #5 0x0000000000000000 in ?? ()
>=20
> Thread 5 (LWP 33838):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1aacb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 4 (LWP 33860):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8cfeb64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 3 (LWP 33859):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedb8e5ab64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 2 (LWP 33840):
> #0 0x00007fee04252080 in ?? () from /lib/ld-musl-x86_64.so.1
> #1 0x00007fee0424f4b6 in ?? () from /lib/ld-musl-x86_64.so.1
> #2 0x00007fedc1a5ab64 in ?? ()
> #3 0x0000000000000000 in ?? ()
>=20
> Thread 1 (LWP 33701):
> #0 0x00007fee0421b7a1 in abort () from /lib/ld-musl-x86_64.so.1
> #1 0x000055d7e6012b70 in ?? ()
> #2 0x0000000000000020 in ?? ()
> #3 0x0000000000000000 in ?? ()
> (gdb)
>=20
>=20
> I'm not a developer nor skilled with gdb but if you provide me the=20
> debugging commands I can execute them and reply back with the results.
> I can also provide the binary and the core dump for analysis if=20
> needed.
>=20
> While waiting for replies I will check if I can upgrade to qemu=20
> 4.1.0, try to repro and provide the results.
>=20
> Thanks.
>=20
> Fernando
>=20
> On mi=E9, oct 23, 2019 at 7:57 PM, Fernando Casas Sch=F6ssow=20
> <casasfernando@outlook.com> wrote:
>> In virsh I would do this while the guest is running:
>>=20
>> virsh attach-disk <vmname> <path_to_ISO_file> <guest_device> --type=20
>> cdrom --mode readonly
>>=20
>> Following the example for guest from my first email:
>>=20
>> virsh attach-disk DCHOMENET01=20
>> /resources/virtio-win-0.1.171-stable.iso sdb --type cdrom --mode=20
>> readonly
>>=20
>> Right after executing this, qemu crashes and log the assertion.
>> I can repro this also from virt-manager by selecting the cdrom=20
>> device -> Connect -> selecting the ISO file -> Choose volume -> Ok=20
>> (basically the same but in the gui).
>>=20
>> I may be able to try 4.1. Will look into it and report back.
>>=20
>> On mi=E9, oct 23, 2019 at 7:33 PM, John Snow <jsnow@redhat.com> wrote:
>>>=20
>>>=20
>>> On 10/23/19 1:28 PM, Fernando Casas Sch=F6ssow wrote:
>>>>  Hi John,
>>>>=20
>>>>  Thanks for looking into this.
>>>>  I can quickly repro the problem with qemu 4.0 binary with=20
>>>> debugging
>>>>  symbols enabled as I have it available already.
>>>>  Doing the same with qemu 4.1 or development head may be too much=20
>>>> hassle
>>>>  but if it's really the only way I can give it try.
>>>>=20
>>>>  Would it worth it to try with 4.0 first and get the strack trace=20
>>>> or it
>>>>  will not help and the only way to go is with 4.1 (or dev)?
>>>>=20
>>>>  Thanks,
>>>>=20
>>>>  Fernando
>>>>=20
>>>=20
>>> If 4.0 is what you have access to, having the stack trace for that=20
>>> is
>>> better than not, but confirming it happens on the latest release=20
>>> would
>>> be nice.
>>>=20
>>> Can you share your workflow for virsh that reproduces the failure?
>>>=20
>>> --js
>>>=20
>>>>  On mi=E9, oct 23, 2019 at 5:34 PM, John Snow <jsnow@redhat.com>=20
>>>> wrote:
>>>>>  On 10/18/19 5:41 PM, Fernando Casas Sch=F6ssow wrote:
>>>>>=20
>>>>>      Hi,
>>>>>=20
>>>>>  Hi! Thanks for the report.
>>>>>=20
>>>>>      Today while working with two different Windows Server 2012 R2
>>>>>      guests I found that when I try to attach an ISO file to a=20
>>>>> SCSI
>>>>>      CD-ROM device through libvirt (virsh or virt-manager) while=20
>>>>> the
>>>>>      guest is running, qemu crashes and the following message is
>>>>>      logged: Assertion failed: blk_get_aio_context(d->conf.blk) =3D=
=3D
>>>>>      s->ctx
>>>>>     =20
>>>>> (/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/virtio-scsi.=
c:
>>>>>      virtio_scsi_ctx_check: 246) I can repro this at will. All I=20
>>>>> have
>>>>>      to do is to try to attach an ISO file to the SCSI CDROM=20
>>>>> while the
>>>>>      guest is running. The SCSI controller model is virtio-scsi=20
>>>>> with
>>>>>      iothread enabled. Please find below all the details about my=20
>>>>> setup
>>>>>      that I considered relevant but I missed something please=20
>>>>> don't
>>>>>      hesitate to let me know:
>>>>>=20
>>>>>  Looks like we got aio_context management wrong with iothread for=20
>>>>> the
>>>>>  media change events somewhere. Should be easy enough to fix if we
>>>>>  figure out where the bad assumption is.
>>>>>=20
>>>>>      Host arch: x86_64 Distro: Alpine Linux 3.10.2 qemu version:=20
>>>>> 4.0
>>>>>=20
>>>>>  Do you have the ability to try 4.1, or the latest development=20
>>>>> head
>>>>>  with debugging symbols enabled?
>>>>>=20
>>>>>      Linux kernel version: 4.19.67 libvirt: 5.5.0 Emulated SCSI
>>>>>      controller: virtio-scsi (with iothread enabled) Guest=20
>>>>> firmware:
>>>>>      OVMF-EFI Guest OS: Window Server 2012 R2 Guest virtio drivers
>>>>>      version: 171 (current stable) qemu command line:
>>>>>      /usr/bin/qemu-system-x86_64 -name
>>>>>      guest=3DDCHOMENET01,debug-threads=3Don -S -object
>>>>>     =20
>>>>> secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/doma=
in-78-DCHOMENET01/master-key.aes
>>>>>      -machine pc-i440fx-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Do=
n=20
>>>>> -cpu
>>>>>     =20
>>>>> IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_a=
djust=3Don,umip=3Don,xsaveopt=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=
=3D0x1fff
>>>>>      -drive
>>>>>     =20
>>>>> file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash=
,format=3Draw,unit=3D0,readonly=3Don
>>>>>      -drive
>>>>>     =20
>>>>> file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=3Dpflash,fo=
rmat=3Draw,unit=3D1
>>>>>      -m 1536 -overcommit mem-lock=3Doff -smp
>>>>>      1,sockets=3D1,cores=3D1,threads=3D1 -object iothread,id=3Diothre=
ad1=20
>>>>> -uuid
>>>>>      f06978ad-2734-44ab-a518-5dfcf71d625e -no-user-config=20
>>>>> -nodefaults
>>>>>      -chardev socket,id=3Dcharmonitor,fd=3D33,server,nowait -mon
>>>>>      chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
>>>>>      base=3Dlocaltime,driftfix=3Dslew -global
>>>>>      kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global
>>>>>      PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot
>>>>>      strict=3Don -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x4 -d=
evice
>>>>>     =20
>>>>> virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,num_queues=3D1,bus=3D=
pci.0,addr=3D0x5
>>>>>      -device=20
>>>>> virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6
>>>>>      -drive
>>>>>     =20
>>>>> file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomenet01.qcow=
2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dnone,discard=3Dun=
map,aio=3Dthreads
>>>>>      -device
>>>>>     =20
>>>>> scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Ddri=
ve-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,wri=
te-cache=3Don
>>>>>      -drive if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -device
>>>>>     =20
>>>>> scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddri=
ve-scsi0-0-0-1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1
>>>>>      -netdev tap,fd=3D41,id=3Dhostnet0,vhost=3Don,vhostfd=3D43 -devic=
e
>>>>>     =20
>>>>> virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:b5:62,bu=
s=3Dpci.0,addr=3D0x3
>>>>>      -chardev
>>>>>     =20
>>>>> socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4900,telnet,server,no=
wait=20
>>>>> -device
>>>>>      isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
>>>>>      spicevmc,id=3Dcharchannel0,name=3Dvdagent -device
>>>>>     =20
>>>>> virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,i=
d=3Dchannel0,name=3Dcom.redhat.spice.0
>>>>>      -chardev socket,id=3Dcharchannel1,fd=3D45,server,nowait -device
>>>>>     =20
>>>>> virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,i=
d=3Dchannel1,name=3Dorg.qemu.guest_agent.0
>>>>>      -chardev=20
>>>>> spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.0
>>>>>      -device
>>>>>     =20
>>>>> virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dcharchannel2,i=
d=3Dchannel2,name=3Dorg.spice-space.webdav.0
>>>>>      -device virtio-tablet-pci,id=3Dinput2,bus=3Dpci.0,addr=3D0x7 -sp=
ice
>>>>>     =20
>>>>> port=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Do=
n
>>>>>      -device
>>>>>     =20
>>>>> qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_s=
ize_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
>>>>>      -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device
>>>>>      usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2=
=20
>>>>> -chardev
>>>>>      spicevmc,id=3Dcharredir1,name=3Dusbredir -device
>>>>>      usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3=
=20
>>>>> -device
>>>>>      virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -sandbox
>>>>>     =20
>>>>> on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecont=
rol=3Ddeny
>>>>>      -msg timestamp=3Don I can provide a core dump of the process if
>>>>>      needed for debugging and the guest XML as well.
>>>>>=20
>>>>>  A backtrace is probably a great starting point (from gdb: `thread
>>>>>  apply all bt`.) I don't know exactly what codepath is being=20
>>>>> exercised
>>>>>  when you "attach an ISO file" through libvirt's interface. If you
>>>>>  don't mind the hassle, trying on the 4.1 (or a development build=20
>>>>> would
>>>>>  be even more luxurious) and giving a stacktrace would be nice.
>>>>>=20
>>>>>      Thanks. Fernando
>>>>>=20
>>>>>  Thanks! --js
>>>>=20
>>>>=20
>>>=20
>>=20
>>=20
>=20
>=20
>=20





