Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ceAwh-0000In-9D
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ceAwd-0003ej-5b
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:33:19 -0500
Received: from [45.249.212.189] (port=2394 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ceAwb-0003cU-R6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:33:15 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 16 Feb 2017 01:31:40 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
	<1486980300.17184.28.camel@redhat.com>
In-Reply-To: <1486980300.17184.28.camel@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Rozenfeld <vrozenfe@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>

SGksDQoNCj4gDQo+IE9uIFNhdCwgMjAxNy0wMi0xMSBhdCAxMDozOSAtMDUwMCwgUGFvbG8gQm9u
emluaSB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBPbiAxMC8wMi8yMDE3
IDEwOjMxLCBHb25nbGVpIChBcmVpKSB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEJ1dCBX
ZSB0ZXN0ZWQgdGhlIHNhbWUgY2FzZXMgb24gWGVuIHBsYXRmb3JtIGFuZCBWTXdhcmUsIGFuZA0K
PiA+ID4gPiA+IHRoZSBndWVzdCBib290ZWQgc3VjY2Vzc2Z1bGx5Lg0KPiA+ID4gPg0KPiA+ID4g
PiBXZXJlIHRoZXNlIHR3byBhbHNvIHRlc3RlZCB3aXRoIGVubGlnaHRlbm1lbnRzIGVuYWJsZWQ/
wqDCoFRDRw0KPiA+ID4gPiBzdXJlbHkgaXNuJ3QuDQo+ID4gPg0KPiA+ID4gQWJvdXQgVENHLCBJ
IGp1c3QgcmVtb3ZlICcgYWNjZWw9a3ZtLCcgYW5kICdoeV9yZWxlYXhlZCcgZnJvbSB0aGUNCj4g
PiA+IGJlbG93IFFFTVUNCj4gPiA+IENvbW1hbmQgbGluZSwgSSB0aG91Z2h0IHRoZSBoeXBlci1W
IGVuYWJsZWQgdGhlbi4gU29ycnkgYWJvdXQgdGhhdC4NCj4gPiA+DQo+ID4gPiBCdXQgZm9yIFhl
biwgd2Ugc2V0ICd2aXJpZGlhbj0xJyB3aGljaCBiZSB0aG91Z2h0IHRoZSBIeXBlci1WIGlzDQo+
ID4gPiBlbmFibGVkLg0KPiA+ID4NCj4gPiA+IEZvciBWTVdhcmUgd2UgYWxzbyBlbmFibGVkIHRo
ZSBIeXBlci1WIGVubGlnaHRlbm1lbnRzLg0KPiBJZiBJJ20gbm90IG1pc3Rha2VuLCBldmVuIEh5
cGVyLVYgc2VydmVyIGRvZXNuJ3QgYWxsb3cgc3BlY2lmeSBtb3JlDQo+IHRoYW4gNjQgdkNQVXMg
Zm9yIEdlbmVyYXRpb24gMSBWTXMuDQoNCk5vcm1hbGx5IHllcywgYnV0IEkgZm91bmQgdGhlIGV4
cGxhbmF0aW9uIGZyb20gTWljcm9zb2Z0IGRvY3VtZW50IGFib3V0IGl0Og0KDQpNYXhpbXVtIFN1
cHBvcnRlZCBWaXJ0dWFsIFByb2Nlc3NvcnMNCg0KT24gV2luZG93cyBvcGVyYXRpbmcgc3lzdGVt
cyB2ZXJzaW9ucyB0aHJvdWdoIFdpbmRvd3MgU2VydmVyIDIwMDggUjIsIA0KcmVwb3J0aW5nIHRo
ZSBIViMxIGh5cGVydmlzb3IgaW50ZXJmYWNlIGxpbWl0cyB0aGUgV2luZG93cyB2aXJ0dWFsIG1h
Y2hpbmUgDQp0byBhIG1heGltdW0gb2YgNjQgVlBzLCByZWdhcmRsZXNzIG9mIHdoYXQgaXMgcmVw
b3J0ZWQgdmlhIENQVUlELjQwMDAwMDA1LkVBWC4NClN0YXJ0aW5nIHdpdGggV2luZG93cyBTZXJ2
ZXIgMjAxMiBhbmQgV2luZG93cyA4LCBpZiBDUFVJRC40MDAwMDAwNS5FQVggDQpjb250YWlucyBh
IHZhbHVlIG9mIC0xLCBXaW5kb3dzIGFzc3VtZXMgdGhhdCB0aGUgaHlwZXJ2aXNvciBpbXBvc2Vz
IG5vIHNwZWNpZmljDQpsaW1pdCB0byB0aGUgbnVtYmVyIG9mIFZQcy4gSW4gdGhpcyBjYXNlLCBX
aW5kb3dzIFNlcnZlciAyMDEyIGd1ZXN0IFZNcyBtYXkNCnVzZSBtb3JlIHRoYW4gNjQgVlBzLCB1
cCB0byB0aGUgbWF4aW11bSBzdXBwb3J0ZWQgbnVtYmVyIG9mIHByb2Nlc3NvcnMgDQphcHBsaWNh
YmxlIHRvIHRoZSBzcGVjaWZpYyBXaW5kb3dzIHZlcnNpb24gYmVpbmcgdXNlZC4NCg0KTGluazog
aHR0cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20vZW4tdXMvdmlydHVhbGl6YXRpb24vaHlwZXItdi1v
bi13aW5kb3dzL3JlZmVyZW5jZS90bGZzDQoNCiJSZXF1aXJlbWVudHMgZm9yIEltcGxlbWVudGlu
ZyB0aGUgTWljcm9zb2Z0IEh5cGVydmlzb3IgSW50ZXJmYWNlIg0KDQpBbmQgdGhlIGJlbG93IHBh
dGNoIHdvcmtzIGZvciBtZSwgSSBjYW4gc3VwcG9ydCBtYXggMjU1IHZjcHVzIGZvciBXUzIwMTIN
CndpdGggaHlwZXItdiBlbmxpZ2h0ZW5tZW50cy4NCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2
L2t2bS5jIGIvdGFyZ2V0L2kzODYva3ZtLmMNCmluZGV4IDI3ZmQwNTAuLmVmZTNjYmMgMTAwNjQ0
DQotLS0gYS90YXJnZXQvaTM4Ni9rdm0uYw0KKysrIGIvdGFyZ2V0L2kzODYva3ZtLmMNCkBAIC03
NzIsNyArNzcyLDcgQEAgaW50IGt2bV9hcmNoX2luaXRfdmNwdShDUFVTdGF0ZSAqY3MpDQoNCiAg
ICAgICAgIGMgPSAmY3B1aWRfZGF0YS5lbnRyaWVzW2NwdWlkX2krK107DQogICAgICAgICBjLT5m
dW5jdGlvbiA9IEhZUEVSVl9DUFVJRF9JTVBMRU1FTlRfTElNSVRTOw0KLSAgICAgICAgYy0+ZWF4
ID0gMHg0MDsNCisgICAgICAgIGMtPmVheCA9IC0xOw0KICAgICAgICAgYy0+ZWJ4ID0gMHg0MDsN
Cg0KICAgICAgICAga3ZtX2Jhc2UgPSBLVk1fQ1BVSURfU0lHTkFUVVJFX05FWFQ7DQoNCj4gSW4g
YW55IGNhc2UsIGlmIHlvdSBhcmUgb25seSBpbnRlcmVzdGVkIGluIGh2X3JlbGF4ZWQsIHlvdSBj
YW4gZHJvcCBpdA0KPiBvZmYgZm9yIFdTMjAxMiBhcyBsb25nIGFzIHlvdSBoYXZlIGNwdSBoeXBl
cnZpc29yIGZsYWcNCj4gKENQVUlELjE6RUNYwqBbYml0wqAzMV09MSkgdHVybmVkIG9uLg0KPiAN
Cmh5X3JlbGF4ZWQgaXMganVzdCBhIGV4YW1wbGUgb2YgZW5hYmxpbmcgaHlwZXJ2LXYgZW5saWdo
dGVubWVudHMuDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=
