Received: from eggs.gnu.org ([209.51.188.92]:40828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hBbGi-0006EF-NO
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hBbGh-0007GA-TI
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:29:12 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 3 Apr 2019 08:29:05 +0000
Message-ID: <6788cca6-2402-f14a-3929-31e5c0269c53@virtuozzo.com>
References: <1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1553866154-257311-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51sgv54qaz.fsf@maestria.local.igalia.com>
In-Reply-To: <w51sgv54qaz.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6883FCD05932640BA9040CE472F1095@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] block/stream: introduce a bottom node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDI5LzAzLzIwMTkgMTk6MDcsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MjkgTWFyIDIwMTkgMDI6Mjk6MTQgUE0gQ0VULCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+
IEBAIC0zMjM3LDcgKzMyMzgsMTQgQEAgdm9pZCBxbXBfYmxvY2tfc3RyZWFtKGJvb2wgaGFzX2pv
Yl9pZCwgY29uc3QgY2hhciAqam9iX2lkLCBjb25zdCBjaGFyICpkZXZpY2UsDQo+PiAgICAgICAg
ICAgam9iX2ZsYWdzIHw9IEpPQl9NQU5VQUxfRElTTUlTUzsNCj4+ICAgICAgIH0NCj4+ICAgDQo+
PiAtICAgIHN0cmVhbV9zdGFydChoYXNfam9iX2lkID8gam9iX2lkIDogTlVMTCwgYnMsIGJhc2Vf
YnMsIGJhc2VfbmFtZSwNCj4+ICsgICAgLyogRmluZCB0aGUgYm90dG9tIG5vZGUgdGhhdCBoYXMg
dGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1hZ2UgKi8NCj4+ICsgICAgYm90dG9tX25vZGUgPSBi
czsNCj4+ICsgICAgd2hpbGUgKChpdGVyID0gYmFja2luZ19icyhib3R0b21fbm9kZSkpICE9IGJh
c2VfYnMpIHsNCj4+ICsgICAgICAgIGJvdHRvbV9ub2RlID0gaXRlcjsNCj4+ICsgICAgfQ0KPj4g
KyAgICBhc3NlcnQoYm90dG9tX25vZGUpOw0KPj4gKw0KPj4gKyAgICBzdHJlYW1fc3RhcnQoaGFz
X2pvYl9pZCA/IGpvYl9pZCA6IE5VTEwsIGJzLCBib3R0b21fbm9kZSwgYmFzZV9uYW1lLA0KPj4g
ICAgICAgICAgICAgICAgICAgIGpvYl9mbGFncywgaGFzX3NwZWVkID8gc3BlZWQgOiAwLCBvbl9l
cnJvciwgJmxvY2FsX2Vycik7DQo+IA0KPiBJc24ndCBpdCBzaW1wbGVyIHRvIHBhc3MgJ2Jhc2Un
IHRvIHN0cmVhbV9zdGFydCgpIGFuZCBmaW5kIHRoZSBib3R0b20NCj4gbm9kZSB0aGVyZT8gKHdp
dGggYmRydl9maW5kX292ZXJsYXkoKSkuDQo+IA0KDQpJIGFtIGdvaW5nIHRvIG1vdmUgdGhlIGJv
dHRvbSA9IGJkcnZfZmluZF9vdmVybGF5KCkgaW50byB0aGUNCnN0cmVhbV9zdGFydCgpIGluIHYz
LCB3aGljaCBpcyBjb21pbmcgc29vbi4NCg0KPiBJIHRoaW5rIGJvdHRvbSBzaG91bGQgYmUgYW4g
aW50ZXJuYWwgaW1wbGVtZW50YXRpb24gZGV0YWlsIG9mIHRoZQ0KPiBibG9jay1zdHJlYW0gZHJp
dmVyLCBjYWxsZXJzIGRvbid0IG5lZWQgdG8ga25vdyBhYm91dCBpdCwgb3IgZG8gdGhleT8NCj4g
DQo+IEJlcnRvDQo+IA0KDQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlu
a2V2aWNoDQo=
