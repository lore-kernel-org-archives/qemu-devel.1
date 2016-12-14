Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cH0Au-0003vB-It
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cH0Ar-0004OE-D0
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:24:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:44873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cH0Ar-0004O0-1V
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:24:09 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Wed, 14 Dec 2016 03:24:01 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257438FCB9E1@SHSMSX104.ccr.corp.intel.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
	<1481020588-4245-2-git-send-email-peterx@redhat.com>
	<20161212081650.GA13155@gmail.com>
	<20161214030554.GH32222@pxdev.xzpeter.org>
In-Reply-To: <20161214030554.GH32222@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 01/13] intel_iommu: allocate new key
 when creating new address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, Jason Wang <jasowang@redhat.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu, Feng" <feng.wu@intel.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWRldmVsIFttYWlsdG86
cWVtdS1kZXZlbC1ib3VuY2VzK3lpLmwubGl1PWludGVsLmNvbUBub25nbnUub3JnXSBPbg0KPiBC
ZWhhbGYgT2YgUGV0ZXIgWHUNCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNCwgMjAxNiAx
MTowNiBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBsaW51eC5pbnRlbC5jb20+OyBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBDYzogTGFuLCBUaWFueXUgPHRpYW55dS5s
YW5AaW50ZWwuY29tPjsgVGlhbiwgS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsNCj4gbXN0
QHJlZGhhdC5jb207IGphbi5raXN6a2FAc2llbWVucy5jb207IGJkLmF2aXZAZ21haWwuY29tOyBx
ZW11LQ0KPiBkZXZlbEBub25nbnUub3JnOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgTGl1
LCBZaSA8eWkubGl1QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUkZD
IFBBVENIIDAxLzEzXSBpbnRlbF9pb21tdTogYWxsb2NhdGUgbmV3IGtleSB3aGVuDQo+IGNyZWF0
aW5nIG5ldyBhZGRyZXNzIHNwYWNlDQo+IA0KPiBPbiBNb24sIERlYyAxMiwgMjAxNiBhdCAwNDox
Njo1MFBNICswODAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gT24gVHVlLCBEZWMgMDYsIDIwMTYg
YXQgMDY6MzY6MTZQTSArMDgwMCwgUGV0ZXIgWHUgd3JvdGU6DQo+ID4gPiBGcm9tOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4NCj4gPiA+IFdlIHVzZSB0aGUgcG9pbnRl
ciB0byBzdGFjayBmb3Iga2V5IGZvciBuZXcgYWRkcmVzcyBzcGFjZSwgdGhpcyB3aWxsDQo+ID4g
PiBicmVhayBoYXNoIHRhYmxlIHNlYXJjaGluZywgZml4aW5nIGJ5IGdfbWFsbG9jKCkgYSBuZXcg
a2V5IGluc3RlYWQuDQo+ID4gPg0KPiA+ID4gQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+DQo+ID4gPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4N
Cj4gPiA+IENjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0KPiA+ID4gQ2M6
IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT4NCj4gPiA+IEFja2VkLWJ5OiBQ
ZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWHUg
PHBldGVyeEByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIHwgNSArKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gaW5kZXggNzA4NzcwZS4uOTJlNDA2
NCAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiBAQCAtMjQyNiwxMiArMjQyNiwxMyBAQCBWVERB
ZGRyZXNzU3BhY2UNCj4gKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1
cyAqYnVzLCBpbnQgZGV2Zm4pDQo+ID4gPiAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9h
czsNCj4gPiA+DQo+ID4gPiAgICAgIGlmICghdnRkX2J1cykgew0KPiA+ID4gKyAgICAgICAgdWlu
dHB0cl90ICpuZXdfa2V5ID0gZ19tYWxsb2Moc2l6ZW9mKCpuZXdfa2V5KSk7DQo+ID4gPiArICAg
ICAgICAqbmV3X2tleSA9ICh1aW50cHRyX3QpYnVzOw0KPiA+ID4gICAgICAgICAgLyogTm8gY29y
cmVzcG9uZGluZyBmcmVlKCkgKi8NCj4gPiA+ICAgICAgICAgIHZ0ZF9idXMgPSBnX21hbGxvYzAo
c2l6ZW9mKFZUREJ1cykgKyBzaXplb2YoVlREQWRkcmVzc1NwYWNlICopICogXA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBYODZfSU9NTVVfUENJX0RFVkZOX01BWCk7DQo+ID4g
PiAgICAgICAgICB2dGRfYnVzLT5idXMgPSBidXM7DQo+ID4gPiAtICAgICAgICBrZXkgPSAodWlu
dHB0cl90KWJ1czsNCj4gPiA+IC0gICAgICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2Fz
X2J5X2J1c3B0ciwgJmtleSwgdnRkX2J1cyk7DQo+ID4gPiArICAgICAgICBnX2hhc2hfdGFibGVf
aW5zZXJ0KHMtPnZ0ZF9hc19ieV9idXNwdHIsIG5ld19rZXksIHZ0ZF9idXMpOw0KPiA+IEhpIFBl
dGVyLA0KPiA+IFlvdXIgZml4IHNlZW1zIHRvIGFuc3dlciBhbiBpc3N1ZSBJIGVuY291bnRlcmVk
IGJhY2sgaW4gT2N0LiBUaGUgc3ltcHRvbSBpczogdXNlDQo+IHRoZSBzYW1lIGJ1cyB2YWx1ZSB0
bw0KPiA+IHNlYXJjaGEgcHJldmlvdXMgaW5zZXJ0ZWQgZW50cnkgaW4gcy0+dnRkX2FzX2J5X2J1
c3B0ciwgdGhlIHJlc3VsdCBpcyBub3QgZm91bmQuDQo+ID4NCj4gPiByZWFsbHkgZ3J0IGZpeC4g
Y291bGQgZXhwbGFpbiBpdCBhIGJpdCBvbiB3aHkgdGhpcyBjaGFuZ2Ugd291bGQgZml4IHRoZSBp
c3N1ZT8NCj4gDQo+IFRoZSBvbGQgY29kZSBpcyBkb2luZyBnX2hhc2hfdGFibGVfaW5zZXJ0KCkg
d2l0aCAiJmtleSIgYXMgdGhlIGhhc2gNCj4ga2V5LiBIb3dldmVyIHZhcmlhYmxlICJrZXkiIGlz
IGFsbG9jYXRlZCBvbiBzdGFjaywgc28gaXQncyB2YWx1ZSBtaWdodA0KPiBjaGFuZ2UgYWZ0ZXIg
d2UgcmV0dXJuIGZyb20gdnRkX2ZpbmRfYWRkX2FzKCkgKHN0YWNrIHZhcmlhYmxlcyBjYW4NCj4g
b25seSBiZSB1c2VkIGluc2lkZSBpdHMgZnVuY3Rpb25hbCBzY29wZSkuIFRoZSBwYXRjaCBzd2l0
Y2hlZCB0byB1c2UNCj4gZ19tYWxsb2MwKCksIHRoYXQnbGwgdXNlIGhlYXAgbWVtb3J5IHJhdGhl
ciB0aGFuIHN0YWNrLCB3aGljaCBpcyBzYWZlLg0KPiANCj4gKEZvcndhcmRpbmcgdGhpcyB0aGFu
a2Z1bG5lc3MgdG8gSmFzb24gd2hvIGlzIHRoZSByZWFsIGF1dGhvciBvZiB0aGlzDQo+ICBmaXgg
Oi0pDQoNClRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLCBQZXRlci4gSSBzZWUuIFRoZW4gaXQg
aXMgc3VyZSB0aGlzIHJlYWxseSBmaXggd2hhdA0KSSBlbmNvdW50ZXJlZCBpbiBPY3QuIFJlYWxs
eSBhIHdvbmRlcmZ1bCBmaXggSmFzb25+IA0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAtLSBwZXRl
cngNCg0K
