Received: from eggs.gnu.org ([2001:4830:134:3::10]:45871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVFrf-0006J3-G3
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVFre-0002Uz-06
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:08:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 7 Dec 2018 13:08:04 +0000
Message-ID: <1f4f45ae-49bc-84dd-4896-78549f9b051c@virtuozzo.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-15-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-15-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDD5EE2A1E3D384A98448068BFCAE8E3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 14/14] iotests: Enhance 223,
 233 to cover 'qemu-nbd --list'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MDEuMTIuMjAxOCAxOjAzLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBBbnkgZ29vZCBuZXcgZmVhdHVy
ZSBkZXNlcnZlcyBzb21lIHJlZ3Jlc3Npb24gdGVzdGluZyA6KQ0KPiBDb3ZlcmFnZSBpbmNsdWRl
czoNCj4gLSAyMjM6IHdoYXQgaGFwcGVucyB3aGVuIHRoZXJlIGFyZSAwIG9yIG1vcmUgdGhhbiAx
IGV4cG9ydCwNCj4gcHJvb2YgdGhhdCB3ZSBjYW4gc2VlIG11bHRpcGxlIGNvbnRleHRzIGluY2x1
ZGluZyBxZW11OmRpcnR5LWJpdG1hcA0KPiAtIDIzMzogcHJvb2YgdGhhdCB3ZSBjYW4gbGlzdCBv
dmVyIFRMUywgYW5kIHRoYXQgbWl4LWFuZC1tYXRjaCBvZg0KPiBwbGFpbi9UTFMgbGlzdGluZ3Mg
c2FuZWx5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNv
bT4NCj4gLS0tDQoNClsuLl0NCg0KPiANCj4gICA9PT0gQ29udHJhc3Qgbm9ybWFsIHN0YXR1cyB0
byBsYXJnZSBncmFudWxhcml0eSBkaXJ0eS1iaXRtYXAgPT09DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dGVzdHMvcWVtdS1pb3Rlc3RzLzIzMyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMzMNCj4gaW5kZXgg
MTgxNGVmZTMzMzMuLjVkNjk0ZDlkMjQyIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVz
dHMvMjMzDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMzMNCj4gQEAgLTcyLDYgKzcyLDkg
QEAgJFFFTVVfSU1HIGluZm8gLS1pbWFnZS1vcHRzIFwNCj4gICAgICAgLS1vYmplY3QgdGxzLWNy
ZWRzLXg1MDksZGlyPSR7dGxzX2Rpcn0vY2xpZW50MSxlbmRwb2ludD1jbGllbnQsaWQ9dGxzMCBc
DQo+ICAgICAgIGRyaXZlcj1uYmQsaG9zdD0kbmJkX3RjcF9hZGRyLHBvcnQ9JG5iZF90Y3BfcG9y
dCx0bHMtY3JlZHM9dGxzMCBcDQo+ICAgICAgIDI+JjEgfCBzZWQgInMvJG5iZF90Y3BfcG9ydC9Q
T1JUL2ciDQo+ICskUUVNVV9OQkRfUFJPRyAtTCAtYiAkbmJkX3RjcF9hZGRyIC1wICRuYmRfdGNw
X3BvcnQgXA0KPiArICAgIC0tb2JqZWN0IHRscy1jcmVkcy14NTA5LGRpcj0ke3Rsc19kaXJ9L2Ns
aWVudDEsZW5kcG9pbnQ9Y2xpZW50LGlkPXRsczAgXA0KPiArICAgIC0tdGxzLWNyZWRzPXRsczAN
Cg0KLS1vYmplY3QgcGFyYW1ldGVyIG1heSBiZSBzdG9yZWQgdG8gYSB2YXJpYWJsZSBiZWZvcmUg
dGhlc2UgdHdvIGNvbW1hbmRzLCB0byBub3QgZHVwbGljYXRlLA0KYW5kIGluIGZvbGxvd2luZyBj
YXNlcyB0b28uDQoNCndpdGggb3Igd2l0aG91dDoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
