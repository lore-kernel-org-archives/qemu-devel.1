Received: from eggs.gnu.org ([2001:4830:134:3::10]:42067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Dzg-0001v4-BC
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Dzb-00006n-Jd
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:40:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:37323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d7Dzb-00005z-9k
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:40:23 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sun, 7 May 2017 04:39:53 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391FFC13@shsmsx102.ccr.corp.intel.com>
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<20170505233541-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170505233541-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] virtio-net: configurable TX queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>

T24gMDUvMDYvMjAxNyAwNDozNyBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBPbiBG
cmksIE1heSAwNSwgMjAxNyBhdCAxMDoyNzoxM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0K
PiA+DQo+ID4NCj4gPiBPbiAyMDE35bm0MDXmnIgwNOaXpSAxODo1OCwgV2FuZywgV2VpIFcgd3Jv
dGU6DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4gPiBJIHdhbnQgdG8gcmUtb3BlbiB0aGUgZGlzY3Vz
c2lvbiBsZWZ0IGxvbmcgdGltZSBhZ286DQo+ID4gPiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxNS0xMS9tc2cwNjE5NC5odG1sDQo+ID4gPiAsIGFuZCBk
aXNjdXNzIHRoZSBwb3NzaWJpbGl0eSBvZiBjaGFuZ2luZyB0aGUgaGFyZGNvZGVkICgyNTYpIFRY
DQo+ID4gPiBxdWV1ZSBzaXplIHRvIGJlIGNvbmZpZ3VyYWJsZSBiZXR3ZWVuIDI1NiBhbmQgMTAy
NC4NCj4gPg0KPiA+IFllcywgSSB0aGluayB3ZSBwcm9iYWJseSBuZWVkIHRoaXMuDQo+ID4NCj4g
PiA+DQo+ID4gPiBUaGUgcmVhc29uIHRvIHByb3Bvc2UgdGhpcyByZXF1ZXN0IGlzIHRoYXQgYSBz
ZXZlcmUgaXNzdWUgb2YgcGFja2V0DQo+ID4gPiBkcm9wcyBpbiBUWCBkaXJlY3Rpb24gd2FzIG9i
c2VydmVkIHdpdGggdGhlIGV4aXN0aW5nIGhhcmRjb2RlZCAyNTYNCj4gPiA+IHF1ZXVlIHNpemUs
IHdoaWNoIGNhdXNlcyBwZXJmb3JtYW5jZSBpc3N1ZXMgZm9yIHBhY2tldCBkcm9wDQo+ID4gPiBz
ZW5zaXRpdmUgZ3Vlc3QgYXBwbGljYXRpb25zIHRoYXQgY2Fubm90IHVzZSBpbmRpcmVjdCBkZXNj
cmlwdG9yDQo+ID4gPiB0YWJsZXMuIFRoZSBpc3N1ZSBnb2VzIGF3YXkgd2l0aCAxSyBxdWV1ZSBz
aXplLg0KPiA+DQo+ID4gRG8gd2UgbmVlZCBldmVuIG1vcmUsIHdoYXQgaWYgd2UgZmluZCAxSyBp
cyBldmVuIG5vdCBzdWZmaWNpZW50IGluIHRoZQ0KPiA+IGZ1dHVyZT8gTW9kZXJuIG5pY3MgaGFz
IHNpemUgdXAgdG8gfjgxOTIuDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGUgY29uY2VybiBtZW50aW9u
ZWQgaW4gdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gKHBsZWFzZSBjaGVjayB0aGUNCj4gPiA+IGxp
bmsNCj4gPiA+IGFib3ZlKSBpcyB0aGF0IHRoZSBudW1iZXIgb2YgY2hhaW5lZCBkZXNjcmlwdG9y
cyB3b3VsZCBleGNlZWQNCj4gPiA+IFVJT19NQVhJT1YgKDEwMjQpIHN1cHBvcnRlZCBieSB0aGUg
TGludXguDQo+ID4NCj4gPiBXZSBjb3VsZCB0cnkgdG8gYWRkcmVzcyB0aGlzIGxpbWl0YXRpb24g
YnV0IHByb2JhYmx5IG5lZWQgYSBuZXcNCj4gPiBmZWF0dXJlIGJpdCB0byBhbGxvdyBtb3JlIHRo
YW4gVUlPX01BWElPViBzZ3MuDQo+IA0KPiBJJ2Qgc2F5IHdlIHNob3VsZCBzcGxpdCB0aGUgcXVl
dWUgc2l6ZSBhbmQgdGhlIHNnIHNpemUuDQo+IA0KDQpJIHRoaW5rIHdlIGNhbiBqdXN0IHNwbGl0
IHRoZSBpb3Ygc2l6ZSBpbiB0aGUgdmlydGlvLW5ldCBiYWNrZW5kLA0KdGhhdCBpcywgc3BsaXQg
dGhlIGxhcmdlIGlvdltdIGludG8gbXVsdGlwbGUgaW92WzEwMjRdIHRvIHNlbmQgdG8gd3JpdGV2
Lg0KDQpCZXN0LA0KV2VpDQoNCg0K
