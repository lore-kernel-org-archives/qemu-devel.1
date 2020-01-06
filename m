Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCC5C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7E3206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iYpS8OKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7E3206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iob5Q-0005Ku-Dt
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 17:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robhenry@microsoft.com>) id 1iob4H-00049q-Lu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robhenry@microsoft.com>) id 1iob4F-0001uw-Sc
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:41:48 -0500
Received: from mail-bn8nam11on2103.outbound.protection.outlook.com
 ([40.107.236.103]:28384 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robhenry@microsoft.com>)
 id 1iob4E-0001sl-5X
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:41:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo8INExEPYDG/shaefzbZ6cnAWCYsbkWg34qgKkKwgr/IVFhx+llugvnJt/q+ayqy2ZMGS/5erqUaFykdu9HhT+0pqbuAkMu7vG10ArqpZjwva0BlT9taQR4cVKTMHCLgEv/9dWBEMuf/6muDCJTijfIzFwcB5wcZiEzB7rzD6zbz/NiBdei5C3PIoUSZKAVy8BqyPVpDYrihdo1jd6IvvzAElubjjwHtNSKGebWBy7RJ606MbhQ3r+/xvCULVYZk+ALDtQ1gxkMzqaGvLkopfn+LEVz3wsiRA4UNXKBEWulE/2zMI1vqCs6vAzW/FmA8qLbihk/5flsGfO9+a6btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTItsxBAKw6B6aHxAkoJLGZaOe8p63nAa19WK4y3zFU=;
 b=C1/9cGqVR+hzVl7hHH39XPm4WbJhVKGy2t1pd1PnB/yLPctKjfZDrn0M+cSHFgEaSbzWHngICWmksZSfMCAvTSEKUKf+OgfkKb+gA9AwgHVMWvUp/J5e5Xyy70uhj8WlpBE+Cp/20qdmre6+CwGEin7fH7A9KdGNgTsZtAIO/ZdZBkvsKxcMTIzijEhWY/sgPIdEAXZCTnshtm1hNbu8B8/SF9UECmmJ7R8+UNSDni9QdHc6hCkAAUf2gDFw3v0BU7/qil0g5n6vQlHdQmO/Ru1qHeseqsQgbadXyjPgHc4saOjuM/ju551xXTNKtvEtk0NbK6JEc9GSf0mEukX18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTItsxBAKw6B6aHxAkoJLGZaOe8p63nAa19WK4y3zFU=;
 b=iYpS8OKXsVXeLX7N+xa5v9GEjPAMivVX6mQxkj299ShwmXpoNWmrlfVlKEtfROKCQZgKR/emYCYzjsv5kp93qK9W5T2g0BNJg6Cd2RtOwG31bUQYu7mMmFsgU5uyZ4NzmEbNiU9YOOUPbH9Ga2rXbXVGJfAnvPaybSADqTetjkk=
Received: from MW2PR2101MB1035.namprd21.prod.outlook.com (52.132.149.11) by
 MW2PR2101MB1097.namprd21.prod.outlook.com (52.132.149.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.3; Mon, 6 Jan 2020 22:41:43 +0000
Received: from MW2PR2101MB1035.namprd21.prod.outlook.com
 ([fe80::74ad:3459:4b02:2885]) by MW2PR2101MB1035.namprd21.prod.outlook.com
 ([fe80::74ad:3459:4b02:2885%7]) with mapi id 15.20.2623.008; Mon, 6 Jan 2020
 22:41:43 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: plugin order of registration and order of callback
Thread-Topic: plugin order of registration and order of callback
Thread-Index: AQHVxNseQXzc8CYKGkq6l1Nhoyx0Vw==
Date: Mon, 6 Jan 2020 22:41:43 +0000
Message-ID: <MW2PR2101MB1035A21608E50D68EE1CF890D63C0@MW2PR2101MB1035.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-06T22:41:43.696Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robhenry@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:c045:c765:32e8:996e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cf0cfbc-238a-4f68-8ed7-08d792f99ae8
x-ms-traffictypediagnostic: MW2PR2101MB1097:
x-microsoft-antispam-prvs: <MW2PR2101MB1097AB29539F9B82DAA5CF7CD63C0@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(316002)(33656002)(9686003)(55016002)(86362001)(4744005)(8936002)(5660300002)(19627405001)(52536014)(71200400001)(6916009)(7696005)(186003)(10290500003)(66946007)(8990500004)(2906002)(66476007)(6506007)(66556008)(66446008)(81166006)(81156014)(64756008)(478600001)(76116006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1097;
 H:MW2PR2101MB1035.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bVVZbbws3DcKbfNZL9mjWvrFVLIcRMF9Y5KphEIrN6oUqbp81U2rzy3qU0ImbQ4e52VGQCix1PtLGFw2lSok2SZNrmTbusUmoaoxuq09XWYzzZmnC560Dyst0cE9gAMo5J5rHGeAz2+WKZbELSktJMu66W1Q31bQBhz4FPfrArzJzN78J9QCnhEJtKL1d3efqHAMGlscGRs1I3kSeUQNyn4/vT8mJ2eZ3SqFwiJA3UuiVBbPWZ6lESDqnLckkaAE3rPGUGh2/X3KJyfv19SuCn/fAcYA1IiMmqUtw+ZLhauZqFFUxT7yVNJ05hKLMjFJQqM1gv9zeqpKlfhKpMawamVGN676yV8CvY9M7b2JOx+Sc+1ry8jHSmtzk3z248Ye2tiR3N2lrrmSnjy4jh3DRIHIJTAA7Lv9ra5AemwWDMFJNfZg/uS/dKvXhiLrmwo
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_MW2PR2101MB1035A21608E50D68EE1CF890D63C0MW2PR2101MB1035_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf0cfbc-238a-4f68-8ed7-08d792f99ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 22:41:43.8329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: La/V1k2nHnWw745ucQat5rJim6r7tG9CTb4FXe8RngxRRd2HerDAiaD9LMSjn2aTHZ0LPX64RD0jhz8dUEFcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.103
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

--_000_MW2PR2101MB1035A21608E50D68EE1CF890D63C0MW2PR2101MB1035_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The documentation on the new plugin capabilities of qemu is silent about th=
e order call back registration should be done, and is also silent on the or=
der in which call backs are fired.

Case in point: The callback registered by qemu_plugin_register_vcpu_mem_cb =
is called after the call back registered by qemu_plugin_register_vcpu_insn_=
exec_cb, regardless of the order of registration.

However, I'd like to have the insn_exec_cb called after the mem_cb so that =
I can save the mem information to be consumed by the insn callback.


--_000_MW2PR2101MB1035A21608E50D68EE1CF890D63C0MW2PR2101MB1035_
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
The documentation on the new plugin capabilities of qemu is silent about th=
e order call back registration should be done, and is also silent on the or=
der in which call backs are fired.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Case in point: The callback registered by qemu_plugin_register_vcpu_mem_cb =
is called after the call back registered by qemu_plugin_register_vcpu_insn_=
exec_cb, regardless of the order of registration.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
However, I'd like to have the insn_exec_cb called after the mem_cb so that =
I can save the mem information to be consumed by the insn callback.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_MW2PR2101MB1035A21608E50D68EE1CF890D63C0MW2PR2101MB1035_--

