Received: from eggs.gnu.org ([209.51.188.92]:34991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gs8vM-0003xM-5q
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gs8vK-000078-Ul
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:22:44 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri, 8 Feb 2019 16:22:21 +0000
Message-ID: <bf53d87b-82c3-1d58-edd0-261b3d763f3c@virtuozzo.com>
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<3f708207-2172-3c09-e32b-8267e1be9fc1@redhat.com>
	<0a20041f-e5b2-49d5-3f06-31d855d11fcb@virtuozzo.com>
	<1be61aa6-c6ad-ac25-8a3f-37a7b48f04da@redhat.com>
In-Reply-To: <1be61aa6-c6ad-ac25-8a3f-37a7b48f04da@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B4AB5DA33887442BB85723189DD41A5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 0/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA4LzAyLzIwMTkgMTg6NTMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDIvOC8xOSA5
OjM3IEFNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMDgvMDIvMjAx
OSAxODoyNSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+PiBPbiAyLzgvMTkgOTowNiBBTSwgQW5kcmV5
IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4+IHYxNDoNCj4+Pj4gVGhlIHRlc3QgMjQyIHdhcyBhbWVu
ZGVkIHRvIGJlIHNhZmVyIGFnYWluc3QgY2hhbmdlcyBpbiB0aGUgYml0bWFwIGFsbG9jYXRpb24N
Cj4+Pj4gYWxnb3JpdGhtIGJlY2F1c2UgdGhlIGJpdG1hcCBkaXJlY3RvcnkgaXMgcmVhbGxvY2F0
ZWQgb24gVk0gc2h1dGRvd24uDQo+Pj4+IFVuZm9ydHVuYXRlbHksIGFuIGVtcHR5IGxpbmUgYXQg
dGhlIGVuZCBvZiB0aGUgYmVuY2htYXJrIGZpbGUgMjQyLm91dCBwZXJzaXN0cy4NCj4+Pg0KPj4+
IEVhc3kgc29sdXRpb246IGluIDI0MiwgYWRkIGFuIGV4dHJhIGxvZygiVGVzdCBjb21wbGV0ZSIp
IG9yIHNpbWlsYXINCj4+PiBhZnRlciB0aGUgb3V0cHV0IHRoYXQgcHJvZHVjZXMgdGhlIGJsYW5r
IGxpbmUsIHRoZW4gMjQyLm91dCB3aWxsIG5vDQo+Pj4gbG9uZ2VyIGhhdmUgYSB0cmFpbGluZyBi
bGFuayBsaW5lLg0KPj4+DQo+PiBUaGFuayB5b3UsIEVyaWMuIEl0IGlzIGdvaW5nIHRvIGJlIHZl
cnNpb24gMTUuDQo+IA0KPiBJZiB0aGF0J3MgdGhlIG9ubHkgY2hhbmdlLCB0aGVuIG5vIG5lZWQg
dG8gcG9zdCB2MTU7IHlvdSBjYW4gY2hlY2sgd2hhdA0KPiBJJ20gcHJlcGFyaW5nIHRvIGluY2x1
ZGUgaW4gTW9uZGF5J3MgcHVsbCByZXF1ZXN0Og0KPiANCj4gaHR0cHM6Ly9yZXBvLm9yLmN6L3Fl
bXUvZXJpY2IuZ2l0L3Nob3J0bG9nL3JlZnMvaGVhZHMvbmJkDQo+IA0KVGhhbmsgeW91IGFnYWlu
Lg0KV2l0aCB0aG9zZSBtaW5vciBhbWVuZG1lbnRzICgrc3BhY2VzKSBhbmQgYSBjb3VwbGUgb2Yg
dGhlIHNpZ25pZmljYW50DQoiUmV2aWV3ZWQtYnkiLCB0aGUgdmVyc2lvbiAxNSBoYXMgYmVlbiBw
cmVwYXJlZC4gTWF5IEkgc2VuZCBpdA0Kb3IgeW91IGFyZSBPSyB3aXRoIHRoZSB2ZXJzaW9uIDE0
Pw0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K
