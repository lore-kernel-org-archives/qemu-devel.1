Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CB82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WRVyYfOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CB82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7b1r-0007SD-Km
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7b18-0006zj-P6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7b17-0001Ns-EF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:56:50 -0400
Received: from mail-ve1eur01on0729.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::729]:23270
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7b16-0001Kz-K2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7cQkQN+PppZGqda4cOsYWuKBIJ88MMjXuFAaNnWP5wLwnMbyyu3OtOZ5fLXfYWYmpJWkaDWsF6GIBslQyx2P98uL4CFQbugEqga5nRQm1j4rooNrXURL7sZzBb0gT8uUMDYCWy6OaGFJAZM8Wam6B656qMT35m+RutXexrZkE3hk4HpSegDu9UQ/Tmcx2Y6smU406Qvuxqgq4DDKtUcBH3WxQLz/4j8CGbQo9BXNYaNJ1q5QdWUWlmWN4RVxH/o5H0mNSb8R4d9sCo+8HcBtsM552LT5qOrJjDkZng5RDjFxNsspxHwEkCFJvevbb4yRBzKuEWbohGRk3EU3M7Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrozl+zpWPh0AJA9v1gunPvhsb6TkyTpd2Lfp7ENgac=;
 b=f95FpnNAwm9wjJ00DHyi0b+SnPcFSGE3nr4sy2zJVoOf4yFnQip9Pa05ATL3FeWCiNAwW85r81T6NBRZLqKi/GFr7jgrhLgOGS/KNRwpi9kCV7/GNPNZlwyPFalfrssoHxh0WavkaOZe0Uzo4yRoiDnGGlgURqynlcG/dPMA97mOotjrvz+m7AcQjLxBOQ0UU2/mPODmMiu6KMBjOarH7ZZUhEVK1XAIH3tMSDbUQmfYl+kOc+gvcQ4ApKn4mnJ8qx54GdaBQjfapOFUnuO6L8YvQ94T4txS4HepEKnI78n+loqfNvFc6/EUTD/j0Wri2fHxBCfDnYP8prMSTommDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrozl+zpWPh0AJA9v1gunPvhsb6TkyTpd2Lfp7ENgac=;
 b=WRVyYfOBe6mqqiGZkZ9FD64F/YLaH1dTtYe5i8qQXkuczEZzPEDQJtTafLL5ZtWYl2n2PNrkzuZRKwosAeLFczWmjL5P3DJGMnDV2iSfdvK6Ps0JbtT0ftoMER1qPzuXnORs2Gey+6RwztDnKHBS9NMpIO1hOuNVDXY+NuiF7Xs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5082.eurprd08.prod.outlook.com (10.255.19.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 07:56:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 07:56:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Thread-Topic: [Qemu-devel] [PULL 1/9] qapi: Add InetSocketAddress member
 keep-alive
Thread-Index: AQHVU5eUa2amvrYk5EmhOdpTNh/x2qcjwg2AgADxVYA=
Date: Tue, 10 Sep 2019 07:56:45 +0000
Message-ID: <1722e8ab-1a2b-311e-63fb-d89387b72c2f@virtuozzo.com>
References: <20190815183039.4264-1-eblake@redhat.com>
 <20190815183039.4264-2-eblake@redhat.com>
 <CAFEAcA-ic=jdSvzOiNCEWmuhXythc2MQGYZYgV=3CBBT2RkEoQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-ic=jdSvzOiNCEWmuhXythc2MQGYZYgV=3CBBT2RkEoQ@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190910105643373
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db130e8e-14cd-448c-e16c-08d735c46cce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5082; 
x-ms-traffictypediagnostic: DB8PR08MB5082:
x-microsoft-antispam-prvs: <DB8PR08MB50823DB47C7496DCCDA6B083C1B60@DB8PR08MB5082.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39840400004)(189003)(199004)(102836004)(229853002)(66446008)(64756008)(66556008)(7736002)(14444005)(31686004)(25786009)(6116002)(3846002)(256004)(6486002)(66946007)(54906003)(71200400001)(36756003)(6246003)(14454004)(31696002)(186003)(53936002)(8676002)(26005)(52116002)(305945005)(5660300002)(478600001)(2906002)(66476007)(2616005)(6512007)(6506007)(316002)(6436002)(386003)(99286004)(8936002)(66066001)(476003)(81166006)(81156014)(4326008)(11346002)(446003)(71190400001)(86362001)(110136005)(486006)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5082;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b6zstgjgQroCTkF2tCK1eLUUdCmsNSCUMlEySEB5p4n+LKawXv36fsJCvlYfwnD7uOtFYoaFZtcbl5PIB4O38q72rR/WwtROq7QBP0sWXP1RYsXWbv6KTCMYpaWEv0r+QfjxM3tv2rpYO/gaJ9gyXdHTKKWZlUMPDxRBEz4KwUABqOWTOzt80/NnakkEkNTcSZHWGU/1J0S+t9bodl5FvHuoY+i0KJIUlln/30Cg+bNnrvUraMI+muQ1y+1IKvMdkjsvaAHu/pg7OBlDZMGba2wwrgLfEvHgIEUKVdrcJkjlCF9QD9cZn5TNbfFBrk+abGV+MjXvzpAZCDGmk2YEaaTharaAeDvO7Ggfzy8TY3WRvtqETwX5e0DbTL83taZiy7q4GzZfpvI03CCBNr50TDCRdZbIRFrcQbFoSveGk+Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B60B749E14B048409080FA57760C6CCA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db130e8e-14cd-448c-e16c-08d735c46cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 07:56:45.3075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhBc7HEfQVg7jkZCeR2+H8V8WYhF/Xz4reYVtz2HdY5yI3qfSA5hNj5pouTVwP+vJep6GyMGRHeS/0PooONZeuzTthprpv1VAeSSOXvAUm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5082
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::729
Subject: Re: [Qemu-devel] [PULL 1/9] qapi: Add InetSocketAddress member
 keep-alive
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDkuMjAxOSAyMDozMiwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVGh1LCAxNSBBdWcg
MjAxOSBhdCAxOTozNCwgRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4N
Cj4+IEZyb206IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCj4+DQo+PiBJdCdzIG5lZWRlZCB0byBwcm92aWRlIGtlZXBhbGl2ZSBmb3IgbmJk
IGNsaWVudCB0byB0cmFjayBzZXJ2ZXINCj4+IGF2YWlsYWJpbGl0eS4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+PiBNZXNzYWdlLUlkOiA8MjAxOTA3MjUwOTQ5MzcuMzI0NTQtMS12c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQo+PiBSZXZpZXdlZC1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJy
dUByZWRoYXQuY29tPg0KPj4gQWNrZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdl
QHJlZGhhdC5jb20+DQo+PiBbZWJsYWtlOiBGaXggZXJyb3IgbWVzc2FnZSB0eXBvXQ0KPj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IA0KPiBIaTsgQ292
ZXJpdHkgc3BvdHMgYSBidWcgaW4gdGhpcyBjaGFuZ2UgKENJRCAxNDA1MzAwKToNCg0KVHdvIGNv
dmVyaXR5IGJ1Z3Mgb24gbXkgcGF0Y2hlcywgSSdtIHNvcnJ5IDooDQoNCkhvdyBjYW4gSSBydW4g
dGhpcyBjb3Zlcml0eSBsb2NhbGx5Pw0KDQo+IA0KPj4gQEAgLTQ1OCw2ICs0NjQsMTkgQEAgaW50
IGluZXRfY29ubmVjdF9zYWRkcihJbmV0U29ja2V0QWRkcmVzcyAqc2FkZHIsIEVycm9yICoqZXJy
cCkNCj4+ICAgICAgIH0NCj4gDQo+IEF0IHRoaXMgcG9pbnQgaW4gdGhlIGZ1bmN0aW9uLCB3ZSBt
aWdodCBiZSBpbiBvbmUgb2YNCj4gdHdvIGNhc2VzOg0KPiAgICgxKSBzb2NrID49IDAgOiB0aGUg
Y29ubmVjdCBzdWNjZWVkZWQNCj4gICAoMikgc29jayA8IDAgOiBjb25uZWN0IGZhaWxlZCwgd2Ug
aGF2ZSBqdXN0IGNhbGxlZA0KPiAgICAgICBlcnJvcl9wcm9wYWdhdGUoKSBhbmQgYXJlIHVzaW5n
IHRoZSBzYW1lIGVuZC1vZi1mdW5jdGlvbg0KPiAgICAgICBjb2RlcGF0aCB0byBmcmVlICdyZXMn
IGJlZm9yZSByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUuDQo+IA0KPj4NCj4+ICAgICAgIGZyZWVh
ZGRyaW5mbyhyZXMpOw0KPj4gKw0KPj4gKyAgICBpZiAoc2FkZHItPmtlZXBfYWxpdmUpIHsNCj4+
ICsgICAgICAgIGludCB2YWwgPSAxOw0KPj4gKyAgICAgICAgaW50IHJldCA9IHFlbXVfc2V0c29j
a29wdChzb2NrLCBTT0xfU09DS0VULCBTT19LRUVQQUxJVkUsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZ2YWwsIHNpemVvZih2YWwpKTsNCj4gDQo+IC4uLmJ1dCBoZXJl
IHdlIHVzZSAnc29jaycgYXNzdW1pbmcgaXQgaXMgdmFsaWQuDQo+IA0KPj4gKw0KPj4gKyAgICAg
ICAgaWYgKHJldCA8IDApIHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAs
IGVycm5vLCAiVW5hYmxlIHRvIHNldCBLRUVQQUxJVkUiKTsNCj4+ICsgICAgICAgICAgICBjbG9z
ZShzb2NrKTsNCj4+ICsgICAgICAgICAgICByZXR1cm4gLTE7DQo+PiArICAgICAgICB9DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICAgICAgIHJldHVybiBzb2NrOw0KPj4gICB9DQo+IA0KPiBJZiB3ZSB3
YW50IHRvIGFkZCBtb3JlICJhY3R1YWwgd29yayIgYXQgdGhpcyBwb2ludCBpbg0KPiB0aGUgZnVu
Y3Rpb24gd2Ugc2hvdWxkIHByb2JhYmx5IHNlcGFyYXRlIG91dCB0aGUgZmFpbGVkLWNhc2UNCj4g
Y29kZXBhdGgsIGVnIGJ5IGNoYW5naW5nDQo+IA0KPiANCj4gICAgICBpZiAoc29jayA8IDApIHsN
Cj4gICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ICAgICAgfQ0K
PiANCj4gICAgICBmcmVlYWRkcmluZm8ocmVzKTsNCj4gDQo+IGludG8NCj4gDQo+ICAgICAgZnJl
ZWFkZHJpbmZvKHJlcyk7DQo+IA0KPiAgICAgIGlmIChzb2NrIDwgMCkgew0KPiAgICAgICAgICBl
cnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCj4gICAgICAgICAgcmV0dXJuIHNvY2s7
DQo+ICAgICAgfQ0KPiANCj4gDQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo+IA0KDQpUaGFua3Ms
IHRoaXMgc2hvdWxkIHdvcmssIEknbGwgc2VuZCBhIHBhdGNoIHNvb24uDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

