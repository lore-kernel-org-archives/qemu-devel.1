Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B1BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75630218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uWeWhefd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75630218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxX4-0002Zt-GK
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFxVa-0001J6-7G
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFxVY-0003Pi-Pb
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:34:49 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com
 ([40.107.14.105]:8419 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFxVY-0003Oy-0W; Thu, 03 Oct 2019 05:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb5J7Y8WdRO1XTrxvGlD9vAdKnT1xWixKGVBPg9IngJCwbe+ZeN645JllivMyZcqLDhJ9+D1YQE2tonjGLkyB/pJkdCcR7AlNtaIH8Uj4EVUipCjlN1IliUkj6tYGgkATMrmobJYYVhuqjbFJ3BJo7XE1sWVuuliypvaewXrHnjeRiLqGxaF6uHh+JqTkIPju9Jqcfw8eJ136pR01aSX3vo2evYhPtkP73caKKWhHyN1Hg8KPWbJY8KxA+STa3ujmabT6cH9mWWX0GxcAM3RjGDigXOho4vNjrJdjnp6Fjncyl4ie+gkaXKcY7VU5tWq/AGgrc0fulzKMi0MX76Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt03wWdiNAOsnBToOwHP1/QlOyF+hE2ihupVdhT7zYQ=;
 b=QuQk9zlpBTPkmEWeHqt5gTB+S7vsGGqx27AZlI+lBw5mKYwWKp63TRpFNBI3Iv2VcUtlp26xMt+hOUUdMm7EULP2rPN81xukPlpXihlFMoXwSagsKhogg04NjEdw6OTpFB+mDwVte3cYBfWrgeoeow6jM5GawOEfWCpkelozw56nddEPRlbXfBgz3lRG5Bf51gI91TR2V4h3ycnVpw+3Hkd9rV2DfQQ1nG0XsfApPbZWsLoriF5DxnnSL/J7BuvYj0OMEEoYtD3Zk+Qrsu39kAZmpCOn0u86+ID1VSxtU8UYaL2gs9S8j+6QagKEiLUMUX7h0+KL2u4W54ojPaxosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt03wWdiNAOsnBToOwHP1/QlOyF+hE2ihupVdhT7zYQ=;
 b=uWeWhefdthuotZAIDH/Z/wUCpoe9jvBXQMugLFI3IjpRyF4uAMBTCFXQnJEnMFXbNREsxLG3lEp2/uFKRdeK5hlLjvyQaWjhvwoWef76xVXlg2VFHrhD9n0TrYNigB+FEqVuhIvGpN3y51ttGmtv24+BmZCQA8361lm1Er7GcCg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5420.eurprd08.prod.outlook.com (52.133.241.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 3 Oct 2019 09:34:44 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 09:34:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdHkGAAgAA0KAD//857AIAADO6AgAEopYA=
Date: Thu, 3 Oct 2019 09:34:43 +0000
Message-ID: <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
 <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
 <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
In-Reply-To: <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:7:28::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003123441448
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aaf0659-8f97-4386-d05f-08d747e4ec2b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5420; 
x-ms-traffictypediagnostic: DB8PR08MB5420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5420F172B9926E80CC65DCDBC19F0@DB8PR08MB5420.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39850400004)(136003)(346002)(366004)(199004)(189003)(110136005)(486006)(25786009)(386003)(31686004)(36756003)(229853002)(76176011)(64756008)(5660300002)(2616005)(478600001)(8676002)(26005)(31696002)(81156014)(8936002)(107886003)(186003)(66446008)(102836004)(71190400001)(81166006)(6486002)(11346002)(6436002)(6116002)(52116002)(446003)(99286004)(316002)(256004)(14444005)(71200400001)(305945005)(6506007)(86362001)(4326008)(6512007)(53546011)(6246003)(7736002)(66946007)(14454004)(3846002)(2501003)(66556008)(66476007)(54906003)(66066001)(476003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5420;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 842qBdbfGUsHzhlWMFQOTGC94EoZWmzs9BYeLYvhLjhBLw0PzCJuIPtTxdH3nn8F/OlCDAm0f/YRUtF7lUubPVbWRINEN/8UGYN4RZjQVtrYryYu1FzZtjnbwhEi9TM1unb9t31iN22p8kIytB88tKLbR3pTYHhBODBWQ0I6in5WRF8bO8Ylo8siqQS7fRfFALlYPii+qzWBwbTFN2iRaU876oiyKwtlLqdu3OT4C+kjqvQmXhV4+1wVMAEsHzJlZBqPDBiAe7a6L9q0XGCYNXHlHl/xv6eJxHeiqlEo2cyZb7Yq2dstzQg/nb5Cvsf+K9Wmker4UfvVOLKOmqoOPopPjDdd05t+70wpNVwaR/8nL2fLr35CvPbfTr4kIhXIsqm9BB6n6Rhn2w75WJCENImVDd6th64LPFSAMNODBtg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0ABA44F015B0B469ABE1C2BCD96BCEF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaf0659-8f97-4386-d05f-08d747e4ec2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 09:34:43.8836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUEQqWB/IA09a36seYCLevG6yf7WIBQxzRwWH9g6AcRlRKfn0kJ/aNHNWA1W0lNWqICSvrTWv3jzPbVGMSrWz2BqGY0YjEL3+NIZSlvYPf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5420
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.105
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxODo1MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMi4xMC4xOSAxNzowNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAyLjEwLjIwMTkgMTg6MDMs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMDIuMTAuMjAxOSAxNzo1
NywgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxMi4wOS4xOSAxNzoxMywgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IFByaW9yIDlhZGMxY2I0OWFmOGQgZG9fc3lu
Y190YXJnZXRfd3JpdGUgaGFkIGEgYnVnOiBpdCByZXNldCBhbGlnbmVkLXVwDQo+Pj4+PiByZWdp
b24gaW4gdGhlIGRpcnR5IGJpdG1hcCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBtYXkgbm90IGNvcHkg
c29tZSBieXRlcw0KPj4+Pj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFsbHkg
bGVhZHMgdG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4+Pj4gdGFyZ2V0Lg0KPj4+Pj4NCj4+Pj4+
IFNvIDlhZGMxY2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1hcCBncmFudWxhcml0eSB0byBiZQ0K
Pj4+Pj4gcmVxdWVzdF9hbGlnbm1lbnQgZm9yIG1pcnJvci10b3AgZmlsdGVyLCBzbyB3ZSBhcmUg
bm90IHdvcmtpbmcgd2l0aA0KPj4+Pj4gdW5hbGlnbmVkIHJlcXVlc3RzLiBIb3dldmVyIGZvcmNp
bmcgbGFyZ2UgYWxpZ25tZW50IG9idmlvdXNseSBkZWNyZWFzZXMNCj4+Pj4+IHBlcmZvcm1hbmNl
IG9mIHVuYWxpZ25lZCByZXF1ZXN0cy4NCj4+Pj4+DQo+Pj4+PiBUaGlzIGNvbW1pdCBwcm92aWRl
cyBhbm90aGVyIHNvbHV0aW9uIGZvciB0aGUgcHJvYmxlbTogaWYgdW5hbGlnbmVkDQo+Pj4+PiBw
YWRkaW5nIGlzIGFscmVhZHkgZGlydHksIHdlIGNhbiBzYWZlbHkgaWdub3JlIGl0LCBhcw0KPj4+
Pj4gMS4gSXQncyBkaXJ0eSwgaXQgd2lsbCBiZSBjb3BpZWQgYnkgbWlycm9yX2l0ZXJhdGlvbiBh
bnl3YXkNCj4+Pj4+IDIuIEl0J3MgZGlydHksIHNvIHNraXBwaW5nIGl0IG5vdyB3ZSBkb24ndCBp
bmNyZWFzZSBkaXJ0aW5lc3Mgb2YgdGhlDQo+Pj4+PiAgwqDCoMKgIGJpdG1hcCBhbmQgdGhlcmVm
b3JlIGRvbid0IGRhbWFnZSAic3luY2hyb25pY2l0eSIgb2YgdGhlDQo+Pj4+PiAgwqDCoMKgIHdy
aXRlLWJsb2NraW5nIG1pcnJvci4NCj4+Pj4NCj4+Pj4gQnV0IHRoYXTigJlzIG5vdCB3aGF0IGFj
dGl2ZSBtaXJyb3IgaXMgZm9yLsKgIFRoZSBwb2ludCBvZiBhY3RpdmUgbWlycm9yIGlzDQo+Pj4+
IHRoYXQgaXQgbXVzdCBjb252ZXJnZSBiZWNhdXNlIGV2ZXJ5IGd1ZXN0IHdyaXRlIHdpbGwgY29u
dHJpYnV0ZSB0b3dhcmRzDQo+Pj4+IHRoYXQgZ29hbC4NCj4+Pj4NCj4+Pj4gSWYgeW91IHNraXAg
YWN0aXZlIG1pcnJvcmluZyBmb3IgdW5hbGlnbmVkIGd1ZXN0IHdyaXRlcywgdGhleSB3aWxsIG5v
dA0KPj4+PiBjb250cmlidXRlIHRvd2FyZHMgY29udmVyZ2luZywgYnV0IGluIGZhY3QgbGVhZCB0
byB0aGUgb3Bwb3NpdGUuDQo+Pj4+DQo+Pj4NCj4+PiBUaGUgd2lsbCBub3QgY29udHJpYnV0ZSBv
bmx5IGlmIHJlZ2lvbiBpcyBhbHJlYWR5IGRpcnR5LiBBY3R1YWxseSwgYWZ0ZXINCj4+PiBmaXJz
dCBpdGVyYXRpb24gb2YgbWlycm9yaW5nIChjb3B5aW5nIHRoZSB3aG9sZSBkaXNrKSwgYWxsIGZv
bGxvd2luZyB3cml0ZXMNCj4+PiB3aWxsIGNvbnRyaWJ1dGUsIHNvIHRoZSB3aG9sZSBwcm9jZXNz
IG11c3QgY29udmVyZ2UuIEl0IGlzIGEgYml0IHNpbWlsYXIgd2l0aA0KPj4+IHJ1bm5pbmcgb25l
IG1pcnJvciBsb29wIGluIG5vcm1hbCBtb2RlLCBhbmQgdGhlbiBlbmFibGUgd3JpdGUtYmxvY2tp
bmcuDQo+Pj4NCj4+DQo+Pg0KPj4gSW4gb3RoZXIgd29yZHMsIHdlIGRvbid0IG5lZWQgImFsbCBn
dWVzdCB3cml0ZXMgY29udHJpYnV0ZSIgdG8gY29udmVyZ2UsDQo+PiAiYWxsIGd1ZXN0IHdyaXRl
cyBkb24ndCBjcmVhdGUgbmV3IGRpcnR5IGJpdHMiIGlzIGVub3VnaCwgYXMgd2UgaGF2ZSBwYXJh
bGxlbA0KPj4gbWlycm9yIGl0ZXJhdGlvbiB3aGljaCBjb250aWd1b3VzbHkgaGFuZGxlcyBkaXJ0
eSBiaXRzLg0KPiANCj4gSG0sIGluIGEgc2Vuc2UuICBCdXQgaXQgZG9lcyBtZWFuIHRoYXQgZ3Vl
c3Qgd3JpdGVzIHdpbGwgbm90IGNvbnRyaWJ1dGUNCj4gdG8gY29udmVyZ2VuY2UuDQo+IA0KPiBB
bmQgdGhhdOKAmXMgYWdhaW5zdCB0aGUgY3VycmVudCBkZWZpbml0aW9uIG9mIHdyaXRlLWJsb2Nr
aW5nLCB3aGljaCBkb2VzDQo+IHN0YXRlIHRoYXQg4oCcd2hlbiBkYXRhIGlzIHdyaXR0ZW4gdG8g
dGhlIHNvdXJjZSwgd3JpdGUgaXQgKHN5bmNocm9ub3VzbHkpDQo+IHRvIHRoZSB0YXJnZXQgYXMg
d2VsbOKAnS4NCj4gDQoNCkhtbSwgdW5kZXJzdGFuZC4gQnV0IElNSE8gb3VyIHByb3Bvc2VkIGJl
aGF2aW9yIGlzIGJldHRlciBpbiBnZW5lcmFsLg0KRG8geW91IHRoaW5rIGl0J3MgYSBwcm9ibGVt
IHRvIGNoYW5nZSBzcGVjIG5vdz8NCklmIHllcywgSSdsbCByZXNlbmQgd2l0aCBhbiBvcHRpb24N
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

