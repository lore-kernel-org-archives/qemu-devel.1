Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA9C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5340D2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GIuTOwgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5340D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Je4-0000oZ-Cq
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 14:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j6JdO-0000MH-VX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j6JdM-0005xq-VY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:43:18 -0500
Received: from mail-bn8nam11on2098.outbound.protection.outlook.com
 ([40.107.236.98]:35808 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j6JdM-0005x5-MT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:43:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfZvCu8J8AwELT78T1oHeSSqWeHky3PhroJiqPaxAaBDvBNYGtOvPqchERJ0Ov8H4OsEmRTLkGSoqZ0GWrqOJFt450JIZRxGfjz8SxYkcAGgzWm60LOPWzSN9i4M/3fzDApr9k7aTuoUGSlF1iU1XKfzto9zTJE0gyC2mKslUjfspt0zQe9mG5ecd8luLDpH0NQmWQOJZiwri39oEJzB9hKc6ZuswWFYMUVcYvDMwuJBPP13lVO8lold9AurFeNvvhQq34zRKuuXeq2RTJw0cFFQWwza0gemLFNdZyPqutwB0jMx9q78nJs7TWQlTQsjZdPBxI/wKLGxF9QcpKAWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHzTyMDEzMrVm4dY8vGZdsyzWQLZHISsnr6rZmlJk9s=;
 b=VkfrU+f+RNPd/EF4Ij9LyPRbh9YXFKfwBjA9jzav3jGUc5ejf6gMPRwqOthOHnjpfGYyUGcc+9wRhy0D4KiNxl0N2v2hNoWXaSYExtQWWO4x+YtIS9DeuTnQaaUWV0PlKwYSJeIS/EPs/bMmwW5xDzDFrfc6EcdIK5ybDcMYN/YZ/DSRDrzVVAyaYQKshNEBqUCxyq8X1GQTn8FWnzTi4oWqcI7wEXS+5mIW/PCHjg+iRtG+MhnJ+XG4sduo4kkrFTJiYVdTem7i0LDUDxIlp9UjexSI4l6e/AZwMjkraayFMI1DwSeulJ/1mcuzbjcJ0epfqeEc8cxw71GDXdot9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHzTyMDEzMrVm4dY8vGZdsyzWQLZHISsnr6rZmlJk9s=;
 b=GIuTOwgusLr+on+5ZCBSvS9qRmWRbKO6to9dHVsyZaJWPm1rGa/nOwmvSmmfOEQpxRvaZb3+Isr4WRi5gEAtgGS/9AQXcxqM+Sk543T68EmPihD3VYfNx6J1Nl8/OE2wZGVCl93Et57MHMSe3KDQlqV3jgys73/iBlAbvzc97CE=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0736.namprd21.prod.outlook.com
 (2603:10b6:803:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.14; Mon, 24 Feb
 2020 19:43:14 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%9]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 19:43:14 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Stefan Weil <sw@weilnetz.de>, "Justin Terry (SF)" <juterry@microsoft.com>, 
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eduardo
 Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
Thread-Topic: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
Thread-Index: AdXmmxkvbI0n3XG6RKSCtw/4QRCyRQAAgE9wABh4YAAAD08KsABT+sQAAK9KW5A=
Date: Mon, 24 Feb 2020 19:43:14 +0000
Message-ID: <SN4PR2101MB08803B0317F0F5314535136CC0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
 <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
 <BN8PR21MB12974CEDAEC173FC8CD626DFB6100@BN8PR21MB1297.namprd21.prod.outlook.com>
 <6b5c046a-af4b-8adf-e3a2-64d904c9ff16@weilnetz.de>
In-Reply-To: <6b5c046a-af4b-8adf-e3a2-64d904c9ff16@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:5493:668f:681d:c7d6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87b7dd10-ea73-46ff-286f-08d7b961c9f8
x-ms-traffictypediagnostic: SN4PR2101MB0736:|SN4PR2101MB0736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB07366D98AB40E5EC588A3EEDC0EC0@SN4PR2101MB0736.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(9686003)(110136005)(5660300002)(6506007)(10290500003)(55016002)(8676002)(8990500004)(86362001)(53546011)(2906002)(52536014)(478600001)(66946007)(66556008)(66446008)(4326008)(33656002)(7696005)(8936002)(4744005)(64756008)(316002)(71200400001)(186003)(76116006)(81156014)(81166006)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0736;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4+2vylZk0/IsGIKic0DWgU+PTpxrXaXkhjgUj8VOihIbTlCHc5hJHT0tHDtnG41jooJEH4h5PfUacy93y9xAlFuyyfRBgXewBp2mwrwHrA1ogq+TGhDS5JC057l6ftjU+xIP8f0ze+bvVyLAeA8glatf4z4+q8a6UrFWG2sJDprUk0tzzI4pX5PBICZ5AWcXggGIn7lXecCc/yMqO2aLXM44Lf2MMnXpRPLy07itbc9bewjIKZGPDh3TRFPyOqEnUlc2HkkYj72kSUSswCC45Qr8oqoiIGhWfCfOiDvn06XK2sp3kidd+PCsEaIl9fTqiD76hYEfPfF99IUoiGYiXc0Qkeog2WwmfamfO4/W6psmqBvNqTiF/5GjoLVRWvmlEQn0H8XF2vp6DBimJpMQ5UdTA4Xbn3L1epIwPWRpzIrhN78TFQvY+uEKrTlVadZ
x-ms-exchange-antispam-messagedata: HZPBnHA5TghyGLLDAJtU5aZPBV4Rnj5NqiqGAUZKU4bhwvxOs8ZSWXqUY7Pq2wYZLeNS/rZ1Mgh0foIRO/fe9jTS3Cd47OW1/mDtLwUzD8RIccWpb5oFoxbTf35T0e4PW2odQL+q9sa//nGSjvRigm3FarTzfhp2itU1y9HhZjvalrBfPABlazdy+jMkgmVJixaCd2v/OrvpfWIwEVTtGA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b7dd10-ea73-46ff-286f-08d7b961c9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:43:14.6355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpmM4720Im5TKvRTL1vOTRP+RX/JlD9c/N27xuB+oKAaRYpT5zMiRuy3DUgfqq927dkbWUFCtugK064P99vA7Nik7MVv3yhqlfoDFVvenjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0736
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.98
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gV2VpbCA8c3dAd2Vp
bG5ldHouZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMCwgMjAyMCAxMTo1NCBQTQ0K
PiBUbzogSnVzdGluIFRlcnJ5IChTRikgPGp1dGVycnlAbWljcm9zb2Z0LmNvbT47IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IFN1bmlsIE11dGh1c3dhbXkNCj4g
PHN1bmlsbXV0QG1pY3Jvc29mdC5jb20+OyBFZHVhcmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhh
dC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUmljaGFyZCBIZW5k
ZXJzb24NCj4gPHJ0aEB0d2lkZGxlLm5ldD4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0K
PiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBXSFBYOiBBc3NpZ25pbmcgbWFp
bnRhaW5lciBmb3IgV2luZG93cyBIeXBlcnZpc29yIFBsYXRmb3JtDQo+IA0KPiBBbSAxOS4wMi4y
MCB1bSAxNjo1MCBzY2hyaWViIEp1c3RpbiBUZXJyeSAoU0YpOg0KPiANCj4gDQo+IEhlbGxvIEp1
c3RpbiwgaGVsbG8gU3VuaWwsDQo+IA0KPiBqdXN0IGEgcmVtaW5kZXI6IHdlIHN0aWxsIGhhdmUg
dGhlIHByb2JsZW0gd2l0aCB0aGUgcHJvcHJpZXRhcnkgbGljZW5zZQ0KPiBmb3IgdGhlIHJlcXVp
cmVkIE1pY3Jvc29mdCBoZWFkZXIgZmlsZXMuDQo+IA0KPiBDYW4geW91IGVzdGltYXRlIHdoZW4g
dGhpcyB3aWxsIGJlIHNvbHZlZD8NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLCBTdGVm
YW4uIFllcywgYWdyZWVkIHRoaXMgcHJvYmxlbSBzdGlsbCBleGlzdHMuIFdlIGZvbGxvd2VkIHVw
IHdpdGgNCnRoZSBTREsgdGVhbSBhbmQgdGhlIGxlZ2FsIHRlYW0gZW5kIG9mIGxhc3QgeWVhci4g
SSB3aWxsIG51ZGdlIHRoZW0gYWdhaW4gZm9yIGFuIHVwZGF0ZQ0KaGVyZS4NCg0KPiBSZWdhcmRz
LA0KPiBTdGVmYW4NCj4gDQoNCg==

