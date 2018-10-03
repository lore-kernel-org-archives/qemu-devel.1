Received: from eggs.gnu.org ([2001:4830:134:3::10]:40330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7gmH-0004tq-04
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7gmD-00009H-7M
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 13:01:11 +0000
Message-ID: <f3511727-2da9-b527-bea2-56358a540f17@virtuozzo.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-3-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-3-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D93866B9F6F1E43A4622E4E066FA93B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/6] block/dirty-bitmaps: fix merge
 permissions
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

MDMuMTAuMjAxOCAwMjowMiwgSm9obiBTbm93IHdyb3RlOg0KPiBJbiBwcmlvciBjb21taXRzIHRo
YXQgbWFkZSBtZXJnZSB0cmFuc2FjdGlvbmFibGUsIHdlIHJlbW92ZWQgdGhlDQo+IGFzc2VydGlv
biB0aGF0IG1lcmdlIGNhbm5vdCBvcGVyYXRlIG9uIGRpc2FibGVkIGJpdG1hcHMuIEluIGFkZGl0
aW9uLA0KPiB3ZSB3YW50IHRvIG1ha2Ugc3VyZSB0aGF0IHdlIGFyZSBwcm9oaWJpdGluZyBtZXJn
ZXMgdG8gImxvY2tlZCIgYml0bWFwcy4NCj4NCj4gVXNlIHRoZSBuZXcgdXNlcl9sb2NrZWQgZnVu
Y3Rpb24gdG8gY2hlY2suDQo+DQo+IFJlcG9ydGVkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVk
aGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0K
DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2
aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIGJsb2NrL2RpcnR5LWJpdG1hcC5jIHwgNiArKyst
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svZGlydHktYml0bWFwLmMgYi9ibG9jay9kaXJ0eS1iaXRt
YXAuYw0KPiBpbmRleCA4NWJjNjY4ZjZhLi44YTZlMDc5MzBmIDEwMDY0NA0KPiAtLS0gYS9ibG9j
ay9kaXJ0eS1iaXRtYXAuYw0KPiArKysgYi9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPiBAQCAtODA2
LDkgKzgwNiw5IEBAIHZvaWQgYmRydl9tZXJnZV9kaXJ0eV9iaXRtYXAoQmRydkRpcnR5Qml0bWFw
ICpkZXN0LCBjb25zdCBCZHJ2RGlydHlCaXRtYXAgKnNyYywNCj4gICANCj4gICAgICAgcWVtdV9t
dXRleF9sb2NrKGRlc3QtPm11dGV4KTsNCj4gICANCj4gLSAgICBpZiAoYmRydl9kaXJ0eV9iaXRt
YXBfZnJvemVuKGRlc3QpKSB7DQo+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgIkJpdG1hcCAn
JXMnIGlzIGZyb3plbiBhbmQgY2Fubm90IGJlIG1vZGlmaWVkIiwNCj4gLSAgICAgICAgICAgICAg
ICAgICBkZXN0LT5uYW1lKTsNCj4gKyAgICBpZiAoYmRydl9kaXJ0eV9iaXRtYXBfdXNlcl9sb2Nr
ZWQoZGVzdCkpIHsNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQml0bWFwICclcycgaXMg
Y3VycmVudGx5IGluIHVzZSBieSBhbm90aGVyIg0KPiArICAgICAgICAiIG9wZXJhdGlvbiBhbmQg
Y2Fubm90IGJlIG1vZGlmaWVkIiwgZGVzdC0+bmFtZSk7DQo+ICAgICAgICAgICBnb3RvIG91dDsN
Cj4gICAgICAgfQ0KPiAgIA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg0K
