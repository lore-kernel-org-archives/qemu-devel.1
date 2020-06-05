Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65714C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 06:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B294207D5
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WnRhlQnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B294207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh5P3-0006qh-AH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 02:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jh5O5-0006Gi-86
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 01:59:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:54060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jh5O2-0002iF-Sm
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 01:59:28 -0400
IronPort-SDR: E7TI3mkO0xeHKKfD9Rs8VrA5AUH1SJL4rjvcDl0ts1NzAPTrYJTcxBKazS6yWDMm29qSV3leR4
 VmMhGw8LxUkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 22:59:14 -0700
IronPort-SDR: 9AHhG9GuS6254/TUxd+bMJHrlPI8OB8x5zXIz7UUZ5eoeaFdM6hgRzLVJV5JYwOo5Qf5SkSaOD
 78JPYU4dHMPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; 
 d="scan'208,217";a="259097674"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2020 22:59:14 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jun 2020 22:59:14 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jun 2020 22:59:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 4 Jun 2020 22:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqobTyw/itkHVq2D0+1lJWFKZKhXPag7ae90NWyUt+6nKmBMDJ+opzJ0CNOIXCVgFApvl4nVbMw+NFMMsmU7E9BaPuzyUH8LHAtoKwWeYaH7cNDtO1U1F5fSRRz3Os6HhsX3I3G4XX6hUU99Nen71nyJy9IDVjL7InbO9DpAWebK4TMLhxHC/9oUb8J1xn7MezAGnWE8+Uo3LH3e/f0+msvdOdgRqzF17pHAVyZMANLwU/1NIEiZEDj4Ou6+2CW3/HMc3GXW5hhV6F9GdnYpYxNtHIBZOrqEO27ZeBMRuCPgPYquJQiGIqVbjsfFwhnJ/o5ghoe11ruXYOP+9bhNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1MwOYir2aQPs1WAR9UKzFW0SIve4AkUK5+Nm4Zr8GI=;
 b=PelwciGbAWcC7m0fcDLPWrIEbLmg47tYUmX1u8n7TqPDOa8OpMlQOEsMf6ip2R5oje2tQHnJZnP91sZQYfSFqkSqLWPVAqNYNvlR8Oriy14RTGD341+bQBQVpy16CQ5VJP9XAUetvsdJ3qNpqyuO47pexqLbqJfHbPI2gS9tWz9uuLL05iNPH9geVuVjEw1S6ncWJOpUoOs4poSpE9b1DvKNCVv0LoyN9W78s0TEzfdDjmLaK7JjZpJ89WaZnl4auPOrMuRLTW/hDEvRUluGPNEF4Xw9gez8C5NOfmQHNEpN+VlfEWooMY8IfYzGeY87Vq0NxIv322/zvdXmOwKG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1MwOYir2aQPs1WAR9UKzFW0SIve4AkUK5+Nm4Zr8GI=;
 b=WnRhlQnpSArDBsj2ziS8wMvpvt9vAtNtC13rm6rn59rbGnD7rugzaYxjpSwWJTcbuGrysg3hJoeBIiSFQ5sJPPv23krVYT101NKjrlr+I4sOXg0gXoVRTJ1fd6goOp2k+7gR5UgYFh7XAzH0goyMp6PWYfMzo0oviw7TVOq2Xfk=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1497.namprd11.prod.outlook.com (2603:10b6:4:c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20; Fri, 5 Jun 2020 05:59:06 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51%9]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 05:59:06 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
Thread-Topic: [RFC] hw: nios2: update interrupt_request when STATUS_PIE
 disabled
