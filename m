Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E7C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C04D20842
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OMotQzl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C04D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCKx-0003kf-BR
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxCKG-0002vZ-1k
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxCKE-0005VY-SB
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:33:35 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com
 ([40.107.3.132]:4992 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxCKD-0005UK-RX; Mon, 12 Aug 2019 11:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEQEyQYL/dcLKw01+508cx1rdCzhe77TTVN4vgRDyHsYnCMGBPS0URe562GO9UAY80uxgZZPYB+4khr6WrtjJILSK+JwqVH5W7SRkIVI2rwoRm4Cf/xe7w7zRU4eNqwjpLGhDb4xu+9GaM35gbqenWSkNby4RMlfM+snWCmYcvLhVod60LVVfmQKihCbEQe1LXe43CDxJeuwl1ia9NW8bV4xQEQyPZxZh+2m16DJojnFpXGRMJGENzo3vtyAPoLJxo4RErX8jY30yP7jaiPJ0hURbAG0ffoyWBbHqgk2Zigcz71xujfF8MTkTbGflk9y0KLP9FSjg+rPGPp1ftfjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0I0LtWc0oVCuVz1VIzXFyRwv9fl51JdhKSsgtITBg0=;
 b=JMseiW0htUHZzZnKNNeiGRSLosyp+JyU82SrQXg4vUM7VD3xImX833qnv5imYqZLp4EPliu1aFOl5F8S+QCoAVMt2GdhjXos4OVRdzHzHdDZLlH/yZztWsynO/ZsusRtR/5oUjfLsO3CUsW8hioxBxV80lrO66pRtEaOTSPVptFvgQk9SjwnHZLRve2ClmtKBrF8bkmbo6QrqolDdJEAe0TBJNNI2t6nOG5Lr5XAZ2zi1KJ5aDSk1y34h32ISg5TnEm80y/4CRSqMtJJpfr1LVSk923Cm0XJo8CPDk0n+jPDAJq93/STNHwlDRc9SxQAE8MaETaT6RGlQJ6UNx76cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0I0LtWc0oVCuVz1VIzXFyRwv9fl51JdhKSsgtITBg0=;
 b=OMotQzl7fHN+Bar8PTcOwLffPSOD+Jc0xqNKAPTNKKXF1zjSi0cBwL5D3m43aLTE9I+wq3UkBiAIjYy1D9bSKTCg0twznFk0H4nySghJVqiQSrv8aCIMGXWEcOAwQ++rN+AmcgVX3/5tEn3E11ifb2XCKSota6Ib9N4+G+cFRTA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4074.eurprd08.prod.outlook.com (20.179.9.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 15:33:30 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 15:33:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 3/3] vpc: Do not return RAW from block_status
Thread-Index: AQHVQwFgmtJInCYBUkSBviHaT9mW1ab3wI+A
Date: Mon, 12 Aug 2019 15:33:30 +0000
Message-ID: <627fbb64-5ffe-aca7-6198-9d991d4219e3@virtuozzo.com>
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-4-mreitz@redhat.com>
In-Reply-To: <20190725155512.9827-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0009.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::19) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812183327495
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f4fd7b-8121-4b54-2802-08d71f3a6d79
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4074; 
x-ms-traffictypediagnostic: DB8PR08MB4074:
x-microsoft-antispam-prvs: <DB8PR08MB40749439D612086C6D0B3979C1D30@DB8PR08MB4074.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(39840400004)(396003)(189003)(199004)(54906003)(316002)(25786009)(110136005)(52116002)(102836004)(386003)(26005)(6506007)(66066001)(99286004)(305945005)(76176011)(486006)(11346002)(31686004)(446003)(2616005)(186003)(476003)(86362001)(6436002)(64756008)(66446008)(6486002)(7736002)(6246003)(2501003)(5660300002)(6512007)(53936002)(66556008)(66476007)(3846002)(6116002)(66946007)(71200400001)(2906002)(71190400001)(478600001)(256004)(36756003)(14444005)(31696002)(229853002)(14454004)(8936002)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4074;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cHjzad4jr5bZTcH+9RnN6MFUM37rmyF6WQO9pZzudyw6g7IxXfAFVVvmngA6dyxeZlzG8v3Fu2v9Q6X49vf8CLbIf5fXtEupH0BfjfvL+G6FfhrTviQKftQBo9cvaD3kYtIjF391oTd0alhlQqr3m33/nwuSgjBfPmllXCi/PJv/oKE7azd09FRrLp26DSWadcn1Gfs4vh2nfuXs5I3PZWJraQ69xQ21GEPCl4BkFpcWS+uVd+VxV819nhBIEwSZWetF7CqN+f0D/CXtj4HACROmMAkUWXc1L85DDwLGf9YRgwyLEp8JPrM6CEULMv3RvxN/hnOHH6wMvB1undTNB8awgZaDo5jkwYfsk4DOoBeqKl7VU0tBMhJjeMtpcr3fV7V/55FnlhzS7UHYGQBb3fVI54fhNdAL8ceNBUnkNk4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E4622DBA22A594C80B9E8501C173AA3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f4fd7b-8121-4b54-2802-08d71f3a6d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 15:33:30.2245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SknO1cXolHSHSBE/8g2lUre1XQ95jOJSglBtK0YPTqmfaBieNtGEYDACeFeTPPdxUOrgrXDhdzFQhckHUTEDFCCjB6TT+uzUr75q5iebJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4074
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.132
Subject: Re: [Qemu-devel] [PATCH 3/3] vpc: Do not return RAW from
 block_status
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

