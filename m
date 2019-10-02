Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677EC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE6A218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KAQBUh2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE6A218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbx9-00010E-Vd
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 06:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFbtM-0007cO-TI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFbtL-0004gb-Sh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:29:56 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:51781 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFbtI-0004cE-TH; Wed, 02 Oct 2019 06:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj8X0LfJSqo+viZMaWxkkPE9mNSgFKggzLXi4m9pj+eVBZ1He+Vi2UeM64iMc3XllPGXxTTWPPT2iHXmdAE3C9cKVuytxF+vqWSAamlyr0/eotpns2vlcLxKgg5LunVCmvjtwbS1QysAL9i0iDEyDuroJZ7hj4CZEiechKqQsMNWAlif1MRr9jf7/mFwIHC7koZia47E4eYuW6Dbfd2SW1KCbz/vZ2GuIrWAJjnNExrdYfgl3c9qiwv6OWHLx+tDkZykx/q1wR/ikKBA3Xdl1ZDdzRq2OON0xkmp/aVeKZeMv0u2KHkWTrSbtHEBnwYPcsw8ovR/tQUmAAxKmr5YaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bue+dYHLlWDXQYyKVJ17upVQc9XIz64cLTMWyc9+jOM=;
 b=d9xy8Itae0XiBwmkBaSxg4G77AUQYQqMmUj4UnLdgvH5/MLCfCC5TGTKyuCE+Y3av7NpVnmMHTTtRLN4VNQbT1ZTlkDqOxw36p/MwFLbZmFrC8Jlpy4PasKCAC5zB0EO7AK3bHKFbBsYUW4A72+jRWpJffTW835UyXAJDGwhuyzwqrVEYO395XumxQite3bSQaAoGFcqrW+vF8okYfZ+XpAtZyG1ccKr9s4mZ+UP0oPoxGpFVEALgxljH2rElOEcDiP8u0JowpreUryn0nUlWMwGJqEzXC2qY7cINBieJbh2KAaKKhlaIVqoiyTMgVy8GjKrETMCgeP0d56EWDUZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bue+dYHLlWDXQYyKVJ17upVQc9XIz64cLTMWyc9+jOM=;
 b=KAQBUh2PBzq/qfd8ZQs388zmcAs0ip/dm32PP+p9ji/nnKeR//ZV1POs0xvlBUe1NGmaAInWG4NEOMT99/AJUaTGg7+LZU5zqEgMjsFb0UqJz8TM/P4Kwsy1/o9FzHL4Ag+g9WbM7hpjAPwPY2EOAWn97okfcwEtHiNh/g3d1R8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5276.eurprd08.prod.outlook.com (20.179.15.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 10:29:50 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 10:29:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 4/6] qemu-nbd: add compression flag support
