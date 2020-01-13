Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38848C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B28B214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B28B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzWg-0002CE-5t
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iqzVl-0001dF-Ge
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iqzVj-0001nG-UY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:12:05 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2059 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iqzVg-0001fF-Hb; Mon, 13 Jan 2020 08:12:00 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id B463715E12985488EBCC;
 Mon, 13 Jan 2020 13:11:53 +0000 (GMT)
Received: from lhreml707-chm.china.huawei.com (10.201.108.56) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 13 Jan 2020 13:11:53 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 13 Jan 2020 13:11:53 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 13 Jan 2020 13:11:53 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Index: AQHVeswdQv2zL2ZjnU2+5S1CywnCCKdgnucAgAYn2ECANV3CUIAANK6AgAADjLCAARyUgIADW0wAgBGftACAAodbgIADcKzggCX7GsCABMMOAIAGBKlA
Date: Mon, 13 Jan 2020 13:11:53 +0000
Message-ID: <5db1e82970fc4e82a32e9ede4d8d40d0@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
 <20191125164541.3f0a593f@redhat.com>
 <444efcb441fe42e5aff58b3af3ab14b4@huawei.com>
 <20191126095655.27227f59@redhat.com>
 <c2bb0be09e244ee59d27c7aaab1783a9@huawei.com>
 <20191211085727.1ab9564e@redhat.com>
 <8562f82b7c0140d3ad0c7f6616cb6f28@huawei.com>
 <20200109181300.00238828@redhat.com>
In-Reply-To: <20200109181300.00238828@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
 "drjones@redhat.com" <drjones@redhat.com>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1kZXZlbA0KPiBb
