Received: from eggs.gnu.org ([208.118.235.92]:51934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfWwN-0001Z0-O2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfWwM-0002f6-QM
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:23:39 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Fri, 4 Jan 2019 21:23:27 +0000
Message-ID: <82dd4207-26e9-486d-2312-434e5fc1d289@janustech.com>
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<w51h8eqdroh.fsf@maestria.local.igalia.com>
	<9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
	<1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
	<472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
	<3797d82c-a6a6-eb97-be0c-67316ee55e22@redhat.com>
	<w51y3806a74.fsf@maestria.local.igalia.com>
In-Reply-To: <w51y3806a74.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5425CCA790243C42929D5B14AF33F93F@namprd07.prod.outlook.com>
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
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

T24gMS80LzE5IDEyOjMxIFBNLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gT24gVGh1IDAzIEph
biAyMDE5IDEwOjQyOjMwIFBNIENFVCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gDQo+PiBJbiBteSB2
aWV3LCBjb2RlIGdlbmVyYXRvcnMgbWFrZSBzZW5zZSB3aGVuIHVzZWQgb24gY29kZSB0aGF0IGlz
DQo+PiBleHBlY3RlZCB0byBjaGFuZ2Ugb3ZlciB0aW1lIChhIGdvb2QgZXhhbXBsZSBpcyBRQVBJ
IGJlY2F1c2Ugd2UgYWRkDQo+PiBuZXcgY29tbWFuZHMgZXZlcnkgcmVsZWFzZTsgb3RoZXIgcGxh
Y2VzIG1pZ2h0IGJlIGEgZ2VuZXJhdG9yIHRvIGhlbHANCj4+IGRlYWwgd2l0aCBzeXNjYWxsIGhh
bmRsZXJzIHNpbmNlIG5ld2VyIGtlcm5lbHMgY2FuIGFkZCBhIHN5c2NhbGw7IG9yDQo+PiBldmVu
IHRoZSBmYWN0IHRoYXQgd2UgaGF2ZSB1c2VkIHNvbWUgcG93ZXJmdWwgR05VIG1ha2UgdGV4dHVh
bA0KPj4gcHJvY2Vzc2luZyB0byBtYWtlIGl0IGVhc3kgdG8gYWRkIGZpbGVzIHRvIHBhcnRpY3Vs
YXIgc3Vic2V0cyBvZiB0aGUNCj4+IGJ1aWxkIHdpdGggYXMgZmV3IGxpbmVzIGVkaXRlZCBhcyBw
b3NzaWJsZSksIHdoZXJlIHRoZSBnb2FsIGlzIHRoYXQNCj4+IHRoZSBnZW5lcmF0b3IgZ2l2ZXMg
eW91IGJvdGggYSBjb21wYWN0IHJlcHJlc2VudGF0aW9uIHRoYXQgaXMgZWFzaWVyDQo+PiB0byBl
ZGl0LCBhbmQgdGhhdCB0aGUgZXhwYW5zaW9uIGZyb20gdGhlIGdlbmVyYXRvciBlbnN1cmVzIHRo
YXQNCj4+IHJlcGV0aXRpdmUgYm9pbGVycGxhdGUgaXMgZm9ybWVkIHdpdGhvdXQgdHlwb3MuICBJ
biBzaG9ydCwgaWYgYQ0KPj4gZ2VuZXJhdG9yIHJlc3VsdHMgaW4gYSBuZXQgcmVkdWN0aW9uIGlu
IGxpbmVzIG9mIGVkaXRlZCBzb3VyY2UgaW4NCj4+IHJlbGF0aW9uIHRvIHRoZSBsaW5lcyBpdCBw
cm9kdWNlcywgQU5EIGlmIHRoZSBzb3VyY2UgdGhhdCBnZXRzDQo+PiByZWdlbmVyYXRlZCBpcyBs
aWtlbHkgdG8gY2hhbmdlLCB0aGVuIGl0IG1ha2VzIHRvdGFsIHNlbnNlIHRvIHNwZW5kDQo+PiB0
aW1lIG9uIHRoZSBnZW5lcmF0b3IuICBCdXQgd2hlbiB0aGUgYW1vdW50IG9mIGVmZm9ydCB0byB3
cml0ZSBhDQo+PiBnZW5lcmF0b3IgY29zdHMgYXMgbXVjaCBhcyBqdXN0IGhhcmQtY29kaW5nIHRo
ZSBsaXN0IG91dHJpZ2h0LA0KPj4gZXNwZWNpYWxseSB3aGVuIHRoZSBsaXN0IGlzIG5vdCBnb2lu
ZyB0byBjaGFuZ2UgKHRoZXJlIHJlYWxseSBhcmVuJ3QNCj4+IGFueSBvdGhlciBwb3dlcnMgb2Yg
MiB3aXRoaW4gNjQgYml0cyksIEknbSBub3Qgc3VyZSBhIGdlbmVyYXRvciBhZGRzDQo+PiBhbnkg
dmFsdWUuDQo+IA0KPiBJIGFncmVlIHdpdGggRXJpYy4NCg0KRmluZSB3aXRoIG1lLiBJIGp1c3Qg
dGhvdWdodCB0aGF0IGluIHRoZSBwcmV2aW91cyBjb252ZXJzYXRpb24gDQooaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDY2Njk3NS8jMjIzMDI0MzUpIHdlIGhhdmUgYWdyZWVk
IA0KdGhhdCBJJ2xsIHNlbmQgdGhpcyBwYXRjaC4gSSd2ZSBzZW50IHYyIGFscmVhZHkgd2l0aCBQ
aGlsJ3Mgc3VnZ2VzdGlvbnMgDQppbmNsdWRlZCwgcGxlYXNlIGZlZWwgZnJlZSB0byBwdWxsIGl0
IGlmIGRlc2lyZWQuDQoNCkxlb25pZC4NCg0KPiANCj4gQmVydG8NCj4gDQo=
