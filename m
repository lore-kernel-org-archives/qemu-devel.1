Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9354C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 22:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D592076A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 22:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WOnZcXQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D592076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOTj4-0004vy-JX
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 18:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cristian.ancuta@intel.com>) id 1jOTiF-0004VO-Ap
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 18:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cristian.ancuta@intel.com>) id 1jOTiD-0008QW-37
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 18:07:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:6046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cristian.ancuta@intel.com>)
 id 1jOTiC-0008Ne-Cx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 18:07:21 -0400
IronPort-SDR: i4+Ug+nWwRmlXxWxsI+9gozIhbFM1pvH+XJplRguwUPTRhvQ0bP9YfTKaFtlrSN5s8EtWWY+sp
 2Qgvm9nj6P2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 15:07:10 -0700
IronPort-SDR: QdufoHDFygMoYD6Bs/OZ76hoyRiVy2tmgIjvdBBuhrsu0jJjtbaU8vdrcj9CUno1FLRBUwejM0
 SNb6YbK3B9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
 d="scan'208,217";a="332312305"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by orsmga001.jf.intel.com with ESMTP; 14 Apr 2020 15:07:08 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 15:07:08 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 15:07:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 15:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTIsEoRIuLBvNhoXb5Qtf8W4YSuj+JCcCb9EJr0N8z3S7mu5Euh71GvY8zl+WA+3b2OLpql4jl2TBhx6EQcCVOZ9+6jgzjUtffccl1eHx3+BI+bcYofJMRG/7HYznvtosp0880Bn4WSG/lrZg0Xax8bmQwEv9eCqARk6KUoUVVt+NUf5MTrZUpXu8upv91HC34Dd7yPcLrEQaQ6CJn9Y1yLK1QlnGp/gydrbf0hrhJkzhHV73UorSFL82psHBUzSVtOsOQ3LXKvwLv5OAskbVyhCWVrXhSqBr1PCFgE29x2BH2cmrfxsYbDTmXIEFKyv6C2o4/SWYHHB8YDEUfl2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AER6DicxMjwGkBbYaU15irA+odk1h7nemGJpOkBoj6g=;
 b=gtaMpPAnkmZMtsAwrK2uC2sFQk874qh51OIa5Zq/M6JRDCvdxEd3AQ83828RhbDcmbTmjwNl/fBSy7YQc9JlXOJyPXByOtYq1VMGq1USHBFRjis910kkePXWWK/SwVx6nq3BOH+87eoNV2oYJaBA4mbjUh6v64fSMjMwmaK1H/dLs19KYqrwg1yyFiNTiOEnmGnel4iiaaSs8y7O9mNt6JFnaMxO2rO/E5haccbSpANoWlXVE5N2vkN1Tgi4nRetMXL4Z2V20poTwUEwatYHGeN2XY/YTuDBJrlRAQ0EiJbvzehnI12ktUPeVtUmt+VpFuZN3hX831Cr41lR9Eyr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AER6DicxMjwGkBbYaU15irA+odk1h7nemGJpOkBoj6g=;
 b=WOnZcXQiejF5A5muEE9h92WLiMeE6IXMf17XY79Ff3P6yBtQQfRTHxUkJzU6/t40XK22e3bGYpWU9Ngo55WEAQywKGpPWuhj9XaeDEwmbWEeC1VtezzHSwexI9sLqwdmtvYtpE3VYfL0uUs9ZkPE57QMiMRSw47Zs+WpNGysqnM=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB4251.namprd11.prod.outlook.com (2603:10b6:5:14f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 22:07:06 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d46c:b97b:c9cc:c005]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d46c:b97b:c9cc:c005%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 22:07:06 +0000
