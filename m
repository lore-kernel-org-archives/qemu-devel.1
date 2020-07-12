Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327FBC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0122063A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e0yCkJ4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0122063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jugGy-0000PI-WA
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 14:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwoodpatrick@nvidia.com>)
 id 1jugGH-0008Oo-Ru
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 13:59:37 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwoodpatrick@nvidia.com>)
 id 1jugGF-0002rm-Ip
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 13:59:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f0b4e100000>; Sun, 12 Jul 2020 10:53:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sun, 12 Jul 2020 10:54:17 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sun, 12 Jul 2020 10:54:17 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 17:54:16 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server
 (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 12 Jul 2020 17:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtjOrqicVNgDiFdfqie2bOT2A+g2NjyWUrNl158IjWl0p2pwXY8eJQ6Dwn9ILahbGugbwEhMUtpcwYdzectKEMOFby71orMiu6ekSe2KzbwoQOXlbQhMW/MMEEdQ5YE77nvbsNoIpy1nwG/DYzv3MTCpisgVKx77EhUUqLFlyQaHMhovjKzLz5l1xnSGW8TZiuPawzZJZLaAOmy6nAe4dMq4lTjfAEecLouvCGokQYGAvnMiPtYcMkMxSjnWNUH7YbF5ehwrty46InYI2I3AHqBIHrJnhHNR684PlzInLwtLFuKFYp1sgEU8VfQxDLCkhBkfr8xsQVjQE6DvgoNIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ei7mayYsfR+wR30feXnf+rtCzcXBsSrPgzA8MQ1NyM=;
 b=icimZAes7i/Y/cYs1aNP6hnXM3uyGsXG8pr73bG+CPaU/zUQr4IapVCfYCA5h9QoTaMQviDPYYfb26qhBgoGNdww3o43sWDndaxI2SUPRhz76vfF28FOnwxpBIWZdFipf65yiVVpzOdex77W9JTMt20AKZ/gDvUotKXwKUf83X1v5etJ1OwP5JsacsiPS14Jj+8Gk49jstCJ1BJccZeO3w3zYbkE1dzEdbFI2PU3viKDcWJORuCnyu/WoUDtQBCasqlQX2oEBwNXUCvWIBTpgkAmEWsM5kMj6ZllK6A51KQVGsJJSGFSOToNUWLtPNl2g/VuMcmdN41ZF+SEaQGP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Sun, 12 Jul
 2020 17:54:15 +0000
Received: from BY5PR12MB4164.namprd12.prod.outlook.com
 ([fe80::ed4e:e409:c7d3:3187]) by BY5PR12MB4164.namprd12.prod.outlook.com
 ([fe80::ed4e:e409:c7d3:3187%7]) with mapi id 15.20.3174.025; Sun, 12 Jul 2020
 17:54:15 +0000
From: Mark Wood-Patrick <mwoodpatrick@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: Seeing a problem in multi cpu runs where memory mapped pcie
 device register reads are returning incorrect values
Thread-Topic: Seeing a problem in multi cpu runs where memory mapped pcie
 device register reads are returning incorrect values
Thread-Index: AdZP0xwDhu8cf1EMQLyhyg6esmh9lQIoh/Hw
Date: Sun, 12 Jul 2020 17:54:15 +0000
Message-ID: <BY5PR12MB4164C27060E41F83BF8D1B28A0630@BY5PR12MB4164.namprd12.prod.outlook.com>
References: <MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0@MN2PR12MB4175.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0@MN2PR12MB4175.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.117.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ac4fae-bdd7-410a-57b3-08d8268c97db
x-ms-traffictypediagnostic: BYAPR12MB3127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31273BEFDC1D4BA3A225BB3AA0630@BYAPR12MB3127.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xggeqQ0eAzFJQBsTKV2G8NipjhOqAPOxpnuoCeE3FT+0LPtt5+iS6kfbaUBx4DGagqq2NtRs3OoyfV7Bp5p8nCMNkd8S8nlQZHJznlnbPW9c6B1B4uhDWgPLVveSQOX5tPPECNAJ8V/zRBBglNntQYFnSOxv4UKv3ZfCmaV3W/6R2MW8Ym5N58R7Ylh/+zAmXRiOXPNBPGgh+rmVIOyMzko0FnNjR4AWOSXkftXTmLt7ycpAh854z08pG8hpK8qMktNkTchVliFVFxtDQaNBAw8C3WmudAbJUDWPVnWmDcl98R0khG2uunK5pTXIpFK5XUvq40ltAY4T2jELuyRhwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4164.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39850400004)(376002)(346002)(186003)(2906002)(26005)(6916009)(8936002)(86362001)(33656002)(66446008)(64756008)(66556008)(66476007)(55016002)(66946007)(9686003)(7696005)(76116006)(52536014)(5660300002)(107886003)(316002)(54906003)(478600001)(71200400001)(4326008)(8676002)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6d30xL/rLijXmPxkhEXgqVUZrbwiv0c/XcctPFQprVLNE5v+hU0zBSPRSWXaQ13SsR/SsI7oDrW38nIWFx5SMMVN6bgIQjuqylBe8bsEVrCzNcyW8coi+MQpcDORot2rId8S47d3DAQQ5oIpExHeZXIz7YLG2AIOATWW7yv5C1npSikim3bzyI3bz2/2qg1weywGekPvG7x7c8c2IuDDi5IBbeuMK/v5X70mUsUyXF4Y9scR4gS9h3LCHD/UGxCTuViRqt+1X4rh07/c6YQqZGzT6//EkWyoweqDMbXw3NNPp6M5L+53FVoL9H2kD5jgUIFAxSOWf00Bcq4dQM3snamBKqSL7Ryw/iKMtw9oPGTQg0xbMO8DIRrVw6srnV1d28fF8IPEi/rwssqkBCOLatp1zt6C/yxv+OPCRj1RHtQuk9uoSEjUQhfHzZfznUmqz/F0o5BWZoc1OsP5KLFPZ8trNlQoj9DdXuM8rM1MpWbLYWH86doMVNQYG6GQRQTb
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac4fae-bdd7-410a-57b3-08d8268c97db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2020 17:54:15.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYLG1tpsmBGvN5mZBTBWs30WYH9s+nfI2RXa5eZu6V1LCVB7XQjRPqowqtQTmk81GQmkG1fBbAw5qx2HLj0dIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB4164C27060E41F83BF8D1B28A0630BY5PR12MB4164namp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1594576400; bh=3Ei7mayYsfR+wR30feXnf+rtCzcXBsSrPgzA8MQ1NyM=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 authentication-results:x-originating-ip:x-ms-publictraffictype:
 x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
 x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type;
 b=e0yCkJ4j5HqP4ty4n2g+YTeElRK2C+a8k9YVrHo6yTujleIUmMqfL+p+vXlHRrdMB
 js7Gg3FJMpxmmMiAskCoWHo3t+rjYxoQtHpp9IUTgBiS+Y86OYYjVvNGiSJhOEDiOA
 ohjg2FbcwrCO+8rbUatgYV0oO2N5AVVslU/EehYdca7gnySVgdKWAPyQ0jn3PKqwGh
 yfTPeGbuLpKtttNH+InIlBpCKii3ytuG1UyGnvVg8hfYg2VPT7ooDbL871ZLueSvfI
 6jOr5xqgHdR/5CcWZIAupFi0XuR7zUxAU2MUnCA6OdyvUQxpA1tlaZaiNPe9WSSUzM
 tThPPNCrkNs0w==
