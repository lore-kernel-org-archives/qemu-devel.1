Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4351C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9463F2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dyqQjtOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3G7-0007lu-QK
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robhenry@microsoft.com>) id 1iv3FF-0006xt-3v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robhenry@microsoft.com>) id 1iv3FC-0007O1-Kx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:59:48 -0500
Received: from mail-eopbgr700106.outbound.protection.outlook.com
 ([40.107.70.106]:22145 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robhenry@microsoft.com>)
 id 1iv3FC-0007NI-7E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:59:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii7QzQPG/ezwWrLncX/odFwc3FqgxVfoJ1GoGmUAMRQyCgAMkIioic0wGsSFZ+Xb1EeobQIO2/HnvVnkl34wrskCavcEBLqCiXxQZizga/GwmAm53qwSpTLidL6T3sz3HImEe4/3slriFYF9BnrUImH50gSJHY7zqKRfYOepbF9wXsZO/sWxjbTEDyzm2B7zD3w9zUfboaq/QsR+cY5pnn9Tr5+jBnLxp7B8TFyaGDwtB0bkev8Vdocuk74y6tb9OlAuzJQShhcphYUjuKSKi0yqOe4v0NdXowyyBDUCO7dZXhohAMh1rs5HFdDXuH+By+Vd52rtESVnfNim/kskRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/A0Ev0jm82tvyacoBmSQLrWa/CBLqxQH/Po/XJRS8k=;
 b=ninoKwPkkvzoL7TaSUo5Dej1boi5fj2FnQ+7ful6+B0+8j+kOpnsTBy84IlfM5Ihi9xvz58ojwrTeEFgbzuHfIOwAmqLxMp3DgqRDENAL8UVYYVYTQrqsRUPc3tMtFwWSckOui05+MZHsj6p3sZYDfDhIAAM+ZflNDJHrH5kyMdpa6fYW3WPfp3tu5IMz9SkB4IaqgYw+W1W5lA3nBHOinR0ayLC7GWlpOqo90O6ApwTpRXScxqZ34n1COVPsuGB4jMNrQbu23v1C+hxDvxgbos9CJUV6AKZJWz/lBH1qNB44zKA6WkJq8Dj4cd+9SqR1ftPBzjyCmk/kbbU1Giepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/A0Ev0jm82tvyacoBmSQLrWa/CBLqxQH/Po/XJRS8k=;
 b=dyqQjtOoVRmH61XoK/QutJwleSjc6soHUOpQvYChll9KtqC5MFE46wrdmO/fs2KFNXCxCodcRa/kXLnIO18CWAh5rrvDeL1EHnff6yQ4uAh05URb1rn/cR97uSxnCMnjgOyHSaNxJEvl1kKN373rfkTPGrFc9/Mfp4Ahvt8YJEU=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com (52.132.20.149) by
 BL0PR2101MB0930.namprd21.prod.outlook.com (52.132.20.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.10; Fri, 24 Jan 2020 17:59:44 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4%5]) with mapi id 15.20.2707.000; Fri, 24 Jan 2020
 17:59:44 +0000
From: Robert Henry <robhenry@microsoft.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Laurent Desnogues
 <laurent.desnogues@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail basic
 consistency checks
Thread-Topic: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail basic
 consistency checks
Thread-Index: AQHV0k8E/OZrWdWsYkuV7phGRZSNIaf6BEuAgAAUvGI=
Date: Fri, 24 Jan 2020 17:59:43 +0000
Message-ID: <BL0PR2101MB10265432576D6FF63AFA2282D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
References: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>,
 <87eevoak12.fsf@linaro.org>
