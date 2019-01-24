Received: from eggs.gnu.org ([209.51.188.92]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmgAx-0005XT-IX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmgAw-0007Il-Bb
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:40:15 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 14:40:10 +0000
Message-ID: <f3b34487-5c86-287e-00b5-331adf9ac931@virtuozzo.com>
References: <20190124141731.21509-1-kwolf@redhat.com>
In-Reply-To: <20190124141731.21509-1-kwolf@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F925FDCC4972ED4BB634BB552CAC6D83@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

MjQuMDEuMjAxOSAxNzoxNywgS2V2aW4gV29sZiB3cm90ZToNCj4gRGVwZW5kaW5nIG9uIHRoZSBl
eGFjdCBpbWFnZSBsYXlvdXQgYW5kIHRoZSBzdG9yYWdlIGJhY2tlbmQgKHRtcGZzIGlzDQo+IGtv
bnduIHRvIGhhdmUgdmVyeSBzbG93IFNFRUtfSE9MRS9TRUVLX0RBVEEpLCBjYWNoaW5nIGxzZWVr
IHJlc3VsdHMgY2FuDQo+IHNhdmUgdXMgYSBsb3Qgb2YgdGltZSBlLmcuIGR1cmluZyBhIG1pcnJv
ciBibG9jayBqb2Igb3IgcWVtdS1pbWcgY29udmVydA0KPiB3aXRoIGEgZnJhZ21lbnRlZCBzb3Vy
Y2UgaW1hZ2UgKC5iZHJ2X2NvX2Jsb2NrX3N0YXR1cyBvbiB0aGUgcHJvdG9jb2wNCj4gbGF5ZXIg
Y2FuIGJlIGNhbGxlZCBmb3IgZXZlcnkgc2luZ2xlIGNsdXN0ZXIgaW4gdGhlIGV4dHJlbWUgY2Fz
ZSkuDQo+IA0KPiBXZSBtYXkgb25seSBjYWNoZSBkYXRhIHJlZ2lvbnMgYmVjYXVzZSBvZiBwb3Nz
aWJsZSBjb25jdXJyZW50IHdyaXRlcnMuDQo+IFRoaXMgbWVhbnMgdGhhdCB3ZSBjYW4gbGF0ZXIg
dHJlYXQgYSByZWNlbnRseSBwdW5jaGVkIGhvbGUgYXMgZGF0YSwgYnV0DQo+IHRoaXMgaXMgc2Fm
ZS4gV2UgY2FuJ3QgY2FjaGUgaG9sZXMgYmVjYXVzZSB0aGVuIHdlIG1pZ2h0IHRyZWF0IHJlY2Vu
dGx5DQo+IHdyaXR0ZW4gZGF0YSBhcyBob2xlcywgd2hpY2ggY2FuIGNhdXNlIGNvcnJ1cHRpb24u
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPiAt
LS0NCj4gICBibG9jay9maWxlLXBvc2l4LmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5j
IGIvYmxvY2svZmlsZS1wb3NpeC5jDQo+IGluZGV4IDhhZWU3YTNmYjguLjcyNzJjN2M5OWQgMTAw
NjQ0DQo+IC0tLSBhL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPiArKysgYi9ibG9jay9maWxlLXBvc2l4
LmMNCj4gQEAgLTE2OCw2ICsxNjgsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgQkRSVlJhd1N0YXRlIHsN
Cj4gICAgICAgYm9vbCBuZWVkc19hbGlnbm1lbnQ7DQo+ICAgICAgIGJvb2wgY2hlY2tfY2FjaGVf
ZHJvcHBlZDsNCj4gICANCj4gKyAgICBzdHJ1Y3Qgc2Vla19kYXRhX2NhY2hlIHsNCj4gKyAgICAg
ICAgYm9vbCAgICAgICAgdmFsaWQ7DQo+ICsgICAgICAgIHVpbnQ2NF90ICAgIHN0YXJ0Ow0KPiAr
ICAgICAgICB1aW50NjRfdCAgICBlbmQ7DQo+ICsgICAgfSBzZWVrX2RhdGFfY2FjaGU7DQoNClNo
b3VsZCB3ZSBoYXZlIHNvbWUgbXV0ZXgtbG9ja2luZyB0byBwcm90ZWN0IGl0Pw0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
