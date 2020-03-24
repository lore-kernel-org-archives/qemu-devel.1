Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D877CC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF1C20719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF1C20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47971 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGidq-0003Aj-TL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGia3-0006vC-N9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGia2-0000Js-9q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:22:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2513 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jGia1-0000IX-Td; Tue, 24 Mar 2020 08:22:50 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id B8600CFE2B2CD2F35A43;
 Tue, 24 Mar 2020 20:22:43 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0487.000;
 Tue, 24 Mar 2020 20:22:37 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v4 3/3] timer/exynos4210_mct: Remove redundant statement
 in exynos4210_mct_write()
Thread-Topic: [PATCH v4 3/3] timer/exynos4210_mct: Remove redundant
 statement in exynos4210_mct_write()
Thread-Index: AQHWAbVx4EDwTTiLjUyFR/2shcgJzKhXDQGAgACVgIA=
Date: Tue, 24 Mar 2020 12:22:37 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6BF788@dggemm511-mbx.china.huawei.com>
References: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
 <20200324082235.27980-4-kuhn.chenqun@huawei.com>
 <b1e4dbf2-842a-dedd-819e-4f2b272dcfb9@vivier.eu>
In-Reply-To: <b1e4dbf2-842a-dedd-819e-4f2b272dcfb9@vivier.eu>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAyNCwgMjAyMCA2OjU5
IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsNCj5xZW11LXRyaXZpYWxAbm9uZ251Lm9yZw0KPkNjOiBaaGFuZ2hh
aWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBwaGlsbWRAcmVkaGF0LmNv
bTsNCj5FdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IElnb3IgTWl0c3lhbmtv
DQo+PGkubWl0c3lhbmtvQGdtYWlsLmNvbT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvM10gdGltZXIvZXh5bm9zNDIx
MF9tY3Q6IFJlbW92ZSByZWR1bmRhbnQNCj5zdGF0ZW1lbnQgaW4gZXh5bm9zNDIxMF9tY3Rfd3Jp
dGUoKQ0KPg0KPkxlIDI0LzAzLzIwMjAgw6AgMDk6MjIsIENoZW4gUXVuIGEgw6ljcml0wqA6DQo+
PiBDbGFuZyBzdGF0aWMgY29kZSBhbmFseXplciBzaG93IHdhcm5pbmc6DQo+PiBody90aW1lci9l
eHlub3M0MjEwX21jdC5jOjEzNzA6OTogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdpbmRleCcg
aXMgbmV2ZXINCj5yZWFkDQo+PiAgICAgICAgIGluZGV4ID0gR0VUX0xfVElNRVJfQ05UX1JFR19J
RFgob2Zmc2V0LCBsdF9pKTsNCj4+ICAgICAgICAgXiAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBody90aW1lci9leHlub3M0MjEwX21jdC5jOjEzOTk6OTog
d2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdpbmRleCcgaXMgbmV2ZXINCj5yZWFkDQo+PiAgICAg
ICAgIGluZGV4ID0gR0VUX0xfVElNRVJfQ05UX1JFR19JRFgob2Zmc2V0LCBsdF9pKTsNCj4+ICAg
ICAgICAgXiAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBo
dy90aW1lci9leHlub3M0MjEwX21jdC5jOjE0NDE6OTogd2FybmluZzogVmFsdWUgc3RvcmVkIHRv
ICdpbmRleCcgaXMgbmV2ZXINCj5yZWFkDQo+PiAgICAgICAgIGluZGV4ID0gR0VUX0xfVElNRVJf
Q05UX1JFR19JRFgob2Zmc2V0LCBsdF9pKTsNCj4+ICAgICAgICAgXiAgICAgICB+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+DQo+SXQgd291bGQgYmUgaW50ZXJlc3Rpbmcg
dG8gdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCB0aGUgaW5kZXggZm9yIHRoZXNlIHJlZ2lzdGVycw0K
PmluIGV4eW5vczQyMTBfbWN0X3JlYWQoKSBhbmQgbm90IGluIGV4eW5vczQyMTBfbWN0X3dyaXRl
KCkuDQo+DQpJIHRoaW5rIHRoZSBpbmRleCBjYW4gYWxzbyBiZSB1c2VkIGluIGV4eW5vczQyMTBf
bWN0X3dyaXRlKCksIGJ1dCB0aGUgb3JpZ2luYWwgYXV0aG9yIHVzZWQgYSBtb3JlIG9idmlvdXMg
cmVnIG5hbWUgaW5zdGVhZCBvZiBpdC4NCg0KVGhlIG9idmlvdXMgcmVnIG5hbWU6DQpjYXNlIEww
X1RDTlRCOiBjYXNlIEwxX1RDTlRCOg0KICAgICAgICAgICByZWcgbmFtZSBpcyA6ICBMX1JFR19D
TlRfVENOVEIgDQoNCmNhc2UgTDBfSUNOVEI6IGNhc2UgTDFfSUNOVEI6DQogICAgICAgICAgIHJl
ZyBuYW1lIGlzIDogICBMX1JFR19DTlRfSUNOVEINCg0KY2FzZSBMMF9GUkNOVEI6IGNhc2UgTDFf
RlJDTlRCOg0KICAgICAgICAgICByZWcgbmFtZSBpcyA6ICAgTF9SRUdfQ05UX0ZSQ0NOVEINCg0K
VGhhbmtzLg0KPg0KPj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3
ZWkuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3ZWku
Y29tPg0KPj4gLS0tDQo+PiBDYzogSWdvciBNaXRzeWFua28gPGkubWl0c3lhbmtvQGdtYWlsLmNv
bT4NCj4+IENjOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+PiAt
LS0NCj4+ICBody90aW1lci9leHlub3M0MjEwX21jdC5jIHwgNCAtLS0tDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3RpbWVyL2V4eW5v
czQyMTBfbWN0LmMgYi9ody90aW1lci9leHlub3M0MjEwX21jdC5jDQo+PiBpbmRleCA5NDQxMjBh
ZWE1Li41NzBjZjcwNzViIDEwMDY0NA0KPj4gLS0tIGEvaHcvdGltZXIvZXh5bm9zNDIxMF9tY3Qu
Yw0KPj4gKysrIGIvaHcvdGltZXIvZXh5bm9zNDIxMF9tY3QuYw0KPj4gQEAgLTEzNjcsNyArMTM2
Nyw2IEBAIHN0YXRpYyB2b2lkIGV4eW5vczQyMTBfbWN0X3dyaXRlKHZvaWQgKm9wYXF1ZSwNCj4+
IGh3YWRkciBvZmZzZXQsDQo+Pg0KPj4gICAgICBjYXNlIEwwX1RDTlRCOiBjYXNlIEwxX1RDTlRC
Og0KPj4gICAgICAgICAgbHRfaSA9IEdFVF9MX1RJTUVSX0lEWChvZmZzZXQpOw0KPj4gLSAgICAg
ICAgaW5kZXggPSBHRVRfTF9USU1FUl9DTlRfUkVHX0lEWChvZmZzZXQsIGx0X2kpOw0KPj4NCj4+
ICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgKiBUQ05UQiBpcyB1cGRhdGVkIHRvIGludGVybmFs
IHJlZ2lzdGVyIG9ubHkgYWZ0ZXIgQ05UIGV4cGlyZWQuDQo+PiBAQCAtMTM5Niw3ICsxMzk1LDYg
QEAgc3RhdGljIHZvaWQgZXh5bm9zNDIxMF9tY3Rfd3JpdGUodm9pZCAqb3BhcXVlLA0KPj4gaHdh
ZGRyIG9mZnNldCwNCj4+DQo+PiAgICAgIGNhc2UgTDBfSUNOVEI6IGNhc2UgTDFfSUNOVEI6DQo+
PiAgICAgICAgICBsdF9pID0gR0VUX0xfVElNRVJfSURYKG9mZnNldCk7DQo+PiAtICAgICAgICBp
bmRleCA9IEdFVF9MX1RJTUVSX0NOVF9SRUdfSURYKG9mZnNldCwgbHRfaSk7DQo+Pg0KPj4gICAg
ICAgICAgcy0+bF90aW1lcltsdF9pXS5yZWcud3N0YXQgfD0gTF9XU1RBVF9JQ05UQl9XUklURTsN
Cj4+ICAgICAgICAgIHMtPmxfdGltZXJbbHRfaV0ucmVnLmNudFtMX1JFR19DTlRfSUNOVEJdID0g
dmFsdWUgJiBAQA0KPj4gLTE0MzgsOCArMTQzNiw2IEBAIHN0YXRpYyB2b2lkIGV4eW5vczQyMTBf
bWN0X3dyaXRlKHZvaWQgKm9wYXF1ZSwNCj4+IGh3YWRkciBvZmZzZXQsDQo+Pg0KPj4gICAgICBj
YXNlIEwwX0ZSQ05UQjogY2FzZSBMMV9GUkNOVEI6DQo+PiAgICAgICAgICBsdF9pID0gR0VUX0xf
VElNRVJfSURYKG9mZnNldCk7DQo+PiAtICAgICAgICBpbmRleCA9IEdFVF9MX1RJTUVSX0NOVF9S
RUdfSURYKG9mZnNldCwgbHRfaSk7DQo+PiAtDQo+PiAgICAgICAgICBEUFJJTlRGKCJsb2NhbCB0
aW1lclslZF0gRlJDTlRCIHdyaXRlICVsbHhcbiIsIGx0X2ksIHZhbHVlKTsNCj4+DQo+PiAgICAg
ICAgICBzLT5sX3RpbWVyW2x0X2ldLnJlZy53c3RhdCB8PSBMX1dTVEFUX0ZSQ0NOVEJfV1JJVEU7
DQo+Pg0KDQo=

