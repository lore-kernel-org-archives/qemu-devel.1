Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE32C76191
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDCE21BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VnfI4mKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDCE21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDyu-0002IN-Af
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqDyg-0001oM-O1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqDyf-0003m9-7u
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:54:30 -0400
Received: from mail-eopbgr150094.outbound.protection.outlook.com
 ([40.107.15.94]:22952 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqDye-0003lr-Kt; Wed, 24 Jul 2019 05:54:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnoTZyfD5U9yWcgTAwZRruIr7cFdM+rbA7vs3OJF1W5YrwxBJ2T+i/f5G5f3Hc0jqFgSTGMUnHpkwgtJhZEV7tXzXEIwJuSodCqtuoinSBS82U+hqwPhIREV8f3ZltVGqJi60lMNqKpPxoC07NZaWKxL3CqQy3m7vp2wazw+AlNdwpwPfojUGsrAxUMCE7Xt3foyu57Br76NvECSDjWKw44/A/Yvx+i3iyGXRISyaWN9fJD2m5zjirWi9wIDHYFefT7tzQBiqGKIc/nEbdgVALPgmLwNG+9kR2BGBaVreeJ0IdnTsbOUGBIyAAieIiX0SllfsLpaR6u0r6bMqYvNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4HvefQt2ZhP7QPL3FrBiDbNPbdAvhCbLIeNzVHMjx0=;
 b=CNPI+de1Z+SO8D2XphDmYMQX9dLXIAiq0USCQS3gPDNohO0iIjO/bI0/az/9OLivJZk40XuBI1xF74T0m0TBTflCW7eCc6eCENz7dPNizqQ4Icfea21b3CujaTszkzgsty/tlOnVKwmer8Qis8qZasAOqpl5/63Q/YoApwciN7NO5QauBZyrxtGAurwiHCUfVwC/xnXIzkEmI3mVFvmHTihB8tau3A1UmkpYjwyzswqRXEI5qSAXH0on5s4QrPZZ9jxvU6bn5ILZfY42eBTOeTjmqxI6T6ot88G+NIqeWC/Mtym0cubc6csZZRbHIGbHesEkpmnK2BLtwaiGPYCXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4HvefQt2ZhP7QPL3FrBiDbNPbdAvhCbLIeNzVHMjx0=;
 b=VnfI4mKOCg/ATjTfI6xtMMSm0jTx9xmo7M70wMF72qCB5UiRL9COSjEUAoZNcsyNrGW9OhHDcH8rm0BmYg/Mt6GmO/EmtSLEHgZNzfZrw35usNnaamU2ZbaytBjrzqh+W5t9g4Zgu/4hQoSksNkoF9NletQV0lW6E4OLr38j2f4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3931.eurprd08.prod.outlook.com (20.179.10.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 09:54:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 09:54:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 30/42] qemu-img: Use child access functions
Thread-Index: AQHVIWvHnxVNzSHLQUiliZZrFDtDOaaivO6AgABtcACAAvl3AIAzpNwA
Date: Wed, 24 Jul 2019 09:54:24 +0000
Message-ID: <650837b5-1fb8-3995-348c-77ab55020585@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
 <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
 <d086a736-6a4d-754d-74a4-f244a577d848@virtuozzo.com>
In-Reply-To: <d086a736-6a4d-754d-74a4-f244a577d848@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0047.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190724125422463
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6c307d9-753d-49d0-4127-08d7101ce8a8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3931; 
x-ms-traffictypediagnostic: DB8PR08MB3931:
x-microsoft-antispam-prvs: <DB8PR08MB3931A8E1CBAC56842CCEDEA7C1C60@DB8PR08MB3931.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(478600001)(446003)(53546011)(11346002)(26005)(14454004)(229853002)(316002)(8676002)(2616005)(5660300002)(256004)(2501003)(6116002)(486006)(6486002)(25786009)(110136005)(3846002)(31696002)(305945005)(6512007)(54906003)(6436002)(7736002)(99286004)(476003)(68736007)(53936002)(4326008)(66476007)(31686004)(66446008)(66556008)(6246003)(86362001)(81166006)(36756003)(81156014)(76176011)(2906002)(8936002)(102836004)(52116002)(186003)(64756008)(71190400001)(66946007)(71200400001)(66066001)(386003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3931;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KvXxd6Osw1SAIOXE9Xmd3XDTkfdO6Q2KTdsiLjnIuNXNt6OTfseRzTUPVc+OMrKkBZ04fwRtxIqr1o5Qo/XussCqQ5VfwM0OWOYCZw/Lt9qKdLk8nvbkGkQi/COfrPxWFYZzDlzUbqT5Kwt40qosq44aHQMz6zsyhOaeP+1MmVb/5qqZZ0o+UdCWiJogt8anMC6RbeI4IZJsR8CbQOlZgp+7cfCMmuNXDIjwZscl1uFlTLWPi9a2onymAaCwvUjZeomd6MDGQoAktiVO43uszEHifB9sAcx1StXkrwykQIZlqoV0dNe+RQnjzs3LsHafUe6jasMWlpVwwrDd9ABfN3cE8p1B3ZVdtYIX+8HArm/uxe39lgqrMrcQd7MABf4+9o5L7eqQSKXG0nuSGbNpDDUfsmBzz8SLhZXayaxSiCw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDA83424AFA56E4D9558C41122E8AE6E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c307d9-753d-49d0-4127-08d7101ce8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 09:54:24.6415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3931
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.94
Subject: Re: [Qemu-devel] [PATCH v5 30/42] qemu-img: Use child access
 functions
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDYuMjAxOSAxNjoxNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTkuMDYuMjAxOSAxODo0OSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTkuMDYuMTkgMTE6MTgs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTMuMDYuMjAxOSAxOjA5
LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4+IFRoaXMgY2hhbmdlcyBpb3Rlc3QgMjA0J3Mgb3V0cHV0
LCBiZWNhdXNlIGJsa2RlYnVnIG9uIHRvcCBvZiBhIENPVyBub2RlDQo+Pj4+IHVzZWQgdG8gbWFr
ZSBxZW11LWltZyBtYXAgZGlzcmVnYXJkIHRoZSByZXN0IG9mIHRoZSBiYWNraW5nIGNoYWluICh0
aGUNCj4+Pj4gYmFja2luZyBjaGFpbiB3YXMgYnJva2VuIGJ5IHRoZSBmaWx0ZXIpLsKgIFdpdGgg
dGhpcyBwYXRjaCwgdGhlDQo+Pj4+IGFsbG9jYXRpb24gaW4gdGhlIGJhc2UgaW1hZ2UgaXMgcmVw
b3J0ZWQgY29ycmVjdGx5Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1y
ZWl0ekByZWRoYXQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqDCoCBxZW11LWltZy5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzNiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0NCj4+Pj4gwqDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjA0Lm91dCB8wqAgMSArDQo+
Pj4+IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMo
LSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3FlbXUtaW1nLmMgYi9xZW11LWltZy5jDQo+Pj4+
IGluZGV4IDA3YjZlMmE4MDguLjdiZmE2ZTVkNDAgMTAwNjQ0DQo+Pj4+IC0tLSBhL3FlbXUtaW1n
LmMNCj4+Pj4gKysrIGIvcWVtdS1pbWcuYw0KPj4+PiBAQCAtOTkyLDcgKzk5Miw3IEBAIHN0YXRp
YyBpbnQgaW1nX2NvbW1pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+Pj4+IMKgwqDCoMKgwqDC
oCBpZiAoIWJsaykgew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMTsNCj4+Pj4g
wqDCoMKgwqDCoMKgIH0NCj4+Pj4gLcKgwqDCoCBicyA9IGJsa19icyhibGspOw0KPj4+PiArwqDC
oMKgIGJzID0gYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMoYmxrX2JzKGJsaykpOw0KPj4+DQo+
Pj4gaWYgZmlsZW5hbWUgaXMganNvbiwgZGVzY3JpYmluZyBleHBsaWNpdCBmaWx0ZXIgb3ZlciBu
b3JtYWwgbm9kZSwgYnMgd2lsbCBiZQ0KPj4+IGV4cGxpY2l0IGZpbHRlciAuLi4NCj4+Pg0KPj4+
PiDCoMKgwqDCoMKgwqAgcWVtdV9wcm9ncmVzc19pbml0KHByb2dyZXNzLCAxLmYpOw0KPj4+PiDC
oMKgwqDCoMKgwqAgcWVtdV9wcm9ncmVzc19wcmludCgwLmYsIDEwMCk7DQo+Pj4+IEBAIC0xMDA5
LDcgKzEwMDksNyBAQCBzdGF0aWMgaW50IGltZ19jb21taXQoaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQ0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUaGlzIGlzIGRpZmZlcmVudCBmcm9tIFFN
UCwgd2hpY2ggYnkgZGVmYXVsdCB1c2VzIHRoZSBkZWVwZXN0IGZpbGUgaW4NCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIHRoZSBiYWNraW5nIGNoYWluIChpLmUuLCB0aGUgdmVyeSBiYXNl
KTsgaG93ZXZlciwgdGhlIHRyYWRpdGlvbmFsDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBiZWhhdmlvciBvZiBxZW11LWltZyBjb21taXQgaXMgdXNpbmcgdGhlIGltbWVkaWF0ZSBiYWNr
aW5nIGZpbGUuICovDQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBiYXNlX2JzID0gYmFja2luZ19icyhi
cyk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBiYXNlX2JzID0gYmRydl9maWx0ZXJlZF9jb3dfYnMo
YnMpOw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWJhc2VfYnMpIHsNCj4+Pg0KPj4+
IGFuZCBoZXJlIHdlJ2xsIGZhaWwuDQo+Pg0KPj4gUmlnaHQsIHdpbGwgY2hhbmdlIHRvIGJkcnZf
YmFja2luZ19jaGFpbl9uZXh0KCkuDQo+Pg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGVycm9yX3NldGcoJmxvY2FsX2VyciwgIkltYWdlIGRvZXMgbm90IGhhdmUgYSBiYWNraW5n
IGZpbGUiKTsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7DQo+
Pj4+IEBAIC0xNjI2LDE5ICsxNjI2LDE4IEBAIHN0YXRpYyBpbnQgY29udmVydF9pdGVyYXRpb25f
c2VjdG9ycyhJbWdDb252ZXJ0U3RhdGUgKnMsIGludDY0X3Qgc2VjdG9yX251bSkNCj4+Pj4gwqDC
oMKgwqDCoMKgIGlmIChzLT5zZWN0b3JfbmV4dF9zdGF0dXMgPD0gc2VjdG9yX251bSkgew0KPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IGNvdW50ID0gbiAqIEJEUlZfU0VDVE9SX1NJ
WkU7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBCbG9ja0RyaXZlclN0YXRlICpzcmNfYnMgPSBibGtf
YnMocy0+c3JjW3NyY19jdXJdKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIEJsb2NrRHJpdmVyU3Rh
dGUgKmJhc2U7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzLT50YXJnZXRfaGFzX2Jh
Y2tpbmcpIHsNCj4+Pj4gLQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBiZHJ2
X2Jsb2NrX3N0YXR1cyhibGtfYnMocy0+c3JjW3NyY19jdXJdKSwNCj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKHNlY3Rvcl9udW0gLSBzcmNfY3VyX29mZnNldCkgKg0KPj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBC
RFJWX1NFQ1RPUl9TSVpFLA0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3VudCwgJmNvdW50LCBOVUxM
LCBOVUxMKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFzZSA9IGJkcnZfYmFja2lu
Z19jaGFpbl9uZXh0KHNyY19icyk7DQo+Pj4NCj4+PiBBcyB5b3UgZGVzY3JpYmVkIGluIGFub3Ro
ZXIgcGF0Y2gsIHdpbGwgbm90IHdlIGhlcmUgZ2V0IGFsbG9jYXRlZCBpbiBiYXNlIGFzIGFsbG9j
YXRlZCwgYmVjYXVzZSBvZg0KPj4+IGNvdW50aW5nIGZpbHRlcnMgYWJvdmUgYmFzZT8NCj4+DQo+
PiBEYW1uLCB5ZXMuwqAgU28NCj4+DQo+PiDCoMKgwqDCoCBiYXNlID0gYmRydl9maWx0ZXJlZF9j
b3dfYnMoYmRydl9za2lwX3J3X2ZpbHRlcnMoc3JjX2JzKSk7DQo+Pg0KPj4gSSBzdXBwb3NlLg0K
Pj4NCj4+PiBIbW0uIEkgbm93IHRoaW5rLCB3aHkgZmlsdGVycyBkb24ndCByZXBvcnQgZXZlcnl0
aGluZyBhcyB1bmFsbG9jYXRlZCwgd291bGQgbm90IGl0IGJlIG1vcmUgY29ycmVjdA0KPj4+IHRo
YW4gZmFsbHRocm91Z2ggdG8gY2hpbGQ/DQo+Pg0KPj4gSSBkb27igJl0IGtub3csIGFjdHVhbGx5
LsKgIE1heWJlLCBtYXliZSBub3QuDQo+Pg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVs
c2Ugew0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1
c19hYm92ZShibGtfYnMocy0+c3JjW3NyY19jdXJdKSwgTlVMTCwNCj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKHNlY3Rvcl9udW0gLSBzcmNfY3VyX29mZnNldCkgKg0KPj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCRFJWX1NFQ1RPUl9TSVpFLA0KPj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb3VudCwgJmNvdW50LCBOVUxMLCBOVUxMKTsNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYmFzZSA9IE5VTEw7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlKHNy
Y19icywgYmFzZSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChzZWN0b3JfbnVtIC0gc3JjX2N1
cl9vZmZzZXQpICoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJEUlZfU0VDVE9SX1NJWkUsDQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3VudCwgJmNvdW50LCBOVUxMLCBOVUxMKTsNCj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoImVycm9yIHdoaWxlIHJlYWRpbmcgYmxvY2sgc3Rh
dHVzIG9mIHNlY3RvciAlIiBQUklkNjQNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICI6ICVzIiwgc2VjdG9yX251bSwgc3RyZXJyb3Io
LXJldCkpOw0KPj4NCj4+IFsuLi5dDQo+Pg0KPj4+PiBAQCAtMjk0OSw3ICsyOTUwLDcgQEAgc3Rh
dGljIGludCBpbWdfbWFwKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+Pj4gwqDCoMKgwqDCoMKg
IGlmICghYmxrKSB7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOw0KPj4+PiDC
oMKgwqDCoMKgwqAgfQ0KPj4+PiAtwqDCoMKgIGJzID0gYmxrX2JzKGJsayk7DQo+Pj4+ICvCoMKg
wqAgYnMgPSBiZHJ2X3NraXBfaW1wbGljaXRfZmlsdGVycyhibGtfYnMoYmxrKSk7DQo+Pj4NCj4+
PiBIbW0sIGFub3RoZXIgdGhvdWdodCBhYm91dCBpbXBsaWNpdCBmaWx0ZXJzLCBob3cgdGhleSBj
b3VsZCBiZSBoZXJlIGluIHFlbXUtaW1nPw0KPj4NCj4+IEhtLCBJIGRvbuKAmXQgdGhpbmsgdGhl
eSBjYW4uDQo+Pg0KPj4+IElmIGltcGxpY2l0IGFyZSBvbmx5DQo+Pj4gam9iIGZpbHRlcnMuIERv
IHlvdSBwcmVwYXJlZCBpdCBmb3IgaW1wbGljaXQgQ09SPyBCdXQgd2UgZGlzY3Vzc2VkIHdpdGgg
S2V2aW4gdGhhdCB3ZSdkIGJldHRlciBkZXByZWNhdGUNCj4+PiBjb3B5LW9uLXJlYWQgb3B0aW9u
Li4NCj4+Pg0KPj4+IFNvLCBpZiBpbXBsaWNpdCBmaWx0ZXJzIGFyZSBmb3IgY29tcGF0aWJpbGl0
eSwgd2UnbGwgaGF2ZSB0aGVtIG9ubHkgaW4gYmxvY2stam9icy4gU28sIHNlZW1zIG5vIHJlYXNv
biB0byBzdXBwb3J0DQo+Pj4gdGhlbSBpbiBxZW11LWltZy4NCj4+DQo+PiBTZWVtcyByZWFzb25h
YmxlLCB5ZXMuDQo+Pg0KPj4+IEFsc28sIGluIGJsb2NrLWpvYnMsIHdlIGNhbiBhYmFuZG9uIGNy
ZWF0aW5nIGltcGxpY2l0IGZpbHRlcnMgYWJvdmUgYW55IGZpbHRlciBub2RlcywgYXMgd2VsbCBh
cyBhYmFuZG9uIGNyZWF0aW5nIGFueQ0KPj4+IGZpbHRlciBub2RlcyBhYm92ZSBpbXBsaWNpdCBm
aWx0ZXJzLiBUaGlzIHdpbGwgc3RpbGwgc3VwcG9ydCBvbGQgc2NlbmFyaW9zLCBidXQgZ2l2ZXMg
dmVyeSBzaW1wbGUgYW5kIHdlbGwgZGVmaW5lZCBzY29wZQ0KPj4+IG9mIHVzaW5nIGltcGxpY2l0
IGZpbHRlcnMgYW5kIGhvdyB0byB3b3JrIHdpdGggdGhlbS4gV2hhdCBkbyB5b3UgdGhpbms/DQo+
Pg0KPj4gSG0sIGluIHdoYXQgd2F5IHdvdWxkIHRoYXQgbWFrZSB0aGluZ3Mgc2ltcGxlcj8NCj4+
DQo+IA0KPiBUaGlzIHF1ZXN0aW9uIHdhcyBpbiBteSBtaW5kIHdoaWxlIEkndmUgZmluaXNoaW5n
IHRoaXMgcGFyYWdyYXBoKSBBdCBsZWFzdCBzdWNoIHJlc3RyaWN0aW9uIGFuc3dlciB0aGUgcXVl
c3Rpb24sIHdoZXJlDQo+IHNob3VsZCBuZXcgZmlsdGVycyBiZSBhZGRlZDogYmVsb3cgb3IgdW5k
ZXIgaW1wbGljaXQgZmlsdGVycy4uIFdpdGggc3VjaCByZXN0cmljdGlvbiB3ZSBhbHdheXMgY2Fu
IGhhdmUgb25seSBvbmUgaW1wbGljaXQgZmlsdGVyDQo+IG92ZXIgbm9uLWZpbHRlciBub2RlLCBh
bmQgYWJvdmUgaXQgc2hvdWxkIGJlIGV4cGxpY2l0IGZpbHRlciBvciBub24tZmlsdGVyIG5vZGUu
IEJ1dCB0aGlzIG5lZWQgaHVnZSB3b3JrIHRvIGJlIGRvbmUgd2l0aCBzbWFsbA0KPiBiZW5lZml0
LCBzbywgZm9yZ2V0IGl0KQ0KPiANCj4gDQoNClN0cmFuZ2UsIEkgaGF2ZSB0aGlzIG1haWwgYXV0
b21hdGljYWxseSByZXR1cm5lZCBiYWNrLiBEaWQgeW91IHJlY2VpdmUgaXQ/DQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

