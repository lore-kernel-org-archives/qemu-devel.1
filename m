Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C05CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11684206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11684206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY2CE-0004fw-1b
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY2BQ-00045L-Hg; Thu, 29 Oct 2020 03:17:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kY2BN-0006cY-IR; Thu, 29 Oct 2020 03:17:16 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CMGwK0ypyzXgnf;
 Thu, 29 Oct 2020 15:17:05 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0487.000;
 Thu, 29 Oct 2020 15:16:54 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth
 <thuth@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@redhat.com>
Subject: RE: [PATCH 8/9] target/ppc: silence the compiler warnings
Thread-Topic: [PATCH 8/9] target/ppc: silence the compiler warnings
Thread-Index: AQHWrOF++5tpq89iJE2w+J6lhBCyZamsQWqAgABWa4CAAI9dAIABBFGQ
Date: Thu, 29 Oct 2020 07:16:53 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA0FA08@dggemm531-mbx.china.huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-9-kuhn.chenqun@huawei.com>
 <77fb89c5-daa2-0039-bdba-cce0f9895195@redhat.com>
 <c8255814-80ff-8937-938f-158ff924bb91@redhat.com>
 <20201028233910.GH5604@yekko.fritz.box>
In-Reply-To: <20201028233910.GH5604@yekko.fritz.box>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga01-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 03:17:04
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 ganqixin <ganqixin@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBHaWJzb24gW21haWx0
bzpkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXVdDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDI5LCAyMDIwIDc6MzkgQU0NCj4gVG86IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0K
PiBDYzogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgQ2hlbnF1
biAoa3VobikNCj4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUu
b3JnOw0KPiBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsgRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90
QGh1YXdlaS5jb20+Ow0KPiBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdl
aS5jb20+OyBnYW5xaXhpbg0KPiA8Z2FucWl4aW5AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCA4LzldIHRhcmdldC9wcGM6IHNpbGVuY2UgdGhlIGNvbXBpbGVyIHdhcm5pbmdzDQo+
IA0KPiBPbiBXZWQsIE9jdCAyOCwgMjAyMCBhdCAwNDowNjowM1BNICswMTAwLCBUaG9tYXMgSHV0
aCB3cm90ZToNCj4gPiBPbiAyOC8xMC8yMDIwIDEwLjU2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gPiA+IE9uIDEwLzI4LzIwIDU6MTggQU0sIENoZW4gUXVuIHdyb3RlOg0KPiA+
ID4+IFdoZW4gdXNpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCBpbiBvdXIgQ0ZMQUdTLCB0aGUg
Y29tcGlsZXIgc2hvd2VkDQo+IHdhcm5pbmc6DQo+ID4gPj4gdGFyZ2V0L3BwYy9tbXVfaGVscGVy
LmM6IEluIGZ1bmN0aW9uIOKAmGR1bXBfbW114oCZOg0KPiA+ID4+IHRhcmdldC9wcGMvbW11X2hl
bHBlci5jOjEzNTE6MTI6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsDQo+IHRocm91
Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQ0KPiA+ID4+ICAxMzUxIHwgICAgICAgICBpZiAo
cHBjNjRfdjNfcmFkaXgoZW52X2FyY2hjcHUoZW52KSkpIHsNCj4gPiA+PiAgICAgICB8ICAgICAg
ICAgICAgXg0KPiA+ID4+IHRhcmdldC9wcGMvbW11X2hlbHBlci5jOjEzNTg6NTogbm90ZTogaGVy
ZQ0KPiA+ID4+ICAxMzU4IHwgICAgIGRlZmF1bHQ6DQo+ID4gPj4gICAgICAgfCAgICAgXn5+fn5+
fg0KPiA+ID4+DQo+ID4gPj4gQWRkIHRoZSBjb3JyZXNwb25kaW5nICJmYWxsIHRocm91Z2giIGNv
bW1lbnQgdG8gZml4IGl0Lg0KPiA+ID4+DQo+ID4gPj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJvYm90
IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVu
IDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+PiBDYzogRGF2aWQg
R2lic29uIDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+DQo+ID4gPj4gLS0tDQo+ID4gPj4g
IHRhcmdldC9wcGMvbW11X2hlbHBlci5jIHwgMSArDQo+ID4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9wcGMvbW11
X2hlbHBlci5jIGIvdGFyZ2V0L3BwYy9tbXVfaGVscGVyLmMNCj4gPiA+PiBpbmRleCA4OTcyNzE0
Nzc1Li41MTc0OWI2MmRmIDEwMDY0NA0KPiA+ID4+IC0tLSBhL3RhcmdldC9wcGMvbW11X2hlbHBl
ci5jDQo+ID4gPj4gKysrIGIvdGFyZ2V0L3BwYy9tbXVfaGVscGVyLmMNCj4gPiA+PiBAQCAtMTM1
NSw2ICsxMzU1LDcgQEAgdm9pZCBkdW1wX21tdShDUFVQUENTdGF0ZSAqZW52KQ0KPiA+ID4+ICAg
ICAgICAgICAgICBicmVhazsNCj4gPiA+PiAgICAgICAgICB9DQo+ID4gPj4gICNlbmRpZg0KPiA+
ID4+ICsgICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPiA+ID4NCj4gPiA+IEknbSBzdXJwcmlz
ZSB0aGUgY29tcGlsZXIgZW1pdCBhIHdhcm5pbmcgZm9yIG1pc3NpbmcgY29tbWVudCwgYnV0DQo+
ID4gPiBkb24ndCBlbWl0IG9uZSBmb3Igc3VwZXJmbHVvdXMgYW5kIGNvbmZ1c2luZyBvbmVzICh3
aGVuIGJ1aWxkaW5nIGENCj4gPiA+IHBwYzMyLW9ubHkgdGFyZ2V0KS4gWW91J2QgbmVlZCB0byBw
dXQgdGhpcyBiZWZvcmUgdGhlICNlbmRpZi4NCj4gPiA+DQo+ID4gPiBCdXQgaW5zdGVhZCBvZiB0
aGlzIGJhbmQtYWlkIHRvIHNpbGVudCB3YXJuaW5nLCByZXBsYWNlIHRoZSBUT0RPIGJ5DQo+ID4g
PiBhIExPR19VTklNUCBjYWxsLCBhbmQgYWRkIGEgYnJlYWsgYmVmb3JlIHRoZSAjZW5kaWYuDQo+
ID4NCj4gPiArMSBmb3IgcmVwbGFjaW5nIHRoZSBUT0RPIHdpdGggYSBMT0dfVU5JTVAgY2FsbCBh
bmQgYWRkaW5nIGEgYnJlYWsNCj4gPiAraW5zdGVhZCwNCj4gPiB0aGF0IHdvdWxkIGxvb2sgd2F5
IGxlc3MgbWVzc3kgdGhhbiB0aGUgY3VycmVudCBjb2RlLg0KPiANCj4gVHJ1ZSwgdGhhdCB3b3Vs
ZCBiZSBhIGJldHRlciBhcHByb2FjaC4NCg0KWWVhaCwgdGhhdCdzIGEgZ29vZCBpZGVhLiAgDQpJ
J2xsIG1vZGlmeSBpdCBpbiB0aGUgdjIuDQoNClRoYW5rcywNCkNoZW4gUXVuDQo+IA0KPiAtLQ0K
PiBEYXZpZCBHaWJzb24JCQl8IEknbGwgaGF2ZSBteSBtdXNpYyBiYXJvcXVlLCBhbmQgbXkgY29k
ZQ0KPiBkYXZpZCBBVCBnaWJzb24uZHJvcGJlYXIuaWQuYXUJfCBtaW5pbWFsaXN0LCB0aGFuayB5
b3UuICBOT1QgX3RoZV8NCj4gX290aGVyXw0KPiAJCQkJfCBfd2F5XyBfYXJvdW5kXyENCj4gaHR0
cDovL3d3dy5vemxhYnMub3JnL35kZ2lic29uDQo=

