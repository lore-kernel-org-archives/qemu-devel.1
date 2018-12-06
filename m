Received: from eggs.gnu.org ([2001:4830:134:3::10]:60008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUuaS-0003eX-BZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUuaO-0007D6-Ej
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:25:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 6 Dec 2018 14:24:52 +0000
Message-ID: <00037b9b-958b-cda9-bc9b-72d8bff5c57f@virtuozzo.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-10-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-10-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C7F3D5E928CD743B892F258A4969A9B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 09/14] nbd/client: Refactor return of
 nbd_receive_negotiate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MDEuMTIuMjAxOCAxOjAzLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBUaGUgZnVuY3Rpb24gY291bGQg
b25seSBldmVyIHJldHVybiAwIG9yIC1FSU5WQUw7IG1ha2UgdGhpcw0KPiBjbGVhcmVyIGJ5IGRy
b3BwaW5nIGEgdXNlbGVzcyAnZmFpbDonIGxhYmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJp
YyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAg
bmJkL2NsaWVudC5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDI4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25iZC9jbGllbnQuYyBiL25iZC9jbGllbnQu
Yw0KPiBpbmRleCAyNzc4NWM1NWQwYS4uMWVkNTAwOTY0MmUgMTAwNjQ0DQo+IC0tLSBhL25iZC9j
bGllbnQuYw0KPiArKysgYi9uYmQvY2xpZW50LmMNCg0KWy4uLl0NCg0KPiAgICAgICB0cmFjZV9u
YmRfcmVjZWl2ZV9uZWdvdGlhdGVfc2l6ZV9mbGFncyhpbmZvLT5zaXplLCBpbmZvLT5mbGFncyk7
DQo+ICAgICAgIGlmICh6ZXJvZXMgJiYgbmJkX2Ryb3AoaW9jLCAxMjQsIGVycnApIDwgMCkgew0K
PiAgICAgICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCAiRmFpbGVkIHRvIHJlYWQgcmVzZXJ2ZWQg
YmxvY2s6ICIpOw0KPiAtICAgICAgICBnb3RvIGZhaWw7DQo+ICsgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiAgICAgICB9DQo+IC0gICAgcmMgPSAwOw0KPiAtDQoNCmhtbSwgcGVyc29uYWxseSBJ
IGxpa2UgdGhpcyBlbXB0eSBsaW5lDQoNCj4gLWZhaWw6DQo+IC0gICAgcmV0dXJuIHJjOw0KPiAr
ICAgIHJldHVybiAwOw0KPiAgIH0NCj4gDQo+ICAgI2lmZGVmIF9fbGludXhfXw0KPiANCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
