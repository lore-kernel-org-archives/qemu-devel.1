Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623EFC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60322067C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60322067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmB0-0005lB-Ru
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kZm9i-0004XM-73; Mon, 02 Nov 2020 21:34:43 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kZm9f-0006Zi-7r; Mon, 02 Nov 2020 21:34:41 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CQDQ21vPKzQmhd;
 Tue,  3 Nov 2020 10:34:34 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 3 Nov 2020 10:34:34 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 dggemm422-hub.china.huawei.com ([169.254.138.104]) with mapi id
 14.03.0487.000; Tue, 3 Nov 2020 10:34:28 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 5/6] plugins/loader: fix uninitialized variable warning
 in plugin_reset_uninstall()
Thread-Topic: [PATCH 5/6] plugins/loader: fix uninitialized variable warning
 in plugin_reset_uninstall()
Thread-Index: AQHWsYQOG+BA1V6h/kOkIdkZ4HoI+6m1JgQAgACIJTA=
Date: Tue, 3 Nov 2020 02:34:27 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA24B18@dggemm531-mbx.china.huawei.com>
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-6-kuhn.chenqun@huawei.com>
 <b069ab47-8f3d-b4e9-77f6-567b1dcbd296@redhat.com>
In-Reply-To: <b069ab47-8f3d-b4e9-77f6-567b1dcbd296@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:34:35
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
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxtZEByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJl
ciAzLCAyMDIwIDEwOjE4IEFNDQo+IFRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1
YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHFlbXUtdHJpdmlhbEBub25nbnUu
b3JnDQo+IENjOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBaaGFuZ2hh
aWxpYW5nDQo+IDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBnYW5xaXhpbiA8Z2Fu
cWl4aW5AaHVhd2VpLmNvbT47IEV1bGVyDQo+IFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gcGx1Z2lucy9sb2FkZXI6IGZpeCB1bmluaXRp
YWxpemVkIHZhcmlhYmxlIHdhcm5pbmcgaW4NCj4gcGx1Z2luX3Jlc2V0X3VuaW5zdGFsbCgpDQo+
IA0KPiBPbiAxMS8zLzIwIDI6NTIgQU0sIENoZW4gUXVuIHdyb3RlOg0KPiA+IEFmdGVyIHRoZSBX
SVRIX1FFTVVfTE9DS19HVUFSRCBtYWNybyBpcyBhZGRlZCwgdGhlIGNvbXBpbGVyIGNhbm5vdA0K
PiA+IGlkZW50aWZ5ICB0aGF0IHRoZSBzdGF0ZW1lbnRzIGluIHRoZSBtYWNybyBtdXN0IGJlIGV4
ZWN1dGVkLiBBcyBhDQo+ID4gcmVzdWx0LCBzb21lIHZhcmlhYmxlcyAgYXNzaWdubWVudCBzdGF0
ZW1lbnRzIGluIHRoZSBtYWNybyBtYXkgYmUNCj4gY29uc2lkZXJlZCBhcyB1bmV4ZWN1dGVkIGJ5
IHRoZSBjb21waWxlci4NCj4gPg0KPiA+IFRoZSBjb21waWxlciBzaG93ZWQgd2FybmluZzoNCj4g
PiBwbHVnaW5zL2xvYWRlci5jOiBJbiBmdW5jdGlvbiDigJhwbHVnaW5fcmVzZXRfdW5pbnN0YWxs
4oCZOg0KPiA+IHBsdWdpbnMvbG9hZGVyLmM6MzgyOjE1OiB3YXJuaW5nOiDigJhjdHjigJkgbWF5
IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbg0KPiA+IHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5p
bml0aWFsaXplZF0NCj4gDQo+IFRoaXMgc2hvdWxkbid0IGhhcHBlbiBhcyB0aGUgZnVuY3Rpb24g
cmV0dXJucyBiZWZvcmUgKGVsc2UgdGhlcmUgaXMgYSBOVUxMDQo+IGRlcmVmKS4NCj4gDQpZZXMs
IGluIGZhY3QsIGl0IHNob3VsZG4ndCBoYXZlIGhhcHBlbmVkIHdoZW4gdGhlIHByb2dyYW0gd2Fz
IHJ1bm5pbmcuDQpCdXQgYWZ0ZXIgYWRkZWQgJ1dJVEhfUUVNVV9MT0NLX0dVQVJEJywgbGV0IHRo
ZSBjb21waWxlciB0aGluayBpdCBtaWdodCBoYXBwZW4uDQpTbywgd2UgYWRkIGEgZGVmYXVsdCB2
YWx1ZSwgbWFrZSB0aGUgY29tcGlsZXIgaGFwcHkuDQoNClRoYW5rcywNCkNoZW4gUXVuDQo+ID4g
IDM4MiB8ICAgICBkYXRhLT5jdHggPSBjdHg7DQo+ID4gICAgICB8ICAgICB+fn5+fn5+fn5+Xn5+
fn4NCj4gPg0KPiA+IEFkZCBhIGRlZmF1bHQgdmFsdWUgZm9yICdleHBpcmVfdGltZScgdG8gcHJl
dmVudGVkIHRoZSB3YXJuaW5nLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJvYm90IDxl
dWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhu
LmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiBDYzogIkFsZXggQmVubsOpZSIgPGFs
ZXguYmVubmVlQGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+ID4gIHBsdWdpbnMvbG9hZGVyLmMgfCAy
ICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL3BsdWdpbnMvbG9hZGVyLmMgYi9wbHVnaW5zL2xvYWRlci5j
IGluZGV4DQo+ID4gOGFjNWRiYzIwZi4uODg1OTNmZTEzOCAxMDA2NDQNCj4gPiAtLS0gYS9wbHVn
aW5zL2xvYWRlci5jDQo+ID4gKysrIGIvcGx1Z2lucy9sb2FkZXIuYw0KPiA+IEBAIC0zNjcsNyAr
MzY3LDcgQEAgdm9pZCBwbHVnaW5fcmVzZXRfdW5pbnN0YWxsKHFlbXVfcGx1Z2luX2lkX3QgaWQs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHJlc2V0KSAgew0KPiA+ICAg
ICAgc3RydWN0IHFlbXVfcGx1Z2luX3Jlc2V0X2RhdGEgKmRhdGE7DQo+ID4gLSAgICBzdHJ1Y3Qg
cWVtdV9wbHVnaW5fY3R4ICpjdHg7DQo+ID4gKyAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fY3R4ICpj
dHggPSBOVUxMOw0KPiA+DQo+ID4gICAgICBXSVRIX1FFTVVfTE9DS19HVUFSRCgmcGx1Z2luLmxv
Y2spIHsNCj4gPiAgICAgICAgICBjdHggPSBwbHVnaW5faWRfdG9fY3R4X2xvY2tlZChpZCk7DQo+
ID4NCg0K

