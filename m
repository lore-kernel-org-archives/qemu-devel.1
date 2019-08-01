Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4033C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED00204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ggTGvHs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED00204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFLK-0004Bz-Qo
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52353)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htFJO-0003El-CA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htFJM-0008NH-8m
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:56:21 -0400
Received: from mail-eopbgr20105.outbound.protection.outlook.com
 ([40.107.2.105]:56846 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htFJL-0008L2-FG; Thu, 01 Aug 2019 13:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEIH74EueBlhhGyvrwC/MCIbjOOVu4wykzjQByXDiIfaaTwpLEfOUlC5e4ev8DLKwXkGy3OJLL/3NB1sQYiNtMUi8s/YSOXB+TRgPHqLRDeYcq6YUtkTpJAs9GGvx4/f2VkTD+QhaRj7iABxrSUxlorhvAeSpBfHFFI/4K4W1B5hicHLsmS+Q7Qj4GcgyMhhpIzQ50Jut1tbnKkBZbMtLdicwCG4SsNgRzW6u/cE6nWePRkwBjpQRMsgPl9Yu4GTqvL0JyaOzxx1wDtrSguYazI+07UJhCjNAJv16TUYsMIp/VVVYzuI0uUOQl+fBsXwwFJwscAepNGM5sST35MFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7mMN1DErKOTRiqkZIoy4kxzUE9jlD7sG9dTNGKentg=;
 b=mo8xovGtpJmytZ+j/IIFPmMvhU3OHcX85FdYaSG0/CqsWmJ4wO2geku2DYaeyWuJbZAGtLuvvH7RK8/YmUzF4TwfVisbsk/dTxtpCLosBEmWDISktHXYziHPbUdDgMn6h7GBRbbKX18c45DGiyylOtl4BBc4hsLsEU4M+qpdM+1+eA6NDmsI+VmVlwGRMDGP7wqIUGLDN9yhtLnMvLj5VBH3KJt0yEPIqN1zXdKokuC/HPtfCTtTwzFr13E8Rpo99dSZJO2AZyTRXbhsutcqFk2tuXC5GILqtCVk17GnQW8YunH+72Ie1XcSO3vHjSThPLojRVI0VSKqnDsvfjiT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7mMN1DErKOTRiqkZIoy4kxzUE9jlD7sG9dTNGKentg=;
 b=ggTGvHs3k2d3w2nOlGVGtPnycv0cycT1r4zGoQEveE7WwV8g5rEjaq4aOeMz964wEMmb2wICQ/45mLUZQEukc4K5ki/R0tBxb88fJIHYOFIjATC6r0zgoUljPAF0s3cjWx2yXyt/nIpd3Jg4FDHshsLA617AD2GvCn0qQclQ+b0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4009.eurprd08.prod.outlook.com (20.179.11.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Thu, 1 Aug 2019 17:56:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 17:56:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH for-4.1 2/2] iotests: Test backup job with two guest
 writes
Thread-Index: AQHVSHuSmXijrz1GlEejh1OLI2A9XqbmdDaAgAARuACAAAVQgIAAAsSAgAACTACAAAOKAA==
Date: Thu, 1 Aug 2019 17:56:14 +0000
Message-ID: <29eb24a4-a817-a7d9-ca57-8ab5b0145947@virtuozzo.com>
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-3-mreitz@redhat.com>
 <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
 <738d7105-f91e-76ad-c2e6-cd5b32b846ef@redhat.com>
 <274d65f2-1b42-8585-3c6f-1ee711c2bb09@virtuozzo.com>
 <02a05f35-cedd-65c1-aafc-01183e5ba91d@redhat.com>
 <fe27353b-b65f-186b-d743-700f49cc11fb@virtuozzo.com>
In-Reply-To: <fe27353b-b65f-186b-d743-700f49cc11fb@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0247.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801205612168
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c2176cb-6273-4a9d-009d-08d716a98b7e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4009; 
x-ms-traffictypediagnostic: DB8PR08MB4009:
x-microsoft-antispam-prvs: <DB8PR08MB4009585D1673E884A4B11033C1DE0@DB8PR08MB4009.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(86362001)(386003)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(102836004)(53546011)(31696002)(36756003)(99286004)(68736007)(76176011)(2906002)(6116002)(8676002)(53936002)(2501003)(52116002)(3846002)(5660300002)(71190400001)(478600001)(71200400001)(14454004)(26005)(256004)(14444005)(446003)(8936002)(316002)(81156014)(486006)(476003)(66066001)(31686004)(4326008)(2616005)(11346002)(6486002)(6512007)(6246003)(81166006)(6436002)(54906003)(25786009)(110136005)(7736002)(229853002)(305945005)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4009;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jz0Kucht8vWgYWv9d7TBT7qOnIU9BBued5AzR/CRyIE7z+1PRgKcyRufs+OkjGr6brG62ovwM6iaJfUyuc9BLEQ2engolGOe0cQnsaInf654hG++nSn1TqNDXtcRGqrYJV+67VNmN7iCvFXzRcRFrjV/q5tupFd2OcHQ0zuwelpBsLJoHJofBtrxb+iwGhSnhS0OYb/3C8Ow4hXRG/l4VS/MDwERkrEJ5eREPMkodnN40Ae+rJky65YN4ZcGsw9FhaSpI3P7tHaob879taOZ6Zqs/gBDnYD4EiuYOZtX7+C5Vkm1XmgkUNrRyRC6LuqpV8fh6fIn7M6+W/KhaXXxETzRE3CU82JhhXWldLwbInfqPSE5yK1fOZ3OSTgeXXkiG3btpqS6C/VyPYn9mELQ3MPijzYFuMsBvwyyi3+aioE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68850B581EE9704A8685A4B3B74476F4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2176cb-6273-4a9d-009d-08d716a98b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 17:56:14.3750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4009
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.105
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] iotests: Test backup job with
 two guest writes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAyMDo0MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDEuMDguMjAxOSAyMDozNSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDEuMDguMTkgMTk6MjUs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMDEuMDguMjAxOSAyMDow
NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAwMS4wOC4xOSAxODowMywgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IDAxLjA4LjIwMTkgMTg6MTIsIE1heCBSZWl0
eiB3cm90ZToNCj4+Pj4+PiBQZXJmb3JtIHR3byBndWVzdCB3cml0ZXMgdG8gbm90IHlldCBiYWNr
ZWQgdXAgYXJlYXMgb2YgYW4gaW1hZ2UsIHdoZXJlDQo+Pj4+Pj4gdGhlIGZvcm1lciB0b3VjaGVz
IGFuIGlubmVyIGFyZWEgb2YgdGhlIGxhdHRlci4NCj4+Pj4+Pg0KPj4+Pj4+IEJlZm9yZSBIRUFE
XiwgY29weSBvZmZsb2FkaW5nIGJyb2tlIHRoaXMgaW4gdHdvIHdheXM6DQo+Pj4+Pj4gKDEpIFRo
ZSBvdXRwdXQgZGlmZmVycyBmcm9tIHRoZSByZWZlcmVuY2Ugb3V0cHV0ICh3aGF0IHRoZSBzb3Vy
Y2Ugd2FzDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIGJlZm9yZSB0aGUgZ3Vlc3Qgd3JpdGVzKS4NCj4+
Pj4+PiAoMikgQnV0IHlvdSB3aWxsIG5vdCBzZWUgdGhhdCBpbiB0aGUgZmFpbGluZyBvdXRwdXQs
IGJlY2F1c2UgdGhlIGpvYg0KPj4+Pj4+IMKgwqDCoMKgwqDCoCBvZmZzZXQgaXMgcmVwb3J0ZWQg
YXMgYmVpbmcgZ3JlYXRlciB0aGFuIHRoZSBqb2IgbGVuZ3RoLsKgIFRoaXMgaXMNCj4+Pj4+PiDC
oMKgwqDCoMKgwqAgYmVjYXVzZSBvbmUgY2x1c3RlciBpcyBjb3BpZWQgdHdpY2UsIGFuZCB0aHVz
IGFjY291bnRlZCBmb3IgdHdpY2UsDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIGJ1dCBvZiBjb3Vyc2Ug
dGhlIGpvYiBsZW5ndGggZG9lcyBub3QgaW5jcmVhc2UuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+
IMKgwqDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMDU2wqDCoMKgwqAgfCAzNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4gwqDCoMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8w
NTYub3V0IHzCoCA0ICsrLS0NCj4+Pj4+PiDCoMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wNTYgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDU2DQo+Pj4+Pj4gaW5k
ZXggZjQwZmMxMWEwOS4uZDcxOTg1MDdmNSAxMDA3NTUNCj4+Pj4+PiAtLS0gYS90ZXN0cy9xZW11
LWlvdGVzdHMvMDU2DQo+Pj4+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ng0KPj4+Pj4+
IEBAIC0xMzMsNiArMTMzLDcgQEAgY2xhc3MgQmFja3VwVGVzdChpb3Rlc3RzLlFNUFRlc3RDYXNl
KToNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudm0gPSBpb3Rlc3RzLlZNKCkN
Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudGVzdF9pbWcgPSBpbWdfY3JlYXRl
KCd0ZXN0JykNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuZGVzdF9pbWcgPSBp
bWdfY3JlYXRlKCdkZXN0JykNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi5yZWZfaW1nID0g
aW1nX2NyZWF0ZSgncmVmJykNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudm0u
YWRkX2RyaXZlKHNlbGYudGVzdF9pbWcpDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
ZWxmLnZtLmxhdW5jaCgpDQo+Pj4+Pj4gQEAgLTE0MCw2ICsxNDEsNyBAQCBjbGFzcyBCYWNrdXBU
ZXN0KGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2VsZi52bS5zaHV0ZG93bigpDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnlfcmVt
b3ZlKHNlbGYudGVzdF9pbWcpDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnlfcmVt
b3ZlKHNlbGYuZGVzdF9pbWcpDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHRyeV9yZW1vdmUoc2Vs
Zi5yZWZfaW1nKQ0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGRlZiBobXBfaW9fd3JpdGVzKHNlbGYs
IGRyaXZlLCBwYXR0ZXJucyk6DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgcGF0
dGVybiBpbiBwYXR0ZXJuczoNCj4+Pj4+PiBAQCAtMTc3LDYgKzE3OSwzOCBAQCBjbGFzcyBCYWNr
dXBUZXN0KGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLmFzc2VydF9xbXAoZXZlbnQsICdkYXRhL2Vycm9yJywgcWVycm9yKQ0K
Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRmFsc2UNCj4+Pj4+
PiArwqDCoMKgIGRlZiB0ZXN0X292ZXJsYXBwaW5nX3dyaXRlcyhzZWxmKToNCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgIyBXcml0ZSBzb21ldGhpbmcgdG8gYmFjayB1cA0KPj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBzZWxmLmhtcF9pb193cml0ZXMoJ2RyaXZlMCcsIFsoJzQyJywgJzBNJywgJzJNJyld
KQ0KPj4+Pj4+ICsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgIyBDcmVhdGUgYSByZWZlcmVuY2Ug
YmFja3VwDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYucW1wX2JhY2t1cF9hbmRfd2FpdChk
ZXZpY2U9J2RyaXZlMCcsIGZvcm1hdD1pb3Rlc3RzLmltZ2ZtdCwNCj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
eW5jPSdmdWxsJywgdGFyZ2V0PXNlbGYucmVmX2ltZykNCj4+Pj4+PiArDQo+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgICMgTm93IHRvIHRoZSB0ZXN0IGJhY2t1cDogV2Ugc2ltdWxhdGUgdGhlIGZvbGxv
d2luZyBndWVzdA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAjIHdyaXRlczoNCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgIyAoMSkgWzFNICsgNjRrLCAxTSArIDEyOGspOiBBZnRlcndhcmRzLCBldmVy
eXRoaW5nIGluIHRoYXQNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgI8KgwqDCoMKgIGFyZWEgc2hv
dWxkIGJlIGluIHRoZSB0YXJnZXQgaW1hZ2UsIGFuZCB3ZSBtdXN0IG5vdCBjb3B5DQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgICPCoMKgwqDCoCBpdCBhZ2FpbiAoYmVjYXVzZSB0aGUgc291cmNlIGlt
YWdlIGhhcyBjaGFuZ2VkIG5vdykNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgI8KgwqDCoMKgICg2
NGsgaXMgdGhlIGpvYidzIGNsdXN0ZXIgc2l6ZSkNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgIyAo
MikgWzFNLCAyTSk6IFRoZSBiYWNrdXAgam9iIG11c3Qgbm90IGdldCBvdmVyZWFnZXIuwqAgSXQN
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgI8KgwqDCoMKgIG11c3QgY29weSBbMU0sIDFNICsgNjRr
KSBhbmQgWzFNICsgMTI4aywgMk0pIHNlcGFyYXRlbHksDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
ICPCoMKgwqDCoCBidXQgbm90IHRoZSBhcmVhIGluIGJldHdlZW4uDQo+Pj4+Pj4gKw0KPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnFtcF9iYWNrdXAoZGV2aWNlPSdkcml2ZTAnLCBmb3JtYXQ9
aW90ZXN0cy5pbWdmbXQsIHN5bmM9J2Z1bGwnLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldD1zZWxmLmRlc3RfaW1nLCBzcGVlZD0x
KQ0KPj4+Pj4+ICsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi5obXBfaW9fd3JpdGVzKCdk
cml2ZTAnLCBbKCcyMycsICclaWsnICUgKDEwMjQgKyA2NCksICc2NGsnKSwNCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKCc2NicsICcxTScsICcxTScpXSkNCj4+Pj4+PiArDQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgICMgTGV0IHRoZSBqb2IgY29tcGxldGUNCj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgcmVzID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpvYi1zZXQtc3BlZWQnLCBkZXZpY2U9J2RyaXZl
MCcsIHNwZWVkPTApDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYuYXNzZXJ0X3FtcChyZXMs
ICdyZXR1cm4nLCB7fSkNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi5xbXBfYmFja3VwX3dh
aXQoJ2RyaXZlMCcpDQo+Pj4+Pj4gKw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmFzc2Vy
dFRydWUoaW90ZXN0cy5jb21wYXJlX2ltYWdlcyhzZWxmLnJlZl9pbWcsIHNlbGYuZGVzdF9pbWcp
LA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICd0YXJnZXQgaW1hZ2UgZG9lcyBub3QgbWF0Y2ggcmVmZXJlbmNlIGltYWdlJykNCj4+Pj4+PiAr
DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgZGVmIHRlc3RfZGlzbWlzc19mYWxzZShzZWxmKToNCj4+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcyA9IHNlbGYudm0ucW1wKCdxdWVyeS1ibG9j
ay1qb2JzJykNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuYXNzZXJ0X3FtcChy
ZXMsICdyZXR1cm4nLCBbXSkNCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzA1Ni5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dA0KPj4+Pj4+IGluZGV4IGRhZTQw
NGUyNzguLjM2Mzc2YmVkODcgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzA1Ni5vdXQNCj4+Pj4+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dA0KPj4+Pj4+
IEBAIC0xLDUgKzEsNSBAQA0KPj4+Pj4+IC0uLi4uLi4uLi4NCj4+Pj4+PiArLi4uLi4uLi4uLg0K
Pj4+Pj4+IMKgwqDCoCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+Pj4gLVJhbiA5IHRlc3RzDQo+Pj4+Pj4g
K1JhbiAxMCB0ZXN0cw0KPj4+Pj4+IMKgwqDCoCBPSw0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gRmFp
bGVkIGZvciBtZToNCj4+Pj4+IC0uLi4uLi4uLi4uDQo+Pj4+PiArcWVtdS1pbWc6IENvdWxkIG5v
dCBvcGVuICcvd29yay9zcmMvcWVtdS9tYXN0ZXIvdGVzdHMvcWVtdS1pb3Rlc3RzL3NjcmF0Y2gv
ZGVzdC5xY293Mic6IEZhaWxlZCB0byBnZXQgc2hhcmVkICJ3cml0ZSIgbG9jaw0KPj4+Pj4gK0lz
IGFub3RoZXIgcHJvY2VzcyB1c2luZyB0aGUgaW1hZ2UgWy93b3JrL3NyYy9xZW11L21hc3Rlci90
ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9kZXN0LnFjb3cyXT8NCj4+Pj4+ICsuLi4uLi5GLi4u
DQo+Pj4+PiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPj4+Pj4gK0ZBSUw6IHRlc3Rfb3ZlcmxhcHBpbmdfd3Jp
dGVzIChfX21haW5fXy5CYWNrdXBUZXN0KQ0KPj4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+ICtU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQo+Pj4+PiArwqAgRmlsZSAiMDU2Iiwg
bGluZSAyMTIsIGluIHRlc3Rfb3ZlcmxhcHBpbmdfd3JpdGVzDQo+Pj4+PiArwqDCoMKgICd0YXJn
ZXQgaW1hZ2UgZG9lcyBub3QgbWF0Y2ggcmVmZXJlbmNlIGltYWdlJykNCj4+Pj4+ICtBc3NlcnRp
b25FcnJvcjogRmFsc2UgaXMgbm90IHRydWUgOiB0YXJnZXQgaW1hZ2UgZG9lcyBub3QgbWF0Y2gg
cmVmZXJlbmNlIGltYWdlDQo+Pj4+PiArDQo+Pj4+PiDCoMKgwqAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+
Pj4gwqDCoMKgIFJhbiAxMCB0ZXN0cw0KPj4+Pj4NCj4+Pj4+IC1PSw0KPj4+Pj4gK0ZBSUxFRCAo
ZmFpbHVyZXM9MSkNCj4+Pj4NCj4+Pj4gSG0uwqAgSSBob3BlZCBzZWVpbmcgQkxPQ0tfSk9CX0NP
TVBMRVRFRCB3b3VsZCBiZSBlbm91Z2guDQo+Pj4NCj4+PiBUaGUgcHJvYmxlbSBpcyBoaWdoZXI6
ICJGYWlsZWQgdG8gZ2V0IHNoYXJlZCAid3JpdGUiIGxvY2siLiBCZWNhdXNlIG9mIHRoaXMgaW90
ZXN0cy5jb21wYXJlX2ltYWdlcw0KPj4+IGNhbid0IHdvcmsuIFNvLCBiZWNhdXNlIG9mIGxvY2tp
bmcsIHdlIG5lZWQgdG8gc2h1dGRvd24gcWVtdSBiZWZvcmUgc3RhcnRpbmcgcWVtdS1pbWcuDQo+
Pj4gQW5kIGl0J3MgZG9uZSBzbyBpbiB0ZXN0X2NvbXBsZXRlX3RvcCgpIChJIGp1c3QgbG9va2Vk
IGF0IGl0IGFzIGl0J3MgdGhlIG9ubHkgb3RoZXIgdXNlciBvZiBjb21wYXJlX2ltYWdlcw0KPj4+
IGluIDA1NikNCj4+DQo+PiBUaGUgZGVzdGluYXRpb24gaW1hZ2Ugc2hvdWxkbuKAmXQgYmUgaW4g
dXNlIGJ5IHFlbXUgYWZ0ZXIgdGhlIGJsb2NrIGpvYiBpcw0KPj4gZG9uZSwgdGhvdWdoLsKgIFRo
ZXJlZm9yZSwgdGhlcmUgc2hvdWxkbuKAmXQgYmUgYSBsb2NrIGlzc3VlLsKgIFRoYXTigJlzIHdo
YXQNCj4+IEkgbWVhbnQuDQo+Pg0KPiANCj4gQWgsIHVuZGVyc3RhbmQuIEhtbSwgdGhlbiBpdCdz
IHN0cmFuZ2UgdGhhdCBJIHNlZSB0aGF0IGVycm9yLi4NCj4gDQo+IENsZWFybHksIGluIGpvYl9m
aW5hbGl6ZV9zaW5nbGUoKSwgam9iX2NsZWFuKCkgaXMgY2FsbGVkIGZpcnN0LCB3aGljaCBzaG91
bGQgY2FsbCBiYWNrdXBfY2xlYW4gdG8gdW5yZWYgdGFyZ2V0LA0KPiB0aGVuIGpvYl9ldmVudF9j
b21wbGV0ZWQoKSBpcyBjYWxsZWQuLi4NCj4gDQo+IA0KDQpCdXQgQmxvY2tKb2Iubm9kZXMgYXJl
IHJlbW92ZWQgYXQgdmVyeS1lbmQgZnJvbSBibG9ja19qb2JfZnJlZSwgc28gaXQgc2VlbXMgdG8g
YmUgYW5vdGhlciByZWZlcmVuY2UgdG8gdGFyZ2V0LA0Kd2hpY2ggaXMgc3RpbGwgYWxpdmUgd2hl
biBldmVudCBpcyBzZW50Lg0KDQo+IA0KPj4NCj4+Pj4+IFNvLCB3aXRoIGFwcGxpZWQNCj4+Pj4+
DQo+Pj4+PiBAQCAtMjA3LDYgKzIwNyw3IEBAIGNsYXNzIEJhY2t1cFRlc3QoaW90ZXN0cy5RTVBU
ZXN0Q2FzZSk6DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcyA9IHNlbGYudm0ucW1w
KCdibG9jay1qb2Itc2V0LXNwZWVkJywgZGV2aWNlPSdkcml2ZTAnLCBzcGVlZD0wKQ0KPj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmFzc2VydF9xbXAocmVzLCAncmV0dXJuJywge30p
DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYucW1wX2JhY2t1cF93YWl0KCdkcml2
ZTAnKQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0uc2h1dGRvd24oKQ0KPj4+Pj4NCj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRUcnVlKGlvdGVzdHMuY29tcGFy
ZV9pbWFnZXMoc2VsZi5yZWZfaW1nLCBzZWxmLmRlc3RfaW1nKSwNCj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAndGFyZ2V0IGltYWdl
IGRvZXMgbm90IG1hdGNoIHJlZmVyZW5jZSBpbWFnZScpDQo+Pj4+DQo+Pj4+IEnigJlkIHBlcnNv
bmFsbHkgcHJlZmVyIGF1dG9fZGlzbWlzcz1GYWxzZSBhbmQgdGhlbiBibG9jay1qb2ItZGlzbWlz
cy4NCj4+Pj4gQWx0aG91Z2ggSSBjYW7igJl0IGdpdmUgYSByZWFzb24gd2h5Lg0KPj4+Pg0KPj4+
Pj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4+Pj4+IFRlc3RlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+Pg0KPj4+PiBJbiBhbnkgY2FzZSwg
dGhhbmtzIQ0KPj4+Pg0KPj4+PiBNYXgNCj4+Pj4NCj4+Pg0KPj4+DQo+Pg0KPj4NCj4gDQo+IA0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

