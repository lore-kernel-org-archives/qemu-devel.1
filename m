Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50852070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="K1ctz03J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50852070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0OoP-0004Id-OA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1k0Ono-0003sM-FL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:33:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:31705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1k0Onk-0001pO-Qz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:33:51 -0400
IronPort-SDR: yIf1vmyHfg0/v9esHj0Kkj6JAsiw5I1GEq6KxN1rGXDJUWBsJOIFBMHzq/Wbhrv0adjRHkMwfJ
 XgJn+6M0MzkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="130759643"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
 d="scan'208,217";a="130759643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 05:33:45 -0700
IronPort-SDR: YtBEEITkp6uptiqToqjzHnlS1s5Chh+Wz4Zf4gicApxZE3CQ61kra5cNl+Yyn08FvIYG2BnJVP
 hwrgEjKs+Jqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
 d="scan'208,217";a="364478931"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga001.jf.intel.com with ESMTP; 28 Jul 2020 05:33:45 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 05:33:44 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 05:33:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 28 Jul 2020 05:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K37XP3a7LlgU4IPL17RcYfg78ci9X1endMgVxn37gkyC3IS72uvrgKGQGtuCXUuQ9JirJtwVejDI4+cxfcFiRW8y7BnboI57pgfGXTuigxaX51DWgK6IPzNoHaoW0PaGoQVbDEPDtr+HGs1CQh9FI5eXoiNOE6cH/Ib6naeV1LVpdAD7ELEtKGj1o9sgGnNLDQHNF167gdvpCXtlUB9nsOXU3elq7Rh5KvVSIjXrEesDIOzfqeAFq+GO9D8myI8BvkYnTzdws0Etut/HAC8fg8sCjBicNykySkwu9t/9kKKaZoxwhuPsLKJMO0n9McsDxQnoSk1G2MT6wFN6hnAeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thtv5XX2pax0jaeSRVQ1CgBQt3sEG7U1hAm0attU84s=;
 b=lj945OeRtMBz92RQUqr06jwuH1H3mrSjiQTYbwgqyNxporp6BmRB/qRLtQkST8SygLRL1PtcZJGI4SLRmmk08N3O5idLOrs9RAPbdatHcGqXAMPmEfSUxOeVlyBJEg0P1KBqTLLjlvzeqNxGMU4qTd/AMugR4ctiK1ilBChUsXRZ1N3o3Zqomn+pHAqKGtsPR+FngB5uVGspd9m6F86kLb79S+/5NrWbkw4+PZmKOaFrjeln9FeuSgDlEKr0mMJC/EraMSPM8eCc01zMhN+gnmHqac08Mvg0XasbmF1CiBVzVF//v1PSVgMFYeKxk2A3oW70X4X1PBc0+1qTuBThwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thtv5XX2pax0jaeSRVQ1CgBQt3sEG7U1hAm0attU84s=;
 b=K1ctz03Jnuul3mBYaMo+jdfm+kd5JQ02yI1PJCeslYLYAX6wjpLBOkismhpc0JsQD7i7VHIxSyU1UBt/XlbgTrpUTTqYl6VqhpDhJPx9zgPwAjlFcVDlKRU7DAe5g37ke4xAQQHZIslSkJ3gkvB3RF8i9jbYbehgyi6VqZAEh4U=
