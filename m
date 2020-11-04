Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324462236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324462236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka97O-0003X6-8a
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 22:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1ka95h-0002dz-GS; Tue, 03 Nov 2020 22:04:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1ka95e-0005nQ-Az; Tue, 03 Nov 2020 22:04:04 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CQs1869Ydz51rd;
 Wed,  4 Nov 2020 11:03:40 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 4 Nov 2020 11:03:43 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Wed, 4 Nov 2020 11:03:34 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: RE: [PATCH 1/6] target/xtensa: fix uninitialized variable warning
Thread-Topic: [PATCH 1/6] target/xtensa: fix uninitialized variable warning
Thread-Index: AQHWsYQKtNCTbaRXh0S8iybx28woy6m1nFiAgACrZUA=
Date: Wed, 4 Nov 2020 03:03:34 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA2AD13@dggemm531-mbx.china.huawei.com>
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-2-kuhn.chenqun@huawei.com>
 <CAMo8BfK5wDgvzWFsC0WHyztUCiGR0dGnJgJiAVt5aG7nt8PsDw@mail.gmail.com>
In-Reply-To: <CAMo8BfK5wDgvzWFsC0WHyztUCiGR0dGnJgJiAVt5aG7nt8PsDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga02-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:03:47
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, qemu-devel <qemu-devel@nongnu.org>,
 ganqixin <ganqixin@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXggRmlsaXBwb3YgW21haWx0
