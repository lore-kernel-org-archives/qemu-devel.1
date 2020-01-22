Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E3FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 00:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8378424655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 00:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HQzzolMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3VO-0004Hl-Is
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 19:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robhenry@microsoft.com>) id 1iu3Ui-0003rH-9E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robhenry@microsoft.com>) id 1iu3Uf-0004LR-US
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:03:39 -0500
Received: from mail-mw2nam10on2121.outbound.protection.outlook.com
 ([40.107.94.121]:17632 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robhenry@microsoft.com>)
 id 1iu3Uf-0004Ci-NA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:03:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFt4ymE0OBPClshTZ1yA4wsDrPv2dty9JYPHst7ymz/3EeYI8U80KtLvJL9KxLj/BzzjPwM/QoFZKg/wyFJ4+zNUt4or9hkq26SxQXqEHkTYT7p8Eh6+oy5IVEyZNZwWylNUoKjimjtZdA4Qs+YG+RJ/jnfkApB+uEy3U+w4rFi9dcT2FR/kcjto55+UUugEkw19pF3zLbRjgMOmb0lOBvUeAX9ut8fSWI9ycynBiKiGonRohx542WjvYQz7bVHYyOXAWm0hhbtW6jXhTrTs/CthtHV+wTnvtlp9TqZ8wX9RA5Fve4Y4IJ/71AYD9GZKyHjoGYbFe7vJXDck0vddzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPXobQ+omGicBT+31SypUuwGx4SC7mSNWc7Gh8dMbH4=;
 b=Hrr/MqsShPEpANsmxbWnPuD2wiWXpMn+43yf6dtf4a3vfoiOF/KaqXTSVe+m0GETRO/g6Yu00OsOfG+Bs6kd6GImd68pv+aRBEtoIJ6EYzA8zKs1ZUsvJrbt+kRKOFTyraY8XHmktrrykhlzifrZgJ9h9Y9Col5eYAxFzgEaHfMcq4j/vkEJIqSmdONX3aX8wU7kNkBjvdMW3pP+bIK/pAmDc5jURsvmUerEn+rLDGLwoRIGdb3VoBl2cMdK40wZwEj4BWZoQpd9U72VipbVOG3c0zmD7gzUP6dASwTTM0lzuddyXd/OOtBaMHWq/q9lo8yWXIF7iXSRqNCeO/8i9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPXobQ+omGicBT+31SypUuwGx4SC7mSNWc7Gh8dMbH4=;
 b=HQzzolMSgNi1HfLkCDMp508rEf5ktpnD5Ti2CCM7mDmZueoJyxH3J1oq4+lCgNqEtDb/J7AroyQfkK1D+lNLFKAlpsELPgtJ8oiEHuhCLCKHP0bSg375kgT4Iq7ogCtzkmi3pqYBQQKGlxvt9Sk23gO+eN8i7uvAUdKCLFz8i74=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com (52.132.20.149) by
 BL0PR2101MB0980.namprd21.prod.outlook.com (52.132.23.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.10; Wed, 22 Jan 2020 00:03:35 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4%5]) with mapi id 15.20.2686.004; Wed, 22 Jan 2020
 00:03:35 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: plugin interface function qemu_plugin_mem_size_shift
Thread-Topic: plugin interface function qemu_plugin_mem_size_shift
Thread-Index: AQHV0Lcu2/sUXSRsnUiX6/LNMzlQLg==
Date: Wed, 22 Jan 2020 00:03:35 +0000
Message-ID: <BL0PR2101MB1026AF0CA590021284C39D1BD60C0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-22T00:03:34.998Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robhenry@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:edf4:6cd7:184f:ce6b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22256153-3379-42b9-520e-08d79ece8680
x-ms-traffictypediagnostic: BL0PR2101MB0980:
x-microsoft-antispam-prvs: <BL0PR2101MB098077FC15D24E1086607AB5D60C0@BL0PR2101MB0980.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(558084003)(52536014)(66446008)(6916009)(2906002)(91956017)(76116006)(64756008)(66556008)(8990500004)(66946007)(33656002)(66476007)(10290500003)(6506007)(19627405001)(7696005)(478600001)(186003)(8936002)(316002)(86362001)(8676002)(5660300002)(55016002)(81166006)(81156014)(71200400001)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB0980;
 H:BL0PR2101MB1026.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6XVIK5zPboa8leY0Li17VgAyYOTIOQSnarHqofAu4+TCArMk1A9oM2RhevI60Y2eN7wcyiIjCrwZk6kCGhiSXJK/BWtFl4DVen0DRgkjzCd56FUoPHqaeqg5QT7yaUFP7bteSzMWRkqSV2eFYTTdvbFNnYTzb8KfNWs2DdGJPaCIyVGXGkYtRbOmTPCtjb/jSLa9/8LtBul0p4rpDZuH2/i9XPBy0z5yTFqRM4V+uhN5b0R0flwVewyj5NEANHV0e0cJGwWX9HFVmgPEOeG5utWK4oHvF36JRPelqn+GoUUW9AXbj54e2t4Vg/jkh9fGhL11izKRAJSoUbOmDiTGorHCeS68Voiz8uJMhb1Xr05AURMdxRpgdB/TR0VkD/IHC1OxcnAm6QjjhQ8jzw9OQca27xyM+iawXmfC5ZLjp9SMFcLgYnLCx1x3rNBsQ3U
x-ms-exchange-antispam-messagedata: DD4eDlGS+b6DU7san0QyI8qVvNZ8sslVYLeFeU/9+/K6uOy3G2/Axa5kjslzF9W8OAlMuGK4tEK3Vq/uNoYnXqiXvKPdbDFG+4Jju48Zjfpnu8oGiMLx+5yARgjg2ibBh1Y3yyuakMYZb8DJq53NFpS+zJhaN30j9EJN42Q5UrOEk3oHNOuPFpHEM3dez5GeJfRnTfewIF3Me/G558lsvQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026AF0CA590021284C39D1BD60C0BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22256153-3379-42b9-520e-08d79ece8680
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 00:03:35.2109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peAKF08DtSpW188FzL0ZMTfvxyzjvevTrpgDVCDjG8stM2HgtL4CVBRzDoAVo6ooGsB40newrVrtm9pWhNeGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0980
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.121
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

--_000_BL0PR2101MB1026AF0CA590021284C39D1BD60C0BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I don't understand what
  unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
does.   The documentation in qemu-plugin.h is silent on this matter.  It ap=
pears to expose more of the guts of qemu that I don't yet know.

--_000_BL0PR2101MB1026AF0CA590021284C39D1BD60C0BL0PR2101MB1026_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
I don't understand what&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
&nbsp;&nbsp;<span>unsigned int qemu_plugin_mem_size_shift(qemu_plugin_memin=
fo_t info);<br>
</span><span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<span spellcheck=3D"false">does.&nbsp; &nbsp;The documentation in qemu-plug=
in.h is silent on this matter.&nbsp; It appears to expose more of the guts =
of qemu that I don't yet know.</span></div>
</body>
</html>

--_000_BL0PR2101MB1026AF0CA590021284C39D1BD60C0BL0PR2101MB1026_--

