Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaLDL-0006dL-UV
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaLDK-0000fw-Mt
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:51:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Dec 2018 13:51:33 +0000
Message-ID: <a718b5ae-7a81-ac6a-7ca9-1aa17542514f@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
	<20181218075707.12006-7-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-7-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <53056A25497C0040A0010FDFC74EB223@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 06/10] file-posix: reset
 fallocate-related flags without CONFIG_FALLOCATE*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

MTguMTIuMjAxOCAxMDo1NywgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gdGhlc2UgZmxhZ3MgY3Vy
cmVudGx5IGFmZmVjdCBub3RoaW5nIHdpdGhvdXQgQ09ORklHX0ZBTExPQ0FURSosIHNvIGl0J3MN
Cj4gbm90IGEgYnVnLiBGaXhpbmcgaXQgbWFrZXMgcG9zc2libGUgdG8gYWRqdXN0IHN1cHBvcnRl
ZCB6ZXJvIGZsYWcNCj4gQkRSVl9SRVFfQUxMT0NBVEUgcmVnYXJkbGVzcyBvZiBjb25maWd1cmF0
aW9uIChpbiB0aGUgZm9sbG93aW5nIHBhdGNoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFudG9u
IE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZAdmlydHVvenpvLmNvbT4NCg0KSSdkIHByZWZlcmUgdG8g
cmVmYWN0b3IgdGhpbmdzIHNvIHRoYXQgdGhlc2UgdmFyaWFibGVzIGFyZSBmYWxzZSBmcm9tIHRo
ZSBiZWdpbm5pbmcgaW4NCnRoZXNlIGNhc2VzLCBidXQgaXQncyBtb3JlIGRpZmZpY3VsdCBhbmQg
bWF5IGJlIGRvbmUgc2VwYXJhdGVseS4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBibG9j
ay9maWxlLXBvc2l4LmMgfCA4ICsrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9maWxlLXBv
c2l4LmMgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4gaW5kZXggZDhmMGI5Mzc1Mi4uYTY1ZTQ2NGNi
YyAxMDA2NDQNCj4gLS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+ICsrKyBiL2Jsb2NrL2ZpbGUt
cG9zaXguYw0KPiBAQCAtMTQ4OCw5ICsxNDg4LDcgQEAgc3RhdGljIHNzaXplX3QgaGFuZGxlX2Fp
b2NiX3dyaXRlX3plcm9lc19ibG9jayhSYXdQb3NpeEFJT0RhdGEgKmFpb2NiKQ0KPiAgIHN0YXRp
YyBpbnQgaGFuZGxlX2Fpb2NiX3dyaXRlX3plcm9lcyh2b2lkICpvcGFxdWUpDQo+ICAgew0KPiAg
ICAgICBSYXdQb3NpeEFJT0RhdGEgKmFpb2NiID0gb3BhcXVlOw0KPiAtI2lmIGRlZmluZWQoQ09O
RklHX0ZBTExPQ0FURSkgfHwgZGVmaW5lZChDT05GSUdfWEZTKQ0KPiAgICAgICBCRFJWUmF3U3Rh
dGUgKnMgPSBhaW9jYi0+YnMtPm9wYXF1ZTsNCj4gLSNlbmRpZg0KPiAgICNpZmRlZiBDT05GSUdf
RkFMTE9DQVRFDQo+ICAgICAgIGludDY0X3QgbGVuOw0KPiAgICNlbmRpZg0KPiBAQCAtMTUxNCw2
ICsxNTEyLDggQEAgc3RhdGljIGludCBoYW5kbGVfYWlvY2Jfd3JpdGVfemVyb2VzKHZvaWQgKm9w
YXF1ZSkNCj4gICAgICAgICAgIH0NCj4gICAgICAgICAgIHMtPmhhc193cml0ZV96ZXJvZXMgPSBm
YWxzZTsNCj4gICAgICAgfQ0KPiArI2Vsc2UNCj4gKyAgICBzLT5oYXNfd3JpdGVfemVyb2VzID0g
ZmFsc2U7DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICAgI2lmZGVmIENPTkZJR19GQUxMT0NBVEVfUFVO
Q0hfSE9MRQ0KPiBAQCAtMTUzMyw2ICsxNTMzLDggQEAgc3RhdGljIGludCBoYW5kbGVfYWlvY2Jf
d3JpdGVfemVyb2VzKHZvaWQgKm9wYXF1ZSkNCj4gICAgICAgICAgICAgICBzLT5oYXNfZGlzY2Fy
ZCA9IGZhbHNlOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+ICsjZWxzZQ0KPiArICAgIHMt
Pmhhc19kaXNjYXJkID0gZmFsc2U7DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICAgI2lmZGVmIENPTkZJ
R19GQUxMT0NBVEUNCj4gQEAgLTE1NDYsNiArMTU0OCw4IEBAIHN0YXRpYyBpbnQgaGFuZGxlX2Fp
b2NiX3dyaXRlX3plcm9lcyh2b2lkICpvcGFxdWUpDQo+ICAgICAgICAgICB9DQo+ICAgICAgICAg
ICBzLT5oYXNfZmFsbG9jYXRlID0gZmFsc2U7DQo+ICAgICAgIH0NCj4gKyNlbHNlDQo+ICsgICAg
cy0+aGFzX2ZhbGxvY2F0ZSA9IGZhbHNlOw0KPiAgICNlbmRpZg0KPiAgIA0KPiAgICAgICByZXR1
cm4gLUVOT1RTVVA7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
