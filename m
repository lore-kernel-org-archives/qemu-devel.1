Received: from eggs.gnu.org ([209.51.188.92]:41209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghWrW-0001nf-9w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghWrV-0001Dd-Is
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:42:54 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 10 Jan 2019 09:42:44 +0000
Message-ID: <d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<8736q3ebs2.fsf@dusky.pond.sub.org>
In-Reply-To: <8736q3ebs2.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <46B365AE9A24174D89AA1D01CB275C89@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>

SGksDQoNCk9uIDEvOC8xOSAxMTozMSBBTSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IEkn
ZCBsZWF2ZSBpdCBoYXJkLWNvZGVkLiAgUmVwbGFjaW5nIGEgZmV3IHRyaXZpYWwgZGVmaW5lcyBi
eSBhbiBhcmd1YWJseQ0KPiBsZXNzIHRyaXZpYWwgc2NyaXB0IGRvZXNuJ3QgZmVlbCBsaWtlIGFu
IGltcHJvdmVtZW50LiAgSW4gdGhpcyBjYXNlLCBpdA0KPiBkb2Vzbid0IGV2ZW4gc2F2ZSBsaW5l
cy4NCg0KQXMgSSd2ZSBzYWlkLCBJJ20gZmluZSB3aXRoIHRoYXQuIFRoZSBhdXRvZ2VuZXJhdGlv
biBzb3VuZHMgdGhlIHJpZ2h0IA0KdGhpbmcgdG8gZG8gaGVyZSwgYXMgdGhlIHRhYmxlIGlzIGF1
dG9nZW5lcnRhZWQgYW55d2F5LCBidXQgaW5kZWVkIGl0IGlzIA0KYWxyZWFkeSB0aGVyZSwgZXhw
bGFpbmVkLCBhbmQgZXZlbiB0aGUgc2NyaXB0IGZvciBnZW5lcmF0aW5nIGl0IGFwcGVhcnMgDQpp
biB0aGUgY29tbWVudHMgZm9yIHJlcHJvZHVjaWJpbGl0eS4NCg0KPiANCj4gSSdtIG5vdCBzdXJl
IEknZCB1c2Ugc2hlbGwgZm9yIHRoaXMsIGJ1dCBzaW5jZSB5b3UgYWxyZWFkeSB3cm90ZSBpdCBh
bmQNCj4gaXQgd29ya3MuLi4NCj4gDQoNCklmIHlvdSd2ZSBub3RpY2VkLCB0aGUgb3JpZ2luYWwg
c2NyaXB0IHdhcyBpbiBBV0suIEJ1dCB0byBiZSBhcyBnZW5lcmljIA0KYXMgcG9zc2libGUsIEkg
ZGlkbid0IHdyaXRlIHRoZSBnZW5lcmF0aW9uIHNjcmlwdCBpbiBBV0sgYmVjYXVzZSBldmVuIA0K
QVdLIGlzIG5vdCBndWFyYW50ZWVkIHRvIGJlIGluc3RhbGxlZCBvbiB0aGUgYnVpbGQgc3lzdGVt
LiBUaGUgb25seSANCmludGVycHJldGVkIGxhbmd1YWdlIHRoYXQgaXMgZ3VhcmFudGVlZCB0byBi
ZSB0aGVyZSBpcyBzaGVsbCAobW9zdCBiYXNpYyANCnNoZWxsKSBiZWNhdXNlIC5jb25maWd1cmUg
aXRzZWxmIG5lZWRzIGl0Lg0KDQpTdXJlLCB0aGUgc2NyaXB0IGNvdWxkIGJlIHByZXR0aWVyIGFu
ZCBzaG9ydGVyLCBidXQgSSB3YW50ZWQgdG8ga2VlcCBpdCANCmNvbXBhdGlibGUgd2l0aCB0aGUg
bW9zdCBiYXNpYyBzaGVsbCwgbm90IG9ubHkgQmFzaCwgYW5kIHdpdGhvdXQgbmVlZGluZyANCmV4
dGVybmFsIHByb2dyYW1zLg0KDQpFcmljIC0gdGhhbmtzIGZvciB0aGUgY29tbWVudCBhYm91dCAn
bG9jYWwnIC0gSSB3aWxsIGdldCByaWQgb2YgaXQgaWYgd2UgDQpkZWNpZGUgdG8gaW5jbHVkZSB0
aGlzIHBhdGNoLg0KDQo+IA0KPiBVbmNoZWNrZWQgdXNlIG9mIGNvbW1hbmQtbGluZSBhcmd1bWVu
dHMgaXMgbm90IG5pY2U6DQo+IA0KPiAgICAgICQgc2NyaXB0cy9nZW4tc2l6ZXMuc2gNCj4gICAg
ICBzY3JpcHRzL2dlbi1zaXplcy5zaDogbGluZSA2NDogOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5DQo+ICAgICAgc2NyaXB0cy9nZW4tc2l6ZXMuc2g6IGxpbmUgNjU6IDogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQ0KPiAgICAgIHNjcmlwdHMvZ2VuLXNpemVzLnNoOiBsaW5lIDY2OiA6IE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gDQo+IFlvdSBzaG91bGQgZXJyb3Igb3V0IGlmICQj
IC1uZSAxLiAgQnV0IGluIHN1Y2ggYSBzaW1wbGUgc2NyaXB0LCBJJ2QNCj4gZGlzcGVuc2Ugd2l0
aCBhcmd1bWVudHMgYW5kIHByaW50IHRvIHN0ZG91dC4gIE1hdHRlciBvZiB0YXN0ZS4NCj4gUmVq
ZWN0aW5nICQjIC1uZSAwIGlzIHN0aWxsIG5pY2UgdGhlbi4NCj4gDQoNCkFncmVlLCB0aGFua3Mh
DQoNCkxlb25pZC4NCl9fXw0K