In-Reply-To: <87eevoak12.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-24T17:59:43.336Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robhenry@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:3871:47d9:980b:71b0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da70315c-4050-4f35-8c87-08d7a0f7314a
x-ms-traffictypediagnostic: BL0PR2101MB0930:
x-microsoft-antispam-prvs: <BL0PR2101MB0930C7934A0DC7B3024063B2D60E0@BL0PR2101MB0930.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(66446008)(7696005)(316002)(478600001)(52536014)(4326008)(186003)(64756008)(66556008)(110136005)(33656002)(66476007)(66946007)(76116006)(10290500003)(91956017)(55016002)(19627405001)(81156014)(5660300002)(9686003)(53546011)(6506007)(8990500004)(8936002)(2906002)(71200400001)(81166006)(86362001)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB0930;
 H:BL0PR2101MB1026.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFBOJ7RaLUJ5zamr+VQ4qDuh1pwJ9VS9fUWe1DCyQsUD1wTtwRtyxjpkIsrLHS+Q9nztaP3Ei+EmyDRe8avO3OizbHBvdaRVe1UlorPU3t/60nZtcOGiO0bxIV2JZzgSKGvNl2nsIb4EhgQMo5pPZbjuaAyMpRg0w7cu/vTuT4CaI5ghBGxYJtKPe5F5/4B5WtVANVGnsj03PnLhoYJeZEkgMWHpnw3JntmHFtgKnmsVVVtpLnPc5+0OEnBzzqiwl0slNx5aBWhTOI1276Ib7EySu9fQybyXJhuwH5FakLHu53W5Yl+TPMLOGpO1PjbZEf5YsXLic2mLiDrQVkvTl/1Stk5fUUdXfYYBW9mXQQOVS6yyGbK+w/H3PeDDha6raGuLxp41NmnIGrPkWAklqc7zwsBFz8usSIkcn0VTfpX6t0/lMVond/zZfrXByXIX
x-ms-exchange-antispam-messagedata: WeptB2DDG3A5Of6JCUV9ywiNRjGptCXoS22GNtNgKu1qDaq/ME3/fYJXeixjNFOwmTmOdP3aBAsF1O1eQRrZj5Oh8LDzInz/1wHn1nI02ns1OhOBet85FCKn2SpNCdzjTP9foyiCObtDnKR6GPbrwpSL4IrtA9vedBVyLKNaBwNL9RjXMPq6a2rQ24K0pAh6QzitxBwraKQsdIwwqzhvzQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB10265432576D6FF63AFA2282D60E0BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da70315c-4050-4f35-8c87-08d7a0f7314a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 17:59:43.8997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaT8kXi2ol0pYQNNBl+XXhoVCgtzLGpQfiXD4KWnUf0RQ4kzv4Rm3Y5+nMHBWnep4FYx2f/jg/a02pMR0v/2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0930
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.106
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BL0PR2101MB10265432576D6FF63AFA2282D60E0BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found at least one problem with my plugin.

I was assuming that the insn data from
      struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
could be passed into qemu_plugin_register_vcpu_insn_exec_cb both as the 1st=
 argument AND as the user data last argument.  This assumed that insn would=
 persist and be unique from when qemu_plugin_register_vcpu_insn_exec_cb was=
 called to when the execution-time callback (vcpu_insn_exec_before) was cal=
led.

This assumption is not true.

I now capture pieces of *insn into my own persistent data structure, and pa=
ss that in as void *udata, my problems went away.

I think this lack of persistence of insn should be documented, or treated a=
s a bug to be fixed.
________________________________
From: Alex Benn=E9e <alex.bennee@linaro.org>
Sent: Friday, January 24, 2020 8:36 AM
To: Robert Henry <robhenry@microsoft.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail basic c=
onsistency checks


Robert Henry <robhenry@microsoft.com> writes:

> I wrote a QEMU plugin for aarch64 where the insn and mem callbacks
> print out the specifics of the guest instructions as they are
> "executed".  I expect this trace stream to be well behaved but it is
> not.

Can you post your plugin? It's hard to diagnose what might be wrong
without the actual code.

> By well-behaved, I expect memory insns print out some memory details,
> non-memory insns don't print anything, and the pc only changes after a
> control flow instruction.

Exactly how are you tracking the PC? You should have the correct PC as
you instrument each instruction. Are you saying qemu_plugin_insn_vaddr()
doesn't report a different PC for each instrumented instruction in a block?

> I don't see that gross correctness about 2%
> of the time.


