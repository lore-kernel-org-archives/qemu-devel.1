Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0754EC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 04:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA82F20753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 04:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82F20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN7VH-0007Es-1v
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 00:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jN7Ud-0006pj-Cm
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 00:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jN7Ub-0001v4-Il
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 00:11:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48916 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jN7Ub-0001rD-10; Sat, 11 Apr 2020 00:11:41 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 5279C9DEE4AF0A674EE4;
 Sat, 11 Apr 2020 12:11:33 +0800 (CST)
Received: from DGGEMM525-MBS.china.huawei.com ([169.254.5.82]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0487.000;
 Sat, 11 Apr 2020 12:11:27 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH RFC 2/9] target/riscv: Add target/riscv/kvm.c to place
 the public kvm interface
Thread-Topic: [PATCH RFC 2/9] target/riscv: Add target/riscv/kvm.c to place
 the public kvm interface
Thread-Index: AQHV+OqsnOkX+bVvQEiYhF3Oc/5rwahiAV8AgAAjKYCAEVYS0A==
Date: Sat, 11 Apr 2020 04:11:26 +0000
Message-ID: <3915816D913D8241BB43E932213F57D4ADC89514@dggemm525-mbs.china.huawei.com>
References: <20200313034949.3028-1-jiangyifei@huawei.com>
 <20200313034949.3028-3-jiangyifei@huawei.com>
 <CAAhSdy3_BO7pRwvLiS9qd3NLXUCj_MnsxT8JtD0833AnY1DOZQ@mail.gmail.com>
 <CAAhSdy24zBmuJ=BZFMXsHRJr-tLTEZs=C92QsE26KLGxPxd88Q@mail.gmail.com>