bWFpbHRvOnFlbXUtZGV2ZWwtYm91bmNlcytzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpPWh1YXdl
aS5jb21Abm9uZ24NCj4gdS5vcmddIE9uIEJlaGFsZiBPZiBJZ29yIE1hbW1lZG92DQo+IFNlbnQ6
IDA5IEphbnVhcnkgMjAyMCAxNzoxMw0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8
c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnOyBkcmpvbmVzQHJlZGhhdC5jb207DQo+IHhpYW9ndWFuZ3JvbmcuZXJpY0Bn
bWFpbC5jb207IEF1Z2VyIEVyaWMgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47DQo+IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBzaGFubm9u
LnpoYW9zbEBnbWFpbC5jb207IHFlbXUtYXJtQG5vbmdudS5vcmc7IHh1d2VpIChPKQ0KPiA8eHV3
ZWk1QGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+OyBsZXJzZWtAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNV0g
QVJNIHZpcnQ6IEFkZCBOVkRJTU0gc3VwcG9ydA0KPiANCj4gT24gTW9uLCA2IEphbiAyMDIwIDE3
OjA2OjMyICswMDAwDQo+IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhpIElnb3IsDQoNClsuLi5d
DQoNCj4gPiAoK0pvbmF0aGFuKQ0KPiA+DQo+ID4gVGhhbmtzIHRvIEpvbmF0aGFuIGZvciB0YWtp
bmcgYSBmcmVzaCBsb29rIGF0IHRoaXMgaXNzdWUgYW5kIHNwb3R0aW5nIHRoaXMsDQo+ID4NCj4g
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuNS1yYzUvc291cmNlL2RyaXZlcnMv
YWNwaS9hY3BpY2EvdXRtaXNjLmMjTA0KPiAxMDkNCj4gPg0KPiA+IEFuZCwgZnJvbSBBQ1BJIDYu
MywgdGFibGUgMTktNDE5DQo+ID4NCj4gPiAiSWYgdGhlIEJ1ZmZlciBGaWVsZCBpcyBzbWFsbGVy
IHRoYW4gb3IgZXF1YWwgdG8gdGhlIHNpemUgb2YgYW4gSW50ZWdlciAoaW4gYml0cyksIGl0DQo+
ID4gd2lsbCBiZSB0cmVhdGVkIGFzIGFuIEludGVnZXIuIE90aGVyd2lzZSwgaXQgd2lsbCBiZSB0
cmVhdGVkIGFzIGEgQnVmZmVyLiBUaGUNCj4gc2l6ZQ0KPiA+IG9mIGFuIEludGVnZXIgaXMgaW5k
aWNhdGVkIGJ5IHRoZSBEZWZpbml0aW9uIEJsb2NrIHRhYmxlIGhlYWRlcidzIFJldmlzaW9uIGZp
ZWxkLg0KPiA+IEEgUmV2aXNpb24gZmllbGQgdmFsdWUgbGVzcyB0aGFuIDIgaW5kaWNhdGVzIHRo
YXQgdGhlIHNpemUgb2YgYW4gSW50ZWdlciBpcyAzMg0KPiBiaXRzLg0KPiA+IEEgdmFsdWUgZ3Jl
YXRlciB0aGFuIG9yIGVxdWFsIHRvIDIgc2lnbmlmaWVzIHRoYXQgdGhlIHNpemUgb2YgYW4gSW50
ZWdlciBpcyA2NA0KPiBiaXRzLiINCj4gPg0KPiA+IEl0IGxvb2tzIGxpa2UgdGhlIG1haW4gcmVh
c29uIGZvciB0aGUgZGlmZmVyZW5jZSBpbiBiZWhhdmlvciBvZiB0aGUgYnVmZmVyIG9iamVjdA0K
PiA+IHNpemUgYmV0d2VlbiB4ODYgYW5kIEFSTS92aXJ0LCBpcyBiZWNhdXNlIG9mIHRoZSBSZXZp
c2lvbiBudW1iZXIgdXNlZCBpbg0KPiB0aGUNCj4gPiBEU0RUIHRhYmxlLiBPbiB4ODYgaXQgaXMg
MSBhbmQgQVJNL3ZpcnQgaXQgaXMgMi4NCj4gPg0KPiA+IFNvIG1vc3QgbGlrZWx5LA0KPiA+DQo+
ID4gPiAgICAgQ3JlYXRlRmllbGQgKE9EQVQsIFplcm8sIExvY2FsMSwgT0JVRikNCj4gDQo+IFlv
dSBhcmUgcmlnaHQsIHRoYXQncyB3aGVyZSBpdCBnb2VzIHdyb25nLCBzaW5jZSBPQlVGDQo+IGlz
IGltcGxpY2l0bHkgY29udmVydGVkIHRvIGludGVnZXIgaWYgc2l6ZSBpcyBsZXNzIHRoYW4gNjRi
aXRzLg0KPiANCj4gPiA+ICAgICBDb25jYXRlbmF0ZSAoQnVmZmVyIChaZXJvKXt9LCBPQlVGLCBM
b2NhbDcpDQo+IA0KPiBzZWUgbW9yZSBiZWxvdw0KPiANCj4gWy4uLl0NCj4gDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvaHcvYWNwaS9udmRpbW0uYyBiL2h3L2FjcGkvbnZkaW1tLmMNCj4gPiBpbmRl
eCA2NGVhY2ZhZDA4Li42MjFmOWZmZDQxIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FjcGkvbnZkaW1t
LmMNCj4gPiArKysgYi9ody9hY3BpL252ZGltbS5jDQo+ID4gQEAgLTExOTIsMTUgKzExOTIsMTgg
QEAgc3RhdGljIHZvaWQgbnZkaW1tX2J1aWxkX2ZpdChBbWwgKmRldikNCj4gPiDCoCDCoCDCoGFt
bF9hcHBlbmQobWV0aG9kLCBpZmN0eCk7DQo+ID4NCj4gPiDCoCDCoCDCoGFtbF9hcHBlbmQobWV0
aG9kLCBhbWxfc3RvcmUoYW1sX3NpemVvZihidWYpLCBidWZfc2l6ZSkpOw0KPiA+IC0gwqAgwqBh
bWxfYXBwZW5kKG1ldGhvZCwgYW1sX3N1YnRyYWN0KGJ1Zl9zaXplLA0KPiA+IC0gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhbWxfaW50KDQpIC8q
IHRoZSBzaXplIG9mDQo+ICJTVEFVIiAqLywNCj4gPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnVmX3NpemUpKTsNCj4gPg0KPiA+IMKgIMKg
IMKgLyogaWYgd2UgcmVhZCB0aGUgZW5kIG9mIGZpdC4gKi8NCj4gPiAtIMKgIMKgaWZjdHggPSBh
bWxfaWYoYW1sX2VxdWFsKGJ1Zl9zaXplLCBhbWxfaW50KDApKSk7DQo+ID4gKyDCoCDCoGlmY3R4
ID0gYW1sX2lmKGFtbF9lcXVhbChhbWxfc3VidHJhY3QoYnVmX3NpemUsDQo+ID4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhbWxfc2l6ZW9mKGFtbF9pbnQoMCkp
LCBOVUxMKSwNCj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGFtbF9pbnQoMCkpKTsNCj4gPiDCoCDCoCDCoGFtbF9hcHBlbmQoaWZjdHgsIGFtbF9yZXR1cm4o
YW1sX2J1ZmZlcigwLCBOVUxMKSkpOw0KPiA+IMKgIMKgIMKgYW1sX2FwcGVuZChtZXRob2QsIGlm
Y3R4KTsNCj4gPg0KPiA+ICsgwqAgwqBhbWxfYXBwZW5kKG1ldGhvZCwgYW1sX3N1YnRyYWN0KGJ1
Zl9zaXplLA0KPiA+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBhbWxfaW50KDQpIC8qIHRoZSBzaXplIG9mDQo+ICJTVEFVIiAqLywNCj4gPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnVm
X3NpemUpKTsNCj4gPiArDQo+ID4gwqAgwqAgwqBhbWxfYXBwZW5kKG1ldGhvZCwgYW1sX2NyZWF0
ZV9maWVsZChidWYsDQo+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBhbWxfaW50KDQgKiBCSVRTX1BFUl9CWVRFKSwgLyogb2Zmc2V0DQo+IGF0IGJ5dGUgNC4q
Lw0KPiA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYW1sX3No
aWZ0bGVmdChidWZfc2l6ZSwgYW1sX2ludCgzKSksDQo+ICJCVUZGIikpOw0KPiANCj4gSW5zdGVh
ZCBvZiBjb3ZlcmluZyB1cCBlcnJvciBpbiBOQ0FMLCBJJ2QgcHJlZmVyIG9yaWdpbmFsIGlzc3Vl
IGZpeGVkLg0KPiBIb3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcyBwc2V1ZG9jb2RlOg0KPiAN
Cj4gICAgICAgICAgICAgICAgIE5URkkgPSBMb2NhbDYNCj4gICAgICAgICAgICAgICAgIExvY2Fs
MSA9IChSTEVOIC0gMHgwNCkNCj4gLSAgICAgICAgICAgICAgICBMb2NhbDEgPSAoTG9jYWwxIDw8
IDB4MDMpDQo+IC0gICAgICAgICAgICAgICAgQ3JlYXRlRmllbGQgKE9EQVQsIFplcm8sIExvY2Fs
MSwgT0JVRikNCj4gLSAgICAgICAgICAgICAgICBDb25jYXRlbmF0ZSAoQnVmZmVyIChaZXJvKSB7
fSwgT0JVRiwgTG9jYWw3KQ0KPiANCj4gICAgICAgICAgICAgICAgIElmIChMb2NhbDEgPCBJbnRl
Z2VyU2l6ZSkNCj4gICAgICAgICAgICAgICAgIHsNCj4gICAgICAgICAgICAgICAgICAgICBMb2Nh
bDcgPSBCdWZmZXIoMCkgLy8gb3V0cHV0IGJ1ZmZlcg0KPiAgICAgICAgICAgICAgICAgICAgIExv
Y2FsOCA9IDAgLy8gaW5kZXggZm9yIGJlaW5nIGNvcGllZCBieXRlDQo+ICAgICAgICAgICAgICAg
ICAgICAgLy8gYnVpbGQgYnl0ZSBieSBieXRlIG91dHB1dCBidWZmZXINCj4gICAgICAgICAgICAg
ICAgICAgICB3aGlsZSAoTG9jYWw4IDwgTG9jYWwxKSB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgTG9jYWw5ID0gQnVmZmVyKDEpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgLy8gY29weSAx
IGJ5dGUgYXQgTG9jYWw4IG9mZnNldCBmcm9tIE9EQVQgdG8NCj4gdGVtcG9yYXJ5IGJ1ZmZlciBM
b2NhbDkNCj4gICAgICAgICAgICAgICAgICAgICAgICBTdG9yZShEZVJlZihJbmRleChPREFULCBM
b2NhbDgpKSwgSW5kZXgoTG9jYWw5LA0KPiAwKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICBD
b25jYXRlbmF0ZSAoTG9jYWw3LCBMb2NhbDksIExvY2FsNykNCj4gICAgICAgICAgICAgICAgICAg
ICAgICBJbmNyZW1lbnQoTG9jYWw4KQ0KPiAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gTG9jYWw3DQo+ICAgICAgICAgICAgICAgICB9IGVsc2Ugew0K
PiAgICAgICAgICAgICAgICAgICAgIENyZWF0ZUZpZWxkIChPREFULCBaZXJvLCBMb2NhbDEsIE9C
VUYpDQo+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE9CVUYNCj4gICAgICAgICAgICAgICAg
IH0NCj4gDQoNCk9rLiBUaGlzIGxvb2tzIG11Y2ggYmV0dGVyLiBJIHdpbGwgdGVzdCB0aGlzIGFu
ZCBzZW50IG91dCBhIHYyIHNvb24gYWRkcmVzc2luZyBvdGhlcg0KY29tbWVudHMgb24gdGhpcyBz
ZXJpZXMgYXMgd2VsbC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

