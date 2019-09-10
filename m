Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D554C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF9920872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fhWI8fC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF9920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cRf-0005Dg-U0
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7c3L-0007CA-OH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7c3K-0007aR-GE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:03:11 -0400
Received: from mail-vi1eur04on0701.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::701]:40925
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7c3G-0007TP-AL; Tue, 10 Sep 2019 05:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abESLByJisM06X3xOZ4PGVO45PhHiG5tawrjJsnaSLMqpcQruVSVLIw2itevi6ml3sDFCYJjxEZ2JVTCcWIUlIGYetkAm6SAZEeiCAOlYqFZTYKY7g54+/TsD2VtNFmOmlayGKonIHBzfjQIma0Um9nDx63d3jBu1Mv8LTTzt2Unv9MvQy+J6GtD46zLGQYeG1R/AeLWhP8rdb48j5Zj+RvZYcKrXrRBwWWqcSQHmfbkQ+RQbfE7irmUEAJvPro8pMWe1se/FBO8emRzBQ+zZTlcvrgCbPywwf/saN/rm0+ekJdMb72eD3bV6SNULFmFv0Hdl0/VBpkGblfoPFwf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r24irondydzBuNebV/+6+RMMGATPfGH1lYb5BCzUeA=;
 b=TUl/69rUxIONT9JqpuRlTvq37n2N9c8WaJv7sT+KaabIiuwXjvud7hyfVSw/lOK77q5Yo3yNfG2R4tU4eJY1ldw45q7CaAsjwHrLyEZbUpVvSS3YgCnwibu0QBRLMP9yPaSajLcGoqzHX/OQiofYZWt9UaqGL9eiRWDI+8YTvXOj4AwOadtUkkjy+8ueE398saiIRo/0wgAKVBPfWj7XgreUFbKqqcDf6MRjW+SyLPZ3/i/THxcTA4QerFncQ7wuG4SU7yb1d2XQEj4iPS2fH8BxVEooY4Zs1PQCRSR7b7n+vt9uZfOFrRxdNzuUoqo0L6y8zfKFpeRVZMdvfxnegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r24irondydzBuNebV/+6+RMMGATPfGH1lYb5BCzUeA=;
 b=fhWI8fC9+bOQuc0BFfxnXn7BvIRxLvi9MVxOtLa5hIZrodboAf2bb3sXkHF9DsOmYnQbtJoWvbOE2t4vK4MmncY+2mXekb6kChMXAK0rBZXI+gz3Fz7TcbkhaWcgi49le7WxqjqrCO/fDp9xS4RVutwk8D8N8GLDl17yU+QTla4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5034.eurprd08.prod.outlook.com (10.255.16.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 09:03:03 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 09:03:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi
 <stefanha@redhat.com>
Thread-Topic: [PULL 01/12] util/iov: introduce qemu_iovec_init_extended
Thread-Index: AQHVXRRhd3kqUeiQskWGPV2+lixAN6cjsOEAgAECDoA=
Date: Tue, 10 Sep 2019 09:03:03 +0000
Message-ID: <0cf55dff-b847-2094-b12f-8c4d8b679a03@virtuozzo.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
 <20190827201639.30368-2-stefanha@redhat.com>
 <CAFEAcA8MsjfKTr9JANt39vGZNPk5McQaex7wTRJkOn+hqB54bg@mail.gmail.com>
In-Reply-To: <CAFEAcA8MsjfKTr9JANt39vGZNPk5McQaex7wTRJkOn+hqB54bg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::20)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190910120301174
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38e95045-0844-40c8-97f3-08d735cdaff6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5034; 
x-ms-traffictypediagnostic: DB8PR08MB5034:
x-microsoft-antispam-prvs: <DB8PR08MB50343A7DBADD840773BA8D1BC1B60@DB8PR08MB5034.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(346002)(136003)(376002)(199004)(189003)(81156014)(446003)(6512007)(71190400001)(110136005)(486006)(6486002)(229853002)(66446008)(6436002)(66066001)(66946007)(66476007)(386003)(64756008)(6506007)(66556008)(8676002)(3846002)(53936002)(2906002)(11346002)(476003)(2616005)(76176011)(5660300002)(26005)(31686004)(81166006)(8936002)(52116002)(36756003)(54906003)(6246003)(6116002)(71200400001)(316002)(99286004)(31696002)(86362001)(102836004)(186003)(14454004)(25786009)(305945005)(14444005)(256004)(478600001)(4326008)(7736002)(309714004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5034;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DL/0/x9QXY8VSO7bUHae1B3ubiMYxPMdTION1324K6QJLyMO1Fc9deqCv1p+Gw83dzBa+8kkFRpzN7EbauuvDv0L3zmWtGsbsvuRW+qba2s4Bm/u5OCuOBUwuJMz6mYkO0KhLc1tMzLa/iGNrUefJ5A/BeSYfDNJHaQR1BOBfNlfac4jOHdnpl6G8gNgS3Y/jYjzrIgriT4jfKwLvdMNnGRYGOprjO8EwRqBRv6nZ+K26R/rIsMT868RbMLtm7JrmIWOH8nwUq/rKVZ64I/8ze1fgB4E810JMYXecF8cLGLkg5WrXeNYxN+SysdFOkfJLrDj1YZwd01XkvaaJfnaFHpVdlgHxmHgKU4cCcLCdgmv1gGEO2bhvXOH7YMjikCXe3ltmi+H8KusffSXTu/55CVlRW/TSjvwoqMMNR6mq0E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <23FAB44C2A11F04DA916C021404AD2BA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e95045-0844-40c8-97f3-08d735cdaff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 09:03:03.4096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odaFIVnePAZ4uAQPvSGBrCpmF3aNevg6OOaHmIBTpzHpGYa8e2i3eWcnC/pFXKMGenngJv3h4Zu8oQPFRV8l+atjX32dAIU/zuCl/WWEvIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5034
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::701
Subject: Re: [Qemu-devel] [PULL 01/12] util/iov: introduce
 qemu_iovec_init_extended
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDkuMjAxOSAyMDozOSwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVHVlLCAyNyBBdWcg
MjAxOSBhdCAyMToxNiwgU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPiB3cm90
ZToNCj4+DQo+PiBGcm9tOiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQo+Pg0KPj4gSW50cm9kdWNlIG5ldyBpbml0aWFsaXphdGlvbiBBUEks
IHRvIGNyZWF0ZSByZXF1ZXN0cyB3aXRoIHBhZGRpbmcuIFdpbGwNCj4+IGJlIHVzZWQgaW4gdGhl
IGZvbGxvd2luZyBwYXRjaC4gTmV3IEFQSSB1c2VzIHFlbXVfaW92ZWNfaW5pdF9idWYgaWYNCj4+
IHJlc3VsdGluZyBpbyB2ZWN0b3IgaGFzIG9ubHkgb25lIGVsZW1lbnQsIHRvIGF2b2lkIGV4dHJh
IGFsbG9jYXRpb25zLg0KPj4gU28sIHdlIG5lZWQgdG8gdXBkYXRlIHFlbXVfaW92ZWNfZGVzdHJv
eSB0byBzdXBwb3J0IGRlc3Ryb3lpbmcgc3VjaA0KPj4gUUlPVnMuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4gQWNrZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4N
Cj4+IE1lc3NhZ2UtaWQ6IDIwMTkwNjA0MTYxNTE0LjI2MjI0MS0yLXZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbQ0KPj4gTWVzc2FnZS1JZDogPDIwMTkwNjA0MTYxNTE0LjI2MjI0MS0yLXZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4NCj4gDQo+IEhpIC0tIENvdmVyaXR5IHRoaW5rcyB0aGlzIG5ldyBm
dW5jdGlvbiBjb3VsZCBoYXZlIGFuDQo+IG91dC1vZi1ib3VuZHMgcmVhZCAoQ0lEIDE0MDUzMDIp
Og0KPiANCj4+ICsvKg0KPj4gKyAqIENvbXBpbGUgbmV3IGlvdmVjLCBjb21iaW5pbmcgQGhlYWRf
YnVmIGJ1ZmZlciwgc3ViLXFpb3Ygb2YgQG1pZF9xaW92LA0KPj4gKyAqIGFuZCBAdGFpbF9idWYg
YnVmZmVyIGludG8gbmV3IHFpb3YuDQo+PiArICovDQo+PiArdm9pZCBxZW11X2lvdmVjX2luaXRf
ZXh0ZW5kZWQoDQo+PiArICAgICAgICBRRU1VSU9WZWN0b3IgKnFpb3YsDQo+PiArICAgICAgICB2
b2lkICpoZWFkX2J1Ziwgc2l6ZV90IGhlYWRfbGVuLA0KPj4gKyAgICAgICAgUUVNVUlPVmVjdG9y
ICptaWRfcWlvdiwgc2l6ZV90IG1pZF9vZmZzZXQsIHNpemVfdCBtaWRfbGVuLA0KPj4gKyAgICAg
ICAgdm9pZCAqdGFpbF9idWYsIHNpemVfdCB0YWlsX2xlbikNCj4+ICt7DQo+PiArICAgIHNpemVf
dCBtaWRfaGVhZCwgbWlkX3RhaWw7DQo+PiArICAgIGludCB0b3RhbF9uaW92LCBtaWRfbmlvdiA9
IDA7DQo+PiArICAgIHN0cnVjdCBpb3ZlYyAqcCwgKm1pZF9pb3Y7DQo+PiArDQo+PiArICAgIGlm
IChtaWRfbGVuKSB7DQo+PiArICAgICAgICBtaWRfaW92ID0gcWlvdl9zbGljZShtaWRfcWlvdiwg
bWlkX29mZnNldCwgbWlkX2xlbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZt
aWRfaGVhZCwgJm1pZF90YWlsLCAmbWlkX25pb3YpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAg
IHRvdGFsX25pb3YgPSAhIWhlYWRfbGVuICsgbWlkX25pb3YgKyAhIXRhaWxfbGVuOw0KPj4gKyAg
ICBpZiAodG90YWxfbmlvdiA9PSAxKSB7DQo+PiArICAgICAgICBxZW11X2lvdmVjX2luaXRfYnVm
KHFpb3YsIE5VTEwsIDApOw0KPj4gKyAgICAgICAgcCA9ICZxaW92LT5sb2NhbF9pb3Y7DQo+PiAr
ICAgIH0gZWxzZSB7DQo+PiArICAgICAgICBxaW92LT5uaW92ID0gcWlvdi0+bmFsbG9jID0gdG90
YWxfbmlvdjsNCj4+ICsgICAgICAgIHFpb3YtPnNpemUgPSBoZWFkX2xlbiArIG1pZF9sZW4gKyB0
YWlsX2xlbjsNCj4+ICsgICAgICAgIHAgPSBxaW92LT5pb3YgPSBnX25ldyhzdHJ1Y3QgaW92ZWMs
IHFpb3YtPm5pb3YpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChoZWFkX2xlbikgew0K
Pj4gKyAgICAgICAgcC0+aW92X2Jhc2UgPSBoZWFkX2J1ZjsNCj4+ICsgICAgICAgIHAtPmlvdl9s
ZW4gPSBoZWFkX2xlbjsNCj4+ICsgICAgICAgIHArKzsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAg
ICBpZiAobWlkX2xlbikgew0KPj4gKyAgICAgICAgbWVtY3B5KHAsIG1pZF9pb3YsIG1pZF9uaW92
ICogc2l6ZW9mKCpwKSk7DQo+PiArICAgICAgICBwWzBdLmlvdl9iYXNlID0gKHVpbnQ4X3QgKilw
WzBdLmlvdl9iYXNlICsgbWlkX2hlYWQ7DQo+PiArICAgICAgICBwWzBdLmlvdl9sZW4gLT0gbWlk
X2hlYWQ7DQo+PiArICAgICAgICBwW21pZF9uaW92IC0gMV0uaW92X2xlbiAtPSBtaWRfdGFpbDsN
Cj4+ICsgICAgICAgIHAgKz0gbWlkX25pb3Y7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYg
KHRhaWxfbGVuKSB7DQo+PiArICAgICAgICBwLT5pb3ZfYmFzZSA9IHRhaWxfYnVmOw0KPj4gKyAg
ICAgICAgcC0+aW92X2xlbiA9IHRhaWxfbGVuOw0KPj4gKyAgICB9DQo+PiArfQ0KPiANCj4gYnV0
IEknbSBub3QgZmFtaWxpYXIgZW5vdWdoIHdpdGggdGhlIGNvZGUgdG8gYmUgYWJsZSB0byB0ZWxs
DQo+IGlmIGl0J3MgY29ycmVjdCBvciBpZiBpdCdzIGp1c3QgZ2V0dGluZyBjb25mdXNlZC4gQ291
bGQNCj4gc29tZWJvZHkgaGF2ZSBhIGxvb2s/IChJdCdzIHBvc3NpYmxlIGl0J3MgZ2V0dGluZyBj
b25mdXNlZA0KPiBiZWNhdXNlIHRoZSBjYWxjdWxhdGlvbiBvZiAndG90YWxfbmlvdicgdXNlcyAn
bWlkX25pb3YnLA0KPiBidXQgdGhlIGNvbmRpdGlvbiBndWFyZGluZyB0aGUgY29kZSB0aGF0IGZp
bGxzIGluIHRoYXQgcGFydA0KPiBvZiB0aGUgdmVjdG9yIGlzICdtaWRfbGVuJywgc28gaXQgdGhp
bmtzIGl0IGNhbiB0YWtlIHRoZQ0KPiAidG90YWxfbmlvdiA9PSAxIiBjb2RlcGF0aCBhbmQgYWxz
byB0aGUgImhlYWRfbGVuID09IHRydWUiDQo+IGFuZCAibWlkX2xlbiAhPSAwIiBwYXRoczsgaW4g
d2hpY2ggY2FzZSB1c2luZyAiaWYgKG1pZF9uaW92KSINCj4gaW5zdGVhZCBtaWdodCBtYWtlIGl0
IGhhcHBpZXIuKQ0KPiANCg0KSSdtIGFmcmFpZCwgSSBkb24ndCBoYXZlIGJldHRlciBhc3N1bXB0
aW9uLiBMZXQncyB0cnkuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

