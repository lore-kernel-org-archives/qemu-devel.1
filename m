Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F1B206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LRBR3AKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F1B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejCi-00061d-9l
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1jejC8-0005Yo-CE
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:53:24 -0400
Received: from mail-mw2nam10on2115.outbound.protection.outlook.com
 ([40.107.94.115]:18133 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1jejC6-0001Zq-Iz
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSAFQmwCLvawP5EaW9eiO3s6xlGfN+R2N7mvr85KBfrXGL8pXhpuvCsWzx1VJ5Vax3FlmMAAYG0tfPc4q71hK0UPUD0SuQ7cbA/SRlWOLN23nZik00CK5lQejjc+XFK9E3CcdblgtVEE0rOQizhA1YZWVX7ViKak5QBu3Y8tMogtS73vUWkO92yo2Q+znDiowRqzXM1dRWswu09++YBDBTazl8J05CakNCdzqk8oFLN/FLSu/9u1T6KQVW1n+Y66C9jxt7gd6p7jRN9qNJBGoLLSMgsJkqDYUhncXzLZKyoyCbCMh7335BEeaDC9/6LPbWAVKAMeH2aC//cVUmwgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHTb8T414BP8bU3c1l8yTtGSo+1yRnJeoI5XnLhRcj4=;
 b=Tzemndqktdmxclf+lQblNrDzmNxexBRbrUURfAzRMnbu1QwkMvLWJWLms5cjoz95oF4ph6Iu9w77KPIDYckIX2wRwK7s0W7WSac2vCLU5Ju8qwYz8zqHdjcbFXpXgEgFlrKdkryo5Pm40ntzeMtA1NlXho4LTf1ktMEbaruijMqImQls0pJGyOFk/Le0+i4byZwmu0dtCTcNLfwGj7YsHuORuwI80hvXmBSwA0wL3wxKlKvEguFIQ8wx5BFhaNYCcavZVjKjibF7o3bmPfNg1PH2swgPQeH9vFxY25HshKA96AFxqlObmaJrtQ5EZhS2YI8wPKZc1H468yljOHuZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHTb8T414BP8bU3c1l8yTtGSo+1yRnJeoI5XnLhRcj4=;
 b=LRBR3AKkMVwapB7LUmY7BMJRzn61NmB3q/ikI9RFtilCbB6tbDfO+nOVQQ52ThrBQTcK8Wugmg+WzSu7YjYfpxJkgRAjVY6gX2ucpptilCKeS69LQxbpfvF+ZRCC7Kwpy86kxXICiHqKKTKMrLH/X+VPoV04y5jLHssJvLD4dD8=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 (2603:10b6:207:30::21) by BL0PR2101MB1090.namprd21.prod.outlook.com
 (2603:10b6:207:37::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.3; Fri, 29 May
 2020 17:38:18 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::bc6a:97fa:9127:9fc6]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::bc6a:97fa:9127:9fc6%4]) with mapi id 15.20.3066.007; Fri, 29 May 2020
 17:38:18 +0000
