Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3870C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9816121774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livekentac.onmicrosoft.com header.i=@livekentac.onmicrosoft.com header.b="Wo79fZ1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9816121774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacZh-00056m-Mi
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iacUy-000369-MK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iacUq-000052-8I
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:23:35 -0500
Received: from mail-eopbgr40049.outbound.protection.outlook.com
 ([40.107.4.49]:59556 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iacUp-0008L0-M4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:23:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6cKRryo9ziuPSSQkW96fKwltUDbX58E4S0qrQq9kmg/FcIo+5yH6uLzFz+2S/4Wgy0chTt60fgs6ob+9YgByg4RE4YH/hn394rj1IlgYKiiGw63HDM1VgPS7wQ1IJL54t/82WaEwhojoArLfHzoMOVV9saK4xM6euGVw3Cro5/UmLiUkqUqjo9qWMZ0JqzL/WQKeQe7QFndfYbtwPcv9ELfa6nhgO+APH34gJkcGkaesVuVmifFjWo2iFxTQUXm48XSRC//vGwO7dncr+hTMzB766n9+VQacFDpMVAAdXnHH98HS/MEcgGbSS5rpNpnMegAextvqRvan7aJPWV3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlb8Kfh2/0hhJdpGJQ8W2MEqiTW/6/ZhGj2LomOAyFU=;
 b=XQuT4s1StmjXbjbPvzGY5UIpuRC93TfxA+OMOrJMY7A36bomQrY3qEgzUZaYrehE4REUEjyV5wCc/9eueZFneHPIZQKAUz69JHDSCkCAY6OCY6TNqwLt3M435tAqfet8eMguO5AUl04KgkmH953SGzkI3Y94jpcnQm3i6KIFopp1606/SpSBc/HMrYnd60d++9Vxm0vF3kojoOa+zrD2uykr/p8JPd1rLBvesBqWC0WVnfo2FhPTXjYqygJPL949hegQ/W4i82enOPycpE5+zyulL1cKd68vSrvkMmrlX6hQnY682hpDLYFCv0O7bYhmDOyOsTL2tfS3ZCSaLi7mYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kent.ac.uk; dmarc=pass action=none header.from=kent.ac.uk;
 dkim=pass header.d=kent.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livekentac.onmicrosoft.com; s=selector2-livekentac-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlb8Kfh2/0hhJdpGJQ8W2MEqiTW/6/ZhGj2LomOAyFU=;
 b=Wo79fZ1OAXUVPtFwc9zurUWbwBfy9ZV5lecOsVYBjyp+31dB8KPL5HPT53Qp3YPvCHpWzf6CWS54PjlzuyI/zKKHDVPGAnJE4xuD80jHtwsUlj2cWMSxYc2UpipU5GSslxMo5D2wUdNbViQL/Mt6CGCacESe1Uy3MlrzZ/5Uds4=
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com (52.135.135.22) by
 DB7PR01MB4745.eurprd01.prod.exchangelabs.com (20.178.42.91) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 09:23:24 +0000
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::c426:70fc:26fe:b0e3]) by DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::c426:70fc:26fe:b0e3%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 09:23:23 +0000
From: Sarah Harris <seh53@kent.ac.uk>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH v35 10/13] target/avr: Add limited support for USART and
 16 bit timer peripherals
Thread-Topic: [PATCH v35 10/13] target/avr: Add limited support for USART and
 16 bit timer peripherals
Thread-Index: AQHVjp9xkfwQU2MQhU6RI1c47qT536eXcJQAgATEPwCAADJjAIAEGMEAgAAXWwCAAAIgAIABdpeA
Date: Fri, 29 Nov 2019 09:23:23 +0000
Message-ID: <20191129092321.491916b91e16695afdd1944e@kent.ac.uk>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-11-mrolnik@gmail.com>
 <CAL1e-=i5S65283Ypg6-qDKkrhcG1r=w5ZqMyxp3CaAcAkPskUw@mail.gmail.com>
 <20191125155728.aaedf5d65b5121be1ad9f52f@kent.ac.uk>
 <CAL1e-=gMzamQs7BGg4cm8y23GqzEw7M=CptEV_UGyhFrOpeyJg@mail.gmail.com>
 <20191128093126.39c8125329aa78c92f7bbc8f@kent.ac.uk>
 <CAL1e-=iqKV0YZfKc4RtFeu2rOZjbYJMk4+hyGK9qXJn01qCbKQ@mail.gmail.com>
 <CAL1e-=ijvq4QmDwari1wX4mrZ0ewsOvhNs_5sO_yxCrY5+xZ5A@mail.gmail.com>
In-Reply-To: <CAL1e-=ijvq4QmDwari1wX4mrZ0ewsOvhNs_5sO_yxCrY5+xZ5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::32) To DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=S.E.Harris@kent.ac.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [80.189.49.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2207aff1-b8a0-4fbc-9681-08d774adc810
x-ms-traffictypediagnostic: DB7PR01MB4745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR01MB4745339662DF3172CB256565F7460@DB7PR01MB4745.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(6486002)(81166006)(229853002)(6512007)(386003)(81156014)(55236004)(53546011)(6506007)(7736002)(3846002)(14444005)(6116002)(76176011)(71200400001)(71190400001)(66446008)(52116002)(256004)(6436002)(305945005)(186003)(316002)(786003)(4326008)(64756008)(66556008)(66946007)(66476007)(2906002)(8676002)(5660300002)(50226002)(54906003)(99286004)(6246003)(66066001)(6916009)(25786009)(36756003)(11346002)(14454004)(478600001)(446003)(8936002)(30864003)(26005)(2616005)(102836004)(1076003)(21314003)(559001)(579004)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR01MB4745;
 H:DB7PR01MB4348.eurprd01.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: kent.ac.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVoFtikVIRU5vHeZNfO6XBLXOevriAQqteo3PA/jbBADIdKftCZRWHNzW85GjClwSY3zWWw8lKDF6hpISbPytyJ2XCfMfg5sypJp2saxvGU7tFfb6bZh627brrJjvyeH00LdqL1VyyvtAvhJJFZBDAVzqaV8tVQ42qgp2C7dahaYcsOOBtxiv3oDsyiKj9BomGe0KFY6VHe6ksKTa1oYNDQoKxWv6hYR9L2w+Jsui2TItvnX3btlj+sOBwtjqiFxa1pCx3sf5Aqpj8cfup8utBZfWa/PhY6eIJsVYPSj6c6vsBTWIpOaBbFX4HKC6da8eLPPqelvsP9cxelBOx+T7cerPKVvjQJWkuvWENmsHhlEju3u2135jnR3h1N9pzLG3UpoP477Xl8BOUWHhSur2lai50Jwn85vka4mwbt2LzMfhqht5YOKESUqfcurWn3e
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CB75A3CE05504642BA9A470F8F5E64ED@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kent.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207aff1-b8a0-4fbc-9681-08d774adc810
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:23:23.7795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 51a9fa56-3f32-449a-a721-3e3f49aa5e9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88ZSPoj4+rD1aE3+lKDleU9m9fE7JHDCBdIhPdRPxkFgpXRe4aun9QGA7wZVpCYSAxYjdKgAdOCS1/z/Vjb71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4745
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.49
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "S.Harris" <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

Yes, adding a note about the limitations of the USART emulation sounds like=
 a good idea.

Yes, I'm happy with switching to the (L)GPL license that's being used elsew=
here.

Kind regards,
Sarah Harris


On Thu, 28 Nov 2019 12:02:38 +0100
Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:

> On Thursday, November 28, 2019, Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>=20
> >
> >
> > On Thursday, November 28, 2019, Sarah Harris <seh53@kent.ac.uk> wrote:
> >
> >> Hi Aleksandar,
> >>
> >> > Sarah, thanks for taking your tome to respond!
> >> No problem! :)
> >>
> >> > do we fully support what is said in:
> >> > * 22.6.2 Sending Frames with 9 Data Bit
> >> > * 22.7.2 Receiving Frames with 9 Data Bits
> >> No, QEMU's character device system only supports 8 bit characters.
> >> Shorter characters can be padded easily, but longer is a problem.
> >> At the moment we just emit a warning and ignore the extra bit in UCSRn=
B
> >> (i.e. behave as if 8 bits was selected).
> >>
> >> > And the same question for section:
> >> > * 22.9 Multi-processor Communication Mode
> >> No, this was out of scope for testing use.
> >> This case is checked when writing to the UCSRnA register, `if (value &
> >> USART_CSRA_MPCM)`, and causes a warning.
> >> I don't know if we should crash instead, but at the moment we just log
> >> the warning and continue.
> >> (USART emulation will be incorrect from when this happens and until MP=
CM
> >> is disabled)
> >>
> >>
> > OK. Thanks. All this sounds reasonable to me. Do you agree that we inse=
rt:
> >
> > /*
> >  * Limitation of this emulation:
> >  *
> >  *   * Sending and receiving frames with 9 data bits sre not supported
> >  *   * Multi-processor communication mode is not supported
> >  */
> >
> > or a similar comment, close to the top of the file?
> >
> >
> One more question, Sarah, Michael left the license preambles the same as
> originals, however this is not a good license (there are some legal
> nuances) for QEMU, do you agree that the license preambles for your
> implementations are changed to LGPL 2.1 (with wording "or later (at your
> option)") that Michael used elsewhere?
>=20
> Best regards,
>=20
>  Aleksandar
>=20
>=20
> > Yours,
> > Aleksandar
> >
> >
> > Kind regards,
> >> Sarah Harris
> >>
> >>
> >> On Mon, 25 Nov 2019 19:57:48 +0100
> >> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
> >>
> >> > On Mon, Nov 25, 2019 at 4:57 PM Sarah Harris <seh53@kent.ac.uk> wrot=
e:
> >> > >
> >> > > Hi Aleksandar,
> >> > >
> >> > > > - Is there a place in docs that explain its implementation in
> >> general?
> >> > > This implementation was based on the datasheet for the ATmega2560
> >> ("ATmega640/1280/1281/2560/2561 datasheet" available from Microchip's
> >> website).
> >> > > (I'm not sure if posting a URL will trigger any spam filters, so I=
'll
> >> leave it for now)
> >> > > See section 22.10, "USART - Register Description".
> >> > >
> >> >
> >> > OK.
> >> >
> >> > > > - Why do cases 4, 5, 6 issue relatively unclear error message
> >> > > > ""update_char_mask(): Reserved character size <mode>"? Is there =
a
> >> > > > better wording perhaps? Where is justification in the doc for th=
ese
> >> > > > cases?
> >> > > The hardware can send/receive characters of various lengths,
> >> specified by settings in these configuration registers.
> >> > > The cases are defined in table 22-7, "UCSZn Bits Settings", which
> >> specifies that modes 4, 5, and 6 are reserved and should not be used.
> >> > > I'm not sure how better to explain this fault to the user; this is=
 an
