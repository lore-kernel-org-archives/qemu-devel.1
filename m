Received: from eggs.gnu.org ([2001:4830:134:3::10]:50267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f0TWP-0003An-8r
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f0TWM-0001Iv-K0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:54:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:53295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f0TWM-0001II-BN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:54:50 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 26 Mar 2018 14:54:45 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739485EE3@shsmsx102.ccr.corp.intel.com>
References: <1521197309-13544-5-git-send-email-wei.w.wang@intel.com>
	<20180316165319-mutt-send-email-mst@kernel.org>
	<5AAE4124.5010602@intel.com>
	<20180319062023-mutt-send-email-mst@kernel.org>
	<5AAF7C72.5070403@intel.com>
	<20180320004900-mutt-send-email-mst@kernel.org>
	<5AB06EE9.1030306@intel.com>
	<20180320045134-mutt-send-email-mst@kernel.org>
	<5AB07D7F.90205@intel.com>
	<20180320051840-mutt-send-email-mst@kernel.org>
	<20180326110904.GI19266@redhat.com>
In-Reply-To: <20180326110904.GI19266@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "quintela@redhat.com" <quintela@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>

T24gTW9uZGF5LCBNYXJjaCAyNiwgMjAxOCA3OjA5IFBNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdy
b3RlOg0KPiANCj4gQXMgZmFyIGFzIGxpYnZpcnQgaXMgY29uY2VybmVkIHRoZXJlIGFyZSB0aHJl
ZSBzZXRzIG9mIHRocmVhZHMgaXQgcHJvdmlkZXMNCj4gY29udHJvbCBvdmVyDQo+IA0KPiAgLSB2
Q1BVcyAtIGVhY2ggVkNQVSBpbiBLVk0gaGFzIGEgdGhyZWFkLiBMaWJ2aXJ0IHByb3ZpZGVzIHBl
ci10aHJlYWQNCj4gICAgdHVuYWJsZSBjb250cm9sDQo+IA0KPiAgLSBJT1RocmVhZHMgLSBlYWNo
IG5hbWVkIEkvTyB0aHJlYWQgY2FuIGJlIGFzc29jaWF0ZWQgd2l0aCBvbmUgb3IgbW9yZQ0KPiAg
ICBkZXZpY2VzLiBMaWJ2aXJ0IHByb3ZpZGVzIHBlci10aHJlYWQgdHVuYWJsZSBjb250cm9sLg0K
PiANCj4gIC0gRW11bGF0b3IgLSBhbnkgb3RoZXIgUUVNVSB0aHJlYWQgd2hpY2ggaXNuJ3QgYW4g
dkNQVSB0aHJlYWQgb3IgSU8gdGhyZWFkDQo+ICAgIGdldHMgY2FsbGVkIGFuIGVtdWxhdG9yIHRo
cmVhZCBieSBsaWJ2aXJ0LiBUaGVyZSBpcyBuby1wZXIgdGhyZWFkDQo+ICAgIHR1bmFibGUgY29u
dHJvbCAtIHdlIGNhbiBzZXQgdHVuYWJsZXMgZm9yIGVudGlyZSBzZXQgb2YgZW11bGF0b3IgdGhy
ZWFkcw0KPiAgICBhdCBvbmNlLg0KPiANCg0KDQpIaSBEYW5pZWwsDQpUaGFua3MgZm9yIHNoYXJp
bmcgdGhlIGRldGFpbHMsIHRoZXkgYXJlIHZlcnkgaGVscGZ1bC4gSSBzdGlsbCBoYXZlIGEgcXVl
c3Rpb246DQoNClRoZXJlIGlzIG5vIGZ1bmRhbWVudGFsIGRpZmZlcmVuY2UgYmV0d2VlbiBpb3Ro
cmVhZCBhbmQgb3VyIG9wdGltaXphdGlvbiB0aHJlYWQgKGl0IGlzIHNpbWlsYXIgdG8gdGhlIG1p
Z3JhdGlvbiB0aHJlYWQsIHdoaWNoIGlzIGNyZWF0ZWQgd2hlbiBtaWdyYXRpb24gYmVnaW5zIGFu
ZCB0ZXJtaW5hdGVkIHdoZW4gbWlncmF0aW9uIGlzIGRvbmUpIC0gYm90aCBvZiB0aGVtIGFyZSBw
dGhyZWFkcyBhbmQgZWFjaCBoYXMgYSBuYW1lLiBDb3VsZCB3ZSBhbHNvIGFkZCB0aGUgc2ltaWxh
ciBwZXItdGhyZWFkIHR1bmFibGUgY29udHJvbCBpbiBsaWJ2aXJ0IGZvciBzdWNoIHRocmVhZHM/
DQoNCkZvciBleGFtcGxlLCBpbiBRRU1VIHdlIGNhbiBhZGQgYSBuZXcgbWlncmF0aW9uIHFtcCBj
b21tYW5kLCBtaWdyYXRlX2VuYWJsZV9mcmVlX3BhZ2Vfb3B0aW1pemF0aW9uIChqdXN0IGxpa2Ug
b3RoZXIgY29tbWFuZHMgbWlncmF0ZV9zZXRfc3BlZWQgMTBHKSwgdGhpcyBjb21tYW5kIHdpbGwg
Y3JlYXRlIHRoZSBvcHRpbWl6YXRpb24gdGhyZWFkLiBJbiB0aGlzIHdheSwgY3JlYXRpb24gb2Yg
dGhlIHRocmVhZCBpcyBpbiBsaWJ2aXJ0J3MgY29udHJvbCwgYW5kIGxpYnZpcnQgY2FuIHRoZW4g
c3VwcG9ydCB0dW5pbmcgdGhlIHRocmVhZCAoZS5nLiBwaW4gaXQgdG8gYW55IHBDUFUpLCByaWdo
dD8NCg0KDQo+IFNvLCBpZiB0aGlzIGJhbGxvb24gZHJpdmVyIHRocmVhZCBuZWVkcyB0byBzdXBw
b3J0IHR1bmluZyBjb250cm9scyBzZXBhcmF0ZWx5DQo+IGZyb20gb3RoZXIgZ2VuZXJhbCBwdXJw
b3NlIFFFTVUgdGhyZWFkcywgdGhlbiBpdCB3b3VsZCBpZGVhbGx5IHVzZQ0KPiBpb3RocmVhZCBp
bmZyYXN0cnVjdHVyZS4NCj4gDQo+IEkgZG9uJ3QgcGFydGljdWxhcmx5IHVuZGVyc3RhbmQgd2hh
dCB0aGlzIGNvZGUgaXMgZG9pbmcsIGJ1dCBwbGVhc2UgY29uc2lkZXINCj4gd2hldGhlciBOVU1B
IGhhcyBhbnkgaW1wYWN0IG9uIHRoZSB3b3JrIGRvbmUgaW4gdGhpcyB0aHJlYWQuIFNwZWNpZmlj
YWxseQ0KPiB3aGVuIHRoZSBndWVzdCBoYXMgbXVsdGlwbGUgdmlydHVhbCBOVU1BIG5vZGVzLCBl
YWNoIGFzc29jaWF0ZWQgd2l0aCBhDQo+IHNwZWNpZmljIGhvc3QgTlVNQSBub2RlLiBJZiB0aGVy
ZSBpcyBhbnkgbWVtb3J5IGludGVuc2l2ZSB3b3JrIGJlaW5nIGRvbmUNCj4gaGVyZSwgdGhlbiBp
dCBtaWdodCBuZWVkIHRvIGJlIGV4ZWN1dGVkIG9uIHRoZSBjb3JyZWN0IGhvc3QgTlVNQSBub2Rl
DQo+IGFjY29yZGluZyB0byB0aGUgbWVtb3J5IHJlZ2lvbiBiZWluZyB0b3VjaGVkLg0KPiANCiAN
CkkgdGhpbmsgaXQgd291bGQgbm90IGJlIHNpZ25pZmljYW50bHkgaW1wYWN0ZWQgYnkgTlVNQSwg
YmVjYXVzZSB0aGlzIG9wdGltaXphdGlvbiB0aHJlYWQgZG9lc27igJl0IGFjY2VzcyB0byB0aGUg
Z3Vlc3QgbWVtb3J5IGEgbG90IGV4Y2VwdCB0aGUgdmlydHF1ZXVlIChldmVuIHdpdGggaW90aHJl
YWQsIHdlIG1heSBzdGlsbCBub3Qga25vdyB3aGljaCBwQ1BVIHRvIHBpbiB0byBtYXRjaCB2aXJ0
cXVldWUgaW4gdGhlIHZOVU1BIGNhc2UpLiBFc3NlbnRpYWxseSwgaXQgZ2V0cyB0aGUgZnJlZSBw
YWdlIGFkZHJlc3MgYW5kIGxlbmd0aCwgdGhlbiBjbGVhcnMgYml0cyBmcm9tIHRoZSBtaWdyYXRp
b24gZGlydHkgYml0bWFwLCB3aGljaCBpcyBhbGxvY2F0ZWQgYnkgUUVNVSBpdHNlbGYuDQpTbywg
SSB0aGluayBhZGRpbmcgdGhlIHR1bmFibGUgc3VwcG9ydCBpcyBuaWNlciwgYnV0IEknbSBub3Qg
c3VyZSBpZiB0aGF0IHdvdWxkIGJlIHJlcXVpcmVkLg0KDQpCZXN0LA0KV2VpDQo=
