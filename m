Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34068C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 23:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D009C206A4
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 23:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BWWkXuwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D009C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfXXM-0006CO-3j
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 19:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1jfXWJ-0005cq-Jh
 for qemu-devel@nongnu.org; Sun, 31 May 2020 19:37:35 -0400
Received: from mail-bn7nam10on2126.outbound.protection.outlook.com
 ([40.107.92.126]:8774 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1jfXWH-00020c-Tn
 for qemu-devel@nongnu.org; Sun, 31 May 2020 19:37:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0nTGCIvLJdB0wHPfmoFpBWEIil8D/HwRxtgu6hVEFArfrX51w94VLLA7QGV6tW1dbBsrCLbF06MSziL08iuVVD5buw1C6O1bKdczBw7sVi93ILYxmWP0zvcBv8OsiU3BkQwictJXlpPuKncJE9OxeM12QBA3Jue5WIDJaJk74ZxtA9bR0T7EGVTTqmO9pncsWy5CfJyYPfCaSL86ze+LxD3sw07aBPayD1eQjRzxEaF7yvpgvOBVn15jBw57XvyePI00kbmIAejVImclZ9fWI9DhZieobG9Dn/OL3mrG75Z+HD0qdVzKmNhmT95fFYVBzYqmI80dWiq8Z86oeqr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGKXk/HiJISTmu13xOY4iUJyqlbY/PBgQeXWaZJENyE=;
 b=TseE2LUn8uMNqxmvZaKjm441ZNFn53pOBQ+5oz9Dc1q1YruyEoLZwnWOHRR0phmTp3JB0Zb3v+giD/j+xuwYudW5me350pWxNrPIhF+g1xEKuiNhkkxjYOB66A8fmRtjeSddanQq2bd0T9MZCMx/tXqF8kXVArAqoa12ozE/0xpx+SlAgdR+RV0qxmVnDuUbCS0zEFoHcDQEIl02jZRa30t67tUceeLQt4WkSXP0WWLnLSqzcilsLPA4lXQFMXAM8TmeftLh4Zl6XUMbjogvGQTSHnu85R/pIDTk2IKe0VqXjUIWRcU97pAd7DOeuC7FMzUNpwFUUJOwOqUBvl71sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGKXk/HiJISTmu13xOY4iUJyqlbY/PBgQeXWaZJENyE=;
 b=BWWkXuwC4CeRz993i3yXWAb41Mo1wx7RWPnlVLYBzn0avEE9siz0GGe43ZSFo3C8Megp33NiR7ue7+pfK1IUkerwdVMs1xA6FC6PIZBIxfIe409DneRx3SW1ZX9ZTpU2HNzxJ95GNDv3VG7EcAcXpRHUJk78Tgp8k5tF5Muhj+c=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 (2603:10b6:207:30::21) by BL0PR2101MB0962.namprd21.prod.outlook.com
 (2603:10b6:207:30::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.5; Sun, 31 May
 2020 23:22:29 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::bc6a:97fa:9127:9fc6]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::bc6a:97fa:9127:9fc6%4]) with mapi id 15.20.3066.007; Sun, 31 May 2020
 23:22:29 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: ia-32/ia-64 fxsave64 instruction behavior when saving mmx
