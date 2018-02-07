Received: from eggs.gnu.org ([2001:4830:134:3::10]:46542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1ejKUc-0001IO-Bz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1ejKUY-0001zF-Tq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:50:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:2201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1ejKUY-0001pq-Iy
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:50:06 -0500
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Date: Wed, 7 Feb 2018 07:49:58 +0000
Message-ID: <ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
In-Reply-To: <5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDYs
IDIwMTggMTozMiBBTQ0KPiBUbzogSWdvciBNYW1tZWRvdg0KPiBDYzogVGFuLCBKaWFuZmVuZzsg
cWVtdS1kZXZlbEBub25nbnUub3JnOyBKYXNvbiBXYW5nOyBNYXhpbWUgQ29xdWVsaW47DQo+IE1p
Y2hhZWwgUyAuIFRzaXJraW4NCj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUkZDXSBleGVj
OiBlbGltaW5hdGUgcmFtIG5hbWluZyBpc3N1ZSBhcw0KPiBtaWdyYXRpb24NCj4gDQo+IE9uIDA1
LzAyLzIwMTggMTg6MTUsIElnb3IgTWFtbWVkb3Ygd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gVGhlbiB3
ZSB3b3VsZCBoYXZlIGJvdGggcmFtIGJsb2NrIG5hbWVkIHBjLnJhbToNCj4gPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEJsb2NrIE5hbWXCoMKgwqAgUFNpemUNCj4gPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYy5yYW3CoMKgwqDCoCA0IEtpQg0K
PiA+Pj4gwqDCoMKgwqDCoCAvb2JqZWN0cy9wYy5yYW3CoMKgwqAgMiBNaUINCj4gPj4+DQo+ID4+
PiBCdXQgSSBhc3N1bWUgaXQncyBhIGNvcm5lciBjYXNlIHdoaWNoIG5vdCByZWFsbHkgaGFwcGVu
Lg0KPiA+PiBZZWFoLCB5b3UncmUgcmlnaHQuIDovICBJIGhhZG4ndCB0aG91Z2h0IG9mIGhvdHBs
dWcuICBJdCBjYW4gaGFwcGVuIGluZGVlZC4NCj4gPg0KPiA+IHBlcmhhcHMgd2Ugc2hvdWxkIGZh
aWwgb2JqZWN0X2FkZCBtZW1vcnktYmFja2VuZC1mb28gaWYgaXQgcmVzdWx0ZWQNCj4gPiBpbiBj
cmVhdGluZyByYW1ibG9jayB3aXRoIGR1cGxpY2F0ZSBpZA0KPiANCj4gTm90ZSB0aGF0IGl0IHdv
dWxkIG9ubHkgYmUgZHVwbGljYXRlZCB3aXRoIEppYW5mZW5nJ3MgcGF0Y2guICBTbyBJJ20NCj4g
d29ycmllZCB0aGF0IGhpcyBwYXRjaCBpcyB3b3JzZSB0aGFuIHdoYXQgd2UgaGF2ZSBub3csIGJl
Y2F1c2UgaXQgbWF5DQo+IGNyZWF0ZSBjb25mbGljdHMgd2l0aCBzeXN0ZW0gUkFNQmxvY2sgbmFt
ZXMgYXJlIG5vdCBuZWNlc3NhcmlseQ0KPiBwcmVkaWN0YWJsZS4gIFJpZ2h0IG5vdywgLW9iamVj
dCBjcmVhdGVzIFJBTUJsb2NrIG5hbWVzIHRoYXQgYXJlIG5pY2VseQ0KPiBjb25zdHJhaW5lZCB3
aXRoaW4gL29iamVjdC8uDQoNClNvIHdlIGFyZSB0cmFkaW5nIG9mZiBiZXR3ZWVuIHRoZSBiZW5l
Zml0IGl0IHRha2VzIGFuZCB0aGUgYmFkIGVmZmVjdCBpdCBicmluZ3MuDQoNCkknbSB3b25kZXJp
bmcgaWYgdGhlIGFib3ZlIGV4YW1wbGUgaXMgdGhlIG9ubHkgZmFpbGVkIGNhc2UgdGhpcyBwYXRj
aCBsZWFkcyB0bywgaS5lLCBvbmx5IHRoZXJlIGlzIGEgcmFtIG5hbWVkICJwYy5yYW0iIGFuZCAi
L29iamVjdC9wYy5yYW0iIGluIHRoZSBzcmMgVk0/DQoNClBsZWFzZSBhbHNvIGNvbnNpZGVyIHRo
ZSBzZWNvbmQgb3B0aW9uLCB0aGF0IGFkZGluZyBhbiBhbGlhcyBuYW1lIGZvciBSQU1CbG9jazsg
SSdtIG5vdCBhIGJpZyBmYW4gZm9yIHRoYXQgb25lLCBhcyBpdCBqdXN0IHB1c2hlcyB0aGUgcHJv
YmxlbSB0byBPcGVuU3RhY2svTGlidmlydC4NCg0KT3IgYW55IG90aGVyIHN1Z2dlc3Rpb25zPw0K
DQpUaGFua3MsDQpKaWFuZmVuZw0K
