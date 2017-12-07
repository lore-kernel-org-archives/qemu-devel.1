Received: from eggs.gnu.org ([2001:4830:134:3::10]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <avi.cohen@huawei.com>) id 1eMskx-0001IM-Vi
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <avi.cohen@huawei.com>) id 1eMsku-00024G-U7
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:46:16 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:33331 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <avi.cohen@huawei.com>)
	id 1eMsku-00023i-Mk
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:46:12 -0500
From: "Avi Cohen (A)" <avi.cohen@huawei.com>
Date: Thu, 7 Dec 2017 09:46:06 +0000
Message-ID: <B84047ECBD981D4B93EAE5A6245AA3610159329D@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] virtio - mem-page swap for inter vm
 comm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang,
	Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

PiBPbiAyMDE35bm0MTLmnIgwN+aXpSAxNjowNCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiA+
IE9uIFRodSwgRGVjIDcsIDIwMTcgYXQgNzo1NCBBTSwgQXZpIENvaGVuIChBKSA8YXZpLmNvaGVu
QGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+PiBUaGVyZSBpcyBhbHJlYWR5IGEgIHZpcnRpbyBt
ZWNoYW5pc20gaW4gd2hpY2ggMiBWTXMgYXNzaWduZWQgYSB2aXJ0aW8gZGV2aWNlDQo+ICwgYXJl
IGNvbW11bmljYXRpbmcgdmlhIGEgdmV0aCBwYWlyICBpbiB0aGUgaG9zdCAuDQo+ID4+IEtWTSBq
dXN0IHBhc3NlcyAgYSBwb2ludGVyIG9mIHRoZSBwYWdlIG9mIHRoZSB3cml0ZXIgVk0gdG8gdGhl
IHJlYWRlcg0KPiA+PiBWTSAtIHJlc3VsdGluZyAgaW4gIGV4Y2VsbGVudCBwZXJmb3JtYW5jZSAo
bm8gdlN3aXRjaCBpbiB0aGUgbWlkZGxlKQ0KPiA+PiAqKlF1ZXN0aW9uKio6ICBXaGF0IGlzIHRo
ZSBhZHZhbnRhZ2Ugb2Ygdmhvc3QtcGNpIGNvbXBhcmVkIHRvIHRoaXMgPw0KPiA+IFdoaWNoIG1l
Y2hhbmlzbSBkbyB5b3UgbWVhbj8NCj4gPg0KPiA+IHZob3N0LXBjaSB3aWxsIGFsbG93IFZNLXRv
LVZNIGNvbW11bmljYXRpb24gd2l0aG91dCB2bWV4aXRzIHdoZW4NCj4gPiBwb2xsaW5nIG1vZGUg
aXMgdXNlZC4gIERvZXMgdGhlIG1lY2hhbmlzbSB5b3UgYXJlIHRoaW5raW5nIGFib3V0DQo+ID4g
cmVxdWlyZSB2bWV4aXRzPw0KPiA+DQo+ID4gU3RlZmFuDQo+IA0KPiBJIGd1ZXNzIHdoYXQgQXZp
IG1lYW5zIGlzIHByb2JhYmx5IHZldGggdGFwIHN1cHBvcnQgKFJGQykgaGVyZToNCj4gDQo+IGh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c0NTQwNDAuaHRtbA0KPiANCj4g
QnV0IGluIGZhY3QsIHdlIGRvbid0IG5lZWQgdmV0aCBhdCBhbGwsIGJ5IHVzaW5nIHJ4IGhhbmRs
ZXIgdHJpY2ssIHdlIGNhbiBlYXNpbHkNCj4gaW1wbGVtZW50IHBhaXIgbW9kZSBvbiBUVU4vVEFQ
Lg0KPiANCltBdmkgQ29oZW4gKEEpXSANCkkgY2hhbmdlZCB0aGUgc3ViamVjdCBzbyBhcyBub3Qg
dG8gaW50ZXJmZXJlIHdpdGggdGhlIG9yaWdpbmFsIHRocmVhZA0KSSBhbSB0cnlpbmcgIHRvIGZp
bmQgcmVmZXJlbmNlIGZvciB0aGUgbWVtLXBhZ2Ugc3dhcHBpbmcgbWVjaGFuaXNtIC0gd2l0aG91
dCAgc3VjY2VzcyB0aWxsIG5vdyAuLg0KQmVzdCBSZWdhcmRzDQpBdmkNCg0K