> >> edge case that I'd expect only an AVR developer testing their own prog=
ram
> >> to see, so describing it in the same way as the datasheet seems a good=
 idea.
> >> > >
> >> >
> >> > OK. I somehow missed table 22-7 while comparing the code and specs -=
 my
> >> bad.
> >> >
> >> > > > - What would be the docs justification for case 7? Why is an err=
or
> >> > > > message issued, but still "char_mask" is set, and I guess, furth=
er
> >> > > > processing will go on? Why the error message says "Nine bit
> >> character
> >> > > > requested"? Who said that (that *nine* bit characters were
> >> requested?
> >> > > > :-)
> >> > > Case 7 also comes from table 22-7, and specifies that the USART
> >> should send/receive 9 bits per character.
> >> > > For characters <=3D 8 bits it's easy to pad them to the 8 bit byte=
s
> >> that the character device subsystem operates on.
> >> > > For characters of 9 bits we'd have to throw away one bit, which se=
ems
> >> like a bad thing to do.
> >> > > I decided it wasn't enough to justify crashing, but the user shoul=
d
> >> be made aware that data is being lost and the output might not be what=
 they
> >> would otherwise expect.
> >> > >
> >> >
> >> > Sarah, thanks for taking your tome to respond! Could you just explai=
n
> >> > to me do we fully support what is said in:
> >> >
> >> > * 22.6.2 Sending Frames with 9 Data Bit
> >> > * 22.7.2 Receiving Frames with 9 Data Bits
> >> >
> >> > or perhaps there are some limitations?
> >> >
> >> > And the same question for section:
> >> >
> >> > * 22.9 Multi-processor Communication Mode
> >> >
> >> > Please note that I don't suggest amending or extending your
> >> > implementation, I just want to understand it better.
> >> >
> >> > Best regards,
> >> > Aleksandar
> >> >
> >> >
> >> > > Kind regards,
> >> > > Sarah Harris
> >> > >
> >> > >
> >> > > On Fri, 22 Nov 2019 16:10:02 +0100
> >> > > Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
> >> > >
> >> > > > On Tue, Oct 29, 2019 at 10:25 PM Michael Rolnik <mrolnik@gmail.c=
om>
> >> wrote:
> >> > > > >
> >> > > > > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >> > > > >
> >> > > > > These were designed to facilitate testing but should provide
> >> enough function to be useful in other contexts.
> >> > > > > Only a subset of the functions of each peripheral is implement=
ed,
> >> mainly due to the lack of a standard way to handle electrical connecti=
ons
> >> (like GPIO pins).
> >> > > > >
> >> > > > > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> >> > > > > ---
> >> > > > >  hw/char/Kconfig                |   3 +
> >> > > > >  hw/char/Makefile.objs          |   1 +
> >> > > > >  hw/char/avr_usart.c            | 324 ++++++++++++++++++
> >> > > > >  hw/misc/Kconfig                |   3 +
> >> > > > >  hw/misc/Makefile.objs          |   2 +
> >> > > > >  hw/misc/avr_mask.c             | 112 ++++++
> >> > > > >  hw/timer/Kconfig               |   3 +
> >> > > > >  hw/timer/Makefile.objs         |   2 +
> >> > > > >  hw/timer/avr_timer16.c         | 605
> >> +++++++++++++++++++++++++++++++++
> >> > > > >  include/hw/char/avr_usart.h    |  97 ++++++
> >> > > > >  include/hw/misc/avr_mask.h     |  47 +++
> >> > > > >  include/hw/timer/avr_timer16.h |  97 ++++++
> >> > > > >  12 files changed, 1296 insertions(+)
> >> > > > >  create mode 100644 hw/char/avr_usart.c
> >> > > > >  create mode 100644 hw/misc/avr_mask.c
> >> > > > >  create mode 100644 hw/timer/avr_timer16.c
> >> > > > >  create mode 100644 include/hw/char/avr_usart.h
> >> > > > >  create mode 100644 include/hw/misc/avr_mask.h
> >> > > > >  create mode 100644 include/hw/timer/avr_timer16.h
> >> > > > >
> >> > > > > diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> >> > > > > index 40e7a8b8bb..331b20983f 100644
> >> > > > > --- a/hw/char/Kconfig
> >> > > > > +++ b/hw/char/Kconfig
> >> > > > > @@ -46,3 +46,6 @@ config SCLPCONSOLE
> >> > > > >
> >> > > > >  config TERMINAL3270
> >> > > > >      bool
> >> > > > > +
> >> > > > > +config AVR_USART
> >> > > > > +    bool
> >> > > > > diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> >> > > > > index 02d8a66925..f05c1f5667 100644
> >> > > > > --- a/hw/char/Makefile.objs
> >> > > > > +++ b/hw/char/Makefile.objs
> >> > > > > @@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
> >> > > > >  obj-$(CONFIG_DIGIC) +=3D digic-uart.o
> >> > > > >  obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
> >> > > > >  obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
> >> > > > > +common-obj-$(CONFIG_AVR_USART) +=3D avr_usart.o
> >> > > > >
> >> > > > >  common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
> >> > > > >  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
> >> > > > > diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
> >> > > > > new file mode 100644
> >> > > > > index 0000000000..9ca3c2a1cd
> >> > > > > --- /dev/null
> >> > > > > +++ b/hw/char/avr_usart.c
> >> > > > > @@ -0,0 +1,324 @@
> >> > > > > +/*
> >> > > > > + * AVR USART
> >> > > > > + *
> >> > > > > + * Copyright (c) 2018 University of Kent
> >> > > > > + * Author: Sarah Harris
> >> > > > > + *
> >> > > > > + * Permission is hereby granted, free of charge, to any perso=
n
> >> obtaining a copy
> >> > > > > + * of this software and associated documentation files (the
> >> "Software"), to deal
> >> > > > > + * in the Software without restriction, including without
> >> limitation the rights
> >> > > > > + * to use, copy, modify, merge, publish, distribute, sublicen=
se,
> >> and/or sell
> >> > > > > + * copies of the Software, and to permit persons to whom the
> >> Software is
> >> > > > > + * furnished to do so, subject to the following conditions:
> >> > > > > + *
> >> > > > > + * The above copyright notice and this permission notice shal=
l
> >> be included in
> >> > > > > + * all copies or substantial portions of the Software.
> >> > > > > + *
> >> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> >> KIND, EXPRESS OR
> >> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >> MERCHANTABILITY,
> >> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN N=
O
> >> EVENT SHALL
> >> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> >> DAMAGES OR OTHER
> >> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> >> OTHERWISE, ARISING FROM,
> >> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OT=
HER
> >> DEALINGS IN
> >> > > > > + * THE SOFTWARE.
> >> > > > > + */
> >> > > > > +
> >> > > > > +#include "qemu/osdep.h"
> >> > > > > +#include "hw/char/avr_usart.h"
> >> > > > > +#include "qemu/log.h"
> >> > > > > +#include "hw/irq.h"
> >> > > > > +#include "hw/qdev-properties.h"
> >> > > > > +
> >> > > > > +static int avr_usart_can_receive(void *opaque)
> >> > > > > +{
> >> > > > > +    AVRUsartState *usart =3D opaque;
> >> > > > > +
> >> > > > > +    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)=
) {
> >> > > > > +        return 0;
> >> > > > > +    }
> >> > > > > +    return 1;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_usart_receive(void *opaque, const uint8_t
> >> *buffer, int size)
> >> > > > > +{
> >> > > > > +    AVRUsartState *usart =3D opaque;
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    assert(!usart->data_valid);
> >> > > > > +    usart->data =3D buffer[0];
> >> > > > > +    usart->data_valid =3D true;
> >> > > > > +    usart->csra |=3D USART_CSRA_RXC;
> >> > > > > +    if (usart->csrb & USART_CSRB_RXCIE) {
> >> > > > > +        qemu_set_irq(usart->rxc_irq, 1);
> >> > > > > +    }
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void update_char_mask(AVRUsartState *usart)
> >> > > > > +{
> >> > > > > +    uint8_t mode =3D ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0=
) |
> >> > > > > +        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
> >> > > > > +        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
> >> > > > > +    switch (mode) {
> >> > > > > +    case 0:
> >> > > > > +        usart->char_mask =3D 0b11111;
> >> > > > > +        break;
> >> > > > > +    case 1:
> >> > > > > +        usart->char_mask =3D 0b111111;
> >> > > > > +        break;
> >> > > > > +    case 2:
> >> > > > > +        usart->char_mask =3D 0b1111111;
> >> > > > > +        break;
> >> > > > > +    case 3:
> >> > > > > +        usart->char_mask =3D 0b11111111;
> >> > > > > +        break;
> >> > > > > +    case 4:
> >> > > > > +        /* Fallthrough. */
> >> > > > > +    case 5:
> >> > > > > +        /* Fallthrough. */
> >> > > > > +    case 6:
> >> > > > > +        qemu_log_mask(
> >> > > > > +            LOG_GUEST_ERROR,
> >> > > > > +            "%s: Reserved character size 0x%x\n",
> >> > > > > +            __func__,
> >> > > > > +            mode);
> >> > > > > +        break;
> >> > > > > +    case 7:
> >> > > > > +        qemu_log_mask(
> >> > > > > +            LOG_GUEST_ERROR,
> >> > > > > +            "%s: Nine bit character size not supported (forci=
ng
> >> eight)\n",
> >> > > > > +            __func__);
> >> > > > > +        usart->char_mask =3D 0b11111111;
> >> > > > > +        break;
> >> > > > > +    default:
> >> > > > > +        assert(0);
> >> > > > > +    }
> >> > > > > +}
> >> > > > > +
> >> > > >
> >> > > > Hello, Michael.
> >> > > >
> >> > > > Please explain to me some details of update_char_mask():
> >> > > >
> >> > > > - Is there a place in docs that explain its implementation in
> >> general?
> >> > > >
> >> > > > - Why do cases 4, 5, 6 issue relatively unclear error message
> >> > > > ""update_char_mask(): Reserved character size <mode>"? Is there =
a
> >> > > > better wording perhaps? Where is justification in the doc for th=
ese
> >> > > > cases?
> >> > > >
> >> > > > - What would be the docs justification for case 7? Why is an err=
or
> >> > > > message issued, but still "char_mask" is set, and I guess, furth=
er
> >> > > > processing will go on? Why the error message says "Nine bit
> >> character
> >> > > > requested"? Who said that (that *nine* bit characters were
> >> requested?
> >> > > > :-)
> >> > > >
> >> > > > Sincerely,
> >> > > > Aleksandar
> >> > > >
> >> > > >
> >> > > >
> >> > > >
> >> > > >
> >> > > >
> >> > > > > +static void avr_usart_reset(DeviceState *dev)
> >> > > > > +{
> >> > > > > +    AVRUsartState *usart =3D AVR_USART(dev);
> >> > > > > +    usart->data_valid =3D false;
> >> > > > > +    usart->csra =3D 0b00100000;
> >> > > > > +    usart->csrb =3D 0b00000000;
> >> > > > > +    usart->csrc =3D 0b00000110;
> >> > > > > +    usart->brrl =3D 0;
> >> > > > > +    usart->brrh =3D 0;
> >> > > > > +    update_char_mask(usart);
> >> > > > > +    qemu_set_irq(usart->rxc_irq, 0);
> >> > > > > +    qemu_set_irq(usart->txc_irq, 0);
> >> > > > > +    qemu_set_irq(usart->dre_irq, 0);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static uint64_t avr_usart_read(void *opaque, hwaddr addr,
> >> unsigned int size)
> >> > > > > +{
> >> > > > > +    AVRUsartState *usart =3D opaque;
> >> > > > > +    uint8_t data;
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +
> >> > > > > +    if (!usart->enabled) {
> >> > > > > +        return 0;
> >> > > > > +    }
> >> > > > > +
> >> > > > > +    switch (addr) {
> >> > > > > +    case USART_DR:
> >> > > > > +        if (!(usart->csrb & USART_CSRB_RXEN)) {
> >> > > > > +            /* Receiver disabled, ignore. */
> >> > > > > +            return 0;
> >> > > > > +        }
> >> > > > > +        if (usart->data_valid) {
> >> > > > > +            data =3D usart->data & usart->char_mask;
> >> > > > > +            usart->data_valid =3D false;
> >> > > > > +        } else {
> >> > > > > +            data =3D 0;
> >> > > > > +        }
> >> > > > > +        usart->csra &=3D 0xff ^ USART_CSRA_RXC;
> >> > > > > +        qemu_set_irq(usart->rxc_irq, 0);
> >> > > > > +        qemu_chr_fe_accept_input(&usart->chr);
> >> > > > > +        return data;
> >> > > > > +    case USART_CSRA:
> >> > > > > +        return usart->csra;
> >> > > > > +    case USART_CSRB:
> >> > > > > +        return usart->csrb;
> >> > > > > +    case USART_CSRC:
> >> > > > > +        return usart->csrc;
> >> > > > > +    case USART_BRRL:
> >> > > > > +        return usart->brrl;
> >> > > > > +    case USART_BRRH:
> >> > > > > +        return usart->brrh;
> >> > > > > +    default:
> >> > > > > +        qemu_log_mask(
> >> > > > > +            LOG_GUEST_ERROR,
> >> > > > > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> >> > > > > +            __func__,
> >> > > > > +            addr);
> >> > > > > +    }
> >> > > > > +    return 0;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_usart_write(void *opaque, hwaddr addr, uint64=
_t
> >> value,
> >> > > > > +                                unsigned int size)
> >> > > > > +{
> >> > > > > +    AVRUsartState *usart =3D opaque;
> >> > > > > +    uint8_t mask;
> >> > > > > +    uint8_t data;
> >> > > > > +    assert((value & 0xff) =3D=3D value);
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +
> >> > > > > +    if (!usart->enabled) {
> >> > > > > +        return;
> >> > > > > +    }
> >> > > > > +
> >> > > > > +    switch (addr) {
> >> > > > > +    case USART_DR:
> >> > > > > +        if (!(usart->csrb & USART_CSRB_TXEN)) {
> >> > > > > +            /* Transmitter disabled, ignore. */
> >> > > > > +            return;
> >> > > > > +        }
> >> > > > > +        usart->csra |=3D USART_CSRA_TXC;
> >> > > > > +        usart->csra |=3D USART_CSRA_DRE;
> >> > > > > +        if (usart->csrb & USART_CSRB_TXCIE) {
> >> > > > > +            qemu_set_irq(usart->txc_irq, 1);
> >> > > > > +            usart->csra &=3D 0xff ^ USART_CSRA_TXC;
> >> > > > > +        }
> >> > > > > +        if (usart->csrb & USART_CSRB_DREIE) {
> >> > > > > +            qemu_set_irq(usart->dre_irq, 1);
> >> > > > > +        }
> >> > > > > +        data =3D value;
> >> > > > > +        qemu_chr_fe_write_all(&usart->chr, &data, 1);
> >> > > > > +        break;
> >> > > > > +    case USART_CSRA:
> >> > > > > +        mask =3D 0b01000011;
> >> > > > > +        /* Mask read-only bits. */
> >> > > > > +        value =3D (value & mask) | (usart->csra & (0xff ^ mas=
k));
> >> > > > > +        usart->csra =3D value;
> >> > > > > +        if (value & USART_CSRA_TXC) {
> >> > > > > +            usart->csra ^=3D USART_CSRA_TXC;
> >> > > > > +            qemu_set_irq(usart->txc_irq, 0);
> >> > > > > +        }
> >> > > > > +        if (value & USART_CSRA_MPCM) {
> >> > > > > +            qemu_log_mask(
> >> > > > > +                LOG_GUEST_ERROR,
> >> > > > > +                "%s: MPCM not supported by USART\n",
> >> > > > > +                __func__);
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    case USART_CSRB:
> >> > > > > +        mask =3D 0b11111101;
> >> > > > > +        /* Mask read-only bits. */
> >> > > > > +        value =3D (value & mask) | (usart->csrb & (0xff ^ mas=
k));
> >> > > > > +        usart->csrb =3D value;
> >> > > > > +        if (!(value & USART_CSRB_RXEN)) {
> >> > > > > +            /* Receiver disabled, flush input buffer. */
> >> > > > > +            usart->data_valid =3D false;
> >> > > > > +        }
> >> > > > > +        qemu_set_irq(usart->rxc_irq,
> >> > > > > +            ((value & USART_CSRB_RXCIE) &&
> >> > > > > +            (usart->csra & USART_CSRA_RXC)) ? 1 : 0);
> >> > > > > +        qemu_set_irq(usart->txc_irq,
> >> > > > > +            ((value & USART_CSRB_TXCIE) &&
> >> > > > > +            (usart->csra & USART_CSRA_TXC)) ? 1 : 0);
> >> > > > > +        qemu_set_irq(usart->dre_irq,
> >> > > > > +            ((value & USART_CSRB_DREIE) &&
> >> > > > > +            (usart->csra & USART_CSRA_DRE)) ? 1 : 0);
> >> > > > > +        update_char_mask(usart);
> >> > > > > +        break;
> >> > > > > +    case USART_CSRC:
> >> > > > > +        usart->csrc =3D value;
> >> > > > > +        if ((value & USART_CSRC_MSEL1) && (value &
> >> USART_CSRC_MSEL0)) {
> >> > > > > +            qemu_log_mask(
> >> > > > > +                LOG_GUEST_ERROR,
> >> > > > > +                "%s: SPI mode not supported by USART\n",
> >> > > > > +                __func__);
> >> > > > > +        }
> >> > > > > +        if ((value & USART_CSRC_MSEL1) && !(value &
> >> USART_CSRC_MSEL0)) {
> >> > > > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART
> >> mode\n", __func__);
> >> > > > > +        }
> >> > > > > +        if (!(value & USART_CSRC_PM1) && (value &
> >> USART_CSRC_PM0)) {
> >> > > > > +            qemu_log_mask(
> >> > > > > +                LOG_GUEST_ERROR,
> >> > > > > +                "%s: Bad USART parity mode\n",
> >> > > > > +                __func__);
> >> > > > > +        }
> >> > > > > +        update_char_mask(usart);
> >> > > > > +        break;
> >> > > > > +    case USART_BRRL:
> >> > > > > +        usart->brrl =3D value;
> >> > > > > +        break;
> >> > > > > +    case USART_BRRH:
> >> > > > > +        usart->brrh =3D value & 0b00001111;
> >> > > > > +        break;
> >> > > > > +    default:
> >> > > > > +        qemu_log_mask(
> >> > > > > +            LOG_GUEST_ERROR,
> >> > > > > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> >> > > > > +            __func__,
> >> > > > > +            addr);
> >> > > > > +    }
> >> > > > > +}
> >> > > > > +
> >> > > > > +static const MemoryRegionOps avr_usart_ops =3D {
> >> > > > > +    .read =3D avr_usart_read,
> >> > > > > +    .write =3D avr_usart_write,
> >> > > > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >> > > > > +    .impl =3D {.min_access_size =3D 1, .max_access_size =3D 1=
}
> >> > > > > +};
> >> > > > > +
> >> > > > > +static Property avr_usart_properties[] =3D {
> >> > > > > +    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
> >> > > > > +    DEFINE_PROP_END_OF_LIST(),
> >> > > > > +};
> >> > > > > +
> >> > > > > +static void avr_usart_pr(void *opaque, int irq, int level)
> >> > > > > +{
> >> > > > > +    AVRUsartState *s =3D AVR_USART(opaque);
> >> > > > > +
> >> > > > > +    s->enabled =3D !level;
> >> > > > > +
> >> > > > > +    if (!s->enabled) {
> >> > > > > +        avr_usart_reset(DEVICE(s));
> >> > > > > +    }
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_usart_init(Object *obj)
> >> > > > > +{
> >> > > > > +    AVRUsartState *s =3D AVR_USART(obj);
> >> > > > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
> >> > > > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
> >> > > > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
> >> > > > > +    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s,
> >> TYPE_AVR_USART, 8);
> >> > > > > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> >> > > > > +    qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
> >> > > > > +    s->enabled =3D true;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_usart_realize(DeviceState *dev, Error **errp)
> >> > > > > +{
> >> > > > > +    AVRUsartState *s =3D AVR_USART(dev);
> >> > > > > +    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
> >> > > > > +                             avr_usart_receive, NULL, NULL,
> >> > > > > +                             s, NULL, true);
> >> > > > > +    avr_usart_reset(dev);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_usart_class_init(ObjectClass *klass, void *da=
ta)
> >> > > > > +{
> >> > > > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> > > > > +
> >> > > > > +    dc->reset =3D avr_usart_reset;
> >> > > > > +    dc->props =3D avr_usart_properties;
> >> > > > > +    dc->realize =3D avr_usart_realize;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static const TypeInfo avr_usart_info =3D {
> >> > > > > +    .name          =3D TYPE_AVR_USART,
> >> > > > > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >> > > > > +    .instance_size =3D sizeof(AVRUsartState),
> >> > > > > +    .instance_init =3D avr_usart_init,
> >> > > > > +    .class_init    =3D avr_usart_class_init,
> >> > > > > +};
> >> > > > > +
> >> > > > > +static void avr_usart_register_types(void)
> >> > > > > +{
> >> > > > > +    type_register_static(&avr_usart_info);
> >> > > > > +}
> >> > > > > +
> >> > > > > +type_init(avr_usart_register_types)
> >> > > > > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> >> > > > > index 2164646553..e79841e3a4 100644
> >> > > > > --- a/hw/misc/Kconfig
> >> > > > > +++ b/hw/misc/Kconfig
> >> > > > > @@ -125,4 +125,7 @@ config MAC_VIA
> >> > > > >      select MOS6522
> >> > > > >      select ADB
> >> > > > >
> >> > > > > +config AVR_MASK
> >> > > > > +    bool
> >> > > > > +
> >> > > > >  source macio/Kconfig
> >> > > > > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> >> > > > > index ba898a5781..3a8093be6a 100644
> >> > > > > --- a/hw/misc/Makefile.objs
> >> > > > > +++ b/hw/misc/Makefile.objs
> >> > > > > @@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rn=
g.o
> >> > > > >  obj-$(CONFIG_MAC_VIA) +=3D mac_via.o
> >> > > > >
> >> > > > >  common-obj-$(CONFIG_GRLIB) +=3D grlib_ahb_apb_pnp.o
> >> > > > > +
> >> > > > > +obj-$(CONFIG_AVR_MASK) +=3D avr_mask.o
> >> > > > > diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c
> >> > > > > new file mode 100644
> >> > > > > index 0000000000..3af82ed9c1
> >> > > > > --- /dev/null
> >> > > > > +++ b/hw/misc/avr_mask.c
> >> > > > > @@ -0,0 +1,112 @@
> >> > > > > +/*
> >> > > > > + * AVR Power Reduction
> >> > > > > + *
> >> > > > > + * Copyright (c) 2019 Michael Rolnik
> >> > > > > + *
> >> > > > > + * Permission is hereby granted, free of charge, to any perso=
n
> >> obtaining a copy
> >> > > > > + * of this software and associated documentation files (the
> >> "Software"), to deal
> >> > > > > + * in the Software without restriction, including without
> >> limitation the rights
> >> > > > > + * to use, copy, modify, merge, publish, distribute, sublicen=
se,
> >> and/or sell
> >> > > > > + * copies of the Software, and to permit persons to whom the
> >> Software is
> >> > > > > + * furnished to do so, subject to the following conditions:
> >> > > > > + *
> >> > > > > + * The above copyright notice and this permission notice shal=
l
> >> be included in
> >> > > > > + * all copies or substantial portions of the Software.
> >> > > > > + *
> >> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> >> KIND, EXPRESS OR
> >> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >> MERCHANTABILITY,
> >> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN N=
O
> >> EVENT SHALL
> >> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> >> DAMAGES OR OTHER
> >> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> >> OTHERWISE, ARISING FROM,
> >> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OT=
HER
> >> DEALINGS IN
> >> > > > > + * THE SOFTWARE.
> >> > > > > + */
> >> > > > > +
> >> > > > > +#include "qemu/osdep.h"
> >> > > > > +#include "hw/misc/avr_mask.h"
> >> > > > > +#include "qemu/log.h"
> >> > > > > +#include "hw/qdev-properties.h"
> >> > > > > +#include "hw/irq.h"
> >> > > > > +
> >> > > > > +#define DB_PRINT(fmt, args...) /* Nothing */
> >> > > > > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n",
> >> __func__, ## args)*/
> >> > > > > +
> >> > > > > +static void avr_mask_reset(DeviceState *dev)
> >> > > > > +{
> >> > > > > +    AVRMaskState *s =3D AVR_MASK(dev);
> >> > > > > +
> >> > > > > +    s->val =3D 0x00;
> >> > > > > +
> >> > > > > +    for (int i =3D 0; i < 8; i++) {
> >> > > > > +        qemu_set_irq(s->irq[i], 0);
> >> > > > > +    }
> >> > > > > +}
> >> > > > > +
> >> > > > > +static uint64_t avr_mask_read(void *opaque, hwaddr offset,
> >> unsigned size)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    assert(offset =3D=3D 0);
> >> > > > > +    AVRMaskState *s =3D opaque;
> >> > > > > +
> >> > > > > +    return (uint64_t)s->val;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_mask_write(void *opaque, hwaddr offset,
> >> > > > > +                              uint64_t val64, unsigned size)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    assert(offset =3D=3D 0);
> >> > > > > +    AVRMaskState *s =3D opaque;
> >> > > > > +    uint8_t val8 =3D val64;
> >> > > > > +
> >> > > > > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> >> > > > > +
> >> > > > > +    s->val =3D val8;
> >> > > > > +    for (int i =3D 0; i < 8; i++) {
> >> > > > > +        qemu_set_irq(s->irq[i], (val8 & (1 << i)) !=3D 0);
> >> > > > > +    }
> >> > > > > +}
> >> > > > > +
> >> > > > > +static const MemoryRegionOps avr_mask_ops =3D {
> >> > > > > +    .read =3D avr_mask_read,
> >> > > > > +    .write =3D avr_mask_write,
> >> > > > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >> > > > > +    .impl =3D {.max_access_size =3D 1}
> >> > > > > +};
> >> > > > > +
> >> > > > > +static void avr_mask_init(Object *dev)
> >> > > > > +{
> >> > > > > +    AVRMaskState *s =3D AVR_MASK(dev);
> >> > > > > +    SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);
> >> > > > > +
> >> > > > > +    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s,
> >> TYPE_AVR_MASK,
> >> > > > > +            0x01);
> >> > > > > +    sysbus_init_mmio(busdev, &s->iomem);
> >> > > > > +
> >> > > > > +    for (int i =3D 0; i < 8; i++) {
> >> > > > > +        sysbus_init_irq(busdev, &s->irq[i]);
> >> > > > > +    }
> >> > > > > +    s->val =3D 0x00;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_mask_class_init(ObjectClass *klass, void *dat=
a)
> >> > > > > +{
> >> > > > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> > > > > +
> >> > > > > +    dc->reset =3D avr_mask_reset;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static const TypeInfo avr_mask_info =3D {
> >> > > > > +    .name          =3D TYPE_AVR_MASK,
> >> > > > > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >> > > > > +    .instance_size =3D sizeof(AVRMaskState),
> >> > > > > +    .class_init    =3D avr_mask_class_init,
> >> > > > > +    .instance_init =3D avr_mask_init,
> >> > > > > +};
> >> > > > > +
> >> > > > > +static void avr_mask_register_types(void)
> >> > > > > +{
> >> > > > > +    type_register_static(&avr_mask_info);
> >> > > > > +}
> >> > > > > +
> >> > > > > +type_init(avr_mask_register_types)
> >> > > > > diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> >> > > > > index a990f9fe35..4343bc23f3 100644
> >> > > > > --- a/hw/timer/Kconfig
> >> > > > > +++ b/hw/timer/Kconfig
> >> > > > > @@ -34,3 +34,6 @@ config CMSDK_APB_TIMER
> >> > > > >  config CMSDK_APB_DUALTIMER
> >> > > > >      bool
> >> > > > >      select PTIMER
> >> > > > > +
> >> > > > > +config AVR_TIMER16
> >> > > > > +    bool
> >> > > > > diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> >> > > > > index dece235fd7..af0913ca3b 100644
> >> > > > > --- a/hw/timer/Makefile.objs
> >> > > > > +++ b/hw/timer/Makefile.objs
> >> > > > > @@ -35,3 +35,5 @@ common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D
> >> cmsdk-apb-timer.o
> >> > > > >  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D
> >> cmsdk-apb-dualtimer.o
> >> > > > >  common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
> >> > > > >  common-obj-$(CONFIG_RASPI) +=3D bcm2835_systmr.o
> >> > > > > +
> >> > > > > +obj-$(CONFIG_AVR_TIMER16) +=3D avr_timer16.o
> >> > > > > diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
> >> > > > > new file mode 100644
> >> > > > > index 0000000000..ac6ef73e77
> >> > > > > --- /dev/null
> >> > > > > +++ b/hw/timer/avr_timer16.c
> >> > > > > @@ -0,0 +1,605 @@
> >> > > > > +/*
> >> > > > > + * AVR 16 bit timer
> >> > > > > + *
> >> > > > > + * Copyright (c) 2018 University of Kent
> >> > > > > + * Author: Ed Robbins
> >> > > > > + *
> >> > > > > + * Permission is hereby granted, free of charge, to any perso=
n
> >> obtaining a copy
> >> > > > > + * of this software and associated documentation files (the
> >> "Software"), to deal
> >> > > > > + * in the Software without restriction, including without
> >> limitation the rights
> >> > > > > + * to use, copy, modify, merge, publish, distribute, sublicen=
se,
> >> and/or sell
> >> > > > > + * copies of the Software, and to permit persons to whom the
> >> Software is
> >> > > > > + * furnished to do so, subject to the following conditions:
> >> > > > > + *
> >> > > > > + * The above copyright notice and this permission notice shal=
l
> >> be included in
> >> > > > > + * all copies or substantial portions of the Software.
> >> > > > > + *
> >> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> >> KIND, EXPRESS OR
> >> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >> MERCHANTABILITY,
> >> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN N=
O
> >> EVENT SHALL
> >> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> >> DAMAGES OR OTHER
> >> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> >> OTHERWISE, ARISING FROM,
> >> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OT=
HER
> >> DEALINGS IN
> >> > > > > + * THE SOFTWARE.
> >> > > > > + */
> >> > > > > +
> >> > > > > +/*
> >> > > > > + * Driver for 16 bit timers on 8 bit AVR devices.
> >> > > > > + * Note:
> >> > > > > + * ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and=
 5
> >> are 16 bit
> >> > > > > + */
> >> > > > > +
> >> > > > > +/*
> >> > > > > + * XXX TODO: Power Reduction Register support
> >> > > > > + *           prescaler pause support
> >> > > > > + *           PWM modes, GPIO, output capture pins, input comp=
are
> >> pin
> >> > > > > + */
> >> > > > > +
> >> > > > > +#include "qemu/osdep.h"
> >> > > > > +#include "hw/timer/avr_timer16.h"
> >> > > > > +#include "qemu/log.h"
> >> > > > > +#include "hw/irq.h"
> >> > > > > +#include "hw/qdev-properties.h"
> >> > > > > +
> >> > > > > +/* Register offsets */
> >> > > > > +#define T16_CRA     0x0
> >> > > > > +#define T16_CRB     0x1
> >> > > > > +#define T16_CRC     0x2
> >> > > > > +#define T16_CNTL    0x4
> >> > > > > +#define T16_CNTH    0x5
> >> > > > > +#define T16_ICRL    0x6
> >> > > > > +#define T16_ICRH    0x7
> >> > > > > +#define T16_OCRAL   0x8
> >> > > > > +#define T16_OCRAH   0x9
> >> > > > > +#define T16_OCRBL   0xa
> >> > > > > +#define T16_OCRBH   0xb
> >> > > > > +#define T16_OCRCL   0xc
> >> > > > > +#define T16_OCRCH   0xd
> >> > > > > +
> >> > > > > +/* Field masks */
> >> > > > > +#define T16_CRA_WGM01   0x3
> >> > > > > +#define T16_CRA_COMC    0xc
> >> > > > > +#define T16_CRA_COMB    0x30
> >> > > > > +#define T16_CRA_COMA    0xc0
> >> > > > > +#define T16_CRA_OC_CONF \
> >> > > > > +    (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_COMC)
> >> > > > > +
> >> > > > > +#define T16_CRB_CS      0x7
> >> > > > > +#define T16_CRB_WGM23   0x18
> >> > > > > +#define T16_CRB_ICES    0x40
> >> > > > > +#define T16_CRB_ICNC    0x80
> >> > > > > +
> >> > > > > +#define T16_CRC_FOCC    0x20
> >> > > > > +#define T16_CRC_FOCB    0x40
> >> > > > > +#define T16_CRC_FOCA    0x80
> >> > > > > +
> >> > > > > +/* Fields masks both TIMSK and TIFR (interrupt mask/flag
> >> registers) */
> >> > > > > +#define T16_INT_TOV    0x1 /* Timer overflow */
> >> > > > > +#define T16_INT_OCA    0x2 /* Output compare A */
> >> > > > > +#define T16_INT_OCB    0x4 /* Output compare B */
> >> > > > > +#define T16_INT_OCC    0x8 /* Output compare C */
> >> > > > > +#define T16_INT_IC     0x20 /* Input capture */
> >> > > > > +
> >> > > > > +/* Clock source values */
> >> > > > > +#define T16_CLKSRC_STOPPED     0
> >> > > > > +#define T16_CLKSRC_DIV1        1
> >> > > > > +#define T16_CLKSRC_DIV8        2
> >> > > > > +#define T16_CLKSRC_DIV64       3
> >> > > > > +#define T16_CLKSRC_DIV256      4
> >> > > > > +#define T16_CLKSRC_DIV1024     5
> >> > > > > +#define T16_CLKSRC_EXT_FALLING 6
> >> > > > > +#define T16_CLKSRC_EXT_RISING  7
> >> > > > > +
> >> > > > > +/* Timer mode values (not including PWM modes) */
> >> > > > > +#define T16_MODE_NORMAL     0
> >> > > > > +#define T16_MODE_CTC_OCRA   4
> >> > > > > +#define T16_MODE_CTC_ICR    12
> >> > > > > +
> >> > > > > +/* Accessors */
> >> > > > > +#define CLKSRC(t16) (t16->crb & T16_CRB_CS)
> >> > > > > +#define MODE(t16)   (((t16->crb & T16_CRB_WGM23) >> 1) | \
> >> > > > > +                     (t16->cra & T16_CRA_WGM01))
> >> > > > > +#define CNT(t16)    VAL16(t16->cntl, t16->cnth)
> >> > > > > +#define OCRA(t16)   VAL16(t16->ocral, t16->ocrah)
> >> > > > > +#define OCRB(t16)   VAL16(t16->ocrbl, t16->ocrbh)
> >> > > > > +#define OCRC(t16)   VAL16(t16->ocrcl, t16->ocrch)
> >> > > > > +#define ICR(t16)    VAL16(t16->icrl, t16->icrh)
> >> > > > > +
> >> > > > > +/* Helper macros */
> >> > > > > +#define VAL16(l, h) ((h << 8) | l)
> >> > > > > +#define ERROR(fmt, args...) \
> >> > > > > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__,=
 ##
> >> args)
> >> > > > > +#define DB_PRINT(fmt, args...) /* Nothing */
> >> > > > > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n",
> >> __func__, ## args)*/
> >> > > > > +
> >> > > > > +static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State
> >> *t16, int64_t t)
> >> > > > > +{
> >> > > > > +    if (t16->period_ns =3D=3D 0) {
> >> > > > > +        return 0;
> >> > > > > +    }
> >> > > > > +    return t / t16->period_ns;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_update_cnt(AVRTimer16State *t16)
> >> > > > > +{
> >> > > > > +    uint16_t cnt;
> >> > > > > +    cnt =3D avr_timer16_ns_to_ticks(t16,
> >> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
> >> > > > > +                                       t16->reset_time_ns);
> >> > > > > +    t16->cntl =3D (uint8_t)(cnt & 0xff);
> >> > > > > +    t16->cnth =3D (uint8_t)((cnt & 0xff00) >> 8);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static inline void avr_timer16_recalc_reset_time(AVRTimer16St=
ate
> >> *t16)
> >> > > > > +{
> >> > > > > +    t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL) -
> >> > > > > +                         CNT(t16) * t16->period_ns;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_clock_reset(AVRTimer16State *t16)
> >> > > > > +{
> >> > > > > +    t16->cntl =3D 0;
> >> > > > > +    t16->cnth =3D 0;
> >> > > > > +    t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
> >> > > > > +{
> >> > > > > +    uint16_t divider =3D 0;
> >> > > > > +    switch (CLKSRC(t16)) {
> >> > > > > +    case T16_CLKSRC_EXT_FALLING:
> >> > > > > +    case T16_CLKSRC_EXT_RISING:
> >> > > > > +        ERROR("external clock source unsupported");
> >> > > > > +        goto end;
> >> > > > > +    case T16_CLKSRC_STOPPED:
> >> > > > > +        goto end;
> >> > > > > +    case T16_CLKSRC_DIV1:
> >> > > > > +        divider =3D 1;
> >> > > > > +        break;
> >> > > > > +    case T16_CLKSRC_DIV8:
> >> > > > > +        divider =3D 8;
> >> > > > > +        break;
> >> > > > > +    case T16_CLKSRC_DIV64:
> >> > > > > +        divider =3D 64;
> >> > > > > +        break;
> >> > > > > +    case T16_CLKSRC_DIV256:
> >> > > > > +        divider =3D 256;
> >> > > > > +        break;
> >> > > > > +    case T16_CLKSRC_DIV1024:
> >> > > > > +        divider =3D 1024;
> >> > > > > +        break;
> >> > > > > +    default:
> >> > > > > +        goto end;
> >> > > > > +    }
> >> > > > > +    t16->freq_hz =3D t16->cpu_freq_hz / divider;
> >> > > > > +    t16->period_ns =3D 1000000000ULL / t16->freq_hz;
> >> > > > > +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu6=
4 "
> >> ns (%f s)",
> >> > > > > +             t16->freq_hz, t16->period_ns, 1 /
> >> (double)t16->freq_hz);
> >> > > > > +end:
> >> > > > > +    return;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_set_alarm(AVRTimer16State *t16)
> >> > > > > +{
> >> > > > > +    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
> >> > > > > +        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
> >> > > > > +        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
> >> > > > > +        /* Timer is disabled or set to external clock source
> >> (unsupported) */
> >> > > > > +        goto end;
> >> > > > > +    }
> >> > > > > +
> >> > > > > +    uint64_t alarm_offset =3D 0xffff;
> >> > > > > +    enum NextInterrupt next_interrupt =3D OVERFLOW;
> >> > > > > +
> >> > > > > +    switch (MODE(t16)) {
> >> > > > > +    case T16_MODE_NORMAL:
> >> > > > > +        /* Normal mode */
> >> > > > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) =
&&
> >> > > > > +            (t16->imsk & T16_INT_OCA)) {
> >> > > > > +            alarm_offset =3D OCRA(t16);
> >> > > > > +            next_interrupt =3D COMPA;
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    case T16_MODE_CTC_OCRA:
> >> > > > > +        /* CTC mode, top =3D ocra */
> >> > > > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16))=
 {
> >> > > > > +            alarm_offset =3D OCRA(t16);
> >> > > > > +            next_interrupt =3D COMPA;
> >> > > > > +        }
> >> > > > > +       break;
> >> > > > > +    case T16_MODE_CTC_ICR:
> >> > > > > +        /* CTC mode, top =3D icr */
> >> > > > > +        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
> >> > > > > +            alarm_offset =3D ICR(t16);
> >> > > > > +            next_interrupt =3D CAPT;
> >> > > > > +        }
> >> > > > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) =
&&
> >> > > > > +            (t16->imsk & T16_INT_OCA)) {
> >> > > > > +            alarm_offset =3D OCRA(t16);
> >> > > > > +            next_interrupt =3D COMPA;
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    default:
> >> > > > > +        ERROR("pwm modes are unsupported");
> >> > > > > +        goto end;
> >> > > > > +    }
> >> > > > > +    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> >> > > > > +        (t16->imsk & T16_INT_OCB)) {
> >> > > > > +        alarm_offset =3D OCRB(t16);
> >> > > > > +        next_interrupt =3D COMPB;
> >> > > > > +    }
> >> > > > > +    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> >> > > > > +        (t16->imsk & T16_INT_OCC)) {
> >> > > > > +        alarm_offset =3D OCRB(t16);
> >> > > > > +        next_interrupt =3D COMPC;
> >> > > > > +    }
> >> > > > > +    alarm_offset -=3D CNT(t16);
> >> > > > > +
> >> > > > > +    t16->next_interrupt =3D next_interrupt;
> >> > > > > +    uint64_t alarm_ns =3D
> >> > > > > +        t16->reset_time_ns + ((CNT(t16) + alarm_offset) *
> >> t16->period_ns);
> >> > > > > +    timer_mod(t16->timer, alarm_ns);
> >> > > > > +
> >> > > > > +    DB_PRINT("next alarm %" PRIu64 " ns from now",
> >> > > > > +        alarm_offset * t16->period_ns);
> >> > > > > +
> >> > > > > +end:
> >> > > > > +    return;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_interrupt(void *opaque)
> >> > > > > +{
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    uint8_t mode =3D MODE(t16);
> >> > > > > +
> >> > > > > +    avr_timer16_update_cnt(t16);
> >> > > > > +
> >> > > > > +    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
> >> > > > > +        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
> >> > > > > +        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
> >> > > > > +        /* Timer is disabled or set to external clock source
> >> (unsupported) */
> >> > > > > +        return;
> >> > > > > +    }
> >> > > > > +
> >> > > > > +    DB_PRINT("interrupt, cnt =3D %d", CNT(t16));
> >> > > > > +
> >> > > > > +    /* Counter overflow */
> >> > > > > +    if (t16->next_interrupt =3D=3D OVERFLOW) {
> >> > > > > +        DB_PRINT("0xffff overflow");
> >> > > > > +        avr_timer16_clock_reset(t16);
> >> > > > > +        if (t16->imsk & T16_INT_TOV) {
> >> > > > > +            t16->ifr |=3D T16_INT_TOV;
> >> > > > > +            qemu_set_irq(t16->ovf_irq, 1);
> >> > > > > +        }
> >> > > > > +    }
> >> > > > > +    /* Check for ocra overflow in CTC mode */
> >> > > > > +    if (mode =3D=3D T16_MODE_CTC_OCRA && t16->next_interrupt =
=3D=3D
> >> COMPA) {
> >> > > > > +        DB_PRINT("CTC OCRA overflow");
> >> > > > > +        avr_timer16_clock_reset(t16);
> >> > > > > +    }
> >> > > > > +    /* Check for icr overflow in CTC mode */
> >> > > > > +    if (mode =3D=3D T16_MODE_CTC_ICR && t16->next_interrupt =
=3D=3D CAPT)
> >> {
> >> > > > > +        DB_PRINT("CTC ICR overflow");
> >> > > > > +        avr_timer16_clock_reset(t16);
> >> > > > > +        if (t16->imsk & T16_INT_IC) {
> >> > > > > +            t16->ifr |=3D T16_INT_IC;
> >> > > > > +            qemu_set_irq(t16->capt_irq, 1);
> >> > > > > +        }
> >> > > > > +    }
> >> > > > > +    /* Check for output compare interrupts */
> >> > > > > +    if (t16->imsk & T16_INT_OCA && t16->next_interrupt =3D=3D=
 COMPA)
