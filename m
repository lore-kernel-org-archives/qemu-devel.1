Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C23C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF21A20721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF21A20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHZA-0007cv-47
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jKHQ0-00046C-PM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jKHPz-0000e5-7a
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:11:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2461 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jKHPy-0000bS-RC; Fri, 03 Apr 2020 04:11:11 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id D9457B41218082944830;
 Fri,  3 Apr 2020 16:11:05 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 3 Apr 2020 16:11:05 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Fri, 3 Apr 2020 16:10:59 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
Thread-Topic: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
Thread-Index: AQHWAlFsKsb+eliWpkW9mt34oeYMj6hnE0Bw//9+5QCAAIafkA==
Date: Fri, 3 Apr 2020 08:10:58 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6D4A27@dggemm511-mbx.china.huawei.com>
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
 <7412CDE03601674DA8197E2EBD8937E83B6D495C@dggemm511-mbx.china.huawei.com>
 <b273c5c9-18cc-691f-bd1f-df056f448ade@vivier.eu>
In-Reply-To: <b273c5c9-18cc-691f-bd1f-df056f448ade@vivier.eu>
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
X-Received-From: 45.249.212.187
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
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjAgNDowNCBQ
TQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11LWRl
dmVsQG5vbmdudS5vcmc7DQo+cWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj5DYzogWmhhbmdoYWls
aWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgcGhpbG1kQHJlZGhhdC5jb20N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvM10gcmVkdW5kYW50IGNvZGU6IEZpeCB3YXJuaW5n
cyByZXBvcnRlZCBieSBDbGFuZw0KPnN0YXRpYyBjb2RlIGFuYWx5emVyDQo+DQo+TGUgMDMvMDQv
MjAyMCDDoCAwOTo1MSwgQ2hlbnF1biAoa3VobikgYSDDqWNyaXTCoDoNCj4+IFBpbmchDQo+Pg0K
Pj4gVGhpcyBzZXJpZXMgaGFzIGJlZW4gcmV2aWV3ZWQuICBDb3VsZCBzb21lb25lIHBsZWFzZSBw
aWNrIHRoaXMgdXAgKGUuZy4gcWVtdS0NCj50cml2aWFsPyk/DQo+DQo+QXMgd2UgYXJlIGluIGhh
cmQgZmVhdHVyZSBmcmVlemUgbm93IGFuZCB0aGlzIGlzIG5vdCBjcml0aWNhbCBidWcgZml4ZXMg
SSdtIGdvaW5nDQo+dG8gcXVldWUgdGhlbSBmb3IgNS4xIGV4Y2VwdCBpZiB5b3UgaGF2ZSBnb29k
IGFyZ3VtZW50cyB0byBoYXZlIHRoZW0gaW4gNS4wLg0KPg0KT0ssICBJIGdldCBpdC4gDQpJdCBp
cyBpbXBvcnRhbnQgdG8gZW5zdXJlIGEgc3RhYmxlIHZlcnNpb24hDQoNClRoYW5rcy4NCj4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IENoZW5xdW4gKGt1aG4pDQo+Pj4g
U2VudDogV2VkbmVzZGF5LCBNYXJjaCAyNSwgMjAyMCAxMDo1OSBBTQ0KPj4+IFRvOiBxZW11LWRl
dmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Pj4gQ2M6IFpoYW5naGFp
bGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47DQo+Pj4gbGF1cmVudEB2aXZp
ZXIuZXU7IHBoaWxtZEByZWRoYXQuY29tOyBDaGVucXVuIChrdWhuKQ0KPj4+IDxrdWhuLmNoZW5x
dW5AaHVhd2VpLmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjUgMC8zXSByZWR1bmRhbnQgY29k
ZTogRml4IHdhcm5pbmdzIHJlcG9ydGVkIGJ5DQo+Pj4gQ2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6
ZXINCj4+Pg0KPj4+IHYxLT52MjoNCj4+PiAtIFBhdGNoMTogQWRkIEpvaG4gU25vdyByZXZpZXcg
Y29tbWVudC4NCj4+PiAtIFBhdGNoOTogTW92ZSB0aGUgJ2RzdF90eXBlJyBkZWNsYXJhdGlvbiB0
byB3aGlsZSgpIHN0YXRlbWVudC4NCj4+PiAtIFBhdGNoMTI6IEFkZCBQaGlsaXBwZSBNYXRoaWV1
LURhdWTojIUgcmV2aWV3IGNvbW1lbnQuDQo+Pj4gLSBQYXRjaDEzOiBNb3ZlIHRoZSAnc2V0JyBk
ZWNsYXJhdGlvbiB0byB0aGUgZm9yKCkgc3RhdGVtZW50Lg0KPj4+DQo+Pj4gdjItPnYzOg0KPj4+
IC0gUGF0Y2gxOiBBZGQgS2V2aW4gV29sZiByZXZpZXcgY29tbWVudC4NCj4+PiAtIFBhdGNoMjog
S2VlcCB0aGUgJ2ZsYWdzJyB0aGVuIHVzZSBpdChCYXNlIG9uIEtldmluJ3MgY29tbWVudHMpLg0K
Pj4+IC0gUGF0Y2gzOiBBZGQgS2V2aW4gV29sZiByZXZpZXcgY29tbWVudC4NCj4+PiAtIFBhdGNo
OTogQWRkIEZyYW5jaXNjbyBJZ2xlc2lhcyBhbmQgQWxpc3RhaXIgRnJhbmNpcyByZXZpZXcgY29t
bWVudC4NCj4+PiAtIFBhdGNoMTA6IEp1YW4gUXVpbnRlbGEgaGFzIGFkZGVkIGl0IHRvIHRoZSBx
dWV1ZSBhbmQgZGVsZXRlIGl0Lg0KPj4+IC0gUGF0Y2gxMi0+UGF0Y2gxMTogQWRkIFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZOiMhSByZXZpZXcgY29tbWVudC4NCj4+PiAtIFBhdGNoMTMtPlBhdGNoMTI6
IEFkZCBQaGlsaXBwZSBNYXRoaWV1LURhdWTojIUgcmV2aWV3IGNvbW1lbnQuDQo+Pj4NCj4+PiB2
My0+djQ6DQo+Pj4gLSBEZWxldGVkIHRoZSBwYXRjaGVzIHRoYXQgaGF2ZSBiZWVuIG1lcmdlZCBp
biB0aGUgdjMuDQo+Pj4gLSBNb2RpZnkgInNjc2kvZXNwLXBjaSIgUGF0Y2gsIHVzZSBnX2Fzc2Vy
dCB3aXRoIHZhcmlhYmxlIHNpemUuDQo+Pj4NCj4+PiB2NC0+djU6DQo+Pj4gLSBQYXRjaDE6IEFk
ZCBMYXVyZW50IFZpdmllciByZXZpZXcgY29tbWVudCBhbmQgY2hhbmdlIHRoZSBzdWJqZWN0Lg0K
Pj4+IC0gUGF0Y2gyOiBVc2UgZXh0cmFjdDE2KCkgaW5zdGVhZCBvZiBkZWxldGUgYml0IG9wZXJh
dGlvbiBzdGF0ZW1lbnQuDQo+Pj4gLSBQYXRjaDM6IEFkZCBMYXVyZW50IFZpdmllciByZXZpZXcg
Y29tbWVudC4NCj4+Pg0KPj4+IENoZW4gUXVuICgzKToNCj4+PiAgc2NzaS9lc3AtcGNpOiBhZGQg
Z19hc3NlcnQoKSBmb3IgZml4IGNsYW5nIGFuYWx5emVyIHdhcm5pbmcgaW4NCj4+PiAgICBlc3Bf
cGNpX2lvX3dyaXRlKCkNCj4+PiAgZGlzcGxheS9ibGl6emFyZDogdXNlIGV4dHJhY3QxNigpIGZv
ciBmaXggY2xhbmcgYW5hbHl6ZXIgd2FybmluZyBpbg0KPj4+ICAgIGJsaXp6YXJkX2RyYXdfbGlu
ZTE2XzMyKCkNCj4+PiAgdGltZXIvZXh5bm9zNDIxMF9tY3Q6IFJlbW92ZSByZWR1bmRhbnQgc3Rh
dGVtZW50IGluDQo+Pj4gICAgZXh5bm9zNDIxMF9tY3Rfd3JpdGUoKQ0KPj4+DQo+Pj4gaHcvZGlz
cGxheS9ibGl6emFyZC5jICAgICB8IDEwICsrKystLS0tLS0NCj4+PiBody9zY3NpL2VzcC1wY2ku
YyAgICAgICAgIHwgIDEgKw0KPj4+IGh3L3RpbWVyL2V4eW5vczQyMTBfbWN0LmMgfCAgNCAtLS0t
DQo+Pj4gMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
Pj4+DQo+Pj4gLS0NCj4+PiAyLjIzLjANCj4+Pg0KPj4NCg0K

