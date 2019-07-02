Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BDC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56202064B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56202064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiIhB-0006hP-UN
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 09:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hiIgR-00068M-UV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hiIgQ-00070f-Le
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:18:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45421 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hiIgN-0006tD-UV; Tue, 02 Jul 2019 09:18:52 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 4BC19C7C349D8B87B5CC;
 Tue,  2 Jul 2019 14:18:42 +0100 (IST)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.40]) by
 lhreml707-cah.china.huawei.com ([10.201.108.48]) with mapi id 14.03.0415.000; 
 Tue, 2 Jul 2019 14:18:34 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug support
Thread-Index: AQHVK0/YlaWqd5FQK0O9lZ5h6q3gOqa3JSqAgAALJICAAAPJAIAAJJBA
Date: Tue, 2 Jul 2019 13:18:34 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F2CC2A2@lhreml524-mbb.china.huawei.com>
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
 <20190702130703.0e74cbe6@redhat.com>
 <CAFEAcA8PDNTQXD3cD3XG9wkc_QOLXUcw62-8AUjSC0g7qjti7g@mail.gmail.com>
 <0bcc011c-17ff-8bfd-1f0e-65c303272664@redhat.com>
In-Reply-To: <0bcc011c-17ff-8bfd-1f0e-65c303272664@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.51.227]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug
 support
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 Laszlo Ersek <lersek@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVnZXIgRXJpYyBbbWFp
bHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbV0NCj4gU2VudDogMDIgSnVseSAyMDE5IDEzOjAwDQo+
IFRvOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBJZ29yIE1hbW1l
ZG92DQo+IDxpbWFtbWVkb0ByZWRoYXQuY29tPg0KPiBDYzogU2hhbWVlcmFsaSBLb2xvdGh1bSBU
aG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gUUVNVSBEZXZl
bG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBxZW11LWFybQ0KPiA8cWVtdS1hcm1Abm9u
Z251Lm9yZz47IFNhbXVlbCBPcnRpeiA8c2FtZW9AbGludXguaW50ZWwuY29tPjsgQXJkDQo+IEJp
ZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+OyBMaW51eGFybSA8bGludXhhcm1A
aHVhd2VpLmNvbT47DQo+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBTaGFubm9uIFpo
YW8NCj4gPHNoYW5ub24uemhhb3NsQGdtYWlsLmNvbT47IHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5j
b207IExhc3psbyBFcnNlaw0KPiA8bGVyc2VrQHJlZGhhdC5jb20+OyBEci4gRGF2aWQgQWxhbiBH
aWxiZXJ0IDxkZ2lsYmVydEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxd
IFtQQVRDSCB2NiAwLzhdIEFSTSB2aXJ0OiBBQ1BJIG1lbW9yeSBob3RwbHVnDQo+IHN1cHBvcnQN
Cj4gDQo+IEhpIFBldGVyLA0KPiANCj4gT24gNy8yLzE5IDE6NDYgUE0sIFBldGVyIE1heWRlbGwg
d3JvdGU6DQo+ID4gT24gVHVlLCAyIEp1bCAyMDE5IGF0IDEyOjA3LCBJZ29yIE1hbW1lZG92IDxp
bWFtbWVkb0ByZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPj4NCj4gPj4gT24gVHVlLCAyNSBKdW4g
MjAxOSAxMzoxNDoxMyArMDEwMA0KPiA+PiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gVGhpcyBzZXJpZXMg
aXMgYW4gYXR0ZW1wdCB0byBwcm92aWRlIGRldmljZSBtZW1vcnkgaG90cGx1ZyBzdXBwb3J0DQo+
ID4+PiBvbiBBUk0gdmlydCBwbGF0Zm9ybS4gVGhpcyBpcyBiYXNlZCBvbiBFcmljJ3MgcmVjZW50
IHdvcmtzIGhlcmVbMV0NCj4gPj4+IGFuZCBjYXJyaWVzIHNvbWUgb2YgdGhlIHBjLWRpbW0gcmVs
YXRlZCBwYXRjaGVzIGRyb3BwZWQgZnJvbSBoaXMNCj4gPj4+IHNlcmllcy4NCj4gPj4+DQo+ID4+
PiBUaGUga2VybmVsIHN1cHBvcnQgZm9yIGFybTY0IG1lbW9yeSBob3QgYWRkIHdhcyBhZGRlZCBy
ZWNlbnRseSBieQ0KPiA+Pj4gUm9iaW4gYW5kIGhlbmNlIHRoZSBndWVzdCBrZXJuZWwgc2hvdWxk
IGJlID0+IDUuMC1yYzEuDQo+ID4+Pg0KPiA+Pj4gTlZESU0gc3VwcG9ydCBpcyBub3QgaW5jbHVk
ZWQgY3VycmVudGx5IGFzIHdlIHN0aWxsIGhhdmUgYW4gdW5yZXNvbHZlZA0KPiA+Pj4gaXNzdWUg
d2hpbGUgaG90IGFkZGluZyBOVkRJTU1bMl0uIEhvd2V2ZXIgTlZESU1NIGNvbGQgcGx1ZyBwYXRj
aGVzDQo+ID4+PiBjYW4gYmUgaW5jbHVkZWQsIGJ1dCBub3QgZG9uZSBmb3Igbm93LCBmb3Iga2Vl
cGluZyBpdCBzaW1wbGUuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBtYWtlcyB1c2Ugb2YgR0VEIGRldmlj
ZSB0byBzZW50IGhvdHBsdWcgQUNQSSBldmVudHMgdG8gdGhlDQo+ID4+PiBHdWVzdC4gR0VEIGNv
ZGUgaXMgYmFzZWQgb24gTmVtdS4gVGhhbmtzIHRvIHRoZSBlZmZvcnRzIG9mIFNhbXVlbCBhbmQN
Cj4gPj4+IFNlYmFzdGllbiB0byBhZGQgdGhlIGhhcmR3YXJlLXJlZHVjZWQgc3VwcG9ydCB0byBO
ZW11IHVzaW5nIEdFRA0KPiA+Pj4gZGV2aWNlWzNdLiAoUGxlYXNlIHNob3V0IGlmIEkgZ290IHRo
ZSBhdXRob3Ivc2lnbmVkLW9mZiB3cm9uZyBmb3INCj4gPj4+IHRob3NlIHBhdGNoZXMgb3IgbWlz
c2VkIGFueSBuYW1lcykuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBpcyBzYW5pdHkgdGVzdGVkIG9uIGEg
SGlTaWxpY29uIEFSTTY0IHBsYXRmb3JtIGFuZCBhcHByZWNpYXRlDQo+ID4+PiBhbnkgZnVydGhl
ciB0ZXN0aW5nLg0KPiA+Pg0KPiA+PiBUaGVyZSBhcmUgc2V2ZXJhbCB0aGluZ3MgSSdkIGZpeC9h
bWVuZCBidXQgaXQncyBub3RoaW5nIHRoYXQgY291bGRuJ3QNCj4gPj4gYmUgZG9uZSBvbiB0b3Ag
YXMgYnVnZml4ZXMgKEknbGwgY29tbWVudCBsYXRlciBvbiBzcGVjaWZpYyBpc3N1ZXMpLg0KPiA+
Pg0KPiA+PiBIb3dldmVyIGFzIGEgd2hvbGUgZnJvbSBBQ1BJIGFuZCBtZW1vcnkgaG90cGx1ZyBQ
T1Ygc2VyaWVzIGxvb2tzIG1vcmUNCj4gPj4gb3IgbGVzcyByZWFkeSBmb3IgbWVyZ2luZy4NCj4g
Pj4NCj4gPj4gSSd2ZSBhc2tlZCBFcmljIHRvIHRlc3QgbWlncmF0aW9uIChJJ20gcXVpdGUgbm90
IHN1cmUgYWJvdXQgdGhhdCBwYXJ0KSwNCj4gPj4gKENDZWQgRGF2aWQpc28gb24gY29uZGl0aW9u
IGl0IHdvcmtzOg0KPiA+Pg0KPiA+PiAgIFJldmlld2VkLWJ5OiBJZ29yIE1hbW1lZG92IDxpbWFt
bWVkb0ByZWRoYXQuY29tPg0KPiA+DQo+ID4gSWYgd2Ugd2FudCB0byBnZXQgdGhpcyBpbnRvIDQu
MSBJJ2xsIG5lZWQgc29tZWJvZHkgdG8gZG8gYSByZXNwaW4NCj4gPiB3aXRoIGFsbCB0aGUgcmVs
ZXZhbnQgZml4ZXMgcHJldHR5IHNvb24gKGllIHdpdGhpbiBhIGRheSBvciB0d28sDQo+ID4gYW5k
IHRoYXQgaXMgcHVzaGluZyBpdCBiZWNhdXNlIHJlYWxseSBpdCdzIG1pc3NlZCB0aGUgZnJlZXpl
DQo+ID4gZGVhZGxpbmUgYWxyZWFkeSkuIEl0IG1pZ2h0IGJlIGVhc2llciBqdXN0IHRvIGxldCBp
dCBnbyBpbnRvIDQuMg0KPiA+IGluc3RlYWQuLi4NCj4gDQo+IE9LIHNvIGFmdGVyIHRob3NlIGxh
dGUgYXR0ZW1wdHMgdG8gZ2V0IGl0IGluLCBJIGFncmVlIHdpdGggeW91LiBJZiBpdA0KPiBtaXNz
ZWQgdGhlIGRlYWRsaW5lIGFscmVhZHkgdGhlbiBsZXQncyBzdGljayB0byB0aGUgcHJvY2VzcyBh
bmQgdHJ5IHRvDQo+IGdldCB0aGlzIGp1c3QgYWZ0ZXIgNC4xLg0KPiANCj4gSSBoYXZlIGp1c3Qg
Y2hlY2tlZCBtaWdyYXRpb24gYW5kIGl0IGZhaWxzIGJldHdlZW4gYSBxZW11IDQuMSBhbmQgcWVt
dQ0KPiA0LjAgd2l0aA0KDQpUaGFua3MgRXJpYyBmb3IgdmVyaWZ5aW5nIHRoYXQuIEkgZGlkbuKA
mXQgYXR0ZW1wdCBtaWdyYXRpb24gdGVzdCB3aXRoIGRpZmZlcmVudA0KdmVyc2lvbnMuDQoNCj4g
InFlbXUtc3lzdGVtLWFhcmNoNjQ6IFVua25vd24gc2F2ZXZtIHNlY3Rpb24gb3IgaW5zdGFuY2Ug
J2FjcGktZ2VkJyAwLg0KPiBNYWtlIHN1cmUgdGhhdCB5b3VyIGN1cnJlbnQgVk0gc2V0dXAgbWF0
Y2hlcyB5b3VyIHNhdmVkIFZNIHNldHVwLA0KPiBpbmNsdWRpbmcgYW55IGhvdHBsdWdnZWQgZGV2
aWNlcw0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiBsb2FkIG9mIG1pZ3JhdGlvbiBmYWlsZWQ6IElu
dmFsaWQgYXJndW1lbnQiDQo+IA0KPiBzbyB3ZSB3b3VsZCBuZWVkIHRvIGhhdmUgYSBub19hY3Bp
X2RldiBjbGFzcyBmaWVsZCB0byBhdm9pZCB1c2luZyB0aGUNCj4gR0VEIGRldmljZSA8IDQuMSBJ
IHRoaW5rLg0KDQpPay4gDQoNCj4gDQo+ICsgdHJvdWJsZXMgd2l0aCB0aGUgRFNEVCByZWYgZmls
ZXMgLyBiaW9zLXRhYmxlcy10ZXN0LmMgdG8gYmUgZml4ZWQuDQoNCkkgYW0gb24gdHJhdmVsIGF0
IHRoZSBtb21lbnQgYW5kIG5vdCBpbiBhIHBvc2l0aW9uIHRvIHJlc3BpbiB0aGlzIHF1aWNrbHku
DQpTbyBhcyBzdWdnZXN0ZWQgYWJvdmUgd2lsbCB0YXJnZXQgNC4yIGlmIHRoYXTigJlzIGZpbmUu
DQoNClRoYW5rcywNClNoYW1lZXINCg0KIA0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCj4gPg0KPiA+
IHRoYW5rcw0KPiA+IC0tIFBNTQ0KPiA+DQo=

