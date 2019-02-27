Received: from eggs.gnu.org ([209.51.188.92]:44790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzA3-0007VJ-FL
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzA2-0008FE-K8
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:22:11 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 12:47:19 +0000
Message-ID: <1b6f86f0-1bf5-f306-b24a-ed37c3d9016a@virtuozzo.com>
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-6-vsementsov@virtuozzo.com>
	<15e27f9f-8788-66ce-7843-0922662e42b1@redhat.com>
In-Reply-To: <15e27f9f-8788-66ce-7843-0922662e42b1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D84D4DFC69D4854AA9CF88A125586C56@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 5/5] qcow2-refcount: don't mask
 corruptions under internal errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjcuMDIuMjAxOSAxNTo0MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4xMi4xOCAxNDo0Miwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IE5vIHJlYXNvbnMgZm9yIG5v
dCByZXBvcnRpbmcgZm91bmQgY29ycnVwdGlvbnMgYXMgY29ycnVwdGlvbnMgaW4gY2FzZQ0KPj4g
b2Ygc29tZSBpbnRlcm5hbCBlcnJvcnMsIGVzcGVjaWFsbHkgaW4gY2FzZSBvZiBqdXN0IGZhaWxl
ZCB0byBmaXggbDINCj4+IGVudHJ5IChhbmQgaW4gdGhpcyBjYXNlLCBtaXNzZWQgY29ycnVwdGlv
bnMgbWF5IGluZmx1ZW5jZSBjb21wYXJpbmcNCj4+IGxvZ2ljLCB3aGVuIHdlIGNhbGN1bGF0ZSBk
aWZmZXJlbmNlIGJldHdlZW4gY29ycnVwdGlvbnMgZmllbGRzIG9mIHR3bw0KPj4gcmVzdWx0cykN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svcWNvdzItcmVmY291bnQu
YyB8IDMxICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ibG9jay9xY293Mi1yZWZjb3VudC5jIGIvYmxvY2svcWNvdzItcmVmY291bnQuYw0KPj4gaW5k
ZXggOGRhMGU5MWRkMy4uYjBlMDA2ZTYyOCAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLXJl
ZmNvdW50LmMNCj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLXJlZmNvdW50LmMNCj4gDQo+IFsuLi5dDQo+
IA0KPj4gQEAgLTE4OTksMTkgKzE4OTksMTYgQEAgc3RhdGljIGludCBjaGVja19vZmxhZ19jb3Bp
ZWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEJkcnZDaGVja1Jlc3VsdCAqcmVzLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiJXMgT0ZMQUdfQ09QSUVEIGRhdGEgY2x1
c3RlcjogIg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImwyX2VudHJ5PSUiIFBS
SXg2NCAiIHJlZmNvdW50PSUiIFBSSXU2NCAiXG4iLA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVwYWlyID8gIlJlcGFpcmluZyIgOiAiRVJST1IiLCBsMl9lbnRyeSwgcmVmY291
bnQpOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgaWYgKHJlcGFpcikgew0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgIGwyX3RhYmxlW2pdID0gY3B1X3RvX2JlNjQocmVmY291bnQgPT0gMQ0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID8gbDJfZW50cnkgfCAgUUNP
V19PRkxBR19DT1BJRUQNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6
IGwyX2VudHJ5ICYgflFDT1dfT0ZMQUdfQ09QSUVEKTsNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICBsMl9kaXJ0eSsrOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgICByZXMtPmNvcnJ1cHRpb25zKys7DQo+PiAtICAgICAgICAg
ICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgICAgICAgICBsMl90YWJsZVtqXSA9IGNwdV90
b19iZTY0KHJlZmNvdW50ID09IDENCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ID8gbDJfZW50cnkgfCAgUUNPV19PRkxBR19DT1BJRUQNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDogbDJfZW50cnkgJiB+UUNPV19PRkxBR19DT1BJRUQpOw0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgbDJfZGlydHkrKzsNCj4gDQo+IEkgZm91bmQgdGhlIG9sZCBsb2dpYyB0
byBiZSBlYXNpZXIgdG8gdW5kZXJzdGFuZCwgYWN0dWFsbHkuICBJdCBtYWRlIGl0DQo+IGNsZWFy
IHRoYXQgaWYgIXJlcGFpciwgdGhlIEwyIHRhYmxlIGlzIG5vdCBnb2luZyB0byBiZSB0b3VjaGVk
Lg0KPiANCj4gTWF4DQo+IA0KDQpzbywNCg0KICAgaWYgKHJlcGFpcikgew0KICAgICAga2VlcCBh
cyBpcw0KICAgfQ0KICAgcmVzLT5jb3JydXB0aW9ucysrOw0KDQpvaz8NCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=
