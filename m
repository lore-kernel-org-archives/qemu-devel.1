Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908C9CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 23:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A861204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 23:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j8msD+IR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Y04Ji7Q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A861204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRlLL-0006nQ-9g
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 18:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iRlJy-00061M-C2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iRlJw-00084c-5H
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:59:38 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iRlJu-00080x-65
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1572908374; x=1604444374;
 h=from:to:subject:date:message-id:mime-version;
 bh=UOjk8x4UFcMABOYtWPy3hBQF8Eqfv9NW8BtsK8JDaeQ=;
 b=j8msD+IRhGIaNo0krAVgRDG+z8CHw0ztCMFu4lkLGXJRi+TjqM/vmhZv
 bLurpzhU40tzlndUw3DYg3djWK4FXFw9+JYF+yLcgd10J/uQzB47yjRqT
 MIdhguNM0YNIx+AHahPxgZfGTYfjffPpHAhW9/sOMth8Q8+kIJP04suBk s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Nov 2019 14:59:30 -0800
IronPort-SDR: Btny/JK924xmOveR/fKaA+mLM0FBX+2SfFE2DV+1lBI6lvZ0LYqQ78FQ7GofiW7MOtBEwIY4lB
 6cH452RRniNjggqas6xGMjNnmtZkKedzylDxt9IUwgYt6/AHOeX1GIliD6S8pY96aC4ZOZ57/0
 Tc8KduXLOWJnqFWNMD97FJ6+9ZJcZCgNWBUlOeAezlNrIYmSrCvyRTeBXhNZee3RXTXcgH1iQW
 yABQ8FzUz6M64RYgBnQRNyG51LCFXdS5t9+pi9qlfJzD8qjWqPIyoGj/9hWdQpEKgLrVC9KKOr
 1wmbK3o3GzfCnW7NXRRToGh0
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 04 Nov 2019 14:59:30 -0800
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 4 Nov 2019 14:59:29 -0800
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 4 Nov 2019 14:59:27 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Mon, 4 Nov 2019 14:59:27 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4741.namprd02.prod.outlook.com (52.135.232.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 22:59:26 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 22:59:26 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: SIGSEGV question (Hexagon)
Thread-Topic: SIGSEGV question (Hexagon)
Thread-Index: AdWTYeXS/8Uy89jdTTCnVwieQLdWQA==
Date: Mon, 4 Nov 2019 22:59:26 +0000
Message-ID: <BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e876e107-b2d1-4c9f-5c6c-08d7617aa43c
x-ms-traffictypediagnostic: BYAPR02MB4741:
x-microsoft-antispam-prvs: <BYAPR02MB4741C54431C0826C735CBB28DE7F0@BYAPR02MB4741.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(86362001)(316002)(33656002)(478600001)(2906002)(4744005)(74316002)(99286004)(256004)(14444005)(76116006)(66476007)(66556008)(64756008)(55016002)(66446008)(66946007)(52536014)(486006)(7696005)(9686003)(14454004)(66066001)(81166006)(102836004)(71190400001)(26005)(6436002)(476003)(3846002)(6506007)(6116002)(790700001)(71200400001)(5660300002)(2501003)(7736002)(6306002)(54896002)(25786009)(186003)(2351001)(81156014)(8936002)(6916009)(8676002)(5640700003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4741;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mC+RypqWN4LXxHRT4dt8xenqxNdS+idsgnLARIYNsDO/+qagHzZYUI7T+G87pqHG8wmL6nRb25naquyH3AOGSawI/fKF59vr3P/J7HQk7Ayu+XMzq6+UmXmZR5ax7oif+tCfWJbJqZpkhIwMaRybkp/ttgNw8/A2HqwO9eBpxrD1VN2x8SAz5W+McXnn3mN0sWR2+MCqzc/K8YxwHT//pZ+kRn2af8T45cb1alQbmi2g7ilZNIhzLLNq1kKSh1bS4pASVYSnxiEeRYeUj+7Qkndo0E2TV8z/tWeQq66JpbB1EIMFaepsGcmuMuncDlQmXV7Rkm5FkVZ/HG0rl3pl05lCvcr0tDXs68/5/Hc1RlkRBLtS9XCTITpafzWicxU6k68ZoyTfLB/uGYtCCVc37gCxlXTCEtqaRitGiprQokfX6h6vIGL9+y88HhrDwx3H
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUCK2bVm3yoW1nLnVR5jOTyr88Js6lKd5+wvOJ7RO7DKGsgFQexZutpmFD/99y7tUkQCTl1jpDrMIXlZxC5cdLmDPLAvIT9zrLMPknXIUiAGkTGgSj/s5kFSdOylHm7Cg/vMKv+9I3nuCDJ9C+7knuA1GiSzovnAhkcPiVU0H0kGDIQgB7zWJPT8IqerqaT8lRUBHo8V5rTkY6KQnFbxueqykXS3CRsS0oZhmEy38FFE8i944gtxC45gShwLGVJeJQn28MYsxQ0DlJs+j97Ev9xi3xLyzhzXbYhJGJybOWTKtM5/OAJEMXgtlCThV5yQGJTtijC/x81DYmMTmCMTsQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiWE1Z13KaZmD5stIkzYuhSlIFtimbNDstD1exlULgU=;
 b=XQjtZkTeFZ1NvXyiw8ncGJmIvasiVDRftR8ueMPQlX2Km0ih3v3iWBA2xcGtkpOt/LN0nTtuA9v3OJosTQ55SpwoHpDEYVvJWSXJdUIUgCN1TU27QLHSsoKOgmzOKu0UE6TPjzYNl91wuqauuJvjYGRtvlwC+lw3LcK8AS+mXHGlvgvAhb1MWcO9UqQljC1WKRluawunqTMu3/oMKl2nZJqLkc384egMG8h7hDLm/qtxmTZx7g5L6jpd2y+GjMJ/xp6Jh0WQtPJ+VHxw2iFk6W/fVTi9marhTE565+qaMOm5WqCwjg4ShmxLZ2Va1tMK2Q2sWAcenSMsHbaeL7CvtA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector2-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiWE1Z13KaZmD5stIkzYuhSlIFtimbNDstD1exlULgU=;
 b=Y04Ji7Q5pU3Uqr+mOIbFMm4Bisf9ml47YlmCZPB7RDPVFaDHiltZkiG4GwMyJfrcAjjDqfYNI7E0B8SOHEq7YYq5IuonOXh7isHiABObSogsQJ/qqMDvkeA5w7aDsJ6QTvWZn1CZwwSWL6hTrr/V1la3mFgt73NfToICFfKXM38=
x-ms-exchange-crosstenant-network-message-id: e876e107-b2d1-4c9f-5c6c-08d7617aa43c
x-ms-exchange-crosstenant-originalarrivaltime: 04 Nov 2019 22:59:26.4075 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: m2PyvpnOZE5nXR9ToQKzcxgFckC5l0AZdaEdF81mUlYCe1l4SwlTmnFDyzlYYRIYu5uwfMxDU8I6/ssFtmppog==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4741
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0BYAPR02MB4886namp_"
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

--_000_BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0BYAPR02MB4886namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Philippe suggested that I run the TCG tests for Hexagon.  Thanks Philippe!!

I discovered that I'm not handling SIGSEGV properly.  We pass other signal =
tests, but not this one.  I'm hoping someone can help.  The first thing tha=
t I realized is that I hadn't provided a tlb_fill function for CPUClass.  W=
hat is this function supposed to do?  I looked at other targets and found t=
hey are setting cs->exception_index to something and then call cpu_loop_exi=
t_restore.  I tried various values for exception_index, but the best I seem=
 to get is re-executing the offending instruction forever.

Any insight would be greatly appreciated.

Thanks,
Taylor


PS  The only other bug that these tests uncovered was that truncate isn't i=
mplemented properly.  This was straightforward to fix.


--_000_BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0BYAPR02MB4886namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
/* List Definitions */
@list l0
	{mso-list-id:85343070;
	mso-list-type:hybrid;
	mso-list-template-ids:-2003797966 565327350 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Philippe suggested that I run the TCG tests for Hexa=
gon.&nbsp; Thanks Philippe!!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I discovered that I&#8217;m not handling SIGSEGV pro=
perly.&nbsp; We pass other signal tests, but not this one.&nbsp; I&#8217;m =
hoping someone can help.&nbsp; The first thing that I realized is that I ha=
dn&#8217;t provided a tlb_fill function for CPUClass.&nbsp; What is this
 function supposed to do?&nbsp; I looked at other targets and found they ar=
e setting cs-&gt;exception_index to something and then call cpu_loop_exit_r=
estore.&nbsp; I tried various values for exception_index, but the best I se=
em to get is re-executing the offending instruction
 forever.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any insight would be greatly appreciated.<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Taylor<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">PS&nbsp; The only other bug that these tests uncover=
ed was that truncate isn&#8217;t implemented properly.&nbsp; This was strai=
ghtforward to fix.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0BYAPR02MB4886namp_--