In-Reply-To: <CAAhSdy24zBmuJ=BZFMXsHRJr-tLTEZs=C92QsE26KLGxPxd88Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.222.107]
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
bzphbnVwQGJyYWluZmF1bHQub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAzMSwgMjAyMCA3
OjE5IFBNDQo+IFRvOiBKaWFuZ3lpZmVpIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+DQo+IENjOiBR
RU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IG9wZW4gbGlzdDpSSVNDLVYN
Cj4gPHFlbXUtcmlzY3ZAbm9uZ251Lm9yZz47IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNv
bT47DQo+IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IFNh
Z2FyIEthcmFuZGlrYXINCj4gPHNhZ2Fya0BlZWNzLmJlcmtlbGV5LmVkdT47IEJhc3RpYW4gS29w
cGVsbWFubg0KPiA8a2Jhc3RpYW5AbWFpbC51bmktcGFkZXJib3JuLmRlPjsgWmhhbmd4aWFvZmVu
ZyAoRikNCj4gPHZpY3Rvci56aGFuZ3hpYW9mZW5nQGh1YXdlaS5jb20+OyBBbGlzdGFpciBGcmFu
Y2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyB5aW55aXBlbmcgPHlpbnlpcGVuZzFA
aHVhd2VpLmNvbT47IFBhbG1lcg0KPiBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBkZW5n
a2FpIChBKSA8ZGVuZ2thaTFAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMg
Mi85XSB0YXJnZXQvcmlzY3Y6IEFkZCB0YXJnZXQvcmlzY3Yva3ZtLmMgdG8gcGxhY2UgdGhlDQo+
IHB1YmxpYyBrdm0gaW50ZXJmYWNlDQo+IA0KPiBPbiBUdWUsIE1hciAzMSwgMjAyMCBhdCAyOjQz
IFBNIEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24g
RnJpLCBNYXIgMTMsIDIwMjAgYXQgOToyMyBBTSBZaWZlaSBKaWFuZyA8amlhbmd5aWZlaUBodWF3
ZWkuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBBZGQgdGFyZ2V0L3Jpc2N2L2t2bS5jIHRvIHBs
YWNlIGt2bV9hcmNoXyogZnVuY3Rpb24gbmVlZGVkIGJ5DQo+IGt2bS9rdm0tYWxsLmMuDQo+ID4g
PiBNZWFud2hpbGUsIGFkZCByaXNjdjY0IGt2bSBzdXBwb3J0IHRvIGNvbmZpZ3VyZS4NCj4gPg0K
PiA+IFRoaXMgc2hvdWxkIGJlIGZvciBib3RoIHJpc2N2NjQgYW5kIHJpc2N2MzIuIFRoZSBLVk1U
T09MIGNvbXBpbGVzDQo+ID4gcGVyZmVjdGx5IGZpbmUgZm9yIHJpc2N2MzIgKGFsdGhvdWdoIG5v
dCB0ZXN0ZWQgbXVjaCkgc28gdGhlcmUgaXMgbm8NCj4gPiBoYXJtIGlzIHN1cHBvcnRpbmcgYm90
aCByaXNjdjY0IGFuZCByaXNjdjMyIGZyb20gc3RhcnQgaXRzZWxmLg0KPiANCj4gRm9yIHlvdXIg
cmVmZXJlbmNlLCBJIGhhdmUgdXBkYXRlZCBLVk0gUklTQy1WIGFuZCBLVk1UT09MIFJJU0MtViBy
ZXBvcw0KPiBhdDoNCj4gaHR0cHM6Ly9naXRodWIuY29tL2t2bS1yaXNjdi9saW51eC5naXQgKHJp
c2N2X2t2bV9tYXN0ZXIgYnJhbmNoKQ0KPiBodHRwczovL2dpdGh1Yi5jb20va3ZtLXJpc2N2L2t2
bXRvb2wuZ2l0IChyaXNjdl9tYXN0ZXIgYnJhbmNoKQ0KPiANCj4gQWJvdmUgcmVwb3Mgd29yayBm
b3IgYm90aCBSVjMyIGFuZCBSVjY0IHN5c3RlbXMuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbnVwDQoN
CkhpLA0KDQpJIHdpbGwgYWRkIHJpc2N2MzIgc3VwcG9ydCBhbmQgc2VuZCB2MiBzZXJpZXMuIEJ1
dCBJIGRvbid0IHRlc3QgY29tcGxldGVseSwgYmVjYXVzZSBpdCBuZWVkIHRpbWUgdG8gYnVpbGQg
cmlzY3YzMiBRRU1VIGFuZCBpdHMgZGVwZW5kZW50IGxpYnJhcmllcy4NCkFueXdheSwgSSB3aWxs
IGNvbnRpbnVlIHRvIGJ1aWxkIGFuZCB0ZXN0IHJpc2N2MzIgUUVNVS4NCg0KQnkgdGhlIHdheSwg
SSBoYWQgYSBwcm9ibGVtIHdpdGggc3RhcnQgcmlzY3Y2NCB2bSBhdCBsYXRlc3Qga3ZtLXJpc2N2
IHZlcnNpb24uDQpsYXN0ZXN0IHZlcnNpb246DQp0Y2cgcWVtdTogaHR0cHM6Ly9naXRodWIuY29t
L3FlbXUvcWVtdQ0KbGludXg6IGh0dHBzOi8vZ2l0aHViLmNvbS9rdm0tcmlzY3YvbGludXgNCm9w
ZW5zYmk6IGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9vcGVuc2JpDQprdm10b29sOiBodHRwczov
L2dpdGh1Yi5jb20va3ZtLXJpc2N2L2t2bXRvb2wNCndoZW4gc3RhcnQgdm0gd2l0aCBrdm10b29s
cyBvciB0aGlzIHFlbXUgc2VyaWVzLCBJIHJlY2VpdmVkIGtlcm5lbCBwYW5pYy4NCkRvIHlvdSBo
YXZlIHRoaXMgcHJvYmxlbSA/DQoNClsgICAgMy41ODM5NjNdIFJ1biAvc2Jpbi9pbml0IGFzIGlu
aXQgcHJvY2Vzcw0KWyAgICAzLjk3MjI2NF0gcmNTWzQ0XTogdW5oYW5kbGVkIHNpZ25hbCAxMSBj
b2RlIDB4MSBhdCAweDAwMDAwMDNmYzhkNjcxNzANClsgICAgMy45OTczOThdIENQVTogMCBQSUQ6
IDQ0IENvbW06IHJjUyBOb3QgdGFpbnRlZCA1LjYuMC1yYzUtMTQwMzYtZzZlMWU5ZmNmNWYzMCAj
Mg0KWyAgICA0LjAyNTE0M10gZXBjOiAwMDAwMDAzZmM4ZDY3MTcwIHJhIDogMDAwMDAwMDAwMDAx
OGMxYyBzcCA6IDAwMDAwMDNmZmZiODRlMDANClsgICAgNC4wNTE2MTFdICBncCA6IDAwMDAwMDAw
MDAxMzY2NDggdHAgOiAwMDAwMDAzZmQ2MDg2NzEwIHQwIDogMDAwMDAwMDAwMDAwMDAwMw0KWyAg
ICA0LjA3ODIyM10gIHQxIDogMDAwMDAwMDAwMDAxNzkyYyB0MiA6IDAwMDAwMDAwMDAwMDAwMGIg
czAgOiAwMDAwMDAwMDAwMDE4YmYwDQpbICAgIDQuMTA1MDgyXSAgczEgOiAwMDAwMDAzZmZmYTJm
YTcwIGEwIDogMDAwMDAwMDAwMDAxOTg2OCBhMSA6IDAwMDAwMDAwMDAwMDAwMDINClsgICAgNC4x
MzE4MjRdICBhMiA6IDAwMDAwMDNmZmZiODRlMDggYTMgOiAwMDAwMDAwMDAwMTA0OTg0IGE0IDog
MDAwMDAwMDAwMDEwNDlkYw0KWyAgICA0LjE1ODIwOV0gIGE1IDogMDAwMDAwM2ZkNjI4ZTcxMCBh
NiA6IDAwMDAwMDNmZmZiODRlMDAgYTcgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDQuMTg0NzU2
XSAgczIgOiAwMDAwMDAzZmZmYTJmYTEwIHMzIDogMDAwMDAwMDAwMDEzNzAxMCBzNCA6IDAwMDAw
MDAwMDAwMDAwMDENClsgICAgNC4yMTE0NDhdICBzNSA6IDAwMDAwMDNmYzhkNjU5MTggczYgOiAw
MDAwMDAwMDAwMDAwMDAxIHM3IDogMDAwMDAwMDAwMDExMjAwMA0KWyAgICA0LjIzODIzOF0gIHM4
IDogMDAwMDAwMDAwMDEzNjE0MCBzOSA6IDAwMDAwMDAwMDAwMDAwMDAgczEwOiAwMDAwMDAwMDAw
MDAwMDAwDQpbICAgIDQuMjY0ODgwXSAgczExOiAwMDAwMDAwMDAwMDAwMDAwIHQzIDogMDAwMDAw
M2ZjOGQ2NzE3MCB0NCA6IDAwMDAwMDAwMDAwMDAwMDINClsgICAgNC4yOTE1NDNdICB0NSA6IDAw
MDAwMDNmZDYyODIxODAgdDYgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDQuMzExMTk2XSBzdGF0
dXM6IDAwMDAwMDAwMDAwMDQwMjAgYmFkYWRkcjogMDAwMDAwM2ZjOGQ2NzE3MCBjYXVzZTogMDAw
MDAwMDAwMDAwMDAwYw0KWyAgICA0LjM0ODgzNV0gaW5pdFsxXTogdW5oYW5kbGVkIHNpZ25hbCAx
MSBjb2RlIDB4MSBhdCAweDAwMDAwMDNmZDYyOTI0NjgNClsgICAgNC4zNzM3MThdIENQVTogMCBQ
SUQ6IDEgQ29tbTogaW5pdCBOb3QgdGFpbnRlZCA1LjYuMC1yYzUtMTQwMzYtZzZlMWU5ZmNmNWYz
MCAjMg0KWyAgICA0LjQwMTM0NF0gZXBjOiAwMDAwMDAzZmQ2MjkyNDY4IHJhIDogMDAwMDAwMDAw
MDEwMmY4OCBzcCA6IDAwMDAwMDNmZmZhMmY5NjANClsgICAgNC40Mjc4MTRdICBncCA6IDAwMDAw
MDAwMDAxMzY2NDggdHAgOiAwMDAwMDAzZmM4YjUwNzEwIHQwIDogMDAwMDAwM2ZkNjI5ZDE3MA0K
WyAgICA0LjQ1NDE5OV0gIHQxIDogMDAwMDAwMDAwMDAwMDIzOCB0MiA6IDAwMDAwMDAwMDAxMzUz
ZjAgczAgOiAwMDAwMDAwMDAwMTI0MDAwDQpbICAgIDQuNDgwNjk5XSAgczEgOiAwMDAwMDAwMDAw
MDAwMDA4IGEwIDogMDAwMDAwMDAwMDEyM2FhOCBhMSA6IDAwMDAwMDAwMDAwMDAwMDYNClsgICAg
NC41MDczNTJdICBhMiA6IDAwMDAwMDAwMDAwMDAwMDAgYTMgOiAwMDAwMDAwMDAwMDAwMDAwIGE0
IDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICA0LjUzMzgxOF0gIGE1IDogZmZmZmZmZmZmZmZmZjAw
MCBhNiA6IDAwMDAwMDNmYzhkNjU5MTggYTcgOiAwMDAwMDAwMDAwMDAwMTA0DQpbICAgIDQuNTYw
NDA4XSAgczIgOiAwMDAwMDAwMDAwMDAwMDAwIHMzIDogMDAwMDAwMDAwMDAwMDAwMCBzNCA6IDAw
MDAwMDAwMDAwMDAwMDANClsgICAgNC41ODY5NjZdICBzNSA6IDAwMDAwMDAwMDAwMDAwMmMgczYg
OiAwMDAwMDAwMDAwMDAwMDAzIHM3IDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICA0LjYxMzMzMV0g
IHM4IDogMDAwMDAwMDAwMDEzNjE0MCBzOSA6IDAwMDAwMDAwMDAwMDAwMDAgczEwOiAwMDAwMDAw
MDAwMDAwMDAwDQpbICAgIDQuNjQwMDA2XSAgczExOiAwMDAwMDAwMDAwMDAwMDAwIHQzIDogMDAw
MDAwM2ZkNjI5MjQ2OCB0NCA6IDAwMDAwMDAwMDAwMDAwMDINClsgICAgNC42NjYzNzJdICB0NSA6
IDAwMDAwMDNmYzhiNTNkYzggdDYgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDQuNjg2MTI0XSBz
dGF0dXM6IDAwMDAwMDAwMDAwMDQwMjAgYmFkYWRkcjogMDAwMDAwM2ZkNjI5MjQ2OCBjYXVzZTog
MDAwMDAwMDAwMDAwMDAwYw0KWyAgICA0LjcxNTYxMl0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNp
bmc6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhIGV4aXRjb2RlPTB4MDAwMDAwMGINCg0KQmVzdCBS
ZWdhcmRzLA0KWWlmZWkgSmlhbmcNCg==

