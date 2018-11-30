Received: from eggs.gnu.org ([2001:4830:134:3::10]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSe3p-0005pP-OR
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSe3p-0000Fb-07
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:22:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 08:21:46 +0000
Message-ID: <2dcfe390-359e-bb5a-a6f7-d7858ba8ebaa@virtuozzo.com>
References: <20181130023232.3079982-1-eblake@redhat.com>
	<20181130023232.3079982-3-eblake@redhat.com>
In-Reply-To: <20181130023232.3079982-3-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CFE8F78A1DE7449ACDE9FA758F9CCEE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/3] nbd/client: Make x-dirty-bitmap more
 reliable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

MzAuMTEuMjAxOCA1OjMyLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBUaGUgaW1wbGVtZW50YXRpb24g
b2YgeC1kaXJ0eS1iaXRtYXAgaW4gcWVtdSAzLjAgc2lsZW50bHkNCj4gZmFsbHMgYmFjayB0byB0
cmVhdGluZyB0aGUgc2VydmVyIGFzIG5vdCBzdXBwb3J0aW5nDQo+IE5CRF9DTURfQkxPQ0tfU1RB
VFVTIGlmIGEgcmVxdWVzdGVkIG1ldGFfY29udGV4dCBuYW1lIHdhcyBub3QNCj4gbmVnb3RpYXRl
ZCwgd2hpY2ggaW4gdHVybiBtZWFucyB0cmVhdGluZyB0aGUgX2VudGlyZV8gaW1hZ2UgYXMNCj4g
ZGF0YS4gU2luY2Ugb3VyIGhhY2sgcmVsaWVkIG9uIHVzaW5nICdxZW11LWltZyBtYXAnIHRvIHZp
ZXcNCj4gd2hpY2ggcG9ydGlvbnMgb2YgdGhlIGltYWdlIHdlcmUgZGlydHkgYnkgc2VlaW5nIHdo
YXQgdGhlDQo+IHJlZGlyZWN0ZWQgYmRydl9ibG9ja19zdGF0dXMoKSB0cmVhdHMgYXMgaG9sZXMs
IHRoaXMgbWVhbnMNCj4gdGhhdCBvdXIgZmFsbGJhY2sgdHJlYXRzIHRoZSBlbnRpcmUgaW1hZ2Ug
YXMgY2xlYW4uICBCZXR0ZXINCj4gd291bGQgaGF2ZSBiZWVuIHRvIHRyZWF0IHRoZSBlbnRpcmUg
aW1hZ2UgYXMgZGlydHksIG9yIHRvIGZhaWwNCj4gdG8gY29ubmVjdCBiZWNhdXNlIHRoZSB1c2Vy
J3MgcmVxdWVzdCBmb3IgYSBzcGVjaWZpYyBjb250ZXh0DQo+IGNvdWxkIG5vdCBiZSBob25vcmVk
LiBUaGlzIHBhdGNoIGdvZXMgd2l0aCB0aGUgbGF0dGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0N
Cj4gICBibG9jay9uYmQtY2xpZW50LmMgfCA1ICsrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL25iZC1jbGllbnQuYyBiL2Js
b2NrL25iZC1jbGllbnQuYw0KPiBpbmRleCA3NmU5Y2EzYWJlYi4uZTZlMjdkYWZhNmEgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrL25iZC1jbGllbnQuYw0KPiArKysgYi9ibG9jay9uYmQtY2xpZW50LmMN
Cj4gQEAgLTk5Miw2ICs5OTIsMTEgQEAgaW50IG5iZF9jbGllbnRfaW5pdChCbG9ja0RyaXZlclN0
YXRlICpicywNCj4gICAgICAgICAgIGxvZ291dCgiRmFpbGVkIHRvIG5lZ290aWF0ZSB3aXRoIHRo
ZSBOQkQgc2VydmVyXG4iKTsNCj4gICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgIH0NCj4g
KyAgICBpZiAoeF9kaXJ0eV9iaXRtYXAgJiYgIWNsaWVudC0+aW5mby5iYXNlX2FsbG9jYXRpb24p
IHsNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAicmVxdWVzdGVkIHgtZGlydHktYml0bWFw
ICVzIG5vdCBmb3VuZCIsDQo+ICsgICAgICAgICAgICAgICAgICAgeF9kaXJ0eV9iaXRtYXApOw0K
PiArICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAgICB9DQo+ICAgICAgIGlmIChjbGllbnQt
PmluZm8uZmxhZ3MgJiBOQkRfRkxBR19SRUFEX09OTFkpIHsNCj4gICAgICAgICAgIHJldCA9IGJk
cnZfYXBwbHlfYXV0b19yZWFkX29ubHkoYnMsICJOQkQgZXhwb3J0IGlzIHJlYWQtb25seSIsIGVy
cnApOw0KPiAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K
