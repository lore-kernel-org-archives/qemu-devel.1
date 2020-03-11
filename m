Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70270C2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 16:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B9F206E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 16:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Kkupk6U/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B9F206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4UC-0000cY-97
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <intermediadc@hotmail.com>) id 1jC4TI-0008Dl-P1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <intermediadc@hotmail.com>) id 1jC4TG-0000AG-Ta
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:44:40 -0400
Received: from mail-am6eur05olkn2060.outbound.protection.outlook.com
 ([40.92.91.60]:36832 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <intermediadc@hotmail.com>)
 id 1jC4TB-0008Kv-8Y; Wed, 11 Mar 2020 12:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgj+jMaDOyBrXGg5HHEqoXF4JrQoYY4B3F+5KPBU0wtPq5I429I+zA1CsL+rtO90Q5Z5nww0TDj2ce5EmyqIHfX42FawrAYKMOeFTzvPKhgd6uGRHCrxuo74H6CauR1qElmhpsS6X0WPOONj7sEz3fx0fcpA6kOmykvRGNN1i+//XV63TUs6jZC5UZjbw1yL0E5ZYsqw5Tva2fqul4dmTaXjw4Qj9XFFYuQ7rIBOBODzu4B2qAQ+ZYOeqhYpyyJ1qyRKxkt0KgNNlOdbLDKQdw3obV0uqY4HcGj/BouNSsdhIDFm8Mwa2veWhGwqdHXBqd+leA/KkAB76G7LA5v6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga67aw54/s00d8lhaqFgnCB0XVmF1ns7wytI1gsYTOE=;
 b=AlMY067553UhkgsFKWqYxHDUwKIxAfa9g7ds9HiRNFvw/7XhPxxsGPIXuN25SzmFFWCbZEmWontvGlsO928Em1tN3s2xAjMclRAjh8TCFZPsW+GY/r9XuhK+xXiqC2u2dGw4aOVasJ3JvCnYdVZ7gjTQAr2hibNbRZ9Qm6S1V78SNWoQ0MklYEDOzsiL/3RVvJ7KzUBuzFg7r+gAaJCdKe0H1z9Rxd7RJfVy4JQtMsEnB3au8gls11aiNyVtw7Bzn5iaTGkuNz6RbNXdOuR/VxXm6JXTZgzEWyfrBHGfeTuBvfv7Wfoji0gsXotKjClNoFbJbMdetEVAsvNlCUnSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga67aw54/s00d8lhaqFgnCB0XVmF1ns7wytI1gsYTOE=;
 b=Kkupk6U/6dIZyzbSBvGLsubkT8JMglv0ZPLDg1odMT9jAJ5GxvQnLGxcXn3TAq/U4AX2aCKJRKe/1xjmdXghW+sEtsJbrUgU0P93Of5oxxmBprES5UZcwjGSrXJokD6nMbxVrJXC0mdqTJXSN3qfEgH+UUvE1R2T+Qqb1ou+qihFTQpwiu17+wH3brQbiuvXeK+2Ix2ORoIQSc6xR9tGvvPBnRJARHZtN0br7/8Iv8CPv00VtfIyJX1x90wuYpuQ3zq/Mr/dqM2uxRP9DUiwEf5WFZRUmpAbkCy9yq40Rf0zVo1/YRR/c9kdinVpdAesT62xSqxV0wDprbPezsE/sA==
Received: from AM6EUR05FT066.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::3c) by
 AM6EUR05HT246.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::368)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 11 Mar
 2020 16:44:29 +0000
Received: from AM6PR03MB5525.eurprd03.prod.outlook.com (10.233.240.55) by
 AM6EUR05FT066.mail.protection.outlook.com (10.233.240.108) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 11 Mar 2020 16:44:29 +0000
