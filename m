Received: from eggs.gnu.org ([2001:4830:134:3::10]:41019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7gng-000695-Gd
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7gna-00012U-FL
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 13:02:34 +0000
Message-ID: <af7783c7-10a0-f8da-11f7-801b5456bb9e@virtuozzo.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-4-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-4-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF5B8CD11C3A9746BEC047FD8A4D75C6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 3/6] block/dirty-bitmaps: allow clear on
 disabled bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

MDMuMTAuMjAxOCAwMjowMiwgSm9obiBTbm93IHdyb3RlOg0KPiBTaW1pbGFybHkgdG8gbWVyZ2Us
IGl0J3MgT0sgdG8gYWxsb3cgY2xlYXIgb3BlcmF0aW9ucyBvbiBkaXNhYmxlZA0KPiBiaXRtYXBz
LCBhcyB0aGlzIGNvbmRpdGlvbiBvbmx5IG1lYW5zIHRoYXQgdGhleSBhcmUgbm90IHJlY29yZGlu
Zw0KPiBuZXcgd3JpdGVzLiBXZSBhcmUgZnJlZSB0byBjbGVhciBpdCBpZiB0aGUgdXNlciByZXF1
ZXN0cyBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29t
Pg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIGJsb2NrL2RpcnR5LWJpdG1hcC5jIHwgMSAt
DQo+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgfCA4IC0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA5IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svZGlydHktYml0bWFw
LmMgYi9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPiBpbmRleCA4YTZlMDc5MzBmLi4wMzVmOTdlNWMy
IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPiArKysgYi9ibG9jay9kaXJ0
eS1iaXRtYXAuYw0KPiBAQCAtNjI1LDcgKzYyNSw2IEBAIHZvaWQgYmRydl9yZXNldF9kaXJ0eV9i
aXRtYXAoQmRydkRpcnR5Qml0bWFwICpiaXRtYXAsDQo+ICAgDQo+ICAgdm9pZCBiZHJ2X2NsZWFy
X2RpcnR5X2JpdG1hcChCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCwgSEJpdG1hcCAqKm91dCkNCj4g
ICB7DQo+IC0gICAgYXNzZXJ0KGJkcnZfZGlydHlfYml0bWFwX2VuYWJsZWQoYml0bWFwKSk7DQo+
ICAgICAgIGFzc2VydCghYmRydl9kaXJ0eV9iaXRtYXBfcmVhZG9ubHkoYml0bWFwKSk7DQo+ICAg
ICAgIGJkcnZfZGlydHlfYml0bWFwX2xvY2soYml0bWFwKTsNCj4gICAgICAgaWYgKCFvdXQpIHsN
Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+IGluZGV4IGQ3NzVmMjI4
ZmUuLmNjY2QzNmI1ZTcgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrZGV2LmMNCj4gKysrIGIvYmxvY2tk
ZXYuYw0KPiBAQCAtMjAxMiw5ICsyMDEyLDYgQEAgc3RhdGljIHZvaWQgYmxvY2tfZGlydHlfYml0
bWFwX2NsZWFyX3ByZXBhcmUoQmxrQWN0aW9uU3RhdGUgKmNvbW1vbiwNCj4gICAgICAgaWYgKGJk
cnZfZGlydHlfYml0bWFwX3VzZXJfbG9ja2VkKHN0YXRlLT5iaXRtYXApKSB7DQo+ICAgICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJDYW5ub3QgbW9kaWZ5IGEgYml0bWFwIGluIHVzZSBieSBhbm90
aGVyIG9wZXJhdGlvbiIpOw0KPiAgICAgICAgICAgcmV0dXJuOw0KPiAtICAgIH0gZWxzZSBpZiAo
IWJkcnZfZGlydHlfYml0bWFwX2VuYWJsZWQoc3RhdGUtPmJpdG1hcCkpIHsNCj4gLSAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiQ2Fubm90IGNsZWFyIGEgZGlzYWJsZWQgYml0bWFwIik7DQo+IC0g
ICAgICAgIHJldHVybjsNCj4gICAgICAgfSBlbHNlIGlmIChiZHJ2X2RpcnR5X2JpdG1hcF9yZWFk
b25seShzdGF0ZS0+Yml0bWFwKSkgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ2Fu
bm90IGNsZWFyIGEgcmVhZG9ubHkgYml0bWFwIik7DQo+ICAgICAgICAgICByZXR1cm47DQo+IEBA
IC0yOTE3LDExICsyOTE0LDYgQEAgdm9pZCBxbXBfYmxvY2tfZGlydHlfYml0bWFwX2NsZWFyKGNv
bnN0IGNoYXIgKm5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICJCaXRtYXAgJyVzJyBpcyBjdXJyZW50bHkgaW4gdXNlIGJ5IGFub3RoZXIgb3BlcmF0aW9uIg0K
PiAgICAgICAgICAgICAgICAgICAgICAiIGFuZCBjYW5ub3QgYmUgY2xlYXJlZCIsIG5hbWUpOw0K
PiAgICAgICAgICAgcmV0dXJuOw0KPiAtICAgIH0gZWxzZSBpZiAoIWJkcnZfZGlydHlfYml0bWFw
X2VuYWJsZWQoYml0bWFwKSkgew0KPiAtICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+IC0gICAg
ICAgICAgICAgICAgICAgIkJpdG1hcCAnJXMnIGlzIGN1cnJlbnRseSBkaXNhYmxlZCBhbmQgY2Fu
bm90IGJlIGNsZWFyZWQiLA0KPiAtICAgICAgICAgICAgICAgICAgIG5hbWUpOw0KPiAtICAgICAg
ICByZXR1cm47DQo+ICAgICAgIH0gZWxzZSBpZiAoYmRydl9kaXJ0eV9iaXRtYXBfcmVhZG9ubHko
Yml0bWFwKSkgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQml0bWFwICclcycgaXMg
cmVhZG9ubHkgYW5kIGNhbm5vdCBiZSBjbGVhcmVkIiwgbmFtZSk7DQo+ICAgICAgICAgICByZXR1
cm47DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0KDQo=
