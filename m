Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B650DC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B79206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NAxBnWf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B79206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iun6v-0007wp-L4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robhenry@microsoft.com>) id 1iun69-0007Nz-2m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robhenry@microsoft.com>) id 1iun66-0006bm-BZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:45:20 -0500
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com
 ([40.107.244.104]:34145 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robhenry@microsoft.com>)
 id 1iun65-0006bF-Q1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:45:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2tlCX/VIi2ZdcLovBrHhtmzX9tl+I06BwH+uWvUTRHNbIR+6u58bSNA15sy9RLcihOMSHCf3DJFiCNW/t2K271wRdb9kJGwLasrWW+y2Xvz+DmTVOnJRwt8ls1Sq9hLasF3UFqtYR2JEo/kfpBO9457end1RfCj/huZxfnS20b9fTbOAGOqxIhx7cLRBRGEyBt5+Z8TIdIBUCrbQ2d1zUHasUO0bvoQC4SIPvxATXsMEsU2m5CUpWMZn0iPBO8vWV6jSNhYmaj6b7/fgDyxPG8DmZBgn7d43NOkGgQFLx0hXDIMTif5F4rdU9mVx7JNZSTvWzHBT3eApylOnzV2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oRUiXWwYRV3ZX+ijel5/aE2NEJbQPWrqjL8+IGoCUY=;
 b=U76gqcN+lqLCzZhkQfPl/inl4J4x/JVo7Xcsdo6USFm6sDrC3kYtdVKym+XgfWZrpHI9KStdC9VQeYJLQMlN0BdbsFcR2OFC9ybvlxgn6Ngz7fpDoePSfLgdNZ9P3Qzf2vKKW/0xoln+5wczXdzrDAfMgyA0l0NQxd+kaGwIYrVpyPP4vmuP7/o6AaRXGdIBwxGD8pxH/waFiA6tD6WfymJlY+q36ksTbs7ekIVTW8X2BkI74hJVENhYaFASYzOJlOM061wJ/JwazIdzQlOaBjErCu7ObepRCZiRlrMWk+5ozkuBwpgEUMblwRGyBno25gJJ6HMCoDw3+2Kgi8kouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oRUiXWwYRV3ZX+ijel5/aE2NEJbQPWrqjL8+IGoCUY=;
 b=NAxBnWf7XscaVntLWakVW/iWcVTbl3DaNVLylaqRag3N7pJPOg7CMjPaaTsl54tYl+6UeUHPQ26v6RrOn2PRlKhAo2C7rSSyDqj3LB4Cb+urdOO/PwBHxRxbB25/+6d7gu8Y6Q4FbJsvzR773oojwuYiRqO94idPwkkwV6cl3h4=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com (52.132.20.149) by
 BL0PR2101MB1026.namprd21.prod.outlook.com (52.132.20.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Fri, 24 Jan 2020 00:45:14 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4%5]) with mapi id 15.20.2686.008; Fri, 24 Jan 2020
 00:45:14 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: QEMU for aarch64 with plugins seems to fail basic consistency checks
Thread-Topic: QEMU for aarch64 with plugins seems to fail basic consistency
 checks
Thread-Index: AQHV0k8E/OZrWdWsYkuV7phGRZSNIQ==
Date: Fri, 24 Jan 2020 00:45:14 +0000
Message-ID: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-24T00:45:14.180Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robhenry@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:3871:47d9:980b:71b0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcdf69bb-a2ba-4fe4-7c00-08d7a066ad16
x-ms-traffictypediagnostic: BL0PR2101MB1026:
x-microsoft-antispam-prvs: <BL0PR2101MB10262D87405ECCE177C01CDAD60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(6916009)(316002)(55016002)(71200400001)(478600001)(8990500004)(10290500003)(8936002)(6506007)(52536014)(33656002)(66946007)(5660300002)(4326008)(66446008)(66556008)(19627405001)(76116006)(64756008)(86362001)(66476007)(9686003)(7696005)(81166006)(81156014)(8676002)(2906002)(186003)(91956017);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1026;
 H:BL0PR2101MB1026.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwQAmhJxY0H4Xc82Kvq44MYw/onsBEqr2dHsJyhr/GVBbWm796vi7/F2Mk/VgEenqNBwNUxdoUfswsIB1mrt6Z9mE0wl9umJajEfGM1+hUPZW4lO8hejpnVhcbbE7fc9Xf5lY86/0Vv/YACMnVxBr8P4wvziBpFhHH3wLRzgnwobnkLnvimjalChFkEY4ld60cA9vhtBhReGRY8xu5OPzxKGIN0mm5ELlgjF5+ObOQyx4WWkk5ePOzrDNKxAgdo2yZSnDrSmcg2ZGu8Qg7LKWdiXqCwyFC+EMrip47etSi7FrPsn5e7P2qaVrmMDcDhXPgB5vkFiFCsdYUd+/fcj7PA1dhJ8MHHlsVjItHjjKMb3jgFW2L7x0Jw6HFhzvIwdvMHZFGP38J7xY+LD0SS5lXpxT8wWBxF35oR2xtJqeUaqB+HMCFH11mjVje2MdgcH
