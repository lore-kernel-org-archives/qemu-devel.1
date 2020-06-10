Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C06C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B76F204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GDTKk+wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B76F204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj28L-0007Fr-DV
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 10:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1jj27V-0006Qh-7b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:54:25 -0400
Received: from mail-bn8nam12on2096.outbound.protection.outlook.com
 ([40.107.237.96]:18112 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1jj27T-0004EA-A3
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:54:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtforVTg4nQfGpnQX5ndlGu6oX7vBcuzL3IfDBdbWY095VpBbRaAduSS5d1J743YZBVQtOEo3EScM0bHDotElA80s+bQmaEgHuPCAdpqf9qPdwZGeUiOpIEWwCBUOnt2WiyWAbhxLoCjUqgQp0NoWfMjWdnbUeSL+tQUASMmBaNB+n6yXh204Ps0FzEXm6UiMm4/oeXQMBUkqx3HckaeVNX+a7NKrwulmcf3WidQiAcwakH6rlXJe6LPTeWCPTnLF/IilxHCD5cj0gS7MPi/eCX9eVKX5TOqHPjAqZ1m9MtNgJbQQi69KiFPzd33qv/dci7If/74Rjh5dYqrpzfQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIC4n7bgVpVrs2g+TqVx5OE//E/H6ozu46j4BD/zN9U=;
 b=ZVQCZFLVVQUNG5c96v33fHxNaLpwVOH941N1BXCsZrmO1M35o8dI7UN+TlfxUtK1/tqc03JlFztZiH16OY1GfnVtgiiLXUN2DguRT6Cf8BL480dqvtr/8lVP7QfWCllhJ3Dy4eRIigwwRWcFXjldUMK7CwevDYa0bIak41UPBxG9I8tYe8/C4Cx1OdNtsitJC8Ajbzjt95sbU41R7HzOkkOTpR4imrQThdNbAYRz+9PzITxZWUn1ecQfSNMbtlbZZa3N3wRvhbZ3oB0LZxNprv5eSF0uBryanrgQBQcWa/K09IsxeQtIXqO5zTWerE6dIUWB3SWy060oLtoOKUmrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIC4n7bgVpVrs2g+TqVx5OE//E/H6ozu46j4BD/zN9U=;
 b=GDTKk+wkM5M378CuSeqelh1A59IHbQvG1ypruiDIf13op1hUX6iER3axb1cljMxjAsHyxKQZP5JXO3i6wNXpsdquy3qLra3oI/KzoOaK+C82JGJXc7UTdHyDO5VoxTvIVLkdL/ReabKCbJ2urx3h20Lga2Gtt2ml/aoZdBN3NKE=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 (2603:10b6:207:30::21) by BL0PR2101MB0932.namprd21.prod.outlook.com
 (2603:10b6:207:30::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.4; Wed, 10 Jun
 2020 14:39:18 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::bc6a:97fa:9127:9fc6]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::bc6a:97fa:9127:9fc6%5]) with mapi id 15.20.3109.008; Wed, 10 Jun 2020
 14:39:18 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Failure of test 'basic gdbstub support'
