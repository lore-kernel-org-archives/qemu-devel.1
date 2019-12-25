Return-Path: <SRS0=MlkC=2P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD4C2D0DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 16:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ED32072A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RZbFb/YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ED32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ik9IG-0006jW-B3
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 11:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ik9Hc-0006Fk-I6
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 11:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ik9Ha-00058y-U5
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 11:13:12 -0500
Received: from mail-eopbgr20138.outbound.protection.outlook.com
 ([40.107.2.138]:48726 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ik9HX-000556-6C; Wed, 25 Dec 2019 11:13:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqWIInvMiyUlydEpzGfoyJA9lQ7LFZEWqxNqEPkDltrYG8gNz8C2a2ygPvJE1HxoMjnqdDNzZwtWeGtC1msWWwAWUvxQp9VqNT4+z9Yle0IJ13bz53wX0ftCV2oBkK7kbPKh9EGnBYdshFRiVgNVTY4u0JhEIg3M/D4bTPGGthTGPfpbtKl02QXV/5DcIq370CHrO4OIsIJ7S6lu7yjWIIiQ4Z533+5gbnH3/B5wbAPMTaw2bkKjen3JNBe6x0b2FRedTy6MziAylo3k8hlN/dfW2V8GzA3UTxirt0hMK6RwuX7TJJZf6zhrWQxqJ8X7KiK16LHNR5CP2KMFtFwIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fokCy6EHTAtDTunI3HVRrUagxuFlPV86lqEB99t33KI=;
 b=J/vPbOeb6/Yac3tG8c0IB5gQTbfMrxrC8BJkMG3QfWDj8ACKyK6swh1TPrkXkTlQxNcdKveIJ7B0/gy7ixx7Cw/eGt7kRInwTybaFL0woL/CJSJsAshbD7g1CRvsm2HVXunfR+QsW9ruCo+SYJhO7+fm9C37qWtIsEF5NX257EP4yMQy1akk7j5o8lA1D4kr3N8nPoHsOVCyr7K+HQ/n43a4vxaJYXnvNIAH6gIyT833lEEEbieB5kyYcMMPGz8tVR7oLVCApUKQT5V/HRlSx9lQhnp6u8c56LHvt6HR7T1Sb8wl4dH/9u5m0z+37JMqY/qvI20JHzR6B17/M9gTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fokCy6EHTAtDTunI3HVRrUagxuFlPV86lqEB99t33KI=;
 b=RZbFb/YEwqvqer0l1GF5pyIGfQ+xK829JA+ZVux4u4Pejozr12fhDfVC/mRbA9HEXVzH2FJz5GTVshpw0LXmctx9GUpdPzj1Q6XfQoT0ZQpOxs/ROJJCc5oHz/tP7RJEeS8so+P4GwXH6u9h/baykvIqrPVEBzio9lqELVqD8ls=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3030.eurprd08.prod.outlook.com (52.135.164.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Wed, 25 Dec 2019 16:13:03 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 16:13:02 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:7:67::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.8 via Frontend Transport; Wed, 25 Dec 2019 16:13:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Topic: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Index: AQHVtnnxYNIeaG1fgkq9lkIsLWKUC6fBiECAgAAE4wCAAAIuAIAABLsAgAAN2ICAAfQVgIAHeWyA
Date: Wed, 25 Dec 2019 16:13:02 +0000
Message-ID: <8fc38576-2e01-5fcb-3442-381880fe75b0@virtuozzo.com>
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
 <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
 <0d6ea2fe-2f4f-00d4-2f13-20591b56310d@virtuozzo.com>
 <CAMRbyys6na7S4q00VR81LNhfNvtEXUAFQV=2R1O506+p_U+VKA@mail.gmail.com>
 <6a3120ba-fcb1-568c-5e1c-8226623e416b@redhat.com>
In-Reply-To: <6a3120ba-fcb1-568c-5e1c-8226623e416b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:7:67::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191225191259716
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aea693c-6335-4541-2238-08d7895550e5
x-ms-traffictypediagnostic: AM6PR08MB3030:
x-microsoft-antispam-prvs: <AM6PR08MB3030E4DB5D618CCD10BD4CC9C1280@AM6PR08MB3030.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39840400004)(376002)(366004)(136003)(199004)(189003)(186003)(53546011)(110136005)(5660300002)(8676002)(31686004)(81166006)(2616005)(956004)(71200400001)(81156014)(6486002)(54906003)(316002)(16526019)(52116002)(16576012)(8936002)(2906002)(66476007)(66946007)(31696002)(4326008)(64756008)(66556008)(66446008)(26005)(478600001)(86362001)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3030;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTkliLKz6gkFqxbDDaXv7eyyRXrhKe0gVqTFyTX5r6tGsRfdoatQVkzSf2HSlewCE3VgGVvhkE/8EpBoj5X2QJ1qddS7zuNlHWl469QSU5/5jD56NZWcbUgnVqANQP6r4HOAj8+laT6LugFwQsWF5Kb3/24BtF01wWkI3cFO6Ch0IGBocjcBzo6yRP+qQzDUQjCngNU7DwujLRhg2Y5OervGcuiSvLiD5I2iul1sxvq3DqgKiEGb68rUZaZ71jEQSfjt+G6Wux1lwocioXIt49zozdyQCiCs/hIO5OgmtVv3BZeCwR0jr20uk2+e+lfp8zN/hqh749QCZnKXdTQkpV0ZEj3/iUPqsfVkIAionKXUyLSIEC4Ydn0Av3CnWltM1hn0vrpbTkpRuW9OIzKWfTUH5rvJmITqU+npa9ogfbrqSC7zGRDx3QFDKjcTVfp5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB90EB0B0872944FBA65985C89133052@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aea693c-6335-4541-2238-08d7895550e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 16:13:02.4770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dx9MHp1TUkOcYVMiNKx70BatILEZBQA2p0RXhoj+acKa3pLmTh8Uud9F93jcr3MkovYSVYRA5QQNTrdpNGyvfRUOz9zIE2kb3QJVj7rn0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.138
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMTIuMjAxOSAxOjA0LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiAxMi8xOS8xOSAxMDoxNCBB
TSwgTmlyIFNvZmZlciB3cm90ZToNCj4gDQo+Pj4+PiAxLiBVc2luZyBkaXNrIG5hbWUgYXMgYSBi
aXRtYXAgbmFtZSBpcyBhIGJhZCBiZWhhdmlvciwgYXMgdGhleSBhcmUgY29tcGxldGVseQ0KPj4+
Pj4gZGlmZmVyZW50IGNvbmNlcHRzLiBFc3BlY2lhbGx5IGtlZXBpbmcgaW4gbWluZCB0aGF0IHVz
ZXIgYWxyZWFkeSBrbm93cyBkaXNrIG5hbWUgYW55d2F5DQo+Pj4+PiBhbmQgbm8gcmVhc29uIHRv
IHdyaXRlIHRoaXMgZXhwb3J0IG5hbWUgaW5zaWRlIG1ldGFkYXRhIGNvbnRleHQgb2YgdGhpcyBl
eHBvcnQuDQo+Pj4+DQo+Pj4+IFRoZSBkaWZmZXJlbnQgY29uY2VwdCBpcyBleHByZXNzZWQgYnkg
dGhlICJxZW11OmRpcnR5LWJpdG1hcDoiIHByZWZpeC4NCj4+Pj4gInFlbXU6ZGlydHktYml0bWFw
OmV4cG9ydC1uYW1lIiBtZWFucyB0aGUgZGlydHkgYml0bWFwIGZvciB0aGlzIGV4cG9ydC4NCj4+
Pg0KPj4+IFdoeSBkbyB5b3UgdGhpbmsgc28/IERpZCB5b3UgcmVhZCBOQkQgc3BlY2lmaWNhdGlv
bj8NCj4+DQo+PiBZZXMgLSB0aGUgbmFtZSBvZiB0aGUgYml0bWFwIGRvZXMgbm90IGhhdmUgYW55
IG1lYW5pbmcuDQo+PiBCdXQgZm9yIG5iZF9zZXJ2ZXJfYWRkIHdlIGFsbG93IG9ubHkgc2luZ2xl
IGJpdG1hcCBmb3IgZXhwb3J0Lg0KPiANCj4gSnVzdCBiZWNhdXNlIHFlbXUgaXMgY3VycmVudGx5
IGxpbWl0ZWQgdG8gb25seSBleHBvc2luZyBvbmUgYml0bWFwIGF0IHRoZSBtb21lbnQgZG9lcyBu
b3QgbWVhbiB0aGF0IGEgZnV0dXJlIHZlcnNpb24gY2FuJ3QgZXhwb3NlIG11bHRpcGxlIGJpdG1h
cHMuIEl0IG1heSB2ZXJ5IHdlbGwgYmUgdGhhdCB3ZSBoYXZlIHJlYXNvbiB0byBleHBvc2UgYm90
aCAicWVtdTpkaXJ0eS1iaXRtYXA6dGltZUEiIGFuZCAicWVtdTpkaXJ0eS1iaXRtYXA6dGltZUIi
IG9uIHRoZSBzYW1lIGV4cG9ydCwgZm9yIGV4cG9zaW5nIHR3byBiaXRtYXBzIGF0IG9uY2UuwqAg
VG8gZ2V0IHRvIHRoYXQgcG9pbnQsIHdlJ2QgaGF2ZSB0byByZWZhY3RvciB0aGUgUUFQSSBjb21t
YW5kIHRvIGFsbG93IGF0dGFjaGluZyBtb3JlIHRoYW4gb25lIGJpdG1hcCBhdCB0aGUgdGltZSBv
ZiBjcmVhdGluZyB0aGUgTkJEIGV4cG9ydCwgYnV0IGl0J3Mgbm90IGltcG9zc2libGUuDQo+IA0K
Pj4NCj4+PiBNZXRhZGF0YSBjb250ZXh0IGlzIGFsd2F5cyBvd25lZCBieSBzb21lIGV4cG9ydC4N
Cj4+DQo+PiBPZiBjb3Vyc2UuDQo+Pg0KPj4+IERvIHlvdSBtZWFuIHRoYXQgdGhlcmUgd2lsbCBi
ZW1ldGFkYXRhIGNvbnRleHRzDQo+Pj4NCj4+PiBxZW11OmRpcnR5LWJpdG1hcDpleHBvcnQtQQ0K
Pj4+IHFlbXU6ZGlydHktYml0bWFwOmV4cG9ydC1CDQo+Pj4NCj4+PiBib3RoIGRlZmluZWQgZm9y
IGV4cG9ydC1BPw0KPj4NCj4+IEl0IGRvZXMgbm90IG1ha2Ugc2Vuc2UsIGJ1dCBpdCBpcyB2YWxp
ZC4NCj4gDQo+IElmIGFuIGltYWdlIGhhcyBtdWx0aXBsZSBiaXRtYXBzLCBleHBvc2luZyBhbGwg
b2YgdGhvc2UgYXMgc2VwYXJhdGUgY29udGV4dHMgYXQgdGhlIHNhbWUgdGltZSBmb3IgYSBzaW5n
bGUgZXhwb3J0IGNhbiBpbmRlZWQgbWFrZSBzZW5zZS4NCj4gDQo+Pg0KPj4+Pj4gMi4gSXQncyBu
b3QgZGlyZWN0bHkgZG9jdW1lbnRlZC4gWW91IGFzc3VtZSB0aGF0IE5BTUUgPT0gQG5hbWUuIEkg
dW5kZXJzdGFuZCB0aGF0DQo+Pj4+PiBpdCBtYXkgYmUgYXNzdW1lZC4uIEJ1dCBpdCdzIG5vdCBk
b2N1bWVudGVkLg0KPj4+Pg0KPj4+PiBCdXQgTkFNRSBpcyBsaWtlbHkgdG8gYmUgdW5kZXJzdG9v
ZCBhcyB0aGUgbmFtZSBhcmd1bWVudCwgYW5kIHVubGlrZWx5IHRvIGJlIHRoZQ0KPj4+PiBiaXRt
YXAgbmFtZS4NCj4+Pg0KPj4+IFllcyBsaWtlbHkuIEJ1dCBpdCdzIHN0aWxsIGJhZCBzcGVjaWZp
Y2F0aW9uLCB3aGljaCBzaG91bGQgYmUgZml4ZWQuDQo+Pg0KPj4gSWYgd2UgY2Fubm90IGNoYW5n
ZSB0aGUgY3VycmVudCBiZWhhdmlvciBzaW5jZSBpdCB3aWxsIGJyZWFrIGN1cnJlbnQgdXNlcnMs
DQo+PiBJIGFncmVlIGZpeGluZyB0aGUgc3BlYyB0byBkZXNjcmliZSB0aGUgY3VycmVudCBiZWhh
dmlvciBpcyBhIGdvb2QgaWRlYS4NCj4gDQo+IFdlIG5lZWQgdGhlIGRvYyBmaXguIA0KDQpEbyB5
b3UgbGlrZSB0aGUgcGF0Y2ggc3RhcnRpbmcgdGhpcyB0aHJlYWQ/IEl0J3MgYSBmaXggd2UgYXJl
IHRhbGtpbmcgYWJvdXQuLg0KDQo+IFdoZXRoZXIgd2UgYWxzbyB3YW50IGFuIGFkZGl0aW9uYWwg
Zml4IGFkZGluZyBhbiBvcHRpb25hbCBwYXJhbWV0ZXIgYWxsb3dpbmcgdXNlciBjb250cm9sIG92
ZXIgdGhlIGV4cG9ydCBuYW1lIGlzIGFsc28gdW5kZXIgZGViYXRlICh0aGUgZmFjdCB0aGF0IHRo
ZSBvbGQgeC1uYmQtc2VydmVyLWFkZC1iaXRtYXAgc3VwcG9ydGVkIGl0IHNob3dzIHRoYXQgaXQg
bWF5IGJlIHVzZWZ1bCwgYnV0IGl0IGlzIG5vdCBtaW5pbWFsLCBhbmQgYXMgSSBwb2ludGVkIG91
dCBhdCB0aGUgdGltZSBvZiByZW1vdmluZyB4LSwgbGlidmlydCBjYW4gYWx3YXlzIGNvbnRyb2wg
d2hhdCBuYW1lIGlzIGV4cG9zZWQgYnkgY3JlYXRpbmcgYSB0ZW1wb3JhcnkgYml0bWFwIGFuZCBt
ZXJnaW5nIGZyb20gb3RoZXIgYml0bWFwcyBpbnRvIHRoZSB0ZW1wb3JhcnkpLg0KPiANCj4gV2Ug
YWxzbyBoYXZlIHRvIHRoaW5rIGFib3V0IGEgZnV0dXJlIG9mIHBhcmFsbGVsIGJhY2t1cCBqb2Jz
OiBsaWJ2aXJ0IGNhbiBjcmVhdGUgYSBzaW5nbGUgdGVtcG9yYXJ5IGJpdG1hcCB0byBleHBvc2Ug
d2hhdGV2ZXIgbmFtZSBpdCB3YW50cyB1bmRlciBvbmUgam9iLCBidXQgaWYgbGlidmlydCB3YW50
cyB0byBleHBvc2UgdGhlIFNBTUUgdXNlci12aXNpYmxlIG5hbWUgdG8gdHdvIHBhcmFsbGVsIGpv
YnMsIGl0IGNhbm5vdCBjcmVhdGUgdHdvIGJpdG1hcHMgd2l0aCB0aGUgc2FtZSBuYW1lLCBzbyBo
YXZpbmcgYSB3YXkgdG8gc2V0IHRoZSB1c2VyLXZpc2libGUgbmFtZSBvZiBhbiBhcmJpdHJhcnkg
Yml0bWFwIHdoZW4gcHJvZHVjaW5nIHRoZSBOQkQgZXhwb3J0IG1ha2VzIHNlbnNlIG9uIHRoYXQg
ZnJvbnQuDQo+IA0KPiANCj4+Pj4NCj4+Pj4+IDMuIEl0J3MgbmV2ZXIgd29ya2VkIGxpa2UgeW91
IHdyaXRlLiBTbyBpZiB3ZSBjaGFuZ2UgdGhlIGJlaGF2aW9yLCB3ZSdsbCBicmVhaw0KPj4+Pj4g
ZXhpc3RpbmcgdXNlcnMuDQo+Pj4+DQo+Pj4+IERvIHdlIGhhdmUgZXhpc3RpbmcgdXNlcnM/IGlz
bid0IHRoaXMgbmV3IGZlYXR1cmUgaW4gNC4yPw0KPj4+DQo+Pj4gTm8sIGl0J3Mgc2luY2UgNC4w
DQo+IA0KPiBBcyBsb25nIGFzIGFsdGVyaW5nIHRoZSBleHBvcnRlZCBuYW1lIGlzIGNvbnRyb2xs
ZWQgYnkgYSBuZXcgb3B0aW9uYWwgcGFyYW1ldGVyLCBpdCBkb2VzIG5vdCBodXJ0IG9sZGVyIDQu
MCBjbGllbnRzIHRoYXQgZG8gbm90IHVzZSB0aGUgbmV3IHBhcmFtZXRlci4NCj4gDQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