bzpqY212YmtiY0BnbWFpbC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjAg
NToyMiBQTQ0KPiBUbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0K
PiBDYzogcWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgUUVNVSBUcml2aWFsDQo+
IDxxZW11LXRyaXZpYWxAbm9uZ251Lm9yZz47IFpoYW5naGFpbGlhbmcNCj4gPHpoYW5nLnpoYW5n
aGFpbGlhbmdAaHVhd2VpLmNvbT47IGdhbnFpeGluIDxnYW5xaXhpbkBodWF3ZWkuY29tPjsgRXVs
ZXINCj4gUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS82XSB0YXJnZXQveHRlbnNhOiBmaXggdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3YXJuaW5n
DQo+IA0KPiBPbiBNb24sIE5vdiAyLCAyMDIwIGF0IDU6NTIgUE0gQ2hlbiBRdW4gPGt1aG4uY2hl
bnF1bkBodWF3ZWkuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBjb21waWxlciBjYW5ub3Qg
ZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIHJldHVybiB2YWx1ZXMgb2YgdGhlDQo+ID4geHRlbnNhX29w
ZXJhbmRfaXNfcmVnaXN0ZXIoaXNhLCBvcGMsIG9wbmQpICBhbmQNCj4geHRlbnNhX29wZXJhbmRf
aXNfdmlzaWJsZShpc2EsIG9wYywgb3BuZCkgZnVuY3Rpb25zIGFyZSB0aGUgc2FtZS4NCj4gDQo+
IEl0IGRvZXNuJ3QgaGF2ZSB0byBiZWNhdXNlIDEpIHRoZXkgZGVmaW5pdGVseSBhcmUgbm90IHRo
ZSBzYW1lLCBidXQNCj4gMikgaXQgZG9lc24ndCBtYXR0ZXIuDQo+IA0KPiA+IFNvLGl0IGFzc3Vt
ZXMgdGhhdCAncmYnIGlzIG5vdCBhc3NpZ25lZCwgYnV0IGl0J3MgdXNlZC4NCj4gDQo+IFRoZSBh
c3N1bXB0aW9uIGlzIHdyb25nLiByZiBpcyB1c2VkIHVuZGVyIHRoZSAnaWYgKHJlZ2lzdGVyX2Zp
bGUpJw0KPiBjb25kaXRpb24gYW5kIHJlZ2lzdGVyX2ZpbGUgaXMgaW5pdGlhbGl6ZWQgdG8gTlVM
TCBhbmQgdGhlbiBzZXQgdG8gc29tZXRoaW5nDQo+IG5vbi1OVUxMIGJhc2VkIG9uIHRoZSB2YWx1
ZSBvZiByZiBoZXJlOg0KPiANCkhpIE1heCwNCiAgWWVhaCwgeW91ciBhbmFseXNpcyBpcyBjb3Jy
ZWN0LiBUaGlzIHJmIGlzIHVzZWQgb25seSB3aGVuIHJlZ2lzdGVyX2ZpbGUgaXMgbm9uLU5VTEwu
IFdoZW4gdGhpcyBjb25kaXRpb24gaXMgbWV0LCB0aGUgcmYgbXVzdCBoYXZlIGJlZW4gYXNzaWdu
ZWQgYSB2YWx1ZS4NClRoZSBHQ0MgOS4zIGNvbXBpbGF0aW9uIEkgdXNlIGNvbnRhaW5zIHRoZSBX
bWF5YmUtdW5pbml0aWFsaXplZCBwYXJhbWV0ZXIgYnkgZGVmYXVsdC4gSXQgY2Fubm90IHJlY29n
bml6ZSB0aGlzIGNvbXBsZXggbG9naWMganVkZ21lbnQuDQpUaGlzIHdhcm5pbmcgbWF5IGJlIGZy
ZXF1ZW50bHkgZW5jb3VudGVyZWQgYnkgZGV2ZWxvcGVycyB3aG8gY29tcGlsZSB0aGlzIHBhcnQg
b2YgY29kZS4NCg0KPiA5NTggICAgICAgICAgICAgaWYgKHh0ZW5zYV9vcGVyYW5kX2lzX3JlZ2lz
dGVyKGlzYSwgb3BjLCBvcG5kKSkgew0KPiA5NTkgICAgICAgICAgICAgICAgIHJmID0geHRlbnNh
X29wZXJhbmRfcmVnZmlsZShpc2EsIG9wYywgb3BuZCk7DQo+IDk2MCAgICAgICAgICAgICAgICAg
cmVnaXN0ZXJfZmlsZSA9IGRjLT5jb25maWctPnJlZ2ZpbGVbcmZdOw0KPiANCj4gPiBUaGUgY29t
cGlsZXIgc2hvd2VkIHdhcm5pbmc6DQo+ID4gdGFyZ2V0L3h0ZW5zYS90cmFuc2xhdGUuYzogSW4g
ZnVuY3Rpb24g4oCYZGlzYXNfeHRlbnNhX2luc27igJk6DQo+ID4gdGFyZ2V0L3h0ZW5zYS90cmFu
c2xhdGUuYzo5ODU6NDM6IHdhcm5pbmc6IOKAmHJm4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6
ZWQgaW4NCj4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQ0KPiA+ICAgOTg1
IHwgICAgICAgICAgICAgICAgICAgICBhcmdbdm9wbmRdLm51bV9iaXRzID0NCj4geHRlbnNhX3Jl
Z2ZpbGVfbnVtX2JpdHMoaXNhLCByZik7DQo+ID4gICAgICAgfA0KPiBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gQWRkIGEgZGVmYXVsdCB2YWx1ZSBmb3IgJ3JmJyB0
byBwcmV2ZW50ZWQgdGhlIHdhcm5pbmcuDQo+IA0KPiBJIGRvbid0IHNlZSBpdCBkb2luZyBkZWZh
dWx0IGJ1aWxkIHdpdGggZ2NjIDguMy4gQnV0IHRoZW4gSSBkb24ndCBzZWUNCj4gLVdtYXliZS11
bmluaXRpYWxpemVkIGluIHRoZSBjb21waWxlciBjb21tYW5kIGxpbmUgZWl0aGVyLg0KPiANCk1h
eWJlIGl0J3MgYXZhaWxhYmxlIGFmdGVyIEdDQzksIG9yIHNvbWUgQ0ZMQUcgY29uZmlndXJhdGlv
bi4NCg0KVGhlIC1XbWF5YmUtdW5pbml0aWFsaXplZCBwYXJhbWV0ZXIgaGFzIHRoaXMgZGVzY3Jp
cHRpb27vvJoNCiJUaGVzZSB3YXJuaW5ncyBhcmUgb25seSBwb3NzaWJsZSBpbiBvcHRpbWl6aW5n
IGNvbXBpbGF0aW9uLCBiZWNhdXNlIG90aGVyd2lzZSBHQ0MgZG9lcyBub3Qga2VlcCB0cmFjayBv
ZiB0aGUgc3RhdGUgb2YgdmFyaWFibGVzLiINCkZyb23vvJpodHRwczovL2djYy5nbnUub3JnL29u
bGluZWRvY3MvZ2NjL1dhcm5pbmctT3B0aW9ucy5odG1sI1dhcm5pbmctT3B0aW9ucw0KDQpJIGhh
dmUgdHJpZWQgdG8gY29uZmlndXJlIG9ubHkgIi1PMiAtZmV4Y2VwdGlvbnMiIGZvciB0aGUgQ0ZM
QUcgb24gR0NDOSwgYW5kIHRoaXMgd2FybmluZyB3aWxsIG9jY3VyLg0KDQo+ID4gUmVwb3J0ZWQt
Ynk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiBDYzog
TWF4IEZpbGlwcG92IDxqY212YmtiY0BnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRhcmdldC94
dGVuc2EvdHJhbnNsYXRlLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC94dGVuc2Ev
dHJhbnNsYXRlLmMgYi90YXJnZXQveHRlbnNhL3RyYW5zbGF0ZS5jDQo+ID4gaW5kZXggOTQ0YTE1
Nzc0Ny4uZWVhODUxYmJlNyAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQveHRlbnNhL3RyYW5zbGF0
ZS5jDQo+ID4gKysrIGIvdGFyZ2V0L3h0ZW5zYS90cmFuc2xhdGUuYw0KPiA+IEBAIC05NTMsNyAr
OTUzLDcgQEAgc3RhdGljIHZvaWQgZGlzYXNfeHRlbnNhX2luc24oQ1BVWHRlbnNhU3RhdGUgKmVu
diwNCj4gPiBEaXNhc0NvbnRleHQgKmRjKQ0KPiA+DQo+ID4gICAgICAgICAgZm9yIChvcG5kID0g
dm9wbmQgPSAwOyBvcG5kIDwgb3BuZHM7ICsrb3BuZCkgew0KPiA+ICAgICAgICAgICAgICB2b2lk
ICoqcmVnaXN0ZXJfZmlsZSA9IE5VTEw7DQo+ID4gLSAgICAgICAgICAgIHh0ZW5zYV9yZWdmaWxl
IHJmOw0KPiA+ICsgICAgICAgICAgICB4dGVuc2FfcmVnZmlsZSByZiA9IC0xOw0KPiANCj4gUGxl
YXNlIHVzZSBYVEVOU0FfVU5ERUZJTkVEIGluc3RlYWQgaWYgeW91IHN0aWxsIHRoaW5rIHRoaXMg
aXMgd29ydGggY2hhbmdpbmcuDQo+IA0KSSBkb24ndCB0aGluayBpdCdzIHdyb25nLCBpdCdzIGp1
c3QgYSBiaXQgb2YgdHJvdWJsZSBmb3IgdGhlIGNvbXBpbGVyIDopDQoNClRoYW5rcywNCkNoZW4g
UXVuDQo=

