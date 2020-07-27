Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D301C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC02A2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gro2eg3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC02A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzxXA-0003qY-7m
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 03:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jzxWJ-0003Mu-RH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:25:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:9590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jzxWG-0003Pf-Ko
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:25:59 -0400
IronPort-SDR: iElLa6Q/sOgr3UZouGw7YHunu53bJoLBLW0iQuC3cukHu2lt3vzDKt6hKyf97VbeRq85PNYViJ
 0I41XsWzLuRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="235831179"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
 d="scan'208,217";a="235831179"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 00:25:49 -0700
IronPort-SDR: oMk68jYFvZ2C9nBPI3kT95DsXukS3BDppfwVPNA+nJGjfXn11zfRcc16ODiy25v0tRH++yPng5
 Zz8z1UpKdvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
 d="scan'208,217";a="364036866"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by orsmga001.jf.intel.com with ESMTP; 27 Jul 2020 00:25:49 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jul 2020 00:25:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jul 2020 00:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo17SFRUSMJUxRNHXQywOldcTBBg83VtujIUZ32r1lcQfQY7GFsfFn2/O9oDt0QqCVRiSiiQ/XFLNy7LlF0M1YSCkCxXOIpiH6bIaYGVmMrBLSCt6p0EzTzMdRtEJhAgG+S2wPdgZLyYKg/4DDWMaoVgcYa3s879v8XPEnTbB2bLwt2A1ood9JkAMbk+kPMskk/szsiwOokrDknJONqknRhY8Nh6bu6Do5zx//mrO2K2FoWxaWeCa6pbaXTcRrGd6ccPWCRNXZ4uQHj6hXZO/S6TY5LdCdpsrA/WcVaPNCchrqTy2WXqhB7FP0UNbTJAiznZk3srlvLypHLJ7kEj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq3hqntQygKY3b69TlGUwEmR1+OCN4QodSkAJDITntw=;
 b=oI6C5smztGwSiWvywtupVoJYu1rrnfgOyCmO8YybMQvLfk7f+28ZpU7HcXKQRiZTAEaH+VFRFHXcTohtcjTQ1lVccpeotauJy8A7E9UssJ8kp9yFqTvYMmVs0DjRcJbZDYeYYM/crqmOS4fxEd/Rf3PmSB9sPaZ9NQmP81ExoL2VBsVhJlu0MmqtVpfWBit2tCnWdlk3VvC9ufICy2JGviij7PTBp+C0+CkCDOUBY+RCaRDVUHSuKZNRMIpJ/HNDx8hluXXnviNal36Df7Sf9btytr10eNhBvBjFCp5w+ocX2htnaFu0oyqCYP4R6D2V98M9omjDjdNkBb32fg1Uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq3hqntQygKY3b69TlGUwEmR1+OCN4QodSkAJDITntw=;
 b=gro2eg3vVB8qfE4xcORwhOB4utupnk+Dwf69auu3VEo4jkCPZg/uykw0jY/9pNS+JEm6wx2oIu+rP/3Sw1N33Zl2UW+6iA9yOSI2IrZPxsSwk/FRoa4biuP3SAP9k+uAzGlGgcxzKtd0pnqdlvC/e/6gQfDWbhkzTmoEM/PAlkU=
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DM6PR11MB3163.namprd11.prod.outlook.com (2603:10b6:5:c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Mon, 27 Jul 2020 07:25:48 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::29db:26c0:5600:9a71]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::29db:26c0:5600:9a71%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 07:25:48 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: qemu icount to run guest SMP code 
Thread-Topic: qemu icount to run guest SMP code 
Thread-Index: AdZj4TUPa7d8LF+FTay+aKrN5OI2RA==
Date: Mon, 27 Jul 2020 07:25:48 +0000
Message-ID: <DM6PR11MB4316F4369641160B5B61AD7B8D720@DM6PR11MB4316.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e74e2b28-8ac5-4fdd-16e9-08d831fe4896
x-ms-traffictypediagnostic: DM6PR11MB3163:
x-microsoft-antispam-prvs: <DM6PR11MB316347AEA49AA113F2AA84E78D720@DM6PR11MB3163.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gmu445hknaTJ8utrJyQHGIgxa/fQqadLyZL94xgwNS84rj2dMh3lltTAHNxWwOcWHJ6wjk7aIR5SC9/SVouhgySM0zYz4vziioyVlvR4b/E65fdeM4YOIne+vG7NDbEuyMUOwaB4iv/Tw1fLi9pb3NMZGVBUbcVGY60g251/BCvsaHfWcZnbfKLIKm1T4ek8dLU7d0yYDTAqND2uU1IxH3C8gdEwHqpGG1f2+dnDDWQf12UNFJou9e/wWXbtiQ4q+oB15nS2eJaEvi9CLL99zHepxpHRbIAtEHn9V2c6u86zLmarLICASJi6+K2zSw9lsekhieT4e2387xErquCDJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4316.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(2906002)(5660300002)(52536014)(7696005)(6506007)(33656002)(83380400001)(8676002)(26005)(478600001)(71200400001)(64756008)(66446008)(186003)(4744005)(110136005)(9686003)(76116006)(8936002)(4743002)(86362001)(66556008)(316002)(55016002)(9326002)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tc1b15qKQDNIYEd+loMv0akI/RKAiTe9BSdw7ebeXzLZfglOGbqgf0u6vosH7mCEzoYv/57dZWgjsIuKY6xDdF8xNXVil3l49T85VFoazKQ+Ms1ch1KCD7B9uZTv5jqihKJdcLNIvlFvgaU22Egtznk2xKQ7eNH/TkT7lBKcbkk7sTFomZzyOMs2V7YGBssJYltRmw5noaZCSXz4/oy+mRuN5L/ePLwxDCd7B+s1bc8z1KPUooe7UnBuOK3Ntx7sJjkOlzDi/OYqFZ4cZC9n1mpdpZHjGqafczCnXC954XJ2UeParnH7x+bgGlYw+r/MgkbHVLYgGf/lZdmHX09W5MkRtF2SvpGJmf63FYBvSu+GZQr8ySkKr7/y9gP0509aDBaLuLxaQocyEklBEaEFk6grpQka4FWcISmrc+issAy1hcISBwh6zC+S/cvtH331fQx9W4rIoZTuCfDi3Tz0dpmuiKUI3+ZlKO1QMtWrZlBlRjYN6yeLmiFIIeBx2GgX
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR11MB4316F4369641160B5B61AD7B8D720DM6PR11MB4316namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74e2b28-8ac5-4fdd-16e9-08d831fe4896
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 07:25:48.0746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLDz8LjkYffg9s9h9zPfX/G+ORIZIZE8Ogez1XlhL10aqFAzs9rNVyL9un0sdCD+KWVqIEp3TWWFisrJ0s1kOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3163
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wentong.wu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:25:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR11MB4316F4369641160B5B61AD7B8D720DM6PR11MB4316namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
We are trying to run guest SMP code with qemu icount mode, but based on my =
current understanding I don't think we can do that, because with icount ena=
bled, the multi cpus will be simulated in round-robin way(tcg kick vcpu tim=
er, or current cpu exit in order to handle interrupt or the ending of the c=
urrent execution translationblock) with the single vCPU thread, so qemu is =
not running guest code in parallel as real hardware does, if guest code has=
 the assumption cores run in parallel it will cause unexpected behavior. Ap=
preciate any comment, thanks a lot!

BR,
Wentong

--_000_DM6PR11MB4316F4369641160B5B61AD7B8D720DM6PR11MB4316namp_
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
 cause unexpected behavior. Appreciate any comment, thanks a lot!<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Wentong<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR11MB4316F4369641160B5B61AD7B8D720DM6PR11MB4316namp_--

