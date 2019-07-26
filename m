Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01425C41514
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89C622CE9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VJARXtVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89C622CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0X8-0005kn-ML
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hr0Wt-0005Kc-Vs
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hr0Ws-00009D-I5
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:45:03 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:49902 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hr0Wr-00004y-KD; Fri, 26 Jul 2019 09:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NELnMt2/iVocOFvv0JBJ2yAF5t5vFiCNZRK9KRTAzU+Iu7nTD/4cDjRG6xRiC5ZsJ1ddUi4IwPsNRylD6XYrAOmO+n9pnjeFkxjrt1kPyXM6OtCiDzgc78qeDazSefP5mHv+Tg68SqJU0DAlA4VJ4Eovnw2td6og9KDOtn3ddvhJALxszv/wixhlqQLR64IwLY8zKAq4PvSSjLo4fCBEVLaHou/oDifl1IBpPKLG+wr3bqSdh2DCbGc1klWqd1MMwXpYXbody7aKqweL2r33aHINYFsLdcFMnMQrXUHrhbdS9ovMFprOt9UFiJ/pLNtZnoFve/H3B2SwD8hrR4B3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX8z6dKyDNMMkQnOiaSJlmUEwhUgGf1laYybQjwtBlc=;
 b=hMF+Rk7WlrkNRT7YVkmK4ooqulZqyxaWjgT2eI3Vk3qRb4k2af4+y1atJkMDlbMTNxJ1WY6xt7fWsRizn+6k0RpQ4PeR6uLT8DKFgDdkMhJWgCaiZ3qgF9REJPqmGvjzVbY3VQ0HTo8bB75cYtVMdgcXvUZ/IV2iu/L8GWB5EJIcpeh/NBPXsRZ6MIoXsXXaZh0+VQ8QWN40pgkKjMxW0ntmz/gQ2H6mBVzLSoyjbea7RYY9A5O+jrydiBv3MkqZVlvyQ2qG6zAMaWGn6gS4nzoHqpMv7WDb14KHiNvm9hQ8R53zBDsN76NdT9CdWTgrKrV9mE19qSYbvXzfkP4cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX8z6dKyDNMMkQnOiaSJlmUEwhUgGf1laYybQjwtBlc=;
 b=VJARXtVk7bpL/M+yCNeJZ+el0yiA2iyzl/V5kawC4kVmlM4YmT/mZWgEyDFlcHtK91IKULprQq+rGTBrXRLq9B71SPw1BUET+YBjcvNsr0B1URFWpsRTCgb+2F+oIEgzACFLk4KV0c8I8oB9ZT7AeLyqGj2FmO8eddPMIRBXQlM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5194.eurprd08.prod.outlook.com (10.255.18.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Fri, 26 Jul 2019 13:44:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 13:44:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 30/42] qemu-img: Use child access functions
Thread-Index: AQHVIWvHnxVNzSHLQUiliZZrFDtDOaaivO6AgABtcACAAvl3AIAzpNwAgAICDACAAWMGgA==
Date: Fri, 26 Jul 2019 13:44:56 +0000
Message-ID: <8a622f21-ecba-6663-52c1-028462b9890a@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
 <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
 <d086a736-6a4d-754d-74a4-f244a577d848@virtuozzo.com>
 <650837b5-1fb8-3995-348c-77ab55020585@virtuozzo.com>
 <6ab14c4a-5460-12f4-da65-ef55511a2e44@redhat.com>
