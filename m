Received: from eggs.gnu.org ([2001:4830:134:3::10]:38160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUxaV-00009W-Rj
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUxaS-0007W7-23
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:37:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 6 Dec 2018 17:36:29 +0000
Message-ID: <5dc82f08-5651-1000-007d-c2bbecf61ade@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-3-vsementsov@virtuozzo.com>
	<20181206103603.GK29540@redhat.com>
In-Reply-To: <20181206103603.GK29540@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A32E1030583B4CB31619B303933DFF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/5] crypto/block: refactor
 qcrypto_block_*crypt_helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDYuMTIuMjAxOCAxMzozNiwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gV2VkLCBE
ZWMgMDUsIDIwMTggYXQgMDU6NDY6NTdQTSArMDMwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSB3cm90ZToNCj4+IHFjcnlwdG9fYmxvY2tfZW5jcnlwdF9oZWxwZXIgYW5kIHFjcnlwdG9f
YmxvY2tfZGVjcnlwdF9oZWxwZXIgYXJlDQo+PiBhbG1vc3QgaWRlbnRpY2FsLCBsZXQncyByZWR1
Y2UgY29kZSBkdXBsaWNhdGlvbiBhbmQgc2ltcGxpZnkgZnVydGhlcg0KPj4gaW1wcm92ZW1lbnRz
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBjcnlwdG8vYmxvY2suYyB8IDgx
ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2Jsb2NrLmMgYi9jcnlwdG8vYmxvY2suYw0KPj4gaW5kZXgg
ZTU5ZDExNDBmZS4uZjQxMDFmMDg0MSAxMDA2NDQNCj4+IC0tLSBhL2NyeXB0by9ibG9jay5jDQo+
PiArKysgYi9jcnlwdG8vYmxvY2suYw0KPj4gQEAgLTE5MCwxNCArMTkwLDIxIEBAIHZvaWQgcWNy
eXB0b19ibG9ja19mcmVlKFFDcnlwdG9CbG9jayAqYmxvY2spDQo+PiAgIH0NCj4+ICAgDQo+PiAg
IA0KPj4gLWludCBxY3J5cHRvX2Jsb2NrX2RlY3J5cHRfaGVscGVyKFFDcnlwdG9DaXBoZXIgKmNp
cGhlciwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3Qgbml2LA0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFDcnlwdG9JVkdlbiAqaXZnZW4s
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHNlY3RvcnNpemUsDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgb2Zmc2V0LA0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ4X3QgKmJ1ZiwNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgbGVuLA0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt0eXBlZGVmIGludCAoKlFD
cnlwdG9DaXBoZXJFbmNyeXB0RnVuYykoUUNyeXB0b0NpcGhlciAqY2lwaGVyLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICppbiwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3V0LA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgbGVuLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4g
Kw0KPj4gK3N0YXRpYyBpbnQgZG9fcWNyeXB0b19ibG9ja19lbmNyeXB0KFFDcnlwdG9DaXBoZXIg
KmNpcGhlciwNCj4gDQo+IENhbiB3ZSBjYWxsIHRoaXMgZnVuY3R1b24gJ2VuY2RlYycsIHNpbmNl
IGl0IGlzIG1pc2xlYWRpbmcgdG8gY2FsbA0KPiBpdCBqdXN0ICdlbmNyeXB0JyB3aGVuIGl0cyB1
c2VkIGZvciBkZWNyeXB0IHRvby4NCg0KTWF5YmUganVzdCBfY3J5cHQgPykNCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
