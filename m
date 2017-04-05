Received: from eggs.gnu.org ([2001:4830:134:3::10]:41007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvtMS-00070n-7v
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 18:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvtMP-0002P3-4h
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 18:25:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:62505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvtMO-0002Or-Tp
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 18:25:05 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 5 Apr 2017 22:25:01 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A50A36@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A4F5DD@ORSMSX112.amr.corp.intel.com>
	<119011da-a75c-3baf-f5c0-f59e0bbc1000@redhat.com>
In-Reply-To: <119011da-a75c-3baf-f5c0-f59e0bbc1000@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/3] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "anthony.perard@citrix.com" <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>

SGkgRXJpYywNCg0KV2lsbCByZXNlbmQgdGhlIHBhdGNoLg0KDQpUaGFua3MsDQpBbnRob255DQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCbGFrZSBbbWFpbHRv
OmVibGFrZUByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDUsIDIwMTcgMTE6
NTAgQU0NCj4gVG86IFh1LCBBbnRob255IDxhbnRob255Lnh1QGludGVsLmNvbT47ICdxZW11LWRl
dmVsQG5vbmdudS5vcmcnDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBhbnRob255
LnBlcmFyZEBjaXRyaXguY29tOyAnUGFvbG8gQm9uemluaScgPHBib256aW5pQHJlZGhhdC5jb20+
Ow0KPiBzc3RhYmVsbGluaUBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0g
W1BBVENIIDEvM10gbW92ZSB4ZW4tY29tbW9uLmMgdG8gaHcveGVuLw0KPiANCj4gT24gMDQvMDUv
MjAxNyAwMTozOSBQTSwgWHUsIEFudGhvbnkgd3JvdGU6DQo+ID4gbW92ZSB4ZW4tY29tbW9uLmMg
dG8gaHcveGVuLw0KPiA+DQo+IA0KPiBZb3VyIG1lc3NhZ2UgZmFpbGVkIHRvIHNldCB0aGUgJ0lu
LVJlcGx5LVRvOicgaGVhZGVyLCBhbmQgd2FzIHRoZXJlZm9yZQ0KPiBub3QgdGhyZWFkZWQgdG8g
eW91ciAwLzMgY292ZXIgbGV0dGVyLiAgUGxlYXNlIHNlZSBpZiB5b3UgY2FuIGZpeCB0aGF0DQo+
IGJlZm9yZSBwb3N0aW5nIHlvdXIgbmV4dCBzZXJpZXMuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9m
ZiAtYnk6IEFudGhvbnkgWHUgPGFudGhvbnkueHVAaW50ZWwuY29tPg0KPiA+DQo+ID4NCj4gPg0K
PiA+IC0tLQ0KPiA+ICBody94ZW4veGVuLWNvbW1vbi5jIHwgMTU4DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgc3R1YnMveGVuLWNv
bW1vbi5jICB8ICAxNCArKysrKw0KPiA+ICB4ZW4tY29tbW9uLXN0dWIuYyAgIHwgIDE0IC0tLS0t
DQo+ID4gIHhlbi1jb21tb24uYyAgICAgICAgfCAxNTggLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE3MiBp
bnNlcnRpb25zKCspLCAxNzIgZGVsZXRpb25zKC0pDQo+IA0KPiBQbGVhc2UgcnVuICdnaXQgY29u
ZmlnIGRpZmYucmVuYW1lcyB0cnVlJyBzbyB0aGF0IHBhdGNoZXMgbGlrZSB0aGlzIHdpbGwNCj4g
YmUgYSBMT1Qgc21hbGxlciBvbiB0aGUgbWFpbGluZyBsaXN0LCBhbmQgd2lsbCBtb3JlIGVhc2ls
eSBmb2N1cyBvbiB0aGUNCj4gKGZldykgdGhpbmdzIHRoYXQgaGF2ZSB0byBjaGFuZ2UgZHVlIHRv
IHRoZSBuZXcgbmFtZSByYXRoZXIgdGhhbiBiZWluZyBhDQo+IGJ1bGsgZGVsZXRlL2luc2VydCBv
cGVyYXRpb24gdGhhdCBoaWRlcyB0aGUgY2hhbmdlcy4NCj4gDQo+IC0tDQo+IEVyaWMgQmxha2Ug
ICBlYmxha2UgcmVkaGF0IGNvbSAgICArMS05MTktMzAxLTMyNjYNCj4gTGlidmlydCB2aXJ0dWFs
aXphdGlvbiBsaWJyYXJ5IGh0dHA6Ly9saWJ2aXJ0Lm9yZw0KDQo=
