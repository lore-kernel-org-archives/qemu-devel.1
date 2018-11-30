Received: from eggs.gnu.org ([2001:4830:134:3::10]:51131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSePp-00011K-8U
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSeB8-00064P-3l
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:29:38 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 08:29:29 +0000
Message-ID: <ae3778cc-5a97-0cc0-c5a0-4c5f070b805d@virtuozzo.com>
References: <20181130023232.3079982-1-eblake@redhat.com>
	<20181130023232.3079982-4-eblake@redhat.com>
In-Reply-To: <20181130023232.3079982-4-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D16467DFC633DF4780FCDB42025FE7F5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] nbd/client: Send NBD_CMD_DISC if open
 fails after connect
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

MzAuMTEuMjAxOCA1OjMyLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBJZiBuYmRfY2xpZW50X2luaXQo
KSBmYWlscyBhZnRlciB3ZSBhcmUgYWxyZWFkeSBjb25uZWN0ZWQsDQo+IHRoZW4gdGhlIHNlcnZl
ciB3aWxsIHNwYW0gbG9ncyB3aXRoOg0KPiANCj4gRGlzY29ubmVjdCBjbGllbnQsIGR1ZSB0bzog
VW5leHBlY3RlZCBlbmQtb2YtZmlsZSBiZWZvcmUgYWxsIGJ5dGVzIHdlcmUgcmVhZA0KPiANCj4g
dW5sZXNzIHdlIGdyYWNlZnVsbHkgZGlzY29ubmVjdCBiZWZvcmUgY2xvc2luZyB0aGUgY29ubmVj
dGlvbi4NCj4gDQo+IFdheXMgdG8gdHJpZ2dlciB0aGlzOg0KPiANCj4gJCBvcHRzPWRyaXZlcj1u
YmQsZXhwb3J0PWZvbyxzZXJ2ZXIudHlwZT1pbmV0LHNlcnZlci5ob3N0PWxvY2FsaG9zdCxzZXJ2
ZXIucG9ydD0xMDgwOQ0KPiAkICBxZW11LWltZyBtYXAgLS1vdXRwdXQ9anNvbiAtLWltYWdlLW9w
dHMgJG9wdHMscmVhZC1vbmx5PW9mZg0KPiAkICBxZW11LWltZyBtYXAgLS1vdXRwdXQ9anNvbiAt
LWltYWdlLW9wdHMgJG9wdHMseC1kaXJ0eS1iaXRtYXA9bm9zdWNoOg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4g
LS0tDQo+ICAgYmxvY2svbmJkLWNsaWVudC5jIHwgMTggKysrKysrKysrKysrKysrKy0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYmxvY2svbmJkLWNsaWVudC5jIGIvYmxvY2svbmJkLWNsaWVudC5jDQo+IGlu
ZGV4IGU2ZTI3ZGFmYTZhLi5mYzViN2VkYThlZSAxMDA2NDQNCj4gLS0tIGEvYmxvY2svbmJkLWNs
aWVudC5jDQo+ICsrKyBiL2Jsb2NrL25iZC1jbGllbnQuYw0KPiBAQCAtOTk1LDEyICs5OTUsMTMg
QEAgaW50IG5iZF9jbGllbnRfaW5pdChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgaWYg
KHhfZGlydHlfYml0bWFwICYmICFjbGllbnQtPmluZm8uYmFzZV9hbGxvY2F0aW9uKSB7DQo+ICAg
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJyZXF1ZXN0ZWQgeC1kaXJ0eS1iaXRtYXAgJXMgbm90
IGZvdW5kIiwNCj4gICAgICAgICAgICAgICAgICAgICAgeF9kaXJ0eV9iaXRtYXApOw0KPiAtICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gKyAgICAg
ICAgZ290byBmYWlsOw0KPiAgICAgICB9DQo+ICAgICAgIGlmIChjbGllbnQtPmluZm8uZmxhZ3Mg
JiBOQkRfRkxBR19SRUFEX09OTFkpIHsNCj4gICAgICAgICAgIHJldCA9IGJkcnZfYXBwbHlfYXV0
b19yZWFkX29ubHkoYnMsICJOQkQgZXhwb3J0IGlzIHJlYWQtb25seSIsIGVycnApOw0KPiAgICAg
ICAgICAgaWYgKHJldCA8IDApIHsNCj4gLSAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAg
ICAgICAgICBnb3RvIGZhaWw7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gICAgICAgaWYg
KGNsaWVudC0+aW5mby5mbGFncyAmIE5CRF9GTEFHX1NFTkRfRlVBKSB7DQo+IEBAIC0xMDI5LDQg
KzEwMzAsMTcgQEAgaW50IG5iZF9jbGllbnRfaW5pdChCbG9ja0RyaXZlclN0YXRlICpicywNCj4g
DQo+ICAgICAgIGxvZ291dCgiRXN0YWJsaXNoZWQgY29ubmVjdGlvbiB3aXRoIE5CRCBzZXJ2ZXJc
biIpOw0KPiAgICAgICByZXR1cm4gMDsNCj4gKw0KPiArIGZhaWw6DQo+ICsgICAgLyoNCj4gKyAg
ICAgKiBXZSBoYXZlIGNvbm5lY3RlZCwgYnV0IG11c3QgZmFpbCBmb3Igb3RoZXIgcmVhc29ucy4g
VGhlDQo+ICsgICAgICogY29ubmVjdGlvbiBpcyBzdGlsbCBibG9ja2luZzsgc2VuZCBOQkRfQ01E
X0RJU0MgYXMgYSBjb3VydGVzeQ0KPiArICAgICAqIHRvIHRoZSBzZXJ2ZXIuDQo+ICsgICAgICov
DQo+ICsgICAgew0KPiArICAgICAgICBOQkRSZXF1ZXN0IHJlcXVlc3QgPSB7IC50eXBlID0gTkJE
X0NNRF9ESVNDIH07DQo+ICsNCj4gKyAgICAgICAgbmJkX3NlbmRfcmVxdWVzdChjbGllbnQtPmlv
YyA/OiBRSU9fQ0hBTk5FTChzaW9jKSwgJnJlcXVlc3QpOw0KPiArICAgICAgICByZXR1cm4gcmV0
Ow0KPiArICAgIH0NCj4gICB9DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==