x-ms-exchange-antispam-messagedata: C8elawpQgGriNhUTJrzal9bEL14v7kz5G0tbGYqdzRMHiQpb8Ls+xxO0tGMIOOYqpK9DG7GsDR0eWaaGfoFX7qdDAdtmwMVkUummF9mqsNk7g+FdUToMYC3cht3PE5vRJd/D9I2ltCBJspSD4yqTBjp4Bi5PKxS3w5V3tVlOvJV1AKhRsDfYV0jRK/DtNerU5jDcE7fkju/AAcL0aoAuCw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026C24DACAFB1771DE47706D60E0BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdf69bb-a2ba-4fe4-7c00-08d7a066ad16
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 00:45:14.5562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SumgjELDp2hJhnCrQ0jGeeJ/+0H7Y8D5xk1Eq9jpPjgTRi/f8cjar5rt2gvQbdJ4orW3V5N1fonMgChLHv97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1026
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.104
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

--_000_BL0PR2101MB1026C24DACAFB1771DE47706D60E0BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I wrote a QEMU plugin for aarch64 where the insn and mem callbacks print ou=
t the specifics of the guest instructions as they are "executed".  I expect=
 this trace stream to be well behaved but it is not. By well-behaved, I exp=
ect memory insns print out some memory details, non-memory insns don't prin=
t anything, and the pc only changes after a control flow instruction.  I do=
n't see that gross correctness about 2% of the time.


  1.  I'm using qemu at tag v4.2.0 (or master head; it doesn't matter), run=
ning on a x86_64 host.
  2.  I build qemu using   ./configure --disable-sdl --enable-gtk --enable-=
plugins --enable-debug --target-list=3Daarch64-softmmu aarch64-linux-user
  3.  I execute qemu from its build area build/aarch64-linux-user/qemu-aarc=
h64, with flags --cpu cortex-a72 and the appropriate args to --plugin ... -=
d plugin -D .....
  4.  I'm emulating a simple C program in linux emulation mode.
  5.  The resulting qemu execution is valgrind clean (eg, I run qemu under =
valgrind) for my little program save for memory leaks I reported a few days=
 ago.

Below is an example of my trace output (the first int printed is the cpu_in=
dex, checked to be always 0). Note that the ldr instruction at 0x41a608 som=
etimes reports a memop, but most of the time it doesn't.  Note that 0x41a60=
8 is seen, by trace, running back to back. Note that (bottom of trace) that=
 the movz instruction reports a memop.  (The executed code comes from glibc=
 _dl_aux_init, executed before main() is called.)

How should this problem be tackled? I can't figure out how to make each tcg=
 block be exactly 1 guest (aarch64) insn, which is where I'd first start ou=
t.

