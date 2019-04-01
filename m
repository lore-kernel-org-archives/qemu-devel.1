Received: from eggs.gnu.org ([209.51.188.92]:50344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hAvtC-00052D-K5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hAvtB-0005lG-MY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:18:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 1 Apr 2019 12:18:02 +0000
Message-ID: <1ad65150-da2c-3106-ca15-11050b1b6381@virtuozzo.com>
References: <20190330150702.11687-1-eblake@redhat.com>
In-Reply-To: <20190330150702.11687-1-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <22DAF89C44276740BBB0C99C4F15AF7B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Saner printing of large file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MzAuMDMuMjAxOSAxODowNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gRGlzayBzaXplcyBjbG9zZSB0
byBJTlQ2NF9NQVggY2F1c2Ugb3ZlcmZsb3csIGZvciBzb21lIHByZXR0eQ0KPiByaWRpY3Vsb3Vz
IG91dHB1dDoNCj4gDQo+ICAgICQgLi9uYmRraXQgLVUgLSBtZW1vcnkgc2l6ZT0kKCgyKio2MyAt
IDUxMikpIC0tcnVuICdxZW11LWltZyBpbmZvICRuYmQnDQo+ICAgIGltYWdlOiBuYmQrdW5peDov
Lz9zb2NrZXQ9L3RtcC9uYmRraXRIU0F6Tnovc29ja2V0DQo+ICAgIGZpbGUgZm9ybWF0OiByYXcN
Cj4gICAgdmlydHVhbCBzaXplOiAtODM4ODYwN1QgKDkyMjMzNzIwMzY4NTQ3NzUyOTYgYnl0ZXMp
DQo+ICAgIGRpc2sgc2l6ZTogdW5hdmFpbGFibGUNCj4gDQo+IEJ1dCB0aGVyZSdzIG5vIHJlYXNv
biB0byBoYXZlIHR3byBzZXBhcmF0ZSBpbXBsZW1lbnRhdGlvbnMgb2YgaW50ZWdlcg0KPiB0byBo
dW1hbi1yZWFkYWJsZSBhYmJyZXZpYXRpb24sIHdoZXJlIG9uZSBoYXMgb3ZlcmZsb3cgYW5kIHN0
b3BzIGF0DQo+ICdUJywgd2hpbGUgdGhlIG90aGVyIGF2b2lkcyBvdmVyZmxvdyBhbmQgZ29lcyBh
bGwgdGhlIHdheSB0byAnRScuIFdpdGgNCj4gdGhpcyBwYXRjaCwgdGhlIG91dHB1dCBub3cgY2xh
aW1zIDhFaUIgaW5zdGVhZCBvZiAtODM4ODYwN1QsIHdoaWNoDQo+IHJlYWxseSBpcyB0aGUgY29y
cmVjdCByb3VuZGluZyBvZiBsYXJnZXN0IGZpbGUgc2l6ZSBzdXBwb3J0ZWQgYnkgcWVtdQ0KPiAo
d2UgY291bGQgZ28gNTExIGJ5dGVzIGxhcmdlciBpZiB3ZSB1c2VkIGJ5dGUtYWNjdXJhdGUgc2l6
aW5nIGluc3RlYWQNCj4gb2Ygcm91bmRpbmcgdXAgdG8gdGhlIG5leHQgc2VjdG9yIGJvdW5kYXJ5
LCBidXQgdGhhdCB3b3VsZG4ndCBjaGFuZ2UNCj4gdGhlIGh1bWFuLXJlYWRhYmxlIHJlc3VsdCku
DQo+IA0KPiBSZXBvcnRlZC1ieTogUmljaGFyZCBXLk0uIEpvbmVzIDxyam9uZXNAcmVkaGF0LmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
