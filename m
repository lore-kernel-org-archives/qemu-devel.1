Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD07FC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DDB24673
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DDB24673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6u8X-0004GK-Ok
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6u7w-0003iV-RE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6u7v-0004nv-D4
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:41:16 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:42098 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6u7v-0004kA-2d; Wed, 26 Feb 2020 05:41:15 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 7148DECA367947E9CA2D;
 Wed, 26 Feb 2020 18:41:11 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 18:41:10 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Wed, 26 Feb 2020 18:41:00 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: RE: [PATCH v2 01/13] block/stream: Remove redundant statement in
 stream_run()
Thread-Topic: [PATCH v2 01/13] block/stream: Remove redundant statement in
 stream_run()
Thread-Index: AQHV7IFlUj7vrN4bEEyjDb3dOy8EkKgstWMAgACNqjD//37wAIAAht+A
Date: Wed, 26 Feb 2020 10:41:00 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B662BF9@dggemm531-mbx.china.huawei.com>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-2-kuhn.chenqun@huawei.com>
 <20200226095102.GA6096@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B662BBF@dggemm531-mbx.china.huawei.com>
 <20200226103608.GC6096@linux.fritz.box>
In-Reply-To: <20200226103608.GC6096@linux.fritz.box>
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max
 Reitz <mreitz@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS2V2aW4gV29sZiBbbWFpbHRvOmt3
