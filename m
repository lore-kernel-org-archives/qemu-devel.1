Received: from eggs.gnu.org ([2001:4830:134:3::10]:51626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dXi8G-00013Q-Hm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dXi8B-0004pR-FY
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:06:48 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:48809)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dXi8A-0004oW-RP
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:06:43 -0400
Date: Wed, 19 Jul 2017 14:06:36 +0800 (CST)
Message-ID: <201707191406361857655@zte.com.cn>
References: 201707191017508680118@zte.com.cn,
	918c73df-fad9-ab4e-1ec9-3b45ef14aa2f@twiddle.net
Mime-Version: 1.0
From: <jiang.biao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_v2_00/45=5D_tcg=3A_support_for_m?=
 =?utf-8?q?ultipleTCGcontexts?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: shi.zhongbing@zte.com.cn, cota@braap.org, alex.bennee@linaro.org, qemu-devel@nongnu.org, jiang.yong5@zte.com.cn

PiBGb3IgdGhpcyBzcGVjaWZpYyBjYXNlLCB0aGUgcHJpbWFyeSBwcm9ibGVtIHdpbGwgYmUgdGhl
IGltcGxpY2l0IG1lbW9yeSANCj4gYmFycmllcnMgdGhhdCB0aGUgaTM4NiBndWVzdCByZXF1aXJl
cywgYnV0IHRoYXQgdGhlIG1pcHM2NCBob3N0IGRvZXMgbm90IHByb3ZpZGUuDQo+IA0KPiBGb3Ig
dGNnL21pcHMvLCBUQ0dfVEFSR0VUX0RFRkFVTFRfTU8gc2hvdWxkIGJlIDAsIGJlY2F1c2UgdGhl
IG1pcHMgYXJjaGl0ZWN0dXJlIA0KPiBkb2VzIG5vdCBoYXZlIGFueSBpbXBsaWNpdCBtZW1vcnkg
b3JkZXJpbmcuICBBbGwgbWVtb3J5IGJhcnJpZXJzIGFyZSBleHBsaWNpdCANCj4gdmlhIFNZTkMg
aW5zdHJ1Y3Rpb25zLg0KPiANCj4gRm9yIHRhcmdldC9pMzg2LCBUQ0dfR1VFU1RfREVGQVVMVF9N
TyBpcyBUQ0dfTU9fQUxMICYgflRDR19NT19TVF9MRCwgb3INCj4gDQo+ICAgICBUQ0dfTU9fTERf
TEQgfCBUQ0dfTU9fTERfU1QgfCBUQ0dfTU9fU1RfU1QNCj4gDQo+IHdoaWNoIG1lYW5zIHRoYXQg
aW1wbGljaXQgbWVtb3J5IGJhcnJpZXJzIGV4aXN0IGJldHdlZW4gbG9hZC9sb2FkLCBsb2FkL3N0
b3JlLCANCj4gc3RvcmUvc3RvcmUsIGJ1dCBub3Qgc3RvcmUvbG9hZC4NCj4gDQo+IEluIG9yZGVy
IHRvIGZpeCB0aGlzLCB3ZSBuZWVkIHRvIGFkZCB0aGUgbWlzc2luZyBiYXJyaWVycyB0byB0aGUg
b3Bjb2RlIHN0cmVhbS4NCj4gDQo+IFRoZSBzaW1wbGVzdCBmaXggZm9yIHRoaXMgaXMgdG8gcHV0
IGEgY2FsbA0KPiANCj4gICAgIHRjZ19nZW5fbWIoVENHX01PX0FMTCB8IFRDR19CQVJfU0MpDQo+
IA0KPiBhdCB0aGUgZW5kIG9mIGdlbl9sZHN0X2kzMiBhbmQgZ2VuX2xkc3RfaTY0LiAgVGhhdCBz
aG91bGQgYmUgZ29vZCBlbm91Z2ggdG8gDQo+IG1ha2UgeW91ciBzcGVjaWZpYyBjYXNlIG9wZXJh
dGUgY29ycmVjdGx5Lg0KPiANCj4gQSBwcm9wZXIgZml4IHdpbGwgaW52b2x2ZSAoMSkgZW1pdHRp
bmcgdGhvc2UgYmFycmllcnMgb25seSBpZiB0aGUgYmFycmllciBpcyANCj4gbm90IGltcGxpZWQg
YnkgdGhlIGhvc3QgYW5kICgyKSBvcHRpbWl6aW5nIGF3YXkgcmVkdW5kYW50IGJhcnJpZXJzLg0K
PiANClRoYW5rcyB2ZXJ5IG11Y2guIFRoYXQgcmVhbGx5IGhlbHBzIGEgbG90Lg0KDQpJJ2xsIGRp
ZyBkZWVwZXIgaW50byB0aGF0IGFuZCBtYXliZSBmZWVkYmFjayBzb21lIHBhdGNoZXMu