From: Robert Henry <robhenry@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: ia-32/ia-64 fxsave64 instruction behavior when saving mmx
Thread-Topic: ia-32/ia-64 fxsave64 instruction behavior when saving mmx
Thread-Index: AQHWNd5quifUeAt/N0utXBrhr3uc7Q==
Date: Fri, 29 May 2020 17:38:18 +0000
Message-ID: <BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-29T17:38:17.597Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [97.126.3.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09f1abf6-cfd3-4d0c-6b00-08d803f712f1
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB109023B57DF0798C0680E450D68F0@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D5xO0mS//iAEed/odRZkBmQDcbbTUwVC9tRiD21NypHcg8m9+o1MquTRU47CsuX6BJ0ProAQNu5rO2Rf5NSC5goGj6UX0YVVFhq563FExt2z8gsZzwPJfuydN7PRPGkE9Ds9yZz6rzVWuMS6FEkg2eh1U/FjEzVEvdkCO8js3rMKEb2JWZECzNmUOUsg2HzPtLCUUQCIvohqyirN5GZwF6gxJjV2jqVxIBuvgF/kNA4fmwfOClfB919ZweL4o7+zkNoZd5jXWKTWrBHmqPdnrtdF0+NyZyNe8p6e4m+vTpPg5NrX6cErP97Eoops2M2bItpenazP4o/ul2ttFRAAe/HP7eLizcYeM7oYIY89GAfX1YgS0GgCPl8j17pJVvmQ3+CxsHXtbHKSaiY2BfrsIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR2101MB1026.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(166002)(26005)(8936002)(33656002)(478600001)(8676002)(186003)(10290500003)(5660300002)(19627405001)(6506007)(2906002)(966005)(82950400001)(82960400001)(8990500004)(66946007)(66446008)(6916009)(55016002)(71200400001)(64756008)(316002)(7696005)(66476007)(9686003)(52536014)(76116006)(86362001)(4744005)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: qKgTk0JjO0hj7wZ1gNvj6KUb4fypmuBG4I2fXFNYG9XaYX8rsap2zhgEaXOQIMbyDhOHLrFOlvgexLkXVgx5y9IRXTC9v+n7uaxsm7z5fyWHY9OtVwq2oVw5aVl+ELsxYZpujjX3IZjvg+Hy29QmYYVJdAfvw9H+zuu2b3+svnRhiKaZe6QV5CMFRWED77mw74/t3Am0IuZq9KpP5pzly4OfXn1Xq/GJPvSkv5BJQ30C0zqkNPewdiuEJTO5LctZDnmzS2YOTqZW6LtBbwP6iU5Zdv0+v0wiog5z6WlRAlgzj4JD/RTa0jCrzEqRii0P1bRpTmQYI6DB3WIXdu0GUktjFx0QY2c99XGjBB2BdAJH5sF8KplKLgyiwGBs5SIdBNys4fmX9fMMYiW4+rDnsivW6A0E01zMHJJyp683hu0ItGWQoAKkbailcf7IT09qHA1ZHiDn2LvFe9DZEDPWOGrAtlqWunZnI+AEsL4vVbs=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f1abf6-cfd3-4d0c-6b00-08d803f712f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 17:38:18.0773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yckb4GvGHTkMKYyRQ0Tn88wztdsBPwbCg1LCGyppyOu7PZAbNt7GJkLB9Bcy4UqF/gXu15xWlskE9+NWCi2ieA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Received-SPF: pass client-ip=40.107.94.115;
 envelope-from=robhenry@microsoft.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 13:53:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--_000_BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Background: The ia-32/ia-64 fxsave64 instruction saves fp80 or legacy SSE m=
mx registers. The mmx registers are saved as if they were fp80 values. The =
lower 64 bits of the constructed fp80 value is the mmx register.  The upper=
 16 bits of the constructed fp80 value are reserved; see the last row of ta=
ble 3-44 of https://www.felixcloutier.com/x86/fxsave#tbl-3-44

The Intel core i9-9980XE Skylake metal I have puts 0xffff into these reserv=
ed 16 bits when saving MMX.

QEMU appears to put 0's there.

Does anybody have insight as to what "reserved" really means, or must be, i=
n this case?  I take the verb "reserved" to mean something other than "unde=
fined".

I came across this issue when running the remill instruction test engine.  =
See my issue https://github.com/lifting-bits/remill/issues/423 For better o=
r worse, remill assumes that those bits are 0xffff, not 0x0000


--_000_BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0BL0PR2101MB1026_
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
Background: The ia-32/ia-64 fxsave64 instruction saves fp80 or legacy SSE m=
mx registers. The mmx registers are saved as if they were fp80 values. The =
lower 64 bits of the constructed fp80 value is the mmx register.&nbsp; The =
upper 16 bits of the constructed fp80
 value are reserved; see the last row of table 3-44 of&nbsp;<a href=3D"http=
s://www.felixcloutier.com/x86/fxsave#tbl-3-44" id=3D"LPNoLP231595">https://=
www.felixcloutier.com/x86/fxsave#tbl-3-44</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The Intel core i9-9980XE Skylake metal I have puts 0xffff into these reserv=
ed 16 bits when saving MMX.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
QEMU appears to put 0's there.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does anybody have insight as to what &quot;reserved&quot; really means, or =
must be, in this case?&nbsp; I take the verb &quot;reserved&quot; to mean s=
omething other than &quot;undefined&quot;.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I came across this issue when running the remill instruction test engine.&n=
bsp; See my issue&nbsp;<a href=3D"https://github.com/lifting-bits/remill/is=
sues/423" style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font=
-size: 12pt;">https://github.com/lifting-bits/remill/issues/423</a>&nbsp;Fo=
r
 better or worse, remill assumes that those bits are 0xffff, not 0x0000</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0BL0PR2101MB1026_--