Thread-Topic: ia-32/ia-64 fxsave64 instruction behavior when saving mmx
Thread-Index: AQHWNd5quifUeAt/N0utXBrhr3uc7ajC2MGj
Date: Sun, 31 May 2020 23:22:29 +0000
Message-ID: <BL0PR2101MB1026CD468E4F0929086C177FD68D0@BL0PR2101MB1026.namprd21.prod.outlook.com>
References: <BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0@BL0PR2101MB1026.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-31T23:22:22.168Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [97.126.3.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46624393-b40c-4503-78b7-08d805b97cc3
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB0962ECFA482D8E394B714DCCD68D0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0420213CCD
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Rii1QABiBz0kBL+0hYkkxwHxocdsoZGp0fxNFwSHzGpzIYVMFhGHhaFFg80U62WxusfYTNnF0fcUtxY1HRiX+AdWlbJovIZZuZ1VtJKMYrct4qQZT+Z/WQ/K7tIUlg5S5GHmQJuCtJooogJdJHXaasORsIlYN2O9Cf5nc51GzSxCZCkC4uVCFyv+gH59Kyg66iC8zvMauj5K5LwYZ+cax/PzCDBJM/1IjilHasXZo7sIfmQnUcQQ7ox4rWrqCqpx1pxIQnqE75APiEnKWMnegYTJFTSIiViLrvlDW3+fiU9RB6KzkdlPuoYlddfH05f0mXxtYuLG0PCCu3J5gL9keoNerdutgYOBg21HnLspyJY1ksm93rnLVO4N+yn0XCEk+W0a/PDIt5eZQG0861/OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR2101MB1026.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(76116006)(316002)(26005)(7696005)(66446008)(6916009)(66476007)(66556008)(64756008)(66946007)(6506007)(53546011)(2906002)(33656002)(52536014)(71200400001)(19627405001)(186003)(10290500003)(966005)(86362001)(9686003)(55016002)(8990500004)(478600001)(166002)(8936002)(5660300002)(8676002)(82960400001)(82950400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ihK6MV5FyOuWn3xni6S7m+lUzIxRCby1Gx1TEKUYbYO95i48mBZNC0XJ4PM8g+bpW2BmJG9vuMmtSc1ez/2n6l35U3bXg5SM7O4sd0W8X1nzHRiwpDWeidu6wnkQmSteoLWmXYorU6oOmH1C/PbFm69i9XsCK61M6Z1CegBq/kCVQiJyAOIfpSKmE6dCPGiMnXD5J0Qjrb1pXFDkvRLCEunYztdf6zRRMFGqS/iXub5rcfNQsZf0XgUPMP//UllXhWuOQNHTtVlPZYnVoWsuLpX02+LKWFLj1IGBI0Q1HE5zq/qIwi/5LdXIq5xgicDAeP5Rv7ofPJnuEOQxiRv4tnYQr2SUwUf639+5iVHkgv0ijuqn7Xswyf3qIfBpJyE9xsz6hSzvtPYfjU2HlCxTfSvkn9x+P7cZlUvEzyyvLehgtvBj2wH+r8kmN/cFaXjZLfIAYJTMtCGgZoWvGKv6Exq6WvXQNZuzip97qrceC+U=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026CD468E4F0929086C177FD68D0BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46624393-b40c-4503-78b7-08d805b97cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2020 23:22:29.2239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CJr6BN2D6kgdMoeR3RgyoAYWuIOBKTOwq1czRAxC3ci8ZPOgjgwiB+drWAODpKO5EN71lj6gF8ZbfOSFcx3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Received-SPF: pass client-ip=40.107.92.126;
 envelope-from=robhenry@microsoft.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 19:37:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--_000_BL0PR2101MB1026CD468E4F0929086C177FD68D0BL0PR2101MB1026_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here's additional information.

All of the remill tests of the legacy MMX instructions fail. These instruct=
ions work on 64-bit registers aliased with the lower 64-bits of the x87 fp8=
0 registers.  The tests fail because remill expects the fxsave64 instructio=
n to deliver 16 bits of 1's (infinity or nan prefix) in the fp80 exponent, =
eg bits 79:64.  Metal does this, but QEMU does not.

Reading of Intel Software development manual, table 3.44 (https://www.felix=
cloutier.com/x86/FXSAVE.html#tbl-3-44) says these 16 bits are reserved, but=
 another version of the manual (http://math-atlas.sourceforge.net/devel/arc=
h/ia32_arch.pdf) section 9.6.2 "Transitions between x87 fpu and mmx code" s=
ays a write to an MMX register sets those 16 bits to all 1s.

In digging through the code for the implementation of the SSE/mmx instructi=
on pavgb I see a nice clean implementation in the SSE_HELPER_B macro which =
takes a MMXREG which is an MMREG_UNION which does not provide, to the exten=
t that I can figure this out, a handle to bits 79:64 of the aliased-with x8=
7 register.

I find it hard to believe that an apparent bug like this has been here "for=
ever". Am I missing something?

Robert Henry
________________________________
From: Robert Henry
Sent: Friday, May 29, 2020 10:38 AM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: ia-32/ia-64 fxsave64 instruction behavior when saving mmx

Background: The ia-32/ia-64 fxsave64 instruction saves fp80 or legacy SSE m=
mx registers. The mmx registers are saved as if they were fp80 values. The =
lower 64 bits of the constructed fp80 value is the mmx register.  The upper=
 16 bits of the constructed fp80 value are reserved; see the last row of ta=
ble 3-44 of https://www.felixcloutier.com/x86/fxsave#tbl-3-44

The Intel core i9-9980XE Skylake metal I have puts 0xffff into these reserv=
ed 16 bits when saving MMX.

QEMU appears to put 0's there.

Does anybody have insight as to what "reserved" really means, or must be, i=
n this case?  I take the verb "reserved" to mean something other than "unde=
fined".

I came across this issue when running the remill instruction test engine.  =
See my issue https://github.com/lifting-bits/remill/issues/423 For better o=
r worse, remill assumes that those bits are 0xffff, not 0x0000


--_000_BL0PR2101MB1026CD468E4F0929086C177FD68D0BL0PR2101MB1026_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Here's additional information.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div><br>
</div>
<div>All of the remill tests of the legacy MMX instructions fail. These ins=
tructions work on 64-bit registers aliased with the lower 64-bits of the x8=
7 fp80 registers. &nbsp;The tests fail because remill expects the fxsave64 =
instruction to deliver 16 bits of 1's
 (infinity or nan prefix) in the fp80 exponent, eg bits 79:64. &nbsp;Metal =
does this, but QEMU does not.<br>
</div>
<div><br>
</div>
<div>Reading of Intel Software development manual, table 3.44 (https://www.=
felixcloutier.com/x86/FXSAVE.html#tbl-3-44) says these 16 bits are reserved=
, but another version of the manual (http://math-atlas.sourceforge.net/deve=
l/arch/ia32_arch.pdf) section 9.6.2
 &quot;Transitions between x87 fpu and mmx code&quot; says a write to an MM=
X register sets those 16 bits to all 1s.<br>
</div>
<div><br>
</div>
<div>In digging through the code for the implementation of the SSE/mmx inst=
ruction pavgb I see a nice clean implementation in the SSE_HELPER_B macro w=
hich takes a MMXREG which is an MMREG_UNION which does not provide, to the =
extent that I can figure this out,
 a handle to bits 79:64 of the aliased-with x87 register.<br>
</div>
<div><br>
</div>
<div>I find it hard to believe that an apparent bug like this has been here=
 &quot;forever&quot;. Am I missing something?<br>
</div>
<div><br>
</div>
<span>Robert Henry</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Robert Henry<br>
<b>Sent:</b> Friday, May 29, 2020 10:38 AM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> ia-32/ia-64 fxsave64 instruction behavior when saving mmx</=
font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Background: The ia-32/ia-64 fxsave64 instruction saves fp80 or legacy SSE m=
mx registers. The mmx registers are saved as if they were fp80 values. The =
lower 64 bits of the constructed fp80 value is the mmx register.&nbsp; The =
upper 16 bits of the constructed fp80
 value are reserved; see the last row of table 3-44 of&nbsp;<a href=3D"http=
s://www.felixcloutier.com/x86/fxsave#tbl-3-44" id=3D"LPNoLP231595">https://=
www.felixcloutier.com/x86/fxsave#tbl-3-44</a></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The Intel core i9-9980XE Skylake metal I have puts 0xffff into these reserv=
ed 16 bits when saving MMX.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
QEMU appears to put 0's there.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Does anybody have insight as to what &quot;reserved&quot; really means, or =
must be, in this case?&nbsp; I take the verb &quot;reserved&quot; to mean s=
omething other than &quot;undefined&quot;.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I came across this issue when running the remill instruction test engine.&n=
bsp; See my issue&nbsp;<a href=3D"https://github.com/lifting-bits/remill/is=
sues/423" style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-siz=
e:12pt">https://github.com/lifting-bits/remill/issues/423</a>&nbsp;For
 better or worse, remill assumes that those bits are 0xffff, not 0x0000</di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
</div>
</body>
</html>

--_000_BL0PR2101MB1026CD468E4F0929086C177FD68D0BL0PR2101MB1026_--

