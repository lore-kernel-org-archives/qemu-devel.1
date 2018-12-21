Received: from eggs.gnu.org ([2001:4830:134:3::10]:47805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaLdv-0001zc-9T
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaLdu-0002aH-NP
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:19:11 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Dec 2018 14:18:55 +0000
Message-ID: <977d6220-4515-fc35-d5e0-baddc37cae0f@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
	<20181218075707.12006-8-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-8-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15D14BA2620E24B90F441F19388899C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 07/10] file-posix: support
 BDRV_REQ_ALLOCATE
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

MTguMTIuMjAxOCAxMDo1NywgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gQ3VycmVudCB3cml0ZV96
ZXJvZXMgaW1wbGVtZW50YXRpb24gaXMgZ29vZCBlbm91Z2ggdG8gc2F0aXNmeSB0aGlzIGZsYWcg
dG9vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZp
cnR1b3p6by5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQo+IC0tLQ0KPiAgIGJsb2NrL2ZpbGUt
cG9zaXguYyB8IDggKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5jIGIv
YmxvY2svZmlsZS1wb3NpeC5jDQo+IGluZGV4IGE2NWU0NjRjYmMuLmMzZmJmNTM4NTMgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPiArKysgYi9ibG9jay9maWxlLXBvc2l4LmMN
Cj4gQEAgLTYwNyw2ICs2MDcsNyBAQCBzdGF0aWMgaW50IHJhd19vcGVuX2NvbW1vbihCbG9ja0Ry
aXZlclN0YXRlICpicywgUURpY3QgKm9wdGlvbnMsDQo+ICAgICAgICAgICB9IGVsc2Ugew0KPiAg
ICAgICAgICAgICAgIHMtPmRpc2NhcmRfemVyb2VzID0gdHJ1ZTsNCj4gICAgICAgICAgICAgICBz
LT5oYXNfZmFsbG9jYXRlID0gdHJ1ZTsNCj4gKyAgICAgICAgICAgIGJzLT5zdXBwb3J0ZWRfemVy
b19mbGFncyA9IEJEUlZfUkVRX0FMTE9DQVRFOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9IGVs
c2Ugew0KPiAgICAgICAgICAgaWYgKCEoU19JU0NIUihzdC5zdF9tb2RlKSB8fCBTX0lTQkxLKHN0
LnN0X21vZGUpKSkgew0KPiBAQCAtNjUwLDEwICs2NTEsMTEgQEAgc3RhdGljIGludCByYXdfb3Bl
bl9jb21tb24oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0KPiAgICNpZmRl
ZiBDT05GSUdfWEZTDQo+ICAgICAgIGlmIChwbGF0Zm9ybV90ZXN0X3hmc19mZChzLT5mZCkpIHsN
Cj4gICAgICAgICAgIHMtPmlzX3hmcyA9IHRydWU7DQo+ICsgICAgICAgIGJzLT5zdXBwb3J0ZWRf
emVyb19mbGFncyA9IEJEUlZfUkVRX0FMTE9DQVRFOw0KPiAgICAgICB9DQo+ICAgI2VuZGlmDQo+
ICAgDQo+IC0gICAgYnMtPnN1cHBvcnRlZF96ZXJvX2ZsYWdzID0gQkRSVl9SRVFfTUFZX1VOTUFQ
Ow0KPiArICAgIGJzLT5zdXBwb3J0ZWRfemVyb19mbGFncyB8PSBCRFJWX1JFUV9NQVlfVU5NQVA7
DQo+ICAgICAgIHJldCA9IDA7DQo+ICAgZmFpbDoNCj4gICAgICAgaWYgKGZpbGVuYW1lICYmIChi
ZHJ2X2ZsYWdzICYgQkRSVl9PX1RFTVBPUkFSWSkpIHsNCj4gQEAgLTE1NTIsNiArMTU1NCwxMCBA
QCBzdGF0aWMgaW50IGhhbmRsZV9haW9jYl93cml0ZV96ZXJvZXModm9pZCAqb3BhcXVlKQ0KPiAg
ICAgICBzLT5oYXNfZmFsbG9jYXRlID0gZmFsc2U7DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsgICAg
aWYgKCFzLT5oYXNfZmFsbG9jYXRlKSB7DQo+ICsgICAgICAgIGFpb2NiLT5icy0+c3VwcG9ydGVk
X3plcm9fZmxhZ3MgJj0gfkJEUlZfUkVRX0FMTE9DQVRFOw0KPiArICAgIH0NCj4gKw0KPiAgICAg
ICByZXR1cm4gLUVOT1RTVVA7DQo+ICAgfQ0KPiAgIA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=
