Received: from eggs.gnu.org ([2001:4830:134:3::10]:43620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1ct4zh-0007C0-Un
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1ct4zc-0004hT-V2
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:14:01 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com
	([104.47.34.90]:63618
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1ct4zc-0004go-GA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:13:56 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Wed, 29 Mar 2017 04:13:53 +0000
Message-ID: <DM2PR21MB0060292DE51C857400F27CA49E350@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
	<5b6dc1d9-996a-66fe-7142-2c9be4670540@weilnetz.de>
	<DM2PR21MB0060C4ECE3B5CEF456AE03AB9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
	<2695069b-5704-536d-33e3-66e8d014475c@redhat.com>
In-Reply-To: <2695069b-5704-536d-33e3-66e8d014475c@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
VHVlc2RheSwgMjggTWFyY2ggMjAxNyAxOTozOQ0KPiANCj4gT24gMjAxN+W5tDAz5pyIMjnml6Ug
MDI6NTUsIEFuZHJldyBCYXVtYW5uIHdyb3RlOg0KPiA+PiBGcm9tOiBTdGVmYW4gV2VpbCBbbWFp
bHRvOnN3QHdlaWxuZXR6LmRlXQ0KPiA+PiBTZW50OiBUdWVzZGF5LCAyOCBNYXJjaCAyMDE3IDEx
OjI4DQo+ID4+IEFtIDI1LjAzLjIwMTcgdW0gMDA6NDYgc2NocmllYiBBbmRyZXcgQmF1bWFubjoN
Cj4gPj4+IFRoZSBkb2NzIGdlbmVyYWxseSBzdGVlciB1c2VycyBhd2F5IGZyb20gdXNpbmcgdGhl
IGxlZ2FjeSAtbmV0DQo+ID4+PiBwYXJhbWV0ZXIsIGhvd2V2ZXIgb24gd2luMzIgYXR0ZW1wdGlu
ZyB0byBlbmFibGUgYSB0YXAgZGV2aWNlIHVzaW5nDQo+ID4+PiAtbmV0ZGV2IHRhcCBmYWlscyBh
dCBhbiBhYm9ydCgpIGluIHRhcF9lbmFibGUoKS4gUmVtb3ZpbmcgdGhlIGFib3J0KClzDQo+ID4+
PiBzZWVtcyB0byBiZSBlbm91Z2ggdG8gZ2V0IGV2ZXJ5dGhpbmcgd29ya2luZywgc28gZG8gdGhh
dC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgQmF1bWFubiA8QW5kcmV3LkJh
dW1hbm5AbWljcm9zb2Z0LmNvbT4NClsuLi5dDQo+ID4+IEphc29uLCB3aGF0IGlzIHRoZSB1c2Ug
b2YgdGFwX2VuYWJsZSwgdGFwX2Rpc2FibGU/DQo+IA0KPiBJdCBzaG91bGQgYmUgb25seSB1c2Vk
IHdoZW4gd2Ugd2FudCB0byBlbmFibGUgYW5kIGRpc2FibGUgYSBzcGVjaWZpYw0KPiBxdWV1ZSBv
ZiBhIG11bHRpcXVldWUgc3VwcG9ydGVkIHRhcC4NCj4gDQo+ID4+ICAgSXMgaXQgZmluZQ0KPiA+
PiB0byBzaW1wbHkgZG8gbm90aGluZyBvbiBXaW5kb3dzIGhlcmU/DQo+IA0KPiBVbmxlc3Mgd2lu
ZG93cyBzdXBwb3J0IG11bHRpcXVldWUgdGFwLCB3ZSBzaG91bGQga2VlcCB0aGUgYXNzZXJ0IGhl
cmUuDQo+IA0KPiA+IEkgd2FzIGFsc28gaG9waW5nIGZvciBhIHJldmlldyAtLSBJJ20gbm8gZXhw
ZXJ0IG9uIHRoaXMgc3R1ZmYgZWl0aGVyLCBidXQgbXkNCj4gcXVpY2sgcmVhZGluZyBvZiB0aG9z
ZSBjb2RlIHBhdGhzIGlzIHRoYXQgdGhleSBpc3N1ZSBpb2N0bHMgdG8gZW5hYmxlL2Rpc2FibGUN
Cj4gcGFja2V0IHJlY2VwdGlvbiBvbiB0aGUgdW5kZXJseWluZyB0YXAgZGV2aWNlLiBBcyB3aW4z
MiBUQVAgaXMgaW1wbGVtZW50ZWQsDQo+IHRoYXQgaXMgYWxyZWFkeSBlbmFibGVkIGZyb20gc3Rh
cnQgb2YgZGF5Lg0KPiA+DQo+ID4gSXQncyBwb3NzaWJsZSB0aGlzIHBhdGNoIHN0aWxsIGRvZXMg
bm90IHBlcm1pdCBkeW5hbWljIHJlY29uZmlndXJhdGlvbiBvZiB0YXANCj4gZGV2aWNlcyAoZS5n
LiBmcm9tIHRoZSBtb25pdG9yIGNvbnNvbGUpLiBIb3dldmVyLCBpdCBkb2VzIHdvcmsgd2l0aCB0
aGUgLQ0KPiBuZXRkZXYgdGFwIG9wdGlvbiBvbiB0aGUgY29tbWFuZC1saW5lLg0KPiA+DQo+ID4+
IEFuZCBpcyB0aGlzIHNvbWV0aGluZyBmb3IgUUVNVeKAjCAyLjkgKEkgYWRkZWQgcXVlc3Rpb24g
dG8gc3ViamVjdCBsaW5lKT8NCj4gPiBJZGVhbGx5LCB5ZXMuIElmIG5vdCwgLW5ldGRldiB0YXAg
d2lsbCBjb250aW51ZSB0byBibG93IHVwIGluIHRoZSBhYm9ydCBhcyBpdCBkb2VzDQo+IHRvZGF5
Li4uDQo+ID4NCj4gPiBBbmRyZXcNCj4gDQo+IFllcywgc28gdGhlIHByb2JsZW0gaXMgd2Ugc2hv
dWxkIHByZXZlbnQgdGFwX2VuYWJsZSgpIGFuZCB0YXBfZGlzYWJsZSgpDQo+IGZyb20gYmVpbmcg
Y2FsbGVkIGlmIG11bHRpcXVldWUgaXMgZGlzYWJsZWQuDQo+IA0KPiBJIGJlbGlldmUgdGhlIGZv
bGxvd2luZyBwYXRjaCBjYW4gZml4IHRoaXMgaXNzdWUsIGNvdWxkIHlvdSBnaXZlIGEgdHJ5DQo+
IG9uIHRoaXM/DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3ZpcnRpby1uZXQuYyBiL2h3L25l
dC92aXJ0aW8tbmV0LmMNCj4gaW5kZXggYzMyMTY4MC4uN2QwOTFjOSAxMDA2NDQNCj4gLS0tIGEv
aHcvbmV0L3ZpcnRpby1uZXQuYw0KPiArKysgYi9ody9uZXQvdmlydGlvLW5ldC5jDQo+IEBAIC01
MTAsNiArNTEwLDEwIEBAIHN0YXRpYyBpbnQgcGVlcl9hdHRhY2goVmlydElPTmV0ICpuLCBpbnQg
aW5kZXgpDQo+ICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgfQ0KPiANCj4gKyAgICBpZiAo
bi0+bWF4X3F1ZXVlcyA9PSAxKSB7DQo+ICsgICAgICAgIHJldHVybiAwOw0KPiArICAgIH0NCj4g
Kw0KPiAgICAgICByZXR1cm4gdGFwX2VuYWJsZShuYy0+cGVlcik7DQo+ICAgfQ0KPiANCg0KWWVw
LCB0aGlzIHdvcmtzLiBUaGFua3MhDQoNCkFuZHJldw0K
