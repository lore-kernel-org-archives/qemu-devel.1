Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5033C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B944206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="V8uepr75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B944206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIcHh-0007v4-5I
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 14:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIcCn-0004TV-F3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:30:58 -0400
Received: from mail-bn8nam08on2083.outbound.protection.outlook.com
 ([40.107.100.83]:39671 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIcCk-0001pT-3P
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:30:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8RBULZHEJ0tVUKqiAZckpU/MsKAteFHCDrLnd16uRORzrjHSLfq1EFlPtNXC23rAnjv6tuB5wq80XEl8+xQZATh0GwmZJ7FwvpwoBa290ChL2DU0THX0KkxolVg7DujUthnUTzlfHgpHeHTpzAMgk+cGSezQwuh+XGWvrDaLzsCyV0TcOvG1woTEQwU0r2DvmLT6UUnfnW/+0my00/bB5LZJTjF4sSQXtoHSgID13bDHLDeuxAY2VBTzQmBsxdt4SaOsLtzkXrAAimDiGlO+kuQH4CeqyMBTFRHg8g+z3+h+QJlGR+7kZpFqdDKvVg3Wq4+5ClaiET5Hz+dylH/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qog87hl0jx9CrYnSHm9HC7OK8BLH9JLhpshPBZdtxUs=;
 b=RTg/1KgaGzgXe8T4hI5zY6Pwcu/r0d1Zcw0oWMsYxSaZ9AjcqdITt/NI7n5AswOud32elyJXh/3z+a+ANBQoZOgyg7xK8vWJEDVZbeQCOCdQ9ZZNCh0xiezsBwOhgZ8zTIXN06v4rq4oG41dV8lEr7JQJypnEgOKDYyugClTWB0TLoz3d6ry35237B5Ok5y9vNfYkfktd3YFc5L5AbkN0SeFgyDjbhskvEoNOCR/Ey/YbzXCyaCKTBP3hvqki3BBk7x+JOSrjYf7BS2AAS29R6g846F6EAFZbKWOzCXQvhZpVqeNSl+lOC9wTVExvguTb3oGeqgKjBGBWTnCWBhMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qog87hl0jx9CrYnSHm9HC7OK8BLH9JLhpshPBZdtxUs=;
 b=V8uepr75UUUzCe9vjw2hq24t3mks47XFT1lsRDZI4qwavlvhiKaPKmprODmXp8yyAghwTIpUs5CnNbnGXuOor6o4daCvSfvIr8YdGSf7T/KgfGWDj23cHQqpXY2Bvc51Ot0QCXNjE9T6CKrYDMmhjCwq5K1Z+6v8R7WRzchWeLo=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5975.namprd02.prod.outlook.com (2603:10b6:a03:118::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 18:30:50 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 18:30:50 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: eMMC support 
Thread-Topic: eMMC support 
Thread-Index: AdaMV1egTP30pYAoRjSnbjGpoRC6iA==
Date: Wed, 16 Sep 2020 18:30:50 +0000
Message-ID: <BY5PR02MB6772761F83EDC56737969C18CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0007a03c-58d5-487a-9ad9-08d85a6ea35a
x-ms-traffictypediagnostic: BYAPR02MB5975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB59750ED915EBA6E166B6DF55CA210@BYAPR02MB5975.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjMYrFe22Co3va5ZwCITiZbfPHbOynSB2emiYheht9iJDfsEVIVtHXB2tWCp/Vst8yYacSf6IBTG7yuH0PTrIuB+RDR1uxJvq3SkjpT0Y2s15AzjlwXBIUb8dKgvmDQN7tDbSSEvHTTqpcEUz7EmyCifjAq7Kp3Q1s4q8EJY08Ldcp0QZyyNaPt6tvtlcKO0DH5whguB1n1A1gp2aau6eLgehnYOgnHAbPYowUpwAMcIA98nlnW7oqWLEh6+X00hWgamJjzeLWVghHZ5VzstXEN7Ir2P8FMu+0i3Xf24MYtE5hRtapctrInTWP/jif3nETSKnu+5Ij195hTd0+TeP8LIGTwwaJJLeas9xu6H53I2/CaN7jIrzJf4vi0tKI4WT5lhfXsid2DJtln7trG3lvc0F3Bch1PXG/CAliwIfJnJZ75flTkjk0pIzt5UpRLy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(396003)(366004)(39850400004)(55016002)(71200400001)(2906002)(26005)(9326002)(21615005)(6506007)(66946007)(166002)(107886003)(86362001)(4326008)(83380400001)(7696005)(4743002)(8936002)(186003)(76116006)(8676002)(316002)(6916009)(54906003)(7116003)(52536014)(66556008)(4744005)(66446008)(478600001)(66476007)(9686003)(966005)(33656002)(5660300002)(3480700007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3o3Ri/Turn3LdVOFWEDLeoWtVxaE7IvQ2cBdTXr6VcBxQ6CfBEJsiBAI7IKQQx2nUUQJqH8ug7KIuXPg++hbnMkg4tgQvMxFqj+MzN0In+cRR2xCnGZgl47Lu8Hg6th6EmE6y9XOX7eXXwBHR1knreqUhpSlydFzUp9Mh887un9VvV2sZzdnfyJb1CjyqK0LglDQwFLs1wEn32gbgJGNB4mSwMsdW+AVN5oDIAhx7ewUbcUqOpb2sfb6K0pJRlqyGK1z2M0iP+jn7Mf/7TQI2erC0eEPA23vLLv/RTL7adSmnOw4PAjLFrlkl3windkY13Xh/OBFQLUqiOYmcenHa9tESQzeYUJ5Y5NBMGpXf8wDKRRT0FelZ2S2K56JLv8dTmc5G+Cy7bFxlvDYERfRKW++EMvpsnRTf/Ba9c2jnkQAnxH9uMCkFYjJfK9vQG0gSLlQgPUTJZHBTlpZ0ODDoNJ7ndv42rdB8aGllZjdqraBF7YEEQs4ujfbTlawxEO9JoCQRiz3I2jJB0igEegmXEXdqRVMjI4iqwqebecHecs2e8ouZmo4eFE55EZ8+6l04BWN2xca9jO1ZDbW7Z/AXnm+bvJo0LISs1zbYGJWWSnlrZXcgAaoTPz082GWwWpt+Od8kD6JbOvzFSzZ3byZ3A==
Content-Type: multipart/alternative;
 boundary="_000_BY5PR02MB6772761F83EDC56737969C18CA210BY5PR02MB6772namp_"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0007a03c-58d5-487a-9ad9-08d85a6ea35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 18:30:50.5391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vJllIHmWanRHylJipWYQg/AJZzrlPKOqB78NCqtpa/v6SrCoLfQ9JrX3lGycJcJwLLrU38miF9KrYiAta5vQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5975
Received-SPF: pass client-ip=40.107.100.83; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 14:30:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Edgar Iglesias <edgari@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR02MB6772761F83EDC56737969C18CA210BY5PR02MB6772namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

We are looking to add eMMC support, I searched the mailing list and found a=
 series posted on eMMC by "Vincent Palatin"
https://lists.gnu.org/archive/html/qemu-devel/2011-07/msg02833.html

I would like to consider the above work and mix-up with more changes to sta=
rt adding support for eMMC. Do you have any suggestions on the approach fol=
lowed in above patches ?

Note: Here is the existing support available in Xilinx fork, which might re=
quire some work
https://github.com/Xilinx/qemu/blob/master/hw/sd/sd.c

Regards,
Sai Pavan

--_000_BY5PR02MB6772761F83EDC56737969C18CA210BY5PR02MB6772namp_
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
<p class=3D"MsoNormal">Hi Philippe,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are looking to add eMMC support, I searched the m=
ailing list and found a series posted on eMMC by &#8220;Vincent Palatin&#82=
21;<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lists.gnu.org/archive/html/qemu-d=
evel/2011-07/msg02833.html">https://lists.gnu.org/archive/html/qemu-devel/2=
011-07/msg02833.html</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I would like to consider the above work and mix-up w=
ith more changes to start adding support for eMMC. Do you have any suggesti=
ons on the approach followed in above patches ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Note: Here is the existing support available in Xili=
nx fork, which might require some work<br>
<a href=3D"https://github.com/Xilinx/qemu/blob/master/hw/sd/sd.c">https://g=
ithub.com/Xilinx/qemu/blob/master/hw/sd/sd.c</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Sai Pavan<o:p></o:p></p>
</div>
</body>
</html>

--_000_BY5PR02MB6772761F83EDC56737969C18CA210BY5PR02MB6772namp_--

