Received: from eggs.gnu.org ([2001:4830:134:3::10]:34673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1eFAY2-0001NI-Gb
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1eFAXy-0008Up-Fr
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:09:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1eFAXx-0008Oi-S3
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:08:58 -0500
From: "Xulei (Stone)" <stone.xulei@huawei.com>
Date: Thu, 16 Nov 2017 03:08:34 +0000
Message-ID: <8E78D212B8C25246BE4CE7EA0E645FE501B57779@dggeml511-mbs.china.huawei.com>
References: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
	<d344052d-ac24-2ce0-38bc-b8008c895946@redhat.com>
	<20171116014346.GA16015@yangzhon-Virtual>
In-Reply-To: <20171116014346.GA16015@yangzhon-Virtual>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Question] Qemu's Heap Becomes Very Large and
 Never Reduce Down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "anthony.xu@intel.com" <anthony.xu@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "liujunjie (A)" <liujunjie23@huawei.com>

PiBPbiBXZWQsIE5vdiAxNSwgMjAxNyBhdCAwMjoxODo1NVBNICswMTAwLCBQYW9sbyBCb256aW5p
IHdyb3RlOg0KPiA+IE9uIDE1LzExLzIwMTcgMDQ6MTQsIFh1bGVpIChTdG9uZSkgd3JvdGU6DQo+
ID4gPiBIaSwgZ3V5cw0KPiA+ID4NCj4gPiA+IEkgbWV0IGEgc3RyYW5nZSBwcm9ibGVtLCB3aXRo
IHFlbXUgMi44LjE6DQo+ID4gPiBxZW11IGNvbnN1bWVzIHRvbyBtYW55IGhlYXAgbWVtb3J5IGFm
dGVyIHNldmVyYWwgb3BlcmF0aW9ucyBhbmQgY2FuDQo+ID4gPiBub3QgcmVsZWFzZSB0aGVtIGFu
eW1vcmU6DQo+ID4gPiBob3QgcHVsZy91bnBsdWcgZGlzayAmIG5ldCwgdm5jIGNvbm5lY3QvZGlz
Y29ubmVjdCzCoGd1ZXN0T1MgcmVib290LCBldGMuDQo+ID4NCj4gPiBUcnkgd2l0aCBuZXdlciBR
RU1VOyB1bnRpbCByZWNlbnRseSB3ZSB1c2VkIGEgbG90IG9mIG1lbW9yeSBhdA0KPiA+IHN0YXJ0
dXAsIGJ1dCBpdCB3YXMgaW1wcm92ZWQgaW4gMi4xMS4NCj4gPg0KPiA+IEhvd2V2ZXIsIEkgdGhp
bmsgQW50aG9ueSBhbHNvIGhhZCBhIHBhdGNoIGFkZGluZyBhIG1hbGxvY190cmltIGNhbGwgaW4N
Cj4gPiB0aGUgUkNVIHRocmVhZCwgd2hpY2ggaW1wcm92ZWQgbWVtb3J5IHVzYWdlLiAgQW50aG9u
eSwgZG8geW91IGtub3cgaWYNCj4gPiB0aGlzIGlzIHN0aWxsIG5lY2Vzc2FyeSBpbiAyLjExPw0K
PiA+DQo+ICAgSGVsbG8gUGFvbG8sDQo+IA0KPiAgIExhc3QgdGltZSwgd2hlbiB5b3UgdHJhdmVs
ZWQgaW4gQmVpSmluZywgd2UgdGFsa2VkIGFib3V0IHRoaXMgbWFsbG9jX3RyaW0oKQ0KPiAgIHNv
bHV0aW9uIGluIFJIIG9mZmljZS4gQXQgdGhhdCB0aW1lLCB5b3UgYXNrZWQgbWUgdG8gc2VuZCB0
aGlzIHBhdGNoIHRvDQo+IHVwc3RyZWFtLg0KPiAgIEkgY2FuIHRyeSB0aGlzIHBhdGNoIGluIHRo
ZSBuZXdlc3QgUWVtdSB2ZXJzaW9uIGlmIHlvdSByZWdhcmQgdGhpcyBzb2x1dGlvbiBpcw0KPiAg
IHN1aXRhYmxlLg0KPiANCj4gICBJIGFsc28gd2FudCB0byBsb29rIGZvciBvdGhlciBtb3JlIGJl
dHRlciBzb2x1dGlvbiwgYnV0IHRoZXJlIGFyZSBzb21lDQo+IHVyZ2VuY3kNCj4gICB0YXNrcyBp
bnRlcnJ1cHQgbWUuDQo+IA0KPiAgIEluIGZhY3QsIEFudGhvbnkgYWxzbyBoYXZlIHNvbWUgb3Ro
ZXIgc29sdXRpb25zIGZvciBoZWFwIG1lbW9yeSBkZWR1Y3Rpb24NCj4gaW4NCj4gICBvdXIgaW50
ZWwgQ2xlYXJDb250YWluZXIuDQo+IA0KDQpUaGFua3MgZm9yIHJlcGx577yBDQogDQpJJ2xsIHRl
c3QgbXkgY2FzZXMgd2l0aCB0aGUgdXBzdHJlYW0gcWVtdSB+DQoNCkluIGZhY3QsIEknZCBsaWtl
IHRyZWF0IHRoaXMgcHJvYmxlbSBhcyBhbiB1bmF3YXJlbmVzcyBidWcuIEJlY2F1c2U6DQoxKSBU
aGlzIHByb2JsZW0gaGFwcGVucyBOT1QgZHVyaW5nIHRoZSBib290dXAgcGhhc2UgYnV0IGFmdGVy
IHNldmVyYWwgb3BlcmF0aW9ucy4NCg0KMikgSXQgaGFwcGVucyBhdCBhIGxvdyBwcm9iYWJpbGl0
eSwgNSBWTXMgb2YgMTAgaG9zdHMgKiAyMCBWTXMgKDEwIGhvc3RzLCBlYWNoIHJ1bnMgMjAgVk1z
KS4NCg0KMylPbmNlIGl0IGhhcHBlbnMsIHdlIGNhbiBOT1QgZGVkdWN0IHRoZSBoZWFwIG1lbW9y
eSB0aHJvdWdoIHVucGx1Z2dpbmcgYWxsIGRpc2tzICYgbmV0cywgDQpkaXNjb25uZWN0aW5nIFZO
QywgYW5kIHJlYm9vdGluZyBndWVzdE9TLg0KDQo0KVJlZmVyIHRvIFN0ZWZhbidzIGFkdmljZSwg
SSBoYXZlIGFscmVhZHkgaXNvbGF0ZWQgbXkgdGVzdHMgdGhhdCBkbyBvbmx5IG9uZSBvcGVyYXRp
b24gcGVyc2lzdGVudGx5IA0Kb25lIHRpbWUuIFRoZSBoZWFwIG1lbW9yeSBkb2VzIG5vdCBncm93
IHVwIHZlcnkgaGlnaC4NCg0KSSBtYXkgdGhpbmsgc3BlY2lmaWMgb3BlcmF0aW9uIHNlcXVlbmNl
IGNhbiB0cmlnZ2VyIHRoaXMgQlVHLg0KSSdsbCBkbyBzb21lIG1vcmUgdGVzdHMsIGFuZCBzdXBw
bHkgbW9yZSB1c2VmdWwgaW5mb3JtYXRpb24gZm9yIFlPVS4NCg0KQlRXLCBJIGFtIG5vdyBhbHNv
IGZvbGxvd2luZyBpbnRlbCBDbGVhckNvbnRhaW5lciBhbmQgSHlwZXIgcHJvamVjdCwgSSB0aGlu
ayB0aGV5IGFyZSBhd2Vzb21lLg0KDQo+ICAgUmVnYXJkcywNCj4gDQo+ICAgWWFuZyBaaG9uZw0K
PiANCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBQYW9sbw0K