From: "Ancuta, Cristian" <cristian.ancuta@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Qemu system mode emulation for heterogeneous SOC
Thread-Topic: Qemu system mode emulation for heterogeneous SOC
Thread-Index: AdYSoRX9rk1WIYP3T5WiHSq+TxQdbQ==
Date: Tue, 14 Apr 2020 22:07:05 +0000
Message-ID: <DM6PR11MB3963D92BC26FB661C7640D61F4DA0@DM6PR11MB3963.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cristian.ancuta@intel.com; 
x-originating-ip: [86.125.233.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe2b4af-2572-4031-a503-08d7e0c02ba3
x-ms-traffictypediagnostic: DM6PR11MB4251:
x-microsoft-antispam-prvs: <DM6PR11MB42514F97CE5F0B0D9767D80AF4DA0@DM6PR11MB4251.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(186003)(7696005)(66476007)(64756008)(5660300002)(6506007)(26005)(76116006)(66946007)(66556008)(316002)(66446008)(2906002)(8676002)(52536014)(9686003)(33656002)(4744005)(8936002)(6916009)(81156014)(478600001)(86362001)(55016002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPeX9UeM+iLamDRD++n5ncAs3KJr3eV+y+WI2fodgwYNOaZDCEwn1ap7Q70QN3FJ9XdG+Pm8Vr5UqkRSEYrQ/v6SDYJApnb5bksfqE+B7TVUCYylz5+T625SSriKDWXfmef/TZjb8W7FSUNK4TPQwJikkyDJe4bgndWTFuHwxvIlBqMlrvxxdg7PjV3XwPHGG9dk1yl2bEkQjLZzo0H5+CaW46qOWa2y2qi6fIo13dWzda2hs3SNC73amDZCIfOz/PwiH35BE1m1CpNiaLx2Jf9qGlz2/2MVc+rQyylXT24BtuisM4aX/jN1nEe/7aCxEJ9c1azwA+IkpK/6DbbLIjPxtgDBAU4DbMSVxpAhuwPI/vA6RoI9L/M4DhaiMIylFix3iwa3sDZ5oUKS5mG4WRfBB8pRSCLooawzOLxPVJlgs0P2DMMBAW+NmCC5IfWu
x-ms-exchange-antispam-messagedata: a2lRHsJcTjv2b9ucz4DH1JN+pPSa9Ap9exIS++2uzbHHVG4bfJX2e95RwdbNNoRADG8Vh/HqlRlur9qjJoMYXavRbPSKzjHsDn/BzqpzDZxZ9uDUHEy8aHAd3ZVzk157yTHXzkNi5ltMHmBwzKn+ZA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR11MB3963D92BC26FB661C7640D61F4DA0DM6PR11MB3963namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe2b4af-2572-4031-a503-08d7e0c02ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 22:07:06.4813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSghvHFXt6KTuDdSdPG6V0ZsxcDfpUxpV0fOewbp4DZZhStHGSAjsZqBht8S2IJ+pqd1zMGUgfyW2Ri9sqwIsppnknlAEKro9DvwJBHSUmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4251
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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

--_000_DM6PR11MB3963D92BC26FB661C7640D61F4DA0DM6PR11MB3963namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

As the subject says, I was wondering if QEMU execution model allows the ful=
l system emulation of a custom heterogeneous SoC architecture.

I'm currently looking at the VersatilePB board as an example of how to defi=
ne a board, it's CPUs, peripherals, memory maps, etc, but it is just one AR=
M core so I'm not sure whether that's the best example to start with.

As a related question, is MMIO supported in user mode emulation?

Thanks,
Cristian


--_000_DM6PR11MB3963D92BC26FB661C7640D61F4DA0DM6PR11MB3963namp_
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
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
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:686761213;
	mso-list-type:hybrid;
	mso-list-template-ids:-1276621184 983840140 68681731 68681733 68681729 686=
81731 68681733 68681729 68681731 68681733;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:20.25pt;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:56.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:92.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:128.25pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:164.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:200.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:236.25pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:272.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:308.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1337460155;
	mso-list-type:hybrid;
	mso-list-template-ids:2134526902 1081266098 68681731 68681733 68681729 686=
81731 68681733 68681729 68681731 68681733;}
@list l1:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:20.25pt;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:56.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:92.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:128.25pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:164.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:200.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:236.25pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:272.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:308.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"RO" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">As the subject says, I was wond=
ering if QEMU execution model allows the full system emulation of a custom =
heterogeneous SoC architecture.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I&#8217;m currently looking at =
the VersatilePB board as an example of how to define a board, it&#8217;s CP=
Us, peripherals, memory maps, etc, but it is just one ARM core so I&#8217;m=
 not sure whether that&#8217;s the best example to start with.<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">As a related question, is MMIO =
supported in user mode emulation?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Cristian<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_DM6PR11MB3963D92BC26FB661C7640D61F4DA0DM6PR11MB3963namp_--