Received-SPF: pass client-ip=216.228.121.64;
 envelope-from=mwoodpatrick@nvidia.com; helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 13:54:17
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "stefanha@gmail.com" <stefanha@gmail.com>,
 Mark Wood-Patrick <mwoodpatrick@nvidia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR12MB4164C27060E41F83BF8D1B28A0630BY5PR12MB4164namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



From: Mark Wood-Patrick <mwoodpatrick@nvidia.com>
Sent: Wednesday, July 1, 2020 11:26 AM
To: qemu-devel@nongnu.org
Cc: Mark Wood-Patrick <mwoodpatrick@nvidia.com>
Subject: Seeing a problem in multi cpu runs where memory mapped pcie device=
 register reads are returning incorrect values

Background
I have a test environment which runs QEMU 4.2 with a plugin that runs two c=
opies of a PCIE device simulator on a CentOS 7.5 host with an Ubuntu 18.04 =
guest. When running with a single QEMU CPU using:

     -cpu kvm64,+lahf_lm -M q35,kernel-irqchip=3Doff -device intel-iommu,in=
tremap=3Don

Our tests run fine. But when running with multiple cpu's:

    -cpu kvm64,+lahf_lm -M q35,kernel-irqchip=3Doff -device intel-iommu,int=
remap=3Don -smp 2,sockets=3D1,cores=3D2

