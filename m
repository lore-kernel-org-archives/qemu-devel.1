Received: from eggs.gnu.org ([2001:4830:134:3::10]:59217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQsMs-0003qn-RR
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQsMo-0007LK-3A
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:05:22 -0500
Received: from [45.249.212.188] (port=2438 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQsMh-00070w-Of
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:05:18 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 10 Jan 2017 09:03:45 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA182982@DGGEMA505-MBX.china.huawei.com>
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
	<20170109162504.GH29989@redhat.com>
In-Reply-To: <20170109162504.GH29989@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: longpeng <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

SGksDQoNCj4gDQo+IE9uIE1vbiwgSmFuIDA5LCAyMDE3IGF0IDAxOjQzOjEwUE0gKzAwMDAsIFN0
ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4gPiBPbiBNb24sIEphbiAwOSwgMjAxNyBhdCAwMzowNDo1
NVBNICswODAwLCBMb25ncGVuZyAoTWlrZSkgd3JvdGU6DQo+ID4gPiBJJ20gb25lIG9mIEdvbmds
ZWkncyB2aXJ0aW8tY3J5cHRvIHByb2plY3QgbWVtYmVycywgYW5kIHdlIHBsYW4gdG8gYWRkIGEN
Cj4gQUZfQUxHDQo+ID4gPiBiYWNrZW5kIGZvciB2aXJ0aW8tY3J5cHRvKHRoZXJlJ3Mgb25seSBi
dWlsdGluLWJhY2tlbmQgY3VycmVudGx5KS4NCj4gPiA+DQo+ID4gPiBJIGZvdW5kIHRoYXQgQ2F0
YWxpbiwgUGFvbG8gYW5kIFN0ZWZhbiBoYWQgZGlzY3Vzc2VkIGFib3V0IHRoaXMgaW4gMjAxNQ0K
PiA+ID4gKGh0dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMva3ZtL21zZzExNTQ1Ny5odG1sKSwg
YnV0IGl0IHNlZW1zIHRoYXQNCj4gQ2F0YWxpbg0KPiA+ID4gZGlkbid0IGRvIGl0LCBzbyBJJ20g
Y29uZnVzZSBhYm91dCB3ZXRoZXIgaXQgaXMgbmVlZCB0byBhZGQgYSBBRl9BTEcNCj4gYmFja2Vu
ZC4NCj4gPiA+DQo+ID4gPiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbj8gVGhhbmtzIDopDQo+
ID4NCj4gPiBJIGhhdmUgbm8gb2JqZWN0aW9ucyB0byBhbiBBRl9BTEcgYmFja2VuZCBpbiBRRU1V
Lg0KPiANCj4gUmF0aGVyIHRoYW4gZG8gYW5vdGhlciBiYWNrZW5kIGZvciB2aXJ0aW8tY3J5cHRv
LCBJTUhPLCB3ZSBzaG91bGQgaGF2ZQ0KPiBhbiBBRl9BTEcgaW1wbCBvZiB0aGUgY3J5cHRvLyBB
UElzLiBUaGF0IHdheSBhbnkgcG90ZW50aWFsIHBlcmZvcm1hbmNlDQo+IGJlbmVmaXRzIHdpbGwg
ZW5oYW5jZSBvdXIgTFVLUyBlbmNyeXB0aW9uIGNvZGUgdG9vLg0KPiANCkFjY29yZGluZyB0byB0
aGUgY3VycmVudGx5IHNjaGVtYXMgb2YgY3J5cHRvLyBBUElzLCB3ZSBjYW4ndCBjaG9vc2UgdGhl
DQpzcGVjaWZpYyBiYWNrZW5kIGR5bmFtaWNhbGx5LiBUaGlzIGlzIGEgbGltaXRhdGlvbiBmb3Ig
dmlydGlvLWNyeXB0byBkZXZpY2UgSSB0aGluay4NCg0KSWYgYW4gQUZfQUxHIGJhY2tlbmQgaXMg
c3VwcG9ydGVkLCB3ZSBjYW4gZGlyZWN0bHkgdXNlIHRoZSBoYXJkd2FyZQ0KYWNjZWxlcmF0b3Jz
IGJhc2VkIG9uIExLQ0YsIHdoaWNoIG1ha2VzIG1hbnkgc2Vuc2UuDQoNClJlZ2FyZHMsDQotR29u
Z2xlaQ0K
