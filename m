Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CCBC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC75206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ITHE6Xzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC75206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHm0X-0007RO-31
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlzQ-0006Mc-Dx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlzP-0005Kt-90
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:41:08 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com
 ([40.107.2.126]:47943 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHlzL-0005Em-QD; Tue, 08 Oct 2019 05:41:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0DiA9TencsjBqBQf08RYseHq3dvv/7kbpcVTtoMcnlSR3Caiv3ilubLqkXE7x38Wz/mwijtGzpofL17ev3dQdFuWKk4ucTNMY2m4DSlydPvOiUuCyXlT6n814l14vm4gqzLDBDeusnKQFkJngZdMjPiVmjiWDFGsW2vV0ODyqDmHkO2uXbcq2TTV5886b60ieIbpmccWY2O4am4PLEJqBOSILcIu+yjwft+nbh8aqUL69oy8iYfSSdzvqiYNqnKKzwFJStFdZrFyOdpqjBUmFetwnYbg/zv2jfx6GnR96bxTPrmazZ3Y4yYTPVbHZPc0f2iN85G8BJdTdfji/APSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duydPSlITxzm8pmHlQ/qi1vIZlNEkeK/R7Tc8VCFAic=;
 b=VfaDmL8IOTfjSJD+8C89DhUDuz+acRPOI8/P42erWuX+RAQjHtzmLeljP+MZkXp67qpwr+SKqOW6erNnu5C8SJxlZQPiFAvsmq/XAsebCagkjBtRRtFTtZq+VYwZ9iRHI74BIZsTEqFRpqLAA31FZ/9c3o4onh4vvO64dRkA+F5WWU6S49jDJwHGRxlJD/GiVNF8jhnxYtD2tadJ7T4zspfSr4CCHDRoGKMjDpHRAHOHastoSj4wCXSqI37AMCtCzdKQArkfirAA71Ag3oI192q3Wxr3BIJISwH/2Jga8Qd/UsGZcgYlz3JeqAmEGRB951LCKeCAJ7Z1qKtlKkjF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duydPSlITxzm8pmHlQ/qi1vIZlNEkeK/R7Tc8VCFAic=;
 b=ITHE6XzvLkxk6tcRgnPv0lXuok/2MHpK2uMrahUPq4MClwZEvtuUyMPRGijUjVx/SyNCKEuuB4mw74hTxaxxp7SGG2qWIm0nEAGIHOTFsBYUhAEFu/U3JHGcOVcLUIIKWzSBwJeeM4lK+AC63vd9gj0+2psHoTbFm0up7TGuvVs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5385.eurprd08.prod.outlook.com (52.133.241.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 09:40:59 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 09:40:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
Thread-Topic: [PATCH] qemu-nbd: Document benefit of --pid-file
Thread-Index: AQHVfUg6+Pk7KfOVdEyr6uO98fDVoadQeeUAgAAEg4A=
Date: Tue, 8 Oct 2019 09:40:59 +0000
Message-ID: <04440b88-78f6-e177-924d-e16fc3c29b5c@virtuozzo.com>
References: <20191007194840.29518-1-eblake@redhat.com>
 <20191008092448.GD1192@redhat.com>
In-Reply-To: <20191008092448.GD1192@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008124057521
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ec92ea7-df03-46a4-1a94-08d74bd3a038
x-ms-traffictypediagnostic: DB8PR08MB5385:
x-microsoft-antispam-prvs: <DB8PR08MB53850493B3CB6BE25494851FC19A0@DB8PR08MB5385.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(136003)(376002)(366004)(189003)(199004)(186003)(99286004)(6506007)(76176011)(386003)(3846002)(31686004)(52116002)(6116002)(256004)(2906002)(305945005)(7736002)(102836004)(14444005)(26005)(66946007)(4326008)(478600001)(5660300002)(6512007)(6246003)(25786009)(66066001)(81156014)(81166006)(8676002)(64756008)(66556008)(66446008)(8936002)(2616005)(11346002)(6486002)(476003)(446003)(14454004)(66476007)(6436002)(486006)(31696002)(71200400001)(71190400001)(86362001)(229853002)(36756003)(110136005)(316002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5385;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfnJLTYZk0aKHcAu4H694AJjubBKLaL633822oQdVTKnNWJrHBAoNB/fMFTLAnxIetFu4j5Nz9RDPa5kNJoylT+3U4XkXnmzUWu/IuEqNDedbo5ofPfHGmvJ/7UixLvs6rYW+VqZWernnLoeGiH8AwZbxyei6+DtvXfTme5MYQKP+rwSrmlHelXWYV5ZvGMwO108/FvYNNkPSpX71pJ5P3WeBzrbuBky8iVlfwK2PZkf67umIN1B6TzWpHbIth8HcX9oEy1y7TxTwDWoO1YSz1sGdK3qnytHQfTyOuk9o8o2TZGt+J/0PBgvpd/afzla+k51pMp6LM/gYp32jNvZE7Gq2U9Sd9dud3SVulzlnGO2ZsKTfOrkhFgTtkI3tzfQs+gvY2+T7dHmBDm3EFLb1HqwahfchmlPNaoTofZaFTI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8006192F0D118E4098C8F14D66312B86@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec92ea7-df03-46a4-1a94-08d74bd3a038
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 09:40:59.5539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRER1F4NLWjS2RzDDGpwUCtLki6d9hmNZaOZuzIZuRqx2FBvlWOCOggaarVGyrSKx0P1JxbjcoLRx1YQcdWNt5oHqamHmgj1nKTTWn4E88M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5385
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.126
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxMjoyNCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gTW9uLCBP
Y3QgMDcsIDIwMTkgYXQgMDI6NDg6NDBQTSAtMDUwMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9u
ZSBiZW5lZml0IG9mIC0tcGlkLWZpbGUgaXMgdGhhdCBpdCBpcyBlYXNpZXIgdG8gcHJvYmUgdGhl
IGZpbGUNCj4+IHN5c3RlbSB0byBzZWUgaWYgYSBwaWQgZmlsZSBoYXMgYmVlbiBjcmVhdGVkIHRo
YW4gaXQgaXMgdG8gcHJvYmUgaWYgYQ0KPj4gc29ja2V0IGlzIGF2YWlsYWJsZSBmb3IgY29ubmVj
dGlvbi4gRG9jdW1lbnQgdGhhdCB0aGlzIGlzIGFuDQo+PiBpbnRlbnRpb25hbCBmZWF0dXJlLg0K
PiANCj4gSSdtIG5vdCBzZWVpbmcgaG93IGNoZWNraW5nIHRoZSBwaWQgZmlsZSBpcyBiZXR0ZXIg
dGhhbiBjaGVja2luZw0KPiB0aGUgc29ja2V0IGRpcmVjdGx5ID8gSSB0aGluayBpdCBpcyBwcm9i
YWJseSBhY3R1YWxseSB3b3JzZS4NCj4gDQo+IFRoZSBtYWluIHByb2JsZW0gd2l0aCB0aGUgc29j
a2V0IGlzIHRoYXQgd2hpbGUgd2UgdW5saW5rIG9uIGNsZWFuDQo+IHNodXRkb3duLCBpdCBtYXkg
c3RpbGwgZXhpc3QgaW4gZGlzayBpZiB0aGUgcHJvY2VzcyBoYXMgZXhpdHRlZA0KPiBhYm5vcm1h
bGx5Lg0KPiANCj4gV2l0aCB0aGUgcGlkZmlsZSB0aG91Z2ggd2UgZG9uJ3QgZXZlciB1bmxpbmsg
aXQsIGV2ZW4gb24gY2xlYW4NCj4gc2h1dGRvd24sIGFzIHdlIGRvbid0IHVzZSB0aGUgcGlkIGZp
bGVzIGV4aXN0YW5jZSBhcyBhIG11dHVhbA0KPiBleGNsdXNpb24gY2hlY2suIFdlIGluc3RlYWQg
YWNxdWlyZSBmY250bCBsb2NrcyBvbiBpdC4NCj4gDQo+IElPVyB0aGUgcGlkZmlsZSBjb3VsZCBl
eGlzdCBhbHJlYWR5IHdoZW4gcWVtdS1uYmQgc3RhcnRzIHVwIGFuZA0KPiB3aWxsIHN0aWxsIGV4
aXN0IHdoZW4gaXQgcXVpdHMuDQoNCkdvb2QgcG9pbnQuDQoNCkkgd2FzIGp1c3QgYSBiaXQgY29u
ZnVzZWQsIGJlY2F1c2UgcGlkIGZpbGUgaXMgc29tZXRoaW5nIHVucmVsYXRlZCB0bw0Kc29ja2V0
LCBhbmQgd2h5IHVzZSBvbmUgdGhpbmcgdG8gY2hlY2sgdGhlIGV4aXN0ZW5jZSBvZiBhbm90aGVy
LCBpZiB3ZQ0KY2FuIGRpcmVjdGx5IHRyeSB0byBjb25uZWN0Lg0KDQo+IA0KPj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgcWVtdS1u
YmQudGV4aSB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcWVtdS1uYmQudGV4aSBiL3FlbXUtbmJk
LnRleGkNCj4+IGluZGV4IDdmNTU2NTc3MjJiZC4uZDQ5NWJiZThhMGVkIDEwMDY0NA0KPj4gLS0t
IGEvcWVtdS1uYmQudGV4aQ0KPj4gKysrIGIvcWVtdS1uYmQudGV4aQ0KPj4gQEAgLTExOCw3ICsx
MTgsOCBAQCBpbiBsaXN0IG1vZGUuDQo+PiAgIEBpdGVtIC0tZm9yaw0KPj4gICBGb3JrIG9mZiB0
aGUgc2VydmVyIHByb2Nlc3MgYW5kIGV4aXQgdGhlIHBhcmVudCBvbmNlIHRoZSBzZXJ2ZXIgaXMg
cnVubmluZy4NCj4+ICAgQGl0ZW0gLS1waWQtZmlsZT1QQVRIDQo+PiAtU3RvcmUgdGhlIHNlcnZl
cidzIHByb2Nlc3MgSUQgaW4gdGhlIGdpdmVuIGZpbGUuDQo+PiArU3RvcmUgdGhlIHNlcnZlcidz
IHByb2Nlc3MgSUQgaW4gdGhlIGdpdmVuIGZpbGUuICBUaGUgcGlkIGZpbGUgaXMgbm90DQo+PiAr
Y3JlYXRlZCB1bnRpbCBhZnRlciB0aGUgc2VydmVyIHNvY2tldCBpcyBvcGVuLg0KPj4gICBAaXRl
bSAtLXRscy1hdXRoej1JRA0KPj4gICBTcGVjaWZ5IHRoZSBJRCBvZiBhIHFhdXRoeiBvYmplY3Qg
cHJldmlvdXNseSBjcmVhdGVkIHdpdGggdGhlDQo+PiAgIC0tb2JqZWN0IG9wdGlvbi4gVGhpcyB3
aWxsIGJlIHVzZWQgdG8gYXV0aG9yaXplIGNvbm5lY3RpbmcgdXNlcnMNCj4+IC0tIA0KPj4gMi4y
MS4wDQo+Pg0KPj4NCj4gDQo+IFJlZ2FyZHMsDQo+IERhbmllbA0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

