Received: from eggs.gnu.org ([209.51.188.92]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gltCf-0000nt-Mq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gltCe-0007Hi-Qs
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:22:45 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 22 Jan 2019 10:22:16 +0000
Message-ID: <05bf4364-61b0-21de-768d-6c1ad2a06d63@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
	<20190108170655.29766-5-vsementsov@virtuozzo.com>
	<bda00283-197d-4b1b-7be0-633a0410f87d@redhat.com>
In-Reply-To: <bda00283-197d-4b1b-7be0-633a0410f87d@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BC9ED0AFA628C48825B98198B69274E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 4/9] qcow2-threads:
 qcow2_co_do_compress: protect queuing by mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>

MTYuMDEuMjAxOSAyOjI5LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiBPbiAwOC8wMS8xOSAxODow
NiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cj4+IC0tLQ0KPj4gICBibG9jay9xY293Mi10aHJlYWRzLmMgfCAxMCArKysrKysrLS0tDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLXRocmVhZHMuYyBiL2Jsb2NrL3Fjb3cyLXRocmVhZHMu
Yw0KPj4gaW5kZXggMjBiMjYxNjUyOS4uMTU2ZTA2NjdiZSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2Nr
L3Fjb3cyLXRocmVhZHMuYw0KPj4gKysrIGIvYmxvY2svcWNvdzItdGhyZWFkcy5jDQo+PiBAQCAt
MTU4LDE1ICsxNTgsMTkgQEAgcWNvdzJfY29fZG9fY29tcHJlc3MoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsIHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+PiAgICAgICAgICAgLmZ1bmMgPSBm
dW5jLA0KPj4gICAgICAgfTsNCj4+ICAgDQo+PiArICAgIHFlbXVfY29fbXV0ZXhfbG9jaygmcy0+
bG9jayk7DQo+PiAgICAgICB3aGlsZSAocy0+bmJfY29tcHJlc3NfdGhyZWFkcyA+PSBNQVhfQ09N
UFJFU1NfVEhSRUFEUykgew0KPj4gLSAgICAgICAgcWVtdV9jb19xdWV1ZV93YWl0KCZzLT5jb21w
cmVzc193YWl0X3F1ZXVlLCBOVUxMKTsNCj4+ICsgICAgICAgIHFlbXVfY29fcXVldWVfd2FpdCgm
cy0+Y29tcHJlc3Nfd2FpdF9xdWV1ZSwgJnMtPmxvY2spOw0KPj4gICAgICAgfQ0KPj4gLQ0KPj4g
ICAgICAgcy0+bmJfY29tcHJlc3NfdGhyZWFkcysrOw0KPj4gKyAgICBxZW11X2NvX211dGV4X3Vu
bG9jaygmcy0+bG9jayk7DQo+PiArDQo+PiAgICAgICB0aHJlYWRfcG9vbF9zdWJtaXRfY28ocG9v
bCwgcWNvdzJfY29tcHJlc3NfcG9vbF9mdW5jLCAmYXJnKTsNCj4+IC0gICAgcy0+bmJfY29tcHJl
c3NfdGhyZWFkcy0tOw0KPj4gICANCj4+ICsgICAgcWVtdV9jb19tdXRleF9sb2NrKCZzLT5sb2Nr
KTsNCj4+ICsgICAgcy0+bmJfY29tcHJlc3NfdGhyZWFkcy0tOw0KPj4gICAgICAgcWVtdV9jb19x
dWV1ZV9uZXh0KCZzLT5jb21wcmVzc193YWl0X3F1ZXVlKTsNCj4+ICsgICAgcWVtdV9jb19tdXRl
eF91bmxvY2soJnMtPmxvY2spOw0KPj4gICANCj4+ICAgICAgIHJldHVybiBhcmcucmV0Ow0KPj4g
ICB9DQo+Pg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhh
dC5jb20+DQo+IA0KPiBidXQsIHNvbWUgaW5mb3JtYXRpb24gd291bGQgYmUgbmljZSB0byBoYXZl
IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KQ291bGQgeW91IHN1Z2dlc3Qgb25lPw0KDQpKdXN0
LCAiVG8gbWFrZSBpdCB0aHJlYWQtc2FmZS4iPyBJIGRvbid0IGhhdmUgZ29vZCB1bmRlcnN0YW5k
aW5nDQpvZiBtb3ZpbmcgZnJvbSAiQWlvQ29udGV4dCBsb2NrIHVzYWdlIiB0byBvdGhlciBsb2Nr
cywgYXMgd2VsbCBhcw0KSSBkb24ndCBrbm93IGhvdyBCbG9ja0RyaXZlclN0YXRlIGlzIGdvaW5n
IHRvIGJlIHVzZWQgaW4gcGFyYWxsZWwNCnRocmVhZHMsIGFuZCBob3cgbXVjaCBvZiBvdGhlciBj
b2RlIGlzIGFscmVhZHkgcHJlcGFyZWQgdG8gd29yaw0KaW4gbXVsdGlwbGUtdGhyZWFkcyBlbnZp
cm9ubWVudC4NCg0KSSBsb29rZWQgdGhyb3VnaCB5b3VyIGNvbW1pdCBtZXNzYWdlcyBvbiBwYXRj
aGVzIHdoaWNoIGFkZGVkIHByb3RlY3Rpb24NCnRvIHNpbWlsYXIgcGxhY2VzIGFib3V0IGNvLXF1
ZXVlcywgYnV0IGRpZG4ndCBmaW5kIGRldGFpbGVkIGRlc2NyaXB0aW9uLg0KDQo+IA0KPiBQYW9s
bw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
