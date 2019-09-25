Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F1C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8892A21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GtieePAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8892A21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5ZF-00029L-DE
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5Xm-00011h-JH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5Xk-0005M7-V5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:13 -0400
Received: from mail-he1eur04on0715.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::715]:47207
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD5Xk-0005Ku-6n
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWZ2eLbpgordLWAtqLPYc7QrSRmniogdRcV5DILKalqmgfLnJ6zav9LYEF9CANBbR2HYUvt/EBFbOaJG1pyQ9JyD7sTjD+ecn7kukPvxiZg1T3+8TNJS0SIn9GrxFtDnezyWO0pFM5M8vOARfNVpjgs6Goo8DH8bfevxv3lGuBguwzHQaMuSVIp+8tkwghuAg1JBCcAy+mOwPZkHNMFNrEp3dBAqw5A4d5UcNogHvy7zxV5DkPk2/KdWpSgGOJooIJZfHV6sdZjiQiBALLReacKrKnOryRN1fcb2VXdKk/vLP6VOab/A4iBJSci1bAb6/1QTOd+5lXRVu+eP+OE4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RM0q8FDpVQfhZP5DUF9XgHK/dfJkJvi7M7Stpe9wG4=;
 b=atsD7JLWK1eun9iNKI3YAUTJntl6nSD9D/b7m6LbfVEUdKld6Puj8GLz4ks1xs1lgU7X7t/1rcqmDyc7h18nQwiWtUGbSBLLTzjk/5FjPGCcDMSceWK0U0shg50g7P5qMHs9FeblkSpbwclIYizLYPubd+HACZvYR1ewaZhHEZnhE1bucwZI3fARo0BjAatFHnKSZeu2NWFnLEB8VO9sFaLDiEs1WUoNkT/LTqwlisHoxU9Q4ucc34o7o1Mjd+Pa6vO+Ou5sDHpFAY/FJ7AfVP4/O+79elO75cEDL3cLKtKgQ1aB7mg7BBhnhO/GJsVYJ2lrJ207p8ApU9x34zTaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RM0q8FDpVQfhZP5DUF9XgHK/dfJkJvi7M7Stpe9wG4=;
 b=GtieePAqGcKUHGH1OOCbKsW+AqEp6wVw/kr2ihWbniwxEqe+Y/mXEy62FlG4Rurufn5U9QiRqL05AUXc4OZ5mEDppfDSK6YuzvxeFFEfPGn4lN/pdAb02eE+oSR6XB6AMuGcEbPyTydRGnPSNBiWui7S7C+523e9FiEW80cZYZI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4011.eurprd08.prod.outlook.com (20.179.8.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Wed, 25 Sep 2019 11:33:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:33:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
Thread-Topic: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
Thread-Index: AQHVZ624+BOAzYdX+0uYhM0m3GFuf6ckjQ6AgABjj4CAAaWmgIAVxGEA
Date: Wed, 25 Sep 2019 11:33:09 +0000
Message-ID: <1296f8b0-b1db-3125-1989-47c4eed2b3e9@virtuozzo.com>
References: <20190910075943.12977-1-vsementsov@virtuozzo.com>
 <20190910080319.GA8215@redhat.com>
 <0e5b08c2-e823-799a-98e3-06174de8d333@redhat.com>
 <00357f96-367e-d003-c166-d43083ee60af@virtuozzo.com>
In-Reply-To: <00357f96-367e-d003-c166-d43083ee60af@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:7:16::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925143306713
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c4e54c4-d676-4dd3-ceb7-08d741ac23ea
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4011; 
x-ms-traffictypediagnostic: DB8PR08MB4011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB40111A880366FF6BAD4A8861C1870@DB8PR08MB4011.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39850400004)(189003)(199004)(31696002)(54906003)(3846002)(256004)(2616005)(99286004)(386003)(14454004)(86362001)(66946007)(66476007)(52116002)(6506007)(31686004)(76176011)(102836004)(71200400001)(4326008)(53546011)(2906002)(14444005)(66066001)(64756008)(66446008)(71190400001)(66556008)(36756003)(6436002)(11346002)(6512007)(8676002)(486006)(26005)(81156014)(81166006)(446003)(478600001)(4744005)(5660300002)(316002)(305945005)(25786009)(476003)(6246003)(186003)(8936002)(110136005)(7736002)(229853002)(6116002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4011;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1qGtSe8842SzjSA2+xt2c3CgcfttdMBlcfrMWTk3OFOJFX3eW6+CR6G7LcNHs2pIiCKaDimbRN6cJR6S7Q34bu4Z1UF+LELEAr+3Co0cpOTLWoqyLwGXgwxQ0f7zuojFNSN3yJV1yIIoskCUq+tP1EZ7Jp+8vsWXxku6WP/ZYNrATrmQMzFDukDBQGzHbFy1qalhTgiYCNKsmf6JZTR875wsQq7V7+IYzMEXByTHhs9CwhKNNlMaCG4sqlk+uvrljuKC2GlaYgjM/iW1HhV6PakQu88YxDpjzYDMvr2jUjLdsj/AZxh8wXMzM1CCDi414+KAVPlW2J23O63cRR88ccgwb1xpgI3shZFUHNaAZgdayZ7z4yEgSJ1MQK6IRyOCGtaVK3jkL3E9AXPlNV9Z96nfB8QoRG6w8+uO1BNYZI0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A2F73DFD524374E9C87F70B6D3972A7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4e54c4-d676-4dd3-ceb7-08d741ac23ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:33:09.1687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovX6mURSUV2oRdy7EuabYF3gPJLH+Ctqst31teg87KJIwR4CvYA8zwvXXEP8CD/3aRSObYVf4UyuSt5+q1/+JVrs8vRFSjsb1WGNHTMMKNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4011
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::715
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDkuMjAxOSAxNTowOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTAuMDkuMjAxOSAxNjo1OSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDkvMTAvMTkgMzowMyBB
TSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+PiBPbiBUdWUsIFNlcCAxMCwgMjAxOSBh
dCAxMDo1OTo0M0FNICswMzAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0K
Pj4+PiBJbiAiaWYgKHNhZGRyLT5rZWVwX2FsaXZlKSB7IiB3ZSBtYXkgYWxyZWFkeSBiZSBvbiBl
cnJvciBwYXRoLCB3aXRoDQo+Pj4+IGludmFsaWQgc29jayA8IDAuIEZpeCBpdCBieSByZXR1cm5p
bmcgZXJyb3IgZWFybGllci4NCj4+Pj4NCj4+Pj4gUmVwb3J0ZWQtYnk6IENvdmVyaXR5IChDSUQg
MTQwNTMwMCkNCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IMKgIHV0aWwv
cWVtdS1zb2NrZXRzLmMgfCA1ICsrKy0tDQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTogRGFuaWVsIFAu
IEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4+DQo+PiBUaGFua3MuwqAgV2lsbCBx
dWV1ZSB0aHJvdWdoIG15IE5CRCB0cmVlLCBzaW5jZSB0aGF0J3Mgd2hlcmUgdGhlIG9yaWdpbmFs
DQo+PiBwcm9ibGVtIHdhcyBpbnRyb2R1Y2VkLg0KPj4NCj4gDQo+IFBsZWFzZSBhZGQgd2hlbiBx
dWV1ZWluZzoNCj4gDQo+IEZpeGVzOiBhZWMyMWQzMTc1NmNiZA0KPiANCg0KSG1tLCBkb24ndCB5
b3UgZm9yZ2V0PyBEb24ndCBzZWUgaXQgbmVpdGhlciBpbiBwdWxsIHJlcXVlc3Qgbm9yIGluIHlv
dXIgYnJhbmNoZXMuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

