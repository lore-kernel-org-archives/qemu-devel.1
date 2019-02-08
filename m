Received: from eggs.gnu.org ([209.51.188.92]:52228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gs86S-0008RS-6V
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gs86R-0005b3-FR
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:30:08 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri, 8 Feb 2019 15:29:48 +0000
Message-ID: <41e29129-196d-1b24-03ae-373b7d357725@virtuozzo.com>
References: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51o97m8ltv.fsf@maestria.local.igalia.com>
In-Reply-To: <w51o97m8ltv.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E662874CA3F02B4F92AEB9A48A7D1F2A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] Stream block job
 involves copy-on-read filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

DQoNCk9uIDA4LzAyLzIwMTkgMTY6MTMsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBXZWQg
MjMgSmFuIDIwMTkgMTI6NTQ6MjQgUE0gQ0VULCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+
ICtzdGF0aWMgQmxvY2tEcml2ZXJTdGF0ZSAqaW5zZXJ0X2ZpbHRlcihCbG9ja0RyaXZlclN0YXRl
ICpicywgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqY29y
X2ZpbHRlcl9iczsNCj4+ICsgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+PiArDQo+PiAr
ICAgIGNvcl9maWx0ZXJfYnMgPSBjcmVhdGVfZmlsdGVyX25vZGUoYnMsIGVycnApOw0KPj4gKyAg
ICBpZiAoY29yX2ZpbHRlcl9icyA9PSBOVUxMKSB7DQo+PiArICAgICAgICBlcnJvcl9wcmVwZW5k
KGVycnAsICJDb3VsZCBub3QgY3JlYXRlIGZpbHRlciBub2RlOiAiKTsNCj4+ICsgICAgICAgIHJl
dHVybiBOVUxMOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGJkcnZfc2V0X2Fpb19jb250ZXh0
KGNvcl9maWx0ZXJfYnMsIGJkcnZfZ2V0X2Fpb19jb250ZXh0KGJzKSk7DQo+PiArDQo+PiArICAg
IGJkcnZfZHJhaW5lZF9iZWdpbihicyk7DQo+PiArICAgIGJkcnZfcmVwbGFjZV9ub2RlKGJzLCBj
b3JfZmlsdGVyX2JzLCAmbG9jYWxfZXJyKTsNCj4+ICsgICAgYmRydl9kcmFpbmVkX2VuZChicyk7
DQo+IA0KPiBJIHRoaW5rIHRoaXMgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGluIHRoZSBwcmV2aW91
cyB2ZXJzaW9uIG9mIHRoaXMNCj4gcGF0Y2g6IGlmIHlvdSBpbnNlcnQgYSBjb3B5LW9uLXJlYWQg
ZmlsdGVyIGhlcmUgdGhlbiBhbGwgZ3Vlc3QgcmVhZHMNCj4gd2lsbCBjb3B5IHRoZSBkYXRhIGZy
b20gdGhlIGJhY2tpbmcgY2hhaW4sIGJ1dCB5b3UgZG9uJ3Qgd2FudCB0byBjb3B5DQo+IGFueXRo
aW5nIGJlbG93IHRoZSAnYmFzZScgbm9kZSwgc28gdGhlIGNvcHktb24tcmVhZCBmaWx0ZXIgbmVl
ZHMgYQ0KPiAnYmFzZScgcGFyYW1ldGVyLg0KPiANCj4gQmVydG8NCj4gDQpUaGFuayB5b3UsIEFs
YmVydG8uIFdlIHdpbGwgc29ydCBpdCBvdXQgZm9yIHN1cmUuDQpCZWZvcmUgdGhhdCwgd2Ugc3Rp
bGwgaGF2ZSB0aGUgdW5yZXNvbHZlZCBpc3N1ZSB3aXRoIGdldHRpbmcgdGhlIGZpbHRlcg0KYXMg
dGhlICdiYXNlJyBpbnB1dCBwYXJhbWV0ZXIuIFRoYXQgaGFwcGVucyBzb21ldGltZXMgYmVjYXVz
ZSB0aGUgYmFzZQ0KaXMgYmVpbmcgc2VhcmNoZWQgYnkgdGhlIGZpbGUgbmFtZSwgd2hpY2ggaXMg
dGhlIHNhbWUgdG8gdGhlIG9uZSBvZiB0aGUNCmZpbHRlciwgcmF0aGVyIHRoYW4gYnkgdGhlIG5v
ZGUgbmFtZSAoISkuIFRoZSBnaXZlbiBzZXJpZXMgaXMgYSBzb21lDQpzb3J0IG9mIHdvcmthcm91
bmQuDQpXZSBhcmUgbG9va2luZyBmb3J3YXJkIHRvIGhlYXJpbmcgZnJvbSB0aGUgbWFpbnRhaW5l
cnMgaG93IHRvIGltcHJvdmUNCnRoZSBzb2x1dGlvbi4gSXMgdGhlcmUgYW55IGlkZWE/DQotLSAN
CldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=
