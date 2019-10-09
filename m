Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBBEC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96309206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RG+LJicR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96309206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54849 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHY4-0006MX-49
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIERy-0004RQ-UO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIERx-0008QR-8e
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:04:30 -0400
Received: from mail-eopbgr00135.outbound.protection.outlook.com
 ([40.107.0.135]:46306 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIERw-0008Of-Fu; Wed, 09 Oct 2019 12:04:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1rEhBRBnD2qKLG5GUyXZe82srMm5skpQ9QXWleb2IUsKYSfaMxWHxB5I1czpoKrDDSSyseuCU4IknYhw+vYc9x8uMP1YhEbLTLr0RR1LZPJPksnSAG/d+ykLYiDWpRciEXTo3oZdsVj2GSnTEr4oloPte3MibI4B/xgYhOIyjNsop46zktIPjhh9VVD/iizvI1vEewRIecoF4D2+cYsQ4kJNpFE04pGauGzWGtxK5gCd3evkGr2WFbKLbv4Ai/QbvLVtkKkG+mct2jYh+hQ3CQmrU6bZKbehRobqiz7LzYC/oybLA42Bb8IfoVEcF0Miy+LBGVZ1e/P0qwr8yZQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MejXB5iWODwBDXMi1hsLLWoHT4sYYSrDP2b+VOcSduc=;
 b=OuCBl0gyRt54lTcwNGZub/MyYJvyLtMAz/TXCcNoshz+aXI9D3agrea6c8eGwEpHMXsCqRcY7eTEA9Z+mkeYDrnfoPipwpbsaweRUStv5+K8Xnnj4AgjRblXMI55lSKMiYG6gZG/7fmISCd/v0RAFO2ITIYc6THsKoqJ120GJhxRe5sj9pkDK2x37bjYPHrYx2rM8h/nLch10YfjFGgiR/A5vAhzQwBHVXaD94xge/relUhT+lKuUdh/M6tHABw0auuIlCJg3z6QGs7hPZ4rQPF9S51wXuV5aH1ceJMli2z0PM3ST7dMyWEQjGCO1QaCC/sgR6E1q9nZwW/bZKXuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MejXB5iWODwBDXMi1hsLLWoHT4sYYSrDP2b+VOcSduc=;
 b=RG+LJicR083bLSebQRYoloteGTJMEBsUeTMV51Zb4U0mYVrCTPDR4Xy2Bwm1D7bIC3PrB5Hajb3fPA2kQ8hMHVewpTjfrBvY7WLDMaSe6WEXi1uHqUSpRrO8L7oZronqNyIAIVq8ah4vfQha/uv+eueN+V0tXzMVKDb3+a8Ip1U=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4188.eurprd08.prod.outlook.com (20.179.12.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 16:04:23 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 16:04:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 01/10] hbitmap: introduce HBITMAP_MAX_ORIG_SIZE
Thread-Topic: [PATCH 01/10] hbitmap: introduce HBITMAP_MAX_ORIG_SIZE
Thread-Index: AQHVd6HZ+dKQIl1FzUmH7s4nNm4VyadSft6AgAAISoA=
Date: Wed, 9 Oct 2019 16:04:23 +0000
Message-ID: <da599d8f-13b7-cee4-faa4-4c310634b9dd@virtuozzo.com>
References: <20190930151502.7829-1-vsementsov@virtuozzo.com>
 <20190930151502.7829-2-vsementsov@virtuozzo.com>
 <a128842b-d3c8-adb7-ec27-c07f59fd53fc@redhat.com>
In-Reply-To: <a128842b-d3c8-adb7-ec27-c07f59fd53fc@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0075.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::46) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191009190421416
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc3d8fe5-679d-4dd9-97db-08d74cd25a1e
x-ms-traffictypediagnostic: DB8PR08MB4188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB418853F63D390C83EF230A3EC1950@DB8PR08MB4188.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39840400004)(376002)(346002)(396003)(189003)(199004)(66066001)(5660300002)(54906003)(53546011)(11346002)(6506007)(2616005)(446003)(386003)(26005)(8676002)(81166006)(81156014)(305945005)(316002)(7736002)(486006)(6436002)(66446008)(64756008)(76176011)(229853002)(86362001)(66476007)(14454004)(66556008)(2501003)(2906002)(36756003)(3846002)(6116002)(476003)(66946007)(110136005)(256004)(107886003)(4326008)(99286004)(31696002)(25786009)(186003)(6512007)(8936002)(71190400001)(6246003)(6486002)(478600001)(71200400001)(102836004)(52116002)(14444005)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4188;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxUNXCs/SgiF5uF20yoFq75w57ZjuVa1CiGw4KQvfQBbQgKRwdm2dDvMQe+bESf5rEaZ6B5E8MVY+nC/Dhcj4JSsn2pe25OASNAepaSxA+1QUBJSHz5nmgcfdRdQAM2YIBZRiCezp7oX2cgYvrfp2gBsCNtdqmdI+nVWFkKQ7vn7bI9D4aIa7zTU7sffdjeVNquFVouSDxrTHVYiTkkTHRA9Uzx8f/tG1n100L9oUBYvqrDdrgus9vfAR5h41M370lDmZsZwiB96wiYbLB7pdYsk/0R9TRuQn1ls1/z+h/p9eMYf+oL5VA0h4z1IJkvRiVc4ZDA/9m+QLNvBgpqJok8BNWFN5NNoMODznkXS407FreLNL4yBGWrWXcS+BaWSijkBwtPG1LPUTxv4W8JLbt2UylFoe7UucfPO63xT8RM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B80CD8BF3F1764ABB4F6685F0FA91CC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3d8fe5-679d-4dd9-97db-08d74cd25a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 16:04:23.5932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CfDWaayoPtInmZd9zAg/MeJcgQdvwzi9MKvrWnJv+5dQ1IRZVjQCwd09K8V/p8pm95Bz4o+TZFM54PWC9ct3OhchJ+4wp/kiBgKunwyj3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4188
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.135
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMTAuMjAxOSAxODozNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8zMC8xOSAxMDoxNCBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cj4gDQo+IEEgYml0IGxpZ2h0IG9uIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgZXhwbGFpbmluZyB3
aHkuDQoNCklmIHVzZSBqdXN0IElOVDY0X01BWCwgdGhlIGNvbW1lbnQgYmVsb3cgbWF5IGJlIG1v
dmUgaGVyZSwgYWNjb21wYW5pZWQgYnkNCnlvdXIgbm90ZSBhYm91dCBkaXNrIHNpemUgbGltaXQu
DQoNCj4gDQo+PiAtLS0NCj4+IMKgIGluY2x1ZGUvcWVtdS9oYml0bWFwLmggfCA3ICsrKysrKysN
Cj4+IMKgIHV0aWwvaGJpdG1hcC5jwqDCoMKgwqDCoMKgwqDCoCB8IDIgKysNCj4+IMKgIDIgZmls
ZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
cWVtdS9oYml0bWFwLmggYi9pbmNsdWRlL3FlbXUvaGJpdG1hcC5oDQo+PiBpbmRleCAxYmY5NDRj
YTNkLi44MjMxN2M1MzY0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9xZW11L2hiaXRtYXAuaA0K
Pj4gKysrIGIvaW5jbHVkZS9xZW11L2hiaXRtYXAuaA0KPj4gQEAgLTMzLDYgKzMzLDEzIEBAIHR5
cGVkZWYgc3RydWN0IEhCaXRtYXBJdGVyIEhCaXRtYXBJdGVyOw0KPj4gwqDCoCAqLw0KPj4gwqAg
I2RlZmluZSBIQklUTUFQX0xFVkVMU8KgwqDCoMKgwqDCoMKgwqAgKChIQklUTUFQX0xPR19NQVhf
U0laRSAvIEJJVFNfUEVSX0xFVkVMKSArIDEpDQo+PiArLyoNCj4+ICsgKiBXZSBoYXZlIEFQSXMg
d2hpY2ggcmV0dXJucyBzaWduZWQgaW50NjRfdCwgdG8gYmUgYWJsZSB0byByZXR1cm4gZXJyb3Iu
DQo+PiArICogVGhlcmVmb3JlIHdlIGNhbid0IGhhbmRsZSBiaXRtYXBzIHdpdGggYWJzb2x1dGUg
c2l6ZSBsYXJnZXIgdGhhbg0KPj4gKyAqIChJTlQ2NF9NQVgrMSkuIFN0aWxsLCBrZWVwIGl0IElO
VDY0X01BWCB0byBiZSBhIGJpdCBzYWZlci4NCj4+ICsgKi8NCj4+ICsjZGVmaW5lIEhCSVRNQVBf
TUFYX09SSUdfU0laRSBJTlQ2NF9NQVgNCj4gDQo+IFRoYXQsIGFuZCBiaXRtYXBzIHJlcHJlc2Vu
dCBkaXNrIGltYWdlcywgYnV0IGRpc2sgaW1hZ2VzIGNhbid0IGV4Y2VlZCBJTlQ2NF9NQVggYnl0
ZXMgKHRoYW5rcyB0byBvZmZfdCBiZWluZyBzaWduZWQpLsKgIEJ1dCBkb2VzIGludHJvZHVjaW5n
IGEgbmV3IGNvbnN0YW50IHJlYWxseSBoZWxwPw0KPiANCj4+ICsNCj4+IMKgIHN0cnVjdCBIQml0
bWFwSXRlciB7DQo+PiDCoMKgwqDCoMKgIGNvbnN0IEhCaXRtYXAgKmhiOw0KPj4gZGlmZiAtLWdp
dCBhL3V0aWwvaGJpdG1hcC5jIGIvdXRpbC9oYml0bWFwLmMNCj4+IGluZGV4IDc1N2QzOWUzNjAu
LmRmMTkyMjM0ZTMgMTAwNjQ0DQo+PiAtLS0gYS91dGlsL2hiaXRtYXAuYw0KPj4gKysrIGIvdXRp
bC9oYml0bWFwLmMNCj4+IEBAIC03MDgsNiArNzA4LDcgQEAgSEJpdG1hcCAqaGJpdG1hcF9hbGxv
Yyh1aW50NjRfdCBzaXplLCBpbnQgZ3JhbnVsYXJpdHkpDQo+PiDCoMKgwqDCoMKgIEhCaXRtYXAg
KmhiID0gZ19uZXcwKHN0cnVjdCBIQml0bWFwLCAxKTsNCj4+IMKgwqDCoMKgwqAgdW5zaWduZWQg
aTsNCj4+ICvCoMKgwqAgYXNzZXJ0KHNpemUgPD0gSEJJVE1BUF9NQVhfT1JJR19TSVpFKTsNCj4g
DQo+IG9yIGNhbiB3ZSBqdXN0IGlubGluZSBJTlQ2NF9NQVggaGVyZT8NCg0KT0sgZm9yIG1lIHRv
by4NCg0KPiANCj4+IMKgwqDCoMKgwqAgaGItPm9yaWdfc2l6ZSA9IHNpemU7DQo+PiDCoMKgwqDC
oMKgIGFzc2VydChncmFudWxhcml0eSA+PSAwICYmIGdyYW51bGFyaXR5IDwgNjQpOw0KPj4gQEAg
LTczOCw2ICs3MzksNyBAQCB2b2lkIGhiaXRtYXBfdHJ1bmNhdGUoSEJpdG1hcCAqaGIsIHVpbnQ2
NF90IHNpemUpDQo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IG51bV9lbGVtZW50cyA9IHNpemU7DQo+
PiDCoMKgwqDCoMKgIHVpbnQ2NF90IG9sZDsNCj4+ICvCoMKgwqAgYXNzZXJ0KHNpemUgPD0gSEJJ
VE1BUF9NQVhfT1JJR19TSVpFKTsNCj4+IMKgwqDCoMKgwqAgaGItPm9yaWdfc2l6ZSA9IHNpemU7
DQo+PiDCoMKgwqDCoMKgIC8qIFNpemUgY29tZXMgaW4gYXMgbG9naWNhbCBlbGVtZW50cywgYWRq
dXN0IGZvciBncmFudWxhcml0eS4gKi8NCj4+DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

