Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CFEC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFE722265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFE722265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqj0-0002bc-1a
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUqgq-0001eT-BS; Tue, 20 Oct 2020 08:24:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2943 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUqgn-0000MA-DN; Tue, 20 Oct 2020 08:24:32 -0400
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id A17AFE2D226EFA3AE3A9;
 Tue, 20 Oct 2020 20:24:23 +0800 (CST)
Received: from DGGEMI424-HUB.china.huawei.com (10.1.199.153) by
 dggemi406-hub.china.huawei.com (10.3.17.144) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 20 Oct 2020 20:24:23 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 DGGEMI424-HUB.china.huawei.com ([10.1.199.153]) with mapi id 14.03.0487.000;
 Tue, 20 Oct 2020 20:24:16 +0800
From: ganqixin <ganqixin@huawei.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PATCH 00/10] Fix line over 80 characters warning
Thread-Topic: [PATCH 00/10] Fix line over 80 characters warning
Thread-Index: AQHWptCti2+LocN7wES+Gm5O7/e0H6mf0GoAgACY6SA=
Date: Tue, 20 Oct 2020 12:24:15 +0000
Message-ID: <A5B86EC83C48EF4CB2BC58BEF3A2F4960658E4ED@DGGEMI525-MBS.china.huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
 <20201020111346.GH287149@redhat.com>
In-Reply-To: <20201020111346.GH287149@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 08:24:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSBbbWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9i
ZXIgMjAsIDIwMjAgNzoxNCBQTQ0KPiBUbzogZ2FucWl4aW4gPGdhbnFpeGluQGh1YXdlaS5jb20+
DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnOyBs
dml2aWVyQHJlZGhhdC5jb207DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgWmhhbmdoYWls
aWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsNCj4gbXN0QHJlZGhhdC5jb207
IGY0YnVnQGFtc2F0Lm9yZzsgYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tOyBDaGVucXVuDQo+IChr
dWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQu
YXUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xMF0gRml4IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzIHdhcm5pbmcNCj4gDQo+IE9uIFR1ZSwgT2N0IDIwLCAyMDIwIGF0IDA0OjMwOjEzQU0gKzA4
MDAsIEdhbiBRaXhpbiB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4gICAgIEkgdXNlZCBzY3JpcHRz
L2NoZWNrcGF0Y2gucGwgdG8gZmluZCB0aGF0IG1hbnkgZmlsZXMgaW4gdGhlIGh3DQo+ID4gZGly
ZWN0b3J5IGNvbnRhaW4gbGluZXMgd2l0aCBtb3JlIHRoYW4gODAgY2hhcmFjdGVycy4gVGhlcmVm
b3JlLCBJDQo+ID4gc3BsaXRlZCBzb21lIGxpbmVzIHRvIGZpeCB0aGlzIHdhcm5pbmcuDQo+IA0K
PiBEbyB3ZSByZWFsbHkgbmVlZCB0byBzdGlsbCBmaXggb3Vyc2VsdmVzIHRvIGEgODAgY29sIGxp
bWl0IGluIHRoZSB5ZWFyIDIwMjAgPw0KPiANCj4gTGludXggaW5jcmVhc2VkIHRoZWlyIG1heCBs
aW5lIGxlbmd0aCB0byAxMDAgY2hhcnMgYW5kIGV2ZW4gc2V0IGNoZWNrcGF0Y2gucGwNCj4gdG8g
bm90IGNvbXBsYWluIGFib3V0IHRoYXQgbGltaXQgdW5sZXNzIC0tc3RyaWN0IGlzIGdpdmVuLg0K
PiANCj4gODAgY2hhcnMgaXMgZmluZSBhcyBhICJ3aXNoIGxpc3QiIHRhcmdldCwgYnV0IElNSE8g
dGhlIGNvZGUgb2Z0ZW4gYmVuZWZpdHMgbW9yZQ0KPiBmcm9tIGV4Y2VlZGluZyA4MCBjaGFycywg
YW5kIG5vdCB3cmFwcGluZy4NCj4gDQoNCkhpIERhbmllbCwNCiAgWWVzLCB5b3UgYXJlIHJpZ2h0
ISBJIGFsc28gZm91bmQgdGhpcyBwcm9ibGVtIHdoZW4gSSB0cnkgdG8gZml4IHRoZXNlIHdhcm5p
bmcuIEluIHNvbWUgY2FzZXMsIHRoZSA4MC1jaGFyYWN0ZXIgbGltaXQgZG9lc24ndCBuZWNlc3Nh
cmlseSBtYWtlIGNvZGUgbW9yZSByZWFkYWJsZS4gDQoNClRoYW5rcywNCkdhbiBRaXhpbg0KDQo+
IFJlZ2FyZHMsDQo+IERhbmllbA0KPiAtLQ0KPiB8OiBodHRwczovL2JlcnJhbmdlLmNvbSAgICAg
IC1vLQ0KPiBodHRwczovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UgOnwNCj4gfDog
aHR0cHM6Ly9saWJ2aXJ0Lm9yZyAgICAgICAgIC1vLQ0KPiBodHRwczovL2ZzdG9wMTM4LmJlcnJh
bmdlLmNvbSA6fA0KPiB8OiBodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0NCj4gaHR0
cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2UgOnwNCg0K

