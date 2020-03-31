Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149BA20658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149BA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDBU-0003qz-9n
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jJDAe-0003MT-SS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jJDAd-0005U5-9k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:26:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2460 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jJDAc-0005RM-La; Tue, 31 Mar 2020 05:26:55 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 832E5A78C32A090C756E;
 Tue, 31 Mar 2020 17:26:45 +0800 (CST)
Received: from DGGEMM525-MBS.china.huawei.com ([169.254.5.177]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0487.000;
 Tue, 31 Mar 2020 17:26:39 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH RFC 8/9] target/riscv: Handler KVM_EXIT_RISCV_SBI exit
Thread-Topic: [PATCH RFC 8/9] target/riscv: Handler KVM_EXIT_RISCV_SBI exit
Thread-Index: AQHV+OqvoUZxcqUDbESQQ6g4WnAHaKhhvyIAgADJQ+A=
Date: Tue, 31 Mar 2020 09:26:39 +0000
Message-ID: <3915816D913D8241BB43E932213F57D4ADC75680@dggemm525-mbs.china.huawei.com>
References: <20200313034949.3028-1-jiangyifei@huawei.com>
 <20200313034949.3028-9-jiangyifei@huawei.com>
 <CAAhSdy3EE+2V+e0po7kmdEau_88CEJ-D9yu7=PQ4ZJQ=zWr9YA@mail.gmail.com>
