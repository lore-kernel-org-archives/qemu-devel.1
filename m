Received: from eggs.gnu.org ([2001:4830:134:3::10]:44940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUXBs-0005zu-44
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUXBp-0003A8-Vd
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:26:11 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 5 Dec 2018 13:25:44 +0000
Message-ID: <7ca3779c-b552-97f1-8ce2-860db23be045@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-7-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181203101429.88735-7-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBBEA6706833EA41B9AA6EA6B2B4B36B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 6/9] file-posix: support
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

MDMuMTIuMjAxOCAxMzoxNCwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gQ3VycmVudCB3cml0ZV96
ZXJvZXMgaW1wbGVtZW50YXRpb24gaXMgZ29vZCBlbm91Z2ggdG8gc2F0aXNmeSB0aGlzIGZsYWcg
dG9vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZp
cnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL2ZpbGUtcG9zaXguYyB8IDggKysrKysrKy0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5jIGIvYmxvY2svZmlsZS1wb3NpeC5jDQo+
IGluZGV4IDA3YmJkYWI5NTMuLmIwYjdhYjAxNTkgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2ZpbGUt
cG9zaXguYw0KPiArKysgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4gQEAgLTYwMyw2ICs2MDMsNyBA
QCBzdGF0aWMgaW50IHJhd19vcGVuX2NvbW1vbihCbG9ja0RyaXZlclN0YXRlICpicywgUURpY3Qg
Km9wdGlvbnMsDQo+ICAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgIHMtPmRpc2Nh
cmRfemVyb2VzID0gdHJ1ZTsNCj4gICAgICAgICAgICAgICBzLT5oYXNfZmFsbG9jYXRlID0gdHJ1
ZTsNCj4gKyAgICAgICAgICAgIGJzLT5zdXBwb3J0ZWRfemVyb19mbGFncyA9IEJEUlZfUkVRX0FM
TE9DQVRFOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgaWYg
KCEoU19JU0NIUihzdC5zdF9tb2RlKSB8fCBTX0lTQkxLKHN0LnN0X21vZGUpKSkgew0KPiBAQCAt
NjQ2LDEwICs2NDcsMTEgQEAgc3RhdGljIGludCByYXdfb3Blbl9jb21tb24oQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0KPiAgICNpZmRlZiBDT05GSUdfWEZTDQo+ICAgICAg
IGlmIChwbGF0Zm9ybV90ZXN0X3hmc19mZChzLT5mZCkpIHsNCj4gICAgICAgICAgIHMtPmlzX3hm
cyA9IHRydWU7DQo+ICsgICAgICAgIGJzLT5zdXBwb3J0ZWRfemVyb19mbGFncyA9IEJEUlZfUkVR
X0FMTE9DQVRFOw0KDQp3aHkgd2Ugc2hvdWxkIGhhbmRsZSB4ZnMgc2VwYXJhdGVseT8gaXMgdGhl
cmUgYSBjYXNlIHdpdGggeGZzLCBub3QgaGFuZGxlZCBieSBwcmV2aW91cyBnZW5lcmljIGlmICgp
Pw0KDQo+ICAgICAgIH0NCj4gICAjZW5kaWYNCj4gICANCj4gLSAgICBicy0+c3VwcG9ydGVkX3pl
cm9fZmxhZ3MgPSBCRFJWX1JFUV9NQVlfVU5NQVA7DQo+ICsgICAgYnMtPnN1cHBvcnRlZF96ZXJv
X2ZsYWdzIHw9IEJEUlZfUkVRX01BWV9VTk1BUDsNCj4gICAgICAgcmV0ID0gMDsNCj4gICBmYWls
Og0KPiAgICAgICBpZiAoZmlsZW5hbWUgJiYgKGJkcnZfZmxhZ3MgJiBCRFJWX09fVEVNUE9SQVJZ
KSkgew0KPiBAQCAtMTUyMCw2ICsxNTIyLDEwIEBAIHN0YXRpYyBzc2l6ZV90IGhhbmRsZV9haW9j
Yl93cml0ZV96ZXJvZXMoUmF3UG9zaXhBSU9EYXRhICphaW9jYikNCj4gICAgICAgICAgIH0NCj4g
ICAgICAgICAgIHMtPmhhc19mYWxsb2NhdGUgPSBmYWxzZTsNCj4gICAgICAgfQ0KPiArDQo+ICsg
ICAgaWYgKCFzLT5oYXNfZmFsbG9jYXRlKSB7DQo+ICsgICAgICAgIGFpb2NiLT5icy0+c3VwcG9y
dGVkX3plcm9fZmxhZ3MgJj0gfkJEUlZfUkVRX0FMTE9DQVRFOw0KPiArICAgIH0NCj4gICAjZW5k
aWYNCj4gICANCj4gICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPiANCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=
