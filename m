Received: from eggs.gnu.org ([208.118.235.92]:53416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfAQt-0001LS-VD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfAQr-00035H-I8
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:21:39 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 3 Jan 2019 21:21:16 +0000
Message-ID: <472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<w51h8eqdroh.fsf@maestria.local.igalia.com>
	<9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
	<1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
In-Reply-To: <1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <386B1F2100638143B10281BE5DBF4EC9@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

SGksDQoNCk9uIDEvNC8xOSAxMjowNCBBTSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMS8zLzE5
IDI6NTcgUE0sIExlb25pZCBCbG9jaCB3cm90ZToNCj4gDQo+Pj4gSSBoYXZlIHRvIHNheSB0aGF0
IEknbSBub3QgdmVyeSBjb252aW5jZWQgb2YgdGhlIGJlbmVmaXRzIG9mIHJlcGxhY2luZyBhDQo+
Pj4gc2V0IG9mIHRyaXZpYWwgbnVtZXJpYyBtYWNyb3Mgd2l0aCBhIGxvbmdlciBhbmQgaGFyZGVy
IHRvIHJlYWQgc2hlbGwNCj4+PiBzY3JpcHQgYWNjb21wYW5pZWQgYnkgY2hhbmdlcyB0byB0aGUg
YnVpbGQgc3lzdGVtLg0KPj4NCj4+IEkgdGhpbmsgdGhhdCB0aGUgYmVuZWZpdCBpcyB0aGF0IHRo
ZSBzY3JpcHQgaXMgZWFzaWx5IHZlcmlmaWFibGUsDQo+PiB3aGVyZWFzIGlmIHNvbWVvbmUgd291
bGQgbGlrZSB0byB2ZXJpZnkgdGhlIHRhYmxlLCB0aGV5IHdpbGwgbmVlZCB0bw0KPj4gZ2VuZXJh
dGUgaXQgdGhlbXNlbHZlcy4gQWxzbywgdGhpcyB0YWJsZSBpcyBhdXRvbWF0aWNhbGx5IGdlbmVy
YXRlZA0KPj4gYW55d2F5LCBzbyBpdCBvbmx5IG1ha2VzIHNlbnNlIHRvIGdlbmVyYXRlIGl0IGR1
cmluZyB0aGUgYnVpbGQuDQo+IA0KPiBCdXQgbm8gb25lIGlzIHN1Ym1pdHRpbmcgcGF0Y2hlcyB0
byBhY3RpdmUgbW9kaWZ5IHRoZSB0YWJsZS4gIFRoZSB3b3JrDQo+IGhhcyBhbHJlYWR5IGJlZW4g
ZG9uZSBvbmNlIHRvIGdlbmVyYXRlIGl0LCBhbmQgdGhlIHJldmlld2VycyBoYXZlDQo+IGFscmVh
ZHkgdmVyaWZpZWQgaXQ7IGF0IHRoaXMgcG9pbnQsIG5vIGZ1cnRoZXIgY2hhbmdlcyBhcmUgbGlr
ZWx5IHRvDQo+IGhhcHBlbiAob3RoZXIgdGhhbiBteSBwaXBlIGRyZWFtIG9mIGVudGlyZWx5IGdl
dHRpbmcgcmlkIG9mIHRoZSB0YWJsZSBpbg0KPiBmYXZvciBvZiB1c2luZyBydW50aW1lIGdlbmVy
YXRpb24gb2YgaHVtYW4tZnJpZW5kbHkgZGVmYXVsdCBzdHJpbmdzIGlzDQo+IGFkZGVkIHRvIFFl
bXVPcHRzIGluc3RlYWQpLiAgSWYgdGhlIHRhYmxlIHdlcmUgbm90IGFscmVhZHkgaW4gZ2l0LCB0
aGVuDQo+IGdlbmVyYXRpbmcgaXQgYXQgYnVpbGQgdGltZSBtaWdodCBtYWtlIHNlbnNlOyBidXQg
YXQgdGhpcyBzdGFnZSBpbiB0aGUNCj4gZ2FtZSwgeW91J3JlIHNsb3dpbmcgZG93biBldmVyeSBi
dWlsZCB0byByZWdlbmVyYXRlIHNvbWV0aGluZyB0aGF0IGlzDQo+IGFscmVhZHkgY29ycmVjdC4N
Cj4gDQoNCk9LLCB0aGF0J3MgYSBnb29kIHBvaW50LiBCdXQgc3RpbGwsIEkgdGhpbmsgdGhhdCB5
b3UgYWdyZWUgdGhhdCBpdCB3b3VsZCANCmJlIG1vcmUgY29ycmVjdCB0byBnZW5lcmF0ZSBpdCBk
dXJpbmcgdGhlIGJ1aWxkLCByaWdodD8gU28gbm93IGl0IGlzIA0KdGhlcmUgYWxyZWFkeSBhbmQg
aXQgd29ya3MuIEJ1dCBpc24ndCBpdCB3b3J0aCBpdCB0byBtYWtlIGl0IG1vcmUgY29ycmVjdD8N
Cg0KTGVvbmlkLg0K
