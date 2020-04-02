Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B101C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D401920737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hVaVrPbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D401920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK35P-0001TS-Tw
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 12:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robhenry@microsoft.com>) id 1jK34k-0000xU-6D
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robhenry@microsoft.com>) id 1jK34i-00025Z-AN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:52:17 -0400
Received: from mail-bn8nam11on2119.outbound.protection.outlook.com
 ([40.107.236.119]:37600 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robhenry@microsoft.com>)
 id 1jK34i-00025E-02
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:52:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onw//nCVEPsBheAxVcBFJqS9zs7fnkoH3dqrsWvOK5fy0WdK77JeQe17NcCeODIna1FJJdn6Z3v5ZOdx+vk6+XXyas07Zg3AMg4oar6BnvK381xi3XUwLUaOCfTNuGNEVxZC/xneffd/lrYWIr4BucfzP/YRcSaCei3EwDSH5dWfXcIIjf4BncaFAzAtK6QrDpjWg0XXO4R4FwWBW/fWa5+pkdh14ODwqKVt+4qesA3vY07bsRvdv75iNvN9mVoct1c0x7luqa26tgXLiMqxV/HfM8B0Ws2epccDGylG03gRQRoEvH+f+wLCcD0hymVl3voaueFqlppvP2X5ZKlnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d2Bcn04oG/wiT2RKr8ViXByyCGrsIpS2xKc8jS6wVQ=;
 b=EAgIxZZj4+gGErEsC1hqSeubm5RarM0KWWLxgD62BwGGLLgO+yGVGQtMPO6zfbi8SA/7EYXZUGvyU+z1kpjpsGcYRAYmmfYEYlnGxuX2oTVSXjOoDYk/t122yguEEmWjth9l2GaXytQ/OxdBHgaH9bxY9k4sjLYuBUC4GndxVf8fDQL7y/qt0A46h61wgV3xTpNjDDewm6VarFZhVVCqewlhPIBVVdK96olmf0aP14Cd4r2qjTOha7Eh0jwQY7D4IPX9ljANiUKwFNvS+SDaP0T6Z0DIbiEtxFE8zA385OYuOod+UTwR9h2l7GJw7lBt6Qu5mZbyj0zL+VQNmjm5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d2Bcn04oG/wiT2RKr8ViXByyCGrsIpS2xKc8jS6wVQ=;
 b=hVaVrPbSJGh61pdgrMZ04Wq6vq90stlDHsyvH5ybkeiCXosMYiLI9WnbqpQf9kId+j8FU+Ni0SeM9HdJQZ4SpKe7AeWXxyqrv95+xUKnQYB+syhP8e0T8Vux/Yowm0swO6vwQ1EXz2oxnlvX7y0xWyKTsFFB6YeR7HSRPm0ji8g=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 (2603:10b6:207:30::21) by BL0PR2101MB0977.namprd21.prod.outlook.com
 (2603:10b6:207:30::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Thu, 2 Apr
 2020 16:52:14 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::5c9a:ca6b:dbfb:80d]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::5c9a:ca6b:dbfb:80d%9]) with mapi id 15.20.2900.002; Thu, 2 Apr 2020
 16:52:14 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: qemu plugin exposure of register addresses
