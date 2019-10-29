Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0957CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FB521924
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AVe2wATd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FB521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQ01-0003S9-Ld
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 07:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPPyz-0002v3-2v
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPPyx-0001JS-Eh
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:48:16 -0400
Received: from mail-eopbgr140100.outbound.protection.outlook.com
 ([40.107.14.100]:31737 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iPPyw-0001I6-SE; Tue, 29 Oct 2019 07:48:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhgMvXz+aOJnq9v+I3zACIDZmX0J+X9e7q3KSDL7yz7L0tHETzoP4bx7W0xZ+6jvOHvCzV1JxJKbI+QtDvPe7hBuNt4zNwrOYYC+fDx8CoVdPXCYtBTsyUSbgavvE+C3wEVL+hA4DvdlZ727VTk/o8TzQevBIIfLHFd2L9Eb4/z/LbyVVR8YRCCHpbc0PsisLkHSiux2ActgAuqHDUvIkxcjMTbX5CPvOGM+c4dLCLIFe/ViT7U9/P+lTo1XQryELa+jBXj6N0ilDpmlnYga4iXsP7PghAa8dv4vegUXORgHDNubCoO8aU4T0kXt9RGnv77w1jjuOESNWo4Nd3sTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfA1GrLSfO7xEZGZWlu2gKGXPT6LsZeqGX6y7Fh9Ulk=;
 b=KGnCG/Yuk8ZbplbgVCIQhO6mpb+kECd51pilIgBQrHurxbUFOu4tqo6PrytYkRTbYlx3iThcK89iH2Y2vyu/eOflj0VSjc61BAf/FS2BJokC5RNxA6NIaOijcjaKGIwJ46Q0KBr7FhnbHvK2GAb8WeUQfe/JEL5DLbn94pO6Vqt8AwZmkJdv5HB7pngXDoU6oz71q8krVv8zt2RvQzBete1QlZmRlj9q4I7J6vY1krTP/D35HP3VUX8IeJqiyMKHQZdiDtMht1Ib1+i35fm1P4OcWyqTMGhU+IlltxOwfVNGGHgpJ8mO/LjKkkdWjFbb15BHOBKpIQmv/ir+Ub8xvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfA1GrLSfO7xEZGZWlu2gKGXPT6LsZeqGX6y7Fh9Ulk=;
 b=AVe2wATdPte/ujqcr5JSHYXt9iKZpBy+Ltw3B5UJUHzLRP4SzF1j27lrUz6HCjCXQ01WK2Ef8B44nhqRD1RuCV5b15ys/1JY8p4yMtYFWngIBOLYJ3bKTNIkT/7/59yJhliRVd6gvhzKCxI+qzaMA7fDsaWr2i96W+e4StHM8Ro=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3475.eurprd08.prod.outlook.com (20.177.110.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:48:10 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 11:48:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdub/GAgAF4sACAAAXuAIABZygAgAAxigA=
Date: Tue, 29 Oct 2019 11:48:10 +0000
Message-ID: <98a5da91-d018-13e1-cf5c-168d7348117b@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <20191028110408.GB3579@localhost.localdomain>
 <44565375-b051-e782-4988-c3e0b1745e37@virtuozzo.com>
 <9780d020-e573-866f-dce4-d99d73f1f5e8@redhat.com>
In-Reply-To: <9780d020-e573-866f-dce4-d99d73f1f5e8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0048.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::34) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191029144808417
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8047a9a2-dd41-4e64-10f1-08d75c65df66
x-ms-traffictypediagnostic: AM0PR08MB3475:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3475F0443A0939171EB43265C1610@AM0PR08MB3475.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(102836004)(229853002)(305945005)(6436002)(36756003)(486006)(6116002)(6486002)(31686004)(6306002)(99286004)(476003)(316002)(2616005)(71190400001)(6512007)(53546011)(186003)(26005)(71200400001)(11346002)(478600001)(76176011)(52116002)(446003)(386003)(81166006)(256004)(2906002)(66066001)(54906003)(14454004)(3846002)(5660300002)(7736002)(81156014)(6246003)(66476007)(66556008)(64756008)(66446008)(66946007)(4326008)(8936002)(25786009)(31696002)(6506007)(8676002)(110136005)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3475;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJBwnJlUCoXaZaW7FFThcL52qqy6F+/LyBlZkqZUHTSkChPWzBLynzr746H+4D8JdjsUPnQa/VenhCOQKihKpMhAZzuPgDEtocOR5e7ecbfXBidal+Oc73jwL9vCxlkWx6Kr0WEeeYy8Mc1WqKcd6Ql8Q4pyeK6XgR3E4pTgtPrMby242nbLvdAGp6UljsO5iGWAPnQyA4fAskRgE7vWxlh6gCwLL1cBW0/5FZ0yklz4An/Xqe5zqViC3kpezX+/5ykuxY7inTXr0BM4vOXmPZOoIWrrcOHgPHhejJsHa8CKqPB+D9S+3dGkq77qd20fbbtPfq2+tB+MNuIAFN05iXtMJUbu/umzFjez/Bksj+nmXH95eAWArxnZ/pIWKUrdiJw9JV7rDouk8FVT9Zv+vhizQab8F+JEAVxVHda7HHb5YB5xTa2ETjszDZjV/QV20Eu78v6PYo4rZpnE3/r4TQmRuTJnfsauAU1KNpONwMM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7A3B4F3C098F841BDFFA6A7810C7EF2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8047a9a2-dd41-4e64-10f1-08d75c65df66
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:48:10.7953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVrXt8tw5COaHQR7qXIfUr3J1H965PuQXntkMQhswVpYqodMOOtRRsPgAeQJeghHUvg73r/m9iwCaCMKY9x/EL8Wz/hga1l0U5XGq8bHhBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3475
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.100
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTAuMjAxOSAxMTo1MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOC4xMC4xOSAxMjoyNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI4LjEwLjIwMTkgMTQ6MDQs
IEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMjcuMTAuMjAxOSB1bSAxMzozNSBoYXQgU3RlZmFu
IEhham5vY3ppIGdlc2NocmllYmVuOg0KPj4+PiBPbiBGcmksIE9jdCAyNSwgMjAxOSBhdCAxMTo1
ODo0NkFNICswMjAwLCBNYXggUmVpdHogd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+Pj4+ICgz
KSBEcm9wIGhhbmRsZV9hbGxvY19zcGFjZSgpLCBpLmUuIHJldmVydCBjOGJiMjNjYmRiZTMyZi4N
Cj4+Pj4+ICAgICAgIFRvIG15IGtub3dsZWRnZSBJ4oCZbSB0aGUgb25seSBvbmUgd2hvIGhhcyBw
cm92aWRlZCBhbnkgYmVuY2htYXJrcyBmb3INCj4+Pj4+ICAgICAgIHRoaXMgY29tbWl0LCBhbmQg
ZXZlbiB0aGVuIEkgd2FzIGEgYml0IHNrZXB0aWNhbCBiZWNhdXNlIGl0IHBlcmZvcm1zDQo+Pj4+
PiAgICAgICB3ZWxsIGluIHNvbWUgY2FzZXMgYW5kIGJhZCBpbiBvdGhlcnMuICBJIGNvbmNsdWRl
ZCB0aGF0IGl04oCZcw0KPj4+Pj4gICAgICAgcHJvYmFibHkgd29ydGggaXQgYmVjYXVzZSB0aGUg
4oCcc29tZSBjYXNlc+KAnSBhcmUgbW9yZSBsaWtlbHkgdG8gb2NjdXIuDQo+Pj4+Pg0KPj4+Pj4g
ICAgICAgTm93IHdlIGhhdmUgdGhpcyBwcm9ibGVtIG9mIGNvcnJ1cHRpb24gaGVyZSAoZ3JhbnRl
ZCBkdWUgdG8gYSBidWcgaW4NCj4+Pj4+ICAgICAgIHRoZSBYRlMgZHJpdmVyKSwgYW5kIGFub3Ro
ZXIgcmVwb3J0IG9mIG1hc3NpdmVseSBkZWdyYWRlZA0KPj4+Pj4gICAgICAgcGVyZm9ybWFuY2Ug
b24gcHBjNjQNCj4+Pj4+ICAgICAgIChodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19i
dWcuY2dpP2lkPTE3NDU4MjMg4oCTIHNvcnJ5LCBhDQo+Pj4+PiAgICAgICBwcml2YXRlIEJaOyBJ
IGhhdGUgdGhhdCA6LS8gIFRoZSByZXBvcnQgaXMgYWJvdXQgNDAgJSB3b3JzZQ0KPj4+Pj4gICAg
ICAgcGVyZm9ybWFuY2UgZm9yIGFuIGluLWd1ZXN0IGZpbyB3cml0ZSBiZW5jaG1hcmsuKQ0KPj4+
Pj4NCj4+Pj4+ICAgICAgIFNvIEkgaGF2ZSB0byBhc2sgdGhlIHF1ZXN0aW9uIGFib3V0IHdoYXQg
dGhlIGp1c3RpZmljYXRpb24gZm9yDQo+Pj4+PiAgICAgICBrZWVwaW5nIGM4YmIyM2NiZGJlMzJm
IGlzLiAgSG93IG11Y2ggZG9lcyBwZXJmb3JtYW5jZSBpbmNyZWFzZSB3aXRoDQo+Pj4+PiAgICAg
ICBpdCBhY3R1YWxseT8gIChPbiBub24tKHBwYzY0K1hGUykgbWFjaGluZXMsIG9idmlvdXNseSkN
Cj4+Pj4+DQo+Pj4+PiAgICAgICBBZHZhbnRhZ2VzOg0KPj4+Pj4gICAgICAgKyBUcml2aWFsDQo+
Pj4+PiAgICAgICArIE5vIGxheWVyaW5nIHZpb2xhdGlvbnMNCj4+Pj4+ICAgICAgICsgV2Ugd291
bGRu4oCZdCBuZWVkIHRvIGtlZXAgdHJhY2sgb2Ygd2hldGhlciB0aGUga2VybmVsIGJ1ZyBoYXMg
YmVlbg0KPj4+Pj4gICAgICAgICBmaXhlZCBvciBub3QNCj4+Pj4+ICAgICAgICsgRml4ZXMgdGhl
IHBwYzY0K1hGUyBwZXJmb3JtYW5jZSBwcm9ibGVtDQo+Pj4+Pg0KPj4+Pj4gICAgICAgRGlzYWR2
YW50YWdlczoNCj4+Pj4+ICAgICAgIC0gUmV2ZXJ0cyBjbHVzdGVyIGFsbG9jYXRpb24gcGVyZm9y
bWFuY2UgdG8gcHJlLWM4YmIyM2NiZGJlMzJmDQo+Pj4+PiAgICAgICAgIGxldmVscywgd2hhdGV2
ZXIgdGhhdCBtZWFucw0KPj4+Pg0KPj4+PiBNeSBmYXZvcml0ZSBiZWNhdXNlIGl0IGlzIGNsZWFu
IGFuZCBzaW1wbGUsIGJ1dCBWbGFkaW1pciBoYXMgYSB2YWxpZA0KPj4+PiB1c2UtY2FzZSBmb3Ig
cmVxdWlyaW5nIHRoaXMgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uIHNvIHJldmVydGluZyBpc24n
dA0KPj4+PiBhbiBvcHRpb24uDQo+Pj4NCj4+PiBWbGFkaW1pciBhbHNvIHNhaWQgdGhhdCBxY293
MiBzdWJjbHVzdGVycyB3b3VsZCBwcm9iYWJseSBhbHNvIHNvbHZlIGhpcw0KPj4+IHByb2JsZW0s
IHNvIG1heWJlIHJldmVydGluZyBhbmQgYXBwbHlpbmcgdGhlIHN1YmNsdXN0ZXIgcGF0Y2hlcyBp
bnN0ZWFkDQo+Pj4gaXMgYSBwb3NzaWJsZSBzb2x1dGlvbiwgdG9vPw0KPj4NCj4+IEknbSBub3Qg
c3VyZSBhYm91dCBzc2QgY2FzZSwgaXQgbWF5IG5lZWQgd3JpdGUtemVybyBvcHRpbWl6YXRpb24g
YW55d2F5Lg0KPiANCj4gV2hhdCBleGFjdGx5IGRvIHlvdSBuZWVkPyAgRG8geW91IGFjdHVhbGx5
IG5lZWQgdG8gd3JpdGUgemVyb2VzIChlLmcuDQo+IGJlY2F1c2UgeW914oCZcmUgc3RvcmluZyBp
bWFnZXMgb24gYmxvY2sgZGV2aWNlcykgb3Igd291bGQgaXQgYmUNCj4gc3VmZmljaWVudCB0byBq
dXN0IGRyb3AgdGhlIENPVyBhcmVhcyB3aGVuIGJkcnZfaGFzX3plcm9faW5pdCgpIGFuZA0KPiBi
ZHJ2X2hhc196ZXJvX2luaXRfdHJ1bmNhdGUoKSBhcmUgdHJ1ZT8NCg0KSG1tLCB3aGF0IGRvIHlv
dSBtZWFuPyBXZSBuZWVkIHRvIHplcm8gQ09XIGFyZWFzLiBTbywgb3JpZ2luYWwgd2F5IGlzIHRv
DQp3cml0ZSByZWFsIHplcm9lcywgb3B0aW1pemVkIHdheSBpcyBmYWxsb2NhdGUuLiBXaGF0IGRv
IHlvdSBtZWFuIGJ5IGRyb3A/DQpNYXJrIHN1Ymx1c3RlcnMgYXMgemVyb2VzIGJ5IG1ldGFkYXRh
Pw0KDQpCdXQgc3RpbGwgd2UnbGwgaGF2ZSBDT1cgYXJlYXMgaW4gc3ViY2x1c3RlciwgYW5kIHdl
J2xsIG5lZWQgdG8gZGlyZWN0bHkgemVybw0KdGhlbS4uIEFuZCBmYWxsb2NhdGUgd2lsbCBtb3N0
IHByb2JhYmx5IGJlIGZhc3RlciBvbiBzc2QgZXh0NCBjYXNlLi4NCg0KPiANCj4gSeKAmW0gYXNr
aW5nIGJlY2F1c2UgRGF2ZSBDaGlubmVyIHNhaWQNCj4gKGh0dHBzOi8vYnVnemlsbGEucmVkaGF0
LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTc2NTU0NyNjNykgdGhhdA0KPiBmYWxsb2NhdGUoKSBpcyBh
bHdheXMgc2xvdyBhdCBsZWFzdCB3aXRoIGFpbz1uYXRpdmUgYmVjYXVzZSBpdCBuZWVkcyB0bw0K
PiB3YWl0IGZvciBhbGwgY29uY3VycmVudCBBSU8gd3JpdGVzIHRvIGZpbmlzaCwgYW5kIHNvIGl0
IGNhdXNlcyB0aGUgQUlPDQo+IHBpcGVsaW5lIHRvIHN0YWxsLg0KPiANCj4gKEhlIHN1Z2dlc3Rl
ZCB1c2luZyBYRlMgZXh0ZW50IHNpemUgaGludHMgdG8gZ2V0IHRoZSBzYW1lIGVmZmVjdCBhcw0K
PiB3cml0ZS16ZXJvZXMgZm9yIGZyZWUsIGJhc2ljYWxseSwgYnV0IEkgZG9u4oCZdCBrbm93IHdo
ZXRoZXIgdGhhdOKAmXMgcmVhbGx5DQo+IHVzZWZ1bCB0byB1czsgYXMgdW5hbGxvY2F0ZWQgYXJl
YXMgb24gWEZTIHJlYWQgYmFjayBhcyB6ZXJvIGFueXdheS4pDQo+IA0KPj4+IFdlIGFscmVhZHkg
aGF2ZSBzb21lIGNhc2VzIHdoZXJlIHRoZSBleGlzdGluZyBoYW5kbGVfYWxsb2Nfc3BhY2UoKQ0K
Pj4+IGNhdXNlcyBwZXJmb3JtYW5jZSB0byBhY3R1YWxseSBiZWNvbWUgd29yc2UsIGFuZCBzZXJp
YWxpc2luZyByZXF1ZXN0cyBhcw0KPj4+IGEgd29ya2Fyb3VuZCBpc24ndCBnb2luZyB0byBtYWtl
IHBlcmZvcm1hbmNlIGFueSBiZXR0ZXIuIFNvIGV2ZW4gb24NCj4+PiB0aGVzZSBncm91bmRzLCBr
ZWVwaW5nIGNvbW1pdCBjOGJiMjNjYmRiZTMyZiBpcyBxdWVzdGlvbmFibGUuDQo+Pj4NCj4+DQo+
PiBDYW4ga2VlcGluZyBoYW5kbGVfYWxsb2Nfc3BhY2UgdW5kZXIgc29tZSBjb25maWcgb3B0aW9u
IGJlIGFuIG9wdGlvbj8NCj4gDQo+IEhtLiAgQSBjb25maWcgb3B0aW9uIGlzIHdlaXJkIGlmIHlv
deKAmXJlIHRoZSBvbmx5IG9uZSB3aG/igJlzIGdvaW5nIHRvDQo+IGVuYWJsZSBpdC4gIEJ1dCBv
dGhlciB0aGFuIHRoYXQgSSBkb27igJl0IGhhdmUgYW55dGhpbmcgYWdhaW5zdCBpdC4NCj4gDQoN
Ckl0J3MganVzdCBhIGJpdCBlYXNpZXIgZm9yIHVzIHRvIG1haW50YWluIGNvbmZpZyBvcHRpb24s
IHRoYW4gb3V0LW9mLXRyZWUgcGF0Y2guDQpPbiB0aGUgb3RoZXIgaGFuZCwgaXQncyBub3QgYSBy
ZWFsIHByb2JsZW0gdG8gbWFpbnRhaW4gdGhpcyBvbmUgcGF0Y2ggaW4gc2VwYXJhdGUuDQpJdCBt
YXkgcmV0dXJuIGFnYWluIHRvIHRoZSB0cmVlLCB3aGVuIFhGUyBidWcgZml4ZWQuDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

