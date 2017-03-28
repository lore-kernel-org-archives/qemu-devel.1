Received: from eggs.gnu.org ([2001:4830:134:3::10]:38076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cswIc-00040Y-Mv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cswIZ-0003WJ-LX
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:56:58 -0400
Received: from mail-bl2nam02on0125.outbound.protection.outlook.com
	([104.47.38.125]:52550
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1cswIZ-0003UE-G8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:56:55 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 28 Mar 2017 18:56:53 +0000
Message-ID: <DM2PR21MB0060647969F7193B509AE8AF9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
	<bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
	<fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
In-Reply-To: <fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9?] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

PiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1
ZXNkYXksIDI4IE1hcmNoIDIwMTcgMTE6NTINCj4gDQo+IE9uIDAzLzI4LzIwMTcgMDE6MzggUE0s
IFN0ZWZhbiBXZWlsIHdyb3RlOg0KPiA+IEFtIDI1LjAzLjIwMTcgdW0gMDA6MTkgc2NocmllYiBB
bmRyZXcgQmF1bWFubjoNCj4gPj4gbG9uZyBpcyAzMi1iaXRzIG9uIDY0LWJpdCB3aW5kb3dzLCB3
aGljaCBjYXVzZWQgdGhlIHRvcCBoYWxmIG9mIHRoZQ0KPiA+PiBhZGRyZXNzIHRvIGJlIHRydW5j
YXRlZDsgdGhpcyBwYXRjaCBjaGFuZ2VzIGl0IHRvIHVzZSB0aGUNCj4gPj4gUUVNVV9BTElHTl9V
UCBtYWNybyB3aGljaCBkb2VzIG5vdCBzdWZmZXIgdGhlIHNhbWUgcHJvYmxlbQ0KPiA+Pg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgQmF1bWFubiA8QW5kcmV3LkJhdW1hbm5AbWljcm9zb2Z0
LmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0K
PiA+PiAtLS0NCj4gDQo+ID4gRXJpYyBhZGRlZCAiZm9yLTIuOSIgdG8gdGhlIHN1YmplY3QgbGlu
ZSBvZiB2MiwgYnV0IG5vdyBpdCB3YXMNCj4gPiBtaXNzaW5nIGFnYWluIGZvciB2My4NCj4gPg0K
PiA+IElzIHRoaXMgbmVlZGVkIGZvciAyLjk/DQo+IA0KPiBZZXMsIGl0J3MgYSBjb3JyZWN0bmVz
cyBidWcgdGhhdCBhdm9pZHMgbWlzY29tcGlsYXRpb24gb24gNjQtYml0IHRhcmdldHMNCj4gd2hl
cmUgbG9uZyBpcyAzMiBiaXRzICh3aGljaCwgYXQgdGhlIG1vbWVudCwgaXMgcmVhbGx5IGp1c3Qg
V2luZG93cykuDQoNCkkgYWdyZWUsIHRoaXMgc2hvdWxkIGJlIGluIDIuOS4gSSBkcm9wcGVkIHRo
ZSB0YWcgYnkgYWNjaWRlbnQuDQoNCj4gPiBJIHdvbmRlciB3aHkgSSBuZXZlciBiZWZvcmUgbm90
aWNlZA0KPiA+IGEgcHJvYmxlbSBvciBnb3QgYSBidWcgcmVwb3J0IGZvciB0aGlzIGlzc3VlLg0K
PiANCj4gUHJvYmFibHkgYmVjYXVzZSBzbyBmZXcgcGVvcGxlIGFyZSB0ZXN0aW5nIG9uIG5hdGl2
ZSBXaW5kb3dzLCBhbmQgaXQNCj4gZG9lc24ndCBhZmZlY3Qgb3RoZXIgcGxhdGZvcm1zLg0KDQpJ
biBhZGRpdGlvbiB0byB0aGF0LCB5b3Ugb25seSBub3RpY2UgaXQgb24gdmlydGlvIGRldmljZXMg
bWFwcGVkIGFib3ZlIHRoZSAzMi1iaXQgbGltaXQuLi4NCg0KQW5kcmV3DQo=
