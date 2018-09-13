Received: from eggs.gnu.org ([2001:4830:134:3::10]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1g0LhM-0000lZ-J1
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1g0LhJ-0005ie-CV
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:05:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:19931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1g0LhJ-0005el-3x
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:05:53 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Thu, 13 Sep 2018 07:05:46 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D3527B11A9@SHSMSX103.ccr.corp.intel.com>
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
	<1529421657-14969-2-git-send-email-jingqi.liu@intel.com>
	<20180716135400.4e7f7d7b@redhat.com>
	<01a7678e-14d0-6687-3545-e408abf59b52@redhat.com>
In-Reply-To: <01a7678e-14d0-6687-3545-e408abf59b52@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V1 RESEND 1/6] hmat acpi: Build Memory
 Subsystem Address Range Structure(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

T24gV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMTggMTA6MzQgUE0sIEVyaWMgQmxha2Ugd3Jv
dGU6DQo+IE9uIDcvMTYvMTggNjo1NCBBTSwgSWdvciBNYW1tZWRvdiB3cm90ZToNCj4gDQo+ID4+
ICsNCj4gPj4gKyNpbmNsdWRlICJ1bmlzdGQuaCINCj4gPj4gKyNpbmNsdWRlICJmY250bC5oIg0K
PiA+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gPj4gKyNpbmNsdWRlICJzeXNlbXUvbnVt
YS5oIg0KPiA+PiArI2luY2x1ZGUgImh3L2kzODYvcGMuaCINCj4gPj4gKyNpbmNsdWRlICJody9p
Mzg2L2FjcGktYnVpbGQuaCINCj4gPj4gKyNpbmNsdWRlICJody9hY3BpL2FjcGkuaCINCj4gPj4g
KyNpbmNsdWRlICJody9hY3BpL2htYXQuaCINCj4gPj4gKyNpbmNsdWRlICJody9hY3BpL2FtbC1i
dWlsZC5oIg0KPiA+PiArI2luY2x1ZGUgImh3L252cmFtL2Z3X2NmZy5oIg0KPiA+PiArI2luY2x1
ZGUgImh3L2FjcGkvYmlvcy1saW5rZXItbG9hZGVyLmgiDQo+ID4gRG8gYWxsIHRoaXMgaGVhZGVy
cyBhcmUgcmVhbGx5IG5lZWRlZCBoZXJlPw0KPiANCj4gRnVydGhlcm1vcmUsICJxZW11L29zZGVw
LmgiIE1VU1QgYmUgbGlzdGVkIGZpcnN0IChhcyBpdCBtYXkgc2V0IG1hY3JvcyB0aGF0DQo+IGFm
ZmVjdCB0aGUgY29udGVudCBvZiBvdGhlciBoZWFkZXJzKTsgInFlbXUvb3NkZXAuaCIgYWxyZWFk
eSB0YWtlcyBjYXJlIG9mDQo+IGluY2x1ZGluZyA8dW5pc3RkLmg+IGFuZCA8ZmNudGwuaD47IGFu
ZCBldmVuIGlmIGl0IGhhZG4ndCwgc3lzdGVtIGhlYWRlcnMgc2hvdWxkDQo+IGJlIHNwZWxsZWQg
bGlrZSA8dW5pc3RkLmg+IHJhdGhlciB0aGFuICJ1bmlzdGQuaCIuDQo+IA0KVGhhbmtzIEVyaWMs
DQpJIHdpbGwgaW1wcm92ZSBhdCBuZXh0IHZlcnNpb24uDQpKaW5ncWkNCj4gLS0NCj4gRXJpYyBC
bGFrZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyDQo+IFJlZCBIYXQsIEluYy4gICAgICAg
ICAgICsxLTkxOS0zMDEtMzI2Ng0KPiBWaXJ0dWFsaXphdGlvbjogIHFlbXUub3JnIHwgbGlidmly
dC5vcmcNCg==
