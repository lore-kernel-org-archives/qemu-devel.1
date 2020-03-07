Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE7C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 07:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C9C206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 07:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C9C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jATTJ-00087y-25
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 02:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jATSd-0007dJ-9Y
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 02:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jATSb-0006nv-Em
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 02:01:23 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2455 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jATSa-0006Mc-Pa; Sat, 07 Mar 2020 02:01:21 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id BD9673555D99461F8F11;
 Sat,  7 Mar 2020 15:01:09 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0439.000;
 Sat, 7 Mar 2020 15:00:59 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: RE: [PATCH] contrib/elf2dmp: prevent uninitialized warning
Thread-Topic: [PATCH] contrib/elf2dmp: prevent uninitialized warning
Thread-Index: AQHV3W1WZ2Vkfkjjwke0Rzm+ZufchKg5/00AgAD71fCAAB4FgIABxzBA
Date: Sat, 7 Mar 2020 07:00:58 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B679333@dggemm511-mbx.china.huawei.com>
References: <20200207041601.89668-1-kuhn.chenqun@huawei.com>
 <20200305215902.24bbe6ce@phystech.edu>
 <7412CDE03601674DA8197E2EBD8937E83B66F9DA@dggemm531-mbx.china.huawei.com>
 <20200306144749.64f08e84@phystech.edu>