The values retuned are correct  all the way up the call stack and in KVM_EX=
IT_MMIO in kvm_cpu_exec (qemu-4.2.0/accel/kvm/kvm-all.c:2365)  but the valu=
e returned to the device driver which initiated the read is 0.

Question
Is anyone else running QEMU 4.2 in multi cpu mode? Is anyone getting incorr=
ect reads from memory mapped device registers  when running in this mode? I=
 would appreciate any pointers on how best to debug the flow from KVM_EXIT_=
MMIO back to the device driver running on the guest


--_000_BY5PR12MB4164C27060E41F83BF8D1B28A0630BY5PR12MB4164namp_
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
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
h2
	{mso-style-priority:9;
	mso-style-link:"Heading 2 Char";
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:18.0pt;
	font-family:"Calibri",sans-serif;}
span.Heading2Char
	{mso-style-name:"Heading 2 Char";
	mso-style-priority:9;
	mso-style-link:"Heading 2";
	font-family:"Calibri",sans-serif;
	font-weight:bold;}
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Mark Wood-Patrick &lt;mwoodpatrick@nvid=
ia.com&gt; <br>
<b>Sent:</b> Wednesday, July 1, 2020 11:26 AM<br>
<b>To:</b> qemu-devel@nongnu.org<br>
<b>Cc:</b> Mark Wood-Patrick &lt;mwoodpatrick@nvidia.com&gt;<br>
<b>Subject:</b> Seeing a problem in multi cpu runs where memory mapped pcie=
 device register reads are returning incorrect values<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white;verti=
cal-align:baseline">
<span style=3D"font-size:14.5pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#242729">Background<o:p></o:p></span></p>
<p class=3D"MsoNormal">I have a test environment which runs QEMU 4.2 with a=
 plugin that runs two copies of a PCIE device simulator on a CentOS 7.5 hos=
t with an Ubuntu 18.04 guest. When running with a single QEMU CPU using:<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; -cpu kvm64,&#43;lahf_lm -M =
q35,kernel-irqchip=3Doff -device intel-iommu,intremap=3Don<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our tests run fine. But when running with multiple c=
pu&#8217;s:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; -cpu kvm64,&#43;lahf_lm -M q35,ke=
rnel-irqchip=3Doff -device intel-iommu,intremap=3Don
<b>-smp 2,sockets=3D1,cores=3D2</b><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The values retuned are correct <span style=3D"color:=
black;background:white">
&nbsp;all the way up the call stack and in </span><span style=3D"font-size:=
10.0pt;font-family:&quot;Verdana&quot;,sans-serif;color:black;background:wh=
ite">KVM_EXIT_MMIO in&nbsp;kvm_cpu_exec (qemu-4.2.0/accel/kvm/kvm-all.c:236=
5)&nbsp;</span> but the value returned to the device driver
 which initiated the read is 0.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<h2 style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;m=
argin-left:0in;background:white;vertical-align:baseline">
<span style=3D"font-size:14.5pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#242729;font-weight:normal">Question<o:p></o:p></span></h2>
<p class=3D"MsoNormal">Is anyone else running QEMU 4.2 in multi cpu mode? I=
s anyone getting incorrect reads from memory mapped device registers &nbsp;=
when running in this mode? I would appreciate any pointers on how best to d=
ebug the flow from
<span style=3D"font-size:10.0pt;font-family:&quot;Verdana&quot;,sans-serif;=
color:black;background:white">
KVM_EXIT_MMIO back to the device driver running on the guest</span><o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></p>
</div>
</body>
</html>

--_000_BY5PR12MB4164C27060E41F83BF8D1B28A0630BY5PR12MB4164namp_--

