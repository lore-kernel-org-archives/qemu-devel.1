Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC94DECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B20205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IiVGhx9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B20205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLGW-0001v7-Dk
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKq3-0008KY-3a
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKpx-0004aA-C9
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:17:22 -0400
Received: from mail-eopbgr50121.outbound.protection.outlook.com
 ([40.107.5.121]:42885 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKpl-0004SE-9g; Tue, 01 Oct 2019 12:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc0N3u1OnJLOxXom9XSLhqj1kcvKnbkX3Ukixoe2K0ak0NiPZz33bLKcpoC0IHAnk/d3kDqN6y6BHgMfv9ywJvQwim8WREy9KPuKKxe62t3Ur3MLOo7esogDn2IiYftkljOLtdc6iDSM7gU2+YPsrEXCH5uJlCCaX8yzkjhGSFKptBqL70aIInjj/gdzOJzwvfOt4RAEAIDiEEwOX0tHTxMVq0zW8b/oz30Jeg1IPQhHzBfb2nTwY/NqKQX7xhonzJLC2n9ZOxPD+lsOhlMRbcazDoH477F9vsIGWO1IAqrjru6K62sxZvcxgzRu3fvJ4mMm+T4gjg61rbDxgP1eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLZq8D9TYngK9IZnSZgU0/j8GukMz9nVYgFOUp0JrTc=;
 b=eaQ95UWlDASdu8CbkNwPQlV2JIqGPCYCgB44ArzOz0UhvmqtM9vQQgYlHvDQYPJycAGeKXxEDZF/T1L3PxYZEbJ+D8OL1m0L6WLgmuRHRojULnaslYkmpd17rNquyGw7eEBM6tADoX8ySCOzLUeyHjwQBgQGCs4I0RAZdcMIkZa5YCw9uKBKb9GU25eWshQWsD2ZwSOhUAazptkZ4SI4sMaBVNJJbhay71E62Th9V2d4luPuvccd6dK1eRhEaomcK1p+Z3vM4cp4u/zj917qMtf/yB0n/oJBiUmuA0UQ3AmHmuJVSj/vncs33r9mEX7xI0lZKmVRP2Fu+tC6FYyNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLZq8D9TYngK9IZnSZgU0/j8GukMz9nVYgFOUp0JrTc=;
 b=IiVGhx9JAGJNrUoZfzHx02rzem9TSkOqm3l7OB9mr7cEM0ee0osOwauji0MgOeM2UIfaK6QlW71OIX0QGAPt8djiECBffdwiA7vRZZolfP05wJA06Dty3TtuDtZHAuNqrwKawm6lpFhpOVCIBjiUund0H1CMrfNRu43ZpO6wXEk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5035.eurprd08.prod.outlook.com (10.255.18.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 16:17:02 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 16:17:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAAC+ICAAB3ngIAABSUAgAAAPAA=
Date: Tue, 1 Oct 2019 16:17:02 +0000
Message-ID: <03c6fbd9-216c-d8d0-00ff-48ae34f76619@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <20191001161610.GG4688@linux.fritz.box>
In-Reply-To: <20191001161610.GG4688@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001191700327
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b720609b-a2a1-4cf3-d83a-08d7468acb19
x-ms-traffictypediagnostic: DB8PR08MB5035:
x-microsoft-antispam-prvs: <DB8PR08MB503515F35BB446B0EDE6FE93C19D0@DB8PR08MB5035.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39840400004)(376002)(396003)(366004)(189003)(199004)(31686004)(478600001)(2906002)(102836004)(6116002)(25786009)(386003)(5660300002)(52116002)(76176011)(26005)(3846002)(6916009)(305945005)(6506007)(7736002)(53546011)(99286004)(486006)(8676002)(81156014)(8936002)(81166006)(476003)(2616005)(256004)(5024004)(11346002)(186003)(54906003)(6246003)(316002)(66476007)(66556008)(446003)(6512007)(36756003)(229853002)(31696002)(86362001)(6436002)(71190400001)(66066001)(6486002)(4326008)(14454004)(64756008)(66446008)(71200400001)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5035;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjLr3X05LrTOMMITXjraCumMBS8nOGAXkXB38NYKUBYJyvi4O3L966v6QIriJu7y25E7/CBXncmm44g7KbHFD1whzCHBNwpn0ta6pT2C7zhCwURiOWXf2gIyFjUAKJ6U1ubw0PceBjp8gjkb0ok89W2IZ8668uZFxHOSeVQnOLDT3GKcKK4RHySn3wC70waGuZKX1zTDP6GUVPN+viu5P3ggo1n38vUisvUWSgvNa8sxJ1by+HCyImY/d+piYJn8T017hbstZxAUbFDDEq2xs7T8Y6lw9X5XHzuuinFGOmxWss0HuSOIKsxZbHKxbkE4x5z5y9MlOnY0jJGrJHtKUCQxTpHrCObKp2bmlUrpfLoqu0GuUgr9h52Z56n6Zz29rGzdh3rXoSJ3tyFIXRTTcOhTmc0W/RyDvG0h+eGiH4A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <922FC85DE443E94AB194BED9C72F2147@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b720609b-a2a1-4cf3-d83a-08d7468acb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 16:17:02.3924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtNifRdBVFgTGV8KQOrhR7+brUhUDX7YGGEr2x0eSsBz8rgdYujBxAtq+ClWgTRxVlkuYfnt5JcEor7vz/XqUqKmqF3jKrVwA+g8E6lu6HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5035
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.121
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxOToxNiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDEuMTAuMjAxOSB1bSAx
Nzo1NyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDAx
LjEwLjIwMTkgMTc6MTAsIEpvaG4gU25vdyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gMTAvMS8x
OSAxMDowMCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IE90
aGVyd2lzZTogSSBoYXZlIGEgbG90IG9mIGNsb3VkeSBpZGVhcyBvbiBob3cgdG8gc29sdmUgdGhp
cywgYnV0DQo+Pj4+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZp
bmQgdGhlICJhZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+Pj4+IHRoZSBub2RlIHRoZSBiaXRtYXAg
aXMgYXR0YWNoZWQgdG8sIHdoaWNoIHdvdWxkIGJlIHRoZSBuYW1lIG9mIHRoZSBmaXJzdA0KPj4+
Pj4gYW5jZXN0b3Igbm9kZSB0aGF0IGlzbid0IGEgZmlsdGVyLiAoT1IsIHRoZSBuYW1lIG9mIHRo
ZSBibG9jay1iYWNrZW5kDQo+Pj4+PiBhYm92ZSB0aGF0IG5vZGUuKQ0KPj4+PiBOb3QgdGhlIG5h
bWUgb2YgYW5jZXN0b3Igbm9kZSwgaXQgd2lsbCBicmVhayBtYXBwaW5nOiBpdCBtdXN0IGJlIG5h
bWUgb2YgdGhlDQo+Pj4+IG5vZGUgaXRzZWxmIG9yIG5hbWUgb2YgcGFyZW50IChtYXkgYmUgdGhy
b3VnaCBzZXZlcmFsIGZpbHRlcnMpIGJsb2NrLWJhY2tlbmQNCj4+Pj4NCj4+Pg0KPj4+IEFoLCB5
b3UgYXJlIHJpZ2h0IG9mIGNvdXJzZSAtLSBiZWNhdXNlIGJsb2NrLWJhY2tlbmRzIGFyZSB0aGUg
b25seQ0KPj4+ICJub2RlcyIgZm9yIHdoaWNoIHdlIGFjdHVhbGx5IGRlc2NlbmQgdGhlIGdyYXBo
IGFuZCBhZGQgdGhlIGJpdG1hcCB0bw0KPj4+IGl0cyBjaGlsZC4NCj4+Pg0KPj4+IFNvIHRoZSBy
ZWFsIGJhY2stcmVzb2x1dGlvbiBtZWNoYW5pc20gaXM6DQo+Pj4NCj4+PiAtIEZpbmQgdGhlIGZp
cnN0IG5vbi1maWx0ZXIgYW5jZXN0b3IsIEENCj4+PiAtIGlmIEEgaXMgbm90IGEgYmxvY2stYmFj
a2VuZCwgd2UgbXVzdCB1c2Ugb3VyIG5vZGUtbG9jYWwgbmFtZS4NCj4+PiAtIGlmIEEncyBuYW1l
IGlzIGVtcHR5LCB3ZSBtdXN0IHVzZSBvdXIgbm9kZS1sb2NhbCBuYW1lLg0KPj4+IC0gSWYgdGhl
IG5hbWUgd2UgaGF2ZSBjaG9zZW4gaXMgbm90IGlkX3dlbGxmb3JtZWQsIHdlIGhhdmUgbm8NCj4+
PiBtaWdyYXRpb24tc3RhYmxlIGFkZHJlc3NhYmxlIG5hbWUgZm9yIHRoaXMgYml0bWFwIGFuZCB0
aGUgbWlncmF0aW9uIG11c3QNCj4+PiBmYWlsIQ0KPj4+DQo+Pj4NCj4+PiBGb3IgcmVzb2x2aW5n
IGJpdG1hcCBhZGRyZXNzZXMgdmlhIFFNUCAobm9kZSwgbmFtZSkgcGFpcnM7IHRoZQ0KPj4+IHJl
c29sdXRpb24gbWV0aG9kIHdvdWxkIGJlIHRoaXM6DQo+Pj4NCj4+PiAtIGlmIHRoZSBub2RlLW5h
bWUgTiBpcyBhIGJsb2NrLWJhY2tlbmQsIGRlc2NlbmQgdGhlIHRyZWUgdW50aWwgd2UgZmluZA0K
Pj4+IHRoZSBmaXJzdCBub24tZmlsdGVyIG5vZGUgVi4NCj4+PiAtIGlmIHRoZSBub2RlLW5hbWUg
TiBpcyBhIEJsb2NrRHJpdmVyU3RhdGUsIHVzZSB0aGlzIG5vZGUgZGlyZWN0bHkuDQo+Pj4NCj4+
DQo+PiBMb29rcyBnb29kIGZvciBtZS4NCj4+DQo+PiBJIGFsc28gdGhpbmsgaWYgb24gZGVzdGlu
YXRpb24gd2UgaGF2ZSBib3RoIGJsb2NrLWJhY2tlbmQgd2l0aCBuYW1lIE4gYW5kDQo+PiBibG9j
ay1ub2RlIHdpdGggbmFtZSBOIGFuZCB0aGUgbGF0dGVyIGlzIG5vdCAoZmlsdGVyZWQpIGNoaWxk
IG9mIHRoZSBmb3JtZXIsDQo+PiB3ZSBzaG91bGQgZmFpbCBtaWdyYXRpb24gb2YgYXQgbGVhc3Qg
dGhhdCBiaXRtYXAuIChIb3BlLCBub2JvZHkgcmV1c2UNCj4+IGJsb2NrLWJhY2tlbmQgbmFtZXMg
YXMgbm9kZS1uYW1lcyBpbiBwcmFjdGljZS4uIChzaG91bGQgd2UgcmVzdHJpY3QgaXQNCj4+IGV4
cGxpY2l0bHkgPykpDQo+IA0KPiBZb3UgY2FuJ3QgaGF2ZSBhIG5vZGUgYW5kIGEgQmxvY2tCYWNr
ZW5kIG9mIHRoZSBzYW1lIG5hbWUsIHRoZXkgc2hhcmUgYQ0KPiBzaW5nbGUgbmFtZXNwYWNlLiBJ
ZiB5b3UgdHJ5IHRvIGRvIHNvLCB5b3UgZ2V0IGFuIGVycm9yLg0KPiANCg0KDQpPaCwgdGhhbmtz
LCB0aGF0J3MgY29vbC4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

