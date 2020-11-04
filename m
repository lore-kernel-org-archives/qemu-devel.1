Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE542071A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NeuroBlade.onmicrosoft.com header.i=@NeuroBlade.onmicrosoft.com header.b="F/WBvdVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE542071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuroblade.ai
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNNt-0001ib-8W
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kaNMw-00018m-Im
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:18:50 -0500
Received: from mail-db8eur05on2125.outbound.protection.outlook.com
 ([40.107.20.125]:52478 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kaNMu-0006wX-6l
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:18:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHMb4IHBP1RcMcgO39bioLO9qe5r9uTNHJvyLb2FyS/cX5Hy5BOyKwI5i2lXXl9kIgr0iDHDNgmqMBcEvNq16Ok7abaoPy7mLB02TlmFyCtmPiu+DImN5FiJa3A6QTMLoLXkZjGojmrPLaM/FR/pYbJSCSW6hn3odoiF9UY31zWgsRcvjsQhFnFMr0lVt/tbA2BDhOm66uIwT0La7BcbOP0ocgMDCYnOVIpEeo/fjJ7n7XYQLkVhT7hoAGGnIdQmk9+y8GwUhUWLKY0sudWYkMUjWBxFAov2ZzDYGOiCEDA73yRwQUNvSCOsb6ERLPyeZWpbSYbqgQNZnSYE/NQibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk1pIbTjsPkE1rNY6DJDNFqW/0gFLwCLgXJce+vFD0Q=;
 b=OcxiH+pVuOaD77kw4y8ftLkOJTJMt94nkxnH51VNvZ4iTH0XutAs44SlMwNjXUepU1KOSB3iNIQ9ZpQtJ88OHzBYAayCP8C3koO4gliZusBvdGfeG5WGTKvtRJhvBkSnoJIj3n4hn+9sZpWQlHO8+uzdqEMA331810KhggXGcicoaRIUypRwoIQceICDzyo7h+yYBxnRbdKUyKzQ7nszMFcjKdHXxShPV0fh9UeTduFHsVFO7MmOh9Hwz6GBsOZd5s1Qe8tmDQx589qDpBJ5BuHTxl08pFznhMAVi/2MoySuUmFFqZVm14ixarokKT/5fdN6lBzxcIDqxalv08mQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=neuroblade.ai; dmarc=pass action=none
 header.from=neuroblade.ai; dkim=pass header.d=neuroblade.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NeuroBlade.onmicrosoft.com; s=selector2-NeuroBlade-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk1pIbTjsPkE1rNY6DJDNFqW/0gFLwCLgXJce+vFD0Q=;
 b=F/WBvdVlTPDSQVh9btiZyZg0IDGbe81QQuRNMT1LlLJCIk8NxxrrcIOsMKJbq9kgeLhW+wqCMUtOm7sBpYYW9/xSHTu0pbFX0d61mHokKjfr1tzeUOx9j9wBOk18J3pxjvA4p3VXL4fZ3xn14YRF6rvbTKfqlsIBM1+L7FutiNI=
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com (2603:10a6:20b:286::17)
 by AM0PR09MB3649.eurprd09.prod.outlook.com (2603:10a6:208:18c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Wed, 4 Nov
 2020 18:18:45 +0000
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542]) by AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 18:18:45 +0000
From: Shaked Matzner <shaked.m@neuroblade.ai>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: executing user code to test qemu driver
Thread-Topic: executing user code to test qemu driver
Thread-Index: AdayyxAw30YcY7CFQgCfeGuQiNXcYQAC2vGg
Date: Wed, 4 Nov 2020 18:18:45 +0000
Message-ID: <AM9PR09MB46434D9527D2BD08A599855382EF0@AM9PR09MB4643.eurprd09.prod.outlook.com>
References: <AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0@AM9PR09MB4643.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0@AM9PR09MB4643.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=neuroblade.ai;
x-originating-ip: [79.176.89.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 855fc041-532f-479f-29e5-08d880ee1166
x-ms-traffictypediagnostic: AM0PR09MB3649:
x-microsoft-antispam-prvs: <AM0PR09MB36499957578DACB3F289829882EF0@AM0PR09MB3649.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cw7MP6ZhkhKb5CRnF5eSQrT9oHJjOaFI/Sw7j8L9mWrEcUnm2lUiWQqDDnNZz78aKmknlY2H+PGmb37uhL4bPEDwNXagYMLvXTs0ZWpAWMi4xXpH/mhwJWSMHbVJG4W1CPyNuXWAfP2naTmBoRO18ngDPGVxinkLRPbOmXU3rSSfDAvh0w+qU1Bw8rxwtj9DvZaoUzmU/2DxyEp69heB/yRdQYkQFmgR8qeZsfwKblKkUi85u9j0Zt/WfTkil/O91NoDP1UEZVlMzIoTAcMGByYaIHIKGuL37XjJY0Zqmt9AGIrtIW9n/HBEHd9eNPo/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4643.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(366004)(136003)(396003)(186003)(53546011)(26005)(6916009)(8676002)(5660300002)(7696005)(6506007)(52536014)(86362001)(478600001)(55016002)(33656002)(66476007)(66946007)(66556008)(66446008)(71200400001)(2940100002)(83380400001)(2906002)(76116006)(316002)(9686003)(64756008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HlGCgJGgz4SXUiJDsqrHk2ez5HBAJfNI5bq3niC9jffD0jalVDaf3f2OXI+SdkS/2mzwhaX5YQm5yPhmmPvfhpfEvoFcAgB4dIuwNvjGVfRsOb0S6xqef+XNON73xyTXtmR5ZcQ60pog4IhptSqWpT420sdFLGZQBR7VdWSyCePxsVk2IcXvXF5tG1vrZA5gdypzIebnwVvIz/Sk0FbhL7shX74dphopXkPzJJRAEGQYegWIs1t/oy+jWhFFLPumquCoJ+pmblsYBuDR2AZL+JDrJedaJZsF+JhCICNa/t41Mxxdw2AUbw5UIuUQ+JUIWIfa6noqwAR7pBtRmmSlMMq7xx+4GTOwM8AptNESUgHxUIf1/YSGFV5O5UeyyZkQnNMtqcefrLrcLHP9KDT0y7uAVu7nNqRRWeJ/I2DWsX9ya1Zr9Fm3huTsKYe5+iFPuueSld4niDaR7xFXdF9wQIOGGjG1ZLnXiv0BfFlCJAUmm5WZ0N4Ua0QlGsR8karmxvocOQL3ctwlVdUpA0LQAfGVJQOJF3YraCE4tLptz45NsK7HhaV+RHD89eTPKixGdL8NA+b2hUvmtPMOOHK5r/c89L7v3FDL3GfkF+u83kRXhGdQTH1rHTWBZuzgrJlIGfT09P8rTUMJyZiHwsagIw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM9PR09MB46434D9527D2BD08A599855382EF0AM9PR09MB4643eurp_"
MIME-Version: 1.0
X-OriginatorOrg: neuroblade.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4643.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855fc041-532f-479f-29e5-08d880ee1166
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 18:18:45.4937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63c61203-65af-4cf8-98e5-d12f35edaefa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeXz+R4nNaTLXeELAuFKgk62G8oqsS4ob+DxSVXDFB0wNDnQhrJMlV6ylUNXivkxA/Ahdu/2fGZ5QeLkRru8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3649
Received-SPF: pass client-ip=40.107.20.125;
 envelope-from=shaked.m@neuroblade.ai;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 13:18:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_AM9PR09MB46434D9527D2BD08A599855382EF0AM9PR09MB4643eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey again,
I also see that when I try open the device after insmod and mknnodev by:
  int device_fd =3D open("/dev/lkmc_pci",O_RDWR);
fails due to permission issue, I tried to chmod it from the device but it d=
oes not work as well.
What is the proper way to add access permission for the device from the use=
r code?
BR,
     Shaked Matzner
From: Shaked Matzner
Sent: Wednesday, November 4, 2020 7:06 PM
To: qemu-devel@nongnu.org
Subject: executing user code to test qemu driver

Hey all,
So I've created a small test to check ioctl calls of my pci with dma driver=
, under a shared directory (which is mounted to the qemu-x86-64 instance).
I've just tried to compile it with gcc (gcc test_dma.c -o test_dma_exec)
I've tried to execute it from the qemu but it said it could not found the f=
ile, also I wonder how does it recognize my kernel and devices),
How should I compile it and run the code?
BR,
     Shaked Matzner


The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or their agent, or if this message has been a=
ddressed to you in error, please immediately alert the sender by reply emai=
l and then delete this message and any attachments. If you are not the inte=
nded recipient, you are hereby notified that any use, dissemination, copyin=
g, or storage of this message or its attachments is strictly prohibited.

--_000_AM9PR09MB46434D9527D2BD08A599855382EF0AM9PR09MB4643eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hey again,<o:p></o:p></p>
<p class=3D"MsoNormal">I also see that when I try open the device after ins=
mod and mknnodev by:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; int device_fd =3D open(&quot;/dev/lkmc_pci&qu=
ot;,O_RDWR);<o:p></o:p></p>
<p class=3D"MsoNormal">fails due to permission issue, I tried to chmod it f=
rom the device but it does not work as well.<o:p></o:p></p>
<p class=3D"MsoNormal">What is the proper way to add access permission for =
the device from the user code?<o:p></o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Shaked Matzner<o:p></o:p></=
p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Shaked Matzner <br>
<b>Sent:</b> Wednesday, November 4, 2020 7:06 PM<br>
<b>To:</b> qemu-devel@nongnu.org<br>
<b>Subject:</b> executing user code to test qemu driver<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hey all,<o:p></o:p></p>
<p class=3D"MsoNormal">So I&#8217;ve created a small test to check ioctl ca=
lls of my pci with dma driver, under a shared directory (which is mounted t=
o the qemu-x86-64 instance).<o:p></o:p></p>
<p class=3D"MsoNormal">I&#8217;ve just tried to compile it with gcc (gcc te=
st_dma.c -o test_dma_exec)<o:p></o:p></p>
<p class=3D"MsoNormal">I&#8217;ve tried to execute it from the qemu but it =
said it could not found the file, also I wonder how does it recognize my ke=
rnel and devices),<o:p></o:p></p>
<p class=3D"MsoNormal">How should I compile it and run the code?<o:p></o:p>=
</p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Shaked Matzner<o:p></o:p></=
p>
</div>
<br>
<p style=3D"font-size:8pt; line-height:10pt; font-family: 'Cambria','times =
roman',serif;">
The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or
 their agent, or if this message has been addressed to you in error, please=
 immediately alert the sender by reply email and then delete this message a=
nd any attachments. If you are not the intended recipient, you are hereby n=
otified that any use, dissemination,
 copying, or storage of this message or its attachments is strictly prohibi=
ted. </p>
</body>
</html>

--_000_AM9PR09MB46434D9527D2BD08A599855382EF0AM9PR09MB4643eurp_--

