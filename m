Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DFC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A125218BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d173xcGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A125218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpVQP-0007qw-G8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hpVQC-0007Lw-PC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hpVQB-0006wm-Lz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:19:56 -0400
Received: from mail-eopbgr20122.outbound.protection.outlook.com
 ([40.107.2.122]:39047 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hpVQ8-0006re-O0; Mon, 22 Jul 2019 06:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw/9UttebDLBlccAoa6hWn6ypbGnEoNrU9rH6xG/eUIBX1a93BnIxm3vNbdPlMB0wn4nWVGINtZYOxEe8egU8AJgFPJSo6RboiZ1bGWuatBXZ/jlIuCLSMoLqUR6w34JqfAbts6fFLh9TOB33bZJkeRu2pzD+k44A5VERidLpNeJ3vmZUR1yrTMwpP/DZ0zlNtoMZI5IJconEY498Bt5pCVK4feMiyBcR30s7Y7dZo0EzXhPTu4+gJFY3jA246Kp8jcU0C7T46/i9OS9645AgX1qfNabaY+jpV4IlEYKYjyvh+c7Sbd8OUVbkIJ5KFzsyHCbfP7LnDD9GYYJ48f97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjoNaOnk4Kij50qGRNdeYgVlem4MVvSCacNaufnauxc=;
 b=AvfjQNcJYg4ht+lbvgPRPEuE+PbG4g67h129aqpaPV+4Wd24Uezj8yFwIUgTtEo2ccOPgLuNq81lBeLDu8J0JHC1hSgy336gZKcRwu2zR+qm3INS3pfY7qo0AlH7Ab9jrgur5ZAIbcCVxax7izkCjN3ReREMkDIs2KBKJUe7b4+D5xY0rsV7qaMNIJ6IWEDVrkMizkxyrosBDBeQRfw2QmNS53tsrry3zuoOh2MfH7x5L3i2rBQViYLDUGd6Nj3xtV+kJLPVS3tJH6atp0k9MryuwS1VykzUFSNrV/uKWMqzzMo7Vj/LEHotSMlzxS/ZilAhrq/hH0oJLmpcwU6XwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjoNaOnk4Kij50qGRNdeYgVlem4MVvSCacNaufnauxc=;
 b=d173xcGO2F12TZq23mhhOqpKNatbzLAfOvCtkvaqd0mEHFLw0+Za31VFG3O7KtJZD4rgCBGDg15t+jOn0vKIO/E80zKnZLeCa3IErDvOoGtPvzAHGsrMZwLWdYyha8P7j+ZPzmZaRILeX/tKB0WKPcYnCJ5mkHknV5HFbKMeec8=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3920.eurprd08.prod.outlook.com (20.178.81.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 10:19:45 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 10:19:45 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH for-4.1 v2] nbd: Initialize reply on failure
Thread-Index: AQHVPlY8L7ko0CFHaUiW270qFUzQFqbWcUiA
Date: Mon, 22 Jul 2019 10:19:45 +0000
Message-ID: <cbbdbcaf-63a7-58d2-af0d-9499c880043a@virtuozzo.com>
References: <20190719172001.19770-1-eblake@redhat.com>
In-Reply-To: <20190719172001.19770-1-eblake@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::34) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d45626a5-e1af-4d70-ada6-08d70e8e1e48
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3920; 
x-ms-traffictypediagnostic: VI1PR08MB3920:
x-microsoft-antispam-prvs: <VI1PR08MB392018F3E7E714772FB82F06F4C40@VI1PR08MB3920.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:144;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(478600001)(44832011)(25786009)(2616005)(476003)(36756003)(31686004)(11346002)(446003)(99286004)(5660300002)(53936002)(4326008)(66446008)(6436002)(66476007)(66556008)(64756008)(66946007)(2501003)(71200400001)(6512007)(7736002)(53546011)(6506007)(386003)(3846002)(81156014)(81166006)(71190400001)(6246003)(66066001)(316002)(6116002)(305945005)(8936002)(14454004)(26005)(68736007)(102836004)(54906003)(86362001)(31696002)(110136005)(229853002)(8676002)(256004)(6486002)(14444005)(76176011)(486006)(2906002)(186003)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3920;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N+UUIJY73e4RPndTqS0wasa4n5pfCw1voma3cHNzGi8JcuGbCzCYvy16OafdFmWC50pB2i0+Uy8WPfdJTcCbwQ7w04LFNOu0jBnpZgWGITkPvUhSZizWjCB/BLtONx/K5N1WF5wnUZULg6le6IYA5TRypPLlOzlnH6u9ME5vZ/6Bn1+WGhab2A729CxZFHqUtK6oYEm5MNKEgzCClmQ7AFC06wO23uoApiV2mqFnllOsGJhJBkQ5gzMQgAjNXKA7FukZ6NsO8fNDDfZXrTzFVTAz2d8uO01CRcuQYOJVbIi7HlgVVcHciG8SSCOdztRtsFVi365jP0OoyhGyhkEEcJ+I65GltIaXgrhqSo9LkTO7dxbcHlpk/V1ytTlq8/Z7JKPMopesGlIqiialOSuSruflxvbo82+TasLE1oB2Qkw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECDECF6A20CB34CBAA8C689CA398163@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45626a5-e1af-4d70-ada6-08d70e8e1e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:19:45.5137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3920
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.122
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] nbd: Initialize reply on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA3LzIwMTkgMjA6MjAsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IFdlJ3ZlIGhhZCB0
d28gc2VwYXJhdGUgcmVwb3J0cyBvZiBkaWZmZXJlbnQgY2FsbGVycyBydW5uaW5nIGludG8gdXNl
DQo+IG9mIHVuaW5pdGlhbGl6ZWQgZGF0YSBpZiBzLT5xdWl0IGlzIHNldCAob25lIGRldGVjdGVk
IGJ5IGdjYyAtTzMsDQo+IGFub3RoZXIgYnkgdmFsZ3JpbmQpLCBkdWUgdG8gY2hlY2tpbmcgJ25i
ZF9yZXBseV9pc19zaW1wbGUocmVwbHkpIHx8DQo+IHMtPnF1aXQnIGluIHRoZSB3cm9uZyBvcmRl
ci4gUmF0aGVyIHRoYW4gY2hhc2luZyBkb3duIHdoaWNoIGNhbGxlcnMNCj4gbmVlZCB0byBwcmUt
aW5pdGlhbGl6ZSByZXBseSwgYW5kIHdoZXRoZXIgdGhlcmUgYXJlIGFueSBvdGhlcg0KPiB1bmlu
aXRpYWxpemVkIHVzZXMsIGl0J3MgZWFzaWVyIHRvIGd1YXJhbnRlZSB0aGF0IHJlcGx5IHdpbGwg
YWx3YXlzIGJlDQo+IHNldCBieSBuYmRfY29fcmVjZWl2ZV9vbmVfY2h1bmsoKSBldmVuIG9uIGZh
aWx1cmUuDQo+IA0KPiBUaGUgdW5pbml0aWFsaXplZCB1c2UgaGFwcGVucyB0byBiZSBoYXJtbGVz
cyAodGhlIG9ubHkgdGltZSB0aGUNCj4gdmFyaWFibGUgaXMgdW5pbml0aWFsaXplZCBpcyBpZiBz
LT5xdWl0IGlzIHNldCwgc28gdGhlIGNvbmRpdGlvbmFsDQo+IHJlc3VsdHMgaW4gdGhlIHNhbWUg
YWN0aW9uIHJlZ2FyZGxlc3Mgb2Ygd2hhdCB3YXMgcmVhZCBmcm9tIHJlcGx5KSwNCj4gYW5kIHdh
cyBpbnRyb2R1Y2VkIGluIGNvbW1pdCA2NWUwMWQ0Ny4NCj4gDQo+IEluIGZpeGluZyB0aGUgcHJv
YmxlbSwgaXQgY2FuIGFsc28gYmUgc2VlbiB0aGF0IGFsbCAob25lKSBjYWxsZXJzIHBhc3MNCj4g
aW4gYSBub24tTlVMTCByZXBseSwgc28gdGhlcmUgaXMgYSBkZWFkIGNvbmR0aW9uYWwgdG8gYWxz
byBiZSBjbGVhbmVkDQo+IHVwLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0
aEByZWRoYXQuY29tPg0KPiBSZXBvcnRlZC1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5z
aGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQmxha2UgPGVi
bGFrZUByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9uYmQuYyB8IDUgKystLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL25iZC5jIGIvYmxvY2svbmJkLmMNCj4gaW5kZXggODFlZGFiYmYzNWVk
Li41N2MxYTIwNTgxMWEgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL25iZC5jDQo+ICsrKyBiL2Jsb2Nr
L25iZC5jDQo+IEBAIC02NDAsMTIgKzY0MCwxMSBAQCBzdGF0aWMgY29yb3V0aW5lX2ZuIGludCBu
YmRfY29fcmVjZWl2ZV9vbmVfY2h1bmsoDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmVxdWVzdF9yZXQsIHFpb3YsIHBheWxvYWQsIGVycnApOw0KPiANCj4g
ICAgICAgaWYgKHJldCA8IDApIHsNCj4gKyAgICAgICAgbWVtc2V0KHJlcGx5LCAwLCBzaXplb2Yo
KnJlcGx5KSk7DQo+ICAgICAgICAgICBzLT5xdWl0ID0gdHJ1ZTsNCj4gICAgICAgfSBlbHNlIHsN
Cj4gICAgICAgICAgIC8qIEZvciBhc3NlcnQgYXQgbG9vcCBzdGFydCBpbiBuYmRfY29ubmVjdGlv
bl9lbnRyeSAqLw0KPiAtICAgICAgICBpZiAocmVwbHkpIHsNCj4gLSAgICAgICAgICAgICpyZXBs
eSA9IHMtPnJlcGx5Ow0KPiAtICAgICAgICB9DQo+ICsgICAgICAgICpyZXBseSA9IHMtPnJlcGx5
Ow0KPiAgICAgICAgICAgcy0+cmVwbHkuaGFuZGxlID0gMDsNCj4gICAgICAgfQ0KPiANCg0KUmV2
aWV3ZWQtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8u
Y29tPg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

