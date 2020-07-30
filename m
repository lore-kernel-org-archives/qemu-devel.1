Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AD2C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F513207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="UNhNK/Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F513207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FtE-0007Qi-Ez
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Josh.Pincus@windriver.com>)
 id 1k1FC3-0005kt-1u
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:30:23 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com
 ([40.107.236.49]:53153 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Josh.Pincus@windriver.com>)
 id 1k1FC0-0004FY-Es
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZrXa0oSffeHyj9RQGZ6+/eQOSli+Oe3XPtrpV8YylIpxhrpP5yPvHflKhPw5nIW0a7EkZvayxT02FmsjmMYwlu7hmeNMsRvpSt67jxxwHqGZSJrl11qe9bYu65Rw0CL85VB0oSF0H0njM7h15B/GEefg7QHhHoisJ9SO31JQgJjendvlBJWr6YgJvVyZVoVglhRRL05pQeXudmEDaGlBO/C8yRsJAtwcr3UsD/BTzB7c1qzy3p4ak3TO00KnSSfsMIpM65LkCbgLz7vu2Arsj7nxXM4jfyhB6CXtZQPSXYaf0324tOlqULeRNkatfAuQ+XPmZ3TajbntaSj5m7chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1N52YThXx622k+BgMwHvtQ4tFJC5XncKUJf8drmijw=;
 b=kEAFUMF6fweN8vr68vyH+lJda1Y+CalahzOit9QksrImGUPJkbeUMMFdGjlgIL7EfpGE4euj942+BFIEAfuhdrpqwS187uA7EDw1rAP5+hh2Crc5mrKEx9StK31sbOkGo3IsVBjVVEumLOhCRHntDf+fu6iffa5v1Zc/SgkHLfab3DugEgFG1nX9THkSHluQBwVgwHCIIEqVsT/eCz/WppdoHSEr3Xx8wN1Hqwy5DnBPEK8CY4py2LirEVXo0HLDWW22OqNybGJ5waL05l3eD5wRdnV2uRC4gVb5aspsHxQJbHiywkCjXLFzMaq4H//EuSlIMWMOvQBI2BSi8kc8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1N52YThXx622k+BgMwHvtQ4tFJC5XncKUJf8drmijw=;
 b=UNhNK/Bl/hDpD+H87dEYfsxEHNexs2DJweLBgE3Gpx7wyZYNYhzRoopaaMPqY9qRJ434s2g4fE7OnqQQrHnBckBx0pKnAI3nDvrS91x3auqyWH2yZSUeMHsp6P7aq/EwT0jEqTdtJPct3qCjrtP4LR8NhuKu3PTAxGFocYr7k5s=
