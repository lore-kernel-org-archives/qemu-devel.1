Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57CEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A908620714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A908620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jknfP-0006bV-0P
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 07:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianjay.zhou@huawei.com>)
 id 1jkndn-0004jc-QY; Mon, 15 Jun 2020 07:51:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2524 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianjay.zhou@huawei.com>)
 id 1jkndl-0003lo-B8; Mon, 15 Jun 2020 07:51:03 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id C61B361BFF711532955C;
 Mon, 15 Jun 2020 19:50:52 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 15 Jun 2020 19:50:52 +0800
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.27]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0487.000;
 Mon, 15 Jun 2020 19:50:42 +0800
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: zhukeqian <zhukeqian1@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: RE: [PATCH] migration: Count new_dirty instead of real_dirty
Thread-Topic: [PATCH] migration: Count new_dirty instead of real_dirty
Thread-Index: AQHWQsOuGwKJH9ifCkKqqwKpHTiKVqjZiHzw
Date: Mon, 15 Jun 2020 11:50:41 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BD38EFD@DGGEMM528-MBX.china.huawei.com>
References: <20200601040250.38324-1-zhukeqian1@huawei.com>
 <3205abb1-8e47-fc19-1213-ead621711291@huawei.com>
In-Reply-To: <3205abb1-8e47-fc19-1213-ead621711291@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=jianjay.zhou@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 07:50:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Wanghaibin \(D\)" <wanghaibin.wang@huawei.com>,
 Chao Fan <fanc.fnst@cn.fujitsu.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgS2VxaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHpodWtl
