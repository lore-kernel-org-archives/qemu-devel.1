Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7ina-0006hV-SS
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7inU-0004qA-C6
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:10:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 15:10:37 +0000
Message-ID: <eb157eaa-b55d-3044-3c25-46a7d8e998f9@virtuozzo.com>
References: <20181003144738.70670-1-vsementsov@virtuozzo.com>
	<121a81ed-7932-b96c-cc84-60b82725d8e1@redhat.com>
In-Reply-To: <121a81ed-7932-b96c-cc84-60b82725d8e1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD441D83329F314EB7DEBD40941C7B06@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>, qemu-stable <qemu-stable@nongnu.org>

MDMuMTAuMjAxOCAxNzo1NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMy8xOCA5OjQ3IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gV2Ugc2hvdWxkIG5vdCBn
byB0byBzdHJ1Y3R1cmVkLXJlYWQgYnJhbmNoIG9uIENBQ0hFIGNvbW1hbmQsIGZpeCB0aGF0Lg0K
Pj4NCj4+IEJ1ZyBpbnRvcm9kdWNlZCBpbiBiYzM3YjA2YTVjZGUyNCAibmJkL3NlcnZlcjogaW50
cm9kdWNlIE5CRF9DTURfQ0FDSEUiDQo+DQo+IHMvaW50b3JvZHVjZWQvaW50cm9kdWNlZC8NCj4N
Cj4+IHdpdGggdGhlIHdob2xlIGZlYXR1cmUgYW5kIGFmZmVjdHMgMy4wLjAgcmVsZWFzZS4NCj4N
Cj4gT3VjaC4gSXQncyBiZWNhdXNlIEkgZG9uJ3QgaGF2ZSBhbiBOQkQgY2xpZW50IHRoYXQgY2Fu
IGlzc3VlIHRoZSANCj4gY29tbWFuZCwgc28gdGhlIHNlcnZlciBzaWRlIGdvdCByZWxlYXNlZCB3
aXRob3V0IHN1ZmZpY2llbnQgdGVzdGluZy4gDQo+IElzIHRoZXJlIHNvbWUgd2F5IHdlIGNvdWxk
IGVuaGFuY2UgcWVtdS1pbyBhcyBOQkQgY2xpZW50IHRvIGlzc3VlIHN1Y2ggDQo+IGEgY29tbWFu
ZD8NCg0KbWF5IGJlLCBqdXN0IGFkZCBxZW11LWlvIGNvbW1hbmQsIGxpa2UgeC1kZWJ1Zy1uYmQt
Y21kLCB3aGljaCB3aWxsIGp1c3QgDQpzZW5kIGFueSBuYmQgY29tbWFuZD8gYW5kIHByaW50cyBh
bGwgc2VydmVyIHJlcGxpZXM/IFRoZW4gd2UnbGwgYmUgYWJsZSANCnRvIHdyaXRlIGFueSB1bml0
IHRlc3RzIG9uIG5iZC1zZXJ2ZXIuIEl0J3Mgbm90IHRoZSBmaXJzdCB0aW1lIHRoZSANCnByb2Js
ZW0gYXJpc2UuLg0KDQo+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPg0KPiBDQzogcWVtdS1zdGFi
bGVAbm9uZ251Lm9yZw0KPg0KPiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhh
dC5jb20+DQo+DQo+IFdpbGwgcXVldWUgdGhyb3VnaCBteSBOQkQgdHJlZS4NCj4NCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQoNCg==