Received: from AM6PR03MB5525.eurprd03.prod.outlook.com
 ([fe80::c482:640:5728:93b7]) by AM6PR03MB5525.eurprd03.prod.outlook.com
 ([fe80::c482:640:5728:93b7%5]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 16:44:29 +0000
From: luigi burdo <intermediadc@hotmail.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: R: Program counter stuck at 0xFFFFFFFC when emulating e5500 processor
 on T4240-RDB board
Thread-Topic: Program counter stuck at 0xFFFFFFFC when emulating e5500
 processor on T4240-RDB board
Thread-Index: AQHV98MtLDUIs86cVEqx/chgvBlp8A==
Date: Wed, 11 Mar 2020 16:44:29 +0000
Message-ID: <AM6PR03MB5525D904C01F4DCA98C73431C8FC0@AM6PR03MB5525.eurprd03.prod.outlook.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:58A015C25FEE89C6B6018195287EBD204AB916A9794584ADAFFE997CC7C25973;
 UpperCasedChecksum:75F67FF0EB80782D0CD8C732644A64F208716F9FAE24FB4C08FAADA2DA2BFFF6;
 SizeAsReceived:6959; Count:43
x-tmn: [bFkMwPV/Fkmsa6fjK9egbUYBQVxLCOSf]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1613ddfe-0add-4110-99fc-08d7c5db7800
x-ms-traffictypediagnostic: AM6EUR05HT246:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XnNOw+I1vBq4D8CyhHYVOEUdBBEeZHP3Nkj1bsuLpqg9YQx52yt0hA05gaAh698UzRz9RsmIm5lbPkwUSzbx75ojbohpDPpva6/kiNUiI2PwfGSW8ISbU1tB2bVtLcvr5ErgDh+0a8XrKXD9SqT5hLBlX65yjHdSIsK5bGwq8VivRPdQr1UyobJk0WUmZy+1oX7XnhtpFuWCzIuiF6PgvXx1DJrhSHb68+T+gz+p0tU=
x-ms-exchange-antispam-messagedata: /hmnhympgYc1aARGjkrgpFFksu3j46WodB/2l+n0Gmgde46Azdwm0dmPDJ2uJaYgdkIZjUYVFl86EnjyLWb+23nH2QVvIn5aRaXdZReYuTYCjHZbdN5mrTF/72mmcDGcKPWbGil8Ox9WTrL360BYBg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM6PR03MB5525D904C01F4DCA98C73431C8FC0AM6PR03MB5525eurp_"
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1613ddfe-0add-4110-99fc-08d7c5db7800
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 16:44:29.7090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT246
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.92.91.60
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
Cc: Wayne Li <waynli329@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR03MB5525D904C01F4DCA98C73431C8FC0AM6PR03MB5525eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI Devid,
the kvm full work on e5500 cpu personally tested this on P5020 and P5040 wh=
en i had the varisys beta boards AmigaOne
But is  not possible made kvm-pr from an e5500 to and e6500 and vice versa.
the e5500 was not kvm-pr compatible with 604e instructions set, probably so=
mething is missing or locked in the cpu? just because i was using on the bo=
ard standard PPC linux distros with only kernel with modules made for the e=
5500 machine and the system was working right.

Probably the e6500 is more compatible with 604e G3/G4 and 970 in Kvm-pr
Ciao
Luigi


________________________________
Da: Qemu-ppc per conto di David Gibson
Inviato: Mercoled=EC, 11 Marzo, 2020 06:03
A: Philippe Mathieu-Daud=E9
Cc: Wayne Li; qemu-ppc; QEMU Developers
Oggetto: Re: Program counter stuck at 0xFFFFFFFC when emulating e5500 proce=
ssor on T4240-RDB board

On Thu, Feb 20, 2020 at 09:44:13AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hello,
>
> On 2/20/20 6:40 AM, Wayne Li wrote:
> > Dear QEMU list members,
>
> No subject: it is unlikely your question get noticed...
>
> Also you didn't Cc'ed the people who might help you (doing that for you):
>
> ./scripts/get_maintainer.pl -f target/ppc/cpu-models.c
> David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC TCG CPUs)
> qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
> qemu-devel@nongnu.org (open list:All patches CC here)

