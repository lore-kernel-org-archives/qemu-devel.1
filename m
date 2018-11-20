Received: from eggs.gnu.org ([2001:4830:134:3::10]:55430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gP7kv-0006ML-Co
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gP7kk-0004Fv-7s
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:15:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 20 Nov 2018 15:15:28 +0000
Message-ID: <4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
References: <20181116184324.8093-1-jsnow@redhat.com>
In-Reply-To: <20181116184324.8093-1-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C12B534B2C70B64093721F4821CC57D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence
 coverity CID 1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

MTYuMTEuMjAxOCAyMTo0MywgSm9obiBTbm93IHdyb3RlOg0KPiBDb3Zlcml0eSB3YXJucyB0aGF0
IGJhY2tpbmdfYnMoKSBjb3VsZCBnaXZlIHVzIGEgTlVMTCBwb2ludGVyLCB3aGljaA0KPiB3ZSB0
aGVuIHVzZSB3aXRob3V0IGNoZWNraW5nIHRoYXQgaXQgaXNuJ3QuDQo+IA0KPiBJbiBvdXIgbG9v
cCBjb25kaXRpb24sIHdlIGNoZWNrIGJzICYmIGJzLT5kcnYgYXMgYSBwb2ludCBvZiBoYWJpdCwg
YnV0DQo+IGJ5IG5hdHVyZSBvZiB0aGUgYmxvY2sgZ3JhcGgsIHdlIGNhbm5vdCBoYXZlIG51bGwg
YnMgcG9pbnRlcnMgaGVyZS4NCj4gDQo+IFRoaXMgbG9vcCBza2lwcyBvbmx5IGltcGxpY2l0IG5v
ZGVzLCB3aGljaCBhbHdheXMgaGF2ZSBjaGlsZHJlbiwgc28NCj4gdGhpcyBsb29wIHNob3VsZCBu
ZXZlciBlbmNvdW50ZXIgYSBudWxsIHZhbHVlLg0KDQpZb3UgbWVhbiwgYWx3YXlzIGhhdmUgYmFj
a2luZyAobm90IGZpbGUgZm9yIGV4Lik/IFNob3VsZCB3ZSBhdCBsZWFzdCBhZGQgYSBjb21tZW50
DQpuZWFyICJib29sIGltcGxpY2l0OyIgdGhhdCB0aGUgbm9kZSBtdXN0IGhhdmUgYmFja2luZy4u
DQoNCkRvIHdlIGhhdmUgZmlsdGVycywgdXNpbmcgJ2ZpbGUnIGNoaWxkIGluc3RlYWQgb2YgYmFj
a2luZywgd2lsbCB3ZSB3YW50IHRvIGF1dG8gaW5zZXJ0IHRoZW0sIGFuZCB0aGVyZWZvcmUgbWFy
ayB0aGVtIHdpdGggaW1wbGljaXQ9dHJ1ZT8NCg0KQW5kIG9uZSBtb3JlIHRoaW5nOg0KU28sIGl0
J3MgbG9va3MgbGlrZSBhIHdyb25nIHdheSB0byBzZWFyY2ggZm9yIGFsbCBibG9jay1ub2Rlcywg
aW5zdGVhZCBvZiBsb29waW5nIHRocm91Z2ggYmFja2luZyBjaGFpbiB0byB0aGUgZmlyc3Qgbm90
LWltcGxpY2l0IGJkcywgd2UgbXVzdCByZWN1cnNpdmVseSBleHBsb3JlIHRoZSB3aG9sZSBibG9j
ayBncmFwaCwgdG8gZmluZCBfYWxsXyB0aGUgYml0bWFwcy4NCg0KPiANCj4gVGlnaHRlbiB0aGUg
bG9vcCBjb25kaXRpb24gdG8gY29heCBDb3Zlcml0eSBpbnRvIGRyb3BwaW5nDQo+IGl0cyBmYWxz
ZSBwb3NpdGl2ZS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5j
b20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMgfCAyICst
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jIGIvbWlncmF0aW9u
L2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+IGluZGV4IDVlOTBmNDRjMmYuLjAwYzA2OGZkYTMgMTAw
NjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYw0KPiArKysgYi9taWdy
YXRpb24vYmxvY2stZGlydHktYml0bWFwLmMNCj4gQEAgLTI4NCw3ICsyODQsNyBAQCBzdGF0aWMg
aW50IGluaXRfZGlydHlfYml0bWFwX21pZ3JhdGlvbih2b2lkKQ0KPiAgICAgICAgICAgY29uc3Qg
Y2hhciAqZHJpdmVfbmFtZSA9IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUoYnMpOw0KPiAg
IA0KPiAgICAgICAgICAgLyogc2tpcCBhdXRvbWF0aWNhbGx5IGluc2VydGVkIG5vZGVzICovDQo+
IC0gICAgICAgIHdoaWxlIChicyAmJiBicy0+ZHJ2ICYmIGJzLT5pbXBsaWNpdCkgew0KPiArICAg
ICAgICB3aGlsZSAoYnMtPmRydiAmJiBicy0+aW1wbGljaXQpIHsNCj4gICAgICAgICAgICAgICBi
cyA9IGJhY2tpbmdfYnMoYnMpOw0KPiAgICAgICAgICAgfQ0KPiAgIA0KPiANCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
