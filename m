Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446672082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k4eZUhT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446672082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqjAm-0003PP-I9
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwoodpatrick@nvidia.com>)
 id 1jqhWF-0005gH-6f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:31:40 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:6013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwoodpatrick@nvidia.com>)
 id 1jqhWC-00054d-H2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:31:38 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efcd5510000>; Thu, 02 Jul 2020 02:26:25 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
 by hkpgpgate102.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 11:26:25 -0700
X-PGP-Universal: processed;
 by hkpgpgate102.nvidia.com on Wed, 01 Jul 2020 11:26:25 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 18:26:22 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 18:26:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvJ+SSvUfWZywEhl82PWxtcdoyTwM0XLyGeyaN07Hk7PwjTHGhxQDfBbKzP+tF0bWLKaHTIcq+zvplqW+c5QGJqNQOOeTiWmmhbDJ3cq936MyvO56kX4cMWlW6ArzHXMDzjC6y9Zj5RNxVhPZGwBc8gXXqd6mHs1NrneW6uw/LHBGqmaqsnYuS8X0h9bzumSJNj9Id+CvfmAZ7YnOR+/RL9meIUYc6HbdFtONDRcPhvm0s8xVgvI91d+DVYUBrbXrL4RsjQzJl3caMwHXRScbN3u53L7Pao59qs5GB4LmNZdt83IkGGXM0ORi52NmYcIiSA4Ws3EPlA18xaGb8Hdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5XsPD3M0PLaVGVPg2TyL7nULL5Sk5Q2YG1PiikhofE=;
 b=DcqnzUE1lq06LMhSqNvYPUH7hpO19Hfq6Otdx4rFvR5ULyX4cQtzHmGeSa/LLcKPxwEJdvJJjJhehCpTCgipAcdPUZPSur8RHZTVDodpebbuWHTjJWXVFr27cP9a2k8++9kRDhtgy4+df91ULrN2Oes1Y+Y248BQjia6sFtV3vMKudlPtV+oLzsvXbc4WVmSJ23yESzJ3O73fSI9rU7NsX3g4u/o4YkjqJN6DcFTlqRomCAWM6aE3dsj1rnxb9HRzVZ+0SnjR9uQhD1UYwHD1EYfEY7KkUuTO2o7rxlxo+6/8Qad5lmYvA1g6h2L4m/zKHPxpTRrfTpLLTIDn6p6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Wed, 1 Jul
 2020 18:26:20 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%9]) with mapi id 15.20.3153.020; Wed, 1 Jul 2020
 18:26:20 +0000
From: Mark Wood-Patrick <mwoodpatrick@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Seeing a problem in multi cpu runs where memory mapped pcie device
 register reads are returning incorrect values
Thread-Topic: Seeing a problem in multi cpu runs where memory mapped pcie
 device register reads are returning incorrect values
Thread-Index: AdZP0xwDhu8cf1EMQLyhyg6esmh9lQ==
Date: Wed, 1 Jul 2020 18:26:19 +0000
Message-ID: <MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0@MN2PR12MB4175.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.117.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2907ae7-4a15-465f-ad4d-08d81dec4043
x-ms-traffictypediagnostic: MN2PR12MB4456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4456A04DCA1AEDF88A94520EA06C0@MN2PR12MB4456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhitIHHNpnIafNf00ev7SwMCA2t5AJ+aHV5lXELybz2lMsIuwl5D1TNkeinXxEQVTt/AIonSVGpbjb76IX2Sdiq/J8Wbr793lvxcXz2fB47ml7Np8emaiy0qu+sbJ6KBTbdIkvSjnf1vFhp1AzkDC4l5jB2r0SVuX9BpMmhlpmtu1r9OB/YqnoXuHvc6Gn6yJqIS8bn5Cb9q9Tft12hveUc+pSWWf+FRBkFuOtD4ympA1+GaxsMLEVpcDbet2uYQ75BR3/jmPeHsrKrz0Va+lg1EzjR0fJcVdMgLyyfcd4Tu6heffFKD3kRFM0mdCR8lmnMZs/p4yCGNYxme3R4KxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(71200400001)(107886003)(52536014)(4326008)(6916009)(478600001)(8936002)(8676002)(76116006)(33656002)(26005)(6506007)(316002)(186003)(66946007)(66446008)(64756008)(5660300002)(66556008)(86362001)(66476007)(55016002)(7696005)(4744005)(9686003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pRQdJF4Q0wzqg1H1Tq5PTzfX+tLoT3ghHCDGbrvRlumjFDOilRZzv5uckqNGTlLlq0PoSKwpK+zy9/5DFLuPTei//Y9xlBeacosyb2ao4q1LsstW8f+RaPMPn5yFxnbpWqxff5dKuKyWlwZ/I74bk2wHcbYvOkC+Rm1VXWPeZifJsMC/wskl91h8xhUtLOlp/uGxmWshbZszYTXoQDjETNi/pVcDMLVq4Zd09rWu0CvnbvwvAOSDkFjy1s8qcWHi/RrZwaTDtyFJC5AAdkvDQozcnZ7GXIlpXWxpGCrZNiZA58BQXssmt2uSA9hBO/mwrQPrX+N+rlwz/NF132/QOXVKBBhu0u+Puyf5GPCn1xn2GFIJnj3nhZ6m1eSgZhn7zs4+gjs9x6bIetUDv4THGWwPlD27Qd6l6tPPJXlDh6vH/Oh3WZhdsChtnkzcvkXUbcVCKX7ROK5X3Ey2Bo9syqi76vnzgBMU3Xb/1SA9DowsIRIZgMPfSIaCDCB9ite1
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2907ae7-4a15-465f-ad4d-08d81dec4043
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:26:19.8812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqJU5NGHizPnePZhhI7/GLYmWBwE++IV2SVSjEeBmE1vuBlR/ErAPbUljRWJB3gCXbZbIj9LUhEAE21ORY40pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0MN2PR12MB4175namp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593627985; bh=G5XsPD3M0PLaVGVPg2TyL7nULL5Sk5Q2YG1PiikhofE=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:Accept-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-forefront-prvs:x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type;
 b=k4eZUhT4cgpMnuye8MbhXtrGLAjmJgPw9tPhwSjGbCMvBuv9EQ14cdjr5xRLy6jol
 qbsC4Wt2pRH7lbzDycKOGjy+/kjZv8enKLV9qX3QpFSxBtzSkaEZ1/L+6/Ymz6+0aH
 UGdGqpxbJlGt4Zi2nfdlYrOovZm6yWmX1V8zmB6fmblYtgdyb+At2cr0094Y8H9iIQ
 fpXgdTWicmd9t8Ibpml/14jB6HeO9HjHQ+hmdg6+KQP6DKLuc5VgE8n73RxVbccGrR
 CTKyzuQDxK4ef2Psyvf6TgMntxz96oBa42s3tQZ6X5wU0xEFdBg2fJx9Fp1du5i9CV
 UgKq877kErdOw==
Received-SPF: pass client-ip=203.18.50.4; envelope-from=mwoodpatrick@nvidia.com;
 helo=nat-hk.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:26:26
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2020 16:15:40 -0400
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
Cc: Mark Wood-Patrick <mwoodpatrick@nvidia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0MN2PR12MB4175namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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


--_000_MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0MN2PR12MB4175namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.Heading2Char
	{mso-style-name:"Heading 2 Char";
	mso-style-priority:9;
	mso-style-link:"Heading 2";
	font-family:"Calibri",sans-serif;
	font-weight:bold;}
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

--_000_MN2PR12MB41758B8F79B8F3BBBAF6C314A06C0MN2PR12MB4175namp_--