>
>
>   1.  I'm using qemu at tag v4.2.0 (or master head; it doesn't matter), r=
unning on a x86_64 host.
>   2.  I build qemu using   ./configure --disable-sdl --enable-gtk --enabl=
e-plugins --enable-debug --target-list=3Daarch64-softmmu aarch64-linux-user
>   3.  I execute qemu from its build area build/aarch64-linux-user/qemu-aa=
rch64, with flags --cpu cortex-a72 and the appropriate args to --plugin ...=
 -d plugin -D .....
>   4.  I'm emulating a simple C program in linux emulation mode.
>   5.  The resulting qemu execution is valgrind clean (eg, I run qemu unde=
r valgrind) for my little program save for memory leaks I reported a few da=
ys ago.
>
> Below is an example of my trace output (the first int printed is the cpu_=
index, checked to be always 0). Note that the ldr instruction at 0x41a608 s=
ometimes reports a memop, but most of the time it doesn't.  Note that 0x41a=
608 is seen, by trace, running back to back. Note that (bottom of trace) th=
at the movz instruction reports a memop.  (The executed code comes from gli=
bc _dl_aux_init, executed before main() is called.)
>
> How should this problem be tackled? I can't figure out how to make each t=
cg block be exactly 1 guest (aarch64) insn, which is where I'd first start =
out.
>
> 0 0x000000000041a784 0x000000000041a784 0xf1000c3f cmp x1, #3
> 0 0x000000000041a788 0x000000000041a788 0x54fff401 b.ne #0xfffffffffffffe=
80
> 0 0x000000000041a78c 0x000000000041a78c 0x52800033 movz w19, #0x1
> 0 0x000000000041a790 0x000000000041a790 0xf9400416 ldr x22, [x0, #8] 0 me=
m  {3 0 0 0} 0x0000004000800618
> 0 0x000000000041a794 0x000000000041a794 0x17ffff9d b #0xfffffffffffffe74
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  =
0 mem  {3 0 0 0} 0x0000004000800620
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  =
0 mem  {3 0 0 0} 0x0000004000800630
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1
> 0 0x000000000041a7dc 0x000000000041a7dc 0xf9400418 ldr x24, [x0, #8] 0 me=
m  {3 0 0 0} 0x0000004000800638
> 0 0x000000000041a7e0 0x000000000041a7e0 0x17ffff8a b #0xfffffffffffffe28
> 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1 0 mem  =
{3 0 0 0} 0x0000004000800640

I'd like to see the -d in_asm,op,op_opt for that unexpected memop operation=
.

--
Alex Benn=E9e

--_000_BL0PR2101MB10265432576D6FF63AFA2282D60E0BL0PR2101MB1026_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
I found at least one problem with my plugin.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
I was assuming that the insn data from</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
&nbsp;&nbsp;<span>&nbsp; &nbsp; struct qemu_plugin_insn *insn =3D qemu_plug=
in_tb_get_insn(tb, i);<br>
</span><span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
could be passed into&nbsp;qemu_plugin_register_vcpu_insn_exec_cb both as th=
e 1st argument AND as the user data last argument.&nbsp; This assumed that =
insn would persist and be unique from when&nbsp;qemu_plugin_register_vcpu_i=
nsn_exec_cb was called to when the execution-time
 callback (vcpu_insn_exec_before) was called.&nbsp;&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
This assumption is not true.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
I now capture pieces of *insn into my own persistent data structure, and pa=
ss that in as void *udata, my problems went away.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
I think this lack of persistence of insn should be documented, or treated a=
s a bug to be fixed.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Benn=E9e &lt;ale=
x.bennee@linaro.org&gt;<br>
<b>Sent:</b> Friday, January 24, 2020 8:36 AM<br>
<b>To:</b> Robert Henry &lt;robhenry@microsoft.com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail =
basic consistency checks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
Robert Henry &lt;robhenry@microsoft.com&gt; writes:<br>
<br>
&gt; I wrote a QEMU plugin for aarch64 where the insn and mem callbacks<br>
&gt; print out the specifics of the guest instructions as they are<br>
&gt; &quot;executed&quot;.&nbsp; I expect this trace stream to be well beha=
ved but it is<br>
&gt; not.<br>
<br>
Can you post your plugin? It's hard to diagnose what might be wrong<br>
without the actual code.<br>
<br>
&gt; By well-behaved, I expect memory insns print out some memory details,<=
br>
&gt; non-memory insns don't print anything, and the pc only changes after a=
<br>
&gt; control flow instruction.<br>
<br>
Exactly how are you tracking the PC? You should have the correct PC as<br>
you instrument each instruction. Are you saying qemu_plugin_insn_vaddr()<br=
>
doesn't report a different PC for each instrumented instruction in a block?=
<br>
<br>
&gt; I don't see that gross correctness about 2%<br>
&gt; of the time.<br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt;&nbsp;&nbsp; 1.&nbsp; I'm using qemu at tag v4.2.0 (or master head; it =
doesn't matter), running on a x86_64 host.<br>
&gt;&nbsp;&nbsp; 2.&nbsp; I build qemu using&nbsp;&nbsp; ./configure --disa=
ble-sdl --enable-gtk --enable-plugins --enable-debug --target-list=3Daarch6=
4-softmmu aarch64-linux-user<br>
&gt;&nbsp;&nbsp; 3.&nbsp; I execute qemu from its build area build/aarch64-=
linux-user/qemu-aarch64, with flags --cpu cortex-a72 and the appropriate ar=
gs to --plugin ... -d plugin -D .....<br>
&gt;&nbsp;&nbsp; 4.&nbsp; I'm emulating a simple C program in linux emulati=
on mode.<br>
&gt;&nbsp;&nbsp; 5.&nbsp; The resulting qemu execution is valgrind clean (e=
g, I run qemu under valgrind) for my little program save for memory leaks I=
 reported a few days ago.<br>
&gt;<br>
&gt; Below is an example of my trace output (the first int printed is the c=
pu_index, checked to be always 0). Note that the ldr instruction at 0x41a60=
8 sometimes reports a memop, but most of the time it doesn't.&nbsp; Note th=
at 0x41a608 is seen, by trace, running back
 to back. Note that (bottom of trace) that the movz instruction reports a m=
emop.&nbsp; (The executed code comes from glibc _dl_aux_init, executed befo=
re main() is called.)<br>
&gt;<br>
&gt; How should this problem be tackled? I can't figure out how to make eac=
h tcg block be exactly 1 guest (aarch64) insn, which is where I'd first sta=
rt out.<br>
&gt;<br>
&gt; 0 0x000000000041a784 0x000000000041a784 0xf1000c3f cmp x1, #3<br>
&gt; 0 0x000000000041a788 0x000000000041a788 0x54fff401 b.ne #0xfffffffffff=
ffe80<br>
&gt; 0 0x000000000041a78c 0x000000000041a78c 0x52800033 movz w19, #0x1<br>
&gt; 0 0x000000000041a790 0x000000000041a790 0xf9400416 ldr x22, [x0, #8] 0=
 mem&nbsp; {3 0 0 0} 0x0000004000800618<br>
&gt; 0 0x000000000041a794 0x000000000041a794 0x17ffff9d b #0xfffffffffffffe=
74<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!&nbsp; 0 mem&nbsp; {3 0 0 0} 0x0000004000800620<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!&nbsp; 0 mem&nbsp; {3 0 0 0} 0x0000004000800630<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
&gt; 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
&gt; 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1<br>
&gt; 0 0x000000000041a7dc 0x000000000041a7dc 0xf9400418 ldr x24, [x0, #8] 0=
 mem&nbsp; {3 0 0 0} 0x0000004000800638<br>
&gt; 0 0x000000000041a7e0 0x000000000041a7e0 0x17ffff8a b #0xfffffffffffffe=
28<br>
&gt; 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1 0 me=
m&nbsp; {3 0 0 0} 0x0000004000800640<br>
<br>
I'd like to see the -d in_asm,op,op_opt for that unexpected memop operation=
.<br>
<br>
-- <br>
Alex Benn=E9e<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR2101MB10265432576D6FF63AFA2282D60E0BL0PR2101MB1026_--

