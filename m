Received: from eggs.gnu.org ([209.51.188.92]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWCw-0000sC-Bp
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWCv-0007gx-Dm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:29:14 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 8 Apr 2019 15:29:07 +0000
Message-ID: <3fb2301b-dccf-178f-92fd-8ba4445642e3@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
	<3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
	<w514l78y10t.fsf@maestria.local.igalia.com>
In-Reply-To: <w514l78y10t.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AAEE3023D6CC747B746AC82D350DEFB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MjIsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBNb24g
MDggQXByIDIwMTkgMDU6MTY6MjIgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiBPbiAwOC8wNC8yMDE5IDE4OjAzLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4+PiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTcgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
Pj4+ICtpbnQgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoQmxvY2tEcml2ZXJTdGF0ZSAqdG9wLA0K
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2Us
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0
X3QgYnl0ZXMsIGludDY0X3QgKnBudW0pDQo+Pj4+ICt7DQo+Pj4+ICsgICAgcmV0dXJuIGJkcnZf
ZG9faXNfYWxsb2NhdGVkX2Fib3ZlKHRvcCwgYmFzZSwgZmFsc2UsIG9mZnNldCwgYnl0ZXMsIHBu
dW0pOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtpbnQgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmVf
aW5jbHVzaXZlKEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0X3Qg
Ynl0ZXMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0
X3QgKnBudW0pDQo+Pj4+ICt7DQo+Pj4+ICsgICAgcmV0dXJuIGJkcnZfZG9faXNfYWxsb2NhdGVk
X2Fib3ZlKHRvcCwgYmFzZSwgdHJ1ZSwgb2Zmc2V0LCBieXRlcywgcG51bSk7DQo+Pj4+ICt9DQo+
Pj4NCj4+PiBJbnN0ZWFkIG9mIGhhdmluZyB0aGVzZSB0d28sIGlzbid0IGl0IHNpbXBsZXIgdG8g
YWRkIGFuICdpbmNsdWRlX2Jhc2UnDQo+Pj4gcGFyYW1ldGVyIHRvIHRoZSBvcmlnaW5hbCBmdW5j
dGlvbj8NCj4+Pg0KPj4+IEFub3RoZXIgYWx0ZXJuYXRpdmUgKEkgaGF2ZW4ndCBjaGVja2VkIHRo
aXMgb25lIHNvIGl0IGNvdWxkIGJlIG1vcmUNCj4+PiBjdW1iZXJzb21lKTogY2hhbmdlIHRoZSBz
ZW1hbnRpY3Mgb2YgdGhlIGZ1bmN0aW9uIHRvIGFsd2F5cyBpbmNsdWRlIHRoZQ0KPj4+IGJhc2Ug
YW5kIG1vZGlmeSB0aGUgY2FsbGVycy4NCj4+DQo+PiBUaGUgaWRlYSBiZWhpbmQgdGhvc2UgdHdv
IGZ1bmN0aW9ucyB3YXMgdG8ga2VlcCB0aGUgcmVzdCBvZiB0aGUgY29kZQ0KPj4gdW5tb2RpZmll
ZC4gQ3VycmVudGx5LCB3ZSBoYXZlIHRoZSBpc3N1ZSB3aXRoIHRoZSBibG9jay1zdHJlYW0NCj4+
IHBhcmFsbGVsIGpvYnMuIFdoYXQgaWYgd2UgbWFuYWdlIHRoaXMgY2FzZSBmaXJzdCBhbmQgdGhl
biwgd2hlbiBwcm92ZWQNCj4+IHRvIGJlIHJvYnVzdCwgdGFrZSBjYXJlIG9mIHRoZSByZXN0Pw0K
PiANCj4gU3VyZSwgdGhhdCBtYWtlcyBzZW5zZSBpZiB5b3UgbmVlZCB0byBkbyBzaWduaWZpY2Fu
dCBjaGFuZ2VzIHRvIHRoZQ0KPiBvdGhlciBjYWxsZXJzLCBidXQgaWYgeW91IGp1c3QgbmVlZCB0
byBwYXNzIGFuIGV4dHJhICdmYWxzZScNCj4gcGFyYW1ldGVyLi4uDQo+IA0KPiBJdCdzIG5vdCBh
IGJpZyBkZWFsLCBJIGp1c3QgdGhpbmsgeW91J2QgaGF2ZSBhIHNpbXBsZXIgcGF0Y2guDQo+IA0K
PiBCZXJ0bw0KPiANCg0KT0ssIEknbGwgZG8gdGhhdCB3aXRoIHRoZSBuZXh0IHY0Lg0KLS0gDQpX
aXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K