MjUuMDcuMjAxOSAxODo1NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiB2cGMgaXMgbm90IHJlYWxseSBh
IHBhc3N0aHJvdWdoIGRyaXZlciwgZXZlbiB3aGVuIHVzaW5nIHRoZSBmaXhlZA0KPiBzdWJmb3Jt
YXQgKHdoZXJlIGhvc3QgYW5kIGd1ZXN0IG9mZnNldHMgYXJlIGVxdWFsKS4gIEl0IHNob3VsZCBo
YW5kbGUNCj4gcHJlYWxsb2NhdGlvbiBsaWtlIGFsbCBvdGhlciBkcml2ZXJzIGRvLCBuYW1lbHkg
YnkgcmV0dXJuaW5nDQo+IERBVEEgfCBSRUNVUlNFIGluc3RlYWQgb2YgUkFXLg0KPiANCj4gVGhl
cmUgaXMgbm8gdGFuZ2libGUgZGlmZmVyZW5jZSBidXQgdGhlIGZhY3QgdGhhdCBiZHJ2X2lzX2Fs
bG9jYXRlZCgpIG5vDQo+IGxvbmdlciBmYWxscyB0aHJvdWdoIHRvIHRoZSBwcm90b2NvbCBsYXll
ci4NCg0KSG1tLiBJc24ndCBhIHJlYWwgYnVnIChmaXhlZCBieSB0aGlzIHBhdGNoKSA/DQoNCkFz
c3VtZSB2cGMtPmZpbGUgaXMgcWNvdzIgd2l0aCBiYWNraW5nLCB3aGljaCBoYXZlICJ1bmFsbG9j
YXRlZCIgcmVnaW9uLCB3aGljaCBpcw0KYmFja2VkIGJ5IGFjdHVhbCBkYXRhIGluIGJhY2tpbmcg
ZmlsZS4NCg0KU28sIHRoaXMgcmVnaW9uIHdpbGwgYmUgcmVwb3J0ZWQgYXMgbm90IGFsbG9jYXRl
ZCBhbmQgd2lsbCBiZSBza2lwcGVkIGJ5IGFueSBjb3B5aW5nDQpsb29wIHVzaW5nIGJsb2NrLXN0
YXR1cz8gSXMgaXQgYSBidWcgb2YgQkRSVl9CTE9DS19SQVcgaXRzZWxmPyBPciBJIGRvbid0IHVu
ZGVyc3RhbmQNCnNvbWV0aGluZy4uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8
bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3ZwYy5jIHwgMiArLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL3ZwYy5jIGIvYmxvY2svdnBjLmMNCj4gaW5kZXggZDQ3NzZlZThhNS4uYjI1
YWFiMDQyNSAxMDA2NDQNCj4gLS0tIGEvYmxvY2svdnBjLmMNCj4gKysrIGIvYmxvY2svdnBjLmMN
Cj4gQEAgLTczNyw3ICs3MzcsNyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiB2cGNfY29fYmxv
Y2tfc3RhdHVzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgKnBudW0gPSBieXRl
czsNCj4gICAgICAgICAgICptYXAgPSBvZmZzZXQ7DQo+ICAgICAgICAgICAqZmlsZSA9IGJzLT5m
aWxlLT5iczsNCj4gLSAgICAgICAgcmV0dXJuIEJEUlZfQkxPQ0tfUkFXIHwgQkRSVl9CTE9DS19P
RkZTRVRfVkFMSUQ7DQo+ICsgICAgICAgIHJldHVybiBCRFJWX0JMT0NLX0RBVEEgfCBCRFJWX0JM
T0NLX09GRlNFVF9WQUxJRCB8IEJEUlZfQkxPQ0tfUkVDVVJTRTsNCj4gICAgICAgfQ0KPiAgIA0K
PiAgICAgICBxZW11X2NvX211dGV4X2xvY2soJnMtPmxvY2spOw0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

