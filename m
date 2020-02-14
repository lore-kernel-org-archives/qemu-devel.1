Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADECC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764C52086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764C52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VMu-0007cU-LH
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j2VME-000797-LX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j2VMD-0001qp-6n
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:25:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:36816 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j2VMC-0001fv-SY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:25:49 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id E065E1ADCF76D9E3F701;
 Fri, 14 Feb 2020 15:25:43 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 15:25:43 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 14 Feb 2020 15:25:43 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Fri, 14 Feb 2020 15:25:43 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Topic: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Index: AQHV4kI1fIh9lqS0F0yGLr3GCBTaKKgYntSAgAGsCpA=
Date: Fri, 14 Feb 2020 07:25:43 +0000
Message-ID: <3fc86f5a6aaf4c6f81dad4f25fcafda0@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
 <20200213135145.GN594756@redhat.com>
In-Reply-To: <20200213135145.GN594756@redhat.com>
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
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgW21haWx0bzpiZXJyYW5nZUByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVh
cnkgMTMsIDIwMjAgOTo1MiBQTQ0KPiBUbzogbWlhb3l1Ym8gPG1pYW95dWJvQGh1YXdlaS5jb20+
DQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHNoYW5ub24uemhhb3NsQGdtYWlsLmNv
bTsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBYaWV4aWFu
Z3lvdQ0KPiA8eGlleGlhbmd5b3VAaHVhd2VpLmNvbT47IG1zdEByZWRoYXQuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUkZDIDIvMl0gcGNpLWV4cGVuZGVyLWJ1czpBZGQgcGNpZS1yb290LXBvcnQgdG8g
cHhiLXBjaWUNCj4gdW5kZXIgYXJtLg0KPiANCj4gT24gVGh1LCBGZWIgMTMsIDIwMjAgYXQgMDM6
NDk6NTJQTSArMDgwMCwgWXVibyBNaWFvIHdyb3RlOg0KPiA+IEZyb206IG1pYW95dWJvIDxtaWFv
eXVib0BodWF3ZWkuY29tPg0KPiA+DQo+ID4gU2luY2UgZGV2aWNlcyBjb3VsZCBub3QgZGlyZWN0
bHkgcGx1Z2dlZCBpbnRvIHB4Yi1wY2llLCB1bmRlciBhcm0sIG9uZQ0KPiA+IHBjaWUtcm9vdCBw
b3J0IGlzIHBsdWdnZWQgaW50byBweGItcGNpZS4gRHVlIHRvIHRoZSBidXMgZm9yIGVhY2gNCj4g
PiBweGItcGNpZSBpcyBkZWZpbmVkIGFzIDIgaW4gYWNwaSBkc2R0IHRhYmxlcyhvbmUgZm9yIHB4
Yi1wY2llLCBvbmUgZm9yDQo+ID4gcGNpZS1yb290LXBvcnQpLCBvbmx5IG9uZSBkZXZpY2UgY291
bGQgYmUgcGx1Z2dlZCBpbnRvIG9uZSBweGItcGNpZS4NCj4gDQo+IFdoYXQgaXMgdGhlIGNhdXNl
IG9mIHRoaXMgYXJtIHNwZWNpZmljIHJlcXVpcmVtZW50IGZvciBweGItcGNpZSBhbmQgbW9yZQ0K
PiBpbXBvcnRhbnRseSBjYW4gYmUgZml4IGl0IHNvIHRoYXQgd2UgZG9uJ3QgbmVlZCB0aGlzIHBh
dGNoID8NCj4gSSB0aGluayBpdCBpcyBoaWdobHkgdW5kZXNpcmFibGUgdG8gaGF2ZSBzdWNoIGEg
cGVyLWFyY2ggZGlmZmVyZW5jZSBpbg0KPiBjb25maWd1cmF0aW9uIG9mIHRoZSBweGItcGNpZSBk
ZXZpY2UuIEl0IG1lYW5zIGFueSBtZ210IGFwcCB3aGljaCBhbHJlYWR5DQo+IHN1cHBvcnRzIHB4
Yi1wY2llIHdpbGwgYmUgYnJva2VuIGFuZCBuZWVkIHRvIHNwZWNpYWwgY2FzZSBhcm0uDQo+IA0K
DQpUaGFua3MgZm9yIHlvdXIgcmVwbHksIFdpdGhvdXQgdGhpcyBwYXRjaCwgdGhlIHB4Yi1wY2ll
IGlzIGFsc28gdXNlYWJsZSwgDQpob3dldmVyLCBvbmUgZXh0cmEgcGNpZS1yb290LXBvcnQgb3Ig
cGNpLWJyaWRnZSBvciBzb21ldGhpbmcgZWxzZSBuZWVkIA0KdG8gYmUgZGVmaW5lZCBieSBtZ210
LiBhcHAuIFRoaXMgcGF0Y2ggd2lsbCBjb3VsZCBiZSBhYmFuZG9uZWQuDQoNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IG1pYW95dWJvIDxtaWFveXVib0BodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+
ICBody9wY2ktYnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UuYyB8IDkgKysrKysrKysrDQo+ID4g
IGluY2x1ZGUvaHcvcGNpL3BjaWVfcG9ydC5oICAgICAgICAgIHwgMSArDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3BjaS1i
cmlkZ2UvcGNpX2V4cGFuZGVyX2JyaWRnZS5jDQo+ID4gYi9ody9wY2ktYnJpZGdlL3BjaV9leHBh
bmRlcl9icmlkZ2UuYw0KPiA+IGluZGV4IDQ3YWFhZjhmZDEuLjNkODk2ZGQ0NTIgMTAwNjQ0DQo+
ID4gLS0tIGEvaHcvcGNpLWJyaWRnZS9wY2lfZXhwYW5kZXJfYnJpZGdlLmMNCj4gPiArKysgYi9o
dy9wY2ktYnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UuYw0KPiA+IEBAIC0xNSw2ICsxNSw3IEBA
DQo+ID4gICNpbmNsdWRlICJody9wY2kvcGNpLmgiDQo+ID4gICNpbmNsdWRlICJody9wY2kvcGNp
X2J1cy5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvcGNpL3BjaV9ob3N0LmgiDQo+ID4gKyNpbmNsdWRl
ICJody9wY2kvcGNpZV9wb3J0LmgiDQo+ID4gICNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMu
aCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJpZGdlLmgiDQo+ID4gICNpbmNsdWRlICJx
ZW11L3JhbmdlLmgiDQo+ID4gQEAgLTIzMyw3ICsyMzQsMTUgQEAgc3RhdGljIHZvaWQgcHhiX2Rl
dl9yZWFsaXplX2NvbW1vbihQQ0lEZXZpY2UNCj4gPiAqZGV2LCBib29sIHBjaWUsIEVycm9yICoq
ZXJycCkNCj4gPg0KPiA+ICAgICAgZHMgPSBxZGV2X2NyZWF0ZShOVUxMLCBUWVBFX1BYQl9IT1NU
KTsNCj4gPiAgICAgIGlmIChwY2llKSB7DQo+ID4gKyNpZmRlZiBfX2FhcmNoNjRfXw0KPiA+ICsg
ICAgICAgIGJ1cyA9IHBjaV9yb290X2J1c19uZXcoZHMsICJweGItcGNpZS1pbnRlcm5hbCIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBOVUxMLCAwLCBUWVBFX1BY
Ql9QQ0lFX0JVUyk7DQo+ID4gKyAgICAgICAgYmRzID0gcWRldl9jcmVhdGUoQlVTKGJ1cyksICJw
Y2llLXJvb3QtcG9ydCIpOw0KPiA+ICsgICAgICAgIGJkcy0+aWQgPSBkZXZfbmFtZTsNCj4gPiAr
ICAgICAgICBxZGV2X3Byb3Bfc2V0X3VpbnQ4KGJkcywgUENJRV9ST09UX1BPUlRfUFJPUF9DSEFT
U0lTLA0KPiA+ICtweGItPmJ1c19ucik7ICNlbHNlDQo+ID4gICAgICAgICAgYnVzID0gcGNpX3Jv
b3RfYnVzX25ldyhkcywgZGV2X25hbWUsIE5VTEwsIE5VTEwsIDAsDQo+ID4gVFlQRV9QWEJfUENJ
RV9CVVMpOw0KPiA+ICsjZW5kaWYNCj4gPiAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgYnVz
ID0gcGNpX3Jvb3RfYnVzX25ldyhkcywgInB4Yi1pbnRlcm5hbCIsIE5VTEwsIE5VTEwsIDAsDQo+
IFRZUEVfUFhCX0JVUyk7DQo+ID4gICAgICAgICAgYmRzID0gcWRldl9jcmVhdGUoQlVTKGJ1cyks
ICJwY2ktYnJpZGdlIik7IGRpZmYgLS1naXQNCj4gPiBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfcG9y
dC5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZV9wb3J0LmggaW5kZXgNCj4gPiA0YjNkMjU0YjA4Li5i
NDFkNDczMjIwIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfcG9ydC5oDQo+
ID4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpZV9wb3J0LmgNCj4gPiBAQCAtNjQsNiArNjQsNyBA
QCBpbnQgcGNpZV9jaGFzc2lzX2FkZF9zbG90KHN0cnVjdCBQQ0lFU2xvdCAqc2xvdCk7DQo+ID4g
dm9pZCBwY2llX2NoYXNzaXNfZGVsX3Nsb3QoUENJRVNsb3QgKnMpOw0KPiA+DQo+ID4gICNkZWZp
bmUgVFlQRV9QQ0lFX1JPT1RfUE9SVCAgICAgICAgICJwY2llLXJvb3QtcG9ydC1iYXNlIg0KPiA+
ICsjZGVmaW5lIFBDSUVfUk9PVF9QT1JUX1BST1BfQ0hBU1NJUyAiY2hhc3NpcyINCj4gPiAgI2Rl
ZmluZSBQQ0lFX1JPT1RfUE9SVF9DTEFTUyhrbGFzcykgXA0KPiA+ICAgICAgIE9CSkVDVF9DTEFT
U19DSEVDSyhQQ0lFUm9vdFBvcnRDbGFzcywgKGtsYXNzKSwNCj4gPiBUWVBFX1BDSUVfUk9PVF9Q
T1JUKSAgI2RlZmluZSBQQ0lFX1JPT1RfUE9SVF9HRVRfQ0xBU1Mob2JqKSBcDQo+ID4gLS0NCj4g
PiAyLjE5LjENCj4gPg0KPiA+DQo+ID4NCj4gDQo+IFJlZ2FyZHMsDQo+IERhbmllbA0KPiAtLQ0K
PiB8OiBodHRwczovL2JlcnJhbmdlLmNvbSAgICAgIC1vLQ0KPiBodHRwczovL3d3dy5mbGlja3Iu
Y29tL3Bob3Rvcy9kYmVycmFuZ2UgOnwNCj4gfDogaHR0cHM6Ly9saWJ2aXJ0Lm9yZyAgICAgICAg
IC1vLSAgICAgICAgICAgIGh0dHBzOi8vZnN0b3AxMzguYmVycmFuZ2UuY29tIDp8DQo+IHw6IGh0
dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgIC1vLQ0KPiBodHRwczovL3d3dy5pbnN0YWdyYW0u
Y29tL2RiZXJyYW5nZSA6fA0KDQpSZWdhcmRzLA0KTWlhbw0K

