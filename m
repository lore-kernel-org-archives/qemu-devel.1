Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF538C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BECB206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livekentac.onmicrosoft.com header.i=@livekentac.onmicrosoft.com header.b="QdpYmtYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BECB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuxkX-0002QA-N3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iuxjv-00020T-OJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iuxju-0007bf-Cn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:07:07 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com
 ([40.107.15.70]:24448 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iuxju-0007ZX-3p; Fri, 24 Jan 2020 07:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg3fW1Zs7sdwKW0pVjZDhMk4q0FF0BhUk6rIC5/zfCWIoT0e5v0ChVkfSaeW4wza42I3RNiidhcX48KQIqzAWHzxsS4Z5zRekhlDa3qwCI7ov6wt3mYNgzoGdmFtxpU1wwfHZxZXxvwLHVVB/ulIpDxB+caOpRvdwsncIElJFGvanrXgsMrGDxATI2bNRsqvXcVeyD0Or5Dch1Na5t4hD4oguTnu+hoOytfepMDb9tNM76UTPe8KTG+dNiEAnh5s86jrMlPoDkMZ7GzC4pWEwqtYQv4p93ntZqhyCGbmjKQIRwebfnZsXXvfkGjO/WYG18dUUCQt0PDNDNu3PldiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI0mltqYSISy/I024hlvmGm/UPqF0z6LfE11Hx65y+w=;
 b=WOAkEO6K4d5/XinSPo+bWyAaUxJCC62Br2IVbl1YGuYiWQ+5fnUHGm5cuF39BxfBZapgo1SZkaTOkUUwh0CLEAIr4W0JEQF9/rZcVGT87P55n3uM2FIAFdNryP+nFiDNY83fheQpbmyxwpb9YEN99mOCal4GtHvpA+YDY4QmyLAJP+Xl3dq27SqTgbII/zzTUcnF4+aRdP4WghxGlft/bF2Dxoev9dIRayT2RVSVgUuyUHEFKKqNcTpE5on4wJR+jg/fu3ibMQm7BVVCa2GRdwtC7yGQtD690VyH3A9x/YbvU8IizHRIR9Jnd/HN7MbnbhyMx/URknervnH7W0n3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kent.ac.uk; dmarc=pass action=none header.from=kent.ac.uk;
 dkim=pass header.d=kent.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livekentac.onmicrosoft.com; s=selector2-livekentac-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI0mltqYSISy/I024hlvmGm/UPqF0z6LfE11Hx65y+w=;
 b=QdpYmtYJHKUH0cUdxqwrHq54cZDKN2rffZNchAAX1n4LusCFvHIgLphrsWN0tGFY6A0c9NmFQY8+lJaEsSBOcl1EIrycLM9/QuGdac98xQwnJv9eNAEcIzAUwJNGB+9EistY2UMQAJa1sCwiqzoHc4SNQYhmv5jl1JOSlsFtqcs=
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com (52.135.135.22) by
 DB7PR01MB5180.eurprd01.prod.exchangelabs.com (20.178.107.30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 24 Jan 2020 12:07:02 +0000
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::8072:b37a:57c5:7d6a]) by DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::8072:b37a:57c5:7d6a%7]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 12:07:02 +0000
Received: from cadance (129.12.216.170) by
 LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Fri, 24 Jan 2020 12:07:01 +0000
From: Sarah Harris <seh53@kent.ac.uk>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH rc2 12/25] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
Thread-Topic: [PATCH rc2 12/25] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
Thread-Index: AQHV0lCDRBxm0GoaUk2I8zLlB2gHJ6f5oUaAgAACfICAABVHAA==
Date: Fri, 24 Jan 2020 12:07:02 +0000
Message-ID: <20200124120722.705ae8bac5cfc939dae2db5f@kent.ac.uk>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-13-f4bug@amsat.org>	<875zh1yw38.fsf@linaro.org>
 <790c5181-c4b0-ea7b-f4e4-07bacae220b2@redhat.com>
