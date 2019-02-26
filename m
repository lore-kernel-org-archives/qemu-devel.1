Received: from eggs.gnu.org ([209.51.188.92]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyfm8-00027G-1C
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyfm6-0001BC-Ly
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:40:12 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 26 Feb 2019 16:39:41 +0000
Message-ID: <4291b1c0-bd89-4e39-f033-696420d1ba4f@virtuozzo.com>
References: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1550762799-830661-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1c4720aa-2831-ae7c-379d-8b7702a9dd23@virtuozzo.com>
	<w5136oaoesa.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136oaoesa.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD98BBEAE1C2D940BC8B33332ECED149@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] block-stream: include base into job
 node list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

DQoNCk9uIDI2LzAyLzIwMTkgMTY6MzMsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBNb24g
MjUgRmViIDIwMTkgMDU6Mzk6MTQgUE0gQ0VULCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IHdyb3RlOg0KPj4+IC0tLSBhL2Jsb2NrL3N0cmVhbS5jDQo+Pj4gKysrIGIvYmxvY2svc3RyZWFt
LmMNCj4+PiBAQCAtMjU5LDYgKzI1OSwxNSBAQCB2b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFy
ICpqb2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+Pj4gICAgICAgIH0NCj4+PiAgICANCj4+PiArICAg
IGlmIChiYXNlKSB7DQo+Pj4gKyAgICAgICAgLyoNCj4+PiArICAgICAgICAgKiBUaGUgYmFzZSBu
b2RlIHNob3VsZCBub3QgZGlzYXBwZWFyIGR1cmluZyB0aGUgam9iLg0KPj4+ICsgICAgICAgICAq
Lw0KPj4+ICsgICAgICAgIGJsb2NrX2pvYl9hZGRfYmRydigmcy0+Y29tbW9uLCAiYmFzZSIsIGJh
c2UsIDAsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX0FMTCAmIH5C
TEtfUEVSTV9HUkFQSF9NT0QsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJv
cl9hYm9ydCk7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICAgICAgICBzLT5iYXNlID0gYmFzZTsN
Cj4+PiAgICAgICAgcy0+YmFja2luZ19maWxlX3N0ciA9IGdfc3RyZHVwKGJhY2tpbmdfZmlsZV9z
dHIpOw0KPj4+ICAgICAgICBzLT5ic19yZWFkX29ubHkgPSBic19yZWFkX29ubHk7DQo+Pj4NCj4+
DQo+Pg0KPj4gSG1tLCBpbnRlcnN0aW5nLCBpcyBCTEtfUEVSTV9HUkFQSF9NT0QgYSBnb29kIHdh
eSB0byBsb2NrIHJlbGF0aW9ucyBpbg0KPj4gbm9kZSBncmFwaD8NCj4+DQo+PiBiZHJ2X3JlcGxh
Y2Vfbm9kZSBkb24ndCBjaGVjayB0aGlzIHBlcm1pc3Npb24uIFNvLCBJIGRvbid0IHVuZGVyc3Rh
bmQsDQo+PiBob3cgdGhpcyBwZXJtaXNzaW9uIHdvcmtzLi4gR3JhcGggbW9kaWZpY2F0aW9uIG9w
ZXJhdGlvbiBpbiBkaWZmZXJlbmNlDQo+PiB3aXRoIHJlYWQgb3Igd3JpdGUgYXJlIG5vdCBkb25l
IHRocm91Z2ggQmRydkNoaWxkIGF0IGFsbC4NCj4+DQo+PiBBcmUgdGhlcmUgYW55IGlkZWFzIG9y
IHdvcmsgc3RhcnRlZCBmb3Igc29tZSBhbm90aGVyIG1lY2hhbmlzbSBvZg0KPj4gImZyZWV6aW5n
IiBhIHN1YmdyYXBoIGR1cmluZyBhbiBvcGVyYXRpb24/DQo+IA0KPiBTZWUgdGhpcyBkaXNjdXNz
aW9uOg0KPiANCj4gICAgIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1i
bG9jay8yMDE4LTExL21zZzAwMzg3Lmh0bWwNCj4gDQo+IEFuZCB0aGVzZSBwYXRjaGVzIChjdXJy
ZW50bHkgdW5kZXIgcmV2aWV3KToNCj4gDQo+ICAgICBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtYmxvY2svMjAxOS0wMS9tc2cwMDYyMi5odG1sDQo+IA0KPiBCZXJ0bw0K
PiANCg0KVGhlIGJkcnZfZnJlZXplX2JhY2tpbmdfY2hhaW4oKSBleGNsdWRlcyB0aGUgYmFzZSBC
bG9ja0RyaXZlclN0YXRlLg0KQW5kIHdlIHdvdWxkIGxpa2UgdG8gcHJvdGVjdCB0aGUgYmFzZSBh
cyB3ZWxsIHdoZW4gcnVubmluZyB0aGUNCmJsb2NrLXN0cmVhbS4NCi0tIA0KV2l0aCB0aGUgYmVz
dCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==