In-Reply-To: <20200306144749.64f08e84@phystech.edu>
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBWaWt0b3IgUHJ1dHlhbm92IFtt
YWlsdG86dmlrdG9yLnBydXR5YW5vdkBwaHlzdGVjaC5lZHVdDQo+U2VudDogRnJpZGF5LCBNYXJj
aCA2LCAyMDIwIDc6NDggUE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3
ZWkuY29tPg0KPkNjOiBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNv
bTsgcWVtdS0NCj5kZXZlbEBub25nbnUub3JnOyBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hh
aWxpYW5nQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gY29udHJpYi9lbGYyZG1w
OiBwcmV2ZW50IHVuaW5pdGlhbGl6ZWQgd2FybmluZw0KPg0KPk9uIEZyaSwgNiBNYXIgMjAyMCAw
MjoxODowNyArMDAwMA0KPiJDaGVucXVuIChrdWhuKSIgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29t
PiB3cm90ZToNCj4NCj4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IFZp
a3RvciBQcnV0eWFub3YgW21haWx0bzp2aWt0b3IucHJ1dHlhbm92QHBoeXN0ZWNoLmVkdV0NCj4+
ID5TZW50OiBGcmlkYXksIE1hcmNoIDYsIDIwMjAgMjo1OSBBTQ0KPj4gPlRvOiBDaGVucXVuIChr
dWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiA+Q2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsgWmhhbmdoYWlsaWFuZw0KPj4gPjx6aGFuZy56aGFu
Z2hhaWxpYW5nQGh1YXdlaS5jb20+OyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZw0KPj4gPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGNvbnRyaWIvZWxmMmRtcDogcHJldmVudCB1bmluaXRpYWxpemVkIHdh
cm5pbmcNCj4+ID4NCj4+ID5PbiBGcmksIDcgRmViIDIwMjAgMTI6MTY6MDEgKzA4MDANCj4+ID48
a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+IHdyb3RlOg0KPj4gPg0KPj4gPj4gRnJvbTogQ2hlbiBR
dW4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPj4gPj4NCj4+ID4+IEZpeCBjb21waWxhdGlv
biB3YXJuaW5nczoNCj4+ID4+IGNvbnRyaWIvZWxmMmRtcC9tYWluLmM6NjY6MTc6IHdhcm5pbmc6
IOKAmEtkcERhdGFCbG9ja0VuY29kZWTigJkgbWF5IGJlDQo+PiA+PiB1c2VkIHVuaW5pdGlhbGl6
ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQ0KPj4gPj4gICAgICAg
ICAgYmxvY2sgPSBfX2J1aWx0aW5fYnN3YXA2NChibG9jayBeIGtkYmUpIF4ga3dhOw0KPj4gPj4g
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiA+PiBj
b250cmliL2VsZjJkbXAvbWFpbi5jOjc4OjI0OiBub3RlOiDigJhLZHBEYXRhQmxvY2tFbmNvZGVk
4oCZIHdhcw0KPj4gPj4gZGVjbGFyZWQgaGVyZSB1aW50NjRfdCBrd24sIGt3YSwgS2RwRGF0YUJs
b2NrRW5jb2RlZDsNCj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn4NCj4+ID4+DQo+PiA+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90
QGh1YXdlaS5jb20+DQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVu
QGh1YXdlaS5jb20+DQo+PiA+PiAtLS0NCj4+ID4+ICBjb250cmliL2VsZjJkbXAvbWFpbi5jIHwg
MjUgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0IGEv
Y29udHJpYi9lbGYyZG1wL21haW4uYyBiL2NvbnRyaWIvZWxmMmRtcC9tYWluLmMgaW5kZXgNCj4+
ID4+IDlhMmRiYzI5MDIuLjIwM2I5ZTZkMDQgMTAwNjQ0DQo+PiA+PiAtLS0gYS9jb250cmliL2Vs
ZjJkbXAvbWFpbi5jDQo+PiA+PiArKysgYi9jb250cmliL2VsZjJkbXAvbWFpbi5jDQo+PiA+PiBA
QCAtNzYsNiArNzYsNyBAQCBzdGF0aWMgS0RERUJVR0dFUl9EQVRBNjQgKmdldF9rZGJnKHVpbnQ2
NF90DQo+PiA+PiBLZXJuQmFzZSwgc3RydWN0IHBkYl9yZWFkZXIgKnBkYiwgREJHS0RfREVCVUdf
REFUQV9IRUFERVI2NA0KPj4gPmtkYmdfaGRyOw0KPj4gPj4gICAgICBib29sIGRlY29kZSA9IGZh
bHNlOw0KPj4gPj4gICAgICB1aW50NjRfdCBrd24sIGt3YSwgS2RwRGF0YUJsb2NrRW5jb2RlZDsN
Cj4+ID4+ICsgICAgdWludDY0X3QgS2lXYWl0TmV2ZXIsIEtpV2FpdEFsd2F5czsNCj4+ID4+DQo+
PiA+PiAgICAgIGlmICh2YV9zcGFjZV9ydyh2cywNCj4+ID4+ICAgICAgICAgICAgICAgICAgS2RE
ZWJ1Z2dlckRhdGFCbG9jayArIG9mZnNldG9mKEtEREVCVUdHRVJfREFUQTY0LA0KPj4gPj4gSGVh
ZGVyKSwgQEAgLTg0LDIxICs4NSwxOSBAQCBzdGF0aWMgS0RERUJVR0dFUl9EQVRBNjQNCj4+ID4+
ICpnZXRfa2RiZyh1aW50NjRfdCBLZXJuQmFzZSwgc3RydWN0IHBkYl9yZWFkZXIgKnBkYiwgcmV0
dXJuIE5VTEw7DQo+PiA+PiAgICAgIH0NCj4+ID4+DQo+PiA+PiAtICAgIGlmIChtZW1jbXAoJmtk
YmdfaGRyLk93bmVyVGFnLCBPd25lclRhZywgc2l6ZW9mKE93bmVyVGFnKSkpIHsNCj4+ID4+IC0g
ICAgICAgIHVpbnQ2NF90IEtpV2FpdE5ldmVyLCBLaVdhaXRBbHdheXM7DQo+PiA+PiAtDQo+PiA+
PiAtICAgICAgICBkZWNvZGUgPSB0cnVlOw0KPj4gPj4gKyAgICBpZiAoIVNZTV9SRVNPTFZFKEtl
cm5CYXNlLCBwZGIsIEtpV2FpdE5ldmVyKSB8fA0KPj4gPj4gKyAgICAgICAgICAgICFTWU1fUkVT
T0xWRShLZXJuQmFzZSwgcGRiLCBLaVdhaXRBbHdheXMpIHx8DQo+PiA+PiArICAgICAgICAgICAg
IVNZTV9SRVNPTFZFKEtlcm5CYXNlLCBwZGIsIEtkcERhdGFCbG9ja0VuY29kZWQpKSB7DQo+PiA+
PiArICAgICAgICByZXR1cm4gTlVMTDsNCj4+ID4+ICsgICAgfQ0KPj4gPj4NCj4+ID4+IC0gICAg
ICAgIGlmICghU1lNX1JFU09MVkUoS2VybkJhc2UsIHBkYiwgS2lXYWl0TmV2ZXIpIHx8DQo+PiA+
PiAtICAgICAgICAgICAgICAgICFTWU1fUkVTT0xWRShLZXJuQmFzZSwgcGRiLCBLaVdhaXRBbHdh
eXMpIHx8DQo+PiA+PiAtICAgICAgICAgICAgICAgICFTWU1fUkVTT0xWRShLZXJuQmFzZSwgcGRi
LCBLZHBEYXRhQmxvY2tFbmNvZGVkKSkNCj4+ID4+IHsNCj4+ID4+IC0gICAgICAgICAgICByZXR1
cm4gTlVMTDsNCj4+ID4+IC0gICAgICAgIH0NCj4+ID4+ICsgICAgaWYgKHZhX3NwYWNlX3J3KHZz
LCBLaVdhaXROZXZlciwgJmt3biwgc2l6ZW9mKGt3biksIDApIHx8DQo+PiA+PiArICAgICAgICAg
ICAgdmFfc3BhY2VfcncodnMsIEtpV2FpdEFsd2F5cywgJmt3YSwgc2l6ZW9mKGt3YSksIDApKSB7
DQo+PiA+PiArICAgICAgICByZXR1cm4gTlVMTDsNCj4+ID4+ICsgICAgfQ0KPj4gPj4NCj4+ID4+
IC0gICAgICAgIGlmICh2YV9zcGFjZV9ydyh2cywgS2lXYWl0TmV2ZXIsICZrd24sIHNpemVvZihr
d24pLCAwKSB8fA0KPj4gPj4gLSAgICAgICAgICAgICAgICB2YV9zcGFjZV9ydyh2cywgS2lXYWl0
QWx3YXlzLCAma3dhLCBzaXplb2Yoa3dhKSwNCj4+ID4+IDApKSB7DQo+PiA+PiAtICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7DQo+PiA+PiAtICAgICAgICB9DQo+PiA+PiArICAgIGlmIChtZW1jbXAo
JmtkYmdfaGRyLk93bmVyVGFnLCBPd25lclRhZywgc2l6ZW9mKE93bmVyVGFnKSkpIHsNCj4+ID4+
ICsgICAgICAgIGRlY29kZSA9IHRydWU7DQo+PiA+Pg0KPj4gPj4gICAgICAgICAgcHJpbnRmKCJb
S2lXYWl0TmV2ZXJdID0gMHglMDE2IlBSSXg2NCJcbiIsIGt3bik7DQo+PiA+PiAgICAgICAgICBw
cmludGYoIltLaVdhaXRBbHdheXNdID0gMHglMDE2IlBSSXg2NCJcbiIsIGt3YSk7DQo+PiA+DQo+
PiA+SGkhDQo+PiA+DQo+PiA+SSBzdXBwb3NlIHRoZSBwcm9ibGVtIGlzIGluIHlvdXIgY29tcGls
ZXIsIGJlY2F1c2Uga2RiZ19kZWNvZGUoKSBpcw0KPj4gPm9ubHkgdXNlZCB3aGVuIEtkcERhdGFC
bG9ja0VuY29kZWQgaXMgYWxyZWFkeSBpbml0aWFsaXplZCBieQ0KPj4gPlNZTV9SRVNPTFZFKCku
DQo+PiA+DQo+PiBIaSAgVmlrdG9yLA0KPj4NCj4+ICAgICAgICBJIGtub3cgaXQncyBhY3R1YWxs
eSBpbml0aWFsaXplZCB3aGVuICAnZGVjb2RlID0gdHJ1ZTsnLA0KPj4gb3RoZXJ3aXNlICcgcmV0
dXJuIGtkYmc7JyAgbm8gbmVlZCB0byBpbml0aWFsaXplLg0KPj4gICAgICBCdXQgdXN1YWxseSB0
aGUgY29tcGlsZXIgY2Fubm90IHVuZGVyc3RhbmQgaXQsIGJlY2F1c2UgaXQgc2VlbXMNCj4+IHRo
YXQgdGhlIGluaXRpYWxpemF0aW9uIGlzIG9ubHkgaW4gdGhlIGlmKCkgc3RhdGVtZW50Lg0KPg0K
PkFzIGZvciBtZSwgbXkgR0NDIDkuMi4xIGRvZXNuJ3Qgc2hvdyBhbnkgd2FybmluZyB3aGlsZSBi
dWlsZGluZyBlbGYyZG1wLg0KPg0KTWF5YmUgeW91IGFyZSByaWdodCwgbXkgR0NDIHZlcnNpb24g
bG93ZXIoIDcuMy4wKS4NCg0KPg0KPj4gSWYgd2UgcHV0IHRoZSBpbml0aWFsaXphdGlvbiBvdXRz
aWRlIHRoZSBpZigpIHN0YXRlbWVudCwgaXQgbWlnaHQNCj4+IGxvb2tzIGJldHRlciB3aXRob3V0
IGFmZmVjdGluZyB0aGUgZnVuY3Rpb25hbGl0eSA/DQo+DQo+Rm9yIG5vdywgeW91ciBvcmlnaW5h
bCBwYXRjaCBhZmZlY3RzIHRoZSBmdW5jdGlvbmFsaXR5LiBUaGUgdXRpbGl0eSB0cmllcyB0bw0K
PnJlc29sdmUgc3ltYm9scyBhcyBsaXR0bGUgYXMgcG9zc2libGUgZHVyaW5nIGNvbnZlcnNpb24s
IGJlY2F1c2Ugd2UgZG9uJ3QNCj5rbm93IGV4YWN0bHkgaG93IFdpbmRvd3Mga2VybmVsIHdvcmtz
LiBUaGlzIGlzIHRoZSByZWFzb24gd2h5IEtEQkcNCj5oZWFkZXIgc2hvdWxkIGJlIGNoZWNrZWQg
YmVmb3JlIHJlc29sdmluZyAzIHN5bWJvbHMuDQo+DQpPSyAsICBsZXQncyBkcm9wIHRoaXMgcGF0
Y2guDQoNClRoYW5rcy4NCj4+DQo+PiBUaGFua3MuDQo+PiA+LS0NCj4+ID5WaWt0b3IgUHJ1dHlh
bm92DQo+DQo+DQo+DQo+LS0NCj5WaWt0b3IgUHJ1dHlhbm92DQo=

