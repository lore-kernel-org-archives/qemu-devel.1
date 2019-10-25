Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BB821872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yyz3FEJO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Tf6GP3wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BB821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2Sa-0004fM-VM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iO2Q2-0007Ji-JC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iO2Q1-0001w1-6Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:26:30 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iO2Q0-0001vI-HC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1572020788; x=1603556788;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jfsQKUZET5JSvp6YaP0CbM5ZfqaFZLkVLlBZA7tq5R4=;
 b=Yyz3FEJOZMUhmcDHxCG7KvbGFT/iJVldoiRfLwS/2YmjAWghItqTQjdE
 9vLvym1Ql1H34iwRRsovr+xVa9/t3GdRty8b6ZDTeqfK6Yx9sP0dCWIAx
 cZ/IGHiIRSa3eVuzZh2JDKwU75lrytjlNTJLMRYaiOXv2ghHW9nHh+vgw U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Oct 2019 09:26:26 -0700
IronPort-SDR: WV28dYTCNInwL0RvLeV26KBdHTjtx9sJpm7XZMd1klfDUS9cHqVNVnsnZwBRh+uWKgRY57+nGW
 v8eidedVaAo6UeDGnuUVH7/lRmYeLEQpNa/S5ViMaYeZGAvSS9NpVMVow4SWcr5u/T7oJ3mmjo
 Uy19bjp1belzt9a0MaXpztCqJ/6lNFU18UzQdEVCamWwLU8sLMGn/+ZaTZuesHPpMaK+xCFwcT
 yTv5PLAXrrnjKXLWtkLF0d94T/ZQ7te0bNL2QUtWgDP2Y5cygIrsOlGKV837+sNbQA23HnhNZN
 1jBsPkDkg12KioCJg5lt1Hjg
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 25 Oct 2019 09:26:25 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 25 Oct 2019 09:26:25 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 25 Oct 2019 09:26:23 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Fri, 25 Oct 2019 09:26:23 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB6439.namprd02.prod.outlook.com (20.179.89.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 16:26:22 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1%7]) with mapi id 15.20.2387.019; Fri, 25 Oct 2019
 16:26:22 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Topic: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Index: AdWLUOkdof4fsTRrRvOiehGwyV6GSg==
