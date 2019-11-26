Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8592075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WLAvl/Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8592075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZVG9-0001t7-7E
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZVEt-0001LT-0h
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZVEr-0005eq-Bw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:26:22 -0500
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:59363 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZVEq-0005da-C5; Tue, 26 Nov 2019 02:26:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uai6OhFwwKdl/9HER2teXE8gsZD1vgMvdz/p2j6KByoTYDMRsRtoSpYN0BPfBfx6k++JRPydu2dECLMq34sCZF+WcZEgahvX0bBLJgzyzdjou8fkoeBHNI2p5d9Rimm0GVk3R7AYTCGmSYeSh4s/IEhWpiLCK8/US3mgdX9xeoUZAt3vTdDKrGtFLDnorkPIyjdB8oMPoUi0uOQ0kWj5/xkIwWtI+RmSAJf7m9zpMHBreQLS2D8NHDWy5acALm2D75CP4ToKfFqwmsq0+9pKqXMJIe2f/MZWG/7z12f9iQWc2pceMEUbB1diDeM38AQ/SsBIO6AUAyI0WsuDyOoYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkKSxpZ9nlocEB7hYAtmuyJpG9doykB4RnnO3gYHwNo=;
 b=iwy4Ut6qiTDhDzwfLD6UuExjd0VC714vazmjLXpi7QVUE7alQohShpPOgEUNuQ/swVXJOEUPdeIpA9Vv6wvnvwWw/D4BezsQUVeSnGkxwsapy0dW5pb4M3MVhpnakltTdAg8CH3015F24jsdVloCYYrZ6eILZg2wvGGVM2yX77lY3o40Ja57e8UGYvOUdGgPFpYSZS96z83ew5hYMKISfaT/xP1Z0dGDS9S+x5pbwoEAK4ZKX0Otd0e24pW+p8mu6O1Jgla6Kjm84L9/bOYT803wwUMts81AqrGacnSXaxNgFllU6NfB9JG5SIopBMorgvMs+sa3GZ/jSiqmsymu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkKSxpZ9nlocEB7hYAtmuyJpG9doykB4RnnO3gYHwNo=;
 b=WLAvl/RpRj6iR26InCkD/9K9N49N6nC724OmM3VcR2xzIeGrZnLttZ1u5T9ePlM0+2dhnW+Oa0nBINi0N6tD6evNWwo81kWkgb0fw1WHhR6L8/sIRSbotSo8EnbaOnHK1XlS45ZDvREwvVYDyOlI4wVRAuGsGpDQdvmb7d6Mow4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3398.eurprd08.prod.outlook.com (20.177.115.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 07:26:17 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 07:26:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/4] block/io: fix bdrv_co_block_status_above
Thread-Topic: [PATCH 1/4] block/io: fix bdrv_co_block_status_above
Thread-Index: AQHVnJu1p2JJSsZEOUKScvlzR8JCBKecGbyAgAECnQA=
Date: Tue, 26 Nov 2019 07:26:16 +0000
Message-ID: <91f61957-33ec-ea91-d0c4-f555199c4d69@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191116163410.12129-2-vsementsov@virtuozzo.com>
 <20191125160037.GD4638@linux.fritz.box>
