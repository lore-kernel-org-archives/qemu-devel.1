Received: from eggs.gnu.org ([2001:4830:134:3::10]:42036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e5MGl-0003N0-Fb
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e5MGh-0000aE-HW
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:38:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:53655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1e5MGh-0000Z5-6e
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:38:35 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Fri, 20 Oct 2017 01:38:27 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5D8657@SHSMSX103.ccr.corp.intel.com>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
	<f5ffd96f-8060-2c22-e6f9-49eab8cfe7c7@redhat.com>
In-Reply-To: <f5ffd96f-8060-2c22-e6f9-49eab8cfe7c7@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@gmail.com" <stefanha@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5
LCAyMDE3IDc6MzMgUE0NCj4gVG86IExpdSwgQ2hhbmdwZW5nIDxjaGFuZ3BlbmcubGl1QGludGVs
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogc3RlZmFuaGFAZ21haWwuY29tOyBt
c3RAcmVkaGF0LmNvbTsgbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tOw0KPiBmZWxpcGVAbnV0
YW5peC5jb207IEhhcnJpcywgSmFtZXMgUiA8amFtZXMuci5oYXJyaXNAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDIvNF0gdmhvc3QtdXNlci1ibGs6IGludHJvZHVjZSBhIG5l
dyB2aG9zdC11c2VyLWJsayBob3N0DQo+IGRldmljZQ0KPiANCj4gT24gMTkvMTAvMjAxNyAwNzoy
NCwgQ2hhbmdwZW5nIExpdSB3cm90ZToNCj4gPiAgICA7Ow0KPiA+ICAgIC0tZW5hYmxlLXZob3N0
LXNjc2kpIHZob3N0X3Njc2k9InllcyINCj4gPiAgICA7Ow0KPiA+ICsgIC0tZGlzYWJsZS12aG9z
dC11c2VyLWJsaykgdmhvc3RfdXNlcl9ibGs9Im5vIg0KPiA+ICsgIDs7DQo+ID4gKyAgLS1lbmFi
bGUtdmhvc3QtdXNlci1ibGspIHZob3N0X3VzZXJfYmxrPSJ5ZXMiDQo+ID4gKyAgOzsNCj4gPiAg
ICAtLWRpc2FibGUtdmhvc3QtdnNvY2spIHZob3N0X3Zzb2NrPSJubyINCj4gPiAgICA7Ow0KPiA+
ICAgIC0tZW5hYmxlLXZob3N0LXZzb2NrKSB2aG9zdF92c29jaz0ieWVzIg0KPiA+IEBAIC0xNTEx
LDYgKzE1MTcsNyBAQCBkaXNhYmxlZCB3aXRoIC0tZGlzYWJsZS1GRUFUVVJFLCBkZWZhdWx0IGlz
IGVuYWJsZWQgaWYNCj4gYXZhaWxhYmxlOg0KPiA+ICAgIGNhcC1uZyAgICAgICAgICBsaWJjYXAt
bmcgc3VwcG9ydA0KPiA+ICAgIGF0dHIgICAgICAgICAgICBhdHRyIGFuZCB4YXR0ciBzdXBwb3J0
DQo+ID4gICAgdmhvc3QtbmV0ICAgICAgIHZob3N0LW5ldCBhY2NlbGVyYXRpb24gc3VwcG9ydA0K
PiA+ICsgIHZob3N0LXVzZXItYmxrICBWTSB2aXJ0aW8tYmxrIGFjY2VsZXJhdGlvbiBpbiB1c2Vy
IHNwYWNlDQo+IA0KPiBQbGVhc2UgdXNlIGRlZmF1bHQtY29uZmlncyBpbnN0ZWFkIG9mIGEgbmV3
IGNvbmZpZ3VyZSBzd2l0Y2guICBTZWUgaG93DQo+IENPTkZJR19WSE9TVF9VU0VSX1NDU0kgaXMg
dXNlZCBpbiBkZWZhdWx0LWNvbmZpZ3MvcGNpLm1hayBhbmQNCj4gZGVmYXVsdC1jb25maWdzL3Mz
OTB4LXNvZnRtbXUubWFrLg0KT2ssIHRoYW5rcy4NCj4gDQo+ID4NCj4gPiArc3RhdGljIGNvbnN0
IGludCB1c2VyX2ZlYXR1cmVfYml0c1tdID0gew0KPiA+ICsgICAgVklSVElPX0JMS19GX1NJWkVf
TUFYLA0KPiA+ICsgICAgVklSVElPX0JMS19GX1NFR19NQVgsDQo+ID4gKyAgICBWSVJUSU9fQkxL
X0ZfR0VPTUVUUlksDQo+ID4gKyAgICBWSVJUSU9fQkxLX0ZfQkxLX1NJWkUsDQo+ID4gKyAgICBW
SVJUSU9fQkxLX0ZfVE9QT0xPR1ksDQo+ID4gKyAgICBWSVJUSU9fQkxLX0ZfU0NTSSwNCj4gDQo+
IFBsZWFzZSBvbWl0IFZJUlRJT19CTEtfRl9TQ1NJLCBpdCdzIGEgbGVnYWN5IG9wdGlvbiB0aGF0
IGlzIG5vdCBhbnltb3JlDQo+IHBhcnQgb2YgdmlydGlvIDEuMC4NCm9rDQo+IA0KPiA+ICsgICAg
VklSVElPX0JMS19GX01RLA0KPiA+ICsgICAgVklSVElPX0JMS19GX1JPLA0KPiA+ICsgICAgVklS
VElPX0JMS19GX0ZMVVNILA0KPiA+ICsgICAgVklSVElPX0JMS19GX0JBUlJJRVIsDQo+IA0KPiBT
YW1lIGZvciBWSVJUSU9fQkxLX0ZfQkFSUklFUi4NCj4gDQo+ID4gKyAgICBWSVJUSU9fQkxLX0Zf
V0NFLA0KPiANCj4gQW5kIFZJUlRJT19CTEtfRl9XQ0UgaXMgdGhlIHNhbWUgYXMgVklSVElPX0JM
S19GX0ZMVVNILCBzbyBpdCBjYW4gYmUNCj4gcmVtb3ZlZCB0b28uICBQbGVhc2UgaW5jbHVkZSBW
SVJUSU9fQkxLX0ZfQ09ORklHX1dDRSBpbnN0ZWFkLCBzaW5jZSB5b3UNCj4gYXJlIHN1cHBvcnRp
bmcgaXQgaW4gdmhvc3RfdXNlcl9ibGtfc2V0X2NvbmZpZy4NCk9rLg0KPiANCj4gPiArICAgIFZJ
UlRJT19GX1ZFUlNJT05fMSwNCj4gPiArICAgIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQywN
Cj4gPiArICAgIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYLA0KPiA+ICsgICAgVklSVElPX0ZfTk9U
SUZZX09OX0VNUFRZLA0KPiA+ICsgICAgVkhPU1RfSU5WQUxJRF9GRUFUVVJFX0JJVA0KPiA+ICt9
Ow0KPiANCj4gPg0KPiA+ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gdmhvc3RfdXNlcl9ibGtfaW5m
byA9IHsNCj4gPiArICAgIC5uYW1lID0gVFlQRV9WSE9TVF9VU0VSX0JMSywNCj4gPiArICAgIC5w
YXJlbnQgPSBUWVBFX1ZJUlRJT19ERVZJQ0UsDQo+ID4gKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNp
emVvZihWSG9zdFVzZXJCbGspLA0KPiA+ICsgICAgLmluc3RhbmNlX2luaXQgPSB2aG9zdF91c2Vy
X2Jsa19pbnN0YW5jZV9pbml0LA0KPiA+ICsgICAgLmNsYXNzX2luaXQgPSB2aG9zdF91c2VyX2Js
a19jbGFzc19pbml0LA0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+IFRoZXJlIGlzIHNvbWUgY29kZSBk
dXBsaWNhdGlvbiwgc28gbWF5YmUgaXQncyB3b3J0aCBpbnRyb2R1Y2luZyBhIGNvbW1vbg0KPiBz
dXBlcmNsYXNzIGxpa2UgVFlQRV9WSVJUSU9fU0NTSV9DT01NT04uICBJJ2xsIGxldCBvdGhlcnMg
Y29tbWVudCBvbg0KPiB3aGV0aGVyIHRoaXMgaXMgYSByZXF1aXJlbWVudC4NCj4gDQo+IFBhb2xv
DQo=
