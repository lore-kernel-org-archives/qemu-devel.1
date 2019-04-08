Received: from eggs.gnu.org ([209.51.188.92]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDR1O-00086w-QD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDR1L-0005VP-VZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:56:58 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 8 Apr 2019 09:56:37 +0000
Message-ID: <d4593259-c3a8-8e84-cbbb-8caf02d6b9a7@virtuozzo.com>
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<28859adc-27c2-e2ed-3f24-ba620236970f@redhat.com>
In-Reply-To: <28859adc-27c2-e2ed-3f24-ba620236970f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <989E22637DC47246A2E806680027669E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qcow2: discard bitmap when
 removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

UElOR0lORw0KDQpJIGtpbmRseSByZW1pbmQgeW91IGFib3V0IHRoaXMgc21hbGwgcGF0Y2ggZm9y
IFFFTVUgNC4xLg0KSSBhbSBnb2luZyB0byBiZSBhd2F5IGZvciB2YWNhdGlvbiBmcm9tIEFwcmls
LCAxMHRoIHRvIE1heSwgMTV0aC4NCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5
IFNoaW5rZXZpY2gNCg0KDQpPbiAxOS8wMy8yMDE5IDAxOjE4LCBKb2huIFNub3cgd3JvdGU6DQo+
IA0KPiANCj4gT24gMi8yOC8xOSA0OjI2IEFNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+
IFdoZW4gYSBiaXRtYXAgaXMgcmVtb3ZlZCwgd2UgY2FuIGNsZWFuIHNvbWUgc3BhY2Ugb24gdGhl
IGRpc2suIFRoZSBzaXplDQo+PiBvZiBhIGNsdXN0ZXIgbWF5IGJlIGxhcmdlciwgc28gaXMgdGhl
IHNpemUgb2YgdGhlIGJpdG1hcCB0aGF0IGluY2x1ZGVzDQo+PiBtYW55IGNsdXN0ZXJzLiBTb21l
IGJpdG1hcHMgY2FuIGJlIGFzIGxhcmdlIGFzIHRlbnMgb2YgbWVnYWJ5dGVzLg0KPj4gVGhlIGZs
YWcgUUNPVzJfRElTQ0FSRF9BTFdBWVMgYWxsb3dzIGEgY2FsbCB0byB0aGUgcmF3X2NvX3BkaXNj
YXJkKCkNCj4+IHRoYXQgZG9lcyB0aGUgYWN0dWFsIGNsZWFuaW5nIG9mIHRoZSBpbWFnZSBvbiBk
aXNrLCB3aGlsZSB3aXRoIHRoZSBmbGFnDQo+PiBRQ09XMl9ESVNDQVJEX09USEVSLCBhIHJlZmVy
ZW5jZSBjb3VudCBvZiB0aGUgY2x1c3RlciBpcyB1cGRhdGVkIG9ubHkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5j
b20+DQo+PiAtLS0NCj4+IHYxOiBEaXNjYXJkIG9sZCBiaXRtYXAgZGlyZWN0b3JpZXMgaW4gUUNP
VzIgaW1hZ2UNCj4+DQo+PiBJbiB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGUgcGF0Y2gsIGFueSBj
YWxsIHRvIHFjb3cyX2ZyZWVfY2x1c3RlcnMoKSBpbg0KPj4gYmxvY2svcWNvdzItYml0bWFwLmMg
d2FzIHdpdGggdGhlIGZsYWcgUUNPVzJfRElTQ0FSRF9BTFdBWVMsIGV2ZW4gaW4gdGhlDQo+PiBj
YXNlcyB3aGVuIHRoZSBjbGVhbmVkIHNwYWNlIGlzIGluc2lnbmlmaWNhbnQsIHBhcnRpY3VsYXJs
eSwgaW4gY2FzZSBvZg0KPj4gYml0bWFwIGRpcmVjdG9yaWVzLg0KPj4gRGlzY3Vzc2VkIGluIHRo
ZSBlbWFpbCB0aHJlYWQgd2l0aCB0aGUgbWVzc2FnZSBJRA0KPj4gPDE1NDk5NzQ5NTEtNzMxMjg1
LTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+DQo+
PiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNv
dzItYml0bWFwLmMgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KPj4gaW5kZXggM2VlNTI0ZC4uMTYy
NzQ0ZSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+PiArKysgYi9ibG9j
ay9xY293Mi1iaXRtYXAuYw0KPj4gQEAgLTIwMiw3ICsyMDIsNyBAQCBzdGF0aWMgdm9pZCBjbGVh
cl9iaXRtYXBfdGFibGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90ICpiaXRtYXBfdGFi
bGUsDQo+PiAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gICAgICAgICAgIH0NCj4+ICAgDQo+
PiAtICAgICAgICBxY293Ml9mcmVlX2NsdXN0ZXJzKGJzLCBhZGRyLCBzLT5jbHVzdGVyX3NpemUs
IFFDT1cyX0RJU0NBUkRfT1RIRVIpOw0KPj4gKyAgICAgICAgcWNvdzJfZnJlZV9jbHVzdGVycyhi
cywgYWRkciwgcy0+Y2x1c3Rlcl9zaXplLCBRQ09XMl9ESVNDQVJEX0FMV0FZUyk7DQo+PiAgICAg
ICAgICAgYml0bWFwX3RhYmxlW2ldID0gMDsNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4gTG9v
a3MgbGlrZSA0LjEgbWF0ZXJpYWwgbm93LiBLZXZpbiBtYXkgaGF2ZSBiZWVuIGV4cGVjdGluZyBt
ZSB0byBlbmdhZ2UNCj4gd2l0aCB0aGlzLCBldmVuIHRob3VnaCBJIGRvIG5vdCBtYWludGFpbiB0
aGUgcWNvdzItYml0bWFwLmMgZmlsZS4gKEFuZA0KPiBJJ20gdmVyeSBiZWhpbmQgb24gcmVhZGlu
ZyBtYWlsIHRoYXQgd2FzIG5vdCBkaXJlY3RseSBhZGRyZXNzZWQgdG8gbWUsDQo+IHNvcnJ5Li4u
ISkNCj4gDQo+IFBsZWFzZSByZXNlbmQgd2hlbiB0aGUgNC4xIHdpbmRvdyBvcGVucyBhbmQgd2Un
bGwgYWRkcmVzcyB0aGlzIHRoZW4uDQo+IA0KPiAtLWpzDQo+IA0KDQo=