b2xmQHJlZGhhdC5jb21dDQo+U2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyMCA2OjM2
IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj5DYzog
Sm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11
LQ0KPnRyaXZpYWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBaaGFuZ2hh
aWxpYW5nDQo+PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IEV1bGVyIFJvYm90DQo+
PGV1bGVyLnJvYm90QGh1YXdlaS5jb20+OyBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDEvMTNdIGJsb2NrL3N0cmVhbTogUmVtb3ZlIHJlZHVu
ZGFudCBzdGF0ZW1lbnQgaW4NCj5zdHJlYW1fcnVuKCkNCj4NCj5BbSAyNi4wMi4yMDIwIHVtIDEx
OjIxIGhhdCBDaGVucXVuIChrdWhuKSBnZXNjaHJpZWJlbjoNCj4+DQo+Pg0KPj4gPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+RnJvbTogS2V2aW4gV29sZiBbbWFpbHRvOmt3b2xmQHJl
ZGhhdC5jb21dDQo+PiA+U2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyMCA1OjUxIFBN
DQo+PiA+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+ID5D
YzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsNCj4+ID5w
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IFpoYW5naGFpbGlhbmcNCj4+ID48emhhbmcuemhhbmdo
YWlsaWFuZ0BodWF3ZWkuY29tPjsgRXVsZXIgUm9ib3QNCj4+ID48ZXVsZXIucm9ib3RAaHVhd2Vp
LmNvbT47IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT47IE1heCBSZWl0eg0KPj4gPjxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4+ID5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAxLzEzXSBibG9jay9z
dHJlYW06IFJlbW92ZSByZWR1bmRhbnQNCj4+ID5zdGF0ZW1lbnQgaW4NCj4+ID5zdHJlYW1fcnVu
KCkNCj4+ID4NCj4+ID5BbSAyNi4wMi4yMDIwIHVtIDA5OjQ2IGhhdCBrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbSBnZXNjaHJpZWJlbjoNCj4+ID4+IEZyb206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5A
aHVhd2VpLmNvbT4NCj4+ID4+DQo+PiA+PiBDbGFuZyBzdGF0aWMgY29kZSBhbmFseXplciBzaG93
IHdhcm5pbmc6DQo+PiA+PiAgIGJsb2NrL3N0cmVhbS5jOjE4Njo5OiB3YXJuaW5nOiBWYWx1ZSBz
dG9yZWQgdG8gJ3JldCcgaXMgbmV2ZXIgcmVhZA0KPj4gPj4gICAgICAgICByZXQgPSAwOw0KPj4g
Pj4gICAgICAgICBeICAgICB+DQo+PiA+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVy
LnJvYm90QGh1YXdlaS5jb20+DQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5j
aGVucXVuQGh1YXdlaS5jb20+DQo+PiA+PiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0By
ZWRoYXQuY29tPg0KPj4gPg0KPj4gPkxldCdzIG1lbnRpb24gdGhhdCB0aGlzIGlzIHVubmVjZXNz
YXJ5IHNpbmNlIGNvbW1pdCAxZDgwOTA5OGFhOS4NCj4+ID4NCj4+ID5TaW5jZSB0aGUgc2FtZSBj
b21taXQsIHRoZSBpbml0aWFsaXNhdGlvbiAnaW50IHJldCA9IDA7JyBpcw0KPj4gPnVubmVjZXNz
YXJ5IGJlY2F1c2Ugd2UgbmV2ZXIgcmVhZCByZXQgYmVmb3JlIG92ZXJ3cml0aW5nIHRoZSBpbml0
aWFsDQo+PiA+dmFsdWUuIFdlIGNvdWxkIGNsZWFuIHRoaXMgdXAgaW4gdGhlIHNhbWUgcGF0Y2gu
DQo+Pg0KPj4gWWVzLCB3ZSBjYW4gY2xlYW4gaXQgYW5kIG1vdmUgJ3JldCcgIGRlY2xhcmF0aW9u
IHRvIHRoZSBmb3IoKSBzdGF0ZW1lbnQuDQo+Pg0KPj4gTW9kaWZ5IGp1c3QgTGlrZSB0aGlz77ya
DQo+PiBbLi4uXQ0KPg0KPkdvZGQgcG9pbnQsIG1ha2VzIHNlbnNlIHRvIG1lLiBQbGVhc2Uga2Vl
cCBteSBSLWIgaWYgeW91IG1ha2UgdGhpcyBjaGFuZ2UuDQpPSywgbm8gcHJvYmxlbe+8gQ0KDQpU
aGFua3MuDQo+DQo+S2V2aW4NCj4NCj4+IEBAIC0xMTQsNyArMTE0LDYgQEAgc3RhdGljIGludCBj
b3JvdXRpbmVfZm4gc3RyZWFtX3J1bihKb2IgKmpvYiwgRXJyb3INCj4qKmVycnApDQo+PiAgICAg
IGludDY0X3Qgb2Zmc2V0ID0gMDsNCj4+ICAgICAgdWludDY0X3QgZGVsYXlfbnMgPSAwOw0KPj4g
ICAgICBpbnQgZXJyb3IgPSAwOw0KPj4gLSAgICBpbnQgcmV0ID0gMDsNCj4+ICAgICAgaW50NjRf
dCBuID0gMDsgLyogYnl0ZXMgKi8NCj4+DQo+PiAgICAgIGlmIChicyA9PSBzLT5ib3R0b20pIHsN
Cj4+IEBAIC0xMzksNiArMTM4LDcgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gc3RyZWFtX3J1
bihKb2IgKmpvYiwgRXJyb3INCj4+ICoqZXJycCkNCj4+DQo+PiAgICAgIGZvciAoIDsgb2Zmc2V0
IDwgbGVuOyBvZmZzZXQgKz0gbikgew0KPj4gICAgICAgICAgYm9vbCBjb3B5Ow0KPj4gKyAgICAg
ICAgaW50IHJldDsNCj4+DQo+PiAgICAgICAgICAvKiBOb3RlIHRoYXQgZXZlbiB3aGVuIG5vIHJh
dGUgbGltaXQgaXMgYXBwbGllZCB3ZSBuZWVkIHRvIHlpZWxkDQo+PiAgICAgICAgICAgKiB3aXRo
IG5vIHBlbmRpbmcgSS9PIGhlcmUgc28gdGhhdCBiZHJ2X2RyYWluX2FsbCgpIHJldHVybnMuDQo+
PiBAQCAtMTgzLDcgKzE4Myw2IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIHN0cmVhbV9ydW4o
Sm9iICpqb2IsIEVycm9yDQo+KiplcnJwKQ0KPj4gICAgICAgICAgICAgICAgICBicmVhazsNCj4+
ICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICB9DQo+PiAtICAgICAgICByZXQgPSAwOw0KPj4N
Cj4+ICAgICAgICAgIC8qIFB1Ymxpc2ggcHJvZ3Jlc3MgKi8NCj4+ICAgICAgICAgIGpvYl9wcm9n
cmVzc191cGRhdGUoJnMtPmNvbW1vbi5qb2IsIG4pOw0KPj4NCj4+ID4NCj4+ID5XaXRoIG9yIHdp
dGhvdXQgdGhlIGNoYW5nZXM6DQo+PiA+DQo+PiA+UmV2aWV3ZWQtYnk6IEtldmluIFdvbGYgPGt3
b2xmQHJlZGhhdC5jb20+DQo+Pg0KDQo=

