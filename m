Received: from eggs.gnu.org ([209.51.188.92]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmfs8-0001NA-9M
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmfs7-0005uf-GD
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:20:48 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 14:20:42 +0000
Message-ID: <7eec9b2f-fbf8-51aa-3883-b692324995ec@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
	<5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
	<29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
	<9767ccf8-6a00-88b0-e28a-3b8602580c2e@virtuozzo.com>
	<352c85fb-fd1d-56e7-ace3-61553e8bbc94@redhat.com>
	<7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
	<6cf829bf-2848-b588-c832-1f6f3e037c3d@redhat.com>
In-Reply-To: <6cf829bf-2848-b588-c832-1f6f3e037c3d@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF8809ABA256694C83A6C5F33DF932DD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MjMuMDEuMjAxOSAxNzozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMS8yMy8xOSAyOjIwIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pj4+Pj4+ICsgICAg
ICAgIGhiaXRtYXBfc2V0KGpvYi0+Y29weV9iaXRtYXAsIGNsdXN0ZXIsIGxhc3RfY2x1c3RlciAt
IGNsdXN0ZXIgKyAxKTsNCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2h5IHRoZSArMT8gIFNob3VsZG4ndCB0
aGUgZGl2aXNpb24gZm9yIGxhc3RfY2x1c3RlciByb3VuZCB1cCBpbnN0ZWFkPw0KPj4+Pj4+Pg0K
Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4gKyAgICAgICAgb2Zmc2V0ID0gKGxhc3RfY2x1c3RlciArIDEp
ICogam9iLT5jbHVzdGVyX3NpemU7DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNhbWUgaGVyZS4NCj4+Pj4+
Pg0KPj4+Pj4+IGxhc3QgY2x1c3RlciBpcyBub3QgImVuZCIsIGJ1dCBpdCdzIGxhc3QgZGlydHkg
Y2x1c3Rlci4gc28gbnVtYmVyIG9mIGRpcnR5IGNsdXN0ZXJzIGlzIGxhc3RfY2x1c3RlciAtIGNs
dXN0ZXIgKyAxLCBhbmQgbmV4dCBvZmZzZXQgaXMgY2FsY3VsYXRlZCB0aHJvdWdoICsxIHRvby4N
Cj4+Pj4+Pg0KPj4+Pj4+IElmIEkgcm91bmQgdXAgZGl2aXNpb24gcmVzdWx0LCBJJ2xsIGdldCBs
YXN0IGZvciBtb3N0IGNhc2VzLCBidXQgImVuZCIgKG5leHQgYWZ0ZXIgdGhlIGxhc3QpLCBmb3Ig
dGhlIGNhc2Ugd2hlbiBvZmZzZXQgJSBqb2ItPmNsdXN0ZXJfc2l6ZSA9PSAwLCBzbywgaG93IHRv
IHVzZSBpdD8NCj4+Pj4+DQo+Pj4+PiBEb2Vzbid0IGJkcnZfZGlydHlfYml0bWFwX25leHRfZGly
dHlfYXJlYSgpIHJldHVybiBhIHJhbmdlIFtvZmZzZXQsDQo+Pj4+PiBvZmZzZXQgKyBieXRlcyks
IGkuZS4gd2hlcmUgIm9mZnNldCArIGJ5dGVzIiBpcyB0aGUgZmlyc3QgY2xlYW4gb2Zmc2V0Pw0K
Pj4+Pg0KPj4+PiBvb3BzLCB5b3UgYXJlIHJpZ2h0LiB0aGVuIEkgbmVlZA0KPj4+PiB1aW50NjRf
dCBsYXN0X2NsdXN0ZXIgPSAob2Zmc2V0ICsgYnl0ZXMgLSAxKSAvIGpvYi0+Y2x1c3Rlcl9zaXpl
Ow0KPj4+DQo+Pj4gVGhhdCwgb3IgeW91IGp1c3QgdXNlIGEgcm91bmRpbmcgdXAgZGl2aXNpb24g
YW5kIHJlbmFtZSBpdCBmcm9tDQo+Pj4gbGFzdF9jbHVzdGVyIHRvIGVuZF9jbHVzdGVyIG9yIGZp
cnN0X2NsZWFuX2NsdXN0ZXIgb3Igc29tZXRoaW5nIChhbmQNCj4+PiBzdWJzZXF1ZW50bHkgZHJv
cCB0aGUgKzFzKS4NCj4+DQo+PiBUaGlzIHdpbGwgbm90IHdvcmssIGFzICgob2Zmc2V0ICsgYnl0
ZXMpIC8gam9iLT5jbHVzdGVyX3NpemUpIGlzIG5vdCBmaXJzdCBjbGVhbiBjbHVzdGVyDQo+PiBv
ciBlbmQgY2x1c3Rlci4gSXQncyBhIGNsdXN0ZXIsIHdoZXJlIGlzIGZpcnN0IGNsZWFuIGJpdCBs
b2NhdGVkLCBidXQgaXQgbWF5IGhhdmUgZGlydHkNCj4+IGJpdHMgdG9vIChvciwgbWF5IG5vdCku
DQo+Pg0KPj4gU28sIHRvIHJld3JpdGUgYmFzZWQgb24gZW5kX2NsdXN0ZXIsIGl0IHNob3VsZCBi
ZSBjYWxjdWxhdGVkIGFzDQo+Pg0KPj4gKG9mZnNldCArIGJ5dGVzIC0gMSkgLyBqb2ItPmNsdXN0
ZXJfc2l6ZSArIDENCj4+DQo+PiBhbmQsIEknbSBnb2luZyB0byBkbyBzbywgb25lICIrMSIgaW5z
dGVhZCBvZiB0d28sIGFuZCwgbWF5IGJlLCBhIGJpdCBtb3JlIHVuZGVyc3RhbmRhYmxlLg0KPiAN
Cj4gQmV0dGVyIGlzIHRvIHVzZSB0aGUgbWFjcm9zIGluIG9zZGVwLmgsIHN1Y2ggYXMgUUVNVV9B
TElHTl9VUC9ET1dOLCB0bw0KPiBtYWtlIHRoZSBpbnRlbnQgb2YgdGhlIGNvZGUgZWFzaWVyIHRv
IHJlYWQgdGhhbiBoYXZpbmcgdG8gY2xvc2VseSBjaGVjaw0KPiB3aGljaCBvcGVyYXRpb24gaXMg
YmVpbmcgcGVyZm9ybWVkIHRvIHNlZSBpZiBpdCBtYWtlcyBzZW5zZSBpbiBjb250ZXh0Lg0KPiAN
Cg0KWWVzLCB0aGFua3MuIEV4YWN0bHk6DQp1aW50NjRfdCBlbmRfY2x1c3RlciA9IERJVl9ST1VO
RF9VUChvZmZzZXQgKyBieXRlcywgam9iLT5jbHVzdGVyX3NpemUpOw0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==