> >> {
> >> > > > > +        t16->ifr |=3D T16_INT_OCA;
> >> > > > > +        qemu_set_irq(t16->compa_irq, 1);
> >> > > > > +    }
> >> > > > > +    if (t16->imsk & T16_INT_OCB && t16->next_interrupt =3D=3D=
 COMPB)
> >> {
> >> > > > > +        t16->ifr |=3D T16_INT_OCB;
> >> > > > > +        qemu_set_irq(t16->compb_irq, 1);
> >> > > > > +    }
> >> > > > > +    if (t16->imsk & T16_INT_OCC && t16->next_interrupt =3D=3D=
 COMPC)
> >> {
> >> > > > > +        t16->ifr |=3D T16_INT_OCC;
> >> > > > > +        qemu_set_irq(t16->compc_irq, 1);
> >> > > > > +    }
> >> > > > > +    avr_timer16_set_alarm(t16);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_reset(DeviceState *dev)
> >> > > > > +{
> >> > > > > +    AVRTimer16State *t16 =3D AVR_TIMER16(dev);
> >> > > > > +
> >> > > > > +    avr_timer16_clock_reset(t16);
> >> > > > > +    avr_timer16_clksrc_update(t16);
> >> > > > > +    avr_timer16_set_alarm(t16);
> >> > > > > +
> >> > > > > +    qemu_set_irq(t16->capt_irq, 0);
> >> > > > > +    qemu_set_irq(t16->compa_irq, 0);
> >> > > > > +    qemu_set_irq(t16->compb_irq, 0);
> >> > > > > +    qemu_set_irq(t16->compc_irq, 0);
> >> > > > > +    qemu_set_irq(t16->ovf_irq, 0);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static uint64_t avr_timer16_read(void *opaque, hwaddr offset,
> >> unsigned size)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    uint8_t retval =3D 0;
> >> > > > > +
> >> > > > > +    switch (offset) {
> >> > > > > +    case T16_CRA:
> >> > > > > +        retval =3D t16->cra;
> >> > > > > +        break;
> >> > > > > +    case T16_CRB:
> >> > > > > +        retval =3D t16->crb;
> >> > > > > +        break;
> >> > > > > +    case T16_CRC:
> >> > > > > +        retval =3D t16->crc;
> >> > > > > +        break;
> >> > > > > +    case T16_CNTL:
> >> > > > > +        avr_timer16_update_cnt(t16);
> >> > > > > +        t16->rtmp =3D t16->cnth;
> >> > > > > +        retval =3D t16->cntl;
> >> > > > > +        break;
> >> > > > > +    case T16_CNTH:
> >> > > > > +        retval =3D t16->rtmp;
> >> > > > > +        break;
> >> > > > > +    case T16_ICRL:
> >> > > > > +        /*
> >> > > > > +         * The timer copies cnt to icr when the input capture
> >> pin changes
> >> > > > > +         * state or when the analog comparator has a match. W=
e
> >> don't
> >> > > > > +         * emulate this behaviour. We do support it's use for
> >> defining a
> >> > > > > +         * TOP value in T16_MODE_CTC_ICR
> >> > > > > +         */
> >> > > > > +        t16->rtmp =3D t16->icrh;
> >> > > > > +        retval =3D t16->icrl;
> >> > > > > +        break;
> >> > > > > +    case T16_ICRH:
> >> > > > > +        retval =3D t16->rtmp;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRAL:
> >> > > > > +        retval =3D t16->ocral;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRAH:
> >> > > > > +        retval =3D t16->ocrah;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRBL:
> >> > > > > +        retval =3D t16->ocrbl;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRBH:
> >> > > > > +        retval =3D t16->ocrbh;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRCL:
> >> > > > > +        retval =3D t16->ocrcl;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRCH:
> >> > > > > +        retval =3D t16->ocrch;
> >> > > > > +        break;
> >> > > > > +    default:
> >> > > > > +        break;
> >> > > > > +    }
> >> > > > > +    return (uint64_t)retval;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_write(void *opaque, hwaddr offset,
> >> > > > > +                              uint64_t val64, unsigned size)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    uint8_t val8 =3D (uint8_t)val64;
> >> > > > > +    uint8_t prev_clk_src =3D CLKSRC(t16);
> >> > > > > +
> >> > > > > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> >> > > > > +
> >> > > > > +    switch (offset) {
> >> > > > > +    case T16_CRA:
> >> > > > > +        t16->cra =3D val8;
> >> > > > > +        if (t16->cra & T16_CRA_OC_CONF) {
> >> > > > > +            ERROR("output compare pins unsupported");
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    case T16_CRB:
> >> > > > > +        t16->crb =3D val8;
> >> > > > > +        if (t16->crb & T16_CRB_ICNC) {
> >> > > > > +            ERROR("input capture noise canceller unsupported"=
);
> >> > > > > +        }
> >> > > > > +        if (t16->crb & T16_CRB_ICES) {
> >> > > > > +            ERROR("input capture unsupported");
> >> > > > > +        }
> >> > > > > +        if (CLKSRC(t16) !=3D prev_clk_src) {
> >> > > > > +            avr_timer16_clksrc_update(t16);
> >> > > > > +            if (prev_clk_src =3D=3D T16_CLKSRC_STOPPED) {
> >> > > > > +                t16->reset_time_ns =3D
> >> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >> > > > > +            }
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    case T16_CRC:
> >> > > > > +        t16->crc =3D val8;
> >> > > > > +        ERROR("output compare pins unsupported");
> >> > > > > +        break;
> >> > > > > +    case T16_CNTL:
> >> > > > > +        /*
> >> > > > > +         * CNT is the 16-bit counter value, it must be
> >> read/written via
> >> > > > > +         * a temporary register (rtmp) to make the read/write
> >> atomic.
> >> > > > > +         */
> >> > > > > +        /* ICR also has this behaviour, and shares rtmp */
> >> > > > > +        /*
> >> > > > > +         * Writing CNT blocks compare matches for one clock
> >> cycle.
> >> > > > > +         * Writing CNT to TOP or to an OCR value (if in use) =
will
> >> > > > > +         * skip the relevant interrupt
> >> > > > > +         */
> >> > > > > +        t16->cntl =3D val8;
> >> > > > > +        t16->cnth =3D t16->rtmp;
> >> > > > > +        avr_timer16_recalc_reset_time(t16);
> >> > > > > +        break;
> >> > > > > +    case T16_CNTH:
> >> > > > > +        t16->rtmp =3D val8;
> >> > > > > +        break;
> >> > > > > +    case T16_ICRL:
> >> > > > > +        /* ICR can only be written in mode T16_MODE_CTC_ICR *=
/
> >> > > > > +        if (MODE(t16) =3D=3D T16_MODE_CTC_ICR) {
> >> > > > > +            t16->icrl =3D val8;
> >> > > > > +            t16->icrh =3D t16->rtmp;
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    case T16_ICRH:
> >> > > > > +        if (MODE(t16) =3D=3D T16_MODE_CTC_ICR) {
> >> > > > > +            t16->rtmp =3D val8;
> >> > > > > +        }
> >> > > > > +        break;
> >> > > > > +    case T16_OCRAL:
> >> > > > > +        /*
> >> > > > > +         * OCRn cause the relevant output compare flag to be
> >> raised, and
> >> > > > > +         * trigger an interrupt, when CNT is equal to the val=
ue
> >> here
> >> > > > > +         */
> >> > > > > +        t16->ocral =3D val8;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRAH:
> >> > > > > +        t16->ocrah =3D val8;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRBL:
> >> > > > > +        t16->ocrbl =3D val8;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRBH:
> >> > > > > +        t16->ocrbh =3D val8;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRCL:
> >> > > > > +        t16->ocrcl =3D val8;
> >> > > > > +        break;
> >> > > > > +    case T16_OCRCH:
> >> > > > > +        t16->ocrch =3D val8;
> >> > > > > +        break;
> >> > > > > +    default:
> >> > > > > +        break;
> >> > > > > +    }
> >> > > > > +    avr_timer16_set_alarm(t16);
> >> > > > > +}
> >> > > > > +
> >> > > > > +static uint64_t avr_timer16_imsk_read(void *opaque,
> >> > > > > +                                      hwaddr offset,
> >> > > > > +                                      unsigned size)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    if (offset !=3D 0) {
> >> > > > > +        return 0;
> >> > > > > +    }
> >> > > > > +    return t16->imsk;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_imsk_write(void *opaque, hwaddr offse=
t,
> >> > > > > +                                   uint64_t val64, unsigned s=
ize)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    if (offset !=3D 0) {
> >> > > > > +        return;
> >> > > > > +    }
> >> > > > > +    t16->imsk =3D (uint8_t)val64;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static uint64_t avr_timer16_ifr_read(void *opaque,
> >> > > > > +                                     hwaddr offset,
> >> > > > > +                                     unsigned size)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    if (offset !=3D 0) {
> >> > > > > +        return 0;
> >> > > > > +    }
> >> > > > > +    return t16->ifr;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static void avr_timer16_ifr_write(void *opaque, hwaddr offset=
,
> >> > > > > +                                  uint64_t val64, unsigned si=
ze)
> >> > > > > +{
> >> > > > > +    assert(size =3D=3D 1);
> >> > > > > +    AVRTimer16State *t16 =3D opaque;
> >> > > > > +    if (offset !=3D 0) {
> >> > > > > +        return;
> >> > > > > +    }
> >> > > > > +    t16->ifr =3D (uint8_t)val64;
> >> > > > > +}
> >> > > > > +
> >> > > > > +static const MemoryRegionOps avr_timer16_ops =3D {
> >> > > > > +    .read =3D avr_timer16_read,
> >> > > > > +    .write =3D avr_timer16_write,
> >> > > > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >> > > > > +    .impl =3D {.max_access_size =3D 1}
> >> > > > > +};
> >> > > > > +
> >> > > > > +static const MemoryRegionOps avr_timer16_imsk_ops =3D {
> >> > > > > +    .read =3D avr_timer16_imsk_read,
> >> > > > > +    .write =3D avr_timer16_imsk_write,
> >> > > > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >> > > > > +    .impl =3D {.max_access_size =3D 1}
> >> > > > > +};
> >> > > > > +
> >> > > > > +static const MemoryRegionOps avr_timer16_ifr_ops =3D {
> >> > > > > +    .read =3D avr_timer16_ifr_read,
> >> > > > > +    .write =3D avr_timer16_ifr_write,
> >> > > > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >> > >
> >
> >