Right.  Unfortunately the embedded cpu support is barely maintained,
so there's only a little bit of help I can give.

> > This will kind of be a repost but I'd like to post my question again
> > because I've gained some more knowledge that makes me feel that my
> > question would be easier to answer.  So we developed a custom-made QEMU
> > VM that emulates a custom machine that has an e5500 processor.  I'm
> > running this VM on a T4240-RDB board which has an e6500 processor and
> > I'm trying to get the VM running with KVM enabled.  The problem I'm
> > having is the program counter refuses to increment at all.  It just
> > stays at the address 0xFFFFFFFC.  On a run without KVM enabled, the VM
> > will also start executing at this same address but the program counter
> > beings to increment immediately.  I know this is a custom QEMU VM and
> > maybe some of the startup stuff we do could be causing problems, but
> > what could possibly stop the program counter from incrementing
> > altogether?
> >
> > Also, I do have another side question.  When running with KVM enabled, =
I
> > see the kernel-level ioctl call KVM_RUN running and then returning over
> > and over again (by the way before the VM kinda grinds to a halt I only
> > see QEMU make the KVM_RUN call twice, but the kernel-level ioctl
> > function is being called over and over again for some reason).  And eac=
h
> > time the KVM_RUN call returns, the return-from-interrupt takes the VM t=
o
> > the address 0xFFFFFFFC.  What is the KVM_RUN ioctl call used for?  Why
> > is it being called over and over again?  Maybe if I understood this
> > better I'd be able to figure out what's stopping my program counter fro=
m
> > incrementing.

I don't really know if KVM even attempts to support e5500 cpus.  We'd
need to at least know what your host kernel is and what KVM variant it
is using.  What's the instruction at 0xfffffffc which seems not to be
handled here properly?  It sounds like you might be getting some sort
of rolling trap, because KVM isn't handling that instruction correctly.

The KVM_RUN is what causes KVM to actual enter the guest and execute
instructions.  It returns when something triggers a guest exit - a
trap or various other events can do this.

--
David Gibson                    | I'll have my music baroque, and my code
david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
                                | _way_ _around_!
http://www.ozlabs.org/~dgibson

--_000_AM6PR03MB5525D904C01F4DCA98C73431C8FC0AM6PR03MB5525eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
HI Devid,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
the kvm full work on e5500 cpu personally tested this on P5020 and P5040 wh=
en i had the varisys beta boards AmigaOne</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
But is&nbsp; not possible made kvm-pr from an e5500 to and e6500 and vice v=
ersa.&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
the e5500 was not kvm-pr compatible with 604e instructions set, probably so=
mething is missing or locked in the cpu? just because i was using on the bo=
ard standard PPC linux distros with only kernel with modules made for the e=
5500 machine and the system was
 working right.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Probably the e6500 is more compatible with 604e G3/G4 and 970 in Kvm-pr</di=
v>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Ciao&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Luigi&nbsp;</div>
<div>
<div><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0);">
<br>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%;">
<b>Da:</b> Qemu-ppc per conto di David Gibson<br>
<b>Inviato:</b> Mercoled=EC, 11 Marzo, 2020 06:03<br>
<b>A:</b> Philippe Mathieu-Daud=E9<br>
<b>Cc:</b> Wayne Li; qemu-ppc; QEMU Developers<br>
<b>Oggetto:</b> Re: Program counter stuck at 0xFFFFFFFC when emulating e550=
0 processor on T4240-RDB board
<div><br>
</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Feb 20, 2020 at 09:44:13AM &#43;0100, Phil=
ippe Mathieu-Daud=E9 wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; On 2/20/20 6:40 AM, Wayne Li wrote:<br>
&gt; &gt; Dear QEMU list members,<br>
&gt; <br>
&gt; No subject: it is unlikely your question get noticed...<br>
&gt; <br>
&gt; Also you didn't Cc'ed the people who might help you (doing that for yo=
u):<br>
&gt; <br>
&gt; ./scripts/get_maintainer.pl -f target/ppc/cpu-models.c<br>
&gt; David Gibson &lt;david@gibson.dropbear.id.au&gt; (maintainer:PowerPC T=
CG CPUs)<br>
&gt; qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)<br>
&gt; qemu-devel@nongnu.org (open list:All patches CC here)<br>
<br>
Right.&nbsp; Unfortunately the embedded cpu support is barely maintained,<b=
r>
so there's only a little bit of help I can give.<br>
<br>
&gt; &gt; This will kind of be a repost but I'd like to post my question ag=
ain<br>
&gt; &gt; because I've gained some more knowledge that makes me feel that m=
y<br>
&gt; &gt; question would be easier to answer.&nbsp; So we developed a custo=
m-made QEMU<br>
&gt; &gt; VM that emulates a custom machine that has an e5500 processor.&nb=
sp; I'm<br>
&gt; &gt; running this VM on a T4240-RDB board which has an e6500 processor=
 and<br>