Thread-Topic: [PATCH 4/6] qemu-nbd: add compression flag support
Thread-Index: AQHVeI5JcGw17iThzESklFPofxlNgqdGQaWAgADl3QA=
Date: Wed, 2 Oct 2019 10:29:50 +0000
Message-ID: <9a1c32f9-811a-d286-440e-a66bd64b3889@virtuozzo.com>
References: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1569958040-697220-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4afd7d6c-7e38-c325-b009-c798186715bd@redhat.com>
In-Reply-To: <4afd7d6c-7e38-c325-b009-c798186715bd@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002132946827
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c50c9fe1-57b1-4f8d-0d91-08d74723746e
x-ms-traffictypediagnostic: DB8PR08MB5276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5276900B2BACB76DCA239F2FC19C0@DB8PR08MB5276.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(396003)(39850400004)(136003)(189003)(199004)(2201001)(5660300002)(186003)(7416002)(66556008)(2501003)(256004)(6246003)(52116002)(66066001)(31696002)(86362001)(107886003)(6506007)(71190400001)(478600001)(2616005)(102836004)(11346002)(71200400001)(31686004)(386003)(476003)(446003)(486006)(64756008)(66446008)(53546011)(66476007)(26005)(66946007)(305945005)(2906002)(110136005)(316002)(6512007)(14454004)(76176011)(7736002)(25786009)(3846002)(36756003)(6116002)(6486002)(4326008)(8676002)(6436002)(8936002)(81166006)(81156014)(229853002)(99286004)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5276;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKp/TISupQ+LYW/Rdfg9RXOJTxqsI8QhNEXN/3wTSGbjovYZQXAJZWsxc3DSBj3clTZMZNJ/PW+ouG7TYZfSiZKzHrvwj2M9dTRLlaCz+rTi+5SSDN5LUjCaEs1qaY9k5cCLHauX5ku145oOYoE5qDYzGansDnpEOjdIB4ActrBuj7HoK9WeCfk2xs9axOOB9MLSbZ9sZKdME8yV1i/60N5fe0f1vv+aYEaefljrzxqN+G3cNUe67w8EJStABlOg2zuEKNnA4oGrjutIrEDt6U9KnFyn3U7zM7ZKgxL11i5eyeL6YbvoDYTX/rIZKZeWyQsvgiDEZ+HLMUgcrd2ohs6i5ER0IXZIjkOV5/ygkAzKQo8fWiJArE3y9Fa/IHn1OE4UPY/71Euy+FpnCMa333k03m/tqXWqhJObI+942Lc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33DF49AD51B8A342B0B1805D2DF42B34@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50c9fe1-57b1-4f8d-0d91-08d74723746e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 10:29:50.0912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRWylWhxSvpc+FYAuf1sRV/dp8iO4ZS9Mp3frga1L3r5VLskqJ3x4GRicOo03aHAIdNs8AeFGv1lHsarzq7OkDqH/9GyxiQG6Xojnpoztpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5276
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.127
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAyMzo0NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMS8xOSAyOjI3IFBN
LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IEFkZGVkIHBvc3NpYmlsaXR5IHRvIHdyaXRl
IGNvbXByZXNzZWQgZGF0YSBieSB1c2luZyB0aGUNCj4+IGJsa193cml0ZV9jb21wcmVzc2VkLiBU
aGlzIGFjdGlvbiBoYXMgdGhlIGxpbWl0YXRpb25zIG9mIHRoZSBmb3JtYXQNCj4+IGRyaXZlci4g
Rm9yIGV4YW1wbGUgd2UgY2FuJ3Qgd3JpdGUgY29tcHJlc3NlZCBkYXRhIG92ZXIgb3RoZXIuDQo+
Pg0KPiANCj4+ICsrKyBiL2Jsb2NrZGV2LW5iZC5jDQo+PiBAQCAtMTkxLDcgKzE5MSw3IEBAIHZv
aWQgcW1wX25iZF9zZXJ2ZXJfYWRkKGNvbnN0IGNoYXIgKmRldmljZSwgYm9vbCBoYXNfbmFtZSwg
Y29uc3QgY2hhciAqbmFtZSwNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoCBleHAgPSBu
YmRfZXhwb3J0X25ldyhicywgMCwgbGVuLCBuYW1lLCBOVUxMLCBiaXRtYXAsICF3cml0YWJsZSwg
IXdyaXRhYmxlLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBOVUxMLCBmYWxzZSwgb25fZWplY3RfYmxrLCBlcnJwKTsNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCwgTlVMTCwgZmFsc2UsIG9u
X2VqZWN0X2JsaywgZXJycCk7DQo+IA0KPiBUaGlzIGlzIGEgbG90IG9mIHBhcmFtZXRlcnMuwqAg
U2hvdWxkIHdlIGJlIGNvbWJpbmluZyBzb21lIG9mIHRoZW0gaW50byBhIHN0cnVjdCwgb3IgZXZl
biBhdCBsZWFzdCB0aGUgYm9vbGVhbnMgaW50byBhIGZsYWdzIHBhcmFtZXRlcj8NCj4gDQo+IA0K
Pj4gKysrIGIvaW5jbHVkZS9ibG9jay9uYmQuaA0KPj4gQEAgLTI1LDYgKzI1LDEwIEBADQo+PiDC
oCAjaW5jbHVkZSAiY3J5cHRvL3Rsc2NyZWRzLmgiDQo+PiDCoCAjaW5jbHVkZSAicWFwaS9lcnJv
ci5oIg0KPj4gK2VudW0gew0KPj4gK8KgIE5CRF9JTlRFUk5BTF9GTEFHX0NPTVBSRVNTID0gMSA8
PCAxLCAvKiBVc2Ugd3JpdGUgY29tcHJlc3NlZCAqLw0KPj4gK307DQo+IA0KPiBXaGF0IGhhcHBl
bmVkIHRvIGZsYWcgMSA8PCAwP8KgIFdoYXQgb3RoZXIgZmxhZ3MgZG8geW91IGFudGljaXBhdGUg
YWRkaW5nPw0KDQpIbW0sIGFueSB3YXksIGNyZWF0aW5nIGZsYWdzIHBhcmFtZXRlciBmb3Igb25s
eSBvbmUgZmxhZyBzZWVtcyB1c2VsZXNzLg0KDQpJIHRoaW5rLCBJJ2QgcHJlZmVyIHRvIGNvdmVy
IGFsbCBuYmRfZXhwb3J0X25ldyBwYXJhbWV0ZXJzIHRvIGEgc3RydWN0dXJlDQp3aXRoIGJvb2xl
YW4gZmllbGRzLCB0byBhdm9pZCBleHRyYSAmL3wgYXJpdGhtZXRpYy4NCg0KbmJkX2V4cG9ydF9u
ZXcgaXMgY2FsbGVkIGZyb20gcW1wX25iZF9zZXJ2ZXJfYWRkIGFuZCBxZW11LW5iZCBtYWluKCks
IGFuZA0KYm90aCBwbGFjZXMgc2VlbXMgdG8gYmVuZWZpdCwgaWYgdGhleSB3aWxsIGZpbGwgc3Ry
dWN0dXJlIGluc3RlYWQgb2YgbG9jYWwNCnZhcmlhYmxlcy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

