Received: from eggs.gnu.org ([2001:4830:134:3::10]:58742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gX3wO-0007YA-GH
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gX3wN-0007vG-Oj
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:48:40 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 12 Dec 2018 12:48:28 +0000
Message-ID: <bd2c4805-86b4-469a-6e3f-01f787d4b3a9@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-6-anton.nefedov@virtuozzo.com>
	<c8832c65-4b52-b56f-cd0b-499597a82b11@virtuozzo.com>
	<50f8f543-f242-649b-407c-fe7c73b91177@virtuozzo.com>
In-Reply-To: <50f8f543-f242-649b-407c-fe7c73b91177@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE929EF62911E8428398054ED305A43C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 5/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

MDUuMTIuMjAxOCAxNzowMSwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gLS0tIGEvaW5jbHVkZS9i
bG9jay9ibG9jay5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2suaA0KPiBAQCAtODcsNiAr
ODcsOSBAQCB0eXBlZGVmIGVudW0gew0KPiAgICAgICAgICogZWZmaWNpZW50bHkgYWxsb2NhdGUg
dGhlIHNwYWNlIHNvIGl0IHJlYWRzIGFzIHplcm9lcywgb3IgcmV0dXJuDQo+IGFuIGVycm9yLg0K
PiAgICAgICAgICogSWYgdGhpcyBmbGFnIGlzIHNldCB0aGVuIEJEUlZfUkVRX1pFUk9fV1JJVEUg
bXVzdCBhbHNvIGJlIHNldC4NCj4gICAgICAgICAqIFRoaXMgZmxhZyBjYW5ub3QgYmUgc2V0IHRv
Z2V0aGVyIHdpdGggQkRSVl9SRVFfTUFZX1VOTUFQLg0KPiArICAgICAqIFRoaXMgZmxhZyBpbXBs
aWNpdGx5IGJlaGF2ZXMgYXMgQkRSVl9SRVFfU0VSSUFMSVNJTkcgaS5lLiBpdCBpcw0KPiArICAg
ICAqIHByb3RlY3RlZCBmcm9tIGNvbmZsaWN0cyB3aXRoIG92ZXJsYXBwaW5nIHJlcXVlc3RzLiBJ
ZiBzdWNoDQo+IGNvbmZsaWN0IGlzDQo+ICsgICAgICogZGV0ZWN0ZWQsIC1FQUdBSU4gaXMgcmV0
dXJuZWQuDQoNCiJiZWhhdmVzIGFzIiBzb3VuZHMgbGlrZSAiZG8gdGhlIHNhbWUiIGZvciBtZSwg
c28gYmV0dGVyIGlzICJpbXBsaWNpdGx5IHNldHMiIG9yIHNvbWV0aGluZyBsaWtlIHRoaXMuDQoN
Cj4gICAgICAgICAqLw0KPiAgICAgICAgQkRSVl9SRVFfQUxMT0NBVEUgICAgICAgICAgID0gMHgx
MDAsDQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
