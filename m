Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CFC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF9B24673
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9B24673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tpe-0002ge-Jz
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6toh-0001tx-2M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6toc-0001wz-UG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:21:22 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2505 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6toc-0001Td-JP; Wed, 26 Feb 2020 05:21:18 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 6D380985A0725E50E009;
 Wed, 26 Feb 2020 18:21:13 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0439.000;
 Wed, 26 Feb 2020 18:21:04 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Subject: RE: [PATCH v2 01/13] block/stream: Remove redundant statement in
 stream_run()
Thread-Topic: [PATCH v2 01/13] block/stream: Remove redundant statement in
 stream_run()
Thread-Index: AQHV7IFlUj7vrN4bEEyjDb3dOy8EkKgstWMAgACNqjA=
Date: Wed, 26 Feb 2020 10:21:03 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B662BBF@dggemm531-mbx.china.huawei.com>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-2-kuhn.chenqun@huawei.com>
 <20200226095102.GA6096@linux.fritz.box>
In-Reply-To: <20200226095102.GA6096@linux.fritz.box>
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
X-Received-From: 45.249.212.188
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtldmluIFdvbGYgW21haWx0
bzprd29sZkByZWRoYXQuY29tXQ0KPlNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjYsIDIwMjAg
NTo1MSBQTQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+
Q2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS10cml2aWFsQG5vbmdudS5vcmc7DQo+cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5n
QGh1YXdlaS5jb20+Ow0KPkV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsgSm9o
biBTbm93IDxqc25vd0ByZWRoYXQuY29tPjsNCj5NYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29t
Pg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDEvMTNdIGJsb2NrL3N0cmVhbTogUmVtb3ZlIHJl
ZHVuZGFudCBzdGF0ZW1lbnQgaW4NCj5zdHJlYW1fcnVuKCkNCj4NCj5BbSAyNi4wMi4yMDIwIHVt
IDA5OjQ2IGhhdCBrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbSBnZXNjaHJpZWJlbjoNCj4+IEZyb206
IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+DQo+PiBDbGFuZyBzdGF0aWMg
Y29kZSBhbmFseXplciBzaG93IHdhcm5pbmc6DQo+PiAgIGJsb2NrL3N0cmVhbS5jOjE4Njo5OiB3
YXJuaW5nOiBWYWx1ZSBzdG9yZWQgdG8gJ3JldCcgaXMgbmV2ZXIgcmVhZA0KPj4gICAgICAgICBy
ZXQgPSAwOw0KPj4gICAgICAgICBeICAgICB+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3Qg
PGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vo
bi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0By
ZWRoYXQuY29tPg0KPg0KPkxldCdzIG1lbnRpb24gdGhhdCB0aGlzIGlzIHVubmVjZXNzYXJ5IHNp
bmNlIGNvbW1pdCAxZDgwOTA5OGFhOS4NCj4NCj5TaW5jZSB0aGUgc2FtZSBjb21taXQsIHRoZSBp
bml0aWFsaXNhdGlvbiAnaW50IHJldCA9IDA7JyBpcyB1bm5lY2Vzc2FyeSBiZWNhdXNlDQo+d2Ug
bmV2ZXIgcmVhZCByZXQgYmVmb3JlIG92ZXJ3cml0aW5nIHRoZSBpbml0aWFsIHZhbHVlLiBXZSBj
b3VsZCBjbGVhbiB0aGlzIHVwDQo+aW4gdGhlIHNhbWUgcGF0Y2guDQoNClllcywgd2UgY2FuIGNs
ZWFuIGl0IGFuZCBtb3ZlICdyZXQnICBkZWNsYXJhdGlvbiB0byB0aGUgZm9yKCkgc3RhdGVtZW50
Lg0KDQpNb2RpZnkganVzdCBMaWtlIHRoaXPvvJoNCkBAIC0xMTQsNyArMTE0LDYgQEAgc3RhdGlj
IGludCBjb3JvdXRpbmVfZm4gc3RyZWFtX3J1bihKb2IgKmpvYiwgRXJyb3IgKiplcnJwKQ0KICAg
ICBpbnQ2NF90IG9mZnNldCA9IDA7DQogICAgIHVpbnQ2NF90IGRlbGF5X25zID0gMDsNCiAgICAg
aW50IGVycm9yID0gMDsNCi0gICAgaW50IHJldCA9IDA7DQogICAgIGludDY0X3QgbiA9IDA7IC8q
IGJ5dGVzICovDQoNCiAgICAgaWYgKGJzID09IHMtPmJvdHRvbSkgew0KQEAgLTEzOSw2ICsxMzgs
NyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBzdHJlYW1fcnVuKEpvYiAqam9iLCBFcnJvciAq
KmVycnApDQoNCiAgICAgZm9yICggOyBvZmZzZXQgPCBsZW47IG9mZnNldCArPSBuKSB7DQogICAg
ICAgICBib29sIGNvcHk7DQorICAgICAgICBpbnQgcmV0Ow0KDQogICAgICAgICAvKiBOb3RlIHRo
YXQgZXZlbiB3aGVuIG5vIHJhdGUgbGltaXQgaXMgYXBwbGllZCB3ZSBuZWVkIHRvIHlpZWxkDQog
ICAgICAgICAgKiB3aXRoIG5vIHBlbmRpbmcgSS9PIGhlcmUgc28gdGhhdCBiZHJ2X2RyYWluX2Fs
bCgpIHJldHVybnMuDQpAQCAtMTgzLDcgKzE4Myw2IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2Zu
IHN0cmVhbV9ydW4oSm9iICpqb2IsIEVycm9yICoqZXJycCkNCiAgICAgICAgICAgICAgICAgYnJl
YWs7DQogICAgICAgICAgICAgfQ0KICAgICAgICAgfQ0KLSAgICAgICAgcmV0ID0gMDsNCg0KICAg
ICAgICAgLyogUHVibGlzaCBwcm9ncmVzcyAqLw0KICAgICAgICAgam9iX3Byb2dyZXNzX3VwZGF0
ZSgmcy0+Y29tbW9uLmpvYiwgbik7DQoNCj4NCj5XaXRoIG9yIHdpdGhvdXQgdGhlIGNoYW5nZXM6
DQo+DQo+UmV2aWV3ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQoNCg==