In-Reply-To: <790c5181-c4b0-ea7b-f4e4-07bacae220b2@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::32) To DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=S.E.Harris@kent.ac.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [129.12.216.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc000f6d-c802-44d1-7872-08d7a0c5eba3
x-ms-traffictypediagnostic: DB7PR01MB5180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR01MB518050F1F06F88E40849206BF70E0@DB7PR01MB5180.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(36756003)(52116002)(64756008)(66476007)(66556008)(53546011)(66946007)(6496006)(71200400001)(66446008)(786003)(16526019)(7416002)(316002)(26005)(186003)(54906003)(2616005)(956004)(8936002)(81166006)(6486002)(8676002)(81156014)(4326008)(1076003)(2906002)(478600001)(6916009)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR01MB5180;
 H:DB7PR01MB4348.eurprd01.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: kent.ac.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4C1aQD9gUShEJuTmBDRUMvsD6HZlt4gCliqcXtExvrjqgXLd+PPZkaB79cRb/ywrekv+/V4c8BTjeE6k41CuGHzvuPLGWUoZ5iykFW+tYRAE27GgILpdlTHoHRxu/jzhIulcCeAImXBF9UTXQyBWTj4WiNKlWWuMRn0LWIXdg5DU34kmAOw0JZZxV9URt3xpz6txenSLXbc3SodPiwHEM5ORvJjkuUmrxCb+ga1/pFLgESX3lE9Q8jjEFYf/q5yezxHEgjeV9bvZzxk17CSn/vmtKgX8DFkpf8RkZapTCWF0bLEv9k4VydMO6QUXoc1yKaLJ0dB1039otKtUrP1wowBnPh9XXiwqJFZPYMqqfpnk5Vtmh5bYsfj0WN5EsnlYJPtM7Rl/3qFJxqo0ErSPsCcQgC1HGQlqFATjYCnOMmyK+bgnKnEq6RdAlgDba8/a
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EC46ED32E308594085092F62ADCA09F7@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kent.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: fc000f6d-c802-44d1-7872-08d7a0c5eba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 12:07:02.4513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 51a9fa56-3f32-449a-a721-3e3f49aa5e9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmP9/GjTXVRE9oQhmj3aEtniZUUdyWPpNJaR9v3uzEYWvJaW79aFHLs9iD+64IpbDdmqV2xnQB4vXIfnxMZGZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB5180
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.70
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
Cc: Fam Zheng <fam@euphon.net>, "S.Harris" <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, "E.Robbins" <E.J.C.Robbins@kent.ac.uk>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Do I understand correctly that you need Ed to email a "Signed-off-by: Ed Ro=
bbins <email>" himself?
Ed's cc'ed already, but I'll email him directly to make sure he's seen this=
 discussion.

Sarah

On Fri, 24 Jan 2020 11:51:13 +0100
Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:

> Hello Sarah,
>=20
> On 1/24/20 11:42 AM, Alex Benn=E9e wrote:
> >=20
> > Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
> >=20
> >> From: Michael Rolnik <mrolnik@gmail.com>
> >>
> >> These were designed to facilitate testing but should provide enough
> >> function to be useful in other contexts.  Only a subset of the functio=
ns
> >> of each peripheral is implemented, mainly due to the lack of a standar=
d
> >> way to handle electrical connections (like GPIO pins).
> >>
> >> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> >> Message-Id: <20200118191416.19934-13-mrolnik@gmail.com>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> [rth: Squash info mtree fixes and a file rename from f4bug, which was:=
]
> >> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> [PMD: Use qemu_log_mask(LOG_UNIMP), replace goto by return]
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> > <snip>
> >> --- /dev/null
> >> +++ b/include/hw/timer/atmel_timer16.h
> >> @@ -0,0 +1,94 @@
> >> +/*
> >> + * Atmel AVR 16 bit timer
> >> + *
> >> + * Copyright (c) 2018 University of Kent
> >> + * Author: Ed Robbins
> >=20
> > No sign off from the author here?
>=20
> Hmmm I Sarah Harris's one, who is from the University of Kent, isn't it=20
> enough? (I remember patched from Xilinx with Edgar S-o-b but from other=20
> authors, Edgar vouched for Xilinx).
>=20
> Sarah, can you get Ed Signed-off-by?
>=20
> >> --- /dev/null
> >> +++ b/hw/timer/atmel_timer16.c
> >> @@ -0,0 +1,605 @@
> > <snip>
> >> +
> >> +/* Helper macros */
> >> +#define VAL16(l, h) ((h << 8) | l)
> >> +#define DB_PRINT(fmt, args...) /* Nothing */
> >> +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
> >> args)*/
> >=20
> > Format strings are likely to bitrot. Either use a if (GATE) or
> > tracepoints.
>=20
> Yes...
>=20
> > <snip>
> >=20
> > Otherwise:
> >=20
> > Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> Thanks!
>=20

