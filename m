Received: from eggs.gnu.org ([209.51.188.92]:34963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyHuu-0004gc-KQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyHut-0003Xf-To
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:11:40 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 15:11:24 +0000
Message-ID: <e746c6a7-f354-ac90-c798-53e662955c39@virtuozzo.com>
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-4-jsnow@redhat.com>
	<be3360bb-cbc1-daa1-2297-f3f8a88faac9@virtuozzo.com>
	<f8cee179-d67f-2426-7d65-c208a82f1876@virtuozzo.com>
	<b293f181-7b78-c11b-81ab-0f4b04e6fb25@redhat.com>
In-Reply-To: <b293f181-7b78-c11b-81ab-0f4b04e6fb25@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA9CF2DEEF362F4EB58750E10EA52857@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

MjUuMDIuMjAxOSAxODowNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi8yNS8xOSA4OjU5IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+DQo+PiBBbmQgb25l
IG1vcmUgaW1wb3J0YW50IHF1ZXN0aW9uOiB3ZSBub3cgY3JlYXRpbmcgbmV3IHFhcGkgYml0bWFw
IHN0YXR1cywgY29uc2lzdGluZyBvZiBzZXZlcmFsIGJvb2wgZmllbGRzLg0KPj4gU2hvdWxkbid0
IHdlIGluc3RlYWQgaW1wbGVtZW50IGl0IGFzIGFuIGFycmF5IG9mIGZsYWdzPw0KPiANCj4gUGFy
c2luZzoNCj4gDQo+IHsgImJ1c3kiOiBmYWxzZSwgInBlcnNpc3RlbnQiOiBmYWxzZSwgInJlY29y
ZGluZyI6IHRydWUgfQ0KPiANCj4gaXMgZWFzaWVyIHRoYW4gcGFyc2luZzoNCj4gDQo+IHsgImZs
YWdzIjogWyAicmVjb3JkaW5nIiBdIH0NCj4gDQo+IChhbmQga25vd2luZyB0aGF0IHVubGlzdGVk
IGZsYWdzICJidXN5IiwgInBlcnNpc3RlbnQiLCBhbmQNCj4gImluY29uc2lzdGVudCIgYXJlIGZh
bHNlKSwgb3I6DQo+IA0KPiB7ICJmbGFncyI6IFsgeyAiYnVzeSI6IGZhbHNlIH0sIHsgInBlcnNp
c3RlbnQiOiBmYWxzZSB9LCB7ICJyZWNvcmRpbmciOg0KPiB0cnVlIH0gXSB9DQo+IA0KPiBTbyB3
aXRob3V0IG1vcmUgcmVhc29uIHdoeSBhbiBhcnJheSBvZiBmbGFncyB3b3VsZCBiZSBuZWVkZWQs
IEkgZG9uJ3QNCj4gc2VlIHRoZSBwb2ludCBmb3IgaXQuDQo+IA0KDQpPay4gVGhlIG9ubHkgcmVh
c29uIEkgc2VlIGlzIHVwY29taW5nIGFwcGVhcmFuY2Ugb2YgZmxhZ3MgaW4gaW1wbGVtZW50YXRp
b24uIEJ1dCBpdCBzZWVtcyBub3QgZW5vdWdoIHJlYXNvbi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K
