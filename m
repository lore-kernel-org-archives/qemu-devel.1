Received: from eggs.gnu.org ([209.51.188.92]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3OsW-000833-PF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3OqN-0006mq-4U
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:36:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 17:36:00 +0000
Message-ID: <d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
	<3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
In-Reply-To: <3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <48A5A8A47C67F14894B1C4481F34CE59@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

MTEuMDMuMjAxOSAxOToxOCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMy81LzE5IDU6NDMgUE0s
IEpvaG4gU25vdyB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGFpbXMgdG8gZW5hYmxlIGJsb2NrIHJl
c2l6ZXMgd2hlbiBwZXJzaXN0ZW50IGJpdG1hcHMgYXJlDQo+PiBpbiB1c2UuIFRoZSBiYXNpYyBh
cHByb2FjaCBoZXJlIGlzIHRvIHJlY29nbml6ZSB0aGF0IHdlIG5vdyBsb2FkIGFsbA0KPj4gcGVy
c2lzdGVudCBiaXRtYXBzIGluIG1lbW9yeSwgYW5kIHNvIHdlIGNhbiByZWx5IG9uIGluLW1lbW9y
eSByZXNpemVzDQo+PiBhbmQgdGhlbiBmbHVzaCB0aGUgY2hhbmdlZCBtZXRhZGF0YSBiYWNrIHRv
IGRpc2suDQo+Pg0KPj4gT25lIHBhcnQgdGhhdCBpcyBwb3RlbnRpYWxseSBub3cgcXVpdGUgc3Ry
YW5nZSBpcyB0aGF0IGJpdG1hcCByZXNpemVzDQo+PiBtYXkgaGFwcGVuIHR3aWNlOiBvbmNlIGR1
cmluZyB0aGUgcWNvdzIgcmVzaXplIGV2ZW50IG9ubHkgaWYgcGVyc2lzdGVudA0KPj4gYml0bWFw
cyBhcmUgZm91bmQsIGFuZCB0aGVuIGFnYWluIGFzIHBhcnQgb2YgdGhlIGdlbmVyaWMgcmVzaXpl
IGNhbGxiYWNrDQo+PiBldmVudCB3aGV0aGVyIG9yIG5vdCB3ZSBoYXZlIGFueSBwZXJzaXN0ZW50
IGJpdG1hcHMuDQo+Pg0KPj4gVGhlIHNlY29uZCByb3VuZCBpcyByZXF1aXJlZCBpZiB3ZSBhcmUg
bm90IHVzaW5nIHFjb3cyIG9yIHdlIGhhdmUgb25seQ0KPj4gdHJhbnNpZW50IGJpdG1hcHMuIFRo
ZSBmaXJzdCByb3VuZCBpcyByZXF1aXJlZCBhcyB3ZSB3aXNoIHRvIGZsdXNoIHRoZQ0KPj4gYml0
bWFwcyBiYWNrIHRvIGRpc2sgYXRvbWljYWxseSB3aXRoIHRoZSBxY293MiByZXNpemUgdG8gYXZv
aWQgdmlvbGF0aW5nDQo+PiBvdXIgaW52YXJpYW50cyBmb3IgdGhlIGJpdG1hcCBtZXRhZGF0YSB3
aGljaCBpcyBjaGVja2VkIGluIG1hbnkgcGxhY2VzLg0KPj4NCj4+IFRoaXMgaXMgaGFybWxlc3M7
IGhiaXRtYXBfdHJ1bmNhdGUgd2lsbCByZWNvZ25pemUgdGhlIHNlY29uZCByb3VuZCBhcw0KPj4g
YSBuby1vcC4NCj4gDQo+IEZXSVcgLSBJIGhhdmUgbm90IHlldCByZXZpZXdlZCB0aGlzIHNlcmll
cyBjbG9zZWx5LCBidXQgSSB0aGluayBpdCB3b3VsZA0KPiBiZSB3aXNlIHRvIGdldCB0aGlzIGlu
aXRpYWwgY3V0IGluIGJlZm9yZSBzb2Z0ZnJlZXplICh3ZSBjYW4gbWFrZQ0KPiBmdXJ0aGVyIHR3
ZWFrcyB0byBmaXggYnVncyBpbiBhc3N1bXB0aW9ucyBkdXJpbmcgcmMxIGFuZCByYzIsIGJ1dCBp
dCdzIGENCj4gbG90IGhhcmRlciB0byBhZGQgdGhlIHNlcmllcyBhdCBhbGwgaWYgaXQgbWlzc2Vz
IHNvZnRmcmVlemUpLg0KPiANCg0KSSBzdGlsbCBub3QgY29udmluY2VkIHRoYXQgd2UgbmVlZCBi
aXRtYXAgZmx1c2hpbmcuIEkgdGhpbmsgKGFuZCBEZW4gc3VwcG9ydHMNCm1lKSB0aGF0IGl0J3Mg
YSBiYWQgaWRlYS4gSXQgbWFrZXMgdGhpbmdzIG1vcmUgZGlmZmljdWx0IHdpdGhvdXQgYSByZWFz
b24sDQpleGNlcHQgaW1wcm92aW5nIGRlYnVnZ2luZyB3aXRoIC0tZm9yY2Utc2hhcmUgd2hpY2gg
c2hvdWxkIG5ldmVyIGJlIHVzZWQgaW4NCnByb2R1Y3Rpb24uDQoNCkJpdG1hcHMgYXJlIHN0b3Jl
ZCBpbiBxY293Ml9pbmFjdGl2YXRlKCkgd2hpY2ggaXMgdHJ1ZSBwbGFjZSBmb3IgZmx1c2hpbmcg
Y2FjaGVzLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
