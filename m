Received: from eggs.gnu.org ([2001:4830:134:3::10]:43666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoX9-0001YK-Rm
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoX6-0006k8-Lt
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:34:07 -0500
Received: from [45.249.212.189] (port=2368 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoX5-0006Zy-11
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:34:04 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 02:33:29 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
In-Reply-To: <6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

Pg0KPiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6
IFdlZG5lc2RheSwgRGVjZW1iZXIgMDcsIDIwMTYgMTE6MjIgUE0NCj4gVG86IEdvbmdsZWkgKEFy
ZWkpOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBzdGVmYW5o
YUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggZm9yLTIuOSB2Ml0gdmlydGlvLWNy
eXB0bzogemVyb2l6ZSB0aGUga2V5IG1hdGVyaWFsIGJlZm9yZQ0KPiBmcmVlDQo+IA0KPiBPbiAx
Mi8wNi8yMDE2IDA4OjI5IFBNLCBHb25nbGVpIHdyb3RlOg0KPiA+IENvbW1vbiBwcmFjdGljZSB3
aXRoIHNlbnNpdGl2ZSBpbmZvcm1hdGlvbiAoa2V5IG1hdGVyaWFsLCBwYXNzd29yZHMsDQo+ID4g
ZXRjKS4gUHJldmVudHMgc2Vuc2l0aXZlIGluZm9ybWF0aW9uIGZyb20gYmVpbmcgZXhwb3NlZCBi
eSBhY2NpZGVudCBsYXRlciBpbg0KPiA+IGNvcmVkdW1wcywgbWVtb3J5IGRpc2Nsb3N1cmUgYnVn
cyB3aGVuIGhlYXAgbWVtb3J5IGlzIHJldXNlZCwgZXRjLg0KPiA+DQo+ID4gU2Vuc2l0aXZlIGlu
Zm9ybWF0aW9uIGlzIHNvbWV0aW1lcyBhbHNvIGhlbGQgaW4gbWxvY2tlZCBwYWdlcyB0byBwcmV2
ZW50DQo+ID4gaXQgYmVpbmcgc3dhcHBlZCB0byBkaXNrIGJ1dCB0aGF0J3Mgbm90IGJlaW5nIGRv
bmUgaGVyZS4NCj4gDQo+IEkgYWxzbyB0aGluayB0aGF0IHBvaW50aW5nIHRvIGVhcmxpZXIgY29t
bWl0IGlkcyB3aXRoIHNpbWlsYXIgYmVoYXZpb3INCj4gaXMgYSBnb29kIGlkZWE7IGluIG90aGVy
IHdvcmRzLCBjYWxsIG91dCBjb21taXQgODgxMzgwMGIuICBTbyBtYXliZQ0KPiByZXdvcmsgdGhp
cyBzZWNvbmQgcGFyYWdyYXBoIHRvOg0KPiANCj4gU2Vuc2l0aXZlIGluZm9ybWF0aW9uIGlzIHNv
bWV0aW1lcyBhbHNvIGhlbGQgaW4gbWxvY2tlZCBwYWdlcyB0byBwcmV2ZW50DQo+IGl0IGJlaW5n
IHN3YXBwZWQgdG8gZGlzaywgYnV0IHFlbXUgaW4gZ2VuZXJhbCBpcyBub3QgY3VycmVudGx5IHRh
a2luZw0KPiB0aGF0IGxldmVsIG9mIHByZWNhdXRpb24gKHNlZSBhbHNvIGNvbW1pdCA4ODEzODAw
YikuDQo+IA0KPiA+DQo+ID4gTGV0J3MgemVyb2l6ZSB0aGUgbWVtb3J5IG9mIENyeXB0b0RldkJh
Y2tlbmRTeW1PcEluZm8gc3RydWN0dXJlIHBvaW50ZWQNCj4gPiBmb3Iga2V5IG1hdGVyaWFsIHNl
Y3VyaXR5Lg0KPiA+DQo+ID4gW3YyOiBTdGVmYW4gcGVyZmVjdHMgdGhlIGNvbW1pdCBtZXNzYWdl
LCB0aGFua3NdDQo+IA0KPiBUaGUgdjIgYmx1cmIgc2hvdWxkIGFwcGVhciBhZnRlciB0aGUgLS0t
IGxpbmUsIGFzIGl0IGlzIG5pY2UgZm9yDQo+IHJldmlld2VycyBidXQgYSB5ZWFyIGZyb20gbm93
IHdoZW4gcmVhZGluZyAnZ2l0IGxvZycgd2Ugd29uJ3QgY2FyZSBob3cNCj4gbWFueSB2ZXJzaW9u
cyB3ZXJlIG9uIHRoZSBsaXN0LCBvbmx5IGFib3V0IHRoZSBvbmUgdmVyc2lvbiBpbiBnaXQuDQo+
IA0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIGp1c3Qgd2FudGVkIHRvIGtlZXAgdGhlIFN0ZWZhbidz
IHdvcmsgYmVjYXVzZQ0KdGhlIG1vc3Qgb2YgY29tbWl0IG1lc3NhZ2UgY29tZXMgZnJvbSBoaW0u
IDopDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBHb25nbGVpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBody92aXJ0aW8vdmlydGlvLWNyeXB0by5jIHwgMTMgKysrKysrKysr
KysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2UgbWF5IHN0aWxsIG5lZWQgaW1wcm92ZW1l
bnQsIGJ1dCB0aGUgbWFpbnRhaW5lciBtaWdodA0KPiBiZSB3aWxsaW5nIHRvIGRvIHRoYXQgd2l0
aG91dCBuZWVkaW5nIGEgdjMuICBBdCBhbnkgcmF0ZSwNCj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxh
a2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiANClRoYW5rcy4NCg0KUmVnYXJkcywNCi1Hb25nbGVp
DQoNCg==