Thread-Index: AdY6/PXgVuA0d+URRVuwGSXTrmqxeg==
Date: Fri, 5 Jun 2020 05:59:06 +0000
Message-ID: <DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860@DM5PR11MB1833.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72343795-0bd2-45e2-c057-08d809158ece
x-ms-traffictypediagnostic: DM5PR11MB1497:
x-microsoft-antispam-prvs: <DM5PR11MB1497362A49C64D6BCDBB26288D860@DM5PR11MB1497.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUdSKmc1xbF0sMoq7RBgJUzKIBi7iV7/Jg9vc1AnR7ZdeGOYYVbUSmee1yTENfNhH7EIMoqcMZGuv0aTpdrg++etxmw9p+bfKQigYE/SA1DGJHERkoj+fbGxyY7/hKao+rV+LoxCKaaxeqsb4TsmNj6k/ZsGdjXtZZX5fknUgzyD41fwr0NR9cmknsqJ5jjEfOUbZ0iWK6vsh3sAOh/bxa3WfZRndQ29oAPfbFW8ZIY38V1zM7nDKEVCG8les6QLBTXz9807z5Y7+Vi3fEw1sin5nPT7mH2QTiui6wZE+D5/INfhstaWnX1dsYLcK2/kwJfGZPfVuQa24YxdkEj8lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(366004)(346002)(396003)(39860400002)(376002)(6916009)(15650500001)(52536014)(86362001)(186003)(33656002)(7696005)(316002)(5660300002)(8936002)(76116006)(55016002)(9686003)(478600001)(6506007)(8676002)(66476007)(66446008)(66556008)(26005)(66946007)(2906002)(71200400001)(83380400001)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4H1TZg9HNVnl4dDQsfC3YAfainxiZjfwIL0aQ2Xt3AG0qYpWXMZR/SOQfcmmuJ1lTJUPINRfDL35UfvxP5YCbcnMN8UpGncmwWcmI8riCEN6+sFpzWVU+ZQtX2JcAPlv41eJT7wiboqGy64/AiereEnweGwE+1H7D6plLPcDwOezDwAqwSgH2DeNKAqTCV0qiGaHEsZBzeUw96WUpTxRbTSgkWnd4Nilqq/Ki/E0ri2ThOhPnKPOPm9nYBw5dqRiweNkc7NRATcb2zINXbou2E1V5ejToUQQ8Tk6C2voTCbaVjd3ENdTdrzLf045MlzShqkQY15KQYTOichKMWzMCNytgkYV+tbks5V2NXZ4ZXEytwtGMexs8h/3UY6/6bp6YH0ceh36MJq/+Vb2x5wRVSt497XRrM3vzli92xm8E6ytZ1Q6IoFDHVHVMO6XQuInxfeUMLdC23XKRoYiUHXe9n1IuIf7VWa1B0eMy+kskDP4lEolPQwhnHD35whO2VQ3
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860DM5PR11MB1833namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72343795-0bd2-45e2-c057-08d809158ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 05:59:06.6123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4M/YvmenLmYVWyIw2WKv3U1EKVoc0DnOZ7HXuJLF289aSMblWvuiOJ2/nwVPYvmKp36SXBQd9bvHIJ2+tCDHpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1497
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=wentong.wu@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 01:59:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

--_000_DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860DM5PR11MB1833namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
I'm running icount mode on qemu_nios2 with customized  platform(almost same=
 with 10m50_devboard),
but cpu abort happened(qemu: fatal: Raised interrupt while not in I/O funct=
ion) when guest code changes
state register with wrctl instruction, add some debug code finding that it'=
s caused by the interrupt_request
mismatch, so I made a patch as below, not sure if it's right, hope I can ha=
ve some discussion with maintainers
first! Thanks a lot!



commit efdb3da4e145a7a34ba8b3ab1cdcfc346ae20a11 (HEAD -> master)
Author: Wentong Wu <wentong.wu@intel.com>
Date:   Fri Jun 5 09:29:43 2020 -0400

    hw: nios2: update interrupt_request when CR_STATUS_PIE disabled

    Update interrupt_request when external interupt pends for STATUS_PIE
    disabled. Otherwise on icount enabled nios2 target there will be cpu
    abort when guest code changes state register with wrctl instruction.

    Signed-off-by: Wentong Wu <wentong.wu@intel.com>

diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 1c1989d5..b04db4d7 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -42,7 +42,9 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, =
int level)
         } else if (!level) {
             env->irq_pending =3D 0;
             cpu_reset_interrupt(cs, type);
-        }
+        } else {
+            cs->interrupt_request |=3D type;
+       }
     } else {
         if (level) {
             cpu_interrupt(cs, type);

--_000_DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860DM5PR11MB1833namp_
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
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">Hi all,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">I&#8217;m running icount mode on qemu_nios2 with c=
ustomized &nbsp;platform(almost same with 10m50_devboard),<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">but cpu abort happened(qemu: fatal: Raised interru=
pt while not in I/O function) when guest code changes<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">state register with wrctl instruction, add some de=
bug code finding that it&#8217;s caused by the interrupt_request<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">mismatch, so I made a patch as below, not sure if =
it&#8217;s right, hope I can have some discussion with maintainers<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">first! Thanks a lot!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">commit efdb3da4e145a7a34ba8b3ab1cdcfc346ae20a11 (H=
EAD -&gt; master)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">Author: Wentong Wu &lt;wentong.wu@intel.com&gt;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">Date:&nbsp;&nbsp; Fri Jun 5 09:29:43 2020 -0400<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp; hw: nios2: update interrupt_req=
uest when CR_STATUS_PIE disabled<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp; Update interrupt_request when e=
xternal interupt pends for STATUS_PIE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp; disabled. Otherwise on icount e=
nabled nios2 target there will be cpu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp; abort when guest code changes s=
tate register with wrctl instruction.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp; Signed-off-by: Wentong Wu &lt;w=
entong.wu@intel.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">index 1c1989d5..b04db4d7 100644<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">--- a/hw/nios2/cpu_pic.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&#43;&#43;&#43; b/hw/nios2/cpu_pic.c<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">@@ -42,7 &#43;42,9 @@ static void nios2_pic_cpu_ha=
ndler(void *opaque, int irq, int level)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (!level) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; env-&gt;irq_pending =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; cpu_reset_interrupt(cs, type);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } =
else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cs-&gt;interrupt_request |=3D type;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (level) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; cpu_interrupt(cs, type);<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860DM5PR11MB1833namp_--

