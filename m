Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gBzOs-0007nY-V3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gBzOm-0007yc-2P
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:42:56 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 09:42:46 +0000
Message-ID: <cfe31ab4-92e7-41e1-24f3-2a09663021d7@virtuozzo.com>
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
Content-ID: <AC6505B232276940BFD62EC74818AD40@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] ping Re: [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
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

cGluZw0KDQoxOC4wOS4yMDE4IDEzOjM3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiAxNy4wOS4yMDE4IDIxOjMzLCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4gT24gMDkv
MTcvMjAxOCAxMTo1MSBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
PiBIbW0sIHBpbmcsIGFueWJvZHkgaGVyZSA/KQ0KPj4+DQo+PiBXYXMgcHJlcGFyaW5nIHRvIHN0
YWdlIG9uIEZyaWRheSwgd29ya2luZyBvbiBpdCBub3cuDQo+Pg0KPj4gSSBuZXZlciB1bmRlcnN0
b29kIHdoeSB5b3UgZm9yYmlkIHRoZSB0cmFuc2ZlciBvZiByZWFkIG9ubHkgYml0bWFwcw0KPj4g
dGhvdWdoLCBjYW4geW91IHBvaW50IHRoYXQgb3V0IGZvciBtZT8NCj4+DQo+PiAtLWpzDQo+DQo+
IHJlYWRvbmx5IGJpdG1hcCAtIG1lYW5zIGl0IGlzIG5vdCBtYXJrZWQgaW5fdXNlIGluIHFjb3cy
IGZpbGUuDQo+DQo+IEhtLCBJIGRvbid0IHJlbWVtYmVyIGV4YWN0IHJlYXNvbiwgYnV0IGF0IGxl
YXN0IGZvciBzaGFyZWQgbWlncmF0aW9uIA0KPiBpdCBpcyB1bnNhZmUgdG8gbWlncmF0ZSByZWFk
b25seSBiaXRtYXAgd2l0aG91dCBzcGVjaWFsIGhhbmRsaW5nOiB3ZSANCj4gbWlncmF0ZSBpdCwg
aXQgYmVjb21lcyBub3QtcmVhZG9ubHksIGl0IGNoYW5nZXMgaW4gUkFNLCB0aGVuIChhc3N1bWUp
IA0KPiBzdG9yaW5nIGZhaWxlZCBhbmQgd2UgaGF2ZSBvbGQgdmVyc2lvbiBvZnRoZSBiaXRtYXAg
aW4gcWNvdzIsIHdoaWNoIGlzIA0KPiBub3QgbWFya2VkIGluX3VzZS4uIFNvIGl0IHNob3VsZCBi
ZSBzb21laG93IGNhcmVmdWxseSBoYW5kbGVkLCB0aGUgDQo+IHNpbXBsZXN0IG9wdGlvbiBpcyBq
dXN0IHRvIGZvcmJpZCBpdC4NCj4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQoN
Cg==
