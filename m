Received: from eggs.gnu.org ([208.118.235.92]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1g9Wm9-0001Nw-L9
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1g9Wkl-0003rR-NX
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:43:28 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 8 Oct 2018 14:43:19 +0000
Message-ID: <f90999f4-9ac5-fec9-3583-f282de7b3793@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-7-git-send-email-anton.nefedov@virtuozzo.com>
	<20181004154723.GI6009@localhost.localdomain>
In-Reply-To: <20181004154723.GI6009@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB1035EBCB5C8840965CF55981D73740@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 6/8] scsi: account unmap operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

DQoNCk9uIDQvMTAvMjAxOCA2OjQ3IFBNLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiBBbSAyMS4wOC4y
MDE4IHVtIDExOjQ2IGhhdCBBbnRvbiBOZWZlZG92IGdlc2NocmllYmVuOg0KPj4gU2lnbmVkLW9m
Zi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KPj4gUmV2
aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBbGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNv
bT4NCj4+IC0tLQ0KPj4gICBody9zY3NpL3Njc2ktZGlzay5jIHwgOSArKysrKysrKy0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ody9zY3NpL3Njc2ktZGlzay5jIGIvaHcvc2NzaS9zY3NpLWRpc2suYw0KPj4g
aW5kZXggOWQxMGRhZi4uMGFhYzEzNyAxMDA2NDQNCj4+IC0tLSBhL2h3L3Njc2kvc2NzaS1kaXNr
LmMNCj4+ICsrKyBiL2h3L3Njc2kvc2NzaS1kaXNrLmMNCj4+IEBAIC0xNjY0LDYgKzE2NjQsMTAg
QEAgc3RhdGljIHZvaWQgc2NzaV91bm1hcF9jb21wbGV0ZV9ub2lvKFVubWFwQ0JEYXRhICpkYXRh
LCBpbnQgcmV0KQ0KPj4gICAgICAgICAgICAgICBnb3RvIGRvbmU7DQo+PiAgICAgICAgICAgfQ0K
Pj4gICANCj4+ICsgICAgICAgIGJsb2NrX2FjY3Rfc3RhcnQoYmxrX2dldF9zdGF0cyhzLT5xZGV2
LmNvbmYuYmxrKSwgJnItPmFjY3QsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIHItPnNl
Y3Rvcl9jb3VudCAqIHMtPnFkZXYuYmxvY2tzaXplLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICBCTE9DS19BQ0NUX1VOTUFQKTsNCj4gDQo+IElmIHRoZSBjaGVjayBqdXN0IGFib3ZlIHRo
aXMgKGNoZWNrX2xiYV9yYW5nZSkgZmFpbHMsIHdlIHNob3VsZCBhY2NvdW50DQo+IGZvciBhbiBp
bnZhbGlkIHJlcXVlc3QuDQo+IA0KDQpEb25lLg0KDQo+PiAgICAgICAgICAgci0+cmVxLmFpb2Ni
ID0gYmxrX2Fpb19wZGlzY2FyZChzLT5xZGV2LmNvbmYuYmxrLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgci0+c2VjdG9yICogcy0+cWRldi5ibG9ja3NpemUs
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByLT5zZWN0b3Jf
Y291bnQgKiBzLT5xZGV2LmJsb2Nrc2l6ZSwNCj4+IEBAIC0xNjkwLDEwICsxNjk0LDExIEBAIHN0
YXRpYyB2b2lkIHNjc2lfdW5tYXBfY29tcGxldGUodm9pZCAqb3BhcXVlLCBpbnQgcmV0KQ0KPj4g
ICAgICAgci0+cmVxLmFpb2NiID0gTlVMTDsNCj4+ICAgDQo+PiAgICAgICBhaW9fY29udGV4dF9h
Y3F1aXJlKGJsa19nZXRfYWlvX2NvbnRleHQocy0+cWRldi5jb25mLmJsaykpOw0KPj4gLSAgICBp
ZiAoc2NzaV9kaXNrX3JlcV9jaGVja19lcnJvcihyLCByZXQsIGZhbHNlKSkgew0KPj4gKyAgICBp
ZiAoc2NzaV9kaXNrX3JlcV9jaGVja19lcnJvcihyLCByZXQsIHRydWUpKSB7DQo+PiAgICAgICAg
ICAgc2NzaV9yZXFfdW5yZWYoJnItPnJlcSk7DQo+PiAgICAgICAgICAgZ19mcmVlKGRhdGEpOw0K
Pj4gICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIGJsb2NrX2FjY3RfZG9uZShibGtfZ2V0X3N0
YXRzKHMtPnFkZXYuY29uZi5ibGspLCAmci0+YWNjdCk7DQo+PiAgICAgICAgICAgc2NzaV91bm1h
cF9jb21wbGV0ZV9ub2lvKGRhdGEsIHJldCk7DQo+PiAgICAgICB9DQo+PiAgICAgICBhaW9fY29u
dGV4dF9yZWxlYXNlKGJsa19nZXRfYWlvX2NvbnRleHQocy0+cWRldi5jb25mLmJsaykpOw0KPj4g
QEAgLTE3NDAsMTAgKzE3NDUsMTIgQEAgc3RhdGljIHZvaWQgc2NzaV9kaXNrX2VtdWxhdGVfdW5t
YXAoU0NTSURpc2tSZXEgKnIsIHVpbnQ4X3QgKmluYnVmKQ0KPj4gICAgICAgcmV0dXJuOw0KPj4g
ICANCj4+ICAgaW52YWxpZF9wYXJhbV9sZW46DQo+PiArICAgIGJsb2NrX2FjY3RfaW52YWxpZChi
bGtfZ2V0X3N0YXRzKHMtPnFkZXYuY29uZi5ibGspLCBCTE9DS19BQ0NUX1VOTUFQKTsNCj4+ICAg
ICAgIHNjc2lfY2hlY2tfY29uZGl0aW9uKHIsIFNFTlNFX0NPREUoSU5WQUxJRF9QQVJBTV9MRU4p
KTsNCj4+ICAgICAgIHJldHVybjsNCj4+ICAgDQo+PiAgIGludmFsaWRfZmllbGQ6DQo+PiArICAg
IGJsb2NrX2FjY3RfaW52YWxpZChibGtfZ2V0X3N0YXRzKHMtPnFkZXYuY29uZi5ibGspLCBCTE9D
S19BQ0NUX1VOTUFQKTsNCj4+ICAgICAgIHNjc2lfY2hlY2tfY29uZGl0aW9uKHIsIFNFTlNFX0NP
REUoSU5WQUxJRF9GSUVMRCkpOw0KPj4gICB9DQo+IA0KPiBXaGF0IGFib3V0IHRoZSBibGtfaXNf
cmVhZF9vbmx5KCkgY2FzZSB3aGljaCBkaXJlY3RseSByZXR1cm5zIHdpdGhvdXQNCj4ganVtcGlu
ZyB0byBvbmUgb2YgdGhlIGVycm9yIGxhYmVscz8NCj4gDQoNClNvIGJhc2ljYWxseSBhbnl0aGlu
ZyB3ZSBkb24ndCBicmluZyB0byBibGsgbGF5ZXIgaXMgaW52YWxpZCByZXEuDQpGaXhlZC4NCg==
