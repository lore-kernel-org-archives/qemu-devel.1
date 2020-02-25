Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADCBC35E03
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B1A21D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B1A21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zf6-0001PR-5r
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j6Z4Z-0002rJ-9r
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j6Z4V-0006Ch-Om
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:12:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2503 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j6Z4V-00062Y-CL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:12:19 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 4F197C2714814973EF23;
 Tue, 25 Feb 2020 20:12:13 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 20:12:12 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 25 Feb 2020 20:12:13 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 20:12:12 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>
Subject: RE: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Topic: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Index: AQHV634DptZMLVW0EUqun9Ee8tGbGqgrJCyAgACsLcA=
Date: Tue, 25 Feb 2020 12:12:12 +0000
Message-ID: <c4aa08df40a74dbd876b9acfbbb09809@huawei.com>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
 <3086f4a2-fb0a-d276-7c76-f06474befa35@redhat.com>
In-Reply-To: <3086f4a2-fb0a-d276-7c76-f06474befa35@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.29]
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIFttYWlsdG86cGhpbG1kQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1
YXJ5IDI1LCAyMDIwIDU6NDggUE0NCj4gVG86IG1pYW95dWJvIDxtaWFveXVib0BodWF3ZWkuY29t
PjsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiBzaGFubm9uLnpoYW9zbEBnbWFpbC5jb20N
Cj4gQ2M6IGJlcnJhbmdlQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyBxZW11LWRldmVsQG5v
bmdudS5vcmc7DQo+IFhpZXhpYW5neW91IDx4aWV4aWFuZ3lvdUBodWF3ZWkuY29tPjsgaW1hbW1l
ZG9AcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvM10gYWNwaTpwY2ktZXhw
ZW5kZXItYnVzOiBBZGQgcHhiIHN1cHBvcnQgZm9yIGFybQ0KPiANCj4gT24gMi8yNS8yMCAyOjUw
IEFNLCBZdWJvIE1pYW8gd3JvdGU6DQo+ID4gRnJvbTogbWlhb3l1Ym8gPG1pYW95dWJvQGh1YXdl
aS5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHkgdmlydCBtYWNoaW5lIGlzIG5vdCBzdXBwb3J0ZWQg
YnkgcHhiLXBjaWUsIGFuZCBvbmx5IG9uZSBtYWluDQo+ID4gaG9zdCBicmlkZ2UgZGVzY3JpYmVk
IGluIEFDUEkgdGFibGVzLg0KPiA+IEluIHRoaXMgcGF0Y2gsUFhCLVBDSUUgaXMgc3VwcHJvdGVk
IGJ5IGFybSBhbmQgY2VydGFpbg0KPiANCj4gVHlwb3M6ICJleHBhbmRlciIgaW4gc3ViamVjdCBh
bmQgInN1cHBvcnRlZCIgaGVyZS4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSBhbmQgc29y
cnkgZm9yIHRoZSBtaXN0YWtlcy4NCkkgd2lsbCBjaGVjayBhbGwgdGhlIHN1YmplY3RzIGFuZCBj
b21tZW50cy4NCg0KPiA+IHJlc291cmNlIGlzIGFsbG9jYXRlZCBmb3IgZWFjaCBweGItcGNpZSBp
biBhY3BpIHRhYmxlLg0KPiA+IFRoZSByZXNvdXJjZSBmb3IgdGhlIG1haW4gaG9zdCBicmlkZ2Ug
aXMgYWxzbyByZWFsbG9jYXRlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IG1pYW95dWJvIDxt
aWFveXVib0BodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3ZpcnQtYWNwaS1idWls
ZC5jIHwgMTE1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+
ICAgaHcvYXJtL3ZpcnQuYyAgICAgICAgICAgIHwgICAzICsNCj4gPiAgIGluY2x1ZGUvaHcvYXJt
L3ZpcnQuaCAgICB8ICAgNyArKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTE4IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3ZpcnQt
YWNwaS1idWlsZC5jIGIvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jIGluZGV4DQo+ID4gMzdjMzQ3
NDhhNi4uYmUxOTg2YzYwZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdmlydC1hY3BpLWJ1aWxk
LmMNCj4gPiArKysgYi9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMNCj4gPiBAQCAtNDksNiArNDks
OCBAQA0KPiA+ICAgI2luY2x1ZGUgImt2bV9hcm0uaCINCj4gPiAgICNpbmNsdWRlICJtaWdyYXRp
b24vdm1zdGF0ZS5oIg0KPiA+DQo+ID4gKyNpbmNsdWRlICJody9hcm0vdmlydC5oIg0KPiA+ICsj
aW5jbHVkZSAiaHcvcGNpL3BjaV9idXMuaCINCj4gPiAgICNkZWZpbmUgQVJNX1NQSV9CQVNFIDMy
DQo+ID4NCj4gPiAgICAgICBpZiAodXNlX2hpZ2htZW0pIHsNCj4gPiAgICAgICAgICAgaHdhZGRy
IGJhc2VfbW1pb19oaWdoID0gbWVtbWFwW1ZJUlRfSElHSF9QQ0lFX01NSU9dLmJhc2U7DQo+IEBA
DQo+ID4gLTc0Niw3ICs4NDcsNyBAQCBidWlsZF9kc2R0KEdBcnJheSAqdGFibGVfZGF0YSwgQklP
U0xpbmtlciAqbGlua2VyLA0KPiBWaXJ0TWFjaGluZVN0YXRlICp2bXMpDQo+ID4gICAgICAgYWNw
aV9kc2R0X2FkZF92aXJ0aW8oc2NvcGUsICZtZW1tYXBbVklSVF9NTUlPXSwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgKGlycW1hcFtWSVJUX01NSU9dICsgQVJNX1NQSV9CQVNFKSwNCj4gTlVN
X1ZJUlRJT19UUkFOU1BPUlRTKTsNCj4gPiAgICAgICBhY3BpX2RzZHRfYWRkX3BjaShzY29wZSwg
bWVtbWFwLCAoaXJxbWFwW1ZJUlRfUENJRV0gKw0KPiBBUk1fU1BJX0JBU0UpLA0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgdm1zLT5oaWdobWVtLCB2bXMtPmhpZ2htZW1fZWNhbSk7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICB2bXMtPmhpZ2htZW0sIHZtcy0+aGlnaG1lbV9lY2FtLCB2
bXMpOw0KPiA+ICAgICAgIGlmICh2bXMtPmFjcGlfZGV2KSB7DQo+ID4gICAgICAgICAgIGJ1aWxk
X2dlZF9hbWwoc2NvcGUsICJcXF9TQi4iR0VEX0RFVklDRSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBIT1RQTFVHX0hBTkRMRVIodm1zLT5hY3BpX2RldiksIGRpZmYgLS1naXQNCj4gPiBh
L2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmlydC5jIGluZGV4IGY3ODhmZTI3ZDYuLjYzMTQ5Mjg2
NzEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3ZpcnQuYw0KPiA+ICsrKyBiL2h3L2FybS92aXJ0
LmMNCj4gPiBAQCAtMTI0Niw2ICsxMjQ2LDkgQEAgc3RhdGljIHZvaWQgY3JlYXRlX3BjaWUoVmly
dE1hY2hpbmVTdGF0ZSAqdm1zKQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHBjaSA9IFBD
SV9IT1NUX0JSSURHRShkZXYpOw0KPiA+ICsNCj4gPiArICAgIFZJUlRfTUFDSElORShxZGV2X2dl
dF9tYWNoaW5lKCkpLT5idXMgPSBwY2ktPmJ1czsNCj4gPiArDQo+ID4gICAgICAgaWYgKHBjaS0+
YnVzKSB7DQo+ID4gICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBuYl9uaWNzOyBpKyspIHsNCj4g
PiAgICAgICAgICAgICAgIE5JQ0luZm8gKm5kID0gJm5kX3RhYmxlW2ldOyBkaWZmIC0tZ2l0DQo+
ID4gYS9pbmNsdWRlL2h3L2FybS92aXJ0LmggYi9pbmNsdWRlL2h3L2FybS92aXJ0LmggaW5kZXgN
Cj4gPiA3MTUwOGJmNDBjLi45MGYxMGExZTQ2IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcv
YXJtL3ZpcnQuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL3ZpcnQuaA0KPiA+IEBAIC0xNDAs
NiArMTQwLDEzIEBAIHR5cGVkZWYgc3RydWN0IHsNCj4gPiAgICAgICBEZXZpY2VTdGF0ZSAqZ2lj
Ow0KPiA+ICAgICAgIERldmljZVN0YXRlICphY3BpX2RldjsNCj4gPiAgICAgICBOb3RpZmllciBw
b3dlcmRvd25fbm90aWZpZXI7DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogcG9pbnRlciB0byBk
ZXZpY2VzIGFuZCBvYmplY3RzDQo+ID4gKyAgICAgKiBWaWEgZ29pbmcgdGhyb3VnaCB0aGUgYnVz
LCBhbGwNCj4gPiArICAgICAqIHBjaSBkZXZpY2VzIGFuZCByZWxhdGVkIG9iamVjdGVzDQo+IA0K
PiBUeXBvICJvYmplY3RzIiwgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgY29tbWVudCB3ZWxs
Lg0KPiANCg0KU29ycnkgZm9yIGFueSBjb25mdXNpb24gY2F1c2VkICxJIHdpbGwgcmV3cml0ZSB0
aGUgY29tbWVudCANCi8qIHBvaW50IHRvIHRoZSByb290IGJ1cywgd2hpY2ggaXMgcGNpZS4wICov
DQpEb2VzIHRoaXMgY29tbWVudCBtYWtlIHNlbnNlPw0KDQo+ID4gKyAgICAgKiBjb3VsZCBiZSBn
YWluZWQuDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIFBDSUJ1cyAqYnVzOw0KPiA+ICAgfSBWaXJ0
TWFjaGluZVN0YXRlOw0KPiA+DQo+ID4gICAjZGVmaW5lIFZJUlRfRUNBTV9JRChoaWdoKSAoaGln
aCA/IFZJUlRfSElHSF9QQ0lFX0VDQU0gOg0KPiA+IFZJUlRfUENJRV9FQ0FNKQ0KPiA+DQoNClJl
Z2FyZHMsDQpNaWFvDQo=

