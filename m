Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A1C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D5E2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D5E2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDMj-00006C-VS
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artifice37@outlook.com>)
 id 1kVDKR-0007Tu-0r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:34:55 -0400
Received: from mail-oln040092255054.outbound.protection.outlook.com
 ([40.92.255.54]:16936 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artifice37@outlook.com>)
 id 1kVDKN-0005VQ-9c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFL4VaDXWVIGR2l9WxUqIZmZeM1IIgI9UC3K5AnjXe8JCVqnGelA5DOIiciIZWDbSqb9cC7bgRJLAcmY39/8CJ+YR4a06WdBCdF7X9yeo7pOQtsrdrrxz6UZOHB60owAchmNGK3j7k+7mvbKHO3vcBbAP88i+DgAChKSt3dapIF+6BytUAGhBhYH0ddHhI2Ckq2/hkN+2BZ0qVe+MZQx/7at2ovzR350IgY5ps7ueRKVCsxcOizh3doHctwOeTjSAg5AC09grtvGsJGj0jHl8UAbRjpuGeNCHzXci4o36nE26NzXrcwcDCaiXSo2RekWKBDqLGCKFa+9OTWZ1zQtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGDEtJLw1BD4kkaElOGU81jSO4++AtPcDtJFlqKCCOU=;
 b=eO+mCewsL7lJEE0wn1TC769ajBdnnW18OWGdnmgB5geqjCUrenbSwv+n/gwzGrYlfTrcH5c3/47kV7FLnTacRv01mmGY8hRVFprZvzHJg4Czlo+U4gajlCBARsorIT0pRBMtp1PJcYbKqz2QPemIQdGsKleaG4xYRApX1niiikVYfpNa+k6jTlF8UiMW6r1uibHXYi/CSFXSBgbFxLSGMWHm1bsgYf3upP+DTM/oPJIwhXkhuemA5mA+8la59kyd25Pmmt9oVpyCBNd6VfH46Fp62M9kN4Lf5xwwnxckXujcbsnLCV/NwuVSvr2WUiIRK4oi2xWtn2rE6o0byU54Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGDEtJLw1BD4kkaElOGU81jSO4++AtPcDtJFlqKCCOU=;
 b=Qg4LZnvC0mFZnm2+HESlNO2YLBhCIsBJOQgCB0+2mVTEUbdP8ca1c1V83J1+sHUaWxtB8SIls5/Zxu96gtcW5qhGBA5n37fs1km34iOAy4vZBQg6G1LPZBtR7RAmMNpZQxlCNdHeNNhJbygjO0yuxbrEIKZZhVwVH7A5112euJCF7vdcEO4CTmMKbBQWepDQvHFIhZt8j15/k+oCJRykyYOgwsJkTN9OzjtTJJH3RoE4F+/+0nefcwGxT+oc+TYBZmztz4k79QTKKi72esxW8GFfsDTgzENhCBrbxmzemgXncVzJTKp1+9K9g/jCJ/wTXUIjzfmfwQ7R29aDWJkfIA==
Received: from HK2APC01FT044.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::42) by
 HK2APC01HT011.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::138)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 12:19:25 +0000
Received: from MEYP282MB1576.AUSP282.PROD.OUTLOOK.COM (2a01:111:e400:7ebc::53)
 by HK2APC01FT044.mail.protection.outlook.com
 (2a01:111:e400:7ebc::371) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 12:19:25 +0000