Thread-Topic: qemu plugin exposure of register addresses
Thread-Index: AQHWCQ3ZMo4LeccLW0mNad9chZRv5Q==
Date: Thu, 2 Apr 2020 16:52:14 +0000
Message-ID: <BL0PR2101MB1026B7A4C994BE826CF95DFFD6C60@BL0PR2101MB1026.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-02T16:52:13.479Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robhenry@microsoft.com; 
x-originating-ip: [97.113.134.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebc0a226-171c-4705-5449-08d7d7263208
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB0977EBB01E467C8838215C72D6C60@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR2101MB1026.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(316002)(8990500004)(19627405001)(52536014)(66556008)(66476007)(66946007)(71200400001)(66446008)(64756008)(55016002)(26005)(7696005)(186003)(33656002)(76116006)(86362001)(9686003)(2906002)(478600001)(82960400001)(82950400001)(10290500003)(8936002)(6916009)(6506007)(81156014)(81166006)(5660300002)(8676002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNZRZEsDIfOb2tpSrwFd2mBwQgeh/uzm0wS8GKLp68VTm7xQg9NQ5+qQNJw/K0QFrhIayqONd9ev6AVxQKAoY7q6l2oMdvzrrMWRn6bIluFPv0bvaPchGgp+rKGrLJk8HrgRoSvV4pHw26Ze1bysJcLB4wy6pWLY4fgqFb5FJ7nZ1foNi8IXFVDiFJbWs9Jxgy98jIiQ5+8srvIO8NULjHxL2F41uP0lHSt7ABckR6POcHMnKWMjiLkh9JFJITdHe22uHu1EBPe+TAq9T2n9+YvxugxGHkcLm4MLoBYw6PcPgE0XZArvJw5tF1J966vP/GxiTN4wJd3zIiMk7A/vaHuxDwqUB0eF5/cbxbGAJW1rOl8v0A8kxW4I77GS8p6ofHxpX+d9BnssPJ0syOeGZo3cWMMA720ef3VTIeM1JA7CLPsQh1g64QtHXORxgR8y
x-ms-exchange-antispam-messagedata: BdBrey4TXK7gs1nzzt/dG4n5xdackKcBqV77t64ATb0JHo7GDX3vDW01GFqiomFqjo7PhUnLrheVrZ68bCtKDBkELMrOXsamVYmtKToA5OuvtTkEeU/g8VKGRBdHAUdadVs9n92q+iG3eNEX6ZQPoQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026B7A4C994BE826CF95DFFD6C60BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc0a226-171c-4705-5449-08d7d7263208
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 16:52:14.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TBz+EY/Rc7QPFHTWHCdDXVolt2oruJzbQ5SExJQaEnQKvtl/18CaPtVDG/rjoACVGTwNz7zmA5e2XAW4ghNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.119
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

--_000_BL0PR2101MB1026B7A4C994BE826CF95DFFD6C60BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There is now a qemu plugin interface function qemu_plugin_register_vcpu_mem=
_cb which registers a plugin-side callback. This callback is later invoked =
at the start of each emulated instruction, and it receives information abou=
t memory addresses and read/write indicators.

I'm wondering how hard it is to add a similar callback to expose register a=
ddresses and read/write indicators.  For example, executing `add r3, r1, $1=
` would generate two callbacks, one {write r3} and the other {read r1}. I'd=
 like this for all kinds of registers such as simd regs, and, gulp, flags r=
egisters.

With this information ISA simulators could examine the data flow graph and =
register dependencies.

I'm not asking for register contents; we don't get memory contents either!

I gather there is some concern about exposing too much functionality to the=
 plugin API, as a plugin might then be used to subvert some aspects of the =
GPL.  I don't understand the details of this concern, nor know where the "l=
ine in the sand" is.

Robert Henry

--_000_BL0PR2101MB1026B7A4C994BE826CF95DFFD6C60BL0PR2101MB1026_
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
: 12pt; color: rgb(0, 0, 0);">
There is now a qemu plugin interface function qemu_plugin_register_vcpu_mem=
_cb which registers a plugin-side callback. This callback is later invoked =
at the start of each emulated instruction, and it receives information abou=
t memory addresses and read/write
 indicators.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm wondering how hard it is to add a similar callback to expose register a=
ddresses and read/write indicators.&nbsp; For example, executing `add r3, r=
1, $1` would generate two callbacks, one {write r3} and the other {read r1}=
. I'd like this for all kinds of registers
 such as simd regs, and, gulp, flags registers.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
With this information ISA simulators could examine the data flow graph and =
register dependencies.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm not asking for register contents; we don't get memory contents either!<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I gather there is some concern about exposing too much functionality to the=
 plugin API, as a plugin might then be used to subvert some aspects of the =
GPL.&nbsp; I don't understand the details of this concern, nor know where t=
he &quot;line in the sand&quot; is.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Robert Henry</div>
</body>
</html>

--_000_BL0PR2101MB1026B7A4C994BE826CF95DFFD6C60BL0PR2101MB1026_--

