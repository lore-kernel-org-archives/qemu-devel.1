Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUx7E-0007w8-9T
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUx78-00029F-9I
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:07:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 6 Dec 2018 17:06:46 +0000
Message-ID: <fa614264-4983-bbdd-b69a-3487f2dfecb4@virtuozzo.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-11-eblake@redhat.com>
	<6e4074f9-99c1-3ed3-01dd-ed99018089d5@virtuozzo.com>
In-Reply-To: <6e4074f9-99c1-3ed3-01dd-ed99018089d5@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F69B0FA2C93534D9D6459055A9DC9C8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 10/14] nbd/client: Split handshake into two
 functions
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

MDYuMTIuMjAxOCAxODoxNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDEuMTIuMjAxOCAxOjAzLCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gKyAqIFJldHVybnM6IG5lZ2F0
aXZlIGVycm5vOiBmYWlsdXJlIHRhbGtpbmcgdG8gc2VydmVyDQo+PiArICrCoMKgwqDCoMKgwqDC
oMKgwqAgMDogc2VydmVyIGlzIG9sZHN0eWxlLCBjbGllbnQgbXVzdCBzdGlsbCBwYXJzZSBleHBv
cnQgc2l6ZQ0KPj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgIDE6IHNlcnZlciBpcyBuZXdzdHlsZSwg
YnV0IGNhbiBvbmx5IGFjY2VwdCBFWFBPUlRfTkFNRQ0KPj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKg
IDI6IHNlcnZlciBpcyBuZXdzdHlsZSwgYnV0IGxhY2tzIHN0cnVjdHVyZWQgcmVwbGllcw0KPj4g
KyAqwqDCoMKgwqDCoMKgwqDCoMKgIDM6IHNlcnZlciBpcyBuZXdzdHlsZSBhbmQgc2V0IHVwIGZv
ciBzdHJ1Y3R1cmVkIHJlcGxpZXMNCj4+ICsgKi8NCj4gDQo+IGhtbSwgbWF5IGJlLCBpbnRyb2R1
Y2UgZW51bSBvZiBuYW1lZCBjb25zdGFudHMsIGluc3RlYWQgb2YgcmF3IG51bWJlcnM/DQo+IA0K
PiBOQkRfU1RBUlRFRF9PTERfU1RZTEUNCj4gTkJEX1NUQVJURURfTkVXX1NUWUxFDQo+IE5CRF9T
VEFSVEVEX05FV19TVFlMRV9GSVhFRA0KPiBOQkRfU1RBUlRFRF9TVFJVQ1RVUkVEX1JFUExJRVMN
Cj4gDQo+IG9yLCBhdCBsZWFzdCwgYWRkIHNob3J0IGNvbW1lbnQgYWZ0ZXIgZWFjaCByZXR1cm4g
c3RhdGVtZW50LCB0byBub3Qgc2Nyb2xsIHVwDQo+IGV2ZXJ5IHRpbWUgKGxpa2UgeW91IGdyYWNl
ZnVsbHkgZG8gYWZ0ZXIgZWFjaCBjYXNlOiBzdGF0ZW1lbnQpLg0KPiANCj4gSG93ZXZlciwgSSdt
IG9rYXkgd2l0aCBlaXRoZXIgd2F5Lg0KPiANCg0KSSBtZWFuLCBpbmNsdWRpbmcgImFzIGlzIi4N
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
