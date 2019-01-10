Received: from eggs.gnu.org ([209.51.188.92]:48174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghdWR-0005OA-FE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghdWQ-0000j8-AZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:49:35 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 10 Jan 2019 16:49:27 +0000
Message-ID: <2a653203-669e-f66e-cdab-82458ec72874@janustech.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<8736q3ebs2.fsf@dusky.pond.sub.org>
	<d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
	<87h8eghej3.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8eghej3.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <84D89FC3E02E42498D800DD0BBB257E4@namprd07.prod.outlook.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

T24gMS8xMC8xOSAyOjQwIFBNLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gTGVvbmlkIEJs
b2NoIDxsYmxvY2hAamFudXN0ZWNoLmNvbT4gd3JpdGVzOg0KPiANCj4+IEhpLA0KPj4NCj4+IE9u
IDEvOC8xOSAxMTozMSBBTSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4gSSdkIGxlYXZl
IGl0IGhhcmQtY29kZWQuICBSZXBsYWNpbmcgYSBmZXcgdHJpdmlhbCBkZWZpbmVzIGJ5IGFuIGFy
Z3VhYmx5DQo+Pj4gbGVzcyB0cml2aWFsIHNjcmlwdCBkb2Vzbid0IGZlZWwgbGlrZSBhbiBpbXBy
b3ZlbWVudC4gIEluIHRoaXMgY2FzZSwgaXQNCj4+PiBkb2Vzbid0IGV2ZW4gc2F2ZSBsaW5lcy4N
Cj4+DQo+PiBBcyBJJ3ZlIHNhaWQsIEknbSBmaW5lIHdpdGggdGhhdC4gVGhlIGF1dG9nZW5lcmF0
aW9uIHNvdW5kcyB0aGUgcmlnaHQNCj4+IHRoaW5nIHRvIGRvIGhlcmUsIGFzIHRoZSB0YWJsZSBp
cyBhdXRvZ2VuZXJ0YWVkIGFueXdheSwgYnV0IGluZGVlZCBpdCBpcw0KPj4gYWxyZWFkeSB0aGVy
ZSwgZXhwbGFpbmVkLCBhbmQgZXZlbiB0aGUgc2NyaXB0IGZvciBnZW5lcmF0aW5nIGl0IGFwcGVh
cnMNCj4+IGluIHRoZSBjb21tZW50cyBmb3IgcmVwcm9kdWNpYmlsaXR5Lg0KPj4NCj4+Pg0KPj4+
IEknbSBub3Qgc3VyZSBJJ2QgdXNlIHNoZWxsIGZvciB0aGlzLCBidXQgc2luY2UgeW91IGFscmVh
ZHkgd3JvdGUgaXQgYW5kDQo+Pj4gaXQgd29ya3MuLi4NCj4+Pg0KPj4NCj4+IElmIHlvdSd2ZSBu
b3RpY2VkLCB0aGUgb3JpZ2luYWwgc2NyaXB0IHdhcyBpbiBBV0suIEJ1dCB0byBiZSBhcyBnZW5l
cmljDQo+PiBhcyBwb3NzaWJsZSwgSSBkaWRuJ3Qgd3JpdGUgdGhlIGdlbmVyYXRpb24gc2NyaXB0
IGluIEFXSyBiZWNhdXNlIGV2ZW4NCj4+IEFXSyBpcyBub3QgZ3VhcmFudGVlZCB0byBiZSBpbnN0
YWxsZWQgb24gdGhlIGJ1aWxkIHN5c3RlbS4gVGhlIG9ubHkNCj4+IGludGVycHJldGVkIGxhbmd1
YWdlIHRoYXQgaXMgZ3VhcmFudGVlZCB0byBiZSB0aGVyZSBpcyBzaGVsbCAobW9zdCBiYXNpYw0K
Pj4gc2hlbGwpIGJlY2F1c2UgLmNvbmZpZ3VyZSBpdHNlbGYgbmVlZHMgaXQuDQo+IA0KPiBXZWxs
LA0KPiANCj4gICAgICAkIGdyZXAgLXcgYXdrIGNvbmZpZ3VyZQ0KPiAgICAgICAgICBtYWo9YGxp
YmdjcnlwdC1jb25maWcgLS12ZXJzaW9uIHwgYXdrIC1GIC4gJ3twcmludCAkMX0nYA0KPiAgICAg
ICAgICBtaW49YGxpYmdjcnlwdC1jb25maWcgLS12ZXJzaW9uIHwgYXdrIC1GIC4gJ3twcmludCAk
Mn0nYA0KPiANCj4gVGhlIGJ1aWxkIGFsc28gcmVxdWlyZXMgUHl0aG9uLg0KDQpOb3QgZm9yIGNy
aXRpY2FsIHRoaW5ncyBhcyB0aGlzLiBJIG1lYW4gaXQgY2FuIHN0aWxsIGJ1aWxkIE9LIHdpdGhv
dXQgDQpQeXRob24uDQoNCj4gDQo+IFsuLi5dDQo+IA0K