Date: Fri, 25 Oct 2019 16:26:22 +0000
Message-ID: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27397635-5bac-44b6-937e-08d7596812cf
x-ms-traffictypediagnostic: BYAPR02MB6439:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR02MB6439FF1CC21AE2A36B817884DE650@BYAPR02MB6439.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(102836004)(14454004)(3846002)(66446008)(66946007)(54896002)(66476007)(966005)(66556008)(478600001)(86362001)(71190400001)(71200400001)(64756008)(256004)(6506007)(4744005)(26005)(5660300002)(25786009)(7696005)(476003)(606006)(2906002)(99286004)(236005)(6306002)(9686003)(5640700003)(4326008)(55016002)(486006)(66066001)(52536014)(6916009)(316002)(7736002)(8676002)(33656002)(81156014)(81166006)(76116006)(6436002)(2501003)(8936002)(186003)(790700001)(6116002)(2351001)(74316002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB6439;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84j9Mc9n09lAiRDEQBW6dT89OCneAYNWeq7H7tbOPXbeD+iAvUk9vfnCPCHeFVf8cDPcbi3iFdII4GaC29avc9P4Qi52E+YsDsBjwJixzNUZgO5ie6MqxgVmHXAb78PZzH0eJ01TsjKny0n/YhxWzXWv2frSx5PEFCcoerSFIcmx3yaKdyVtNfkBUjdrxUdrq3e6Z1qs8RS2Nv8FvXlazPiytQ0X+7fJFlDKyiIqrVXQM7oAurBf93cJSIk8Su0pvcL/0S1SNEGa+nzw87Ns+Ryhs9qgHvC+V8lR3xT8EcaHcM3wctnDQc520WjyyvTmsKEWKVlCKapoYAwfNbhrUXXol85/2m3z+bnoPBbSiZuysBLGd1XeBjnu1uXjsOC1HvvVkDSG/ibr2oldUOOKMfX4ImmOHniRfgJyihdl2DEJbyKsqjOkE2+SHsUAK/hPh88WnwgJN3ddJnwtsX5/m6QCjwq2/hsjL/UpmHdnIpU=
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMqiyGqif78teNnQcLsdU4Eacz0Yc1xoQyCzhitL7ccTOD2KrYcgJhavOMpF8t6HtfwPAbfr1VjwfhPEkozXHhKFaHEGfTg76vUnjsntV++zwh7iDYBX08FbWI+e6dYoXSROEdCs8NX7pWuUx+pCCDPaXPqazMGDBYfMJozK64o/HpgLHUMtNVDm1WLBp6h4BFcZ43nzetfWyOZuD61C8PW5VyOhrMN03QqNRwzuz4sGdL2zqUH3oBi84kP01U47N6NS1tNSHpErzGIJJcgT7GdU+WjBRqyTmNsZoLRIcXmC2itoYaIbzJW1r8kl4R/tqpxx7jgPo5FFmSaCFzQ+yQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2k4xB5eyRaKqypJJfpFjug3rKUX2o836UlJWxWfYrw=;
 b=mEK391XR9KGJoUiOFRhTQ05VotLC+1hkwJ1nfDr8IvULkmAQ8KDq2DXj3DuD+6jdsiy35B0J/0G8Hh9L3MHCEormUwX7kRhrYUO2itphrkEOz0g5TY0jrq3GG9rFc/D59s0xm+bLrLrDTBC2eVf75R1pnlBYvYfw7l7AmxVceAtBEXXAlr+oYvuUTS0YOV559BUv/czts4GYPogw3qC/yWEkkDmY5dhwNzbXoe40dzOcfmlSsAcfZ9eTGKTxkXX16vXGk1WRX0+mXUDdEVGzXnG0niEPSBEvzr3i13qqwz/jHEnx10KLTsexHOMjUGtLSRMYCbdBHnZDstKDZlHD8Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector2-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2k4xB5eyRaKqypJJfpFjug3rKUX2o836UlJWxWfYrw=;
 b=Tf6GP3whfeJ46nz0YZ+3Miba2z42q9WYd7NAIZH8b0YmrDHueYnxmM4DJ1vn6Z+kbK1kMnEm46uIz8KjPjzSnms4nAmsTV6wemOgIBZTd6Huv5h/BLQgFcQPhaBcCq885XZpSo0G9NkC3RENk3D3J643JOd0gOVEmqFIYK8B4mY=
x-ms-exchange-crosstenant-network-message-id: 27397635-5bac-44b6-937e-08d7596812cf
x-ms-exchange-crosstenant-originalarrivaltime: 25 Oct 2019 16:26:22.1310 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: jxHt2fYE/MKjj5xyCFy+gXR+MFgOpfSQ75acauNSwa3JgXnr1dCIjygnNsxbtFBTHcVFPfB5ScrCi+bJk+I9GQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB6439
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB48863165DEE32E5C563E93F4DE650BYAPR02MB4886namp_"
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Alessandro Di Federico <ale@rev.ng>, "nizzo@rev.ng" <nizzo@rev.ng>,
 =?iso-8859-1?Q?Niccol=F2_Izzo?= <izzoniccolo@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BYAPR02MB48863165DEE32E5C563E93F4DE650BYAPR02MB4886namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We would like inform the you that we will be doing a talk at the KVM Forum =
next week on QEMU for Qualcomm Hexagon.  Alessandro Di Federico, Niccolo Iz=
zo, and I have been working independently on implementations of the Hexagon=
 target.  We plan to merge the implementations, have a community review, an=
d ultimately have Hexagon be an official target in QEMU.  Our code is avail=
able at the links below.
https://github.com/revng/qemu-hexagon
https://github.com/quic/qemu
If anyone has any feedback on the code as it stands today or guidance on ho=
w best to prepare it for review, please let us know.

Thanks,
Taylor

--_000_BYAPR02MB48863165DEE32E5C563E93F4DE650BYAPR02MB4886namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">We would like inform the you that we will be doing a=
 talk at the KVM Forum next week on QEMU for Qualcomm Hexagon.&nbsp; Alessa=
ndro Di Federico, Niccolo Izzo, and I have been working independently on im=
plementations of the Hexagon target.&nbsp; We
 plan to merge the implementations, have a community review, and ultimately=
 have Hexagon be an official target in QEMU.&nbsp; Our code is available at=
 the links below.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in"><u><a href=3D"https://git=
hub.com/revng/qemu-hexagon">https://github.com/revng/qemu-hexagon</a></u><o=
:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in"><u><a href=3D"https://git=
hub.com/quic/qemu">https://github.com/quic/qemu</a></u><o:p></o:p></p>
<p class=3D"MsoNormal">If anyone has any feedback on the code as it stands =
today or guidance on how best to prepare it for review, please let us know.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Taylor<o:p></o:p></p>
</div>
</body>
</html>

--_000_BYAPR02MB48863165DEE32E5C563E93F4DE650BYAPR02MB4886namp_--