In-Reply-To: <20191125160037.GD4638@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0052.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191126102614928
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52f78861-17ae-4f4e-e963-08d77241ec98
x-ms-traffictypediagnostic: AM6PR08MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB33986623E74322E71CC2631AC1450@AM6PR08MB3398.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(39840400004)(376002)(51444003)(189003)(199004)(11346002)(31696002)(86362001)(2616005)(446003)(229853002)(305945005)(6116002)(3846002)(7736002)(186003)(66446008)(64756008)(66556008)(5660300002)(66946007)(6246003)(81156014)(8676002)(26005)(36756003)(14444005)(66066001)(52116002)(8936002)(256004)(478600001)(102836004)(81166006)(54906003)(71190400001)(6486002)(6436002)(71200400001)(316002)(14454004)(25786009)(2906002)(99286004)(386003)(6916009)(6506007)(66476007)(107886003)(4326008)(31686004)(6512007)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3398;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZJsDAwAKqn/kcOuE25jQtYleSYoLFTEK95LLWhs0NFbHBdALCzfB50+gWxsH7rsL2Rg+AEYL4gmbGvAIQotcTDZXSUA/QEvHKgoLQfeNooQoSL4I9kG17LBTgUAEWGgNkXnXBszRYfDeMrjYUSEkDp/YTBLujCpXGGgmoJ0zfd37wUU+OqHsZX1my8yrZiRQPS6RmpgktdtWdNIA2ZCzNO0GKswJEs5IXijtJCFo36IMx8mE4U5OxN2O+KgnJulkplUcqGEIvMzJnliyDhTgCUo+Q956dwnJxC5Em9BlzNQsQ6csSnXurs8y34bAqyM9CAGcWUXMX+LWJVfZRNFbR6beY7udzzYpL2Vl0CEXrvHzcN1Ntc3Xgh+739d8eUbtkiWulz3+3EcyRJtttF/mrlG3ht2r+NWnYqfJ5hNoQbOrip/azbo+xrVmvQyOSPN
Content-Type: text/plain; charset="utf-8"
Content-ID: <81CA594005196D4089645C20AFEE4FF9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f78861-17ae-4f4e-e963-08d77241ec98
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 07:26:16.8017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6lXzLVT/TZjHKb5A91/8eC626f5FGZGalULHoTb+e4iRUeNpu7o8Pua1HW93haWoCfjvR6Iu4+ox3vbTz8Mh4WS1+db9Fp79ESxwqCANY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3398
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.129
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMTEuMjAxOSAxOTowMCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTYuMTEuMjAxOSB1bSAx
NzozNCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IGJk
cnZfY29fYmxvY2tfc3RhdHVzX2Fib3ZlIGhhcyBzZXZlcmFsIHByb2JsZW1zIHdpdGggaGFuZGxp
bmcgc2hvcnQNCj4+IGJhY2tpbmcgZmlsZXM6DQo+Pg0KPj4gMS4gV2l0aCB3YW50X3plcm9zPXRy
dWUsIGl0IG1heSByZXR1cm4gcmV0IHdpdGggQkRSVl9CTE9DS19aRVJPIGJ1dA0KPj4gd2l0aG91
dCBCRFJWX0JMT0NLX0FMTE9DQVRFRCBmbGFnLCB3aGVuIGFjdHVhbGx5IHNob3J0IGJhY2tpbmcg
ZmlsZQ0KPj4gd2hpY2ggcHJvZHVjZXMgdGhlc2UgYWZ0ZXItRU9GIHplcm9zIGlzIGluc2lkZSBy
ZXF1ZXN0ZWQgYmFja2luZw0KPj4gc2VxdWVzbmNlLg0KPiANCj4gcy9zZXF1ZXNuY2Uvc2VxdWVu
Y2UvDQo+IA0KPj4NCj4+IDIuIFdpdGggd2FudF96ZXJvcz1mYWxzZSwgaXQgd2lsbCBqdXN0IHN0
b3AgaW5zaWRlIHJlcXVlc3RlZCByZWdpb24sIGlmDQo+PiB3ZSBoYXZlIHVuYWxsb2NhdGVkIHJl
Z2lvbiBpbiB0b3Agbm9kZSB3aGVuIHVuZGVybHlpbmcgYmFja2luZyBpcw0KPj4gc2hvcnQuDQo+
IA0KPiBJIGhvbmVzdGx5IGRvbid0IHVuZGVyc3RhbmQgdGhpcyBvbmUuIENhbiB5b3UgcmVwaHJh
c2UvZXhwbGFpbiBpbiBtb3JlDQo+IGRldGFpbCB3aGF0IHlvdSBtZWFuIGJ5ICJzdG9wIGluc2lk
ZSBbdGhlXSByZXF1ZXN0ZWQgcmVnaW9uIj8NCg0KSG1tLCB5ZXMsIGJhZCBkZXNjcmlwdGlvbi4g
SSBtZWFuLCBpdCBtYXkgcmV0dXJuIHBudW09MCBwcmlvciB0byBhY3R1YWwgRU9GLA0KYmVjYXVz
ZSBvZiBFT0Ygb2Ygc2hvcnQgYmFja2luZyBmaWxlLg0KDQo+IA0KPj4gRml4IHRoZXNlIHRoaW5n
cywgbWFraW5nIGxvZ2ljIGFib3V0IHNob3J0IGJhY2tpbmcgZmlsZXMgY2xlYXJlci4NCj4+DQo+
PiBOb3RlIHRoYXQgMTU0IG91dHB1dCBjaGFuZ2VkLCBiZWNhdXNlIG5vdyBiZHJ2X2Jsb2NrX3N0
YXR1c19hYm92ZSBkb24ndA0KPj4gbWVyZ2UgdW5hbGxvY2F0ZWQgemVyb3Mgd2l0aCB6ZXJvcyBh
ZnRlciBFT0YgKHdoaWNoIGFyZSBhY3R1YWxseQ0KPj4gImFsbG9jYXRlZCIgaW4gUE9WIG9mIHJl
YWQgZnJvbSBiYWNraW5nLWNoYWluIHRvcCkgYW5kIGlzX3plcm8oKSBqdXN0DQo+PiBkb24ndCB1
bmRlcnN0YW5kIHRoYXQgdGhlIHdob2xlIGhlYWQgb3IgdGFpbCBpcyB6ZXJvLiBXZSBtYXkgdXBk
YXRlDQo+PiBpc196ZXJvIHRvIGNhbGwgYmRydl9ibG9ja19zdGF0dXNfYWJvdmUgc2V2ZXJhbCB0
aW1lcywgb3IgYWRkIGZsYWcgdG8NCj4+IGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlIHRoYXQgd2Ug
YXJlIG5vdCBpbnRlcmVzdGVkIGluIEFMTE9DQVRFRCBmbGFnLA0KPj4gc28gcmFuZ2VzIHdpdGgg
ZGlmZmVyZW50IEFMTE9DQVRFRCBzdGF0dXMgbWF5IGJlIG1lcmdlZCwgYnV0IGFjdHVhbGx5LA0K
Pj4gaXQgc2VlbXMgdGhhdCB3ZSdkIGJldHRlciBkb24ndCBjYXJlIGFib3V0IHRoaXMgY29ybmVy
IGNhc2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL2lvLmMgICAg
ICAgICAgICAgICAgIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0N
Cj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE1NC5vdXQgfCAgNCArKy0tDQo+PiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2lvLmMgYi9ibG9jay9pby5jDQo+PiBpbmRleCBmNzU3NzdmNWVhLi40ZDdm
YTk5YmQyIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svaW8uYw0KPj4gKysrIGIvYmxvY2svaW8uYw0K
Pj4gQEAgLTI0MzQsMjUgKzI0MzQsNDQgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmRydl9j
b19ibG9ja19zdGF0dXNfYWJvdmUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICAgICAg
cmV0ID0gYmRydl9jb19ibG9ja19zdGF0dXMocCwgd2FudF96ZXJvLCBvZmZzZXQsIGJ5dGVzLCBw
bnVtLCBtYXAsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZSk7
DQo+PiAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+IC0gICAgICAgICAgICBicmVhazsNCj4+
ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICAgICAgIH0NCj4+IC0gICAgICAgIGlm
IChyZXQgJiBCRFJWX0JMT0NLX1pFUk8gJiYgcmV0ICYgQkRSVl9CTE9DS19FT0YgJiYgIWZpcnN0
KSB7DQo+PiArICAgICAgICBpZiAoKnBudW0gPT0gMCkgew0KPj4gKyAgICAgICAgICAgIGlmIChm
aXJzdCkgew0KPj4gKyAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgICAg
IH0NCj4+ICsNCj4+ICAgICAgICAgICAgICAgLyoNCj4+IC0gICAgICAgICAgICAgKiBSZWFkaW5n
IGJleW9uZCB0aGUgZW5kIG9mIHRoZSBmaWxlIGNvbnRpbnVlcyB0byByZWFkDQo+PiAtICAgICAg
ICAgICAgICogemVyb2VzLCBidXQgd2UgY2FuIG9ubHkgd2lkZW4gdGhlIHJlc3VsdCB0byB0aGUN
Cj4+IC0gICAgICAgICAgICAgKiB1bmFsbG9jYXRlZCBsZW5ndGggd2UgbGVhcm5lZCBmcm9tIGFu
IGVhcmxpZXINCj4+IC0gICAgICAgICAgICAgKiBpdGVyYXRpb24uDQo+PiArICAgICAgICAgICAg
ICogUmVhZHMgZnJvbSBicyBmb3Igc2VsZWN0ZWQgcmVnaW9uIHdpbGwgcmV0dXJuIHplcm9lcywg
cHJvZHVjZWQNCj4+ICsgICAgICAgICAgICAgKiBiZWNhdXNlIGN1cnJlbnQgbGV2ZWwgaXMgc2hv
cnQuIFdlIHNob3VsZCBjb25zaWRlciBpdCBhcw0KPj4gKyAgICAgICAgICAgICAqIGFsbG9jYXRl
ZC4NCj4gDQo+ICJ0aGUgc2VsZWN0ZWQgcmVnaW9uIg0KPiAidGhlIGN1cnJlbnQgbGV2ZWwiDQo+
IA0KPj4gKyAgICAgICAgICAgICAqIFRPRE86IFNob3VsZCB3ZSByZXBvcnQgcCBhcyBmaWxlIGhl
cmU/DQo+IA0KPiBJIHRoaW5rIHRoYXQgd291bGQgbWFrZSBzZW5zZS4NCj4gDQo+PiAgICAgICAg
ICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgIGFzc2VydChyZXQgJiBCRFJWX0JMT0NLX0VPRik7
DQo+IA0KPiBDYW4gdGhpcyBhc3NlcnRpb24gYmUgbW92ZWQgYWJvdmUgdGhlIGlmIChmaXJzdCk/
DQoNCml0IG1heSBjb3JyZXNwb25kIHRvIHJlcXVlc3RlZCBieXRlcz09MC4uIEJ1dCB3ZSBjYW4g
Y2hlY2sgaXQgc2VwYXJhdGVseQ0KYmVmb3JlIGZvciBsb29wIGFuZCBtb3ZlIHRoaXMgYXNzZXJ0
aW9uLg0KDQo+IA0KPj4gICAgICAgICAgICAgICAqcG51bSA9IGJ5dGVzOw0KPj4gKyAgICAgICAg
ICAgIHJldHVybiBCRFJWX0JMT0NLX1pFUk8gfCBCRFJWX0JMT0NLX0FMTE9DQVRFRDsNCj4+ICAg
ICAgICAgICB9DQo+PiAtICAgICAgICBpZiAocmV0ICYgKEJEUlZfQkxPQ0tfWkVSTyB8IEJEUlZf
QkxPQ0tfREFUQSkpIHsNCj4+IC0gICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgIGlmIChy
ZXQgJiBCRFJWX0JMT0NLX0FMTE9DQVRFRCkgew0KPj4gKyAgICAgICAgICAgIC8qIFdlJ3ZlIGZv
dW5kIHRoZSBub2RlIGFuZCB0aGUgc3RhdHVzLCB3ZSBtdXN0IHJldHVybi4gKi8NCj4+ICsNCj4+
ICsgICAgICAgICAgICBpZiAocmV0ICYgQkRSVl9CTE9DS19aRVJPICYmIHJldCAmIEJEUlZfQkxP
Q0tfRU9GICYmICFmaXJzdCkgew0KPj4gKyAgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAg
ICAgICAgICAgKiBUaGlzIGxldmVsIGFsc28gcmVzcG9uc2libGUgZm9yIHJlYWRzIGFmdGVyIEVP
RiBpbnNpZGUNCj4+ICsgICAgICAgICAgICAgICAgICogdW5hbGxvY2F0ZWQgcmVnaW9uIGluIHBy
ZXZpb3VzIGxldmVsLg0KPiANCj4gImlzIGFsc28gcmVzcG9uc2libGUiDQo+ICJ0aGUgdW5hbGxv
Y2F0ZWQgcmVnaW9uIGluIHRoZSBwcmV2aW91cyBsZXZlbCINCj4gDQo+PiArICAgICAgICAgICAg
ICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICAqcG51bSA9IGJ5dGVzOw0KPj4gKyAgICAgICAg
ICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICAgICAgIH0N
Cj4+IC0gICAgICAgIC8qIFtvZmZzZXQsIHBudW1dIHVuYWxsb2NhdGVkIG9uIHRoaXMgbGF5ZXIs
IHdoaWNoIGNvdWxkIGJlIG9ubHkNCj4+IC0gICAgICAgICAqIHRoZSBmaXJzdCBwYXJ0IG9mIFtv
ZmZzZXQsIGJ5dGVzXS4gICovDQo+IA0KPiBBbnkgcmVhc29uIGZvciBkZWxldGluZyB0aGlzIGNv
bW1lbnQ/IEkgdGhpbmsgaXQncyBzdGlsbCB2YWxpZC4NCg0KSG1tLCBJIGRlY2lkZWQgdGhhdCBp
dCdzIG9idmlvdXMgYW5kIHNob3J0ZXIgY29tbWVudCBpcyBlbm91Z2guDQpJIGNhbiBsZWF2ZSBp
dCwgb2YgY291cnNlLg0KDQo+IA0KPj4gLSAgICAgICAgYnl0ZXMgPSBNSU4oYnl0ZXMsICpwbnVt
KTsNCj4+ICsNCj4+ICsgICAgICAgIC8qIFByb2NlZWQgdG8gYmFja2luZyAqLw0KPj4gKyAgICAg
ICAgYXNzZXJ0KCpwbnVtIDw9IGJ5dGVzKTsNCj4+ICsgICAgICAgIGJ5dGVzID0gKnBudW07DQo+
PiAgICAgICAgICAgZmlyc3QgPSBmYWxzZTsNCj4+ICAgICAgIH0NCj4+ICsNCj4+ICAgICAgIHJl
dHVybiByZXQ7DQo+PiAgIH0NCj4gDQo+IEtldmluDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

