Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F1C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912FC21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AFAQJfiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912FC21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqUb-00087y-Fw
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqT0-0007Rx-Fu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqSz-0000j4-A5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:03:02 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com
 ([40.107.2.108]:39552 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAqSv-0000fw-Tc; Thu, 19 Sep 2019 03:02:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct9eqBJquiucS+sDsHIXkP6soG+Vikw4vuefhB/vp3mSV8d3ZNwvR6jrLZKWrS1kI5m70wqKwyOLwdeeTQf0PLfUQnV/8jPcdw8fuGTgv76dFnz+rLkQ/g0DNAKsbVQRr6BzzuK1u+93PXrxRtomwE4JpnpSFCmgOroRtIlmmGG+4C9e4OmTjJjUeRYMkoyaWCgMug9QzsFl4tMjEAbK2E4Eh6bBjPZhMQAH3YKnCeYKehoRvy2PTZHR2syDmYHGewHw9X9ygIR9JVaOm4qu7pNccXcYBbU+HiCRxe3qtWOgH9o34C46bp/rFbKGkD4AFz50ZKmnhRFWbfHKBSFrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+W5Ma2Jl/1z8q0SED10qfs4f7qsbOMgm+FOhXbTOFA=;
 b=UFIvS5JfiO8kXR5R/Vr4Zo6RvIzdkA4Mk69LTtSvjgmu0TV5+RK9vj13kfDgm30ntygENgc+WL+0YGgSfIx7qq0SS6Elt4X/ULPpefz9xmzGa0dyedETJIWmawL28orPo2i/e7SAb5eNy6Qs0mzLM83KsFXebIdPgsgCkCitx8hnP9ec/sLpfYeDpArVYV/d8/hmQFqysqLhQo1jCHVG0Xb8FxA6HZt3oygdEtyxRGEHotwEaCDY4XcKvyY42/8AvYyAFmIr3yeczdtlFiE9mMzw7Ot4mb0Dir39nIVXIV3kpBb5R916J+o7+++i20wYjQahKCKG9XaSWJMvDLMhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+W5Ma2Jl/1z8q0SED10qfs4f7qsbOMgm+FOhXbTOFA=;
 b=AFAQJfiuv8GAH9bwhQfrikJ3Oir+djeyiNPgRUdyZD3yzsFet7o2z92sTgye3XxOp+wwIEQlfdVZOovFmALkxcuXeUB/UYIgkaY2lbtGZZV09xttGd9iQGTRJlQsokanJLvBfjdtENHRh96KcWMCxMFDVZXaexNCxaju4u6tyUQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4090.eurprd08.prod.outlook.com (20.179.10.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 19 Sep 2019 07:02:55 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 07:02:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v12 2/2] block/backup: fix
 backup_cow_with_offload for last cluster
Thread-Index: AQHVbXIGXUUOLPMMPkSC7NtUOm6516cx4G0AgAC1MAA=
Date: Thu, 19 Sep 2019 07:02:55 +0000
Message-ID: <275828de-04f7-abed-ab58-a56e1904e415@virtuozzo.com>
References: <20190917160731.10895-1-vsementsov@virtuozzo.com>
 <20190917160731.10895-3-vsementsov@virtuozzo.com>
 <d5144da7-687c-f37e-4e6a-0687605aca0b@redhat.com>
In-Reply-To: <d5144da7-687c-f37e-4e6a-0687605aca0b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919100252812
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcc32d85-30e9-49a3-257c-08d73ccf654a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4090; 
x-ms-traffictypediagnostic: DB8PR08MB4090:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB409042A4F5C6D81F26697597C1890@DB8PR08MB4090.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39840400004)(189003)(199004)(11346002)(2616005)(476003)(6512007)(36756003)(102836004)(6486002)(14454004)(52116002)(54906003)(6436002)(26005)(186003)(8936002)(76176011)(2501003)(25786009)(81166006)(81156014)(99286004)(2906002)(8676002)(31686004)(3846002)(6506007)(66066001)(229853002)(53546011)(386003)(86362001)(110136005)(4326008)(66476007)(66556008)(64756008)(66446008)(305945005)(316002)(31696002)(107886003)(486006)(7736002)(6116002)(256004)(446003)(14444005)(478600001)(71200400001)(66946007)(5660300002)(6246003)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4090;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X+YByIfTwNfP4h87NpxjnVe2jcnY/HxjFl1aq+zwOjJc8pwVBy7dk7PTlSTh/wkJIJkh+YC7iBgKMyvvNvF6AnUwaKTRf488jR58EWT0PSd7V//md/EGDkfuXs3PPNXCq5E99CRmk3hKWUQSTdFWJ0d+mX9I5UzeuLt9DscaAAHOa1Ih0t5N4KUUXk2Ax8r+jfkJ/b9CyeDFqhGL0BwScps/4GzS9Qw4Fo2+W3AkEIDVtG0InlFqRvkuJ2A/X0nID5z/n1HRnPK0o+KiVmpH5LQlrUZ/X4Zo7vn30ZiGGJ2ArFFVX4Ta4ZAh8o0cgI4MaDuX63itElk2hDLSKpprPI+u3WEMDVLlwxJv42MKH3vvRw9iyw84TcbbGEDnBO7zNFnpUyRfdqh5aTplbkhbmydH604JshQ7DY0A8KDnpDI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24552BAFC7638947ABE2931FCC5A3FFE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc32d85-30e9-49a3-257c-08d73ccf654a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 07:02:55.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryBwHGEHu3kId11nckQp9UZdCDG5VSngS2a8qKUOa1mo7lKU9RNS3W83TL4ERgSMEt+XBK0cZ18PKdy2D48H/MOjw7sgaMECLGLowXYy4jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4090
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.108
Subject: Re: [Qemu-devel] [PATCH v12 2/2] block/backup: fix
 backup_cow_with_offload for last cluster
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAyMzoxNCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMTcvMTkg
MTI6MDcgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBXZSBzaG91
bGRuJ3QgdHJ5IHRvIGNvcHkgYnl0ZXMgYmV5b25kIEVPRi4gRml4IGl0Lg0KPj4NCj4+IEZpeGVz
OiA5ZGVkNGEwMTE0OTY4ZQ0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+IMKgIGJsb2NrL2JhY2t1cC5jIHwg
MiArLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+
IGluZGV4IGQ4ZmRiZmFkZmUuLjg5ZjdmODkyMDAgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9iYWNr
dXAuYw0KPj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+IEBAIC0xNjEsNyArMTYxLDcgQEAgc3Rh
dGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX2Nvd193aXRoX29mZmxvYWQoQmFja3VwQmxvY2tK
b2IgKmpvYiwNCj4+IMKgwqDCoMKgwqAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChqb2ItPmNvcHlf
cmFuZ2Vfc2l6ZSwgam9iLT5jbHVzdGVyX3NpemUpKTsNCj4+IMKgwqDCoMKgwqAgYXNzZXJ0KFFF
TVVfSVNfQUxJR05FRChzdGFydCwgam9iLT5jbHVzdGVyX3NpemUpKTsNCj4+IC3CoMKgwqAgbmJ5
dGVzID0gTUlOKGpvYi0+Y29weV9yYW5nZV9zaXplLCBlbmQgLSBzdGFydCk7DQo+PiArwqDCoMKg
IG5ieXRlcyA9IE1JTihqb2ItPmNvcHlfcmFuZ2Vfc2l6ZSwgTUlOKGVuZCwgam9iLT5sZW4pIC0g
c3RhcnQpOw0KPiANCj4gSSdtIGEgbGl0dGxlIGNvbmZ1c2VkLiBJIHRoaW5rIHRoZSBwYXRjaCBh
cyB3cml0dGVuIGlzIGNvcnJlY3QsIGJ1dCBJIGRvbid0IGtub3cgd2hhdCBwcm9ibGVtIGl0IHNv
bHZlcy4NCg0KbGFzdCBjbHVzdGVyIG1heSBleGNlZWQgRU9GLiBBbmQgYmFja3VwX2RvX2NvdyAo
d2hvIGNhbGxzICBiYWNrdXBfY293X3dpdGhfb2ZmbG9hZCkgcm91bmRzIGFsbCB0byBjbHVzdGVy
cy4NCkl0J3Mgbm90IGJhZCwgYnV0IHdlIG5lZWQgdG8gY3JvcCBuYnl0ZXMgYmVmb3JlIGNhbGxp
bmcgYWN0dWFsIGlvIGZ1bmN0aW9ucy4gYmFja3VwX2Nvd193aXRoX2JvdW5jZV9idWZmZXIgZG9l
cyB0aGUgc2FtZSB0aGluZy4NCg0KPiANCj4gSWYgd2UncmUgZ29pbmcgdG8gYWxsb3cgdGhlIGNh
bGxlciB0byBwYXNzIGluIGFuIGVuZCB0aGF0J3MgYmV5b25kIEVPRiwgZG9lcyB0aGF0IG1lYW4g
d2UgYXJlICpyZXF1aXJpbmcqIHRoZSBjYWxsZXIgdG8gcGFzcyBpbiBhIHZhbHVlIHRoYXQncyBh
bGlnbmVkPw0KDQpBY3R1YWxseSB5ZXMsIGFzIHdlIGFyZSByZXNldHRpbmcgZGlydHkgYml0bWFw
Lg0KDQo+IA0KPiBXZSBzaG91bGQgcHJvYmFibHkgYXNzZXJ0IHdoYXQga2luZCBvZiBhIHZhbHVl
IHdlJ3JlIGFjY2VwdGVkIGhlcmUsIHJpZ2h0PyBXZSBkbyBmb3Igc3RhcnQsIGJ1dCBzaG91bGQg
d2UgZm9yICdlbmQnIGFzIHdlbGw/DQoNClllcyBhc3NlcnRpb24gbWF5IGJlIGFkZGVkLg0KDQo+
IA0KPiBUaGVuIC4uLg0KPiANCj4+IMKgwqDCoMKgwqAgbnJfY2x1c3RlcnMgPSBESVZfUk9VTkRf
VVAobmJ5dGVzLCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+IA0KPiBEb24ndCB3ZSBqdXN0IHJvdW5k
IHRoaXMgcmlnaHQgYmFjayB1cCBpbW1lZGlhdGVseSBhbnl3YXk/IERvZXMgdGhhdCBtZWFuIHdl
IGhhdmUgY2FsbGVycyB0aGF0IGFyZSBwYXNzaW5nIGluIGFuICdlbmQnIHRoYXQncyBtb3JlIHRo
YW4gMSBqb2ItY2x1c3RlciBiZXlvbmQgRU9GPyBUaGF0IHNlZW1zIGxpa2Ugc29tZXRoaW5nIHRo
YXQgc2hvdWxkIGJlIGZpeGVkIGluIHRoZSBjYWxsZXIsIHN1cmVseT8NCg0KbnJfY2x1c3RlcnMg
YXJlIHVzZWQgdG8gc2V0L3Jlc2V0IGRpcnR5IGJpdG1hcC4gSXQncyBPSy4gU3RpbGwsIGZvciBs
YXN0IGNsdXN0ZXIgd2UgY2FuIGRyb3AgaXQgYW5kIHVzZSBuYnl0ZXMgZGlyZWN0bHkuIE5vIHRo
ZXJlIHNob3VsZCBub3QgYmUgc3VjaCBjYWxsZXJzLg0KbmJ5dGVzIGlzIHVzZWQgdG8gY2FsbCBi
bGtfY29fY29weV9yYW5nZSwgYW5kIG11c3QgYmUgY3JvcHBlZCB0byBub3QgZXhjZWVkIEVPRi4N
Cg0KQWxzbywgYmFja3VwX2Nvd193aXRoX2JvdW5jZV9idWZmZXIgYmVoYXZlIGluIHNpbWlsYXIg
d2F5OiBpdCBjcm9wcyBuYnl0ZXMuDQoNCk9mIGNvdXJzZSwgdGhlcmUgaXMgYSBwbGFjZSBmb3Ig
Z29vZCByZWZhY3RvcmluZywgYnV0IEkgdGhpbmsgbm90IGluIHRoaXMgcGF0Y2gsIGl0J3MgYSBz
bWFsbCBidWcgZml4Lg0KDQo+IA0KPj4gwqDCoMKgwqDCoCBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1h
cChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgam9iLT5jbHVzdGVyX3NpemUgKiBucl9j
bHVzdGVycyk7DQo+Pg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