In-Reply-To: <6ab14c4a-5460-12f4-da65-ef55511a2e44@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::42)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190726164453931
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53ef9efd-0379-4402-267f-08d711cf71bb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5194; 
x-ms-traffictypediagnostic: DB8PR08MB5194:
x-microsoft-antispam-prvs: <DB8PR08MB519461C38E20241D4E2F70D6C1C00@DB8PR08MB5194.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(39850400004)(346002)(396003)(199004)(189003)(99286004)(71190400001)(71200400001)(68736007)(7736002)(6512007)(316002)(8936002)(8676002)(81156014)(81166006)(54906003)(110136005)(305945005)(486006)(476003)(14444005)(256004)(2616005)(446003)(11346002)(4326008)(66066001)(31686004)(53936002)(26005)(36756003)(25786009)(6246003)(186003)(2501003)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(86362001)(3846002)(6116002)(6436002)(229853002)(478600001)(6486002)(52116002)(14454004)(102836004)(386003)(6506007)(53546011)(76176011)(2906002)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5194;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ax+Gr2aks2ho4Hl0Q2kat6l+cfI6LR60OopcgWoF8VjOdvvNzj20nsGA8ed7Ck1snF8J72YwjKFgnz8f8gxldEzYpOhKPndxAHG3XKOqEKFszt4mapQMPOOBfiZ0+UCzGtYyTAsE0Yu8SxMK/28Rv0dSGK5sutGsHlyTjRk5oLMmSsmmbmcp2vS3NKv9icJPfLUzAwRAIb3M9lNLViyi/GAgc9/3p5QNjwvR5RuhQrJNgm932sHP1DzZIyKEj4K/HhnOVpeckw6b5/HGc86gJ1hftAim8BrNuyH2QPUJFFB0a1W3q+xa4n+9uVudNsf3Y6DV4lvL+M41PNgd89KFjkJ+zuFaQsqbE6jiUU0NCmIKOGCc9cbelt1SHhfkRDuxzrmVuLGdqCUKX8MQPUZ2ROkjOAq3VYgwS2sE6bkjTiM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AF4B2AB177FC24DABB025A883A10B0C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ef9efd-0379-4402-267f-08d711cf71bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 13:44:56.1589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5194
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
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

MjUuMDcuMjAxOSAxOTozNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNC4wNy4xOSAxMTo1NCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIxLjA2LjIwMTkgMTY6MTUs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTkuMDYuMjAxOSAxODo0
OSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxOS4wNi4xOSAxMToxOCwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IDEzLjA2LjIwMTkgMTowOSwgTWF4IFJlaXR6
IHdyb3RlOg0KPj4+Pj4+IFRoaXMgY2hhbmdlcyBpb3Rlc3QgMjA0J3Mgb3V0cHV0LCBiZWNhdXNl
IGJsa2RlYnVnIG9uIHRvcCBvZiBhIENPVyBub2RlDQo+Pj4+Pj4gdXNlZCB0byBtYWtlIHFlbXUt
aW1nIG1hcCBkaXNyZWdhcmQgdGhlIHJlc3Qgb2YgdGhlIGJhY2tpbmcgY2hhaW4gKHRoZQ0KPj4+
Pj4+IGJhY2tpbmcgY2hhaW4gd2FzIGJyb2tlbiBieSB0aGUgZmlsdGVyKS7CoCBXaXRoIHRoaXMg
cGF0Y2gsIHRoZQ0KPj4+Pj4+IGFsbG9jYXRpb24gaW4gdGhlIGJhc2UgaW1hZ2UgaXMgcmVwb3J0
ZWQgY29ycmVjdGx5Lg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxt
cmVpdHpAcmVkaGF0LmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgwqDCoCBxZW11LWltZy5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzNiArKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0NCj4+Pj4+PiAgwqDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjA0Lm91dCB8
wqAgMSArDQo+Pj4+Pj4gIMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAx
NiBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9xZW11LWltZy5jIGIv
cWVtdS1pbWcuYw0KPj4+Pj4+IGluZGV4IDA3YjZlMmE4MDguLjdiZmE2ZTVkNDAgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvcWVtdS1pbWcuYw0KPj4+Pj4+ICsrKyBiL3FlbXUtaW1nLmMNCj4+Pj4+PiBA
QCAtOTkyLDcgKzk5Miw3IEBAIHN0YXRpYyBpbnQgaW1nX2NvbW1pdChpbnQgYXJnYywgY2hhciAq
KmFyZ3YpDQo+Pj4+Pj4gIMKgwqDCoMKgwqDCoCBpZiAoIWJsaykgew0KPj4+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMTsNCj4+Pj4+PiAgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+PiAt
wqDCoMKgIGJzID0gYmxrX2JzKGJsayk7DQo+Pj4+Pj4gK8KgwqDCoCBicyA9IGJkcnZfc2tpcF9p
bXBsaWNpdF9maWx0ZXJzKGJsa19icyhibGspKTsNCj4+Pj4+DQo+Pj4+PiBpZiBmaWxlbmFtZSBp
cyBqc29uLCBkZXNjcmliaW5nIGV4cGxpY2l0IGZpbHRlciBvdmVyIG5vcm1hbCBub2RlLCBicyB3
aWxsIGJlDQo+Pj4+PiBleHBsaWNpdCBmaWx0ZXIgLi4uDQo+Pj4+Pg0KPj4+Pj4+ICDCoMKgwqDC
oMKgwqAgcWVtdV9wcm9ncmVzc19pbml0KHByb2dyZXNzLCAxLmYpOw0KPj4+Pj4+ICDCoMKgwqDC
oMKgwqAgcWVtdV9wcm9ncmVzc19wcmludCgwLmYsIDEwMCk7DQo+Pj4+Pj4gQEAgLTEwMDksNyAr
MTAwOSw3IEBAIHN0YXRpYyBpbnQgaW1nX2NvbW1pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFRoaXMgaXMgZGlmZmVyZW50IGZyb20gUU1Q
LCB3aGljaCBieSBkZWZhdWx0IHVzZXMgdGhlIGRlZXBlc3QgZmlsZSBpbg0KPj4+Pj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogdGhlIGJhY2tpbmcgY2hhaW4gKGkuZS4sIHRoZSB2ZXJ5IGJh
c2UpOyBob3dldmVyLCB0aGUgdHJhZGl0aW9uYWwNCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIGJlaGF2aW9yIG9mIHFlbXUtaW1nIGNvbW1pdCBpcyB1c2luZyB0aGUgaW1tZWRpYXRl
IGJhY2tpbmcgZmlsZS4gKi8NCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgYmFzZV9icyA9IGJhY2tp
bmdfYnMoYnMpOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBiYXNlX2JzID0gYmRydl9maWx0ZXJl
ZF9jb3dfYnMoYnMpOw0KPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWJhc2VfYnMp
IHsNCj4+Pj4+DQo+Pj4+PiBhbmQgaGVyZSB3ZSdsbCBmYWlsLg0KPj4+Pg0KPj4+PiBSaWdodCwg
d2lsbCBjaGFuZ2UgdG8gYmRydl9iYWNraW5nX2NoYWluX25leHQoKS4NCj4+Pj4NCj4+Pj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKCZsb2NhbF9lcnIsICJJbWFn
ZSBkb2VzIG5vdCBoYXZlIGEgYmFja2luZyBmaWxlIik7DQo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBkb25lOw0KPj4+Pj4+IEBAIC0xNjI2LDE5ICsxNjI2LDE4IEBA
IHN0YXRpYyBpbnQgY29udmVydF9pdGVyYXRpb25fc2VjdG9ycyhJbWdDb252ZXJ0U3RhdGUgKnMs
IGludDY0X3Qgc2VjdG9yX251bSkNCj4+Pj4+PiAgwqDCoMKgwqDCoMKgIGlmIChzLT5zZWN0b3Jf
bmV4dF9zdGF0dXMgPD0gc2VjdG9yX251bSkgew0KPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbnQ2NF90IGNvdW50ID0gbiAqIEJEUlZfU0VDVE9SX1NJWkU7DQo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIEJsb2NrRHJpdmVyU3RhdGUgKnNyY19icyA9IGJsa19icyhzLT5zcmNbc3JjX2N1cl0p
Ow0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBCbG9ja0RyaXZlclN0YXRlICpiYXNlOw0KPj4+Pj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocy0+dGFyZ2V0X2hhc19iYWNraW5nKSB7DQo+Pj4+
Pj4gLQ0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGJkcnZfYmxvY2tfc3Rh
dHVzKGJsa19icyhzLT5zcmNbc3JjX2N1cl0pLA0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChzZWN0
b3JfbnVtIC0gc3JjX2N1cl9vZmZzZXQpICoNCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCRFJWX1NF
Q1RPUl9TSVpFLA0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50LCAmY291bnQsIE5VTEwsIE5V
TEwpOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJhc2UgPSBiZHJ2X2JhY2tpbmdf
Y2hhaW5fbmV4dChzcmNfYnMpOw0KPj4+Pj4NCj4+Pj4+IEFzIHlvdSBkZXNjcmliZWQgaW4gYW5v
dGhlciBwYXRjaCwgd2lsbCBub3Qgd2UgaGVyZSBnZXQgYWxsb2NhdGVkIGluIGJhc2UgYXMgYWxs
b2NhdGVkLCBiZWNhdXNlIG9mDQo+Pj4+PiBjb3VudGluZyBmaWx0ZXJzIGFib3ZlIGJhc2U/DQo+
Pj4+DQo+Pj4+IERhbW4sIHllcy7CoCBTbw0KPj4+Pg0KPj4+PiAgwqDCoMKgwqAgYmFzZSA9IGJk
cnZfZmlsdGVyZWRfY293X2JzKGJkcnZfc2tpcF9yd19maWx0ZXJzKHNyY19icykpOw0KPj4+Pg0K
Pj4+PiBJIHN1cHBvc2UuDQo+Pj4+DQo+Pj4+PiBIbW0uIEkgbm93IHRoaW5rLCB3aHkgZmlsdGVy
cyBkb24ndCByZXBvcnQgZXZlcnl0aGluZyBhcyB1bmFsbG9jYXRlZCwgd291bGQgbm90IGl0IGJl
IG1vcmUgY29ycmVjdA0KPj4+Pj4gdGhhbiBmYWxsdGhyb3VnaCB0byBjaGlsZD8NCj4+Pj4NCj4+
Pj4gSSBkb27igJl0IGtub3csIGFjdHVhbGx5LsKgIE1heWJlLCBtYXliZSBub3QuDQo+Pj4+DQo+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+Pj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0ID0gYmRydl9ibG9ja19zdGF0dXNfYWJvdmUoYmxrX2JzKHMtPnNyY1tz
cmNfY3VyXSksIE5VTEwsDQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNlY3Rv
cl9udW0gLSBzcmNfY3VyX29mZnNldCkgKg0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEJEUlZfU0VDVE9SX1NJWkUsDQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y291bnQsICZjb3VudCwgTlVMTCwgTlVMTCk7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYmFzZSA9IE5VTEw7DQo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0ID0gYmRydl9ibG9ja19zdGF0dXNfYWJvdmUoc3JjX2JzLCBiYXNl
LA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc2VjdG9yX251bSAtIHNyY19jdXJfb2Zmc2V0
KSAqDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJEUlZfU0VDVE9SX1NJWkUsDQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50LCAmY291bnQsIE5VTEwsIE5VTEwpOw0KPj4+Pj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4+Pj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgiZXJyb3Igd2hpbGUgcmVhZGluZyBibG9jayBz
dGF0dXMgb2Ygc2VjdG9yICUiIFBSSWQ2NA0KPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIjogJXMiLCBzZWN0b3JfbnVtLCBzdHJl
cnJvcigtcmV0KSk7DQo+Pj4+DQo+Pj4+IFsuLi5dDQo+Pj4+DQo+Pj4+Pj4gQEAgLTI5NDksNyAr
Mjk1MCw3IEBAIHN0YXRpYyBpbnQgaW1nX21hcChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+Pj4+
Pj4gIMKgwqDCoMKgwqDCoCBpZiAoIWJsaykgew0KPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gMTsNCj4+Pj4+PiAgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+PiAtwqDCoMKgIGJzID0g
YmxrX2JzKGJsayk7DQo+Pj4+Pj4gK8KgwqDCoCBicyA9IGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0
ZXJzKGJsa19icyhibGspKTsNCj4+Pj4+DQo+Pj4+PiBIbW0sIGFub3RoZXIgdGhvdWdodCBhYm91
dCBpbXBsaWNpdCBmaWx0ZXJzLCBob3cgdGhleSBjb3VsZCBiZSBoZXJlIGluIHFlbXUtaW1nPw0K
Pj4+Pg0KPj4+PiBIbSwgSSBkb27igJl0IHRoaW5rIHRoZXkgY2FuLg0KPj4+Pg0KPj4+Pj4gSWYg
aW1wbGljaXQgYXJlIG9ubHkNCj4+Pj4+IGpvYiBmaWx0ZXJzLiBEbyB5b3UgcHJlcGFyZWQgaXQg
Zm9yIGltcGxpY2l0IENPUj8gQnV0IHdlIGRpc2N1c3NlZCB3aXRoIEtldmluIHRoYXQgd2UnZCBi
ZXR0ZXIgZGVwcmVjYXRlDQo+Pj4+PiBjb3B5LW9uLXJlYWQgb3B0aW9uLi4NCj4+Pj4+DQo+Pj4+
PiBTbywgaWYgaW1wbGljaXQgZmlsdGVycyBhcmUgZm9yIGNvbXBhdGliaWxpdHksIHdlJ2xsIGhh
dmUgdGhlbSBvbmx5IGluIGJsb2NrLWpvYnMuIFNvLCBzZWVtcyBubyByZWFzb24gdG8gc3VwcG9y
dA0KPj4+Pj4gdGhlbSBpbiBxZW11LWltZy4NCj4+Pj4NCj4+Pj4gU2VlbXMgcmVhc29uYWJsZSwg
eWVzLg0KPj4+Pg0KPj4+Pj4gQWxzbywgaW4gYmxvY2stam9icywgd2UgY2FuIGFiYW5kb24gY3Jl
YXRpbmcgaW1wbGljaXQgZmlsdGVycyBhYm92ZSBhbnkgZmlsdGVyIG5vZGVzLCBhcyB3ZWxsIGFz
IGFiYW5kb24gY3JlYXRpbmcgYW55DQo+Pj4+PiBmaWx0ZXIgbm9kZXMgYWJvdmUgaW1wbGljaXQg
ZmlsdGVycy4gVGhpcyB3aWxsIHN0aWxsIHN1cHBvcnQgb2xkIHNjZW5hcmlvcywgYnV0IGdpdmVz
IHZlcnkgc2ltcGxlIGFuZCB3ZWxsIGRlZmluZWQgc2NvcGUNCj4+Pj4+IG9mIHVzaW5nIGltcGxp
Y2l0IGZpbHRlcnMgYW5kIGhvdyB0byB3b3JrIHdpdGggdGhlbS4gV2hhdCBkbyB5b3UgdGhpbms/
DQo+Pj4+DQo+Pj4+IEhtLCBpbiB3aGF0IHdheSB3b3VsZCB0aGF0IG1ha2UgdGhpbmdzIHNpbXBs
ZXI/DQo+Pj4+DQo+Pj4NCj4+PiBUaGlzIHF1ZXN0aW9uIHdhcyBpbiBteSBtaW5kIHdoaWxlIEkn
dmUgZmluaXNoaW5nIHRoaXMgcGFyYWdyYXBoKSBBdCBsZWFzdCBzdWNoIHJlc3RyaWN0aW9uIGFu
c3dlciB0aGUgcXVlc3Rpb24sIHdoZXJlDQo+Pj4gc2hvdWxkIG5ldyBmaWx0ZXJzIGJlIGFkZGVk
OiBiZWxvdyBvciB1bmRlciBpbXBsaWNpdCBmaWx0ZXJzLi4gV2l0aCBzdWNoIHJlc3RyaWN0aW9u
IHdlIGFsd2F5cyBjYW4gaGF2ZSBvbmx5IG9uZSBpbXBsaWNpdCBmaWx0ZXINCj4+PiBvdmVyIG5v
bi1maWx0ZXIgbm9kZSwgYW5kIGFib3ZlIGl0IHNob3VsZCBiZSBleHBsaWNpdCBmaWx0ZXIgb3Ig
bm9uLWZpbHRlciBub2RlLiBCdXQgdGhpcyBuZWVkIGh1Z2Ugd29yayB0byBiZSBkb25lIHdpdGgg
c21hbGwNCj4+PiBiZW5lZml0LCBzbywgZm9yZ2V0IGl0KQ0KPiANCj4gT0suICBJIHNob3VsZCBo
YXZlIHJlYWQgdGhlIGxhc3QgcGFydCBmaXJzdCwgdGhlbiBJIGNvdWxkIGhhdmUgcmVwbGllZA0K
PiBzb29uZXIuIDotKQ0KPiANCj4+IFN0cmFuZ2UsIEkgaGF2ZSB0aGlzIG1haWwgYXV0b21hdGlj
YWxseSByZXR1cm5lZCBiYWNrLiBEaWQgeW91IHJlY2VpdmUgaXQ/DQo+IA0KPiBObywgSSBkaWRu
4oCZdC4gIChOb3IgYW55IG9mIHRoZSBvdGhlciBtYWlscyB5b3UgcmVzZW50LikgIFdlaXJkLg0K
DQpJbnRlcmVzdGluZyB0aGF0IGl0IHJlYWNoZWQgbWFpbGluZyBsaXN0IGFuZCBwcmVzZW50cyBp
biBhcmNoaXZlLg0KDQo+IA0KPiBBbHNvLCB3ZWxjb21lIGJhY2ssIGNvbmdyYXR1bGF0aW9ucywg
YW5kIGFsbCB0aGUgYmVzdCB0byB5b3VyIGZhbWlseSEgOi0pDQo+IA0KDQoNClRoYW5rIHlvdSEN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

