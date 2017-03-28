Received: from eggs.gnu.org ([2001:4830:134:3::10]:37780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cswH7-0003R6-El
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cswH4-00027e-Cs
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:55:25 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com
	([104.47.34.98]:39744
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1cswH3-000275-UT
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:55:22 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 28 Mar 2017 18:55:19 +0000
Message-ID: <DM2PR21MB0060C4ECE3B5CEF456AE03AB9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
	<5b6dc1d9-996a-66fe-7142-2c9be4670540@weilnetz.de>
In-Reply-To: <5b6dc1d9-996a-66fe-7142-2c9be4670540@weilnetz.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for 2.9?] tap-win32: don't abort in
 tap_enable(); enables -netdev tap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>

PiBGcm9tOiBTdGVmYW4gV2VpbCBbbWFpbHRvOnN3QHdlaWxuZXR6LmRlXQ0KPiBTZW50OiBUdWVz
ZGF5LCAyOCBNYXJjaCAyMDE3IDExOjI4DQoNCj4gQW0gMjUuMDMuMjAxNyB1bSAwMDo0NiBzY2hy
aWViIEFuZHJldyBCYXVtYW5uOg0KPiA+IFRoZSBkb2NzIGdlbmVyYWxseSBzdGVlciB1c2VycyBh
d2F5IGZyb20gdXNpbmcgdGhlIGxlZ2FjeSAtbmV0DQo+ID4gcGFyYW1ldGVyLCBob3dldmVyIG9u
IHdpbjMyIGF0dGVtcHRpbmcgdG8gZW5hYmxlIGEgdGFwIGRldmljZSB1c2luZw0KPiA+IC1uZXRk
ZXYgdGFwIGZhaWxzIGF0IGFuIGFib3J0KCkgaW4gdGFwX2VuYWJsZSgpLiBSZW1vdmluZyB0aGUg
YWJvcnQoKXMNCj4gPiBzZWVtcyB0byBiZSBlbm91Z2ggdG8gZ2V0IGV2ZXJ5dGhpbmcgd29ya2lu
Zywgc28gZG8gdGhhdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBCYXVtYW5uIDxB
bmRyZXcuQmF1bWFubkBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQvdGFwLXdpbjMy
LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9uZXQvdGFwLXdpbjMyLmMgYi9uZXQvdGFw
LXdpbjMyLmMNCj4gPiBpbmRleCA2NjJmOWI2Li4zNjIwODQzIDEwMDY0NA0KPiA+IC0tLSBhL25l
dC90YXAtd2luMzIuYw0KPiA+ICsrKyBiL25ldC90YXAtd2luMzIuYw0KPiA+IEBAIC04MTEsMTAg
KzgxMSwxMCBAQCBpbnQgbmV0X2luaXRfdGFwKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBj
aGFyDQo+ICpuYW1lLA0KPiA+DQo+ID4gIGludCB0YXBfZW5hYmxlKE5ldENsaWVudFN0YXRlICpu
YykNCj4gPiAgew0KPiA+IC0gICAgYWJvcnQoKTsNCj4gPiArICAgIHJldHVybiAwOw0KPiA+ICB9
DQo+ID4NCj4gPiAgaW50IHRhcF9kaXNhYmxlKE5ldENsaWVudFN0YXRlICpuYykNCj4gPiAgew0K
PiA+IC0gICAgYWJvcnQoKTsNCj4gPiArICAgIHJldHVybiAwOw0KPiA+ICB9DQo+IA0KPiBBcyBJ
IG5ldmVyIHdvcmtlZCB3aXRoIFRBUCBvbiBXaW5kb3dzLCBJIGNhbm5vdCBzYXkgbXVjaCB0byB0
aGlzIGZpeC4NCj4gDQo+IEphc29uLCB3aGF0IGlzIHRoZSB1c2Ugb2YgdGFwX2VuYWJsZSwgdGFw
X2Rpc2FibGU/IElzIGl0IGZpbmUNCj4gdG8gc2ltcGx5IGRvIG5vdGhpbmcgb24gV2luZG93cyBo
ZXJlPw0KDQpJIHdhcyBhbHNvIGhvcGluZyBmb3IgYSByZXZpZXcgLS0gSSdtIG5vIGV4cGVydCBv
biB0aGlzIHN0dWZmIGVpdGhlciwgYnV0IG15IHF1aWNrIHJlYWRpbmcgb2YgdGhvc2UgY29kZSBw
YXRocyBpcyB0aGF0IHRoZXkgaXNzdWUgaW9jdGxzIHRvIGVuYWJsZS9kaXNhYmxlIHBhY2tldCBy
ZWNlcHRpb24gb24gdGhlIHVuZGVybHlpbmcgdGFwIGRldmljZS4gQXMgd2luMzIgVEFQIGlzIGlt
cGxlbWVudGVkLCB0aGF0IGlzIGFscmVhZHkgZW5hYmxlZCBmcm9tIHN0YXJ0IG9mIGRheS4NCg0K
SXQncyBwb3NzaWJsZSB0aGlzIHBhdGNoIHN0aWxsIGRvZXMgbm90IHBlcm1pdCBkeW5hbWljIHJl
Y29uZmlndXJhdGlvbiBvZiB0YXAgZGV2aWNlcyAoZS5nLiBmcm9tIHRoZSBtb25pdG9yIGNvbnNv
bGUpLiBIb3dldmVyLCBpdCBkb2VzIHdvcmsgd2l0aCB0aGUgLW5ldGRldiB0YXAgb3B0aW9uIG9u
IHRoZSBjb21tYW5kLWxpbmUuDQoNCj4gQW5kIGlzIHRoaXMgc29tZXRoaW5nIGZvciBRRU1V4oCM
IDIuOSAoSSBhZGRlZCBxdWVzdGlvbiB0byBzdWJqZWN0IGxpbmUpPw0KDQpJZGVhbGx5LCB5ZXMu
IElmIG5vdCwgLW5ldGRldiB0YXAgd2lsbCBjb250aW51ZSB0byBibG93IHVwIGluIHRoZSBhYm9y
dCBhcyBpdCBkb2VzIHRvZGF5Li4uDQoNCkFuZHJldw0K
