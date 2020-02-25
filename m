Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E094BC35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A51218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A51218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6PS1-0004eY-Vw
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j6PRI-00047J-SH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j6PRG-00054A-VS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:55:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2502 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j6PRF-00051S-7Q
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:55:10 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 43E6A4E8750FFE6F13B3;
 Tue, 25 Feb 2020 09:55:06 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 09:55:05 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 25 Feb 2020 09:54:58 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 09:54:58 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Topic: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Index: AQHV4kI1fIh9lqS0F0yGLr3GCBTaKKgYntSAgAGsCpD//6x8gIAB/zXAgA3cxwCAAWRTAA==
Date: Tue, 25 Feb 2020 01:54:58 +0000
Message-ID: <3efca0dcac27481a819c9a983ce03a0b@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
 <20200213135145.GN594756@redhat.com>
 <3fc86f5a6aaf4c6f81dad4f25fcafda0@huawei.com>
 <20200214102451.GA613610@redhat.com>
 <8f977fbdd8e346ef911ebfe71dbb1514@huawei.com>
 <20200224123606.GM635661@redhat.com>
In-Reply-To: <20200224123606.GM635661@redhat.com>
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
w6kgW21haWx0bzpiZXJyYW5nZUByZWRoYXQuY29tXQ0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5
IDI0LCAyMDIwIDg6MzYgUE0NCj4gVG86IG1pYW95dWJvIDxtaWFveXVib0BodWF3ZWkuY29tPg0K
PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBtc3RAcmVkaGF0LmNvbTsgcWVtdS1kZXZl
bEBub25nbnUub3JnOw0KPiBYaWV4aWFuZ3lvdSA8eGlleGlhbmd5b3VAaHVhd2VpLmNvbT47IHNo
YW5ub24uemhhb3NsQGdtYWlsLmNvbTsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1JGQyAyLzJdIHBjaS1leHBlbmRlci1idXM6QWRkIHBjaWUtcm9vdC1wb3J0IHRvIHB4
Yi1wY2llDQo+IHVuZGVyIGFybS4NCj4gDQo+IE9uIFNhdCwgRmViIDE1LCAyMDIwIGF0IDA4OjU5
OjI4QU0gKzAwMDAsIG1pYW95dWJvIHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogRGFuaWVsIFAuIEJlcnJhbmfDqSBbbWFpbHRvOmJlcnJh
bmdlQHJlZGhhdC5jb21dDQo+ID4gPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE0LCAyMDIwIDY6
MjUgUE0NCj4gPiA+IFRvOiBtaWFveXVibyA8bWlhb3l1Ym9AaHVhd2VpLmNvbT4NCj4gPiA+IENj
OiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHNoYW5ub24uemhhb3NsQGdtYWlsLmNvbTsNCj4g
PiA+IGltYW1tZWRvQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgWGlleGlhbmd5
b3UNCj4gPiA+IDx4aWV4aWFuZ3lvdUBodWF3ZWkuY29tPjsgbXN0QHJlZGhhdC5jb20NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUkZDIDIvMl0gcGNpLWV4cGVuZGVyLWJ1czpBZGQgcGNpZS1yb290LXBv
cnQgdG8NCj4gPiA+IHB4Yi1wY2llIHVuZGVyIGFybS4NCj4gPiA+DQo+ID4gPiBPbiBGcmksIEZl
YiAxNCwgMjAyMCBhdCAwNzoyNTo0M0FNICswMDAwLCBtaWFveXVibyB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IERh
bmllbCBQLiBCZXJyYW5nw6kgW21haWx0bzpiZXJyYW5nZUByZWRoYXQuY29tXQ0KPiA+ID4gPiA+
IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxMywgMjAyMCA5OjUyIFBNDQo+ID4gPiA+ID4gVG86
IG1pYW95dWJvIDxtaWFveXVib0BodWF3ZWkuY29tPg0KPiA+ID4gPiA+IENjOiBwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc7IHNoYW5ub24uemhhb3NsQGdtYWlsLmNvbTsNCj4gPiA+ID4gPiBpbWFt
bWVkb0ByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFhpZXhpYW5neW91DQo+ID4g
PiA+ID4gPHhpZXhpYW5neW91QGh1YXdlaS5jb20+OyBtc3RAcmVkaGF0LmNvbQ0KPiA+ID4gPiA+
IFN1YmplY3Q6IFJlOiBbUkZDIDIvMl0gcGNpLWV4cGVuZGVyLWJ1czpBZGQgcGNpZS1yb290LXBv
cnQgdG8NCj4gPiA+ID4gPiBweGItcGNpZSB1bmRlciBhcm0uDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBPbiBUaHUsIEZlYiAxMywgMjAyMCBhdCAwMzo0OTo1MlBNICswODAwLCBZdWJvIE1pYW8gd3Jv
dGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBtaWFveXVibyA8bWlhb3l1Ym9AaHVhd2VpLmNvbT4NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaW5jZSBkZXZpY2VzIGNvdWxkIG5vdCBkaXJlY3RseSBw
bHVnZ2VkIGludG8gcHhiLXBjaWUsIHVuZGVyDQo+ID4gPiA+ID4gPiBhcm0sIG9uZSBwY2llLXJv
b3QgcG9ydCBpcyBwbHVnZ2VkIGludG8gcHhiLXBjaWUuIER1ZSB0byB0aGUNCj4gPiA+ID4gPiA+
IGJ1cyBmb3IgZWFjaCBweGItcGNpZSBpcyBkZWZpbmVkIGFzIDIgaW4gYWNwaSBkc2R0IHRhYmxl
cyhvbmUNCj4gPiA+ID4gPiA+IGZvciBweGItcGNpZSwgb25lIGZvciBwY2llLXJvb3QtcG9ydCks
IG9ubHkgb25lIGRldmljZSBjb3VsZA0KPiA+ID4gPiA+ID4gYmUgcGx1Z2dlZCBpbnRvDQo+ID4g
PiBvbmUgcHhiLXBjaWUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGlzIHRoZSBjYXVzZSBv
ZiB0aGlzIGFybSBzcGVjaWZpYyByZXF1aXJlbWVudCBmb3IgcHhiLXBjaWUNCj4gPiA+ID4gPiBh
bmQgbW9yZSBpbXBvcnRhbnRseSBjYW4gYmUgZml4IGl0IHNvIHRoYXQgd2UgZG9uJ3QgbmVlZCB0
aGlzIHBhdGNoID8NCj4gPiA+ID4gPiBJIHRoaW5rIGl0IGlzIGhpZ2hseSB1bmRlc2lyYWJsZSB0
byBoYXZlIHN1Y2ggYSBwZXItYXJjaA0KPiA+ID4gPiA+IGRpZmZlcmVuY2UgaW4gY29uZmlndXJh
dGlvbiBvZiB0aGUgcHhiLXBjaWUgZGV2aWNlLiBJdCBtZWFucyBhbnkNCj4gPiA+ID4gPiBtZ210
IGFwcCB3aGljaCBhbHJlYWR5IHN1cHBvcnRzIHB4Yi1wY2llIHdpbGwgYmUgYnJva2VuIGFuZCBu
ZWVkDQo+IHRvIHNwZWNpYWwgY2FzZSBhcm0uDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g
VGhhbmtzIGZvciB5b3VyIHJlcGx5LCBXaXRob3V0IHRoaXMgcGF0Y2gsIHRoZSBweGItcGNpZSBp
cyBhbHNvDQo+ID4gPiA+IHVzZWFibGUsIGhvd2V2ZXIsIG9uZSBleHRyYSBwY2llLXJvb3QtcG9y
dCBvciBwY2ktYnJpZGdlIG9yDQo+ID4gPiA+IHNvbWV0aGluZyBlbHNlIG5lZWQgdG8gYmUgZGVm
aW5lZCBieSBtZ210LiBhcHAuIFRoaXMgcGF0Y2ggd2lsbCBjb3VsZA0KPiBiZSBhYmFuZG9uZWQu
DQo+ID4gPg0KPiA+ID4gVGhhdCdzIG5vdCByZWFsbHkgYW5zd2VyaW5nIG15IHF1ZXN0aW9uLiBJ
SVVDLCB0aGlzIHB4Yi1wY2llIGRldmljZQ0KPiA+ID4gd29ya3MgZmluZSBvbiB4ODZfNjQsIGFu
ZCBJIHdhbnQgdG8ga25vdyB3aHkgaXQgZG9lc24ndCB3b3JrIG9uIGFybSA/DQo+ID4gPiBSZXF1
aXJpbmcgZGlmZmVyZW50IHNldHVwcyBieSB0aGUgbWdtdCBhcHBzIGlzIG5vdCBhdCBhbGwgbmlj
ZQ0KPiA+ID4gYmVjYXVzZSBpdCB3aWxsIGluZXZpdGFibHkgbGVhZCB0byBicm9rZW4gYXJtIHNl
dHVwcy4geDg2XzY0IGdldHMNCj4gPiA+IGZhciBtb3JlIHRlc3RpbmcgJiB1c2FnZSwgZGV2ZWxv
cGVycyB3b24ndCByZWFsaXplIGFybSBpcyBkaWZmZXJlbnQuDQo+ID4gPg0KPiA+ID4NCj4gPg0K
PiA+IFRoYW5rcyBmb3IgcmVwbHlpbmcuIEN1cnJlbnRseSwgb24geDg2XzY0LCBweGItcGNpZSBk
ZXZpY2VzIGlzDQo+ID4gcHJlc2VudGVkIGluIGFjcGkgdGFibGVzIGJ1dCBvbiBhcm0sIEl0IGlz
IG5vdCwgb25seSBvbmUgbWFpbiBob3N0DQo+ID4gYnJpZGdlIGlzIHByZXNlbnRlZCBmb3IgYXJt
IGluIGFjcGkgZHNkdCB0YWJsZXMuIFRoYXQncyB3aHkgcHhiLXBjaWUNCj4gPiB3b3JrcyBvbg0K
PiA+IHg4Nl82NCBidXQgZG9lc24ndCB3b3JrIG9uIGFybS4gVGhlIHBhdGNoIDEvMiBkbyB0aGUg
d29yayB0byBwcmVzZW50DQo+ID4gYW5kIGFsbG9jYXRlIHJlc291cmNlcyBmb3IgcHhiLXBjaWUg
aW4gYXJtLg0KPiANCj4gWWVzLCB0aGlzIGZpcnN0IHBhdGNoIG1ha2VzIHNlbnNlDQo+IA0KDQpU
aGFua3MgZm9yIHRoZSBjb21tZW50cywgdGhlIHBhdGNoIGhhcyBiZWVuIHVwZGF0ZWQgdG8gdjQs
IHBscyBjaGVjayBpdC4NCg0KPiA+IEZvciB4ODZfNjQsIGlmIG9uZSBkZXZpY2UgaXMgZ29pbmcg
dG8gYmUgcGx1Z2dlZCBpbnRvIHB4Yi1wY2llLCBvbmUNCj4gPiBleHRyYSBwY2llLXJvb3QtcG9y
dCBvciBwY2ktYnJpZGdlIGhhdmUgdG8gYmUgZGVmaW5lZCBhbmQgcGx1Z2dlZCBvbg0KPiA+IHB4
Yi1wY2llLCB0aGVuIHRoZSBkZXZpY2UgaXMgcGx1Z2dlZCBvbiB0aGUgcGNpZS1yb290LXBvcnQg
b3IgcGNpLWJyaWRnZS4NCj4gDQo+ID4gVGhpcyBwYXRjaCAyLzIganVzdCBhdXRvIGRlZmluZWQg
b25lIHBjaWUtcm9vdC1wb3J0IGZvciBhcm0uIElmIHRoaXMNCj4gPiBwYXRjaCBhYmFuZG9uZWQs
IHRoZSB1c2FnZSBvZiBweGItcGNpZSB3b3VsZCBiZSB0aGUgc2FtZSB3aXRoIHg4Nl82NCwNCj4g
PiB0aGVyZWZvcmUsIHRvIGtlZXAgdGhlIHNhbWUgc3RlcCBmb3IgeDg2IGFuZCBhcm0sIHRoaXMg
cGF0Y2ggMi8yIGNvdWxkDQo+ID4gYmUgYWJhbmRvbmRlZC4NCj4gDQo+IFllcywgSSB0aGluayBh
YmFuZG9uaW5nIHRoaXMgcGF0Y2ggMiBpcyBiZXN0LiBBcHBsaWNhdGlvbnMgdGhhdCBrbm93IGhv
dyB0bw0KPiB1c2UgcHhiLXBjaWUgb24geDg2XzY0LCB3aWxsIGFscmVhZHkgZG8gdGhlIHJpZ2h0
IHRoaW5nIG9uIGFybSB0b28sIG9uY2UgeW91cg0KPiBmaXJzdCBwYXRjaCBpcyBtZXJnZWQuDQo+
IA0KDQpUaGlzIHBhdGNoIGhhcyBiZWVuIGFiYW5kb25lZCBzaW5jZSB2My4NCg0KPiBSZWdhcmRz
LA0KPiBEYW5pZWwNCj4gLS0NCj4gfDogaHR0cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0NCj4g
aHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90b3MvZGJlcnJhbmdlIDp8DQo+IHw6IGh0dHBzOi8v
bGlidmlydC5vcmcgICAgICAgICAtby0gICAgICAgICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJh
bmdlLmNvbSA6fA0KPiB8OiBodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0NCj4gaHR0
cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2UgOnwNCg0KDQpSZWdhcmRzLA0KTWlhbw0K

