Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA335C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964E12077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964E12077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2xp-0005an-MI
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jH2wG-0003LY-Od
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jH2wF-0007S8-IH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:07:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2514 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jH2wF-0007NQ-72; Wed, 25 Mar 2020 06:07:07 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id DF311A1E6AA37241058B;
 Wed, 25 Mar 2020 18:07:01 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Wed, 25 Mar 2020 18:06:52 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 3/3] crypto: Redundant type conversion for AES_KEY pointer
Thread-Topic: [PATCH 3/3] crypto: Redundant type conversion for AES_KEY pointer
Thread-Index: AQHWAoba7fbUDZCqgEW/3PLwSBDmBahYiQSAgACKuMA=
Date: Wed, 25 Mar 2020 10:06:51 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6C24A6@dggemm511-mbx.china.huawei.com>
References: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
 <20200325092137.24020-4-kuhn.chenqun@huawei.com>
 <f57b72eb-fdf8-b811-64d1-04d95a15f6e6@vivier.eu>
In-Reply-To: <f57b72eb-fdf8-b811-64d1-04d95a15f6e6@vivier.eu>
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBXZWRuZXNkYXksIE1hcmNoIDI1LCAyMDIwIDU6
NDUgUE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsgcWVt
dS1kZXZlbEBub25nbnUub3JnOw0KPnFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Q2M6IFpoYW5n
aGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IEV1bGVyIFJvYm90DQo+
PGV1bGVyLnJvYm90QGh1YXdlaS5jb20+OyBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUBy
ZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBjcnlwdG86IFJlZHVuZGFudCB0
eXBlIGNvbnZlcnNpb24gZm9yIEFFU19LRVkgcG9pbnRlcg0KPg0KPkxlIDI1LzAzLzIwMjAgw6Ag
MTA6MjEsIENoZW4gUXVuIGEgw6ljcml0wqA6DQo+PiBGaXg6IGVhZWM5MDNjNWI4DQo+Pg0KPg0K
PkRpZCB5b3UgcnVuIHRoZSBjb2NjaW5lbGxlIHNjcmlwdCBzY3JpcHRzL2NvY2NpbmVsbGUvdHlw
ZWNhc3QuY29jY2kgPw0KPg0KWWVzLCBJIHJ1biBpdCBhbmQgcGxhbiB0byBpbnRlZ3JhdGUgaXQg
aW50byBFdWxlclJvYm90IHNvIHRoYXQgc2ltaWxhciBpc3N1ZXMgY2FuIGJlIGRpc2NvdmVyZWQg
c29vbmVyLg0KDQpUaGFua3MuDQo+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVy
LnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVu
cXVuQGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+IENjOiAiRGFuaWVsIFAuIEJlcnJhbmfDqSIgPGJl
cnJhbmdlQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICBjcnlwdG8vY2lwaGVyLWJ1aWx0aW4uYyB8
IDYgKystLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2NpcGhlci1idWlsdGluLmMgYi9jcnlw
dG8vY2lwaGVyLWJ1aWx0aW4uYyBpbmRleA0KPj4gYmY4NDEzZTcxYS4uOTlkNjI4MGExNiAxMDA2
NDQNCj4+IC0tLSBhL2NyeXB0by9jaXBoZXItYnVpbHRpbi5jDQo+PiArKysgYi9jcnlwdG8vY2lw
aGVyLWJ1aWx0aW4uYw0KPj4gQEAgLTEzMyw4ICsxMzMsNyBAQCBzdGF0aWMgdm9pZCBxY3J5cHRv
X2NpcGhlcl9hZXNfeHRzX2VuY3J5cHQoY29uc3QNCj4+IHZvaWQgKmN0eCwgIHsNCj4+ICAgICAg
Y29uc3QgUUNyeXB0b0NpcGhlckJ1aWx0aW5BRVNDb250ZXh0ICphZXNjdHggPSBjdHg7DQo+Pg0K
Pj4gLSAgICBxY3J5cHRvX2NpcGhlcl9hZXNfZWNiX2VuY3J5cHQoKEFFU19LRVkgKikmYWVzY3R4
LT5lbmMsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcmMsIGRzdCwg
bGVuZ3RoKTsNCj4+ICsgICAgcWNyeXB0b19jaXBoZXJfYWVzX2VjYl9lbmNyeXB0KCZhZXNjdHgt
PmVuYywgc3JjLCBkc3QsIGxlbmd0aCk7DQo+PiAgfQ0KPj4NCj4+DQo+PiBAQCAtMTQ1LDggKzE0
NCw3IEBAIHN0YXRpYyB2b2lkIHFjcnlwdG9fY2lwaGVyX2Flc194dHNfZGVjcnlwdChjb25zdA0K
Pj4gdm9pZCAqY3R4LCAgew0KPj4gICAgICBjb25zdCBRQ3J5cHRvQ2lwaGVyQnVpbHRpbkFFU0Nv
bnRleHQgKmFlc2N0eCA9IGN0eDsNCj4+DQo+PiAtICAgIHFjcnlwdG9fY2lwaGVyX2Flc19lY2Jf
ZGVjcnlwdCgoQUVTX0tFWSAqKSZhZXNjdHgtPmRlYywNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNyYywgZHN0LCBsZW5ndGgpOw0KPj4gKyAgICBxY3J5cHRvX2NpcGhl
cl9hZXNfZWNiX2RlY3J5cHQoJmFlc2N0eC0+ZGVjLCBzcmMsIGRzdCwgbGVuZ3RoKTsNCj4+ICB9
DQo+Pg0KPj4NCj4+DQoNCg==

