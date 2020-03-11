Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F080C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B5220873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B5220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvHA-00060f-2o
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBvAd-0003wT-Qt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBvAa-0007Pf-7Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:48:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2457 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBvAX-0007GO-6i; Wed, 11 Mar 2020 02:48:41 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 4E25B68315DBA7FFA642;
 Wed, 11 Mar 2020 14:48:37 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 14:48:37 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Wed, 11 Mar 2020 14:48:27 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
Thread-Topic: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
Thread-Index: AQHV9t0YSMWYddN3YEKvEzi9xBDShqhBZbEAgAGJB+A=
Date: Wed, 11 Mar 2020 06:48:27 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B684485@dggemm511-mbx.china.huawei.com>
References: <20200310130844.30076-1-kuhn.chenqun@huawei.com>
 <bccf78b8-4c63-1587-742c-2595fe78e632@vivier.eu>
In-Reply-To: <bccf78b8-4c63-1587-742c-2595fe78e632@vivier.eu>
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
Cc: Fam Zheng <fam@euphon.net>, Hannes Reinecke <hare@suse.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAxMCwgMjAyMCAxMTow
MSBQTQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11
LQ0KPmRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Q2M6IEZhbSBa
aGVuZyA8ZmFtQGV1cGhvbi5uZXQ+OyBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5jb20+Ow0K
PlpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IHFlbXUtYmxv
Y2tAbm9uZ251Lm9yZzsNCj5FdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IFBh
b2xvIEJvbnppbmkNCj48cGJvbnppbmlAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENI
XSBody9zY3NpL21lZ2FzYXM6Q2xlYW4gdXAgc29tZSByZWR1bmRhbnQgY29kZSBmaXgNCj5DbGFu
ZyB3YXJuaW5ncw0KPg0KPkxlIDEwLzAzLzIwMjAgw6AgMTQ6MDgsIENoZW4gUXVuIGEgw6ljcml0
wqA6DQo+PiBIZXJlIGFyZSBzb21lIHJlZHVuZGFudCBzdGF0ZW1lbnRzLCB3ZSBjYW4gY2xlYW4g
dGhlbSB1cC4NCj4+IENsYW5nIHN0YXRpYyBjb2RlIGFuYWx5emVyIHNob3cgd2FybmluZzoNCj4+
IGh3L3Njc2kvbWVnYXNhcy5jOjExNzU6MzI6IHdhcm5pbmc6IFZhbHVlIHN0b3JlZCB0byAnbWF4
X2xkX2Rpc2tzJyBkdXJpbmcNCj5pdHMgaW5pdGlhbGl6YXRpb24gaXMgbmV2ZXIgcmVhZA0KPj4g
ICAgIHVpbnQzMl90IG51bV9sZF9kaXNrcyA9IDAsIG1heF9sZF9kaXNrcyA9IHMtPmZ3X2x1bnM7
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+ICAgfn5+fn5+
fn5+fg0KPj4gaHcvc2NzaS9tZWdhc2FzLmM6MTE4Mzo5OiB3YXJuaW5nOiBWYWx1ZSBzdG9yZWQg
dG8gJ21heF9sZF9kaXNrcycgaXMgbmV2ZXINCj5yZWFkDQo+PiAgICAgICAgIG1heF9sZF9kaXNr
cyA9IDA7DQo+PiAgICAgICAgIF4gICAgICAgICAgICAgIH4NCj4NCj5UaGlzIGhhcyBiZWVuIGlu
dHJvZHVjZWQgYnk6DQo+DQo+ZDk3YWUzNjg0ODYzICgibWVnYXNhczogZml4dXAgTUZJX0RDTURf
TERfTElTVF9RVUVSWSIpDQo+DQo+QW5kIG1vZGlmaWVkIGJ5Og0KPg0KPmNvbW1pdCAzZjJjZDRk
ZDQ3NzE5NDk3NTQwZmIwZTBhYTA2MzVlMTI3ZjI4MzhmDQo+DQpZZXMsIHRoaXMgbW9kaWZpY2F0
aW9uIG1ha2VzIHRoZSBmaXJzdCBwaWVjZSBvZiBjb2RlKHRoZSBpZiBzdGF0ZW1lbnQgaW4gbWVn
YXNhcy5jOjExODMpICBsb29rIG1lYW5pbmdsZXNzIGFuZCByZXN1bHRpbmcgaW4gd2FybmluZy4N
Cg0KTWF5YmUgd2UgY2FuIG1ha2UgdGhpcyBwaWVjZSBjb2RlIGJldHRlciwgIGFsdGhvdWdoIG15
IG1vZGlmaWNhdGlvbiBpcyB3cm9uZy4NCg0KVGhhbmtzLg0KPkF1dGhvcjogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+DQo+RGF0ZTogICBXZWQgT2N0IDI5IDEzOjAwOjA3IDIwMTQgKzAx
MDANCj4NCj4gICAgbWVnYXNhczogZml4dXAgZGV2aWNlIG1hcHBpbmcNCj4NCj4gICAgTG9naWNh
bCBkcml2ZXMgY2FuIG9ubHkgYmUgYWRkcmVzc2VkIHdpdGggdGhlICd0YXJnZXRfaWQnIG51bWJl
cjsNCj4gICAgTFVOIG51bWJlcnMgY2Fubm90IGJlIHNlbGVjdGVkLg0KPiAgICBQaHlzaWNhbCBk
cml2ZXMgY2FuIGJlIHNlbGVjdGVkIHdpdGggYm90aCwgdGFyZ2V0IGFuZCBMVU4gaWQuDQo+DQo+
ICAgIFNvIHdlIHNob3VsZCBkaXNhbGxvdyBMVU4gbnVtYmVycyBub3QgZXF1YWwgdG8gMCB3aGVu
IGluDQo+ICAgIFJBSUQgbW9kZS4NCj4NCj4gICAgU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+DQo+ICAgIFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+IC4uLg0KPkBAIC0xMTQzLDEwICsxMTUyLDEzIEBAIHN0YXRpYyBp
bnQNCj5tZWdhc2FzX2RjbWRfbGRfbGlzdF9xdWVyeShNZWdhc2FzU3RhdGUgKnMsIE1lZ2FzYXND
bWQgKmNtZCkNCj4gICAgICAgICByZXR1cm4gTUZJX1NUQVRfSU5WQUxJRF9QQVJBTUVURVI7DQo+
ICAgICB9DQo+ICAgICBkY21kX3NpemUgPSBzaXplb2YodWludDMyX3QpICogMiArIDM7DQo+LQ0K
PisgICAgbWF4X2xkX2Rpc2tzID0gY21kLT5pb3Zfc2l6ZSAtIGRjbWRfc2l6ZTsNCj4gICAgIGlm
IChtZWdhc2FzX2lzX2pib2QocykpIHsNCj4gICAgICAgICBtYXhfbGRfZGlza3MgPSAwOw0KPiAg
ICAgfQ0KPisgICAgaWYgKG1heF9sZF9kaXNrcyA+IE1GSV9NQVhfTEQpIHsNCj4rICAgICAgICBt
YXhfbGRfZGlza3MgPSBNRklfTUFYX0xEOw0KPisgICAgfQ0KPiAgICAgUVRBSUxRX0ZPUkVBQ0go
a2lkLCAmcy0+YnVzLnFidXMuY2hpbGRyZW4sIHNpYmxpbmcpIHsNCj4gICAgICAgICBTQ1NJRGV2
aWNlICpzZGV2ID0gRE9fVVBDQVNUKFNDU0lEZXZpY2UsIHFkZXYsIGtpZC0+Y2hpbGQpOyAuLi4N
Cj4NCj4NCj5UaGFua3MsDQo+TGF1cmVudA0K

