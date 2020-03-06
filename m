Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C00C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E97D2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E97D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA2Zs-0003A1-P7
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 21:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jA2ZD-0002P6-2k
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jA2ZB-0006ve-KM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:18:22 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2075 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jA2ZB-0006mu-9n; Thu, 05 Mar 2020 21:18:21 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 30EB245F27C7070C3DC1;
 Fri,  6 Mar 2020 10:18:15 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Fri, 6 Mar 2020 10:18:07 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: RE: [PATCH] contrib/elf2dmp: prevent uninitialized warning
Thread-Topic: [PATCH] contrib/elf2dmp: prevent uninitialized warning
Thread-Index: AQHV3W1WZ2Vkfkjjwke0Rzm+ZufchKg5/00AgAD71fA=
Date: Fri, 6 Mar 2020 02:18:07 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B66F9DA@dggemm531-mbx.china.huawei.com>
References: <20200207041601.89668-1-kuhn.chenqun@huawei.com>
 <20200305215902.24bbe6ce@phystech.edu>
In-Reply-To: <20200305215902.24bbe6ce@phystech.edu>
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
X-Received-From: 45.249.212.189
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVmlrdG9yIFBydXR5YW5vdiBbbWFp
bHRvOnZpa3Rvci5wcnV0eWFub3ZAcGh5c3RlY2guZWR1XQ0KPlNlbnQ6IEZyaWRheSwgTWFyY2gg
NiwgMjAyMCAyOjU5IEFNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2Vp
LmNvbT4NCj5DYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBwYm9uemluaUByZWRoYXQuY29tOyBa
aGFuZ2hhaWxpYW5nDQo+PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IHFlbXUtdHJp
dmlhbEBub25nbnUub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gY29udHJpYi9lbGYyZG1wOiBw
cmV2ZW50IHVuaW5pdGlhbGl6ZWQgd2FybmluZw0KPg0KPk9uIEZyaSwgNyBGZWIgMjAyMCAxMjox
NjowMSArMDgwMA0KPjxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4gd3JvdGU6DQo+DQo+PiBGcm9t
OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+Pg0KPj4gRml4IGNvbXBpbGF0
aW9uIHdhcm5pbmdzOg0KPj4gY29udHJpYi9lbGYyZG1wL21haW4uYzo2NjoxNzogd2FybmluZzog
4oCYS2RwRGF0YUJsb2NrRW5jb2RlZOKAmSBtYXkgYmUNCj4+IHVzZWQgdW5pbml0aWFsaXplZCBp
biB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+PiAgICAgICAgICBibG9j
ayA9IF9fYnVpbHRpbl9ic3dhcDY0KGJsb2NrIF4ga2RiZSkgXiBrd2E7DQo+PiAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4+IGNvbnRyaWIvZWxmMmRt
cC9tYWluLmM6Nzg6MjQ6IG5vdGU6IOKAmEtkcERhdGFCbG9ja0VuY29kZWTigJkgd2FzIGRlY2xh
cmVkDQo+PiBoZXJlIHVpbnQ2NF90IGt3biwga3dhLCBLZHBEYXRhQmxvY2tFbmNvZGVkOw0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4NCj4+IFJlcG9y
dGVkLWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gIGNv
bnRyaWIvZWxmMmRtcC9tYWluLmMgfCAyNSArKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9jb250cmliL2VsZjJkbXAvbWFpbi5jIGIvY29udHJpYi9lbGYyZG1wL21h
aW4uYyBpbmRleA0KPj4gOWEyZGJjMjkwMi4uMjAzYjllNmQwNCAxMDA2NDQNCj4+IC0tLSBhL2Nv
bnRyaWIvZWxmMmRtcC9tYWluLmMNCj4+ICsrKyBiL2NvbnRyaWIvZWxmMmRtcC9tYWluLmMNCj4+
IEBAIC03Niw2ICs3Niw3IEBAIHN0YXRpYyBLRERFQlVHR0VSX0RBVEE2NCAqZ2V0X2tkYmcodWlu
dDY0X3QNCj4+IEtlcm5CYXNlLCBzdHJ1Y3QgcGRiX3JlYWRlciAqcGRiLCBEQkdLRF9ERUJVR19E
QVRBX0hFQURFUjY0DQo+a2RiZ19oZHI7DQo+PiAgICAgIGJvb2wgZGVjb2RlID0gZmFsc2U7DQo+
PiAgICAgIHVpbnQ2NF90IGt3biwga3dhLCBLZHBEYXRhQmxvY2tFbmNvZGVkOw0KPj4gKyAgICB1
aW50NjRfdCBLaVdhaXROZXZlciwgS2lXYWl0QWx3YXlzOw0KPj4NCj4+ICAgICAgaWYgKHZhX3Nw
YWNlX3J3KHZzLA0KPj4gICAgICAgICAgICAgICAgICBLZERlYnVnZ2VyRGF0YUJsb2NrICsgb2Zm
c2V0b2YoS0RERUJVR0dFUl9EQVRBNjQsDQo+PiBIZWFkZXIpLCBAQCAtODQsMjEgKzg1LDE5IEBA
IHN0YXRpYyBLRERFQlVHR0VSX0RBVEE2NA0KPj4gKmdldF9rZGJnKHVpbnQ2NF90IEtlcm5CYXNl
LCBzdHJ1Y3QgcGRiX3JlYWRlciAqcGRiLCByZXR1cm4gTlVMTDsNCj4+ICAgICAgfQ0KPj4NCj4+
IC0gICAgaWYgKG1lbWNtcCgma2RiZ19oZHIuT3duZXJUYWcsIE93bmVyVGFnLCBzaXplb2YoT3du
ZXJUYWcpKSkgew0KPj4gLSAgICAgICAgdWludDY0X3QgS2lXYWl0TmV2ZXIsIEtpV2FpdEFsd2F5
czsNCj4+IC0NCj4+IC0gICAgICAgIGRlY29kZSA9IHRydWU7DQo+PiArICAgIGlmICghU1lNX1JF
U09MVkUoS2VybkJhc2UsIHBkYiwgS2lXYWl0TmV2ZXIpIHx8DQo+PiArICAgICAgICAgICAgIVNZ
TV9SRVNPTFZFKEtlcm5CYXNlLCBwZGIsIEtpV2FpdEFsd2F5cykgfHwNCj4+ICsgICAgICAgICAg
ICAhU1lNX1JFU09MVkUoS2VybkJhc2UsIHBkYiwgS2RwRGF0YUJsb2NrRW5jb2RlZCkpIHsNCj4+
ICsgICAgICAgIHJldHVybiBOVUxMOw0KPj4gKyAgICB9DQo+Pg0KPj4gLSAgICAgICAgaWYgKCFT
WU1fUkVTT0xWRShLZXJuQmFzZSwgcGRiLCBLaVdhaXROZXZlcikgfHwNCj4+IC0gICAgICAgICAg
ICAgICAgIVNZTV9SRVNPTFZFKEtlcm5CYXNlLCBwZGIsIEtpV2FpdEFsd2F5cykgfHwNCj4+IC0g
ICAgICAgICAgICAgICAgIVNZTV9SRVNPTFZFKEtlcm5CYXNlLCBwZGIsIEtkcERhdGFCbG9ja0Vu
Y29kZWQpKSB7DQo+PiAtICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAtICAgICAgICB9DQo+
PiArICAgIGlmICh2YV9zcGFjZV9ydyh2cywgS2lXYWl0TmV2ZXIsICZrd24sIHNpemVvZihrd24p
LCAwKSB8fA0KPj4gKyAgICAgICAgICAgIHZhX3NwYWNlX3J3KHZzLCBLaVdhaXRBbHdheXMsICZr
d2EsIHNpemVvZihrd2EpLCAwKSkgew0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiArICAg
IH0NCj4+DQo+PiAtICAgICAgICBpZiAodmFfc3BhY2VfcncodnMsIEtpV2FpdE5ldmVyLCAma3du
LCBzaXplb2Yoa3duKSwgMCkgfHwNCj4+IC0gICAgICAgICAgICAgICAgdmFfc3BhY2VfcncodnMs
IEtpV2FpdEFsd2F5cywgJmt3YSwgc2l6ZW9mKGt3YSksIDApKQ0KPj4gew0KPj4gLSAgICAgICAg
ICAgIHJldHVybiBOVUxMOw0KPj4gLSAgICAgICAgfQ0KPj4gKyAgICBpZiAobWVtY21wKCZrZGJn
X2hkci5Pd25lclRhZywgT3duZXJUYWcsIHNpemVvZihPd25lclRhZykpKSB7DQo+PiArICAgICAg
ICBkZWNvZGUgPSB0cnVlOw0KPj4NCj4+ICAgICAgICAgIHByaW50ZigiW0tpV2FpdE5ldmVyXSA9
IDB4JTAxNiJQUkl4NjQiXG4iLCBrd24pOw0KPj4gICAgICAgICAgcHJpbnRmKCJbS2lXYWl0QWx3
YXlzXSA9IDB4JTAxNiJQUkl4NjQiXG4iLCBrd2EpOw0KPg0KPkhpIQ0KPg0KPkkgc3VwcG9zZSB0
aGUgcHJvYmxlbSBpcyBpbiB5b3VyIGNvbXBpbGVyLCBiZWNhdXNlIGtkYmdfZGVjb2RlKCkgaXMg
b25seQ0KPnVzZWQgd2hlbiBLZHBEYXRhQmxvY2tFbmNvZGVkIGlzIGFscmVhZHkgaW5pdGlhbGl6
ZWQgYnkgU1lNX1JFU09MVkUoKS4NCj4NCkhpICBWaWt0b3IsDQoNCiAgICAgICBJIGtub3cgaXQn
cyBhY3R1YWxseSBpbml0aWFsaXplZCB3aGVuICAnZGVjb2RlID0gdHJ1ZTsnLCAgb3RoZXJ3aXNl
ICcgcmV0dXJuIGtkYmc7JyAgbm8gbmVlZCB0byBpbml0aWFsaXplLg0KICAgICAgDQogICAgIEJ1
dCB1c3VhbGx5IHRoZSBjb21waWxlciBjYW5ub3QgdW5kZXJzdGFuZCBpdCwgYmVjYXVzZSBpdCBz
ZWVtcyB0aGF0IHRoZSBpbml0aWFsaXphdGlvbiBpcyBvbmx5IGluIHRoZSBpZigpIHN0YXRlbWVu
dC4NCklmIHdlIHB1dCB0aGUgaW5pdGlhbGl6YXRpb24gb3V0c2lkZSB0aGUgaWYoKSBzdGF0ZW1l
bnQsIGl0IG1pZ2h0IGxvb2tzIGJldHRlciB3aXRob3V0IGFmZmVjdGluZyB0aGUgZnVuY3Rpb25h
bGl0eSA/DQoNClRoYW5rcy4NCj4tLQ0KPlZpa3RvciBQcnV0eWFub3YNCg==

