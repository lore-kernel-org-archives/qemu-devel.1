Received: from eggs.gnu.org ([2001:4830:134:3::10]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFADc-0003O4-S1
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 20:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFADZ-0004iC-Q5
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 20:43:24 -0500
Received: from [45.249.212.189] (port=2369 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFADY-0004g3-H3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 20:43:21 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 9 Dec 2016 01:42:41 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA158099@DGGEMA505-MBX.china.huawei.com>
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
	<20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
	<9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
In-Reply-To: <9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>

SGksDQoNCj4NCj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggZm9yLTIuOSB2Ml0g
dmlydGlvLWNyeXB0bzogemVyb2l6ZSB0aGUga2V5DQo+IG1hdGVyaWFsIGJlZm9yZSBmcmVlDQo+
IA0KPiBPbiAwOC4xMi4yMDE2IDE2OjIzLCBFcmljIEJsYWtlIHdyb3RlOg0KPiA+IE9uIDEyLzA3
LzIwMTYgMDg6MjggUE0sIEdvbmdsZWkgKEFyZWkpIHdyb3RlOg0KPiA+DQo+ID4+PiBBcyBmYXIg
YXMgSSdtIGF3YXJlLCBvdGhlciBwcm9qZWN0cyB1c3VhbGx5IGhhdmUgYSBzcGVjaWFsIG1lbXNl
dA0KPiA+Pj4gdmFyaWF0aW9uIGZvciBkb2luZyB0aGlzLiBUaGF0IGlzIGJlY2F1c2UgY29tcGls
ZXJzIG1heSBjaG9vc2UgdG8NCj4gPj4+ICJvcHRpbWl6ZSIgbWVtc2V0KHAsIC4uLikgKyBmcmVl
KHApIHRvIGp1c3QgdGhlIGZyZWUocCkuIEhhdmluZyBhDQo+ID4+DQo+ID4+IEFjdHVhbGx5LCBJ
IGdvb2dsZWQgdGhpcywgYnV0IEkgZGlkbid0IGZpbmQgYSBkZWZpbml0ZSBhbnN3ZXIuIEFuZA0K
PiA+Pg0KPiA+PiBUaGUgTGludXgga2VybmVsIHVzZXMga3pmcmVlIGluc3RlYWQgb2YgbWVtc2V0
ICsga2ZyZWUNCj4gKG1tL3NsYWJfY29tbW9uLmMpLg0KPiANCj4gV2VsbCwgSSBwZXJzb25hbGx5
IGRvbid0IG1pbmQgd2hldGhlciB3ZSB1c2UgYSBjdXN0b20gemZyZWUoKSBvciBhDQo+IGN1c3Rv
bSBtZW1zZXRfcygpICsgZnJlZSgpLiBJIG9ubHkgbWluZCB0aGF0IHRoaXMgcGF0Y2ggYWN0dWFs
bHkgYWx3YXlzDQo+IGRvZXMgd2hhdCBpdCBpcyBpbnRlbmRlZCB0byBkby4NCj4gDQpZZXMsIGJ1
dCB3aHkgbGludXgga2VybmVsIHRvIHRoaW5rIGFib3V0IHRoZSBjb21waWxlciBvcHRpbWl6YXRp
b24gZm9yDQptZW1zZXQgZm9yIHNlbnNpdGl2ZSBkYXRhPw0KDQo+ID4gSWYgd2UncmUgd29ycmll
ZCBhYm91dCBjbGVhbmluZyB0aGluZ3Mgd2l0aG91dCBhbGxvd2luZyB0aGUgY29tcGlsZXIgYQ0K
PiA+IGNoYW5jZSB0byBvcHRpbWl6ZSwgdGhlbiB3cml0aW5nIG91ciBvd24gcWVtdV96ZnJlZSgp
IHdyYXBwZXIgbWF5IGluZGVlZA0KPiA+IG1ha2Ugc2Vuc2UuICBCdXQgdGhhdCB3b24ndCBjb3Zl
ciB0aGUgY2FzZSBpbiBEYW5pZWwncyBlYXJsaWVyIHBhdGNoDQo+ID4gKHJlZmVyZW5jZWQgZWxz
ZXdoZXJlIGluIHRoaXMgdGhyZWFkKSwgYXMgdGhhdCB3YXMgemVyb2l6aW5nIHN0YWNrDQo+ID4g
bWVtb3J5IChiZWZvcmUgaXQgd2VudCBvdXQgb2Ygc2NvcGUpIHJhdGhlciB0aGFuIGhlYXAgbWVt
b3J5IChiZWZvcmUNCj4gPiBmcmVlKS4gIFNvIHlvdSdkIHN0aWxsIG5lZWQgc29tZSBzb3J0IG9m
ICd3cml0ZSB0aGlzIG1lbW9yeSBubyBtYXR0ZXINCj4gPiB3aGF0JyBwcmltaXRpdmUgdGhhdCB3
b3VsZCBiZSBkaXJlY3RseSB1c2FibGUgb24gc3RhY2sgbWVtb3J5IGFuZA0KPiA+IGluZGlyZWN0
bHkgdXNlZCBhcyBwYXJ0IG9mIHRoZSBxZW11X3pmcmVlKCkgd3JhcHBlci4NCj4gPg0KSWYgd2Ug
d3JhcCBhIHNlY3VyZV9tZW1zZXQoKSwgdGhlbiBib3RoIHN0YWNrIG1lbW9yeSBhbmQgaGVhcA0K
bWVtb3J5IGNhbiB1c2UgaXQuDQoNClBscyBzZWU6DQoNCmh0dHA6Ly93d3cub3Blbi1zdGQub3Jn
L2p0YzEvc2MyMi93ZzE0L3d3dy9kb2NzL24xMzgxLnBkZg0KDQpCdXQgdGhlIHNlY3VyZV9tZW1z
ZXQoKSBpcyBub3QgYXMgZWZmaWNpZW50IGFzIHBvc3NpYmxlIGR1ZSB0byB0aGUgbmF0dXJlIG9m
IHRoZSB2b2xhdGlsZQ0KdHlwZSBxdWFsaWZpZXIgcHJldmVudGluZyB0aGUgY29tcGlsZXIgZnJv
bSBvcHRpbWl6aW5nIHRoZSBjb2RlIGF0IGFsbC4gDQoNCkl0IHdpbGwgY2F1c2UgaHVnZSBwZXJm
b3JtYW5jZSByZWdyZXNzaW9uIGF0IGhvdCBwYXRoIG9mIGRhdGEgcGxhbmUuLi4NCg0KPiA+IEJ1
dCBJIHdvdWxkbid0IHdvcnJ5IGFib3V0IGl0IGZvciBub3csIHVubGVzcyBzb21lb25lIHByb3Zl
cyB3ZSBhY3R1YWxseQ0KPiA+IGhhdmUgYSBjb21waWxlciBvcHRpbWl6aW5nIGF3YXkgdGhlIGNs
ZWFudXBzLg0KPiANCj4gSXQncyB0cnVlIHRoYXQgd2UgZG9uJ3QgaGF2ZSB0byB3b3JyeSBhYm91
dCBpdCAqbm93KiwgYnV0IHRoZSBhcHByb2FjaA0KPiBvZiB3YWl0aW5nIHVudGlsIHRoZSBjb21w
aWxlciBicmVha3MgaXQgZG9lcyBub3Qgc2VlbSByaWdodCB0byBtZS4NCj4gDQo+IElmIGF0IHNv
bWUgcG9pbnQgc29tZSBjb21waWxlciByZWNvZ25pemVzIGdfZnJlZSgpIGFzIGJlaW5nIHRoZSBz
YW1lDQo+IGZ1bmN0aW9uIGFzIGZyZWUoKSBhbmQgdGh1cyBvcHRpbWl6ZXMgbWVtc2V0KCkgKyBn
X2ZyZWUoKSwgd2Ugc2ltcGx5DQo+IHdvbid0IG5vdGljZSBiZWNhdXNlIG5vYm9keSB3aWxsIGtl
ZXAgdHJhY2sgb2YgdGhlIGdlbmVyYXRlZCBhc3NlbWJseQ0KPiBvdXRwdXQgYWxsIHRoZSB0aW1l
Lg0KPiANCj4gVGhlcmUgaXMgYSByZWFzb24gQzExIGludHJvZHVjZWQgbWVtc2V0X3MoKSwgYW5k
IGl0IGlzIHRoaXMuDQo+IA0KLi4uZG9lcyBpdCBtYWtlIHNlbnNlIGlmIHdlIGludHJvZHVjZSBz
ZWN1cmVfbWVtc2V0KCkgbm93ID8gDQoNCldhaXRpbmcgZm9yIHlvdXIgZmVlZGJhY2suIFRoYW5r
cyENCg0KDQpSZWdhcmRzLA0KLUdvbmdsZWkNCg==
