Received: from eggs.gnu.org ([209.51.188.92]:48574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEext-0007ro-0J
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEexs-0007x6-1k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:02:24 -0400
Received: from mail-eopbgr680052.outbound.protection.outlook.com
	([40.107.68.52]:53638
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hEexr-0007wo-MZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:02:23 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Thu, 11 Apr 2019 19:02:21 +0000
Message-ID: <7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
In-Reply-To: <61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <05F7BBE3B9FD39438A1BB8145543B6B6@namprd12.prod.outlook.com>
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
To: Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Erik Skultety <eskultet@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

DQoNCk9uIDQvMTEvMTkgMToxMCBQTSwgTGFzemxvIEVyc2VrIHdyb3RlOg0KPiBPbiAwNC8xMS8x
OSAxOTo1OSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+PiBUaGVyZSBhcmUgbGltaXRlZCBudW1i
ZXJzIG9mIHRoZSBTRVYgZ3Vlc3RzIHRoYXQgY2FuIGJlIHJ1biBjb25jdXJyZW50bHkuDQo+PiBB
IG1hbmFnZW1lbnQgYXBwbGljYXRpb25zIG1heSBuZWVkIHRvIGtub3cgdGhpcyBsaW1pdCBzbyB0
aGF0IGl0IGNhbiBwbGFjZQ0KPj4gU0VWIFZNcyBvbiBob3N0cyB3aGljaCBoYXZlIHN1aXRhYmxl
IHJlc291cmNlcyBhdmFpbGFibGUuDQo+Pg0KPj4gQ3VycmVudGx5LCB0aGlzIGxpbWl0IGlzIG5v
dCBleHBvc2VkIHRvIHRoZSBhcHBsaWNhdGlvbi4gQWRkIGEgbmV3DQo+PiAnc2V2LW1heC1ndWVz
dCcgZmllbGQgaW4gdGhlIHF1ZXJ5LXNldi1jYXBhYmlsaXRpZXMgdG8gcHJvdmlkZSB0aGlzDQo+
PiBpbmZvcm1hdGlvbi4NCj4+DQo+PiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCj4+IENjOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+PiBD
YzogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+PiBDYzogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4+IENjOiBMYXN6bG8gRXJzZWsgPGxlcnNla0By
ZWRoYXQuY29tPg0KPj4gQ2M6IEVyaWsgU2t1bHRldHkgPGVza3VsdGV0QHJlZGhhdC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+
PiAtLS0NCj4+ICAgcWFwaS90YXJnZXQuanNvbiAgfCA2ICsrKystLQ0KPj4gICB0YXJnZXQvaTM4
Ni9zZXYuYyB8IDYgKysrKy0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9xYXBpL3RhcmdldC5qc29uIGIv
cWFwaS90YXJnZXQuanNvbg0KPj4gaW5kZXggMWQ0ZDU0YjYwMC4uYjQ1MTIxZDMwYiAxMDA2NDQN
Cj4+IC0tLSBhL3FhcGkvdGFyZ2V0Lmpzb24NCj4+ICsrKyBiL3FhcGkvdGFyZ2V0Lmpzb24NCj4+
IEBAIC0xODMsNyArMTgzLDggQEANCj4+ICAgICAnZGF0YSc6IHsgJ3BkaCc6ICdzdHInLA0KPj4g
ICAgICAgICAgICAgICAnY2VydC1jaGFpbic6ICdzdHInLA0KPj4gICAgICAgICAgICAgICAnY2Jp
dHBvcyc6ICdpbnQnLA0KPj4gLSAgICAgICAgICAgICdyZWR1Y2VkLXBoeXMtYml0cyc6ICdpbnQn
fSwNCj4+ICsgICAgICAgICAgICAncmVkdWNlZC1waHlzLWJpdHMnOiAnaW50JywNCj4+ICsgICAg
ICAgICAgICAnc2V2LW1heC1ndWVzdHMnOiAnaW50J30sDQo+IA0KPiBXb3VsZCBpdCBiZSB1c2Vm
dWwgdG8gbWFrZSB0aGlzIG5ldyBmaWVsZCBvcHRpb25hbD8gRS5nLiBpZiBpdCB3YXMNCj4gbWlz
c2luZywgbGlidmlydGQgY291bGQgYXNzdW1lICJubyBsaW1pdCIuDQo+IA0KDQpJIGFtIG5vdCBz
dXJlIGlmIHdlIG5lZWQgdG8gbWFrZSB0aGlzIGZpZWxkIG9wdGlvbmFsIC0gbWFpbmx5IGJlY2F1
c2UNCmluIFNFViBjb250ZXh0IGhhcmR3YXJlIHdpbGwgYWx3YXlzIGhhdmUgc29tZSBsaW1pdHMg
KGF0IGxlYXN0IGluDQpmb3Jlc2VlYWJsZSBmdXR1cmUpLiBUaGUgYXJjaGl0ZWN0dXJlIHByb3Zp
ZGVzIHVzIGEgQ1BVSUQgdG8gcXVlcnkNCnRoaXMgY2FwYWJpbGl0aWVzIHNvIEkgYW0gYXNzdW1p
bmcgdGhhdCBmdXR1cmUgQ1BVcyB3aWxsIHBvcHVsYXRlDQpzb21lIHZhbHVlcyBpbiBpdC4NCg0K
PiBBZ2Fpbiwgbm90IHN1cmUgaWYgdGhhdCdzIHVzZWZ1bCwgYnV0IGl0J3Mgbm90IGhhcmQgdG8g
aW50cm9kdWNlIHRoZQ0KPiBmaWVsZCBhcyBvcHRpb25hbCBub3cuIFJlbW92aW5nIG1hbmRhdG9y
eSBmaWVsZHMgbGF0ZXIgaXMgaW1wb3NzaWJsZS4NCj4gDQoNCg==
