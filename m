Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gHBiK-0003O8-Sm
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gHBiE-0001cz-Q8
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:52:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Oct 2018 17:52:09 +0000
Message-ID: <72f7a1bd-940d-475f-ceb6-cd105fe02e2b@virtuozzo.com>
References: <20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
	<20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
	<20180801185515.GE2691@work-vm>
	<6bfdc952-fb17-feae-f367-be710853d829@openvz.org>
	<20180802092907.GA2523@work-vm>
	<202065a2-f9d1-ce31-b12b-437d57095ac1@openvz.org>
	<20180802095056.GB2523@work-vm>
	<86304a35-efd8-a605-f684-2bd3fb3b9815@openvz.org>
	<1e41d103-6d56-71e8-ef60-fc4c9343a06e@redhat.com>
	<6d8ed319-9b63-5a7b-fcfe-20cd37cf8c7c@virtuozzo.com>
	<d2538432-be74-99bc-72d1-94f8abaa2f9b@redhat.com>
	<26c0e008-898d-924a-214e-68ab9fedf1ea@virtuozzo.com>
In-Reply-To: <26c0e008-898d-924a-214e-68ab9fedf1ea@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B70F184CDE56C04381BADF33648B6CDB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] ping2 Re: [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

cGluZzINCg0KSGksIHdoYXQgYWJvdXQgdGhpcyBmaW5hbGx5PyBMb29rcyBsaWtlIGV2ZXJ5b25l
IHNlZSBhIGxvdCBvZiBjb21tZW50cyANCmFuZCB0aGluZywgdGhhdCB0aGVyZSBzaG91bGQgYmUg
YSBuZXcgdmVyc2lvbiwgYnV0IGFjdHVhbGx5LCB0aGVyZSBpcyANCmFsbW9zdCB1bnJlbGF0ZWQg
ZGlzY3Vzc2lvbiBhbmQvb3IgYW5zd2VyZWQgcXVlc3Rpb25zLiBPbmx5IHJlcGhyYXNpbmcgDQpi
eSBFcmljIGluIHBhdGNoIDIgbWF5IGJlIGFwcGxpZWQsIHRvIGNoYW5nZSBzb21ldGhpbmcuDQpU
aGUgc2VyaWVzIGZpeCB0aGUgYnVnIGluIGJpdG1hcHMgbWlncmF0aW9uLCBsb29rIGF0IHBhdGNo
IDUuDQoNCjE4LjA5LjIwMTggMTM6MzcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDE3LjA5LjIwMTggMjE6MzMsIEpvaG4gU25vdyB3cm90ZToNCj4+DQo+PiBPbiAwOS8x
Ny8yMDE4IDExOjUxIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+
IEhtbSwgcGluZywgYW55Ym9keSBoZXJlID8pDQo+Pj4NCj4+IFdhcyBwcmVwYXJpbmcgdG8gc3Rh
Z2Ugb24gRnJpZGF5LCB3b3JraW5nIG9uIGl0IG5vdy4NCj4+DQo+PiBJIG5ldmVyIHVuZGVyc3Rv
b2Qgd2h5IHlvdSBmb3JiaWQgdGhlIHRyYW5zZmVyIG9mIHJlYWQgb25seSBiaXRtYXBzDQo+PiB0
aG91Z2gsIGNhbiB5b3UgcG9pbnQgdGhhdCBvdXQgZm9yIG1lPw0KPj4NCj4+IC0tanMNCj4NCj4g
cmVhZG9ubHkgYml0bWFwIC0gbWVhbnMgaXQgaXMgbm90IG1hcmtlZCBpbl91c2UgaW4gcWNvdzIg
ZmlsZS4NCj4NCj4gSG0sIEkgZG9uJ3QgcmVtZW1iZXIgZXhhY3QgcmVhc29uLCBidXQgYXQgbGVh
c3QgZm9yIHNoYXJlZCBtaWdyYXRpb24gDQo+IGl0IGlzIHVuc2FmZSB0byBtaWdyYXRlIHJlYWRv
bmx5IGJpdG1hcCB3aXRob3V0IHNwZWNpYWwgaGFuZGxpbmc6IHdlIA0KPiBtaWdyYXRlIGl0LCBp
dCBiZWNvbWVzIG5vdC1yZWFkb25seSwgaXQgY2hhbmdlcyBpbiBSQU0sIHRoZW4gKGFzc3VtZSkg
DQo+IHN0b3JpbmcgZmFpbGVkIGFuZCB3ZSBoYXZlIG9sZCB2ZXJzaW9uIG9mdGhlIGJpdG1hcCBp
biBxY293Miwgd2hpY2ggaXMgDQo+IG5vdCBtYXJrZWQgaW5fdXNlLi4gU28gaXQgc2hvdWxkIGJl
IHNvbWVob3cgY2FyZWZ1bGx5IGhhbmRsZWQsIHRoZSANCj4gc2ltcGxlc3Qgb3B0aW9uIGlzIGp1
c3QgdG8gZm9yYmlkIGl0Lg0KPg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg0K
