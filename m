Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF6AC3A5A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF25B214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rEVm1jO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF25B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2u9S-00065Y-Se
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2u8P-0005EF-TW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2u8N-0000Vg-QS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:20:57 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com
 ([40.107.8.104]:23621 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2u8N-0000U7-16; Wed, 28 Aug 2019 05:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W30GaRYgolQxa34qqLBb5+2uqvjKOhoJFYvVPrnoi6SB8j53vHK4NUTdjxigTTNc6tOji0R0RRafHvkN69D5r0AXqQeY3tNJo7bx1mviSUB1rEgB4VXPtnLyRT0xhdYs9TdF+ONUyfZZvF8702Be8hwlpJ1N4uiW8V+GrG7dXWoFRwqNJZmHq3GWqY4YxzlyeND7HchKfFway8UuszSKW5+SoTBabvetQIGx21ZWUMTwH9s4fjjANCLsIVllwcst77xZHSechW9mOD3+OoKGNK2hQkgDdWZ5piKDe6oaG01R7yQBhrv0SZjDHjkqxCm/5f3roV8ZbPe9dzt65rTVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za+8sA6Xnzv8jJotkUSErclu5gd5nmqkJ2ybfgp+P1k=;
 b=GCO3NBTTozFM8oA9MVRkRZm5YIMCxrC3sYPbk7/mI9d5Fht37oCwQw/ASgCmMED3y+QnvOl6oRaFGipGxHWXvkQxIeT/DWVUb6AoXhlJ6Ojm4GiaENm0VmouAs9ht51DSnfe1o3ms5LutsCBooRLc+ws9JN2EmXrxyPBp4NSfHlV5AUjMMAjfTOQ5CFqiS7Z/hY3uN75xhKY8VsESWu3Ot/8gSMfH4WLJh5+Y9TU9YX5tgjVdi4q0G3KtkBD5s3gpgQ8CCvGVrdtTI2ABoxOOYybPPGGAURhFwe1Q0BqPRTiyx/sjkA7Cnpqc++yy2nIpo7IMlZJ0MVfOI8hgFqo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za+8sA6Xnzv8jJotkUSErclu5gd5nmqkJ2ybfgp+P1k=;
 b=rEVm1jO7T8Cd561yoIA5irKFUwAet/W/AE3envU6i0NulHzPQ0hemOVtqLb1KNLp4kZABblYb69kraoYN0O8TYIkACatofXpBFu6RdJ+DdvC09psa/MOWhjhjNE3qc+3wk40eZ/FO1kKddw7y2wZh9xsnXDCedK/8A9KxpebI10=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5163.eurprd08.prod.outlook.com (10.255.18.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 09:20:51 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 09:20:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVUogdkuEpfSqLt0qlSVbE/q5j26cIg2YAgAb++gCAANxRAA==
Date: Wed, 28 Aug 2019 09:20:51 +0000
Message-ID: <ba0e7e98-d02f-3514-b435-71923a483c6e@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <de4667c2-7fd7-932d-6ce3-9844f284a0b4@virtuozzo.com>
 <d2bf50f1-e441-4cdb-291f-119a3ed93f51@redhat.com>
In-Reply-To: <d2bf50f1-e441-4cdb-291f-119a3ed93f51@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::34)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190828122048624
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac9dc9b0-7e0a-4ecb-a0f9-08d72b9904ec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5163; 
x-ms-traffictypediagnostic: DB8PR08MB5163:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB51634E66F26F9F70C4C239F2C1A30@DB8PR08MB5163.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(26005)(31686004)(54906003)(2906002)(186003)(478600001)(66066001)(102836004)(8676002)(229853002)(66446008)(71190400001)(446003)(53936002)(11346002)(107886003)(76176011)(8936002)(316002)(4326008)(25786009)(6116002)(66556008)(81166006)(3846002)(52116002)(81156014)(66946007)(36756003)(305945005)(64756008)(110136005)(6512007)(66476007)(71200400001)(6246003)(2501003)(6506007)(6486002)(53546011)(31696002)(5660300002)(476003)(14454004)(486006)(86362001)(6436002)(2616005)(7736002)(386003)(256004)(99286004)(6306002)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5163;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PISIwfja3f6JN26ijw1d+LMPMrFXLeEg+apptt3G5BNZQOuLYk8r7o8ymb/kLG+Dw59OYRebCNRH9D/7LKrx9ugkoWEoai3njb701RvvG2UKBVxa2aF8NBpJd04YSZdmKAUkcy/GnL3KCq9WGtplo9gSbOaPY09aOmfUkCDwrAogWXzAsAuGE22UDo888+DDogS2uS6lTrvT92qubdBTRzZYP8IUilFb1/MIVuGKveVIs4Zbzirg2fqqLLsH3CkcEhJPyS2XriW/PUrE9gyUGitRzNARQq09YcTpFwzlEtK8lklvDySWJCFDLIAS9n9jXwBkXvJwm62z53INlQeRLQm4lNAfoY+WxN7gZma5EYAWoF4Pp7Z2dmcCr4sVCo9hoB7BfL3KMm+b8DltsT+4JJqFGmpnjCC23PsbGwPA3PE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F26FEA05E46F654195C3DBE2528B37C6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9dc9b0-7e0a-4ecb-a0f9-08d72b9904ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 09:20:51.1303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvXh/wg4A+/UR21SNWBndaFPbNLeDRcV/iYWaFyViguw6oq+Ll1eyEn99trpNywgmx4Xp7+EumfHgcjcaHx1MiZwiN/aRiFdW5oULjzYCLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5163
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.104
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDguMjAxOSAyMzoxMiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvMjMvMTkg
NToyMiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE0LjA4LjIw
MTkgMTM6MDcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gVG8gZ2V0
IHJpZCBvZiBpbXBsaWNpdCBmaWx0ZXJzIHJlbGF0ZWQgd29ya2Fyb3VuZHMgaW4gZnV0dXJlIGxl
dCdzDQo+Pj4gZGVwcmVjYXRlIHRoZW0gbm93Lg0KPj4NCj4+IEludGVyZXN0aW5nLCBjb3VsZCB3
ZSBkZXByZWNhdGUgaW1wbGljaXQgZmlsdGVyIHdpdGhvdXQgZGVwcmVjYXRpb24gb2YgdW5uZWNl
c3NpdHkgb2YNCj4+IHBhcmFtZXRlcj8gQXMgYWN0dWFsbHksIGl0J3MgZ29vZCB3aGVuIHRoaXMg
cGFyYW1ldGVyIGlzIG5vdCBuZWNlc3NhcnksIGluIG1vc3QgY2FzZXMNCj4+IHVzZXIgaXMgbm90
IGludGVyZXN0ZWQgaW4gbm9kZS1uYW1lLg0KPj4NCj4gDQo+IGh0dHBzOi8vZW4ud2lrdGlvbmFy
eS5vcmcvd2lraS91bm5lY2Vzc2l0eSAtLSBJIGFtIHN1cnByaXNlZCB0byBsZWFybg0KPiB0aGF0
IHRoaXMgYSByZWFsIHdvcmQgaW4gdGhlIGxhbmd1YWdlIEkgc3BlYWsuIDopDQo+IA0KPiBJIGFz
c3VtZSB5b3UncmUgcmVmZXJyaW5nIHRvIG1ha2luZyB0aGUgb3B0aW9uYWwgYXJndW1lbnQgbWFu
ZGF0b3J5Lg0KDQpleGFjdGx5LCBpdCdzIG15IGEgYml0ICJnb29nbGUtdHJhbnNsYXRlLWRyaXZl
biIgRW5nbGlzaCkNCg0KPiANCj4+IE9idmlvdXNseSB3ZSBjYW4gZG8gdGhlIGZvbGxvd2luZzoN
Cj4+DQo+PiAxLiBJbiA0LjIgd2UgZGVwcmVjYXRlIHVubmVjZXNzaXR5LCB3aGljaCBpbXBsaWVz
IGRlcHJlY2F0aW9uIG9mIGltcGxpY2l0IGZpbHRlcnMNCj4+IDIuIEFmdGVyIHNvbWUgcmVsZWFz
ZXMgaW4gNC54IHdlIGNhbiBkcm9wIGRlcHJlY2F0ZWQgZnVuY3Rpb25hbGl0eSwgc28gd2UgZHJv
cCBpdCB0b2dldGhlciB3aXRoDQo+PiBpbXBsaWNpdCBmaWx0ZXJzLiBBbmQsIGluIHNhbWUgcmVs
ZWFzZSA0Lnggd2UgcmV0dXJuIGl0IGJhY2sgKGFzIGl0J3MgY29tcGF0aWJsZSBjaGFuZ2UgOikN
Cj4+IGJ1dCB3aXRob3V0IGltcGxpY2l0IGZpbHRlcnMgKHNvLCBpZiBmaWx0ZXItbm9kZS1uYW1l
IG5vdCBzcGVjaWZpZWQsIHdlIGp1c3QgY3JlYXRlDQo+PiBleHBsaWNpdCBmaWx0ZXIgd2l0aCBh
dXRvZ2VuZXJhdGVkIG5vZGUtbmFtZSkNCj4+DQo+PiBTbywgZWZmZWN0aXZlbHkgd2UganVzdCBk
cm9wICJkZXByZWNhdGlvbiBtYXJrIiB0b2dldGhlciB3aXRoIGltcGxpY2l0IGZpbHRlcnMsIHdo
aWNoIGlzIG5pY2UNCj4+IGJ1dCBhY3R1YWxseSBjb25mdXNpbmcuDQo+Pg0KPj4gSW5zdGVhZCwg
d2UgbWF5IGRvDQo+PiAxLiBJbiA0LjIgZGVwcmVjYXRlDQo+PiAyLiBJbiA0LnggZHJvcCBvcHRp
b25hbGl0eSB0b2dldGhlciB3aXRoIGltcGxpY2l0IGZpbHRlcnMNCj4+IDMuIEluIDQueSAoeSA+
IHggb2YgY291cnNlKSByZXR1cm4gb3B0aW9uYWxpdHkgYmFjaw0KPj4NCj4gDQo+IEFoLCBJIHNl
ZSB3aGF0IHlvdSdyZSBkaWdnaW5nIGF0IGhlcmUgbm93Li4uDQo+IA0KPj4gSXQncyBhIGJpdCBz
YWZlciwgYnV0IGZvciB1c2VycyB3aG8gbWlzcyByZWxlYXNlcyBbNC54LCA0LnkpIGl0J3Mgbm8g
ZGlmZmVyZW5jZS4uDQo+Pg0KPj4gT3Igd2UganVzdCB3cml0ZSBpbiBzcGVjLCB0aGF0IGltcGxp
Y2l0IGZpbHRlcnMgYXJlIGRlcHJlY2F0ZWQ/IEJ1dCB3ZSBoYXZlIG5vdGhpbmcgYWJvdXQgaW1w
bGljaXQNCj4+IGZpbHRlcnMgaW4gc3BlYy4gTW9yZSBvdmVyLCB3ZSBkaXJlY3RseSB3cml0ZSB0
aGF0IHdlIGhhdmUgZmlsdGVyLCBhbmQgaWYgcGFyYW1ldGVyIGlzIG9taXR0ZWQNCj4+IGl0J3Mg
bm9kZS1uYW1lIGlzIGF1dG9nZW5lcmF0ZWQuIFNvIGFjdHVhbGx5LCB0aGUgZmFjdCB0aGUgZmls
dGVyIGlzIGhpZGRlbiB3aGVuIGZpbHRlci1ub2RlLW5hbWUgaXMNCj4+IHVuc3BlY2lmaWVkIGlz
IF91bmRvY3VtZW50ZWRfLg0KPj4NCj4+IFNvLCBmaW5hbGx5LCBpdCBsb29rcyBsaWtlIG5vdGhp
bmcgdG8gZGVwcmVjYXRlZCBpbiBzcGVjaWZpY2F0aW9uLCB3ZSBjYW4ganVzdCBkcm9wIGltcGxp
Y2l0IGZpbHRlcnMgOikNCj4+DQo+PiBXaGF0IGRvIHlvdSB0aGluaz8NCj4+DQo+IA0KPiBXaGF0
IGV4YWN0bHkgX0lTXyBhbiBpbXBsaWNpdCBmaWx0ZXI/IEhvdyBkb2VzIGl0IGRpZmZlciB0b2Rh
eSBmcm9tIGFuDQo+IGV4cGxpY2l0IGZpbHRlcj8gSSBhc3N1bWVkIHRoZSBvbmx5IGRpZmZlcmVu
Y2Ugd2FzIGlmIGl0IHdhcyBuYW1lZCBvcg0KPiBub3Q7IGJ1dCBJIHRoaW5rIEkgbXVzdCBiZSBt
aXN0YWtlbiBub3cgaWYgeW91J3JlIHByb3Bvc2luZyBsZWF2aW5nIHRoZQ0KPiBpbnRlcmZhY2Ug
YWxvbmUgZW50aXJlbHkuDQo+IA0KPiBBcmUgdGhleSBpbnN0YW50aWF0ZWQgZGlmZmVyZW50bHk/
DQo+IA0KDQpBcyBJIHVuZGVyc3RhbmQsIHRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgdGhlaXIgQmxv
Y2tEcml2ZXJTdGF0ZS5pbXBpY2l0IGZpZWxkLCBhbmQgc2V2ZXJhbCBwbGFjZXMgaW4gY29kZQ0K
d2hlcmUgd2Ugc2tpcCBpbXBsaWNpdCBmaWx0ZXIgd2hlbiB0cnlpbmcgdG8gZmluZCBzb21ldGhp
bmcgaW4gYSBjaGFpbiBzdGFydGluZyBmcm9tIGEgZGV2aWNlLg0KDQpIbW0sIE9LLCBsZXQncyBz
ZWU6DQoNCjEuIHRoZSBvbmx5IGltcGxpY2l0IGZpbHRlcnMgYXJlIGNvbW1pdF90b3AgYW5kIG1p
cnJvcl90b3AgaWYgdXNlciBkb24ndCBzcGVjaWZ5IGZpbHRlci1ub2RlLW5hbWUuDQoNCldoZXJl
IGl0IG1ha2Ugc2Vuc2UsIGkuZS4sIHdoZXJlIGltcGxpY2l0IGZpZWxkIHVzZWQ/DQoNCjIuIGJk
cnZfcXVlcnlfaW5mbywgYmRydl9xdWVyeV9iZHNfc3RhdHMsIGJkcnZfYmxvY2tfZGV2aWNlX2lu
Zm8ob25seSB3aGVuIGNhbGxlZCBmcm9tIGJkcnZfcXVlcnlfaW5mbyksIHRoZXknbGwNCnJlcG9y
dCBmaWx0ZXIgYXMgdG9wIG5vZGUgaWYgd2UgZG9uJ3QgbWFyayBpdCBpbXBsaWNpdC4NCg0KMy4g
YmRydl9yZWZyZXNoX2ZpbGVuYW1lLCBiZHJ2X3Jlb3Blbl9wYXJzZV9iYWNraW5nLCBiZHJ2X2Ry
b3BfaW50ZXJtZWRpYXRlOg0KICAgSSB0aGluayBpdCdzIG5vdCBhIHByb2JsZW0sIGp1c3QgZHJv
cCBzcGVjaWFsIGNhc2UgZm9yIGltcGxpY2l0IGZpdGxlcnMNCg0KU28sIHNlZW1zIHRoZSBvbmx5
IHJlYWwgY2hhbmdlIGlzIHF1ZXJ5LWJsb2NrIGFuZCBxdWVyeS1ibG9ja3N0YXRzIG91dHB1dCB3
aGVuIG1pcnJvciBvciBjb21taXQgaXMgc3RhcnRlZA0Kd2l0aG91dCBzcGVjaWZ5aW5nIGZpbHRl
ci1ub2RlLW5hbWUgKGZpbHRlciB3b3VsZCBiZSBvbiB0b3ApDQoNClNvLCBob3cgc2hvdWxkIHdl
IGRlcHJlY2F0ZSB0aGlzLCBvciBjYW4gd2UganVzdCBjaGFuZ2UgaXQ/DQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

