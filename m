Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A9AC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A69120727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A69120727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBptl-0007oy-HM
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 21:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBptB-0007EN-N2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBptA-0002U8-Gw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:10:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:36218 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBpt7-0002AX-Ni; Tue, 10 Mar 2020 21:10:22 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 45A31B8D47AC5803E4B4;
 Wed, 11 Mar 2020 09:10:16 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0439.000;
 Wed, 11 Mar 2020 09:10:09 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
Thread-Topic: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
Thread-Index: AQHV9t0YSMWYddN3YEKvEzi9xBDShqhBUMqAgAFChQA=
Date: Wed, 11 Mar 2020 01:10:08 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B683DFE@dggemm511-mbx.china.huawei.com>
References: <20200310130844.30076-1-kuhn.chenqun@huawei.com>
 <CAFEAcA_W2pRztEAmd1v+6O-1J9-CckVV8+G6kZ3igmR-ie6k+Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_W2pRztEAmd1v+6O-1J9-CckVV8+G6kZ3igmR-ie6k+Q@mail.gmail.com>
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
X-Received-From: 45.249.212.255
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
Cc: Fam Zheng <fam@euphon.net>, Hannes Reinecke <hare@suse.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGV0ZXIgTWF5ZGVsbCBbbWFpbHRv
OnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAxMCwgMjAy
MCA5OjQ3IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4N
Cj5DYzogUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBRRU1VIFRyaXZp
YWwgPHFlbXUtDQo+dHJpdmlhbEBub25nbnUub3JnPjsgRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5l
dD47IEhhbm5lcyBSZWluZWNrZQ0KPjxoYXJlQHN1c2UuY29tPjsgWmhhbmdoYWlsaWFuZyA8emhh
bmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsNCj5RZW11LWJsb2NrIDxxZW11LWJsb2NrQG5v
bmdudS5vcmc+OyBFdWxlciBSb2JvdA0KPjxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsgUGFvbG8g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBody9z
Y3NpL21lZ2FzYXM6Q2xlYW4gdXAgc29tZSByZWR1bmRhbnQgY29kZSBmaXgNCj5DbGFuZyB3YXJu
aW5ncw0KPg0KPk9uIFR1ZSwgMTAgTWFyIDIwMjAgYXQgMTM6MTAsIENoZW4gUXVuIDxrdWhuLmNo
ZW5xdW5AaHVhd2VpLmNvbT4NCj53cm90ZToNCj4+DQo+PiBIZXJlIGFyZSBzb21lIHJlZHVuZGFu
dCBzdGF0ZW1lbnRzLCB3ZSBjYW4gY2xlYW4gdGhlbSB1cC4NCj4+IENsYW5nIHN0YXRpYyBjb2Rl
IGFuYWx5emVyIHNob3cgd2FybmluZzoNCj4+IGh3L3Njc2kvbWVnYXNhcy5jOjExNzU6MzI6IHdh
cm5pbmc6IFZhbHVlIHN0b3JlZCB0byAnbWF4X2xkX2Rpc2tzJyBkdXJpbmcNCj5pdHMgaW5pdGlh
bGl6YXRpb24gaXMgbmV2ZXIgcmVhZA0KPj4gICAgIHVpbnQzMl90IG51bV9sZF9kaXNrcyA9IDAs
IG1heF9sZF9kaXNrcyA9IHMtPmZ3X2x1bnM7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+ICAgfn5+fn5+fn5+fg0KPj4gaHcvc2NzaS9tZWdhc2FzLmM6MTE4
Mzo5OiB3YXJuaW5nOiBWYWx1ZSBzdG9yZWQgdG8gJ21heF9sZF9kaXNrcycgaXMgbmV2ZXINCj5y
ZWFkDQo+PiAgICAgICAgIG1heF9sZF9kaXNrcyA9IDA7DQo+PiAgICAgICAgIF4gICAgICAgICAg
ICAgIH4NCj4+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdl
aS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5j
b20+DQo+PiAtLS0NCj4+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0K
Pj4gQ2M6IEZhbSBaaGVuZyA8ZmFtQGV1cGhvbi5uZXQ+DQo+PiBDYzogSGFubmVzIFJlaW5lY2tl
IDxoYXJlQHN1c2UuY29tPg0KPj4gQ2M6IHFlbXUtYmxvY2tAbm9uZ251Lm9yZw0KPj4gLS0tDQo+
PiAgaHcvc2NzaS9tZWdhc2FzLmMgfCAzICstLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvc2NzaS9tZWdh
c2FzLmMgYi9ody9zY3NpL21lZ2FzYXMuYyBpbmRleA0KPj4gYWYxOGM4OGI2NS4uM2Y5ODJlMWQz
YiAxMDA2NDQNCj4+IC0tLSBhL2h3L3Njc2kvbWVnYXNhcy5jDQo+PiArKysgYi9ody9zY3NpL21l
Z2FzYXMuYw0KPj4gQEAgLTExNzIsNyArMTE3Miw3IEBAIHN0YXRpYyBpbnQNCj5tZWdhc2FzX2Rj
bWRfbGRfbGlzdF9xdWVyeShNZWdhc2FzU3RhdGUgKnMsIE1lZ2FzYXNDbWQgKmNtZCkNCj4+ICAg
ICAgdWludDE2X3QgZmxhZ3M7DQo+PiAgICAgIHN0cnVjdCBtZmlfbGRfdGFyZ2V0aWRfbGlzdCBp
bmZvOw0KPj4gICAgICBzaXplX3QgZGNtZF9zaXplID0gc2l6ZW9mKGluZm8pLCByZXNpZDsNCj4+
IC0gICAgdWludDMyX3QgbnVtX2xkX2Rpc2tzID0gMCwgbWF4X2xkX2Rpc2tzID0gcy0+ZndfbHVu
czsNCj4+ICsgICAgdWludDMyX3QgbnVtX2xkX2Rpc2tzID0gMCwgbWF4X2xkX2Rpc2tzOw0KPj4g
ICAgICBCdXNDaGlsZCAqa2lkOw0KPj4NCj4+ICAgICAgLyogbWJveDAgY29udGFpbnMgZmxhZ3Mg
Ki8NCj4+IEBAIC0xMTgwLDcgKzExODAsNiBAQCBzdGF0aWMgaW50DQo+bWVnYXNhc19kY21kX2xk
X2xpc3RfcXVlcnkoTWVnYXNhc1N0YXRlICpzLCBNZWdhc2FzQ21kICpjbWQpDQo+PiAgICAgIHRy
YWNlX21lZ2FzYXNfZGNtZF9sZF9saXN0X3F1ZXJ5KGNtZC0+aW5kZXgsIGZsYWdzKTsNCj4+ICAg
ICAgaWYgKGZsYWdzICE9IE1SX0xEX1FVRVJZX1RZUEVfQUxMICYmDQo+PiAgICAgICAgICBmbGFn
cyAhPSBNUl9MRF9RVUVSWV9UWVBFX0VYUE9TRURfVE9fSE9TVCkgew0KPj4gLSAgICAgICAgbWF4
X2xkX2Rpc2tzID0gMDsNCj4+ICAgICAgfQ0KPg0KPlRoaXMgZG9lc24ndCBsb29rIHJpZ2h0IC0t
IHlvdXIgY2hhbmdlIHJlbW92ZXMgdGhlIG9ubHkgc3RhdGVtZW50IGluIHRoZSBib2R5DQo+b2Yg
dGhpcyAiaWYiLiBJIHRoaW5rIHlvdSBuZWVkIHRvIGV4YW1pbmUgd2hhdCB0aGUgZnVuY3Rpb24g
aXMgdHJ5aW5nIHRvIGRvIHdpdGgNCj50aGUgdGVzdCBpdCBpcyBkb2luZyBvbiB0aGVzZSBmbGFn
cyBpbiBvcmRlciB0byBpZGVudGlmeSB3aGF0IHRoZSByaWdodCBjaGFuZ2UgaXMuLi4NCj4NCkFo
LCBzb3JyeSBmb3IgdHJvdWJsZSwgIGl0IGlzIG5vdCBhIG1pc3Rha2UgdGhhdCBzaG91bGQgaGFw
cGVuLiBJIHNob3VsZCBkb3VibGUgY2hlY2sgaXQgbmV4dCB0aW1lLg0KDQo+UHJvYmFibHkgdGhp
cyBtZWFucyBnb2luZyBiYWNrIHRvIHRoZSBoL3cgc3BlYyB0byBpZGVudGlmeSB0aGUgY29ycmVj
dA0KPmJlaGF2aW91ciBvdmVyYWxsLg0KPg0KWWVzLCBJIHNob3VsZCBnbyBiYWNrIHRoZSBodyBz
cGVjIGluIG9yZGVyIHRvIHVuZGVyc3RhbmQgdGhlIGJlaGF2aW91ciBvdmVyYWxsLg0KDQpUaGFu
a3MuDQpDaGVuIFF1bg0K

