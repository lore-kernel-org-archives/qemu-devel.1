Received: from eggs.gnu.org ([2001:4830:134:3::10]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gREDl-00006c-RB
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gREDf-0003Ob-My
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:34:29 -0500
Received: from mail-oln040092003045.outbound.protection.outlook.com
	([40.92.3.45]:41568
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liq3ea@outlook.com>) id 1gREDe-0003H8-Kk
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:34:23 -0500
From: li qiang <liq3ea@outlook.com>
Date: Mon, 26 Nov 2018 10:34:13 +0000
Message-ID: <BN6PR18MB1220C6FD680DB5E2C2AEA9F09FD70@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181126100836.8805-1-kraxel@redhat.com>
In-Reply-To: <20181126100836.8805-1-kraxel@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-ID: <D792E567124E8F448F575430815ADD61@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ehci: fix fetch qtd race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQrU2iAyMDE4LzExLzI2IDE4OjA4LCBHZXJkIEhvZmZtYW5uINC0tcA6DQo+IFRoZSB0b2tlbiBm
aWVsZCBjb250YWlucyB0aGUgKGd1ZXN0LWZpbGxlZCkgc3RhdGUgb2YgdGhlIHF0ZCwgd2hpY2gN
Cj4gaW5kaWNhdGVzIHdoZW5ldmVyIHRoZSBvdGhlciBmaWVsZHMgYXJlIHZhbGlkIG9yIG5vdC4g
IFNvIG1ha2Ugc3VyZQ0KPiB3ZSByZWFkIHRoZSB0b2tlbiBmaXJzdCwgb3RoZXJ3aXNlIHdlIG1h
eSBlbmQgdXAgd2l0aCBhbiBzdGFsZSBuZXh0DQo+IHBvaW50ZXI6DQo+DQo+ICAgICgxKSBlaGNp
IHJlYWRzIG5leHQNCj4gICAgKDIpIGd1ZXN0IHdyaXRlcyBuZXh0DQo+ICAgICgzKSBndWVzdCB3
cml0ZXMgdG9rZW4NCj4gICAgKDQpIGVoY2kgcmVhZHMgdG9rZW4NCj4gICAgKDUpIGVoY2kgb3Bl
cmF0ZXMgd2l0aCBzdGFsZSBuZXh0Lg0KDQpIZWxsbyBHZXJkLA0KDQpDb3VsZCB5b3UgcGxlYXNl
IGV4cGxhaW4gaG93IHRoaXMgY2FuIGhhcHBlbj8NCg0KSU1PLCB0aGUgZGV2aWNlIGVtdWxhdGlv
biBob2xkcyB0aGUgQlFMIGFuZCB0aGUgZ3Vlc3QgY2FuJ3QgZXhlY3V0ZSwgaG93IA0KY2FuIHRo
ZSBndWVzdA0KDQp3cml0ZSB0aGlzIHdoZW4gUUVNVSBpcyBpbiAnZWhjaV9zdGF0ZV9mZXRjaHF0
ZCc/DQoNCg0KVGhhbmtzLA0KDQpMaSBRaWFuZw0KDQoNCj4gVHlwaWNhbCBlZmZlY3QgaXMgdGhh
dCBxZW11IGRvZXNuJ3Qgbm90aWNlIHRoYXQgdGhlIGd1ZXN0IGFwcGVuZHMgbmV3DQo+IHF0ZHMg
dG8gdGhlIGVuZCBvZiB0aGUgcXVldWUuICBMb29rcyBsaWtlIHRoZSB1c2IgZGV2aWNlIHN0b3Bw
ZWQNCj4gcmVzcG9uZGluZy4gIExpbnV4IGNhbiByZWNvdmVyIGZyb20gdGhhdCwgYnV0IGxlYXZl
cyBhIG1lc3NhZ2UgaW4gdGhlDQo+IGtlcm5lbCBsb2cgdGhhdCBpdCBkaWQgcmVzZXQgdGhlIHVz
YiBkZXZpY2UgaW4gcXVlc3Rpb24uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4g
PGtyYXhlbEByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBody91c2IvaGNkLWVoY2kuYyB8IDEyICsr
KysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hjZC1laGNpLmMgYi9ody91c2IvaGNk
LWVoY2kuYw0KPiBpbmRleCBlNWFjZmM1YmE1Li44ZDQ0ZDQ4M2RmIDEwMDY0NA0KPiAtLS0gYS9o
dy91c2IvaGNkLWVoY2kuYw0KPiArKysgYi9ody91c2IvaGNkLWVoY2kuYw0KPiBAQCAtMTc4Myw5
ICsxNzgzLDE3IEBAIHN0YXRpYyBpbnQgZWhjaV9zdGF0ZV9mZXRjaHF0ZChFSENJUXVldWUgKnEp
DQo+ICAgICAgIEVIQ0lxdGQgcXRkOw0KPiAgICAgICBFSENJUGFja2V0ICpwOw0KPiAgICAgICBp
bnQgYWdhaW4gPSAxOw0KPiArICAgIHVpbnQzMl90IGFkZHI7DQo+ICAgDQo+IC0gICAgaWYgKGdl
dF9kd29yZHMocS0+ZWhjaSwgTkxQVFJfR0VUKHEtPnF0ZGFkZHIpLCAodWludDMyX3QgKikgJnF0
ZCwNCj4gLSAgICAgICAgICAgICAgICAgICBzaXplb2YoRUhDSXF0ZCkgPj4gMikgPCAwKSB7DQo+
ICsgICAgYWRkciA9IE5MUFRSX0dFVChxLT5xdGRhZGRyKTsNCj4gKyAgICBpZiAoZ2V0X2R3b3Jk
cyhxLT5laGNpLCBhZGRyICsgIDgsICZxdGQudG9rZW4sICAgMSkgPCAwKSB7DQo+ICsgICAgICAg
IHJldHVybiAwOw0KPiArICAgIH0NCj4gKyAgICBiYXJyaWVyKCk7DQo+ICsgICAgaWYgKGdldF9k
d29yZHMocS0+ZWhjaSwgYWRkciArICAwLCAmcXRkLm5leHQsICAgIDEpIDwgMCB8fA0KPiArICAg
ICAgICBnZXRfZHdvcmRzKHEtPmVoY2ksIGFkZHIgKyAgNCwgJnF0ZC5hbHRuZXh0LCAxKSA8IDAg
fHwNCj4gKyAgICAgICAgZ2V0X2R3b3JkcyhxLT5laGNpLCBhZGRyICsgMTIsIHF0ZC5idWZwdHIs
DQo+ICsgICAgICAgICAgICAgICAgICAgQVJSQVlfU0laRShxdGQuYnVmcHRyKSkgPCAwKSB7DQo+
ICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgfQ0KPiAgICAgICBlaGNpX3RyYWNlX3F0ZChx
LCBOTFBUUl9HRVQocS0+cXRkYWRkciksICZxdGQpOw0K