&gt; &gt; I'm trying to get the VM running with KVM enabled.&nbsp; The prob=
lem I'm<br>
&gt; &gt; having is the program counter refuses to increment at all.&nbsp; =
It just<br>
&gt; &gt; stays at the address 0xFFFFFFFC.&nbsp; On a run without KVM enabl=
ed, the VM<br>
&gt; &gt; will also start executing at this same address but the program co=
unter<br>
&gt; &gt; beings to increment immediately.&nbsp; I know this is a custom QE=
MU VM and<br>
&gt; &gt; maybe some of the startup stuff we do could be causing problems, =
but<br>
&gt; &gt; what could possibly stop the program counter from incrementing<br=
>
&gt; &gt; altogether?<br>
&gt; &gt; <br>
&gt; &gt; Also, I do have another side question.&nbsp; When running with KV=
M enabled, I<br>
&gt; &gt; see the kernel-level ioctl call KVM_RUN running and then returnin=
g over<br>
&gt; &gt; and over again (by the way before the VM kinda grinds to a halt I=
 only<br>
&gt; &gt; see QEMU make the KVM_RUN call twice, but the kernel-level ioctl<=
br>
&gt; &gt; function is being called over and over again for some reason).&nb=
sp; And each<br>
&gt; &gt; time the KVM_RUN call returns, the return-from-interrupt takes th=
e VM to<br>
&gt; &gt; the address 0xFFFFFFFC.&nbsp; What is the KVM_RUN ioctl call used=
 for?&nbsp; Why<br>
&gt; &gt; is it being called over and over again?&nbsp; Maybe if I understo=
od this<br>
&gt; &gt; better I'd be able to figure out what's stopping my program count=
er from<br>
&gt; &gt; incrementing.<br>
<br>
I don't really know if KVM even attempts to support e5500 cpus.&nbsp; We'd<=
br>
need to at least know what your host kernel is and what KVM variant it<br>
is using.&nbsp; What's the instruction at 0xfffffffc which seems not to be<=
br>
handled here properly?&nbsp; It sounds like you might be getting some sort<=
br>
of rolling trap, because KVM isn't handling that instruction correctly.<br>
<br>
The KVM_RUN is what causes KVM to actual enter the guest and execute<br>
instructions.&nbsp; It returns when something triggers a guest exit - a<br>
trap or various other events can do this.<br>
<br>
-- <br>
David Gibson&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | I'll have my music ba=
roque, and my code<br>
david AT gibson.dropbear.id.au&nbsp; | minimalist, thank you.&nbsp; NOT _th=
e_ _other_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | _way_ _around_!<br>
<a href=3D"http://www.ozlabs.org/~dgibson" target=3D"_blank" rel=3D"noopene=
r noreferrer" data-auth=3D"NotApplicable">http://www.ozlabs.org/~dgibson</a=
><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_AM6PR03MB5525D904C01F4DCA98C73431C8FC0AM6PR03MB5525eurp_--

