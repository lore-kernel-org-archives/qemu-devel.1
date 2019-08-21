Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7ADC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFE9206BB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RWoqvUvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFE9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PDx-0001kd-OD
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i0PCs-0000ny-0X
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i0PCq-0003rS-LE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:55:13 -0400
Received: from mail-eopbgr50120.outbound.protection.outlook.com
 ([40.107.5.120]:37517 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i0PCq-0003os-A0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwcwx9EhFKhwUnRHcEihZclaiNlhium37esykkSA81yPvkvqNBgDJbAbj8fyl8v/LNgFsWSFZxhtBTxSOFtaZI2qtTiXiUFrRVj8EZwHJG8IbfmJkufIhwGDLqr++eQfHJzAl+rfl2WjGsHwB4KUN0wbV6HDroMnwY3BaLbh3SUE1iEu/YJqhF7mmqQpN30LqEqk6hku8xDBPtvYqyJCEyG16HlY4UO4nWgNjYWnVt7PhJO0KfFvPiSv2A1oiLcxbOfr4LYm5Czlna2/aVvmfKfCreh630yUjQqiDvRbnyCbi+TYdpJ+GclpEYW8wc/0h9w+CLBmCzuJCaWFy1My8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m76p3f5rSMSQBqGUc5muvPGOnrFgrdrDsaVUc3y6hJY=;
 b=FbJeA7l4q/oIc4SYHONlXXANVOG7x6KNM5HEsgDeWpVtXhZSAUErNXjv7tAUGOJqOQ6kgyy/e2PggO4OkNNsPYuI6gSb+wtOS0i0YesB+eVCDPJJ9/vUbEZ/73Ddo9H/iYCI4KlfIiyr9i2e/h6woBEjj0QkZY5vKIBJQbk5QNYKpK52mfxW9pTKQTLdiQTtUu5WHCOtX8n0yo5Q8jJiLg3HO8PLpoMD3j5LURQD+Q66YDdo4OFNwR5uv9p3wribg7FG1TBcAHGsW2forf9sKGidkj94qr8UPcNAJectTdp5FadmBJ0LHCNJm12aFCuxCH59n96HV4uEIZeVJDLphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m76p3f5rSMSQBqGUc5muvPGOnrFgrdrDsaVUc3y6hJY=;
 b=RWoqvUvV6i0UQ3R8cbJUhg5sG4AyO9vQuqp+nCvejtZ2ISaH4wKiDYM/BEqy2S5ISmf05QPBXL1w/1PnyO8BYrgfrGFCl9T7DsLdRdejIE5ZAJSTYnSuBdFm4zkeOs+UHeF+ANtvS3O/ZGgfsrOva3D+WS1HxHgcIaTgXe9IFVU=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3583.eurprd08.prod.outlook.com (20.177.61.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 11:55:07 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.024; Wed, 21 Aug 2019
 11:55:07 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v3] make check-unit: use after free in
 test-opts-visitor
Thread-Index: AQHVS6+yW1O0+uQoyUezalsyE4hvLacFjuGwgAAISoA=
Date: Wed, 21 Aug 2019 11:55:07 +0000
Message-ID: <bf62a458-9e50-4c54-81af-b2477a0b5ffc@virtuozzo.com>
References: <1565024586-387112-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <875zmqlq00.fsf@dusky.pond.sub.org>
In-Reply-To: <875zmqlq00.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0077.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::21) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93c57fdb-1f64-4c16-a6ad-08d7262e6940
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3583; 
x-ms-traffictypediagnostic: VI1PR08MB3583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB358310F6260D25492E501F41F4AA0@VI1PR08MB3583.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(66476007)(6246003)(478600001)(64756008)(2616005)(14454004)(53936002)(25786009)(386003)(4326008)(3846002)(66556008)(6116002)(76176011)(31686004)(52116002)(6916009)(2906002)(446003)(6506007)(102836004)(5660300002)(6486002)(66946007)(229853002)(66446008)(26005)(4744005)(256004)(7736002)(31696002)(99286004)(11346002)(476003)(44832011)(86362001)(71200400001)(316002)(53546011)(186003)(8936002)(36756003)(81166006)(66066001)(8676002)(81156014)(54906003)(6436002)(6512007)(71190400001)(305945005)(486006)(20703003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3583;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H4EG3NjCUc/ho8TaTbebyxM0e2bxJ8jK5VaRgl2N9teigBsUbGOCU7++jISadmDWmXlGNF6FBpeCi1xsp5KhiH7NWaEvr287YK+WmOpRtGgwX/L8HEniRgUEpI9yiNyrFrnbL35GI1Y9LG/GsS3EZmM8xefvU5+LacYG5WG1/R6+Y5CdcuobHd4lczhfEkfjbKi0gV2ZMs8bWBPfYeLTqQWZCvoDczJmiQT4rgvQOPzeSCtoIm7QJOeU4ahm0aMbKVvsfzbRpQkUavxEnskVPxxAZQV67B6n9Z12Ck6a0KrwF4PTQwaSSvHYFq/JEEGYafrNoadGy82GwINKsSqnSZSIojRX5EATWu5TWWuBDxvybGYbFjxj6pJe/YFp4PRLPyn+2ha97mp98cyg9+TuFbpjZi6VhuaW4A2jI1mUGog=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C203D7BC39D7645B36DF965B8B2EF60@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c57fdb-1f64-4c16-a6ad-08d7262e6940
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:55:07.4968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gCNkxjuuGr6aL8nqbYuoi/r9DSesJV/kK/kX7F3f0g8+de3yu31rh2o7xme6wLldYy7KtAL0G1l38QloQtjvcakX1xaJcLXA1fTEOqq3XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3583
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.120
Subject: Re: [Qemu-devel] [PATCH v3] make check-unit: use after free in
 test-opts-visitor
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
Cc: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIxLzA4LzIwMTkgMTQ6MjUsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBBbmRy
ZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0K
PiANCj4+IEluIHRoZSBzdHJ1Y3QgT3B0c1Zpc2l0b3IsIHRoZSAncmVwZWF0ZWRfb3B0cycgbWVt
YmVyIHBvaW50cyB0byBhIGxpc3QNCj4+IGluIHRoZSAndW5wcm9jZXNzZWRfb3B0cycgaGFzaCB0
YWJsZSBhZnRlciB0aGUgbGlzdCBoYXMgYmVlbiBkZXN0cm95ZWQuDQo+PiBBIHN1YnNlcXVlbnQg
Y2FsbCB0byB2aXNpdF90eXBlX2ludCgpIHJlZmVyZW5jZXMgdGhlIGRlbGV0ZWQgbGlzdC4NCj4+
IEl0IHJlc3VsdHMgaW4gdXNlLWFmdGVyLWZyZWUgaXNzdWUgcmVwcm9kdWNlZCBieSBydW5uaW5n
IHRoZSB0ZXN0IGNhc2UNCj4+IHVuZGVyIHRoZSBWYWxncmluZDogdmFsZ3JpbmQgdGVzdHMvdGVz
dC1vcHRzLXZpc2l0b3IuDQo+PiBBIG5ldyBtb2RlIExpc3RNb2RlOjpMTV9UUkFWRVJTRUQgaXMg
ZGVjbGFyZWQgdG8gbWFyayB0aGUgbGlzdA0KPj4gdHJhdmVyc2FsIGNvbXBsZXRlZC4NCj4+DQo+
PiBTdWdnZXN0ZWQtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0
dW96em8uY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVA
cmVkaGF0LmNvbT4NCj4gDQo+IFF1ZXVlZC4gIFRoYW5rcyENCj4gDQpUaGFuayB5b3UgdmVyeSBt
dWNoIE1hcmt1cyENCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkg
U2hpbmtldmljaA0K

