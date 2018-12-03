Received: from eggs.gnu.org ([2001:4830:134:3::10]:54235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gTqL4-0006M4-Eq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gTqL0-0003YT-Bt
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:40:50 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 3 Dec 2018 15:40:38 +0000
Message-ID: <329096c2-1150-ea97-683c-fee403a0eede@virtuozzo.com>
References: <20181203151209.17331-1-mreitz@redhat.com>
In-Reply-To: <20181203151209.17331-1-mreitz@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C3418D12C9A1E4F8C0BC2EAEEB7872A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-3.1 v3] iotests: simple mirror test
 with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>

MDMuMTIuMjAxOCAxODoxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBGcm9tOiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IA0KPiBUaGlzIHRl
c3QgaXMgYnJva2VuIHdpdGhvdXQgcHJldmlvdXMgY29tbWl0IGZpeGluZyBkZWFkLWxvY2sgaW4g
bWlycm9yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHog
PG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gQmFzZWQtb246IDIwMTgxMTI5MTAxODAxLjY0
MjEtMi12c2VtZW50c292QHZpcnR1b3p6by5jb20NCj4gDQo+IFRoaXMgaXMgYSB2MyB0byB0aGUg
c2Vjb25kIHBhdGNoIG9mICJbUEFUQ0ggdjIgMC8yXSBtaXJyb3IgZGVhZC1sb2NrIiBieQ0KPiBW
bGFkaW1pci4gIEluc3RlYWQgb2YgbWlycm9yaW5nIGZyb20gYSBmdWxseSBhbGxvY2F0ZWQgaW1h
Z2UsIHRoaXMNCj4gdmVyc2lvbiBtaXJyb3JzIGZyb20gYSBwcmVhbGxvY2F0aW9uPW1ldGFkYXRh
IGltYWdlLCBhbmQgaXQgbWlycm9ycyBub3QNCj4gdG8gdGhlIHJlYWwgZGlzaywgYnV0IHRvIGEg
dGhyb3R0bGUvbnVsbC1jbyBjb21iaW5hdGlvbi4NCj4gDQo+IFRoZSBhZHZhbnRhZ2VzIGFyZSB0
aGF0IGl0IGlzIGFuIGluZGljYXRvciBvZiB0aGUgYnVnIGluZGVwZW5kZW50bHkgb2YNCj4gZGlz
ayBzcGVlZCAoVmxhZGltaXIncyB2ZXJzaW9uIGFsd2F5cyB3b3JrZWQgb24gdG1wZnMgZm9yIG1l
KSwgYW5kIHRoYXQNCj4gaXQgYWxsb2NhdGVzIGxlc3MgdGhhbiAxIE1CIG9mIHNwYWNlIGluIGNv
bnRyYXN0IHRvIDIgR0IuDQo+IA0KPiBUaGUgZGlzYWR2YW50YWdlIGlzIHRoYXQgaXQgaXMgbm90
IGEgcmVhbC1saWZlIHVzZSBjYXNlLiAgV2UgbWF5IHdhbnQgdG8NCj4gYWRkIFZsYWRpbWlyJ3Mg
dGVzdCwgdG9vLCBwcm9iYWJseSBpbiBhIHNwZWNpYWwgZ3JvdXAgdGhhdCBpcyBub3QNCj4gZXhl
Y3V0ZWQgYnkgZGVmYXVsdC4NCj4gDQo+IEFsc28sIHRoaXMgdmVyc2lvbiBmaXhlcyBjb21wYXRp
YmlsaXR5IHdpdGggcHl0aG9uMyAoYnkgdXNpbmcNCj4gaW90ZXN0cy5sb2coKSksIGFuZCBpdCBr
aWxscyB0aGUgVk0gZXZlbiBvbiBmYWlsdXJlIChieSBjYXRjaGluZyBhbmQNCj4gcmVyYWlzaW5n
IHRoZSBleGNlcHRpb24sIGFmdGVyIHRoZSBWTSBoYXMgYmVlbiBzaHV0IGRvd24pLg0KPiANCj4g
RmluYWxseSwgdGhlIHRlc3QgY2FuIHN0aWxsIGJlIGluIHRoZSBxdWljayBncm91cCwgYmVjYXVz
ZSBpdCB0dXJucyBvdXQNCj4gdGhhdCBicHMtdG90YWw9c2l6ZSBpcyBlbm91Z2ggdG8gbWFrZSBp
dCBmYWlsIGJlZm9yZSB0aGUgZml4IChzbyBpdCBydW5zDQo+IGluIDEgcyBpZiBpdCBwYXNzZXMp
Lg0KDQoNCndvcmtzIGZvciBtZSwgdGhhbmsgeW91IQ0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K
