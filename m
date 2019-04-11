Received: from eggs.gnu.org ([209.51.188.92]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEeHR-0004Ek-04
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEeHP-0004bU-0A
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:18:32 -0400
Received: from mail-eopbgr730063.outbound.protection.outlook.com
	([40.107.73.63]:3046
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hEeHM-0004WJ-0a
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:18:29 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Thu, 11 Apr 2019 18:18:17 +0000
Message-ID: <41de8328-90c8-ce9a-b952-7694d2aa86c3@amd.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<20190411180516.GJ3641@redhat.com>
In-Reply-To: <20190411180516.GJ3641@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F6D71DAF4BE41428A0F9E85FD05F770@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Erik Skultety <eskultet@redhat.com>

DQoNCk9uIDQvMTEvMTkgMTowNSBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24g
VGh1LCBBcHIgMTEsIDIwMTkgYXQgMDU6NTk6NTBQTSArMDAwMCwgU2luZ2gsIEJyaWplc2ggd3Jv
dGU6DQo+PiBUaGVyZSBhcmUgbGltaXRlZCBudW1iZXJzIG9mIHRoZSBTRVYgZ3Vlc3RzIHRoYXQg
Y2FuIGJlIHJ1biBjb25jdXJyZW50bHkuDQo+PiBBIG1hbmFnZW1lbnQgYXBwbGljYXRpb25zIG1h
eSBuZWVkIHRvIGtub3cgdGhpcyBsaW1pdCBzbyB0aGF0IGl0IGNhbiBwbGFjZQ0KPj4gU0VWIFZN
cyBvbiBob3N0cyB3aGljaCBoYXZlIHN1aXRhYmxlIHJlc291cmNlcyBhdmFpbGFibGUuDQo+Pg0K
Pj4gQ3VycmVudGx5LCB0aGlzIGxpbWl0IGlzIG5vdCBleHBvc2VkIHRvIHRoZSBhcHBsaWNhdGlv
bi4gQWRkIGEgbmV3DQo+PiAnc2V2LW1heC1ndWVzdCcgZmllbGQgaW4gdGhlIHF1ZXJ5LXNldi1j
YXBhYmlsaXRpZXMgdG8gcHJvdmlkZSB0aGlzDQo+PiBpbmZvcm1hdGlvbi4NCj4+DQo+PiBDYzog
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4+IENjOiBNYXJrdXMgQXJtYnJ1
c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+PiBDYzogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhh
dC5jb20+DQo+PiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4N
Cj4+IENjOiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPg0KPj4gQ2M6IEVyaWsgU2t1
bHRldHkgPGVza3VsdGV0QHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNp
bmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgcWFwaS90YXJnZXQuanNv
biAgfCA2ICsrKystLQ0KPj4gICB0YXJnZXQvaTM4Ni9zZXYuYyB8IDYgKysrKy0tDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9xYXBpL3RhcmdldC5qc29uIGIvcWFwaS90YXJnZXQuanNvbg0KPj4gaW5kZXgg
MWQ0ZDU0YjYwMC4uYjQ1MTIxZDMwYiAxMDA2NDQNCj4+IC0tLSBhL3FhcGkvdGFyZ2V0Lmpzb24N
Cj4+ICsrKyBiL3FhcGkvdGFyZ2V0Lmpzb24NCj4+IEBAIC0xODMsNyArMTgzLDggQEANCj4gDQo+
IEEgZmV3IGxpbmVzIGFib3ZlIGhlcmUgeW91IG5lZWQgdG8gZG9jdW1lbnQgdGhlIG5ldyBmaWVs
ZA0KPiB3aXRoIChzaW5jZSA0LjEpIGFubm90YXRpb24uDQo+IA0KDQpub3RlZC4gdGhhbmtzDQo=
