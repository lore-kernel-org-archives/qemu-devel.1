Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A83C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D9D207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h0IOoe5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9D207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFadY-000401-Np
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kFacy-0003bF-7K
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:13:28 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com
 ([40.107.68.40]:11396 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kFacv-00073x-4Y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:13:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3qk+ifKV0/j7xoXQvvhRkEXa0gzTbhwXBPFaYiKgrApKR8Z174b8RN9XIHjhh5Cuz+OP35wtOx88UEcUaE+bMLKYBCdUvqABMHsCqtW/omVWiAhUcag0wrIxpXZcjQlA9PeTviEiS2I+8si0O4RjFpfLnA1Yw3MbbqD5RiLgugls9GLxMKEP4QGOP7QelxkQb9nB+RzoeNGtOy3DMC0+qQ/oyMobia1T6kLcn//gRYCemh7eXMSnBbTh5flpvZVAhk6bTrxRmS2p52bg55nV5BcT1mFdRA8Z4zcS8hL1AagTpymzBACbAjBXc6hITGoPylfLPxdQq8BFNWNip0wnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWv+dEyEyhxrpdkg8jVTaa/D1M6AcVuKNNE85L0BmvI=;
 b=J+gml2fpS18NBEw/akw/Crr1s1wvx0aEjU+JjMnxJc9hr3m62KxfiNRfW7Msbm/tP/PhzahSEP6Gd8hZyBJmsRqUml+hjLWavtv0VzsfBbWOznIJDag5fQfsEgWmJ47tZzv3PWuQb7u9uFAU7mQRQwKGuXY+HXqUMqovFHByNRqF7+Ams6gDs3Y1/dqUVlfVyOhf44Uga9YMaKFX0qNoc7hrUAzAH8OfjBc7wqChLtLsq0zkIEwQmln2JlmXGJXoIcz4xveRbC4rI+GHj2Hfzn+xfSVdsRhTpiA6k3emQClfRi4TvacI5iULq7hMW1FlDUFUflYUwpFhJ9/wQT7w/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWv+dEyEyhxrpdkg8jVTaa/D1M6AcVuKNNE85L0BmvI=;
 b=h0IOoe5vRIKHQ/8eC5jHU68/IwbswPTGGew/JxsJzoLjqKgagu9WNt9Ki6Vkn2tBOO2bkYYUGghtbgsdeB2ZPJ7TjpKJED6/RWJ7T3tUFppyfhY3Y16nRR/MjDVA9znlG1BBeEgZkxBeEl6fSLCojVt1bXhFmZWb6opooL/1Hz0=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6801.namprd02.prod.outlook.com (2603:10b6:a03:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 09:58:20 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 09:58:20 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Edgar
 Iglesias <edgari@xilinx.com>, Francisco Eduardo Iglesias
 <figlesia@xilinx.com>
Subject: RE: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Thread-Topic: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Thread-Index: AQHWfW+Ua1yvfd0S/EK+NcJs9pMBDKlUAL+AgAqNz+A=
Date: Tue, 8 Sep 2020 09:58:20 +0000
Message-ID: <BY5PR02MB6772B6F211489F7E2A9D5CCDCA290@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
In-Reply-To: <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd2c0bca-c88d-403d-9a69-08d853ddb7a2
x-ms-traffictypediagnostic: BY5PR02MB6801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB68011DCB03FDB7411DB53692CA290@BY5PR02MB6801.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6+nj/8uV7d3A7ghXj8s2IjQIjRTT77Aw6c5/3iKfQOuutankHCGKN8BR8iRfYKkfM870LHErm4MBFEeLM0ZKxix5VYSoWLGcViYza/azej59nGjKWeOaKhVw077cDauoRwqfwql2O/zDlRgX4LPYdIMr3R+SlsmWUuxiKnbgtEaYDrTQjwxABQHbu31RAppndw2Os2gTItfi4O0FtDrCXKEEqBWSupmw/0oRB0YB3RbzreFYJMySq2DUmIBSR0YLJJqKhztDGP68K+H6gx1I7ttBVds4kJw69Oy0Y51Ds0FUZZWxc58XXd+eDLSB57fjSlrnrgsC+4ceTCPGKxfew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(66556008)(55016002)(2906002)(7416002)(478600001)(86362001)(66476007)(26005)(7696005)(52536014)(66446008)(64756008)(8676002)(6506007)(53546011)(83380400001)(316002)(6636002)(33656002)(66946007)(5660300002)(8936002)(76116006)(9686003)(4326008)(186003)(110136005)(71200400001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PMlkyu2AQwzHpxjSPB+TKx/5fNwNd192jFM8hBWHj0kWp0Uy+Vd3HcPATmFdDmWTJRpuYZe2BFv3etS5BxM/FVI90qBbtX8Ja1MBmxYIgobOrrmXIufqIuYjRJ91wxH1Kh67/61XXnZ0Y65priNaPRXfRxjEVhdEyEXXKrzuvTXZURdi7sSLBesIxKwBp/CJ0lsHmK50xmU8Ju8CQZdoYNQ7Ee6aNhs+Uujd2WW7rmCTMRMY3St1KMzjGeG3/WB+xvOhvwcZOluQLObIpLhN1v4/XW+JWxfVMMTc1eaQDo93L2bfSw4tQzCxhXgcKThiERB2AORizorC7IcGsx8rIEe9h3D7EIwykmbatwb74CWwZg+Tcp0EnVVKk2ForEAXxnQhaD3MSbyz1csLX9soxUw1OYtrcEfTguF0fBU2QVBJmFinfgt8eKt0WHA/2BRiXkCenSvD2sONJe1jVWXCx7d2Q4v4U59y0omeLwSqIqj/5nN5IDx85l5IslyLXCMVpr1gqjcJHES8jLEzWKqujy+SzbnH1nU4OpIpOGyqzj1C4Qla3C2ZPyBqZOCeSqCol5PGht1I9Yxht54EQw1TlNokbb6G5S+Jo1Tdo2i9htbOtPsXTlQEPdppGrRQNJDONF2aUBKWT6KHVoedHE6/3g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2c0bca-c88d-403d-9a69-08d853ddb7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 09:58:20.4394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: js+CEHjtHjsB5L/qkSUxTNtp10aQHZFxl3KGDh5sathDQ4kveyX26UFW2psgUIPCXgNw7qOcU4aNd3X51d/XiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6801
Received-SPF: pass client-ip=40.107.68.40; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 06:13:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgMSwgMjAyMCAxMDowNSBQTQ0KPiBUbzogU2FpIFBhdmFuIEJvZGR1IDxzYWlw
YXZhQHhpbGlueC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+OyBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+Ow0KPiAnTWFyYy1BbmRy
w6kgTHVyZWF1JyA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGFvbG8gQm9uemluaQ0K
PiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29t
PjsgRWRnYXINCj4gSWdsZXNpYXMgPGVkZ2FyaUB4aWxpbnguY29tPjsgRnJhbmNpc2NvIEVkdWFy
ZG8gSWdsZXNpYXMNCj4gPGZpZ2xlc2lhQHhpbGlueC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT47DQo+
IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IFlpbmcgRmFuZw0KPiA8ZmFu
Z3lpbmcxQGh1YXdlaS5jb20+OyBWaWtyYW0gR2FyaHdhbCA8Zm51dkB4aWxpbnguY29tPjsgUGF1
bA0KPiBaaW1tZXJtYW4gPHBhdWxkemltQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAxLzddIHVzYi9oY2QteGhjaTogTWFrZSBkbWEgcmVhZC93cml0ZXMgaG9va3MgcGNpDQo+
IGZyZWUNCj4gDQo+IE9uIDgvMjgvMjAgOToxOSBQTSwgU2FpIFBhdmFuIEJvZGR1IHdyb3RlOg0K
PiA+IFRoaXMgcGF0Y2ggc3RhcnRzIG1ha2luZyB0aGUgaGNkLXhoY2kuYyBwY2kgZnJlZSwgYXMg
cGFydCBvZiB0aGlzDQo+ID4gcmVzdHJ1Y3R1cmluZyBkbWEgcmVhZC93cml0ZXMgYXJlIGhhbmRs
ZWQgd2l0aG91dCBwYXNzaW5nIHBjaSBvYmplY3QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
YWkgUGF2YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+
ICBody91c2IvaGNkLXhoY2kuYyB8IDI0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLSAgaHcvdXNi
L2hjZC14aGNpLmggfA0KPiA+IDMgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hj
ZC14aGNpLmMgYi9ody91c2IvaGNkLXhoY2kuYyBpbmRleA0KPiA+IDY3YTE4ZmUuLjI1OTBmN2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvdXNiL2hjZC14aGNpLmMNCj4gPiArKysgYi9ody91c2IvaGNk
LXhoY2kuYw0KPiA+IEBAIC00OTUsNyArNDk1LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHhoY2lf
ZG1hX3JlYWRfdTMycyhYSENJU3RhdGUNCj4gPiAqeGhjaSwgZG1hX2FkZHJfdCBhZGRyLA0KPiA+
DQo+ID4gICAgICBhc3NlcnQoKGxlbiAlIHNpemVvZih1aW50MzJfdCkpID09IDApOw0KPiA+DQo+
ID4gLSAgICBwY2lfZG1hX3JlYWQoUENJX0RFVklDRSh4aGNpKSwgYWRkciwgYnVmLCBsZW4pOw0K
PiA+ICsgICAgZG1hX21lbW9yeV9yZWFkKHhoY2ktPmFzLCBhZGRyLCBidWYsIGxlbik7DQo+ID4N
Cj4gPiAgICAgIGZvciAoaSA9IDA7IGkgPCAobGVuIC8gc2l6ZW9mKHVpbnQzMl90KSk7IGkrKykg
ew0KPiA+ICAgICAgICAgIGJ1ZltpXSA9IGxlMzJfdG9fY3B1KGJ1ZltpXSk7IEBAIC01MTUsNyAr
NTE1LDcgQEAgc3RhdGljDQo+ID4gaW5saW5lIHZvaWQgeGhjaV9kbWFfd3JpdGVfdTMycyhYSENJ
U3RhdGUgKnhoY2ksIGRtYV9hZGRyX3QgYWRkciwNCj4gPiAgICAgIGZvciAoaSA9IDA7IGkgPCBu
OyBpKyspIHsNCj4gPiAgICAgICAgICB0bXBbaV0gPSBjcHVfdG9fbGUzMihidWZbaV0pOw0KPiA+
ICAgICAgfQ0KPiA+IC0gICAgcGNpX2RtYV93cml0ZShQQ0lfREVWSUNFKHhoY2kpLCBhZGRyLCB0
bXAsIGxlbik7DQo+ID4gKyAgICBkbWFfbWVtb3J5X3dyaXRlKHhoY2ktPmFzLCBhZGRyLCB0bXAs
IGxlbik7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgWEhDSVBvcnQgKnhoY2lfbG9va3VwX3Bv
cnQoWEhDSVN0YXRlICp4aGNpLCBzdHJ1Y3QgVVNCUG9ydA0KPiA+ICp1cG9ydCkgQEAgLTY0NCw3
ICs2NDQsNiBAQCBzdGF0aWMgdm9pZCB4aGNpX2RpZShYSENJU3RhdGUgKnhoY2kpDQo+ID4NCj4g
PiAgc3RhdGljIHZvaWQgeGhjaV93cml0ZV9ldmVudChYSENJU3RhdGUgKnhoY2ksIFhIQ0lFdmVu
dCAqZXZlbnQsIGludA0KPiA+IHYpICB7DQo+ID4gLSAgICBQQ0lEZXZpY2UgKnBjaV9kZXYgPSBQ
Q0lfREVWSUNFKHhoY2kpOw0KPiA+ICAgICAgWEhDSUludGVycnVwdGVyICppbnRyID0gJnhoY2kt
PmludHJbdl07DQo+ID4gICAgICBYSENJVFJCIGV2X3RyYjsNCj4gPiAgICAgIGRtYV9hZGRyX3Qg
YWRkcjsNCj4gPiBAQCAtNjYzLDcgKzY2Miw3IEBAIHN0YXRpYyB2b2lkIHhoY2lfd3JpdGVfZXZl
bnQoWEhDSVN0YXRlICp4aGNpLA0KPiBYSENJRXZlbnQgKmV2ZW50LCBpbnQgdikNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2X3RyYi5zdGF0dXMsIGV2X3RyYi5jb250cm9s
KTsNCj4gPg0KPiA+ICAgICAgYWRkciA9IGludHItPmVyX3N0YXJ0ICsgVFJCX1NJWkUqaW50ci0+
ZXJfZXBfaWR4Ow0KPiA+IC0gICAgcGNpX2RtYV93cml0ZShwY2lfZGV2LCBhZGRyLCAmZXZfdHJi
LCBUUkJfU0laRSk7DQo+ID4gKyAgICBkbWFfbWVtb3J5X3dyaXRlKHhoY2ktPmFzLCBhZGRyLCAm
ZXZfdHJiLCBUUkJfU0laRSk7DQo+ID4NCj4gPiAgICAgIGludHItPmVyX2VwX2lkeCsrOw0KPiA+
ICAgICAgaWYgKGludHItPmVyX2VwX2lkeCA+PSBpbnRyLT5lcl9zaXplKSB7IEBAIC03MjAsMTIg
KzcxOSwxMSBAQA0KPiA+IHN0YXRpYyB2b2lkIHhoY2lfcmluZ19pbml0KFhIQ0lTdGF0ZSAqeGhj
aSwgWEhDSVJpbmcgKnJpbmcsICBzdGF0aWMNCj4gPiBUUkJUeXBlIHhoY2lfcmluZ19mZXRjaChY
SENJU3RhdGUgKnhoY2ksIFhIQ0lSaW5nICpyaW5nLCBYSENJVFJCICp0cmIsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90ICphZGRyKSAgew0KPiA+IC0gICAg
UENJRGV2aWNlICpwY2lfZGV2ID0gUENJX0RFVklDRSh4aGNpKTsNCj4gPiAgICAgIHVpbnQzMl90
IGxpbmtfY250ID0gMDsNCj4gPg0KPiA+ICAgICAgd2hpbGUgKDEpIHsNCj4gPiAgICAgICAgICBU
UkJUeXBlIHR5cGU7DQo+ID4gLSAgICAgICAgcGNpX2RtYV9yZWFkKHBjaV9kZXYsIHJpbmctPmRl
cXVldWUsIHRyYiwgVFJCX1NJWkUpOw0KPiA+ICsgICAgICAgIGRtYV9tZW1vcnlfcmVhZCh4aGNp
LT5hcywgcmluZy0+ZGVxdWV1ZSwgdHJiLCBUUkJfU0laRSk7DQo+ID4gICAgICAgICAgdHJiLT5h
ZGRyID0gcmluZy0+ZGVxdWV1ZTsNCj4gPiAgICAgICAgICB0cmItPmNjcyA9IHJpbmctPmNjczsN
Cj4gPiAgICAgICAgICBsZTY0X3RvX2NwdXMoJnRyYi0+cGFyYW1ldGVyKTsgQEAgLTc2Miw3ICs3
NjAsNiBAQCBzdGF0aWMNCj4gPiBUUkJUeXBlIHhoY2lfcmluZ19mZXRjaChYSENJU3RhdGUgKnho
Y2ksIFhIQ0lSaW5nICpyaW5nLCBYSENJVFJCICp0cmIsDQo+ID4NCj4gPiAgc3RhdGljIGludCB4
aGNpX3JpbmdfY2hhaW5fbGVuZ3RoKFhIQ0lTdGF0ZSAqeGhjaSwgY29uc3QgWEhDSVJpbmcNCj4g
PiAqcmluZykgIHsNCj4gPiAtICAgIFBDSURldmljZSAqcGNpX2RldiA9IFBDSV9ERVZJQ0UoeGhj
aSk7DQo+ID4gICAgICBYSENJVFJCIHRyYjsNCj4gPiAgICAgIGludCBsZW5ndGggPSAwOw0KPiA+
ICAgICAgZG1hX2FkZHJfdCBkZXF1ZXVlID0gcmluZy0+ZGVxdWV1ZTsgQEAgLTc3Myw3ICs3NzAs
NyBAQCBzdGF0aWMNCj4gPiBpbnQgeGhjaV9yaW5nX2NoYWluX2xlbmd0aChYSENJU3RhdGUgKnho
Y2ksIGNvbnN0IFhIQ0lSaW5nICpyaW5nKQ0KPiA+DQo+ID4gICAgICB3aGlsZSAoMSkgew0KPiA+
ICAgICAgICAgIFRSQlR5cGUgdHlwZTsNCj4gPiAtICAgICAgICBwY2lfZG1hX3JlYWQocGNpX2Rl
diwgZGVxdWV1ZSwgJnRyYiwgVFJCX1NJWkUpOw0KPiA+ICsgICAgICAgIGRtYV9tZW1vcnlfcmVh
ZCh4aGNpLT5hcywgZGVxdWV1ZSwgJnRyYiwgVFJCX1NJWkUpOw0KPiA+ICAgICAgICAgIGxlNjRf
dG9fY3B1cygmdHJiLnBhcmFtZXRlcik7DQo+ID4gICAgICAgICAgbGUzMl90b19jcHVzKCZ0cmIu
c3RhdHVzKTsNCj4gPiAgICAgICAgICBsZTMyX3RvX2NwdXMoJnRyYi5jb250cm9sKTsNCj4gPiBA
QCAtODI4LDcgKzgyNSw3IEBAIHN0YXRpYyB2b2lkIHhoY2lfZXJfcmVzZXQoWEhDSVN0YXRlICp4
aGNpLCBpbnQgdikNCj4gPiAgICAgICAgICB4aGNpX2RpZSh4aGNpKTsNCj4gPiAgICAgICAgICBy
ZXR1cm47DQo+ID4gICAgICB9DQo+ID4gLSAgICBwY2lfZG1hX3JlYWQoUENJX0RFVklDRSh4aGNp
KSwgZXJzdGJhLCAmc2VnLCBzaXplb2Yoc2VnKSk7DQo+ID4gKyAgICBkbWFfbWVtb3J5X3JlYWQo
eGhjaS0+YXMsIGVyc3RiYSwgJnNlZywgc2l6ZW9mKHNlZykpOw0KPiA+ICAgICAgbGUzMl90b19j
cHVzKCZzZWcuYWRkcl9sb3cpOw0KPiA+ICAgICAgbGUzMl90b19jcHVzKCZzZWcuYWRkcl9oaWdo
KTsNCj4gPiAgICAgIGxlMzJfdG9fY3B1cygmc2VnLnNpemUpOw0KPiA+IEBAIC0xNDQwLDcgKzE0
MzcsNyBAQCBzdGF0aWMgaW50IHhoY2lfeGZlcl9jcmVhdGVfc2dsKFhIQ0lUcmFuc2Zlcg0KPiAq
eGZlciwgaW50IGluX3hmZXIpDQo+ID4gICAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgeGZlci0+
aW50X3JlcSA9IGZhbHNlOw0KPiA+IC0gICAgcGNpX2RtYV9zZ2xpc3RfaW5pdCgmeGZlci0+c2ds
LCBQQ0lfREVWSUNFKHhoY2kpLCB4ZmVyLT50cmJfY291bnQpOw0KPiA+ICsgICAgcWVtdV9zZ2xp
c3RfaW5pdCgmeGZlci0+c2dsLCBERVZJQ0UoeGhjaSksIHhmZXItPnRyYl9jb3VudCwNCj4gPiAr
IHhoY2ktPmFzKTsNCj4gPiAgICAgIGZvciAoaSA9IDA7IGkgPCB4ZmVyLT50cmJfY291bnQ7IGkr
Kykgew0KPiA+ICAgICAgICAgIFhIQ0lUUkIgKnRyYiA9ICZ4ZmVyLT50cmJzW2ldOw0KPiA+ICAg
ICAgICAgIGRtYV9hZGRyX3QgYWRkcjsNCj4gPiBAQCAtMjEwMSw3ICsyMDk4LDcgQEAgc3RhdGlj
IFRSQkNDb2RlIHhoY2lfYWRkcmVzc19zbG90KFhIQ0lTdGF0ZQ0KPiAqeGhjaSwgdW5zaWduZWQg
aW50IHNsb3RpZCwNCj4gPiAgICAgIGFzc2VydChzbG90aWQgPj0gMSAmJiBzbG90aWQgPD0geGhj
aS0+bnVtc2xvdHMpOw0KPiA+DQo+ID4gICAgICBkY2JhYXAgPSB4aGNpX2FkZHI2NCh4aGNpLT5k
Y2JhYXBfbG93LCB4aGNpLT5kY2JhYXBfaGlnaCk7DQo+ID4gLSAgICBwb2N0eCA9IGxkcV9sZV9w
Y2lfZG1hKFBDSV9ERVZJQ0UoeGhjaSksIGRjYmFhcCArIDggKiBzbG90aWQpOw0KPiA+ICsgICAg
cG9jdHggPSBsZHFfbGVfZG1hKHhoY2ktPmFzLCBkY2JhYXAgKyA4ICogc2xvdGlkKTsNCj4gPiAg
ICAgIGljdHggPSB4aGNpX21hc2s2NChwaWN0eCk7DQo+ID4gICAgICBvY3R4ID0geGhjaV9tYXNr
NjQocG9jdHgpOw0KPiA+DQo+ID4gQEAgLTI0MzksNyArMjQzNiw3IEBAIHN0YXRpYyBUUkJDQ29k
ZQ0KPiB4aGNpX2dldF9wb3J0X2JhbmR3aWR0aChYSENJU3RhdGUgKnhoY2ksIHVpbnQ2NF90IHBj
dHgpDQo+ID4gICAgICAvKiBUT0RPOiBhY3R1YWxseSBpbXBsZW1lbnQgcmVhbCB2YWx1ZXMgaGVy
ZSAqLw0KPiA+ICAgICAgYndfY3R4WzBdID0gMDsNCj4gPiAgICAgIG1lbXNldCgmYndfY3R4WzFd
LCA4MCwgeGhjaS0+bnVtcG9ydHMpOyAvKiA4MCUgKi8NCj4gPiAtICAgIHBjaV9kbWFfd3JpdGUo
UENJX0RFVklDRSh4aGNpKSwgY3R4LCBid19jdHgsIHNpemVvZihid19jdHgpKTsNCj4gPiArICAg
IGRtYV9tZW1vcnlfd3JpdGUoeGhjaS0+YXMsIGN0eCwgYndfY3R4LCBzaXplb2YoYndfY3R4KSk7
DQo+ID4NCj4gPiAgICAgIHJldHVybiBDQ19TVUNDRVNTOw0KPiA+ICB9DQo+ID4gQEAgLTM0MzEs
NiArMzQyOCw3IEBAIHN0YXRpYyB2b2lkIHVzYl94aGNpX3JlYWxpemUoc3RydWN0IFBDSURldmlj
ZQ0KPiAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAgICB9DQo+ID4NCj4gPiAgICAgIHVzYl94
aGNpX2luaXQoeGhjaSk7DQo+ID4gKyAgICB4aGNpLT5hcyA9IHBjaV9nZXRfYWRkcmVzc19zcGFj
ZShkZXYpOw0KPiA+ICAgICAgeGhjaS0+bWZ3cmFwX3RpbWVyID0gdGltZXJfbmV3X25zKFFFTVVf
Q0xPQ0tfVklSVFVBTCwNCj4gPiB4aGNpX21md3JhcF90aW1lciwgeGhjaSk7DQo+ID4NCj4gPiAg
ICAgIG1lbW9yeV9yZWdpb25faW5pdCgmeGhjaS0+bWVtLCBPQkpFQ1QoeGhjaSksICJ4aGNpIiwg
TEVOX1JFR1MpOw0KPiA+IEBAIC0zNTMxLDcgKzM1MjksNyBAQCBzdGF0aWMgaW50IHVzYl94aGNp
X3Bvc3RfbG9hZCh2b2lkICpvcGFxdWUsIGludA0KPiB2ZXJzaW9uX2lkKQ0KPiA+ICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAgICAgc2xvdC0+Y3R4ID0N
Cj4gPiAtICAgICAgICAgICAgeGhjaV9tYXNrNjQobGRxX2xlX3BjaV9kbWEocGNpX2RldiwgZGNi
YWFwICsgOCAqIHNsb3RpZCkpOw0KPiA+ICsgICAgICAgICAgICB4aGNpX21hc2s2NChsZHFfbGVf
ZG1hKHhoY2ktPmFzLCBkY2JhYXAgKyA4ICogc2xvdGlkKSk7DQo+ID4gICAgICAgICAgeGhjaV9k
bWFfcmVhZF91MzJzKHhoY2ksIHNsb3QtPmN0eCwgc2xvdF9jdHgsIHNpemVvZihzbG90X2N0eCkp
Ow0KPiA+ICAgICAgICAgIHNsb3QtPnVwb3J0ID0geGhjaV9sb29rdXBfdXBvcnQoeGhjaSwgc2xv
dF9jdHgpOw0KPiA+ICAgICAgICAgIGlmICghc2xvdC0+dXBvcnQpIHsNCj4gPiBkaWZmIC0tZ2l0
IGEvaHcvdXNiL2hjZC14aGNpLmggYi9ody91c2IvaGNkLXhoY2kuaCBpbmRleA0KPiA+IDk0NmFm
NTEuLmVkYmQ5MjYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdXNiL2hjZC14aGNpLmgNCj4gPiArKysg
Yi9ody91c2IvaGNkLXhoY2kuaA0KPiA+IEBAIC0yMiw2ICsyMiw4IEBADQo+ID4gICNpZm5kZWYg
SFdfVVNCX0hDRF9YSENJX0gNCj4gPiAgI2RlZmluZSBIV19VU0JfSENEX1hIQ0lfSA0KPiA+DQo+
ID4gKyNpbmNsdWRlICJzeXNlbXUvZG1hLmgiDQo+IA0KPiBBZGRyZXNzU3BhY2UgaXMgZm9yd2Fy
ZC1kZWNsYXJlZCBpbiAicWVtdS90eXBlZGVmcy5oIiwgc28gbm8gbmVlZCB0bw0KPiBpbmNsdWRl
IGl0IGhlcmUgKHllcyBpbiB0aGUgc291cmNlcyBpbmNsdWRpbmcgaGNkLXhoY2kuaCkuDQpbU2Fp
IFBhdmFuIEJvZGR1XSBZZXMgeW91IGFyZSByaWdodCEsIGJ1dCB3aXRob3V0IHRoaXMgIiBkbWFf
YWRkcl90ICIgaXMgdW5kZWZpbmVkLiANCkF0IHRoaXMgcG9pbnQgb2YgdGhlIHBhdGNoLCBoY2Qt
eGhjaS5oIGlzIGNvbXBpbGVkIGFsb25nIHdpdGggcGNpLmggd2hpY2ggd291bGQgcHJvdmlkZSAn
ZG1hX2FkZHJfdCcsIGJ1dCB3aGVuIHdlIHN0cmlwIHRoZSBwY2kgd3JhcHBlciBhcm91bmQgaGNk
LXhoY2kgd2Ugd291bGQgbWlzcyBpdC4gTGV0IG1lIGtub3csIGlmIGl0cyBnb29kIHRvIGFkZCBs
YXRlciBpbiB0aGUgcGF0Y2ggc2VyaWVzIHdoZW4gdGhlIHNwbGl0IGhhcHBlbnMuDQoNClJlZ2Fy
ZHMsDQpTYWkgUGF2YW4NCj4gDQo+IFdpdGggdGhhdCBmaXhlZDoNCj4gUmV2aWV3ZWQtYnk6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gDQo+ID4gKw0KPiA+
ICAjZGVmaW5lIFRZUEVfWEhDSSAiYmFzZS14aGNpIg0KPiA+ICAjZGVmaW5lIFRZUEVfTkVDX1hI
Q0kgIm5lYy11c2IteGhjaSINCj4gPiAgI2RlZmluZSBUWVBFX1FFTVVfWEhDSSAicWVtdS14aGNp
Ig0KPiA+IEBAIC0xODksNiArMTkxLDcgQEAgc3RydWN0IFhIQ0lTdGF0ZSB7DQo+ID4NCj4gPiAg
ICAgIFVTQkJ1cyBidXM7DQo+ID4gICAgICBNZW1vcnlSZWdpb24gbWVtOw0KPiA+ICsgICAgQWRk
cmVzc1NwYWNlICphczsNCj4gPiAgICAgIE1lbW9yeVJlZ2lvbiBtZW1fY2FwOw0KPiA+ICAgICAg
TWVtb3J5UmVnaW9uIG1lbV9vcGVyOw0KPiA+ICAgICAgTWVtb3J5UmVnaW9uIG1lbV9ydW50aW1l
Ow0KPiA+DQoNCg==

