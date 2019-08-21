Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E4C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974FA22CF4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kdIHN26s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974FA22CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OPj-0000BY-Pl
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0OOZ-0007vl-CS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0OOY-0005NG-1g
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:03:15 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com
 ([40.107.7.90]:5722 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i0OOX-0005MM-QS; Wed, 21 Aug 2019 07:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu2PEUmCs12a8ev9GNUD4OIn4G+IgCl2xyrDum60GQ/atincOeeiPZdbmJgFx9Mf0mCmE00laNBVY+JvayF3GgzFKrKCV4PMDBhmCXYkLSPzQZ5FNkWW+BblV7l9Ru3CO+lIJV83zhziz1Wr0rJSi5tTbegyybK2JP9P6NOMWDwCe/6tJyGih/pd3+nE1ALSjVii9Ns02P/wnwvKSIRoO5buB4C4vIwyq16qYIo8yeSwlEKLBXZ7vUN1UxGObqI4TbZg61jvcLoDsDRKJfEBPXHRKA/NCCBfg5omZE5S75qz9V942CWRiZORFlg5H+Ewo06tZIb8QsQhVTBdgXXTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHcpdTjuxT3popfrRPG8b2sYDP/2P18+VPog449JG7M=;
 b=O85MEeCcz5L1glvfDUeUkIuqya20U1O00NCqk8FQx9iy/y8Kn0ag9/1Lge8OoXT48G1VHgk1FeijF5iKwvxscVzPrPbB8kpnLUcBrFZ6H5YAVOadrpaAv0CK1gpoLa4rK3z/nBd2cGeK0/bnmXJyjCXPohkctNcPpW+YYt2++YVpErfnZAi5zZhlgrIC8WxR+7hTRK+U92hue0+kjqhB7rM5xMXrgbcks3rD09iKCb52ZBRt+99EyLrCpQQXtmlHEPWS9SAes+X+7aZWa/U+m9AZFLDuFL02CpAJwrF2JGvC7Knw6yoBp8mang6mKcsR5HbTCxkxj6yfM1VGw3v1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHcpdTjuxT3popfrRPG8b2sYDP/2P18+VPog449JG7M=;
 b=kdIHN26sN3iEHklr9fE+KT2laTwEn1KTjkw2eNU9+vPIT8pEbQXdKW00nQQYGlXr9Qh6LNoGh9p9Jgceks2LZ0sgsuCMRN+uJjrGB4esq8tOCBOinuWqkjhX8xeeL67onhXObmCr1d3qkIb66+uTFn64lZDQxw8vcNDotfne/h0=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB3096.eurprd08.prod.outlook.com (52.135.162.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 11:03:11 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 11:03:11 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 5/9] scsi: store unmap offset and nb_sectors in
 request struct
Thread-Index: AQHVC/RUuKGH/mEdN0ahoebEve56fqb4Vx0AgA2xAoA=
Date: Wed, 21 Aug 2019 11:03:11 +0000
Message-ID: <7cb6f07c-a107-a166-9ae7-5972970efe0a@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-6-anton.nefedov@virtuozzo.com>
 <b0af8e55-81a9-d9c4-e65e-04a6cec802b6@redhat.com>
In-Reply-To: <b0af8e55-81a9-d9c4-e65e-04a6cec802b6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:7:28::36) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ac11697-20e3-4ab2-64e8-08d7262727ec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB3096; 
x-ms-traffictypediagnostic: AM6PR08MB3096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3096FF814878A9E70DEE1026F8AA0@AM6PR08MB3096.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39840400004)(189003)(199004)(316002)(446003)(81166006)(81156014)(44832011)(71200400001)(71190400001)(6512007)(2616005)(66066001)(476003)(11346002)(3846002)(54906003)(486006)(53936002)(2501003)(25786009)(8676002)(14444005)(256004)(6116002)(186003)(86362001)(31696002)(26005)(76176011)(66946007)(14454004)(107886003)(66556008)(66476007)(66446008)(478600001)(8936002)(6486002)(52116002)(6246003)(64756008)(102836004)(31686004)(7736002)(53546011)(99286004)(6436002)(5660300002)(386003)(6506007)(2906002)(4326008)(229853002)(305945005)(36756003)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3096;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q5IVIpQ/zsX2sQONyCMHHH1r5egXKvOz+SwlspQRnGz674DO1soR9msXV8KeDxEBGCR0PRpkrh5VEqY9v3YzR5IRJ9933nWhP15tx+mIOQIhoVKG9Fl2IvEdpEVcqvZRX+Ucufaddp9GEdBPOuMTDsoY4ql5F15NIR8rbboOm3AdDiTTW4642qNsgX0viMVFRwgAh5AgIw9hExTuFemirKXYuQPVGjND3S7TkzjOFnRwBWRMRf3Z+f/B+mN2APfYJrPXM4X3LDqt9tgMRKtWnHT4cvtQNatotUkYtoXpoZVt+d1rpqO+YGCdeYBWGSJ03GFpCV3ppMhBf3MWHfbb9sx1QnYGqG2AmGpWeWhrHNwLhL6kArb8tE9TpqKPgVKWnCXQcuKYJQCjROpwVf8kPUxkvX7dtKT//gOeMAOosO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5561518CDC964479E90CDBC543AC63C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac11697-20e3-4ab2-64e8-08d7262727ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:03:11.3147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQ6CeeKVqzzdQQk1EalziIivwpEZHw20296T8YFP872bi2WQaaBK1X97wMJ3tlsI6l7FBSYGPQpXG49BivaKCL7zLSWqIIM584VYVvdBQi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3096
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.90
Subject: Re: [Qemu-devel] [PATCH v8 5/9] scsi: store unmap offset and
 nb_sectors in request struct
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTIvOC8yMDE5IDg6NTggUE0sIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMTYuMDUuMTkgMTY6
MzMsIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+PiBpdCBhbGxvd3MgdG8gcmVwb3J0IGl0IGluIHRo
ZSBlcnJvciBoYW5kbGVyDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50
b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IFJldmlld2VkLWJ5
OiBBbGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4+IC0tLQ0KPj4gICBody9zY3Np
L3Njc2ktZGlzay5jIHwgMTIgKysrKystLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiAoU29ycnkgZm9yIHRoZSBsYXRlIHJl
cGx5IDotLykNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvaHcvc2NzaS9zY3NpLWRpc2suYyBiL2h3L3Nj
c2kvc2NzaS1kaXNrLmMNCj4+IGluZGV4IGU3ZTg2NWFiM2IuLmI0MzI1NDEwM2MgMTAwNjQ0DQo+
PiAtLS0gYS9ody9zY3NpL3Njc2ktZGlzay5jDQo+PiArKysgYi9ody9zY3NpL3Njc2ktZGlzay5j
DQo+PiBAQCAtMTYwMiw4ICsxNjAyLDYgQEAgc3RhdGljIHZvaWQgc2NzaV91bm1hcF9jb21wbGV0
ZV9ub2lvKFVubWFwQ0JEYXRhICpkYXRhLCBpbnQgcmV0KQ0KPj4gICB7DQo+PiAgICAgICBTQ1NJ
RGlza1JlcSAqciA9IGRhdGEtPnI7DQo+PiAgICAgICBTQ1NJRGlza1N0YXRlICpzID0gRE9fVVBD
QVNUKFNDU0lEaXNrU3RhdGUsIHFkZXYsIHItPnJlcS5kZXYpOw0KPj4gLSAgICB1aW50NjRfdCBz
ZWN0b3JfbnVtOw0KPj4gLSAgICB1aW50MzJfdCBuYl9zZWN0b3JzOw0KPj4gICANCj4+ICAgICAg
IGFzc2VydChyLT5yZXEuYWlvY2IgPT0gTlVMTCk7DQo+PiAgICAgICBpZiAoc2NzaV9kaXNrX3Jl
cV9jaGVja19lcnJvcihyLCByZXQsIGZhbHNlKSkgew0KPj4gQEAgLTE2MTEsMTYgKzE2MDksMTYg
QEAgc3RhdGljIHZvaWQgc2NzaV91bm1hcF9jb21wbGV0ZV9ub2lvKFVubWFwQ0JEYXRhICpkYXRh
LCBpbnQgcmV0KQ0KPj4gICAgICAgfQ0KPj4gICANCj4+ICAgICAgIGlmIChkYXRhLT5jb3VudCA+
IDApIHsNCj4+IC0gICAgICAgIHNlY3Rvcl9udW0gPSBsZHFfYmVfcCgmZGF0YS0+aW5idWZbMF0p
Ow0KPj4gLSAgICAgICAgbmJfc2VjdG9ycyA9IGxkbF9iZV9wKCZkYXRhLT5pbmJ1Zls4XSkgJiAw
eGZmZmZmZmZmVUxMOw0KPj4gLSAgICAgICAgaWYgKCFjaGVja19sYmFfcmFuZ2Uocywgc2VjdG9y
X251bSwgbmJfc2VjdG9ycykpIHsNCj4+ICsgICAgICAgIHItPnNlY3RvciA9IGxkcV9iZV9wKCZk
YXRhLT5pbmJ1ZlswXSk7DQo+PiArICAgICAgICByLT5zZWN0b3JfY291bnQgPSBsZGxfYmVfcCgm
ZGF0YS0+aW5idWZbOF0pICYgMHhmZmZmZmZmZlVMTDsNCj4+ICsgICAgICAgIGlmICghY2hlY2tf
bGJhX3JhbmdlKHMsIHItPnNlY3Rvciwgci0+c2VjdG9yX2NvdW50KSkgew0KPj4gICAgICAgICAg
ICAgICBzY3NpX2NoZWNrX2NvbmRpdGlvbihyLCBTRU5TRV9DT0RFKExCQV9PVVRfT0ZfUkFOR0Up
KTsNCj4+ICAgICAgICAgICAgICAgZ290byBkb25lOw0KPj4gICAgICAgICAgIH0NCj4+ICAgDQo+
PiAgICAgICAgICAgci0+cmVxLmFpb2NiID0gYmxrX2Fpb19wZGlzY2FyZChzLT5xZGV2LmNvbmYu
YmxrLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWN0b3Jf
bnVtICogcy0+cWRldi5ibG9ja3NpemUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5iX3NlY3RvcnMgKiBzLT5xZGV2LmJsb2Nrc2l6ZSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgci0+c2VjdG9yICogcy0+cWRldi5ibG9j
a3NpemUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHItPnNl
Y3Rvcl9jb3VudCAqIHMtPnFkZXYuYmxvY2tzaXplLA0KPiANCj4gVGhpcyBsb29rcyB0byBtZSBs
aWtlIHRoZXNlIGFyZSBub3QgbmVjZXNzYXJpbHkgaW4gdGVybXMgb2YgNTEyLWJ5dGUNCj4gc2Vj
dG9ycy4gIEl0IGRvZXNu4oCZdCBzZWVtIHRvIG1ha2UgYW55dGhpbmcgdGVjaG5pY2FsbHkgd3Jv
bmcsIGJlY2F1c2UNCj4gcGF0Y2ggNyB0YWtlcyB0aGF0IGludG8gYWNjb3VudC4NCj4gDQo+IEJ1
dCBpdOKAmXMgc3RpbGwgd2VpcmQgaWYgZXZlcnl0aGluZyBlbHNlIGluIHRoaXMgZmlsZSB0cmVh
dHMgdGhlc2UgZmllbGRzDQo+IGFzIGJlaW5nIGluIHRlcm1zIG9mIDUxMiBieXRlIHNlY3RvcnMg
KGFuZCB0aGV5IGFyZSBhY3R1YWxseSBkZWZpbmVkDQo+IHRoaXMgd2F5IGluIFNDU0lEaXNrUmVx
KS4NCj4gDQoNCk5pY2UgdGhhdCB5b3UgY2F1Z2h0IHRoaXMsIHRoYW5rcyEgSSBndWVzcyB2YXJp
YWJsZSBuYW1lcyBtaXNsZWQgbWUNCg==