In-Reply-To: <CAAhSdy3EE+2V+e0po7kmdEau_88CEJ-D9yu7=PQ4ZJQ=zWr9YA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.201.158]
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
Cc: "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <anup.patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFudXAgUGF0ZWwgW21haWx0
bzphbnVwQGJyYWluZmF1bHQub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAzMSwgMjAyMCAx
OjE3IFBNDQo+IFRvOiBKaWFuZ3lpZmVpIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+DQo+IENjOiBR
RU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IG9wZW4gbGlzdDpSSVNDLVYg
PHFlbXUtDQo+IHJpc2N2QG5vbmdudS5vcmc+OyBBbnVwIFBhdGVsIDxhbnVwLnBhdGVsQHdkYy5j
b20+OyBaaGFuZ2hhaWxpYW5nDQo+IDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBT
YWdhciBLYXJhbmRpa2FyDQo+IDxzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBCYXN0aWFuIEtv
cHBlbG1hbm4gPGtiYXN0aWFuQG1haWwudW5pLQ0KPiBwYWRlcmJvcm4uZGU+OyBaaGFuZ3hpYW9m
ZW5nIChGKSA8dmljdG9yLnpoYW5neGlhb2ZlbmdAaHVhd2VpLmNvbT47DQo+IEFsaXN0YWlyIEZy
YW5jaXMgPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IHlpbnlpcGVuZw0KPiA8eWlueWlwZW5n
MUBodWF3ZWkuY29tPjsgUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+IGRl
bmdrYWkgKEEpIDxkZW5na2FpMUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJG
QyA4LzldIHRhcmdldC9yaXNjdjogSGFuZGxlciBLVk1fRVhJVF9SSVNDVl9TQkkgZXhpdA0KPiAN
Cj4gT24gRnJpLCBNYXIgMTMsIDIwMjAgYXQgOToyMyBBTSBZaWZlaSBKaWFuZyA8amlhbmd5aWZl
aUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPg0KPiA+IFVzZSBjaGFyLWZlIGhhbmRsZXIgY29uc29s
ZSBzYmkgY2FsbCwgd2hpY2ggaW1wbGVtZW50IGVhcmx5IGNvbnNvbGUgaW8NCj4gPiB3aGlsZSBh
cHBseSAnZWFybHljb249c2JpJyBpbnRvIGtlcm5lbCBwYXJhbWV0ZXJzLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWWlmZWkgSmlhbmcgPGppYW5neWlmZWlAaHVhd2VpLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZaXBlbmcgWWluIDx5aW55aXBlbmcxQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+
ID4gIHRhcmdldC9yaXNjdi9rdm0uYyB8IDU0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9r
dm0uYyBiL3RhcmdldC9yaXNjdi9rdm0uYyBpbmRleA0KPiA+IDBmNDI5ZmQ4MDIuLjFkZjcwZmJi
MjkgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2t2bS5jDQo+ID4gKysrIGIvdGFyZ2V0
L3Jpc2N2L2t2bS5jDQo+ID4gQEAgLTM4LDYgKzM4LDcgQEANCj4gPiAgI2luY2x1ZGUgInFlbXUv
bG9nLmgiDQo+ID4gICNpbmNsdWRlICJody9sb2FkZXIuaCINCj4gPiAgI2luY2x1ZGUgImt2bV9y
aXNjdi5oIg0KPiA+ICsjaW5jbHVkZSAiY2hhcmRldi9jaGFyLWZlLmgiDQo+ID4NCj4gPiAgc3Rh
dGljIF9fdTY0IGt2bV9yaXNjdl9yZWdfaWQoX191NjQgdHlwZSwgX191NjQgaWR4KSAgeyBAQCAt
NjEsNg0KPiA+ICs2MiwxOSBAQCBzdGF0aWMgX191NjQga3ZtX3Jpc2N2X3JlZ19pZChfX3U2NCB0
eXBlLCBfX3U2NCBpZHgpDQo+ID4NCj4gPiAgI2RlZmluZSBSSVNDVl9GUF9EX1JFRyhpZHgpICBr
dm1fcmlzY3ZfcmVnX2lkKEtWTV9SRUdfUklTQ1ZfRlBfRCwNCj4gPiBpZHgpDQo+ID4NCj4gPiAr
ZW51bSBzYmlfZXh0X2lkIHsNCj4gPiArICAgIFNCSV9FWFRfMF8xX1NFVF9USU1FUiA9IDB4MCwN
Cj4gPiArICAgIFNCSV9FWFRfMF8xX0NPTlNPTEVfUFVUQ0hBUiA9IDB4MSwNCj4gPiArICAgIFNC
SV9FWFRfMF8xX0NPTlNPTEVfR0VUQ0hBUiA9IDB4MiwNCj4gPiArICAgIFNCSV9FWFRfMF8xX0NM
RUFSX0lQSSA9IDB4MywNCj4gPiArICAgIFNCSV9FWFRfMF8xX1NFTkRfSVBJID0gMHg0LA0KPiA+
ICsgICAgU0JJX0VYVF8wXzFfUkVNT1RFX0ZFTkNFX0kgPSAweDUsDQo+ID4gKyAgICBTQklfRVhU
XzBfMV9SRU1PVEVfU0ZFTkNFX1ZNQSA9IDB4NiwNCj4gPiArICAgIFNCSV9FWFRfMF8xX1JFTU9U
RV9TRkVOQ0VfVk1BX0FTSUQgPSAweDcsDQo+ID4gKyAgICBTQklfRVhUXzBfMV9TSFVURE9XTiA9
IDB4OCwNCj4gPiArICAgIFNCSV9FWFRfQkFTRSA9IDB4MTAsDQo+ID4gK307DQo+ID4gKw0KPiAN
Cj4gUGxlYXNlIGFkZCBzZXBhcmF0ZSBTQkkgZWNhbGwgaW50ZXJmYWNlIGhlYWRlciAoc2ltaWxh
ciB0byBPcGVuU0JJKS4NCj4gVGhpcyBoZWFkZXIgd2lsbCBvbmx5IGhhdmUgU0JJIHNwZWMgcmVs
YXRlZCBkZWZpbmVzLg0KPiANCj4gUmVmZXIsDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9v
cGVuc2JpL2Jsb2IvbWFzdGVyL2luY2x1ZGUvc2JpL3NiaV9lY2FsbF9pbnRlcmZhDQo+IGNlLmgN
Cg0KWWVzLCB0aGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJJ2xsIHVwZGF0ZSBpdCBhdCBuZXh0IHNl
cmllcyBhZnRlciB5b3UgcmV2aWV3IHRoaXMgc2VyaWVzIGFsbC4NCg0KPiANCj4gPiAgc3RhdGlj
IGludCBrdm1fcmlzY3ZfZ2V0X3JlZ3NfY29yZShDUFVTdGF0ZSAqY3MpICB7DQo+ID4gICAgICBp
bnQgcmV0ID0gMDsNCj4gPiBAQCAtNDIzLDkgKzQzNyw0NyBAQCBib29sDQo+IGt2bV9hcmNoX3N0
b3Bfb25fZW11bGF0aW9uX2Vycm9yKENQVVN0YXRlICpjcykNCj4gPiAgICAgIHJldHVybiB0cnVl
Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBrdm1fcmlzY3ZfaGFuZGxlX3NiaShzdHJ1
Y3Qga3ZtX3J1biAqcnVuKSB7DQo+ID4gKyAgICBpbnQgcmV0ID0gMDsNCj4gPiArICAgIHVuc2ln
bmVkIGNoYXIgY2g7DQo+ID4gKyAgICBzd2l0Y2ggKHJ1bi0+cmlzY3Zfc2JpLmV4dGVuc2lvbl9p
ZCkgew0KPiA+ICsgICAgY2FzZSBTQklfRVhUXzBfMV9DT05TT0xFX1BVVENIQVI6DQo+ID4gKyAg
ICAgICAgY2ggPSBydW4tPnJpc2N2X3NiaS5hcmdzWzBdOw0KPiA+ICsgICAgICAgIHFlbXVfY2hy
X2ZlX3dyaXRlKHNlcmlhbF9oZCgwKS0+YmUsICZjaCwgc2l6ZW9mKGNoKSk7DQo+ID4gKyAgICAg
ICAgYnJlYWs7DQo+ID4gKyAgICBjYXNlIFNCSV9FWFRfMF8xX0NPTlNPTEVfR0VUQ0hBUjoNCj4g
PiArICAgICAgICByZXQgPSBxZW11X2Nocl9mZV9yZWFkX2FsbChzZXJpYWxfaGQoMCktPmJlLCAm
Y2gsIHNpemVvZihjaCkpOw0KPiA+ICsgICAgICAgIGlmIChyZXQgPT0gc2l6ZW9mKGNoKSkgew0K
PiA+ICsgICAgICAgICAgICBydW4tPnJpc2N2X3NiaS5hcmdzWzBdID0gY2g7DQo+ID4gKyAgICAg
ICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgcnVuLT5yaXNjdl9zYmkuYXJnc1swXSA9IC0x
Ow0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgICAgICBicmVhazsNCj4gDQo+IFBsZWFzZSBlbXVs
YXRlIFNCSSB2MC4xIFNodXRkb3duIGNhbGwgYXMgd2VsbC4NCg0KSXQgc2VlbXMgdGhhdCB0aGVy
ZSBpcyBubyBuZWVkIGZvciBlbXVsYXRpbmcgU0hVVERPV04gY2FsbCBhdCBRRU1VLg0KU0JJX0VY
VF8wXzFfU0hVVERPV04gaXMgcmVkaXJlY3QgdG8gS1ZNX1NZU1RFTV9FVkVOVF9TSFVURE9XTiBp
biBLVk0sDQp3aGljaCBpcyBoYW5kbGVkIGJ5IGNvbW1vbiBrdm0tZXhpdCBoYW5kbGVyIGluIFFF
TVUuDQpBbmQsIEl0IGlzIG5vcm1hbCB0byBwZXJmb3JtIGBwb3dlcm9mZmAgaW4gdGhlIHZpcnR1
YWwgbWFjaGluZS4NCg0KPiANCj4gPiArICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgcWVtdV9s
b2dfbWFzayhMT0dfVU5JTVAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAiJXM6IHVuLWhh
bmRsZWQgU0JJIEVYSVQsIHNwZWNpZmljIHJlYXNvbnMgaXMgJWx1XG4iLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgX19mdW5jX18sIHJ1bi0+cmlzY3Zfc2JpLmV4dGVuc2lvbl9pZCk7DQo+
ID4gKyAgICAgICAgcmV0ID0gLTE7DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKyAgICB9DQo+
ID4gKyAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBpbnQga3ZtX2FyY2hfaGFu
ZGxlX2V4aXQoQ1BVU3RhdGUgKmNzLCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKSAgew0KPiA+IC0gICAg
cmV0dXJuIDA7DQo+ID4gKyAgICBpbnQgcmV0ID0gMDsNCj4gPiArICAgIHN3aXRjaCAocnVuLT5l
eGl0X3JlYXNvbikgew0KPiA+ICsgICAgY2FzZSBLVk1fRVhJVF9SSVNDVl9TQkk6DQo+ID4gKyAg
ICAgICAgcmV0ID0ga3ZtX3Jpc2N2X2hhbmRsZV9zYmkocnVuKTsNCj4gPiArICAgICAgICBicmVh
azsNCj4gPiArICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5J
TVAsICIlczogdW4taGFuZGxlZCBleGl0IHJlYXNvbiAlZFxuIiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBydW4tPmV4aXRfcmVhc29uKTsNCj4gPiArICAgICAgICByZXQg
PSAtMTsNCj4gPiArICAgICAgICBicmVhazsNCj4gPiArICAgIH0NCj4gPiArICAgIHJldHVybiBy
ZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICB2b2lkIGt2bV9yaXNjdl9yZXNldF92Y3B1KFJJU0NWQ1BV
ICpjcHUpDQo+ID4gLS0NCj4gPiAyLjE5LjENCj4gPg0KPiA+DQo+ID4NCj4gDQo+IFJlZ2FyZHMs
DQo+IEFudXANCg0KQmVzdCByZWdhcmRzLA0KWWlmZWkgSmlhbmcNCg==