Received: from DM6PR11MB4331.namprd11.prod.outlook.com (2603:10b6:5:203::12)
 by DM6PR11MB2812.namprd11.prod.outlook.com (2603:10b6:5:c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Thu, 30 Jul
 2020 20:15:12 +0000
Received: from DM6PR11MB4331.namprd11.prod.outlook.com
 ([fe80::c982:743f:799c:b82c]) by DM6PR11MB4331.namprd11.prod.outlook.com
 ([fe80::c982:743f:799c:b82c%6]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 20:15:12 +0000
From: "Pincus, Josh" <Josh.Pincus@windriver.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Thread-Topic: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Thread-Index: AdZmrhrBQeJ2OAaDRPSTvIJ+bQHYig==
Date: Thu, 30 Jul 2020 20:15:12 +0000
Message-ID: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [68.41.142.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1a468d-ae3e-4aa1-a7d2-08d834c543fe
x-ms-traffictypediagnostic: DM6PR11MB2812:
x-microsoft-antispam-prvs: <DM6PR11MB2812694688C0E7BE51FB1DA2F9710@DM6PR11MB2812.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXTUoxFBm7j0trM/zXBd4D88L9UGU+Wka6J0YQxxnWXDIpwiedcpnm/My1wLl9lNyoDm/jukVjBbrCeWOQamfM9oOxzuZmsyftFMc1UXywX1jMRAKqsJj+HzF/qHIpylwLibWUPt9y93tAmKvjKbj7hdZA+jTh5bGSHG4pgGsowMX10WkbIagEgHmJOtewdjixtEQ/hGjWNvPM8kvTMR3C1avL8XNWO2UZsxy36Q/is1zGvob2nWzKbe4oTOOPKJB3w9oWM+xF/bTwNWMIW3JNZOm3h691khyaWjagiEarY+A/FABsmXfM8XV/Ws057r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4331.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(136003)(396003)(346002)(39850400004)(2906002)(6506007)(86362001)(66476007)(7696005)(66446008)(8936002)(186003)(66946007)(33656002)(8676002)(4326008)(71200400001)(64756008)(26005)(66556008)(76116006)(9326002)(55016002)(9686003)(5660300002)(54906003)(52536014)(110136005)(478600001)(558084003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Q201bm4Dy6i1CwES/lVT20zq3gMg1K5kuc7DA1lNvPfww5vdYJVw6axwJ6me5JY0aXV3DudbwClVUAA8yrU/TBz1Gqy0GfhvqNuQC6ElfdzO5HfgGsjPCv9BObkiSlgV+cUvZvW4YaSxwBMmFBCPjAa43onz4TCrGWve0/zqbYA04OQqxXGTPMeCw8Nwx1JhYKzfpWbNAwMvNdxdjkvnnrYzY8EGLDoKCRpL+IxVep144I6mkTz9TAnBV08r3jShjgv73Motg6bCWTIbz0gGayaFl4BDMmtP1C+jJuQOH1r9rJ/WjShdA0e8fMywYPG7vr/muvcjq0hnlxrTL3mSr6F6pyHprqxIyPoKUtyfxhyEJbcDNUGTrJQyaI+X3ynrLAJmgapae0Vo/OStl8gMhBOC8Yc4Lo+RPEFhIARLHHDukSz+jI/vNw1HcQddrOQ1FmYIdIqV3dR1WLAUXAShQTq02qnf80FzUn+HmAvPiQrPiR63rAG7Pnceq+T00D1XGu6LAfbqGABk5p6teWLTlQqUmIeeTiHySPDpZDK91d4AHuLdJr9nYbul0NwZ0vwuiafyAJHA0rS37lTmIXptol3ock2h11BzlnrRlSYfBt92kJ0xKaeXuAWLpknEZDSnHIedD/ukI2Ums1tV4k5KbQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR11MB4331B490586462DE7353E0B8F9710DM6PR11MB4331namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4331.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1a468d-ae3e-4aa1-a7d2-08d834c543fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 20:15:12.5760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7I76xNStU7k0OihW+AV1rm/UNrstlgd2tniKJ5FMoPvXtVaL8OZFD1O9PYhLEBr1DAWjr7XjueKx9f3tEBRg8gYThAsZIpLRWC2oPcApZ78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2812
Received-SPF: pass client-ip=40.107.236.49;
 envelope-from=Josh.Pincus@windriver.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 16:30:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Jul 2020 17:13:58 -0400
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR11MB4331B490586462DE7353E0B8F9710DM6PR11MB4331namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We were looking into a similar enhancement for the Virt I/O MMIO transport =
and came across this project.
This enhancement would be perfect for us.

Has there been any progress since Feb, 2020?  It looks like the effort migh=
t have stalled?

Thanks,
JP

--_000_DM6PR11MB4331B490586462DE7353E0B8F9710DM6PR11MB4331namp_
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
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We were looking into a similar enhancement for the V=
irt I/O MMIO transport and came across this project.<o:p></o:p></p>
<p class=3D"MsoNormal">This enhancement would be perfect for us.<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Has there been any progress since Feb, 2020?&nbsp; I=
t looks like the effort might have stalled?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">JP<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR11MB4331B490586462DE7353E0B8F9710DM6PR11MB4331namp_--

