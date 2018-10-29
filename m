Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gH4V1-0008Gz-Rc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gH4Uy-00017O-Me
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:10:19 -0400
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com
	([104.47.33.111]:27074
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gH4Uy-0000nA-D7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:10:16 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Mon, 29 Oct 2018 10:09:55 +0000
Message-ID: <ae0a75e1-4e9e-2ddc-c492-69d4a95b6d9c@wavecomp.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540383527-7923-5-git-send-email-aleksandar.markovic@rt-rk.com>
	<51e7458e-935f-5775-af64-0908b2110ed7@wavecomp.com>
	<BN6PR2201MB12514D71C5469F4080A1C123C6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251F15F9A76D3183A2ACBEAC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251F15F9A76D3183A2ACBEAC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC2085ED375582409C86D7C1308636C8@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 04/20] target/mips: Add and integrate
 MXU decoding engine placeholder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

SW4gdGhhdCBjYXNlLCBJIGd1ZXNzIHRoaXMgc2hvdWxkIGJlIE9LIGZvciBub3csIGFzIE1YVSBz
dXBwb3J0IGlzIA0KaW5pdGlhdGVkIGJ5IENyYWlnIGFuZCB0aGlzIHdpbGwgYmUNCg0KYW4gZWFz
eSBhZGQtb24gd2hlbiBoZSBwcm92aWRlIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbi4NCg0KDQpSZXZp
ZXdlZC1ieTogU3RlZmFuIE1hcmtvdmljIDxzbWFya292aWNAd2F2ZWNvbXAuY29tPg0KDQoNCk9u
IDI4LjEwLjE4LiAxOTozOSwgQWxla3NhbmRhciBNYXJrb3ZpYyB3cm90ZToNCj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjcgMDQvMjBdIHRhcmdldC9taXBzOiBBZGQgYW5kIGludGVncmF0ZSBNWFUg
ZGVjb2RpbmcgZW5naW5lID4gcGxhY2Vob2xkZXINCj4+DQo+Pj4gSXMgdGhlIGJlc3Qgd2F5IHRv
IGltcGxlbWVudCB0aGlzIHRvIGluY2x1ZGUgcHJvY2Vzc2luZyBvZiBNVUwsIENMWiwNCj4+PiBD
TE8sIFNEQkJQIGluc3RydWN0aW9ucyBpbnRvIGRlY29kZV9vcGNfbXh1IGFzIHRoZWlyIGVuY29k
aW5ncyBhcmVuJ3QNCj4+PiBvdmVybGFpZCBieSBNWFUgaW5zdHJ1Y3Rpb25zIGNvbnNpZGVyaW5n
IE1JUFMgU1BFQ0lBTDIgaW5zdHJ1Y3Rpb24NCj4+PiBwb29sIGFuZCBNWFUgSW5zdHJ1Y3Rpb24g
U2V0Pw0KPj4gVGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBkb24ndCBoYXZlIHRoZSBkb2N1bWVudGF0
aW9uIGZvciBJbmdlbmljJ3MgYmFzZQ0KPj4gaW5zdHJ1Y3Rpb24gc2V0LiBNeSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgQ3JhaWcgZXN0YWJsaXNoZWQgbmVjZXNzaXR5IG9mDQo+PiBpbmNsdWRpbmcg
bm9uLU1YVSBNVUwgaW50byBkZWNvZGVfb3BjX214dSgpIGJ5IGV4cGVyaW1lbnRhdGlvbiwNCj4+
IG9yIGJ5IGxvb2tpbmcgYXQgSW5nZW5pYydzIHRvb2xjaGFpbiBzb3VyY2UgY29kZS4NCj4+DQo+
PiBOb3RlIHRoYXQgQ0xaLCBDTE8sIFNEQkJQIGFyZSBtb3ZlZCBmcm9tIFNQRUNJQUwyIHRvIGFu
b3RoZXINCj4+IHBsYWNlIGluIG9wY29kZSBzcGFjZSBpbiBNSVBTIFI2Lg0KPj4NCj4+IENyYWln
LCBjYW4geW91IG9mZmVyIGFueSBpbnNpZ2h0IG9uIENMWiwgQ0xPLCBTREJCUCBpbiBJbmdlbmlj
J3MgYmFzZQ0KPj4gaW5zdHJ1Y3Rpb24gc2V0PyBUaGV5IGFyZSBpbiBTUEVDSUFMMiBvcGNvZGUg
c3BhY2UgZm9yIE1JUFMgcHJlLVI2Lg0KPj4NCj4+IFdvcnNlIGNvbWUgdG8gd29yc3QsIEkgcmVj
b21tZW5kIGFkZGluZyAiVE9ETyIgY29tbWVudCB0byBhbg0KPj4gYXBwcm9wcmlhdGUgcGxhY2Ug
aW4gZGVjb2RlX29wY19teHUoKSwgYW5kIGdvIGZvcndhcmQgd2l0aG91dCBoYW5kbGluZw0KPj4g
Q0xaLCBDTE8sIFNEQkJQIC0gZ2l2ZW4gdGhhdCBhbGwgY2hhbmdlcyBpbiB0aGlzIHNlcmllcyBh
cmUganVzdCB0aGUgZmlyc3QNCj4+IHBoYXNlIG9mIGltcGxlbWVudGluZyBNWFUgc3VwcG9ydCAt
IHRoZXkgd29uJ3QgYWZmZWN0IGFueSBwcm9kdWN0aW9uDQo+PiBjb2RlIGF0IHRoaXMgbW9tZW50
Lg0KPj4NCj4gSSB0aGluayB0aGlzIGNvbW1lbnQgc2hvdWxkIGJlIGFkZGVkIHRvIHRoZSBkZWNv
ZGVfb3BjX214dSgpLCB3aXRoaW4gcGF0Y2ggMTE6DQo+DQo+ICAgICAgLyoNCj4gICAgICAgKiBU
T0RPOiBJbnZlc3RpZ2F0ZSBuZWNlc3NpdHkgb2YgaW5jbHVkaW5nIGhhbmRsaW5nIG9mDQo+ICAg
ICAgICogQ0xaLCBDTE8sIFNEQkIgaW4gdGhpcyBmdW5jdGlvbiwgYXMgdGhleSBiZWxvbmcgdG8N
Cj4gICAgICAgKiBTUEVDSUFMMiBvcGNvZGUgc3BhY2UgZm9yIHJlZ3VsYXIgcHJlLVI2IE1JUFMg
SVNBcy4NCj4gICAgICAgKi8NCj4NCj4gVGhhbmtzLA0KPiBBbGVrc2FuZGFyDQo=