cWlhbg0KPiBTZW50OiBNb25kYXksIEp1bmUgMTUsIDIwMjAgMTE6MTkgQU0NCj4gVG86IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgUGFvbG8gQm9uemluaQ0KPiA8
cGJvbnppbmlAcmVkaGF0LmNvbT47IFpob3VqaWFuIChqYXkpIDxqaWFuamF5Lnpob3VAaHVhd2Vp
LmNvbT4NCj4gQ2M6IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+OyBDaGFvIEZh
biA8ZmFuYy5mbnN0QGNuLmZ1aml0c3UuY29tPjsNCj4gV2FuZ2hhaWJpbiAoRCkgPHdhbmdoYWli
aW4ud2FuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtaWdyYXRpb246IENv
dW50IG5ld19kaXJ0eSBpbnN0ZWFkIG9mIHJlYWxfZGlydHkNCj4gDQo+IEhpIFBhb2xvIGFuZCBK
aWFuIFpob3UsDQo+IA0KPiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbiBvbiB0aGlzIHBhdGNo
Pw0KPiANCj4gVGhhbmtzLA0KPiBLZXFpYW4NCj4gDQo+IE9uIDIwMjAvNi8xIDEyOjAyLCBLZXFp
YW4gWmh1IHdyb3RlOg0KPiA+IERJUlRZX0xPR19JTklUSUFMTFlfQUxMX1NFVCBmZWF0dXJlIGlz
IG9uIHRoZSBxdWV1ZS4gVGhpcyBmaXhzIHRoZQ0KDQpzL2ZpeHMvZml4ZXMNCg0KPiA+IGRpcnR5
IHJhdGUgY2FsY3VsYXRpb24gZm9yIHRoaXMgZmVhdHVyZS4gQWZ0ZXIgaW50cm9kdWNpbmcgdGhp
cw0KPiA+IGZlYXR1cmUsIHJlYWxfZGlydHlfcGFnZXMgaXMgZXF1YWwgdG8gdG90YWwgbWVtb3J5
IHNpemUgYXQgYmVnaW5pbmcuDQo+ID4gVGhpcyBjYXVzaW5nIHdyb25nIGRpcnR5IHJhdGUgYW5k
IGZhbHNlIHBvc2l0aXZlIHRocm90dGxpbmcuDQoNCkkgdGhpbmsgaXQgc2hvdWxkIGJlIHRlc3Rl
ZCB3aGV0aGVyIERJUlRZX0xPR19JTklUSUFMTFlfQUxMX1NFVCBpcyBlbmFibGVkDQppbiByYW1f
aW5pdF9iaXRtYXBzKG1heWJlPykgaW4gb3JkZXIgdG8gYmUgY29tcGF0aWJsZSB3aXRoIHRoZSBv
bGQgcGF0aC4NCg0KVGhhbmtzLA0KSmF5IFpob3UNCg0KPiA+DQo+ID4gQlRXLCByZWFsIGRpcnR5
IHJhdGUgaXMgbm90IHN1aXRhYmxlIGFuZCBub3QgdmVyeSBhY2N1cmF0ZS4NCj4gPg0KPiA+IDEu
IEZvciBub3Qgc3VpdGFibGU6IFdlIG1haW5seSBjb25jZXJuIG9uIHRoZSByZWxhdGlvbnNoaXAg
YmV0d2Vlbg0KPiA+ICAgIGRpcnR5IHJhdGUgYW5kIG5ldHdvcmsgYmFuZHdpZHRoLiBOZXQgaW5j
cmVhc2VtZW50IG9mIGRpcnR5IHBhZ2VzDQo+ID4gICAgbWFrZXMgbW9yZSBzZW5zZS4NCj4gPiAy
LiBGb3Igbm90IHZlcnkgYWNjdXJhdGU6IFdpdGggbWFudWFsIGRpcnR5IGxvZyBjbGVhciwgc29t
ZSBkaXJ0eSBwYWdlcw0KPiA+ICAgIHdpbGwgYmUgY2xlYXJlZCBkdXJpbmcgZWFjaCBwZXJvaWQs
IG91ciAicmVhbCBkaXJ0eSByYXRlIiBpcyBsZXNzDQo+ID4gICAgdGhhbiByZWFsICJyZWFsIGRp
cnR5IHJhdGUiLg0KDQoNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VxaWFuIFpodSA8emh1
a2VxaWFuMUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2V4ZWMvcmFtX2FkZHIu
aCB8IDUgKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaCBi
L2luY2x1ZGUvZXhlYy9yYW1fYWRkci5oIGluZGV4DQo+ID4gNWU1OWEzZDhkNy4uYWY5Njc3ZTI5
MSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvZXhlYy9yYW1fYWRkci5oDQo+ID4gQEAgLTQ0Myw3ICs0NDMsNyBAQCBzdGF0aWMgaW5s
aW5lDQo+ID4gIHVpbnQ2NF90IGNwdV9waHlzaWNhbF9tZW1vcnlfc3luY19kaXJ0eV9iaXRtYXAo
UkFNQmxvY2sgKnJiLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJhbV9hZGRyX3Qgc3RhcnQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBsZW5ndGgsDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QNCj4gKnJlYWxf
ZGlydHlfcGFnZXMpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QNCj4gPiArICphY2N1X2RpcnR5X3BhZ2VzKQ0KPiA+ICB7DQo+ID4g
ICAgICByYW1fYWRkcl90IGFkZHI7DQo+ID4gICAgICB1bnNpZ25lZCBsb25nIHdvcmQgPSBCSVRf
V09SRCgoc3RhcnQgKyByYi0+b2Zmc2V0KSA+Pg0KPiA+IFRBUkdFVF9QQUdFX0JJVFMpOyBAQCAt
NDY5LDcgKzQ2OSw2IEBAIHVpbnQ2NF90DQo+IGNwdV9waHlzaWNhbF9tZW1vcnlfc3luY19kaXJ0
eV9iaXRtYXAoUkFNQmxvY2sgKnJiLA0KPiA+ICAgICAgICAgICAgICBpZiAoc3JjW2lkeF1bb2Zm
c2V0XSkgew0KPiA+ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBiaXRzID0gYXRvbWlj
X3hjaGcoJnNyY1tpZHhdW29mZnNldF0sIDApOw0KPiA+ICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBuZXdfZGlydHk7DQo+ID4gLSAgICAgICAgICAgICAgICAqcmVhbF9kaXJ0eV9wYWdl
cyArPSBjdHBvcGwoYml0cyk7DQo+ID4gICAgICAgICAgICAgICAgICBuZXdfZGlydHkgPSB+ZGVz
dFtrXTsNCj4gPiAgICAgICAgICAgICAgICAgIGRlc3Rba10gfD0gYml0czsNCj4gPiAgICAgICAg
ICAgICAgICAgIG5ld19kaXJ0eSAmPSBiaXRzOw0KPiA+IEBAIC01MDIsNyArNTAxLDYgQEAgdWlu
dDY0X3QNCj4gY3B1X3BoeXNpY2FsX21lbW9yeV9zeW5jX2RpcnR5X2JpdG1hcChSQU1CbG9jayAq
cmIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0ICsgYWRkciArIG9mZnNldCwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgVEFSR0VUX1BBR0VfU0laRSwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgRElSVFlfTUVNT1JZX01JR1JBVElPTikpIHsNCj4gPiAtICAg
ICAgICAgICAgICAgICpyZWFsX2RpcnR5X3BhZ2VzICs9IDE7DQo+ID4gICAgICAgICAgICAgICAg
ICBsb25nIGsgPSAoc3RhcnQgKyBhZGRyKSA+PiBUQVJHRVRfUEFHRV9CSVRTOw0KPiA+ICAgICAg
ICAgICAgICAgICAgaWYgKCF0ZXN0X2FuZF9zZXRfYml0KGssIGRlc3QpKSB7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgbnVtX2RpcnR5Kys7DQo+ID4gQEAgLTUxMSw2ICs1MDksNyBAQCB1aW50
NjRfdA0KPiBjcHVfcGh5c2ljYWxfbWVtb3J5X3N5bmNfZGlydHlfYml0bWFwKFJBTUJsb2NrICpy
YiwNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgICphY2N1X2RpcnR5
X3BhZ2VzICs9IG51bV9kaXJ0eTsNCj4gPiAgICAgIHJldHVybiBudW1fZGlydHk7DQo+ID4gIH0N
Cj4gPiAgI2VuZGlmDQo+ID4NCg==

