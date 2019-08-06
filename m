Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79290C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E9C208C3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yv14XBIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E9C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2CO-0003Mt-Fv
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44793)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hv2Bi-0002on-Th
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hv2Bh-0006zT-Ku
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:19:50 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com
 ([40.107.14.112]:63872 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hv2Bh-0006yy-1x; Tue, 06 Aug 2019 12:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGeTtYwYkBkp4hfuYE9MrqAdaKFADXEBvqmuGVe3OCAnTDPpUjAozKvW9Ft0xOq+k6wL2RN15BqbxvPDlFgSA+I+e9lNnh8RZ4cMK6tA7QJ+PaVZc5UGiy7ihkyBuMoQ7WBFpOjwMOF9TcRl0u58c8uqC6gkjEeFerBKHqg5RKrL76l8L858NS5CdypqMNRpPt7iMalGDYsRR+0wRXcOcW9LAFggOMU9I/9X/NY0dG1+abTmyJQ/hkc2nLBoaty8aXezmE3HvUisP8eZNOQS2BghaU653ssqNC748A8uWv/b1f2FVYPgMqzq8akbSmOoNurov6SfIWz0cJULQ3ZcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=676kK9sPmwnn8PcLVz3i0NPfvaYVYp8aGR7HjDaRVgo=;
 b=IGIE1H7KjqDIXMFVrVRskfT6je68qe6Mky6tAd1MFjOZNOijUljagbQrvw45e0/FHox5CZPaT6I4ERzRIEkIK9lfVgKL/6OjumTYRGfnMKG1OdNkaWxhkU/LDERPVnDSRNsnNshcp42pJQT/y8nm9HQM9oHZ6VTFf+8XK/fFkYLH303V1Ssq3eBdcTOm0T+TCjon/2V4J8YCVjYsC0fPWOymnmO4mDoL3ZUObyvkh+aMC33Sq/6qu64fu0Xp5N7zvF2VmGxjfYEDsYYkJafZ7RZmENQUc2vjy6IuIkc571PDFhkVCXdc0nh0hSsXPfCJwr8EBwjbpUrojbDl11W1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=676kK9sPmwnn8PcLVz3i0NPfvaYVYp8aGR7HjDaRVgo=;
 b=Yv14XBIv+WUffx9ERYauMDg1H9lH8NQ64Joa7hYMacGnbCEzWkx5YT/ZrMNu8aDNO+xyFWeV/OjLMBa0RinCFlymGXyclbcjgR08hlJDGMe4sR63knHdw5Xp2pvvPLC4+Tm8IotVF1a0vcwg8GsMn2uJGNCxIphIuDhgo/H0fhg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5386.eurprd08.prod.outlook.com (52.133.241.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Tue, 6 Aug 2019 16:19:44 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:19:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] util/hbitmap: strict hbitmap_reset
Thread-Index: AQHVTGtMH7YacSuUYU+otoBPFxph3abuSc2AgAAC3QA=
Date: Tue, 6 Aug 2019 16:19:44 +0000
Message-ID: <c0f0831f-851b-a76d-208c-22d97e4392d8@virtuozzo.com>
References: <20190806152611.280389-1-vsementsov@virtuozzo.com>
 <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
In-Reply-To: <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190806191942132
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4de00094-b77b-4ff1-04c7-08d71a89e498
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5386; 
x-ms-traffictypediagnostic: DB8PR08MB5386:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB5386030A09BE4AA5FB821751C1D50@DB8PR08MB5386.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(346002)(136003)(376002)(189003)(199004)(2906002)(53546011)(71200400001)(476003)(2616005)(486006)(11346002)(446003)(71190400001)(14454004)(31696002)(4326008)(107886003)(86362001)(6246003)(68736007)(478600001)(25786009)(316002)(6436002)(186003)(305945005)(7736002)(26005)(64756008)(3846002)(66446008)(66556008)(6306002)(6486002)(36756003)(966005)(229853002)(6512007)(110136005)(5660300002)(66066001)(6506007)(53936002)(386003)(66476007)(102836004)(54906003)(6116002)(52116002)(99286004)(66946007)(256004)(31686004)(76176011)(81156014)(81166006)(8676002)(8936002)(2501003)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5386;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pcZ6ZDGITsNl+GtF3jHxuypgyVuLVaiiClg52woWmZsxaccGoRHKvgkug7zCDpn+Nx+RS46TzCVE6bpdHV64LaTPK3oY22N4/Qp8NILgKn03OMQ/YAUaob1cbhywWUPkoPczomqtdRcsXnpJWlk6Rh1Wfd8DRUPqT6PAijUzdq4PVYnMTO/WT/uImv+n/Fg5lJMLhnpfXRp5dtgk7lvvRxg7Iwux+fPNkK9ClMAO9rPt27SJoaPtoyF4AGDI544i1enlcD7sLxii+9IeaWF2IO7vcWSIAoLGf7376i2pU0Zz3OB6+Vqy5u6YuVXQ0bvq1pVYqwee3y3DVU60MfB8ygSGj3b9W1rMFOB20/v6Hl8R0tplx6tXd0/adShpcLglY4dbRROGIWsoB5RxYiuBaksTxYjAly7itvc2QnP6XN4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F466CE04B5907F419FCD4E111E21F26C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de00094-b77b-4ff1-04c7-08d71a89e498
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:19:44.5665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.112
Subject: Re: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDguMjAxOSAxOTowOSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNi4wOC4xOSAxNzoyNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGhiaXRtYXBfcmVzZXQgaGFz
IGFuIHVub2J2aW91cyBwcm9wZXJ0eTogaXQgcm91bmRzIHJlcXVlc3RlZCByZWdpb24gdXAuDQo+
PiBJdCBtYXkgcHJvdm9rZSBidWdzLCBsaWtlIGluIHJlY2VudGx5IGZpeGVkIHdyaXRlLWJsb2Nr
aW5nIG1vZGUgb2YNCj4+IG1pcnJvcjogdXNlciBjYWxscyByZXNldCBvbiB1bmFsaWduZWQgcmVn
aW9uLCBub3Qga2VlcGluZyBpbiBtaW5kIHRoYXQNCj4+IHRoZXJlIGFyZSBwb3NzaWJsZSB1bnJl
bGF0ZWQgZGlydHkgYnl0ZXMsIGNvdmVyZWQgYnkgcm91bmRlZC11cCByZWdpb24NCj4+IGFuZCBp
bmZvcm1hdGlvbiBvZiB0aGlzIHVucmVsYXRlZCAiZGlydGluZXNzIiB3aWxsIGJlIGxvc3QuDQo+
Pg0KPj4gTWFrZSBoYml0bWFwX3Jlc2V0IHN0cmljdDogYXNzZXJ0IHRoYXQgYXJndW1lbnRzIGFy
ZSBhbGlnbmVkLCBhbGxvd2luZw0KPj4gb25seSBvbmUgZXhjZXB0aW9uIHdoZW4gQHN0YXJ0ICsg
QGNvdW50ID09IGhiLT5vcmlnX3NpemUuIEl0J3MgbmVlZGVkDQo+PiB0byBjb21mb3J0IHVzZXJz
IG9mIGhiaXRtYXBfbmV4dF9kaXJ0eV9hcmVhLCB3aGljaCBjYXJlcyBhYm91dA0KPj4gaGItPm9y
aWdfc2l6ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiB2MiBiYXNlZCBv
biBNYXgncyBodHRwczovL2dpdGh1Yi5jb20vWGFuQ2xpYy9xZW11LmdpdCBibG9jaw0KPj4gd2hp
Y2ggd2lsbCBiZSBtZXJnZWQgc29vbiB0byA0LjEsIGFuZCB0aGlzIHBhdGNoIGdvZXMgdG8gNC4y
DQo+PiBCYXNlZC1vbjogaHR0cHM6Ly9naXRodWIuY29tL1hhbkNsaWMvcWVtdS5naXQgYmxvY2sN
Cj4+DQo+PiB2MSB3YXMgIltQQVRDSF0gdXRpbC9oYml0bWFwOiBmaXggdW5hbGlnbmVkIHJlc2V0
IiwgYW5kIGFzIEkgdW5kZXJzdGFuZA0KPj4gd2UgYWxsIGFncmVlZCB0byBqdXN0IGFzc2VydCBh
bGlnbm1lbnQgaW5zdGVhZCBvZiBhbGlnbmluZyBkb3duDQo+PiBhdXRvbWF0aWNhbGx5Lg0KPj4N
Cj4+ICAgaW5jbHVkZS9xZW11L2hiaXRtYXAuaCB8IDUgKysrKysNCj4+ICAgdGVzdHMvdGVzdC1o
Yml0bWFwLmMgICB8IDIgKy0NCj4+ICAgdXRpbC9oYml0bWFwLmMgICAgICAgICB8IDQgKysrKw0K
Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2hiaXRtYXAuaCBiL2luY2x1ZGUvcWVtdS9o
Yml0bWFwLmgNCj4+IGluZGV4IDRhZmJlNjI5MmUuLjc4NjVlODE5Y2EgMTAwNjQ0DQo+PiAtLS0g
YS9pbmNsdWRlL3FlbXUvaGJpdG1hcC5oDQo+PiArKysgYi9pbmNsdWRlL3FlbXUvaGJpdG1hcC5o
DQo+PiBAQCAtMTMyLDYgKzEzMiwxMSBAQCB2b2lkIGhiaXRtYXBfc2V0KEhCaXRtYXAgKmhiLCB1
aW50NjRfdCBzdGFydCwgdWludDY0X3QgY291bnQpOw0KPj4gICAgKiBAY291bnQ6IE51bWJlciBv
ZiBiaXRzIHRvIHJlc2V0Lg0KPj4gICAgKg0KPj4gICAgKiBSZXNldCBhIGNvbnNlY3V0aXZlIHJh
bmdlIG9mIGJpdHMgaW4gYW4gSEJpdG1hcC4NCj4+ICsgKiBAc3RhcnQgYW5kIEBjb3VudCBtdXN0
IGJlIGFsaWduZWQgdG8gYml0bWFwIGdyYW51bGFyaXR5LiBUaGUgb25seSBleGNlcHRpb24NCj4+
ICsgKiBpcyByZXNldHRpbmcgdGhlIHRhaWwgb2YgdGhlIGJpdG1hcDogQGNvdW50IG1heSBiZSBl
cXVhbCB0byBAc3RhcnQgKw0KPj4gKyAqIGhiLT5vcmlnX3NpemUsDQo+IA0KPiBzL0BzdGFydCAr
IGhiLT5vcmlnX3NpemUvaGItPm9yaWdfc2l6ZSAtIEBzdGFydC8sIEkgdGhpbmsuDQoNCkhhLCBJ
IHdhbnRlZCB0byBzYXkgc3RhcnQgKyBjb3VudCBlcXVhbCB0byBvcmlnX3NpemUuIFlvdXJzIGlz
IE9LIHRvbyBvZiBjb3Vyc2UuDQoNCj4gDQo+PiAgICAgIGluIHRoaXMgY2FzZSBAY291bnQgbWF5
IGJlIG5vdCBhbGlnbmVkLiBAc3RhcnQgKyBAY291bnQNCj4gDQo+ICthcmUNCj4gDQo+IFdpdGgg
dGhvc2UgZml4ZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0
LmNvbT4NCg0KVGhhbmtzIQ0KDQo+IA0KPj4gKyAqIGFsbG93ZWQgdG8gYmUgZ3JlYXRlciB0aGFu
IGhiLT5vcmlnX3NpemUsIGJ1dCBvbmx5IGlmIEBzdGFydCA8IGhiLT5vcmlnX3NpemUNCj4+ICsg
KiBhbmQgQHN0YXJ0ICsgQGNvdW50ID0gQUxJR05fVVAoaGItPm9yaWdfc2l6ZSwgZ3JhbnVsYXJp
dHkpLg0KPj4gICAgKi8NCj4+ICAgdm9pZCBoYml0bWFwX3Jlc2V0KEhCaXRtYXAgKmhiLCB1aW50
NjRfdCBzdGFydCwgdWludDY0X3QgY291bnQpOw0KPj4gICANCj4+IGRpZmYgLS1naXQgYS90ZXN0
cy90ZXN0LWhiaXRtYXAuYyBiL3Rlc3RzL3Rlc3QtaGJpdG1hcC5jDQo+PiBpbmRleCA1OTJkODIx
OWRiLi4yYmU1NmQxNTk3IDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvdGVzdC1oYml0bWFwLmMNCj4+
ICsrKyBiL3Rlc3RzL3Rlc3QtaGJpdG1hcC5jDQo+PiBAQCAtNDIzLDcgKzQyMyw3IEBAIHN0YXRp
YyB2b2lkIHRlc3RfaGJpdG1hcF9ncmFudWxhcml0eShUZXN0SEJpdG1hcERhdGEgKmRhdGEsDQo+
PiAgICAgICBoYml0bWFwX3Rlc3RfY2hlY2soZGF0YSwgMCk7DQo+PiAgICAgICBoYml0bWFwX3Rl
c3Rfc2V0KGRhdGEsIDAsIDMpOw0KPj4gICAgICAgZ19hc3NlcnRfY21waW50KGhiaXRtYXBfY291
bnQoZGF0YS0+aGIpLCA9PSwgNCk7DQo+PiAtICAgIGhiaXRtYXBfdGVzdF9yZXNldChkYXRhLCAw
LCAxKTsNCj4+ICsgICAgaGJpdG1hcF90ZXN0X3Jlc2V0KGRhdGEsIDAsIDIpOw0KPj4gICAgICAg
Z19hc3NlcnRfY21waW50KGhiaXRtYXBfY291bnQoZGF0YS0+aGIpLCA9PSwgMik7DQo+PiAgIH0N
Cj4+ICAgDQo+PiBkaWZmIC0tZ2l0IGEvdXRpbC9oYml0bWFwLmMgYi91dGlsL2hiaXRtYXAuYw0K
Pj4gaW5kZXggYmNjMGFjZGM2YS4uNTg2OTIwY2I1MiAxMDA2NDQNCj4+IC0tLSBhL3V0aWwvaGJp
dG1hcC5jDQo+PiArKysgYi91dGlsL2hiaXRtYXAuYw0KPj4gQEAgLTQ3Niw2ICs0NzYsMTAgQEAg
dm9pZCBoYml0bWFwX3Jlc2V0KEhCaXRtYXAgKmhiLCB1aW50NjRfdCBzdGFydCwgdWludDY0X3Qg
Y291bnQpDQo+PiAgICAgICAvKiBDb21wdXRlIHJhbmdlIGluIHRoZSBsYXN0IGxheWVyLiAgKi8N
Cj4+ICAgICAgIHVpbnQ2NF90IGZpcnN0Ow0KPj4gICAgICAgdWludDY0X3QgbGFzdCA9IHN0YXJ0
ICsgY291bnQgLSAxOw0KPj4gKyAgICB1aW50NjRfdCBncmFuID0gMVVMTCA8PCBoYi0+Z3JhbnVs
YXJpdHk7DQo+PiArDQo+PiArICAgIGFzc2VydCghKHN0YXJ0ICYgKGdyYW4gLSAxKSkpOw0KPj4g
KyAgICBhc3NlcnQoIShjb3VudCAmIChncmFuIC0gMSkpIHx8IChzdGFydCArIGNvdW50ID09IGhi
LT5vcmlnX3NpemUpKTsNCj4+ICAgDQo+PiAgICAgICB0cmFjZV9oYml0bWFwX3Jlc2V0KGhiLCBz
dGFydCwgY291bnQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0ID4+IGhiLT5n
cmFudWxhcml0eSwgbGFzdCA+PiBoYi0+Z3JhbnVsYXJpdHkpOw0KPj4NCj4gDQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

