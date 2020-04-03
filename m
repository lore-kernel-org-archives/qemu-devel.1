Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF061C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9712073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9712073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKH8B-0004SR-Ki
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jKH7Y-0003vW-U8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jKH7X-0002Yd-Rj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:52:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2082 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jKH7X-0002OD-FL; Fri, 03 Apr 2020 03:52:07 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id E69B22CDF00EFD953093;
 Fri,  3 Apr 2020 15:51:57 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 3 Apr 2020 15:51:57 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Fri, 3 Apr 2020 15:51:49 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
Thread-Topic: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
Thread-Index: AQHWAlFsKsb+eliWpkW9mt34oeYMj6hnE0Bw
Date: Fri, 3 Apr 2020 07:51:48 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6D495C@dggemm511-mbx.china.huawei.com>
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KVGhpcyBzZXJpZXMgaGFzIGJlZW4gcmV2aWV3ZWQuICBDb3VsZCBzb21lb25lIHBs
ZWFzZSBwaWNrIHRoaXMgdXAgKGUuZy4gcWVtdS10cml2aWFsPyk/DQoNCj4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW5xdW4gKGt1aG4pDQo+U2VudDogV2VkbmVzZGF5LCBN
YXJjaCAyNSwgMjAyMCAxMDo1OSBBTQ0KPlRvOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
dHJpdmlhbEBub25nbnUub3JnDQo+Q2M6IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlh
bmdAaHVhd2VpLmNvbT47IGxhdXJlbnRAdml2aWVyLmV1Ow0KPnBoaWxtZEByZWRoYXQuY29tOyBD
aGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+U3ViamVjdDogW1BBVENI
IHY1IDAvM10gcmVkdW5kYW50IGNvZGU6IEZpeCB3YXJuaW5ncyByZXBvcnRlZCBieSBDbGFuZyBz
dGF0aWMNCj5jb2RlIGFuYWx5emVyDQo+DQo+djEtPnYyOg0KPi0gUGF0Y2gxOiBBZGQgSm9obiBT
bm93IHJldmlldyBjb21tZW50Lg0KPi0gUGF0Y2g5OiBNb3ZlIHRoZSAnZHN0X3R5cGUnIGRlY2xh
cmF0aW9uIHRvIHdoaWxlKCkgc3RhdGVtZW50Lg0KPi0gUGF0Y2gxMjogQWRkIFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZOiMhSByZXZpZXcgY29tbWVudC4NCj4tIFBhdGNoMTM6IE1vdmUgdGhlICdzZXQn
IGRlY2xhcmF0aW9uIHRvIHRoZSBmb3IoKSBzdGF0ZW1lbnQuDQo+DQo+djItPnYzOg0KPi0gUGF0
Y2gxOiBBZGQgS2V2aW4gV29sZiByZXZpZXcgY29tbWVudC4NCj4tIFBhdGNoMjogS2VlcCB0aGUg
J2ZsYWdzJyB0aGVuIHVzZSBpdChCYXNlIG9uIEtldmluJ3MgY29tbWVudHMpLg0KPi0gUGF0Y2gz
OiBBZGQgS2V2aW4gV29sZiByZXZpZXcgY29tbWVudC4NCj4tIFBhdGNoOTogQWRkIEZyYW5jaXNj
byBJZ2xlc2lhcyBhbmQgQWxpc3RhaXIgRnJhbmNpcyByZXZpZXcgY29tbWVudC4NCj4tIFBhdGNo
MTA6IEp1YW4gUXVpbnRlbGEgaGFzIGFkZGVkIGl0IHRvIHRoZSBxdWV1ZSBhbmQgZGVsZXRlIGl0
Lg0KPi0gUGF0Y2gxMi0+UGF0Y2gxMTogQWRkIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZOiMhSByZXZp
ZXcgY29tbWVudC4NCj4tIFBhdGNoMTMtPlBhdGNoMTI6IEFkZCBQaGlsaXBwZSBNYXRoaWV1LURh
dWTojIUgcmV2aWV3IGNvbW1lbnQuDQo+DQo+djMtPnY0Og0KPi0gRGVsZXRlZCB0aGUgcGF0Y2hl
cyB0aGF0IGhhdmUgYmVlbiBtZXJnZWQgaW4gdGhlIHYzLg0KPi0gTW9kaWZ5ICJzY3NpL2VzcC1w
Y2kiIFBhdGNoLCB1c2UgZ19hc3NlcnQgd2l0aCB2YXJpYWJsZSBzaXplLg0KPg0KPnY0LT52NToN
Cj4tIFBhdGNoMTogQWRkIExhdXJlbnQgVml2aWVyIHJldmlldyBjb21tZW50IGFuZCBjaGFuZ2Ug
dGhlIHN1YmplY3QuDQo+LSBQYXRjaDI6IFVzZSBleHRyYWN0MTYoKSBpbnN0ZWFkIG9mIGRlbGV0
ZSBiaXQgb3BlcmF0aW9uIHN0YXRlbWVudC4NCj4tIFBhdGNoMzogQWRkIExhdXJlbnQgVml2aWVy
IHJldmlldyBjb21tZW50Lg0KPg0KPkNoZW4gUXVuICgzKToNCj4gIHNjc2kvZXNwLXBjaTogYWRk
IGdfYXNzZXJ0KCkgZm9yIGZpeCBjbGFuZyBhbmFseXplciB3YXJuaW5nIGluDQo+ICAgIGVzcF9w
Y2lfaW9fd3JpdGUoKQ0KPiAgZGlzcGxheS9ibGl6emFyZDogdXNlIGV4dHJhY3QxNigpIGZvciBm
aXggY2xhbmcgYW5hbHl6ZXIgd2FybmluZyBpbg0KPiAgICBibGl6emFyZF9kcmF3X2xpbmUxNl8z
MigpDQo+ICB0aW1lci9leHlub3M0MjEwX21jdDogUmVtb3ZlIHJlZHVuZGFudCBzdGF0ZW1lbnQg
aW4NCj4gICAgZXh5bm9zNDIxMF9tY3Rfd3JpdGUoKQ0KPg0KPiBody9kaXNwbGF5L2JsaXp6YXJk
LmMgICAgIHwgMTAgKysrKy0tLS0tLQ0KPiBody9zY3NpL2VzcC1wY2kuYyAgICAgICAgIHwgIDEg
Kw0KPiBody90aW1lci9leHlub3M0MjEwX21jdC5jIHwgIDQgLS0tLQ0KPiAzIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+DQo+LS0NCj4yLjIzLjANCj4N
Cg0K

