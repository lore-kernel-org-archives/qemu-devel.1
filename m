Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1999C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1112083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1112083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2tJi-0003vk-Fl
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 04:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j2tIb-0003Sf-Op
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j2tIa-0000Dq-0R
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:59:41 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2438 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j2tIZ-0008Pd-Ky
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:59:39 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id A6E589FFF69A8FB6BA9F;
 Sat, 15 Feb 2020 16:59:29 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 15 Feb 2020 16:59:29 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 15 Feb 2020 16:59:29 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Sat, 15 Feb 2020 16:59:28 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Topic: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Index: AQHV4kI1fIh9lqS0F0yGLr3GCBTaKKgYntSAgAGsCpD//6x8gIAB/zXA
Date: Sat, 15 Feb 2020 08:59:28 +0000
Message-ID: <8f977fbdd8e346ef911ebfe71dbb1514@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
 <20200213135145.GN594756@redhat.com>
 <3fc86f5a6aaf4c6f81dad4f25fcafda0@huawei.com>
 <20200214102451.GA613610@redhat.com>
In-Reply-To: <20200214102451.GA613610@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.131.16]
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgW21haWx0bzpiZXJyYW5nZUByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5
IDE0LCAyMDIwIDY6MjUgUE0NCj4gVG86IG1pYW95dWJvIDxtaWFveXVib0BodWF3ZWkuY29tPg0K
PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBzaGFubm9uLnpoYW9zbEBnbWFpbC5jb207
DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgWGlleGlhbmd5
b3UNCj4gPHhpZXhpYW5neW91QGh1YXdlaS5jb20+OyBtc3RAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1JGQyAyLzJdIHBjaS1leHBlbmRlci1idXM6QWRkIHBjaWUtcm9vdC1wb3J0IHRvIHB4
Yi1wY2llIHVuZGVyDQo+IGFybS4NCj4gDQo+IE9uIEZyaSwgRmViIDE0LCAyMDIwIGF0IDA3OjI1
OjQzQU0gKzAwMDAsIG1pYW95dWJvIHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogRGFuaWVsIFAuIEJlcnJhbmfDqSBbbWFpbHRvOmJlcnJh
bmdlQHJlZGhhdC5jb21dDQo+ID4gPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTMsIDIwMjAg
OTo1MiBQTQ0KPiA+ID4gVG86IG1pYW95dWJvIDxtaWFveXVib0BodWF3ZWkuY29tPg0KPiA+ID4g
Q2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgc2hhbm5vbi56aGFvc2xAZ21haWwuY29tOw0K
PiA+ID4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBYaWV4aWFu
Z3lvdQ0KPiA+ID4gPHhpZXhpYW5neW91QGh1YXdlaS5jb20+OyBtc3RAcmVkaGF0LmNvbQ0KPiA+
ID4gU3ViamVjdDogUmU6IFtSRkMgMi8yXSBwY2ktZXhwZW5kZXItYnVzOkFkZCBwY2llLXJvb3Qt
cG9ydCB0bw0KPiA+ID4gcHhiLXBjaWUgdW5kZXIgYXJtLg0KPiA+ID4NCj4gPiA+IE9uIFRodSwg
RmViIDEzLCAyMDIwIGF0IDAzOjQ5OjUyUE0gKzA4MDAsIFl1Ym8gTWlhbyB3cm90ZToNCj4gPiA+
ID4gRnJvbTogbWlhb3l1Ym8gPG1pYW95dWJvQGh1YXdlaS5jb20+DQo+ID4gPiA+DQo+ID4gPiA+
IFNpbmNlIGRldmljZXMgY291bGQgbm90IGRpcmVjdGx5IHBsdWdnZWQgaW50byBweGItcGNpZSwg
dW5kZXIgYXJtLA0KPiA+ID4gPiBvbmUgcGNpZS1yb290IHBvcnQgaXMgcGx1Z2dlZCBpbnRvIHB4
Yi1wY2llLiBEdWUgdG8gdGhlIGJ1cyBmb3INCj4gPiA+ID4gZWFjaCBweGItcGNpZSBpcyBkZWZp
bmVkIGFzIDIgaW4gYWNwaSBkc2R0IHRhYmxlcyhvbmUgZm9yDQo+ID4gPiA+IHB4Yi1wY2llLCBv
bmUgZm9yIHBjaWUtcm9vdC1wb3J0KSwgb25seSBvbmUgZGV2aWNlIGNvdWxkIGJlIHBsdWdnZWQg
aW50bw0KPiBvbmUgcHhiLXBjaWUuDQo+ID4gPg0KPiA+ID4gV2hhdCBpcyB0aGUgY2F1c2Ugb2Yg
dGhpcyBhcm0gc3BlY2lmaWMgcmVxdWlyZW1lbnQgZm9yIHB4Yi1wY2llIGFuZA0KPiA+ID4gbW9y
ZSBpbXBvcnRhbnRseSBjYW4gYmUgZml4IGl0IHNvIHRoYXQgd2UgZG9uJ3QgbmVlZCB0aGlzIHBh
dGNoID8NCj4gPiA+IEkgdGhpbmsgaXQgaXMgaGlnaGx5IHVuZGVzaXJhYmxlIHRvIGhhdmUgc3Vj
aCBhIHBlci1hcmNoIGRpZmZlcmVuY2UNCj4gPiA+IGluIGNvbmZpZ3VyYXRpb24gb2YgdGhlIHB4
Yi1wY2llIGRldmljZS4gSXQgbWVhbnMgYW55IG1nbXQgYXBwIHdoaWNoDQo+ID4gPiBhbHJlYWR5
IHN1cHBvcnRzIHB4Yi1wY2llIHdpbGwgYmUgYnJva2VuIGFuZCBuZWVkIHRvIHNwZWNpYWwgY2Fz
ZSBhcm0uDQo+ID4gPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJlcGx5LCBXaXRob3V0IHRo
aXMgcGF0Y2gsIHRoZSBweGItcGNpZSBpcyBhbHNvDQo+ID4gdXNlYWJsZSwgaG93ZXZlciwgb25l
IGV4dHJhIHBjaWUtcm9vdC1wb3J0IG9yIHBjaS1icmlkZ2Ugb3Igc29tZXRoaW5nDQo+ID4gZWxz
ZSBuZWVkIHRvIGJlIGRlZmluZWQgYnkgbWdtdC4gYXBwLiBUaGlzIHBhdGNoIHdpbGwgY291bGQg
YmUgYWJhbmRvbmVkLg0KPiANCj4gVGhhdCdzIG5vdCByZWFsbHkgYW5zd2VyaW5nIG15IHF1ZXN0
aW9uLiBJSVVDLCB0aGlzIHB4Yi1wY2llIGRldmljZSB3b3JrcyBmaW5lDQo+IG9uIHg4Nl82NCwg
YW5kIEkgd2FudCB0byBrbm93IHdoeSBpdCBkb2Vzbid0IHdvcmsgb24gYXJtID8NCj4gUmVxdWly
aW5nIGRpZmZlcmVudCBzZXR1cHMgYnkgdGhlIG1nbXQgYXBwcyBpcyBub3QgYXQgYWxsIG5pY2Ug
YmVjYXVzZSBpdCB3aWxsDQo+IGluZXZpdGFibHkgbGVhZCB0byBicm9rZW4gYXJtIHNldHVwcy4g
eDg2XzY0IGdldHMgZmFyIG1vcmUgdGVzdGluZyAmIHVzYWdlLA0KPiBkZXZlbG9wZXJzIHdvbid0
IHJlYWxpemUgYXJtIGlzIGRpZmZlcmVudC4NCj4gDQo+DQoNClRoYW5rcyBmb3IgcmVwbHlpbmcu
IEN1cnJlbnRseSwgb24geDg2XzY0LCBweGItcGNpZSBkZXZpY2VzIGlzIHByZXNlbnRlZCBpbiBh
Y3BpIHRhYmxlcyBidXQgb24gYXJtLCBJdCBpcyBub3QsIG9ubHkgb25lIG1haW4gaG9zdCBicmlk
Z2UgaXMgcHJlc2VudGVkIGZvciBhcm0gaW4gYWNwaSBkc2R0IHRhYmxlcy4gVGhhdCdzIHdoeSBw
eGItcGNpZSB3b3JrcyBvbiB4ODZfNjQgYnV0IGRvZXNuJ3Qgd29yayBvbiBhcm0uIFRoZSBwYXRj
aCAxLzIgZG8gdGhlIHdvcmsgdG8gcHJlc2VudCBhbmQgYWxsb2NhdGUgcmVzb3VyY2VzIGZvciBw
eGItcGNpZSBpbiBhcm0uDQpGb3IgeDg2XzY0LCBpZiBvbmUgZGV2aWNlIGlzIGdvaW5nIHRvIGJl
IHBsdWdnZWQgaW50byBweGItcGNpZSwgb25lIGV4dHJhIHBjaWUtcm9vdC1wb3J0IG9yIHBjaS1i
cmlkZ2UgaGF2ZSB0byBiZSBkZWZpbmVkIGFuZCBwbHVnZ2VkIG9uIHB4Yi1wY2llLCB0aGVuIHRo
ZSBkZXZpY2UgaXMgcGx1Z2dlZCBvbiB0aGUgcGNpZS1yb290LXBvcnQgb3IgcGNpLWJyaWRnZS4N
ClRoaXMgcGF0Y2ggMi8yIGp1c3QgYXV0byBkZWZpbmVkIG9uZSBwY2llLXJvb3QtcG9ydCBmb3Ig
YXJtLiBJZiB0aGlzIHBhdGNoIGFiYW5kb25lZCwgdGhlIHVzYWdlIG9mIHB4Yi1wY2llIHdvdWxk
IGJlIHRoZSBzYW1lIHdpdGggeDg2XzY0LCB0aGVyZWZvcmUsIHRvIGtlZXAgdGhlIHNhbWUgc3Rl
cCBmb3IgeDg2IGFuZCBhcm0sIHRoaXMgcGF0Y2ggMi8yIGNvdWxkIGJlIGFiYW5kb25kZWQuDQoN
CiANCj4gDQo+IFJlZ2FyZHMsDQo+IERhbmllbA0KPiAtLQ0KPiB8OiBodHRwczovL2JlcnJhbmdl
LmNvbSAgICAgIC1vLQ0KPiBodHRwczovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2Ug
OnwNCj4gfDogaHR0cHM6Ly9saWJ2aXJ0Lm9yZyAgICAgICAgIC1vLQ0KPiBodHRwczovL2ZzdG9w
MTM4LmJlcnJhbmdlLmNvbSA6fA0KPiB8OiBodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAt
by0NCj4gaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2UgOnwNCg0KUmVnYXJkcywN
Ck1pYW8NCg==