0 0x000000000041a784 0x000000000041a784 0xf1000c3f cmp x1, #3
0 0x000000000041a788 0x000000000041a788 0x54fff401 b.ne #0xfffffffffffffe80
0 0x000000000041a78c 0x000000000041a78c 0x52800033 movz w19, #0x1
0 0x000000000041a790 0x000000000041a790 0xf9400416 ldr x22, [x0, #8] 0 mem =
 {3 0 0 0} 0x0000004000800618
0 0x000000000041a794 0x000000000041a794 0x17ffff9d b #0xfffffffffffffe74
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  0 =
mem  {3 0 0 0} 0x0000004000800620
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  0 =
mem  {3 0 0 0} 0x0000004000800630
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1
0 0x000000000041a7dc 0x000000000041a7dc 0xf9400418 ldr x24, [x0, #8] 0 mem =
 {3 0 0 0} 0x0000004000800638
0 0x000000000041a7e0 0x000000000041a7e0 0x17ffff8a b #0xfffffffffffffe28
0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1 0 mem  {3=
 0 0 0} 0x0000004000800640






--_000_BL0PR2101MB1026C24DACAFB1771DE47706D60E0BL0PR2101MB1026_
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
I wrote a QEMU plugin for aarch64 where the insn and mem callbacks print ou=
t the specifics of the guest instructions as they are &quot;executed&quot;.=
&nbsp; I expect this trace stream to be well behaved but it is not. By well=
-behaved, I expect memory insns print out some
 memory details, non-memory insns don't print anything, and the pc only cha=
nges after a control flow instruction.&nbsp; I don't see that gross correct=
ness about 2% of the time.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<ol spellcheck=3D"false">
<li><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvet=
ica, sans-serif; font-size: 12pt;" spellcheck=3D"false">I'm using qemu at t=
ag v4.2.0 (or master head; it doesn't matter), running on a x86_64 host.</s=
pan></li><li><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Aria=
l, Helvetica, sans-serif; font-size: 12pt;" spellcheck=3D"false">I build qe=
mu using</span>&nbsp; &nbsp;./configure --disable-sdl --enable-gtk --enable=
-plugins --enable-debug --target-list=3Daarch64-softmmu aarch64-linux-user<=
/li><li>I execute qemu from its build area&nbsp;<span spellcheck=3D"false" =
style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt;">build/aarch64-linux-user/qemu-aarch64, with flags =
--cpu cortex-a72 and the appropriate args to
 --plugin ... -d plugin -D .....</span></li><li>I'm emulating a simple C pr=
ogram in linux emulation mode.<br>
</li><li>The resulting qemu execution is valgrind clean (eg, I run qemu und=
er valgrind) for my little program save for memory leaks I reported a few d=
ays ago.</li></ol>
</div>
<div style=3D"" spellcheck=3D"false"><span style=3D"" spellcheck=3D"false">
<div spellcheck=3D"false" style=3D"color: rgb(0, 0, 0); font-family: Calibr=
i, Arial, Helvetica, sans-serif; font-size: 12pt; margin: 0px;">
<span spellcheck=3D"false" style=3D"margin: 0px">Below is an example of my =
trace output (the first int printed is the cpu_index, checked to be always =
0). Note that&nbsp;</span><span spellcheck=3D"false" style=3D"color: rgb(0,=
 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt=
;">the
 ldr instruction at 0x41a608 sometimes reports a memop, but most of the tim=
e it doesn't.&nbsp; Note that 0x41a608 is seen, by trace, running back to b=
ack. Note that (bottom of trace) that the movz instruction reports a memop.=
&nbsp; (The executed code comes from glibc&nbsp;</span><span style=3D"color=
: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif; font-si=
ze: 12pt;">_dl_aux_init,
 executed before main() is called.)</span></div>
<div spellcheck=3D"false" style=3D"color: rgb(0, 0, 0); font-family: Calibr=
i, Arial, Helvetica, sans-serif; font-size: 12pt; margin: 0px;">
<br>
</div>
<div spellcheck=3D"false" style=3D"color: rgb(0, 0, 0); font-family: Calibr=
i, Arial, Helvetica, sans-serif; font-size: 12pt; margin: 0px;">
<span spellcheck=3D"false" style=3D"margin: 0px">How should this problem be=
 tackled? I can't figure out how to make each tcg block be exactly 1 guest =
(aarch64) insn, which is where I'd first start out.</span></div>
<div spellcheck=3D"false" style=3D"color: rgb(0, 0, 0); font-family: Calibr=
i, Arial, Helvetica, sans-serif; font-size: 12pt; margin: 0px;">
<span spellcheck=3D"false" style=3D"margin: 0px; font-family: &quot;Courier=
 New&quot;, monospace;"><br>
</span></div>
<span>0 0x000000000041a784 0x000000000041a784 0xf1000c3f cmp x1, #3<br>
</span>
<div>0 0x000000000041a788 0x000000000041a788 0x54fff401 b.ne #0xfffffffffff=
ffe80<br>
</div>
<div>0 0x000000000041a78c 0x000000000041a78c 0x52800033 movz w19, #0x1<br>
</div>
<div>0 0x000000000041a790 0x000000000041a790 0xf9400416 ldr x22, [x0, #8] 0=
 mem &nbsp;{3 0 0 0} 0x0000004000800618<br>
</div>
<div>0 0x000000000041a794 0x000000000041a794 0x17ffff9d b #0xfffffffffffffe=
74<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
! &nbsp;0 mem &nbsp;{3 0 0 0} 0x0000004000800620<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
! &nbsp;0 mem &nbsp;{3 0 0 0} 0x0000004000800630<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]=
!<br>
</div>
<div>0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44<br>
</div>
<div>0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1<br>
</div>
<div>0 0x000000000041a7dc 0x000000000041a7dc 0xf9400418 ldr x24, [x0, #8] 0=
 mem &nbsp;{3 0 0 0} 0x0000004000800638<br>
</div>
<div>0 0x000000000041a7e0 0x000000000041a7e0 0x17ffff8a b #0xfffffffffffffe=
28<br>
</div>
<div>0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1 0 me=
m &nbsp;{3 0 0 0} 0x0000004000800640<br>
</div>
<span></span><br>
<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;" spellcheck=3D"false"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;" spellcheck=3D"false"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;" spellcheck=3D"false">&nbsp;</span></div>
</body>
</html>

--_000_BL0PR2101MB1026C24DACAFB1771DE47706D60E0BL0PR2101MB1026_--

