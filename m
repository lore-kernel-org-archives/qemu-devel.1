Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115AFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1A022277
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lqoH/ybT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1A022277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaCHp-00083q-1K
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 01:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kaCGA-0007Xz-Vj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 01:27:06 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com
 ([40.107.92.57]:31488 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kaCG8-0000tX-3p
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 01:27:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KszRpklsEZitAUfNdXvxTT1q+UYMFbJPr2rg3j2z5/EQ1gWyOyCMtOWIDb5o6RCbzR1jVGEOQ3gVcxJyDmeXJR1cKp9yI9ZWoahdLFaDt+MJvtRvl8OjqpY2Pl0abZOO5hOJIZ4+OV8Q7NabY6ymp5xlZhHdv2tPxy1VDKqEwxRh4pTH27Ax5aOk9NTPVYe41o04grBMJCQNa7q8sHmXHBNZFGEoLGbZLLb5nKuzQz9bVKFAAnQoGePlimPngZtPASWiBZ5fix9RcO06y1nJSt/UWS+DE6mpwTE60lAi/GNPffiefsPvV/BDefsSmFQelr5qqXSYHEKxEmqsbHHV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77jvNqUDZT+xBAW5jYDfKtrvTslCnOOjCMYc/+D2wbM=;
 b=NnftheHtAF4isXXgbQKCuRAU1plnkcvVjoNZ7ExkpWqXpEUU7ct3QZFZROnGbkvcqHFz5xfZDDcLcPmvXv5NhHN6w5/vs4y/dLjP62GvFIBsaIHfDrgx1+n681FAUI4knF4MgE8joTHSHdLiwRArAPdgj3dFdW5Wh+Tj1X5e/8XgX25CMjAe9VTh/TT8RugEQNxGRAA24mOBxyve0AuOb7VkUKy9pheE4j8B1XA7VV87mvJzJJMcYMPYO7yCccKaEy8ozXrkQ1zlGF6Owx1PmiWPIQ4U+RPk2xzHAzR6JlfI48n3f0S6xmYUtLpwcwHjFFeQb8PQ3B4m6iYvHN6h7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77jvNqUDZT+xBAW5jYDfKtrvTslCnOOjCMYc/+D2wbM=;
 b=lqoH/ybTxrbtmR9RuNw1bvbHGjchRkGUdLBhNDYozxPt+wOoG6fBSm0XC0Aili55+PWzy7IQf0YZfRnImOWpr7woQ3l3c5AwSpvRbo+7W3iDhFnIQLY07HeuG5+F3PiR0Yg8brqkqOYglPUGRgMpulHa6yIeoI6xSCLY10J8O6w=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB7026.namprd02.prod.outlook.com (2603:10b6:a03:23d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 06:11:57 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 06:11:57 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Debugging with rr
Thread-Topic: Debugging with rr
Thread-Index: AdaycIwfH9l3MmUsRFCTK2Hxm3kkdQ==
Date: Wed, 4 Nov 2020 06:11:57 +0000
Message-ID: <BY5PR02MB6772DD4A5DE5980A1F7459D9CAEF0@BY5PR02MB6772.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ef5e5bd-2352-43e0-4728-08d880888906
x-ms-traffictypediagnostic: BY5PR02MB7026:
x-microsoft-antispam-prvs: <BY5PR02MB7026F13400EE951B9156B566CAEF0@BY5PR02MB7026.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tU/ozbsEJJHYTsXur5upzKE8my2uZ4au9TZIsH6VMeOTqLQb4xVbyyxBdzn4a/rFE7X7nMT2rzog81gjXzceFNcmqXI0+/3Pb2ZyrMIkdPSDp2DpYwW3snbN2fngCB+Q8ma+pYLNCFcVHMMhW1LxCoOz0U67omC6wW+qaPSToYd4FL1a3LhNEgA5zdBV7oheBU4Sukp450YAXCipzzMocSfKQ5nXt/KvdM5LpvnQKAUF4Kb+s5Xe1nGwBU0oUMeIxxBVSLncFFEtZZncjW6pN7UEZrtU1ut9NG+XlfnLdOZLacVVLkKIUxUi03VEBChb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(366004)(396003)(346002)(376002)(186003)(9326002)(33656002)(9686003)(8676002)(26005)(316002)(558084003)(478600001)(7116003)(71200400001)(5660300002)(55016002)(2906002)(7696005)(76116006)(6506007)(66946007)(4326008)(66476007)(64756008)(66446008)(66556008)(3480700007)(52536014)(8936002)(6916009)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Axhk4Jn75eco2EKY396sdCsBrnm6bVwoShbREWs3631tdfr0/dJq7kz0YuuOLYH306nOTbBWLg/P2W00LBUvVkV0EZ2y04z72I5r7nSVCj7JSrqX0I2hbRyORaiv2amBT0FBJN2MbyjnIbS603cTzffWdv8cZtcwBkcaPvWeN5fQf4jyuY2CZZ6m7sjUqmGLCHNTlFzfoWGTfKI0y+5jjb+Qc8hLaLgzOPn0HyzaE9b/0pwfjfo9VXmfL9iHqlIA4bhSSepUF+Mb2seAuUcIowSVO7ryaLpHbMO6A4jEXbwD7V3R1oLmTXk/aqHBDVxF6gPxkcNNa06WyMGqyHIxnfs2dYCwYh+CfHRLH7Zu7lbhHkIfYgyH5SOg1chlZzRewVEeX84m8ZLQyWsmPYfMVS4ViScRpfmv+vQnXpClvbZWj566gCvkE2MVXFzGv5qJrGZkuYtWsI7VFj3Yg8hvPJKfBrk/76rlzQ2KokUcDbSLqab+mvWD92U5KERu+VDsr24Ygit0j4bLw6aUyyyrCOviF5jQ5sJ+NJs5oY0TH+ZhmQ9kiVMR5fMkUnta6nm9gPBbzlvaLyb4rhKmyTn4+Y7ORex1E0bEooIqcUstElrltRqcvFlWpom3SJCv8O/x/t1tCod7NdhdvP29OWtg6w==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR02MB6772DD4A5DE5980A1F7459D9CAEF0BY5PR02MB6772namp_"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef5e5bd-2352-43e0-4728-08d880888906
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 06:11:57.4289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysYlNB8BiY/h3hMUxzev+xlfYO1OmRyfkYABEhNMEPdA9LZiBw29++1hUDYDzEqnpkk5+iDWOZsvZf/Hs7g8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7026
Received-SPF: pass client-ip=40.107.92.57; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 01:27:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR02MB6772DD4A5DE5980A1F7459D9CAEF0BY5PR02MB6772namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I tired debugging QEMU with rr version 4.1.0, on ubuntu 16.04. And I see be=
low errors, any suggestions on the issue would be helpful

rr: /build/rr-jR8ti5/rr-4.1.0/src/Event.h:304: SyscallEvent& Event::Syscall=
(): Assertion `is_syscall_event()' failed.

Regards,
Sai Pavan


--_000_BY5PR02MB6772DD4A5DE5980A1F7459D9CAEF0BY5PR02MB6772namp_
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
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I tired debugging QEMU with rr version 4.1.0, on ubu=
ntu 16.04. And I see below errors, any suggestions on the issue would be he=
lpful<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">rr: /build/rr-jR8ti5/rr-4.1.0/src/Event.h:304: Sysca=
llEvent&amp; Event::Syscall(): Assertion `is_syscall_event()' failed.<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Sai Pavan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BY5PR02MB6772DD4A5DE5980A1F7459D9CAEF0BY5PR02MB6772namp_--

