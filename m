Received: from eggs.gnu.org ([209.51.188.92]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1ak2-0006BA-UJ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1ak2-0004RD-3z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:54:06 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 6 Mar 2019 17:53:53 +0000
Message-ID: <b86d5853-f2b1-3c4e-8ba9-c07791facd57@virtuozzo.com>
References: <1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1551694120-768127-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190306145230.GI6818@localhost.localdomain>
In-Reply-To: <20190306145230.GI6818@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <832839B6A386B742A0353336B85FD0D1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: check whitelisted formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>

DQoNCk9uIDA2LzAzLzIwMTkgMTc6NTIsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDA0LjAzLjIw
MTkgdW0gMTE6MDggaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gU29tZSB0
ZXN0IGNhc2VzIHJlcXVpcmUgc3BlY2lmaWMgZm9ybWF0cy4gVGhlIG1ldGhvZCBkZWNvcmF0b3IN
Cj4+IHNraXBfaWZfdW5zdXBwb3J0ZWQoKSBjaGVja3MgaWYgcmVxdWVzdGVkIGZvcm1hdHMgYXJl
IHdoaXRlbGlzdGVkLg0KPj4gVGhlIHRlc3QgIzEzOSB3YXMgc2VsZWN0ZWQgZm9yIGEgc2FtcGxl
IG91dHB1dDoNCj4+DQo+PiAxMzcgM3MgLi4uDQo+PiAxMzggMHMgLi4uDQo+PiAxMzkgMnMgLi4u
DQo+PiAgICAgIFtjYXNlIG5vdCBydW5dIHRlc3RCbGtWZXJpZnkgKF9fbWFpbl9fLlRlc3RCbG9j
a2RldkRlbCk6IGZvcm1hdHMgWydibGt2ZXJpZnknXSBhcmUgbm90IHdoaXRlbGlzdGVkDQo+PiAg
ICAgIFtjYXNlIG5vdCBydW5dIHRlc3RRdW9ydW0gKF9fbWFpbl9fLlRlc3RCbG9ja2RldkRlbCk6
IGZvcm1hdHMgWydxdW9ydW0nXSBhcmUgbm90IHdoaXRlbGlzdGVkDQo+PiAxNDAgMHMgLi4uDQo+
PiBOb3QgcnVuOiAxMzEgMTM1IDEzNg0KPj4gU29tZSBjYXNlcyBub3QgcnVuIGluOiAxMzkNCj4+
IFBhc3NlZCBhbGwgMTM3IHRlc3RzDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5r
ZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IA0KPiBXb3VsZCB5b3Ug
bWluZCBzcXVhc2hpbmcgaW4gdGhpcyBodW5rIGZvciB2Mz8NCj4gDQo+IEtldmluDQo+IA0KDQpJ
IHdpbGwgc3F1YXNoIGl0IGluIHYzLg0KDQpBbmRyZXkNCg0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMv
cWVtdS1pb3Rlc3RzLzEzOSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xMzkNCj4gaW5kZXggY2I5NzAy
OTRkMy4uOTMzYjQ1MTIxYSAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzEzOQ0K
PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTM5DQo+IEBAIC0zMjUsNiArMzI1LDcgQEAgY2xh
c3MgVGVzdEJsb2NrZGV2RGVsKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICAgICAgIyBG
SVhNRSBtaXJyb3IwIGRpc2FwcGVhcnMsIGRyaXZlLW1pcnJvciBkb2Vzbid0IHRha2UgYSByZWZl
cmVuY2UNCj4gICAgICAgICAgICNzZWxmLmRlbEJsb2NrRHJpdmVyU3RhdGUoJ21pcnJvcjAnKQ0K
PiAgIA0KPiArICAgIEBpb3Rlc3RzLnNraXBfaWZfdW5zdXBwb3J0ZWQoWydibGtkZWJ1ZyddKQ0K
PiAgICAgICBkZWYgdGVzdEJsa0RlYnVnKHNlbGYpOg0KPiAgICAgICAgICAgc2VsZi5hZGRCbGtE
ZWJ1ZygnZGVidWcwJywgJ25vZGUwJykNCj4gICAgICAgICAgICMgJ25vZGUwJyBpcyB1c2VkIGJ5
IHRoZSBibGtkZWJ1ZyBub2RlDQo+IA0K
