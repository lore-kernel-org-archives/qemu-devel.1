Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FD8C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE2A2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dHkpXSRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE2A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIr1t-0000PD-FP
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqwK-0002Y9-G1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqwJ-0005dK-21
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:10:24 -0400
Received: from mail-eopbgr10090.outbound.protection.outlook.com
 ([40.107.1.90]:12790 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqwI-0005cv-K7; Fri, 11 Oct 2019 05:10:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB3xQsQjy5tkvYnt2u3Tg1FOrqeHSMXzXhN1Fc40lzDa1PC2lW5SScI3RyHk9bT4NB8ppkoOBtf+hggZWYdMzkDt3YAnt24vyRUQ+NSADgkgOEgMEJz7AgyttK6xsQTPpxD488/k4Rh1ggMs9zZTWQKGFlHvaNMjfIwE01kLBTn/G3Bty6u7iu2cUbNzZYWjS4H44WpxTaxm7lal4s00WUUIAN2RuJni/Eb05uFtSESA8pssmZaxMfxqca8ZIVaUzKi8N5QmxfeTiYT0dXzpEI4usyV6bJ4VAhGR6cIATVK9WjzyDbj+ldFdR8ktn8vn0jgJVXSm2kJd1dwz0b/JtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTRwCWksHBLQJCkwEzY13RWBgJofyLp3d/wcIpPyzc0=;
 b=eZPqGZoo6ChCxocNxbkzg7aADymlW9djfOhJM5Th3ec2tTTpVakYUk903okbDHKtQjmogb8LLgvBhOI9833b+UnYL2CLwvluXLebOLDswlYnJ3wBtP+5launBsaRQM/oTlFSCmuFo3H+0KKepbMy4VclcO36zjqDF8xAVx0iy96x0sdNghHnGKEEhtEwgcNza6tzuW3W1GAOkEYGZFtf7ZStRRjKZxPjEdkTiw+1Q0V/NLVxEndX2iIfpvN54PKMrz2+hMZIxSCRfK4NKUMvkrNUfRinurOmwAAWzwDGXrw20kgF4Ti9qUdsn08oapKTMMBtUf8kCY4m+Djl+XPv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTRwCWksHBLQJCkwEzY13RWBgJofyLp3d/wcIpPyzc0=;
 b=dHkpXSRb9gEbgHMv5xca11qqvLmMtZvNcALwZJgPYSX4z1JXIl0V7h+oNPRvbMXCh0fOeeu4eV/3x91CFw0bJ7WzhKxiQ0BMN6UUhSddy9Hi+4fhZyUl62VY3Gp2m1wu54x/nRqScmj4i8x5hnYdu2XHYdCjKyrwQEqMGj654fc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4139.eurprd08.prod.outlook.com (20.179.11.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 09:10:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 09:10:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdKz3mAgAp6joCAAAccAIAAA0oA
Date: Fri, 11 Oct 2019 09:10:20 +0000
Message-ID: <974a64f9-9ac4-109b-d879-1d49cd8a21e2@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <6fd6a449-0443-ecfa-0eec-23e3b515b303@redhat.com>
 <eb11dfe2-fe3b-54bf-a23f-b9d208690680@virtuozzo.com>
 <0cc82b6a-9a1c-4f5b-f133-153ab739c0a3@redhat.com>
In-Reply-To: <0cc82b6a-9a1c-4f5b-f133-153ab739c0a3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191011121018429
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b874f08-279c-4ba6-7e0c-08d74e2ad724
x-ms-traffictypediagnostic: DB8PR08MB4139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4139205B6A33ED27DA90C0B1C1970@DB8PR08MB4139.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39830400003)(396003)(366004)(346002)(376002)(189003)(51444003)(199004)(52116002)(186003)(386003)(6506007)(53546011)(99286004)(66476007)(66556008)(64756008)(66446008)(66946007)(6512007)(26005)(102836004)(76176011)(31696002)(8676002)(36756003)(25786009)(71200400001)(14444005)(71190400001)(256004)(229853002)(316002)(6486002)(7736002)(305945005)(81166006)(6436002)(107886003)(6116002)(54906003)(8936002)(110136005)(31686004)(86362001)(5660300002)(81156014)(6246003)(66066001)(476003)(486006)(3846002)(2616005)(11346002)(2906002)(446003)(4326008)(14454004)(478600001)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4139;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: li/XB/DqAYUJlWXWrBEkMuiLxxZBJyjTeWdydOc2PQJdTukrVSQh4mRBVXUrnZVtgZ1apcC8w1hwgUwtuvnB+CtKQtVcYq7qLrsE1NoqgHJtmob6a28QJCmAxhLYEEYUSCAWjHM6puuJ9cTx1wXxpu1//LKEuijozZUgbzdQkiKMAaHu8+JP0/g9g4zp937jelmeIY0hX4sTjdoF0c2USRZ6T1VB4g/axf27fGJREP9jJeBsjvxvTkbZhWUg/fb3vapYrU/22F7zS1bUyzUxQKO9yGPh+yl1bvla4Xf00IzxHGlM+tK7Cp/VhKIY50YMLD4AzsEMVFQYm+VuNiyoLiw51rs1OrIo3y4d0WGiVNm3q8hTOsY3adUohJhPAgjdsSRDZelCjMOzfSeFzLrAX9NVxSr4TSzkCayEvi5S+P0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C39BB751B4E33D4982A1393438083541@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b874f08-279c-4ba6-7e0c-08d74e2ad724
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 09:10:20.3221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7ElKCuYAv73+Lzql8krWIl7z3jML7oSH0yzDhU363kkUJcDJH2EEHfbKe4iYFu2an+vIVegGZCqfnAH0JkXx3XPROsXbYwR0Buzy6J4L3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4139
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.90
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

MTEuMTAuMjAxOSAxMTo1OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMS4xMC4xOSAxMDozMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA0LjEwLjIwMTkgMTk6MzEs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMi4wOS4xOSAxNzoxMywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gUHJpb3IgOWFkYzFjYjQ5YWY4ZCBkb19zeW5jX3Rh
cmdldF93cml0ZSBoYWQgYSBidWc6IGl0IHJlc2V0IGFsaWduZWQtdXANCj4+Pj4gcmVnaW9uIGlu
IHRoZSBkaXJ0eSBiaXRtYXAsIHdoaWNoIG1lYW5zIHRoYXQgd2UgbWF5IG5vdCBjb3B5IHNvbWUg
Ynl0ZXMNCj4+Pj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFsbHkgbGVhZHMg
dG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4+PiB0YXJnZXQuDQo+Pj4+DQo+Pj4+IFNvIDlhZGMx
Y2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1hcCBncmFudWxhcml0eSB0byBiZQ0KPj4+PiByZXF1
ZXN0X2FsaWdubWVudCBmb3IgbWlycm9yLXRvcCBmaWx0ZXIsIHNvIHdlIGFyZSBub3Qgd29ya2lu
ZyB3aXRoDQo+Pj4+IHVuYWxpZ25lZCByZXF1ZXN0cy4gSG93ZXZlciBmb3JjaW5nIGxhcmdlIGFs
aWdubWVudCBvYnZpb3VzbHkgZGVjcmVhc2VzDQo+Pj4+IHBlcmZvcm1hbmNlIG9mIHVuYWxpZ25l
ZCByZXF1ZXN0cy4NCj4+Pj4NCj4+Pj4gVGhpcyBjb21taXQgcHJvdmlkZXMgYW5vdGhlciBzb2x1
dGlvbiBmb3IgdGhlIHByb2JsZW06IGlmIHVuYWxpZ25lZA0KPj4+PiBwYWRkaW5nIGlzIGFscmVh
ZHkgZGlydHksIHdlIGNhbiBzYWZlbHkgaWdub3JlIGl0LCBhcw0KPj4+PiAxLiBJdCdzIGRpcnR5
LCBpdCB3aWxsIGJlIGNvcGllZCBieSBtaXJyb3JfaXRlcmF0aW9uIGFueXdheQ0KPj4+PiAyLiBJ
dCdzIGRpcnR5LCBzbyBza2lwcGluZyBpdCBub3cgd2UgZG9uJ3QgaW5jcmVhc2UgZGlydGluZXNz
IG9mIHRoZQ0KPj4+PiAgICAgIGJpdG1hcCBhbmQgdGhlcmVmb3JlIGRvbid0IGRhbWFnZSAic3lu
Y2hyb25pY2l0eSIgb2YgdGhlDQo+Pj4+ICAgICAgd3JpdGUtYmxvY2tpbmcgbWlycm9yLg0KPj4+
Pg0KPj4+PiBJZiB1bmFsaWduZWQgcGFkZGluZyBpcyBub3QgZGlydHksIHdlIGp1c3Qgd3JpdGUg
aXQsIG5vIHJlYXNvbiB0byB0b3VjaA0KPj4+PiBkaXJ0eSBiaXRtYXAgaWYgd2Ugc3VjY2VlZCAo
b24gZmFpbHVyZSB3ZSdsbCBzZXQgdGhlIHdob2xlIHJlZ2lvbg0KPj4+PiBvZmNvdXJzZSwgYnV0
IHdlIGxvc3MgInN5bmNocm9uaWNpdHkiIG9uIGZhaWx1cmUgYW55d2F5KS4NCj4+Pj4NCj4+Pj4g
Tm90ZTogd2UgbmVlZCB0byBkaXNhYmxlIGRpcnR5X2JpdG1hcCwgb3RoZXJ3aXNlIHdlIHdpbGwg
bm90IGJlIGFibGUgdG8NCj4+Pj4gc2VlIGluIGRvX3N5bmNfdGFyZ2V0X3dyaXRlIGJpdG1hcCBz
dGF0ZSBiZWZvcmUgY3VycmVudCBvcGVyYXRpb24uIFdlDQo+Pj4+IG1heSBvZiBjb3Vyc2UgY2hl
Y2sgZGlydHkgYml0bWFwIGJlZm9yZSB0aGUgb3BlcmF0aW9uIGluDQo+Pj4+IGJkcnZfbWlycm9y
X3RvcF9kb193cml0ZSBhbmQgcmVtZW1iZXIgaXQsIGJ1dCB3ZSBkb24ndCBuZWVkIGFjdGl2ZQ0K
Pj4+PiBkaXJ0eSBiaXRtYXAgZm9yIHdyaXRlLWJsb2NraW5nIG1pcnJvciBhbnl3YXkuDQo+Pj4+
DQo+Pj4+IE5ldyBjb2RlLXBhdGggaXMgdW51c2VkIHVudGlsIHRoZSBmb2xsb3dpbmcgY29tbWl0
IHJldmVydHMNCj4+Pj4gOWFkYzFjYjQ5YWY4ZC4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBE
ZW5pcyBWLiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+ICAgIGJsb2NrL21pcnJvci5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9taXJyb3IuYyBi
L2Jsb2NrL21pcnJvci5jDQo+Pj4+IGluZGV4IGQxNzZiZjU5MjAuLmQxOTJmNmE5NmIgMTAwNjQ0
DQo+Pj4+IC0tLSBhL2Jsb2NrL21pcnJvci5jDQo+Pj4+ICsrKyBiL2Jsb2NrL21pcnJvci5jDQo+
Pj4+IEBAIC0xMjA0LDYgKzEyMDQsMzkgQEAgZG9fc3luY190YXJnZXRfd3JpdGUoTWlycm9yQmxv
Y2tKb2IgKmpvYiwgTWlycm9yTWV0aG9kIG1ldGhvZCwNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgUUVNVUlPVmVjdG9yICpxaW92LCBpbnQgZmxhZ3MpDQo+Pj4+ICAgIHsNCj4+Pj4gICAg
ICAgIGludCByZXQ7DQo+Pj4+ICsgICAgc2l6ZV90IHFpb3Zfb2Zmc2V0ID0gMDsNCj4+Pj4gKw0K
Pj4+PiArICAgIGlmICghUUVNVV9JU19BTElHTkVEKG9mZnNldCwgam9iLT5ncmFudWxhcml0eSkg
JiYNCj4+Pj4gKyAgICAgICAgYmRydl9kaXJ0eV9iaXRtYXBfZ2V0KGpvYi0+ZGlydHlfYml0bWFw
LCBvZmZzZXQpKSB7DQo+Pj4+ICsgICAgICAgICAgICAvKg0KPj4+PiArICAgICAgICAgICAgICog
RGlydHkgdW5hbGlnbmVkIHBhZGRpbmcNCj4+Pj4gKyAgICAgICAgICAgICAqIDEuIEl0J3MgYWxy
ZWFkeSBkaXJ0eSwgbm8gZGFtYWdlIHRvICJhY3RpdmVseV9zeW5jZWQiIGlmIHdlIGp1c3QNCj4+
Pj4gKyAgICAgICAgICAgICAqICAgIHNraXAgdW5hbGlnbmVkIHBhcnQuDQo+Pj4+ICsgICAgICAg
ICAgICAgKiAyLiBJZiB3ZSBjb3B5IGl0LCB3ZSBjYW4ndCByZXNldCBjb3JyZXNwb25kaW5nIGJp
dCBpbg0KPj4+PiArICAgICAgICAgICAgICogICAgZGlydHlfYml0bWFwIGFzIHRoZXJlIG1heSBi
ZSBzb21lICJkaXJ0eSIgYnl0ZXMgc3RpbGwgbm90DQo+Pj4+ICsgICAgICAgICAgICAgKiAgICBj
b3BpZWQuDQo+Pj4+ICsgICAgICAgICAgICAgKiBTbywganVzdCBpZ25vcmUgaXQuDQo+Pj4+ICsg
ICAgICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgICAgIHFpb3Zfb2Zmc2V0ID0gUUVNVV9BTElH
Tl9VUChvZmZzZXQsIGpvYi0+Z3JhbnVsYXJpdHkpIC0gb2Zmc2V0Ow0KPj4+PiArICAgICAgICAg
ICAgaWYgKGJ5dGVzIDw9IHFpb3Zfb2Zmc2V0KSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgLyog
bm90aGluZyB0byBkbyBhZnRlciBzaHJpbmsgKi8NCj4+Pj4gKyAgICAgICAgICAgICAgICByZXR1
cm47DQo+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+ICsgICAgICAgICAgICBvZmZzZXQgKz0gcWlv
dl9vZmZzZXQ7DQo+Pj4+ICsgICAgICAgICAgICBieXRlcyAtPSBxaW92X29mZnNldDsNCj4+Pj4g
KyAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIVFFTVVfSVNfQUxJR05FRChvZmZzZXQgKyBi
eXRlcywgam9iLT5ncmFudWxhcml0eSkgJiYNCj4+Pj4gKyAgICAgICAgYmRydl9kaXJ0eV9iaXRt
YXBfZ2V0KGpvYi0+ZGlydHlfYml0bWFwLCBvZmZzZXQgKyBieXRlcyAtIDEpKQ0KPj4+PiArICAg
IHsNCj4+Pj4gKyAgICAgICAgdWludDY0X3QgdGFpbCA9IChvZmZzZXQgKyBieXRlcykgJSBqb2It
PmdyYW51bGFyaXR5Ow0KPj4+PiArDQo+Pj4+ICsgICAgICAgIGlmIChieXRlcyA8PSB0YWlsKSB7
DQo+Pj4+ICsgICAgICAgICAgICAvKiBub3RoaW5nIHRvIGRvIGFmdGVyIHNocmluayAqLw0KPj4+
PiArICAgICAgICAgICAgcmV0dXJuOw0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgICAgIGJ5
dGVzIC09IHRhaWw7DQo+Pj4+ICsgICAgfQ0KPj4+PiAgICANCj4+Pj4gICAgICAgIGJkcnZfcmVz
ZXRfZGlydHlfYml0bWFwKGpvYi0+ZGlydHlfYml0bWFwLCBvZmZzZXQsIGJ5dGVzKTsNCj4+Pj4g
ICAgDQo+Pj4NCj4+PiBUaGUgYmRydl9zZXRfZGlydHlfYml0bWFwKCkgaW4gdGhlIGVycm9yIGNh
c2UgYmVsb3cgbmVlZHMgdG8gdXNlIHRoZQ0KPj4+IG9yaWdpbmFsIG9mZnNldC9ieXRlcywgSSBz
dXBwb3NlLg0KPj4NCj4+IE5vLCBiZWNhdXNlIHdlIHNocmluayB0YWlsIG9ubHkgaWYgaXQgaXMg
YWxyZWFkeSBkaXJ0eS4gQW5kIHdlJ3ZlIGxvY2tlZCB0aGUNCj4+IHJlZ2lvbiBmb3IgaW4tZmxp
Z2h0IG9wZXJhdGlvbiwgc28gbm9ib2R5IGNhbiBjbGVhciB0aGUgYml0bWFwIGluIGEgbWVhbnRp
bWUuDQo+IA0KPiBUcnVlLiAgQnV0IHdvdWxkbuKAmXQgaXQgYmUgc2ltcGxlciB0byB1bmRlcnN0
YW5kIHRvIGp1c3QgdXNlIHRoZSBvcmlnaW5hbA0KPiBvZmZzZXRzPw0KDQp0aGVuIHdlIG5lZWQg
dG8gc3RvcmUgdGhlbS4uIEFuZCBpZiB3ZSBkbyBpdCwgSSdkIHByZWZlciB0byBhZGQgYW4gYXNz
ZXJ0aW9uIHRoYXQNCnNocnVuayB0YWlscyBhcmUgc3RpbGwgZGlydHkgaW5zdGVhZC4NCg0KPiAN
Cj4+IEJ1dCBzdGlsbCwgaGVyZSBpcyBzb21ldGhpbmcgdG8gZG86DQo+Pg0KPj4gZm9yIG5vdC1z
aHJpbmtlZCB0YWlscywgaWYgYW55LCB3ZSBzaG91bGQ6DQo+PiAxLiBhbGlnbiBkb3duIGZvciBy
ZXNldA0KPj4gMi4gYWxpZ24gdXAgZm9yIHNldCBvbiBmYWlsdXJlDQo+IA0KPiBXZWxsLCB0aGUg
YWxpZ24gdXAgaXMgZG9uZSBhdXRvbWF0aWNhbGx5LCBhbmQgSSB0aGluayB0aGF04oCZcyBwcmV0
dHkNCj4gc2VsZi1leHBsYW5hdG9yeS4NCj4gDQo+IE1heA0KPiANCj4+Pg0KPj4+IEFwYXJ0IGZy
b20gdGhhdCwgbG9va3MgZ29vZCB0byBtZS4NCj4+Pg0KPj4+IE1heA0KPj4+DQo+Pg0KPj4NCj4g
DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

