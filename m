Received: from eggs.gnu.org ([2001:4830:134:3::10]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g8UtK-0000Rr-9g
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g8UtE-0004Qu-5X
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:31:57 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 5 Oct 2018 18:31:46 +0000
Message-ID: <da3a89d9-4e22-3b3c-de30-035a4b0d1aba@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-14-vsementsov@virtuozzo.com>
	<20181004124421.GC6009@localhost.localdomain>
	<d691c927-e37a-1178-8180-9893278aa02c@virtuozzo.com>
	<20181004145241.GG6009@localhost.localdomain>
	<19e42ee8-fdbe-e637-6728-bfc10b137f63@virtuozzo.com>
	<46e224bd-8c1f-4565-944e-52440e85e2f0@virtuozzo.com>
	<20181005155213.GB4606@localhost.localdomain>
	<05adf79a-4ae1-0ba1-aa7f-7696aa043594@virtuozzo.com>
	<ac7c795b-127f-8f2e-4953-95b74f57ffee@redhat.com>
In-Reply-To: <ac7c795b-127f-8f2e-4953-95b74f57ffee@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC49B56A68C1B048961FA15AA1BB5F01@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter
 driver: fleecing-hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

VGhhbmsgeW91LCBob3BlIHRoYXQncyBmaXhlZCBub3cpDQoNCk9uIDEwLzA1LzIwMTggMDc6NDcg
UE0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDEwLzUvMTggMTE6NDAgQU0sIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiAwNS4xMC4yMDE4IDE4OjUyLCBLZXZpbiBXb2xm
IHdyb3RlOg0KPj4+IEhpIFZsYWRpbWlyLA0KPj4+DQo+Pj4gY2FuIHlvdSBwbGVhc2UgY2hlY2sg
eW91ciBtYWlsZXIgc2V0dGluZ3M/IFRoZSBwbGFpbiB0ZXh0IHZlcnNpb24gb2YgdGhlDQo+Pj4g
ZW1haWxzIGlzIGhhcmRseSBsZWdpYmxlIGJlY2F1c2UgaXQgbWl4ZXMgcXVvdGVzIHRleHQgYW5k
IHJlcGxpZXMuIEkNCj4+PiBoYWQgdG8gbWFudWFsbHkgb3BlbiB0aGUgSFRNTCBwYXJ0IHRvIGZp
Z3VyZSBvdXQgd2hhdCB5b3UgcmVhbGx5IHdyb3RlLg0KPj4NCj4+IEkndmUgc2VudCBpdCBmcm9t
IG90aGVyIHRodW5kZXJiaXJkIGluc3RhbmNlIGZyb20gaG9tZSwgSSBob3BlDQo+PiB0aHVuZGVy
YmlyZCBhdCB3b3JrICh3aGVyZSBJJ20gY29tcG9zaW5nIG5vdykgaXMgb2suLg0KPiANCj4gQ29t
cGFyaW5nIHRoZSB0d286DQo+IA0KPiBIb21lOg0KPiBNZXNzYWdlLUlEOiA8NDZlMjI0YmQtOGMx
Zi00NTY1LTk0NGUtNTI0NDBlODVlMmYwQHZpcnR1b3p6by5jb20+DQo+IC4uLg0KPiBDb250ZW50
LVR5cGU6IG11bHRpcGFydC9hbHRlcm5hdGl2ZTsNCj4gIMKgwqDCoMKgYm91bmRhcnk9Il8wMDBf
NDZlMjI0YmQ4YzFmNDU2NTk0NGU1MjQ0MGU4NWUyZjB2aXJ0dW96em9jb21fIg0KPiANCj4gV29y
azoNCj4gTWVzc2FnZS1JRDogPDA1YWRmNzlhLTRhZTEtMGJhMS1hYTdmLTc2OTZhYTA0MzU5NEB2
aXJ0dW96em8uY29tPg0KPiAuLi4NCj4gQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0
PSJ1dGYtOCINCj4gQ29udGVudC1JRDogPERGMDZERDU2MTAwMTA4NDY5OUE4RUI5ODJENjY3MjFC
QGV1cnByZDA4LnByb2Qub3V0bG9vay5jb20+DQo+IENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6
IGJhc2U2NA0KPiANCj4gU28sIHRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgYXQgaG9tZSwgeW91IGhh
dmVuJ3QgdG9sZCB0aHVuZGVyYmlyZCB0byBzZW5kIA0KPiBwbGFpbi10ZXh0IG9ubHkgZW1haWxz
IHRvIHNwZWNpZmljIHJlY2lwaWVudHMgKHNldHRpbmcgdXAgdGhlIGxpc3QgYXMgDQo+IG9uZSBv
ZiB0aG9zZSByZWNpcGllbnRzIHRoYXQgd2FudHMgcGxhaW4tdGV4dCBvbmx5KSwgYW5kIHNvbWV0
aGluZyBlbHNlIA0KPiBpbiB5b3VyIGxvY2FsIGNvbmZpZ3VyYXRpb25zIHRoZW4gcmVzdWx0cyBp
biBhIG11bHRpcGFydCBlbWFpbCB3aGVyZSB0aGUgDQo+IGh0bWwgcG9ydGlvbiBsb29rcyBmaW5l
IGJ1dCB0aGUgcGxhaW4tdGV4dCBwb3J0aW9uIGhhcyBob3JyZW5kb3VzIA0KPiBxdW90aW5nLiBC
dXQgYXQgd29yaywgeW91IGFyZSBjb25maWd1cmVkIGZvciBwbGFpbi10ZXh0LW9ubHkgb3V0cHV0
LCANCj4gaHRtbCBpcyBub3QgZXZlbiBhdmFpbGFibGUsIGFuZCB0aGUgcXVvdGluZyBpcyBkZWNl
bnQgZnJvbSB0aGUgc3RhcnQuDQo+IA0K
