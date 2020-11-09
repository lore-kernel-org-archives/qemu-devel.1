Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B68C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 05:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745EA21534
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 05:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745EA21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc09P-0004Dx-5j
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 00:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kc08C-0003ff-B3; Mon, 09 Nov 2020 00:54:20 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kc088-0003Tr-UH; Mon, 09 Nov 2020 00:54:20 -0500
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CV0YC0y0mzXkVm;
 Mon,  9 Nov 2020 13:53:51 +0800 (CST)
Received: from DGGEMI421-HUB.china.huawei.com (10.1.199.150) by
 dggemi403-hub.china.huawei.com (10.3.17.136) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 9 Nov 2020 13:53:56 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.227]) by
 dggemi421-hub.china.huawei.com ([10.1.199.150]) with mapi id 14.03.0487.000;
 Mon, 9 Nov 2020 13:53:46 +0800
From: ganqixin <ganqixin@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
Thread-Topic: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
Thread-Index: AQHWtFcK3BwZItgAU0SAQTpR6FXL/qm6wmyAgASLbJA=
Date: Mon, 9 Nov 2020 05:53:45 +0000
Message-ID: <A5B86EC83C48EF4CB2BC58BEF3A2F496065A4AE0@DGGEMI525-MBS.china.huawei.com>
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
 <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
 <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
 <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
 <87zh3ufoy4.fsf@dusky.pond.sub.org>
 <CAFEAcA-3a8gYRPzk4jzv3QfLAw3tL74LoFTMy+VhXZA3QdOfPg@mail.gmail.com>
In-Reply-To: <CAFEAcA-3a8gYRPzk4jzv3QfLAw3tL74LoFTMy+VhXZA3QdOfPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.159]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187; envelope-from=ganqixin@huawei.com;
 helo=szxga01-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:53:57
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P.
 Berrange" <berrange@redhat.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWls
dG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIg
NywgMjAyMCAxMjoyMCBBTQ0KPiBUbzogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQu
Y29tPg0KPiBDYzogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsg
RGFuaWVsIFAuIEJlcnJhbmdlDQo+IDxiZXJyYW5nZUByZWRoYXQuY29tPjsgWmhhbmdoYWlsaWFu
Zw0KPiA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT47DQo+IFFFTVUgVHJpdmlhbCA8cWVtdS10cml2aWFsQG5vbmdudS5v
cmc+OyBRRU1VIERldmVsb3BlcnMNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IGdhbnFpeGlu
IDxnYW5xaXhpbkBodWF3ZWkuY29tPjsgUGFvbG8NCj4gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT47IENoZW5xdW4gKGt1aG4pDQo+IDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gc2NyaXB0cy9jaGVja3BhdGNoLnBsOiBNb2RpZnkgdGhlIGxpbmUg
bGVuZ3RoIGxpbWl0IG9mIHRoZQ0KPiBjb2RlDQo+IA0KPiBPbiBGcmksIDYgTm92IDIwMjAgYXQg
MTY6MDgsIE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+
ID4gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+ID4g
PiBQZXJzb25hbGx5IEkganVzdCBkb24ndCB0aGluayBjaGVja3BhdGNoIHNob3VsZCBiZSBudWRn
aW5nIHBlb3BsZQ0KPiA+ID4gaW50byBmb2xkaW5nIDg1LWNoYXJhY3RlciBsaW5lcywgZXNwZWNp
YWxseSB3aGVuIHRoZXJlIGFyZSBtdWx0aXBsZQ0KPiA+ID4gdmVyeSBzaW1pbGFyIGxpbmVzIGlu
IGEgcm93IGFuZCBvbmx5IG9uZSB3b3VsZCBnZXQgZm9sZGVkLCBlZyB0aGUNCj4gPiA+IHByb3Rv
dHlwZXMgaW4gdGFyZ2V0L2FybS9oZWxwZXIuaCAtLSBzb21lIG9mIHRoZXNlIGp1c3QgZWRnZSBi
ZXlvbmQNCj4gPiA+IDgwIGNoYXJhY3RlcnMgYW5kIEkgdGhpbmsgd3JhcHBpbmcgdGhlbSBpcyBj
bGVhcmx5IHdvcnNlIGZvcg0KPiA+ID4gcmVhZGFiaWxpdHkuDQo+ID4NCj4gPiBUaGUgd2Fybmlu
ZydzIGludGVudCBpcyAiYXJlIHlvdSBzdXJlIHRoaXMgbGluZSBpcyBiZXR0ZXIgbm90IGJyb2tl
bj8iDQo+ID4gVGhlIHByb2JsZW0gaXMgcGVvcGxlIHRyZWF0aW5nIGl0IGFzIGFuIG9yZGVyIHRo
YXQgYWJzb2x2ZXMgdGhlbSBmcm9tDQo+ID4gdXNpbmcgZ29vZCBqdWRnZW1lbnQgaW5zdGVhZC4N
Cj4gPg0KPiA+IEkgcHJvcG9zZSB0byBmaXggaXQgYnkgcGhyYXNpbmcgdGhlIHdhcm5pbmcgbW9y
ZSBjbGVhcmx5LiAgSW5zdGVhZCBvZg0KPiA+DQo+ID4gICAgIFdBUk5JTkc6IGxpbmUgb3ZlciA4
MCBjaGFyYWN0ZXJzDQo+ID4NCj4gPiB3ZSBjb3VsZCBzYXkNCj4gPg0KPiA+ICAgICBXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycw0KPiA+ICAgICBQbGVhc2UgZXhhbWluZSB0aGUgbGlu
ZSwgYW5kIHVzZSB5b3VyIGp1ZGdlbWVudCB0byBkZWNpZGUgd2hldGhlcg0KPiA+ICAgICBpdCBz
aG91bGQgYmUgYnJva2VuLg0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IHRoYXQgZm9yIGEgbGluZSBv
dmVyIDgwIGNoYXJhY3RlcnMgYW5kIGxlc3MgdGhhbg0KPiA4NSBjaGFyYWN0ZXJzLCB0aGUgYW5z
d2VyIGlzIGdvaW5nIHRvIGJlICJiZXR0ZXIgbm90IGJyb2tlbiINCj4gYSBwcmV0dHkgaGlnaCBw
ZXJjZW50YWdlIG9mIHRoZSB0aW1lOyB0aGF0IGlzLCB0aGUgd2FybmluZyBoYXMgdG9vIG1hbnkg
ZmFsc2UNCj4gcG9zaXRpdmVzLCBhbmQgd2Ugc2hvdWxkIHR1bmUgaXQgdG8gaGF2ZSBmZXdlci4N
Cj4gDQo+IEFuZCB0aGUgbHVyZSBvZiAicHJvZHVjZSBubyB3YXJuaW5ncyIgaXMgYSBzdHJvbmcg
b25lLCBzbyB3ZSBzaG91bGQgYmUgYXQNCj4gbGVhc3QgY2F1dGlvdXMgYWJvdXQgd2hhdCBvdXIg
dG9vbGluZyBpcyBudWRnaW5nIHVzIGludG8gZG9pbmcuDQo+IA0KDQpQZXJzb25hbGx5LCBJIGFn
cmVlIHdpdGggdGhpcyB2aWV3LiBJIHRoaW5rIGl0IGlzIG5vdCBhIGdvb2QgdGhpbmcgdG8gY2hl
Y2sgZm9yIG1hbnkgZmFsc2UgcG9zaXRpdmVzLCB3aGV0aGVyIGZvciBtYWludGFpbmVycyBvciBp
bmV4cGVyaWVuY2VkIGRldmVsb3BlcnMuVGhlIGxpbWl0IG9mIDEwMCBpcyBzZXQgYnkgcmVmZXJy
aW5nIHRvIHRoZSBrZXJuZWwgY29tbWl0KGJkYzQ4ZmExMWU0NmY4NjcpLCBtYXliZSBpdCdzIG5v
dCB2ZXJ5IHN1aXRhYmxlIGhlcmUuIFdvdWxkIGl0IGJlIG1vcmUgYXBwcm9wcmlhdGUgZm9yIHVz
IHRvIHNldCB0aGUgbGltaXQgdG8gODUgb3IgOTA/DQpJbiBhZGRpdGlvbiwgY291bGQgd2UgdGVs
bCBkZXZlbG9wZXJzIGluIHRoZSB3YXJuaW5nIG1lc3NhZ2UgdGhhdCB0aGlzIGlzIGp1c3QgdG8g
cmVtaW5kIHRoZW0gdG8gcGF5IGF0dGVudGlvbiBhbmQgbm90IHRvIHJlcGxhY2UgdGhlaXIganVk
Z21lbnQgKGxpa2UgTWFya3VzIHNhaWQpPw0KDQpUaGFua3MsDQpHYW4gUWl4aW4NCg0KPiB0aGFu
a3MNCj4gLS0gUE1NDQo=

