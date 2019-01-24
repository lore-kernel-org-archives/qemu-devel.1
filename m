Received: from eggs.gnu.org ([209.51.188.92]:47534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmg8B-0003HD-Qb
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmg8A-0003Ec-G7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:37:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 14:37:14 +0000
Message-ID: <02acf2a0-50d9-16d8-c2c4-3001a1d30b23@virtuozzo.com>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190122185740.GC5220@localhost.localdomain>
	<340bf08d-57ff-c6b3-13f4-b7c1b0a5e707@virtuozzo.com>
In-Reply-To: <340bf08d-57ff-c6b3-13f4-b7c1b0a5e707@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5164221A39AEF94AB8CFE672AA142DAA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjMuMDEuMjAxOSAxNTowNCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjIuMDEuMjAxOSAyMTo1NywgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDExLjAxLjIwMTkgdW0g
MTI6NDAgaGF0IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4g
MTEuMDEuMjAxOSAxMzo0MSwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4gQW0gMTAuMDEuMjAxOSB1
bSAxNDoyMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+
Pj4+IGRydl9jb19ibG9ja19zdGF0dXMgZGlncyBicy0+ZmlsZSBmb3IgYWRkaXRpb25hbCwgbW9y
ZSBhY2N1cmF0ZSBzZWFyY2gNCj4+Pj4+IGZvciBob2xlIGluc2lkZSByZWdpb24sIHJlcG9ydGVk
IGFzIERBVEEgYnkgYnMgc2luY2UgNWRhYTc0YTZlYmMuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBhY2N1
cmFjeSBpcyBub3QgZnJlZTogYXNzdW1lIHdlIGhhdmUgcWNvdzIgZGlzay4gQWN0dWFsbHksIHFj
b3cyDQo+Pj4+PiBrbm93cywgd2hlcmUgYXJlIGhvbGVzIGFuZCB3aGVyZSBpcyBkYXRhLiBCdXQg
ZXZlcnkgYmxvY2tfc3RhdHVzDQo+Pj4+PiByZXF1ZXN0IGNhbGxzIGxzZWVrIGFkZGl0aW9uYWxs
eS4gQXNzdW1lIGEgYmlnIGRpc2ssIGZ1bGwgb2YNCj4+Pj4+IGRhdGEsIGluIGFueSBpdGVyYXRp
dmUgY29weWluZyBibG9jayBqb2IgKG9yIGltZyBjb252ZXJ0KSB3ZSdsbCBjYWxsDQo+Pj4+PiBs
c2VlayhIT0xFKSBvbiBldmVyeSBpdGVyYXRpb24sIGFuZCBlYWNoIG9mIHRoZXNlIGxzZWVrcyB3
aWxsIGhhdmUgdG8NCj4+Pj4+IGl0ZXJhdGUgdGhyb3VnaCBhbGwgbWV0YWRhdGEgdXAgdG8gdGhl
IGVuZCBvZiBmaWxlLiBJdCdzIG9idmlvdXNseQ0KPj4+Pj4gaW5lZmZlY3RpdmUgYmVoYXZpb3Iu
IEFuZCBmb3IgbWFueSBzY2VuYXJpb3Mgd2UgZG9uJ3QgbmVlZCB0aGlzIGxzZWVrDQo+Pj4+PiBh
dCBhbGwuDQo+Pj4+Pg0KPj4+Pj4gU28sIGxldCdzICI1ZGFhNzRhNmViYyIgYnkgZGVmYXVsdCwg
bGVhdmluZyBhbiBvcHRpb24gdG8gcmV0dXJuDQo+Pj4+PiBwcmV2aW91cyBiZWhhdmlvciwgd2hp
Y2ggaXMgbmVlZGVkIGZvciBzY2VuYXJpb3Mgd2l0aCBwcmVhbGxvY2F0ZWQNCj4+Pj4+IGltYWdl
cy4NCj4+Pj4+DQo+Pj4+PiBBZGQgaW90ZXN0IGlsbHVzdHJhdGluZyBuZXcgb3B0aW9uIHNlbWFu
dGljcy4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+DQo+Pj4+IEkgc3RpbGwgdGhp
bmsgdGhhdCBhbiBvcHRpb24gaXNuJ3QgYSBnb29kIHNvbHV0aW9uIGFuZCB3ZSBzaG91bGQgdHJ5
IHVzZQ0KPj4+PiBzb21lIGhldXJpc3RpY3MgaW5zdGVhZC4NCj4+Pg0KPj4+IERvIHlvdSB0aGlu
ayB0aGF0IGhldXJpc3RpY3Mgd291bGQgYmUgYmV0dGVyIHRoYW4gZmFpciBjYWNoZSBmb3IgbHNl
ZWsgcmVzdWx0cz8NCj4+DQo+PiBJIGp1c3QgcGxheWVkIGEgYml0IHdpdGggdGhpcyAocWVtdS1p
bWcgY29udmVydCBvbmx5KSwgYW5kIGhvdyBtdWNoDQo+PiBjYWNoaW5nIGxzZWVrKCkgcmVzdWx0
cyBoZWxwcyBkZXBlbmRzIGNvbXBsZXRlbHkgb24gdGhlIGltYWdlLiBBcyBpdA0KPj4gaGFwcGVu
ZWQsIG15IHRlc3QgaW1hZ2Ugd2FzIHRoZSB3b3JzdCBjYXNlIHdoZXJlIGNhY2hpbmcgZGlkbid0
IGJ1eSB1cw0KPj4gbXVjaC4gT2J2aW91c2x5LCBJIGNhbiBqdXN0IGFzIGVhc2lseSBjb25zdHJ1
Y3QgYW4gaW1hZ2Ugd2hlcmUgaXQgbWFrZXMNCj4+IGEgaHVnZSBkaWZmZXJlbmNlLiBJIHRoaW5r
IHRoYXQgbW9zdCByZWFsLXdvcmxkIGltYWdlcyBzaG91bGQgYmUgYWJsZSB0bw0KPj4gdGFrZSBn
b29kIGFkdmFudGFnZSBvZiBpdCwgdGhvdWdoLCBhbmQgaXQgZG9lc24ndCBodXJ0LCBzbyBtYXli
ZSB0aGF0J3MNCj4+IGEgZmlyc3QgdGhpbmcgdGhhdCB3ZSBjYW4gZG8gaW4gYW55IGNhc2UuIEl0
IG1pZ2h0IG5vdCBiZSB0aGUgY29tcGxldGUNCj4+IHNvbHV0aW9uLCB0aG91Z2guDQo+IA0KPiBI
bW0sIGFuZCBvbmUgbW9yZSBpZGVhIGZyb20gRGVuOg0KPiANCj4gV2UgY2FuIGRldGVjdCBwcmVh
bGxvY2F0ZWQgaW1hZ2UsIGNvbXBhcmluZyBhbGxvY2F0ZWQgc2l6ZSBvZiByZWFsIGZpbGUgd2l0
aA0KPiBudW1iZXIgb2Ygbm9uLXplcm8gcWNvdzIgcmVmY291bnRzLiBTbywgcmVhbCBhbGxvY2F0
aW9uIGlzIG11Y2ggbGVzcyB0aGFuDQo+IGFsbG9jYXRpb24gaW4gcWNvdzIgcG9pbnQgb2Ygdmll
dywgd2UnbGwgZW5hYmxlIGxzZWVrcywgb3RoZXJ3aXNlIC0gbm90Lg0KPiANCg0KS2V2aW4sIHdo
YXQgZG8geW91IHRoaW5rPw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