Thread-Topic: Failure of test 'basic gdbstub support'
Thread-Index: AQHWPrExfndF6+xmVE6rVMzDsVBbjw==
Date: Wed, 10 Jun 2020 14:39:18 +0000
Message-ID: <BL0PR2101MB1026A0AC34665437F4B7D4FED6820@BL0PR2101MB1026.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-10T14:39:18.111Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [63.228.98.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fadd22c-b3c6-4d63-bac3-08d80d4c0e9e
x-ms-traffictypediagnostic: BL0PR2101MB0932:
x-microsoft-antispam-prvs: <BL0PR2101MB0932EABA112ED4ED0510324ED6830@BL0PR2101MB0932.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Q9zd35ZTNNhn836lvOdglBuVyDR4j2zDY2C7trhEWm/cozOspGyFE5K2NPAobky4z5j0yidqj1p+hjFLlP3oamWGWICcpzkRM5JGt40/2zgs3EhK/g//GH1XTMAZnSU+q+dPrHFSlcb9HSgXfO2/EQF1XQ+saTNTjcmUg6e5KIpN8dfweFklY5hqzr8nme8l2LZoQLpc6qZiJq+8hb5XcgSaaY+2uUNEovIyZGUXlOaC4gEuefvOjEsz7GxM35RsDuzwjOFQWYUQpT54m/T2eiCAOXzHcFBvH1YHIB92T3v246MvuPMEmTc5+2biz9u2tCzSCawJ1rHV/HGpj/fOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR2101MB1026.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(6506007)(86362001)(82960400001)(10290500003)(52536014)(8676002)(64756008)(316002)(66476007)(66946007)(4326008)(2906002)(66556008)(33656002)(5660300002)(478600001)(82950400001)(8990500004)(186003)(71200400001)(76116006)(26005)(83380400001)(8936002)(6916009)(66446008)(55016002)(7696005)(19627405001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /0PO/+N9fUROA2I4yuLWTGogsIebspFr4/CuirocVxGNy9ncu1CwkfUaXbhg8mWwuvOSuX10ufkFDpoT2uZuTcmL89yDTCQCsW4VJy4XbdVk1W22VQH7q0xk+VS3niU1MQXZDIcPmptpo/0S6I/bnhn1O9xuBMsGEGWqnCPjaCNBgKmQp7+H/QumbOo67/q4E6UTrjznG2LAEPmUh3poieMOat6KXw4CeI6BjXYrDyZABilYjuPvIrie6IqlRP4B9MJt2Z/hQUgvk9XPdPpLLpSgXZoIZWUjov91nOyhX123Da5YJz+1nsyjgyVBO0gDF8mmJcc1i7nhjL48bdiCOFHXKi3keRqVxBAhwkJp6HNsr+repVtmhCG/qXrlFL/bqJEnMsuNLHodoap15YIV+qbCfllu/15nqc/yfZ9+C5hyX2lKzPWjWJeVvV+ladfdxLAjN14v1CjTV5+4hO6hZy+PFyE8u/mC+q4dQYbeVG8=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026A0AC34665437F4B7D4FED6820BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fadd22c-b3c6-4d63-bac3-08d80d4c0e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 14:39:18.5155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGXIhl3EI6FfU/Kcqjfi/6CpNVXcto4yhips8bFFnvoRh0D3Vaz0TNzP93Fouh+6Z8eNwWmUuXrKOzQJtx5/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0932
Received-SPF: pass client-ip=40.107.237.96;
 envelope-from=robhenry@microsoft.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 10:54:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

--_000_BL0PR2101MB1026A0AC34665437F4B7D4FED6820BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The newish test 'basic gdbstub support' fails for me on an out-of-the-box  =
build on a host x86_64.  (See below for the config.log head.)

Is this failure expected?  If so, where can I see that in the various CI en=
gines you have running them?

In digging through the test driver python code in tests/tcg/multiarch/gdbst=
ub/sha1.py I see that the test assumes that a breakpoint on the function SH=
A1Init is a breakpoint at the 1st assignment statement; the 1st next execut=
es the 1st assignment statement, etc.

This is a very fragile assumption.  It depends on the compiler used to comp=
ile sha1.c; it depends on the optimization level; it depends on the accurac=
y of the pc mapping in the debug info; it depends on gdb.

Better would be to change SHA1Init to do its work, and then call another no=
n-inlined function taking a context pointer, and then examine context->stat=
e[0] and context->state[1].

Thanks in advance

TEST    basic gdbstub support
make[2]: *** [/mnt/robhenry/qemu_robhenry_amd64/qemu/tests/tcg/multiarch/Ma=
kefile.target:51: run-gdbstub-sha1] Error 2


 QEMU configure log Tue 09 Jun 2020 02:45:06 PM PDT
# Configured with: '../configure' '--disable-sdl' '--enable-gtk' '--extra-l=
dflags=3D-L/usr/lib' '--enable-plugins' '--target-list=3Dx86_64-softmmu x86=
_64-linux-user'


--_000_BL0PR2101MB1026A0AC34665437F4B7D4FED6820BL0PR2101MB1026_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The newish test 'basic gdbstub support' fails for me on an out-of-the-box&n=
bsp; build on a host x86_64.&nbsp; (See below for the config.log head.)</di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Is this failure expected?&nbsp; If so, where can I see that in the various =
CI engines you have running them?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
In digging through the test driver python code in&nbsp;tests/tcg/multiarch/=
gdbstub/sha1.py I see that the test assumes that a breakpoint on the functi=
on SHA1Init is a breakpoint at the 1st assignment statement; the 1st next e=
xecutes the 1st assignment statement,
 etc.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
This is a very fragile assumption.&nbsp; It depends on the compiler used to=
 compile sha1.c; it depends on the optimization level; it depends on the ac=
curacy of the pc mapping in the debug info; it depends on gdb.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Better would be to change SHA1Init to do its work, and then call another no=
n-inlined function taking a context pointer, and then examine context-&gt;s=
tate[0] and context-&gt;state[1].</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thanks in advance</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
TEST &nbsp; &nbsp;basic gdbstub support<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<div>make[2]: *** [/mnt/robhenry/qemu_robhenry_amd64/qemu/tests/tcg/multiar=
ch/Makefile.target:51: run-gdbstub-sha1] Error 2<br>
</div>
<span></span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span>&nbsp;QEMU configure log Tue 09 Jun 2020 02:45:06 PM PDT<br>
</span>
<div># Configured with: '../configure' '--disable-sdl' '--enable-gtk' '--ex=
tra-ldflags=3D-L/usr/lib' '--enable-plugins' '--target-list=3Dx86_64-softmm=
u x86_64-linux-user'<br>
</div>
<span></span><br>
</div>
</body>
</html>

--_000_BL0PR2101MB1026A0AC34665437F4B7D4FED6820BL0PR2101MB1026_--

