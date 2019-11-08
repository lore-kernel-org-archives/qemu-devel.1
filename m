Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36986C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 07:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40242087E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 07:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="etJrMV/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40242087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSyOk-0001ES-Vs
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 02:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iSyO3-0000lC-8I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iSyO2-0004NY-4o
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:08:51 -0500
Received: from mail-eopbgr70135.outbound.protection.outlook.com
 ([40.107.7.135]:64302 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iSyNy-0004M8-JB; Fri, 08 Nov 2019 02:08:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlpKE2uSpElxY7+9hHR3woox+4PYuIIaBpvIKdR+y/16zNYPtl+4kOjHm9JeEI/cq3ucFMZqgCpHMMv4XRmwJ7iOaIDRhpPN69oJbG7rB7E/OEtq9E9w/vgfSvvsc5VyJiBL0hN40GyAxgW8UG/CzL1vuQGw9SJ8qWzZNpjXUeMTxNjobYFL2y6bfJeBlAMn++umc8XfY7BMiKrAiOIeD72hsqnY0PyS/CKmyab8sjDUvPq1R+R12za60CxVB3kfLTSp6TWsHR+HR0nIitMtbPAqAvpR8GTy2mWkCCYCgV32b1alIoizXyNtWSHMdzDZZCz0u6uxJVvFISYUy1aXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8KXzLDcUNVQocjCKdOJYjgWeokNztfBalpYRcDCeOc=;
 b=Yg5jIGOkvGjsB7vnvctmkzC3PLyHq2Q2z95hffyy/2UGdDIAU/xTT7ZWypYQKuxBb9KZpDQPhRIW0/TbUX2OrSFdoDGfZxct1ZOonJI/CQOPL9kNPWuLTybLweF9ZiwHEBs5ciIASswfNPbnWd3TeUJsgEEWPhsdvEX9qHreNjgAFlE+clXvHXIdZVpxcw9puGjbEpn8EsVlkTSy8iynSocg4ScUTIePIYfA2B7LnDqm/J0rbZRSDf5ikm8iN7pE7/j74zelAFLQ2iBBq0BNU+WyVXvskwdTqC4yVkjAvOnzCwRfuBEw39FjgsnWoMrR+Gr4G0YyQGB/KHdHrOM32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8KXzLDcUNVQocjCKdOJYjgWeokNztfBalpYRcDCeOc=;
 b=etJrMV/hRAJtZVvsOG5F3jnP2OPz3gw6aCtyzLq1ZF2wmov5XFeqP5Ngrq05CQgjvfhNaivud1NyfcIDYj/JqaitFMhAyvsXfKfMAHBXo1WrMHXLHaIETMyNPa5gXGtlRU5drXTaYtMSPWKkFxMxxGlJZPKWlqcSdaU5d3JIHu8=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5025.eurprd08.prod.outlook.com (10.255.29.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 07:08:42 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 07:08:41 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v1 4/4] iotests: add test for virtio-scsi and virtio-blk
 machine type settings
Thread-Topic: [PATCH v1 4/4] iotests: add test for virtio-scsi and virtio-blk
 machine type settings
Thread-Index: AQHVk/SLFHikiWR2YEmBsMEHbhhFn6d93/0AgAALMgCAAJ0jgIABYQYAgAD1bgA=
Date: Fri, 8 Nov 2019 07:08:41 +0000
Message-ID: <bcde79fb-9056-b5a0-69c6-126930244654@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-5-dplotnikov@virtuozzo.com>
 <20191106092412.GH189998@stefanha-x1.localdomain>
 <909f6a98-a750-db34-de23-6c9d89f9f19e@redhat.com>
 <20191106192641.GP3812@habkost.net>
 <20191107163012.GB29053@localhost.localdomain>
In-Reply-To: <20191107163012.GB29053@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:7:67::19) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.138.10.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5197ce9f-fc51-4e83-0edb-08d7641a7c7f
x-ms-traffictypediagnostic: AM0PR08MB5025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB50259ED52B6B008E6B2B60B5CF7B0@AM0PR08MB5025.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(39840400004)(376002)(136003)(189003)(199004)(71200400001)(5660300002)(3846002)(6116002)(6246003)(25786009)(86362001)(31696002)(2906002)(316002)(14454004)(110136005)(71190400001)(7416002)(478600001)(36756003)(6512007)(305945005)(66066001)(52116002)(7736002)(26005)(6436002)(102836004)(76176011)(4326008)(2616005)(476003)(8676002)(6506007)(53546011)(386003)(486006)(99286004)(6486002)(31686004)(66946007)(8936002)(66556008)(66476007)(66446008)(256004)(81166006)(81156014)(229853002)(446003)(11346002)(186003)(54906003)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5025;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfaldqYUrkX9OlEl5uww45ewv6/kXnRAgFJ/QLGDf27MA6phwlwANEDa0aMW7maKThdiq315HAXUlY8gwJkmQlvzhNm0+uVGA2yILHzj2BwQxOpTCNrjBsgFc/W7YkMnpJrdeckirmtozER15hXUnRh7H1M8JvmAb5G+VmZexRdjs2bPi45aJ3iF3MtPUv1fkr3ayFyGZwKd+fjvK2SIHCiLnJZpwzoOpqqKjCJY+SH23haVA0tG58MBviqZSWhPecN1OBvyMR9UHqBR1SPaDcExz9V3s+MMVbyOOZCFXP/GlN0R15unZHbfbPxq9uPP1D/1ORN3rtDEXbbX1UloHVw6jhLnBVrU3XaFOIDYZqq+nwkry0m6mJpcbm6wAfWCWLXzC9ZXDE/HfJf3OokfejqVmEJJVPt4zjWUONT9Fy09goJh2fCpZ0ZWFWSYwuAu
Content-Type: text/plain; charset="utf-8"
Content-ID: <77BB16CFB612B94692A711A013DD3343@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5197ce9f-fc51-4e83-0edb-08d7641a7c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 07:08:41.9192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGlMNY5Tz+BbEerjs96QTS/EiDPsmefMdPjGQwFVennn1dYgFwm1cQPs7P16yY7Z8DugCbBBu9wU5HwabbGedJQvZki3bZuHaN9dU3qzF5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5025
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.135
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAwNy4xMS4yMDE5IDE5OjMwLCBDbGViZXIgUm9zYSB3cm90ZToNCj4gT24gV2VkLCBOb3Yg
MDYsIDIwMTkgYXQgMDQ6MjY6NDFQTSAtMDMwMCwgRWR1YXJkbyBIYWJrb3N0IHdyb3RlOg0KPj4g
T24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMTE6MDQ6MTZBTSArMDEwMCwgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+IE9uIDA2LjExLjE5IDEwOjI0LCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6DQo+Pj4+IE9u
IFR1ZSwgTm92IDA1LCAyMDE5IGF0IDA3OjExOjA1UE0gKzAzMDAsIERlbmlzIFBsb3RuaWtvdiB3
cm90ZToNCj4+Pj4+IEl0IHRlc3RzIHByb3BlciBxdWV1ZSBzaXplIHNldHRpbmdzIGZvciBhbGwg
YXZhaWxhYmxlIG1hY2hpbmUgdHlwZXMuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRGVu
aXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2NyAgICAgfCAxNTQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4+Pj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY3Lm91dCB8ICAg
MSArDQo+Pj4+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgICAxICsNCj4+Pj4+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAxNTYgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4gICBjcmVhdGUgbW9kZSAx
MDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2Nw0KPj4+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvcWVtdS1pb3Rlc3RzLzI2Ny5vdXQNCj4+Pj4gVGhlIHFlbXUtaW90ZXN0cyBtYWludGFp
bmVycyBtaWdodCBwcmVmZXIgZm9yIHRoaXMgdG8gYmUgYXQgdGhlDQo+Pj4+IHRvcC1sZXZlbCBp
biB0ZXN0cy8gc2luY2UgaXQncyBub3QgcmVhbGx5IGFuIGlvdGVzdCwgYnV0IHRoZSBjb2RlIGl0
c2VsZg0KPj4+PiBsb29rcyBmaW5lIHRvIG1lOg0KPj4+Pg0KPj4+PiBSZXZpZXdlZC1ieTogU3Rl
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPj4+IEdvb2QgcXVlc3Rpb24uICBJ
IGRvbuKAmXQgcmVhbGx5IG1pbmQsIGJ1dCBpdCB3b3VsZCBiZSB3ZWlyZCBpZiBzdGFydGVkDQo+
Pj4gYWRkaW5nIGFsbCBraW5kcyBvZiDigJxleHRlcm5hbOKAnSBxZW11IHRlc3RzIChpLmUuIHRo
YXQgdXNlIFFNUCkgaW4gdGhlDQo+Pj4gaW90ZXN0cyBkaXJlY3RvcnkuDQo+Pj4NCj4+PiBXaGF0
IGlzIHRoZSBhbHRlcm5hdGl2ZT8gIEp1c3QgcHV0dGluZyBpdCBpbiBhIGRpZmZlcmVudCBkaXJl
Y3RvcnkNCj4+PiBkb2VzbuKAmXQgc291bmQgdGhhdCBhcHBlYWxpbmcgdG8gbWUgZWl0aGVyLCBi
ZWNhdXNlIGl0IHdvdWxkIHN0aWxsIGRlcGVuZA0KPj4+IG9uIHRoZSBpb3Rlc3RzIGluZnJhc3Ry
dWN0dXJlLCByaWdodD8gIChpLmUuLCBpb3Rlc3RzLnB5IGFuZCBjaGVjaykNCj4+IFdlIGRvIGhh
dmUgdGVzdHMvYWNjZXB0YW5jZSBmb3Igc2ltcGxlIHRlc3QgY2FzZXMgd3JpdHRlbiBpbg0KPj4g
UHl0aG9uLiAgV2hhdCdzIHRoZSByZWFzb24gZm9yIHRoaXMgdGVzdCBjYXNlIHRvIGRlcGVuZCBv
biB0aGUNCj4+IGlvdGVzdHMgaW5mcmFzdHJ1Y3R1cmU/DQo+Pg0KPj4gLS0gDQo+PiBFZHVhcmRv
DQo+IFRoaXMgdGVzdCBkb2VzIGxvb2sgc2ltaWxhciBpbiBzcGlyaXQgdG8gInRlc3RzL2FjY2Vw
dGFuY2UvdmlydGlvX3ZlcnNpb24ucHkiLg0KPg0KPiBEZW5pcywNCj4NCj4gSWYgeW91IHRoaW5r
IHRoaXMgaXMgbW9yZSBvZiBhIGdlbmVyaWMgdGVzdCB0aGFuIGFuIElPIHRlc3QsIGFuZCB3b3Vs
ZA0KPiByYXRoZXIgd2FudCB0byBoYXZlIGl0IGEgbW9yZSBhZ25vc3RpYyBsb2NhdGlvbiwgSSBj
YW4gcHJvdmlkZSB5b3UNCj4gd2l0aCB0aXBzIChvciBhIHBhdGNoKSB0byBkbyBzby4NCg0KSXQg
d291bGQgYmUgZ3JlYXQhIFRoYW5rcyENCg0KRGVuaXMNCg0KPg0KPiBDaGVlcnMsDQo+IC0gQ2xl
YmVyLg0KPg0K