Received: from MEYP282MB1576.AUSP282.PROD.OUTLOOK.COM
 ([fe80::5c7a:715a:58f3:77bd]) by MEYP282MB1576.AUSP282.PROD.OUTLOOK.COM
 ([fe80::5c7a:715a:58f3:77bd%3]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 12:19:25 +0000
From: root artifice <artifice37@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Adding device support in aarch64 virt board
Thread-Topic: Adding device support in aarch64 virt board
Thread-Index: AQHWp5/zMvyzEjfwu0+rq+V/uV90Xg==
Date: Wed, 21 Oct 2020 12:19:25 +0000
Message-ID: <MEYP282MB15766D032B11CCEA0F744A47DF1C0@MEYP282MB1576.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:83AFFEBDF87D71F5E4989B1DF3E11F19C2A5E587B064BDD95880A5BF16ACA44C;
 UpperCasedChecksum:AACA34279BAAC11667F769F45B80B57231D4F16919FA3825096B9AEF2D7FBF95;
 SizeAsReceived:6627; Count:41
x-tmn: [qqHvykxMGQMU3q4NdpAjamIJIF04JNzc]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 2eb2b4ca-8f71-446d-6c34-08d875bb8cea
x-ms-traffictypediagnostic: HK2APC01HT011:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPZdf6K+6hhjMp5XjnM09/rQBKhTYV2J0fkOxvg9NM86E5aeKKXX+9815M/9jGfQlPJLrVhTVGh6UZkHR17vYpQ25W3Hi4/uDQWxts8ByqVS+2VAtZZ1EzRQ+AVzB99VMkymcAB4pq5COhXWFyiXyT99wqeBndOW+MyVVOardf4/gUO1t2vC9UGh1dX23azFs899YwMt60Vy8YwzfDlUzA==
x-ms-exchange-antispam-messagedata: nh5gdkXk8m34VS8JsNjSpXPOsPJjpfntpEFX5XLjLzP1BLe8rK0BzvzVTBkHA2kraXBvTj6bURRxItBZH5/fGPwhC4TFrOhzfk0kPnMvatfMupwkadHnI2fAUr7kEh9o8SgMcGW51r6lla9eQzN4Bw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_MEYP282MB15766D032B11CCEA0F744A47DF1C0MEYP282MB1576AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT044.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb2b4ca-8f71-446d-6c34-08d875bb8cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 12:19:25.5651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT011
Received-SPF: pass client-ip=40.92.255.54; envelope-from=artifice37@outlook.com;
 helo=APC01-HK2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 08:34:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

--_000_MEYP282MB15766D032B11CCEA0F744A47DF1C0MEYP282MB1576AUSP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=92d like to add I2C support for aarch64 virt board. So I modified hw/arm/=
virt.c as follows.


  1.  Add [VIRT_I2C] =3D { 0x09100000, 0x00001000 } entry in base_memmap to=
 define a memory region
  2.  Use the following to emulate a I2C device

dev =3D sysbus_create_simple(TYPE_VERSATILE_I2C, vms->memmap[VIRT_I2C].base=
, NULL);

i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");

i2c_slave_create_simple(i2c, "sii9022", 0x39);

  1.  Use the following to add device tree file entry

nodename =3D g_strdup_printf("/i2c@%" PRIx64, base);

qemu_fdt_add_subnode(vms->fdt, nodename);

qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "arm,versatile-i2=
c");

qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg", 1, base, 1, size);

After modification, QEMU can compile successfully. However, when I run it (=
qemu-system-aarch64 -M virt -m 2048 -cpu cortex-a53 -kernel ./Image -nograp=
hic -hda rootfs.ext2 --append "root=3D/dev/vda"), I got the following error=
:

  *   qemu-system-aarch64: qemu-5.1.0/softmmu/memory.c:2388: memory_region_=
add_subregion_common: Assertion `!subregion->container' failed

The assertion exists in qemu-5.1.0\softmmu\memory.c: memory_region_add_subr=
egion_common() and is triggered by dev =3D sysbus_create_simple(TYPE_VERSAT=
ILE_I2C, vms->memmap[VIRT_I2C].base, NULL);. I think it means I=92m using a=
 memory region that has been used. But I think the memory region in base_me=
map I=92ve chosen is available. Besides, the assertion =93subregion->contai=
ner=94 is derived from dev =3D qdev_new(name) (located in hw/core/sysbus.c)=
, which I have no control over when calling sysbus_create_simple(). Could s=
omeone tell me which part is wrong?

Any help is appreciated. Thanks in advance.

Regards,
Weiqi

--_000_MEYP282MB15766D032B11CCEA0F744A47DF1C0MEYP282MB1576AUSP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:DengXian;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:DengXian;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1244534596;
	mso-list-type:hybrid;
	mso-list-template-ids:-1972970140 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1483157133;
	mso-list-type:hybrid;
	mso-list-template-ids:1153339524 -1 67698713 67698715 67698703 67698713 67=
698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style>
</head>
<body lang=3D"ZH-CN">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I=92d like to add I2C support f=
or aarch64 virt board. So I modified hw/arm/virt.c as follows.</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 =
lfo1"><span lang=3D"EN-US">Add [VIRT_I2C] =3D { 0x09100000, 0x00001000 } en=
try in base_memmap to define a memory region</span></li><li class=3D"MsoLis=
tParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 lfo1"><span lang=3D=
"EN-US">Use the following to emulate a I2C device</span></li></ol>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">dev =3D sysbus_create_si=
mple(TYPE_VERSATILE_I2C, vms-&gt;memmap[VIRT_I2C].base, NULL);</span></p>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">i2c =3D (I2CBus *)qdev_g=
et_child_bus(dev, &quot;i2c&quot;);</span></p>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">i2c_slave_create_simple(=
i2c, &quot;sii9022&quot;, 0x39);</span></p>
<ol style=3D"margin-top:0cm" start=3D"3" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 =
lfo1"><span lang=3D"EN-US">Use the following to add device tree file entry<=
/span></li></ol>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">nodename =3D g_strdup_pr=
intf(&quot;/i2c@%&quot; PRIx64, base);</span></p>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">qemu_fdt_add_subnode(vms=
-&gt;fdt, nodename);</span></p>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">qemu_fdt_setprop_string(=
vms-&gt;fdt, nodename, &quot;compatible&quot;, &quot;arm,versatile-i2c&quot=
;);</span></p>
<p class=3D"MsoListParagraph"><span lang=3D"EN-US">qemu_fdt_setprop_sized_c=
ells(vms-&gt;fdt, nodename, &quot;reg&quot;, 1, base, 1, size);</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">After modification, QEMU can co=
mpile successfully. However, when I run it (qemu-system-aarch64 -M virt -m =
2048 -cpu cortex-a53 -kernel ./Image -nographic -hda rootfs.ext2 --append &=
quot;root=3D/dev/vda&quot;), I got the following
 error:</span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo2"><span lang=3D"EN-US">qemu-system-aarch64: qemu-5.1.0/softmmu/memory.c=
:2388: memory_region_add_subregion_common: Assertion `!subregion-&gt;contai=
ner' failed</span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The assertion exists in qemu-5.=
1.0\softmmu\memory.c: memory_region_add_subregion_common() and is triggered=
 by dev =3D sysbus_create_simple(TYPE_VERSATILE_I2C, vms-&gt;memmap[VIRT_I2=
C].base, NULL);. I think it means I=92m using
 a memory region that has been used. But I think the memory region in base_=
memap I=92ve chosen is available. Besides, the assertion =93subregion-&gt;c=
ontainer=94 is derived from dev =3D qdev_new(name) (located in hw/core/sysb=
us.c), which I have no control over when calling
 sysbus_create_simple(). Could someone tell me which part is wrong?</span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Any help is appreciated. Thanks=
 in advance.</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Regards,<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Weiq=
i<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_MEYP282MB15766D032B11CCEA0F744A47DF1C0MEYP282MB1576AUSP_--