Received: from MN2PR11MB4318.namprd11.prod.outlook.com (2603:10b6:208:17a::22)
 by BL0PR11MB3393.namprd11.prod.outlook.com (2603:10b6:208:62::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 12:33:43 +0000
Received: from MN2PR11MB4318.namprd11.prod.outlook.com
 ([fe80::8ce6:4649:a044:1ad8]) by MN2PR11MB4318.namprd11.prod.outlook.com
 ([fe80::8ce6:4649:a044:1ad8%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:33:41 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: qemu icount to run guest SMP code
Thread-Topic: qemu icount to run guest SMP code
Thread-Index: AdZk2xio5SGW7n3vThCQMVLBcVs0iQ==
Date: Tue, 28 Jul 2020 12:33:41 +0000
Message-ID: <MN2PR11MB4318AB4E0101B3D312277D978D730@MN2PR11MB4318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de2b1174-6032-4a77-e666-08d832f27606
x-ms-traffictypediagnostic: BL0PR11MB3393:
x-microsoft-antispam-prvs: <BL0PR11MB3393CFE677F912E8FEEDF24E8D730@BL0PR11MB3393.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgeB6T6N9rtdsVAEoy4nXHZ80JIY8bgO6KyY9pCKX5crtvhLynEgHs/KW+IGSR0T2rvoFfdOFV1oYHEy8A8RkHE/u4TOsIieHgAMSBd7AV6gRD2MKIA0W9bOa0uy6gDM7xDI7G0SePuaoods+nTG6PKKQpR63Xo3gd+Ii8CNB19uwa65SBJOL6cw3NrYVCllfiaQN3pjnfeMTVeFRuMB+2U7cT8KVDXyqzjeBQpz5vALvKnFiJ0yiuVNjGegbgBw+XI3dz9/41KNUgYqeIgQ7N+GPj6q/ZSQZAFaDc4VggkrDpH9jlOVbWFraxXersOcxK6ByzvrM39IiwFcCUwZsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(9686003)(33656002)(4744005)(8676002)(9326002)(86362001)(8936002)(2906002)(55016002)(64756008)(66946007)(66446008)(66556008)(66476007)(76116006)(6916009)(83380400001)(26005)(186003)(478600001)(52536014)(7696005)(6506007)(316002)(5660300002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: STMANmCPsxDrVHlmEgQdAgDQlp4x5vghjLQrb0DeYC3OV0jlr8llpiHOmunJZ4JAsMWPEAnS6xRKsfe3ZhlrI06+VCQMF3xEyXF3nKD+FGY1PtbhI4xKkeZF1nppou1le3z/L5PNabJzZ3BfA9Uomogs6uA02G325mLAnHBI73xVlm/PPrE4kaCGnAfMVaigAxLrRWJfR7Zw8T+lCO5PL5yf2cfW//9UgmgZboDChxXi9yDZjOP2o9GjcTUeulVdp3SJ01Ow5zU+qC5sIfNWRWygPZ8l9G4u6kkXqQUMdCQnLIB3omteqif+9WiGqxxhyQz0BoSj0PGzBZgiMyBlUKCmNUWtNcmiC1eVl6Bs/qPgqsoyfwD7KADLc0cHaSN/METngiuapPoQcpIvE83dnRrXFYle8tfinPvLvBRFx3QBqwmhn1OlKCrngB//BkO8ddQJL/xH8lRF5rctoYZzPY1+3K07fYELVz+vHiVFlu/niveCHT++i4r8An4QwnHb
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_MN2PR11MB4318AB4E0101B3D312277D978D730MN2PR11MB4318namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2b1174-6032-4a77-e666-08d832f27606
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:33:41.5633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiVYMBDywLucHvx5GEwLl7pGWG87gHSwe6xNhVADEKLkQVhPuOrZbuocfv/PPit3xDLeOnnQm4qfpD/cVwoLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3393
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=wentong.wu@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:33:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_MN2PR11MB4318AB4E0101B3D312277D978D730MN2PR11MB4318namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
We are trying to run guest SMP code with qemu icount mode, but based on my =
current understanding I don't think we can do that, because with icount ena=
bled, the multi cpus will be simulated in round-robin way(tcg kick vcpu tim=
er, or current cpu exit in order to handle interrupt or the ending of the c=
urrent execution translationblock) with the single vCPU thread, so qemu is =
not running guest code in parallel as real hardware does, if guest code has=
 the assumption cores run in parallel it will cause unexpected behavior.

I'm fresh man to QEMU and not sure whether the understanding is correct or =
not, so appreciate any comment, thanks a lot!

BR.


--_000_MN2PR11MB4318AB4E0101B3D312277D978D730MN2PR11MB4318namp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
<p class=3D"MsoNormal">We are trying to run guest SMP code with qemu icount=
 mode, but based on my current understanding I don&#8217;t think we can do =
that, because with icount enabled, the multi cpus will be simulated in roun=
d-robin way(tcg kick vcpu timer, or current
 cpu exit in order to handle interrupt or the ending of the current executi=
on translationblock) with the single vCPU thread, so qemu is not running gu=
est code in parallel as real hardware does, if guest code has the assumptio=
n cores run in parallel it will
 cause unexpected behavior.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m fresh man to QEMU and not sure whether the=
 understanding is correct or not, so appreciate any comment, thanks a lot!<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR11MB4318AB4E0101B3D312277D978D730MN2PR11MB4318namp_--

