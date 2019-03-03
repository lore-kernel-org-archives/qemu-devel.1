Received: from eggs.gnu.org ([209.51.188.92]:43541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0S1P-0005Ma-Bo
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0S1O-0003wr-JQ
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:23:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:2052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h0S1O-0003rH-Aj
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:23:18 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Sun, 3 Mar 2019 14:23:05 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806067D83@shsmsx102.ccr.corp.intel.com>
References: <20190228165508.21594-1-chen.zhang@intel.com>
	<20190228165508.21594-5-chen.zhang@intel.com>
	<8b4f2327-fc03-4cda-4b18-876c77339b5b@redhat.com>
In-Reply-To: <8b4f2327-fc03-4cda-4b18-876c77339b5b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V2 4/7] Migration/colo.c: Add new
 COLOExitReason to handle all failover state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRXJpYyBCbGFrZSBbbWFpbHRvOmVi
bGFrZUByZWRoYXQuY29tXSANClNlbnQ6IEZyaWRheSwgTWFyY2ggMSwgMjAxOSAxOjA1IEFNDQpU
bzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGNuLmZ1aml0c3UuY29tPjsgWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT47IERy
LiBEYXZpZCBBbGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+OyBKdWFuIFF1aW50ZWxh
IDxxdWludGVsYUByZWRoYXQuY29tPjsgemhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFu
Z0BodWF3ZWkuY29tPjsgTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPjsgcWVt
dS1kZXYgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgNC83
XSBNaWdyYXRpb24vY29sby5jOiBBZGQgbmV3IENPTE9FeGl0UmVhc29uIHRvIGhhbmRsZSBhbGwg
ZmFpbG92ZXIgc3RhdGUNCg0KT24gMi8yOC8xOSAxMDo1NSBBTSwgWmhhbmcgQ2hlbiB3cm90ZToN
Cj4gRnJvbTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+IA0KPiBJbiB0aGlz
IHBhdGNoIHdlIGFkZCB0aGUgcHJvY2Vzc2luZyBzdGF0ZSBmb3IgQ09MT0V4aXRSZWFzb24sIGJl
Y2F1c2UgDQo+IHdlIGhhdmUgdG8gaWRlbnRpZnkgQ09MTyBpbiB0aGUgZmFpbG92ZXIgcHJvY2Vz
c2luZyBzdGF0ZSBvciBmYWlsb3ZlciANCj4gZXJyb3Igc3RhdGUuIEluIHRoZSB3YXksIHdlIGNh
biBoYW5kbGUgYWxsIHRoZSBmYWlsb3ZlciBzdGF0ZS4NCj4gV2UgaGF2ZSBpbXByb3ZlZCB0aGUg
ZGVzY3JpcHRpb24gb2YgdGhlIENPTE9FeGl0UmVhc29uIGJ5IHRoZSB3YXkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gLS0tDQo+ICBt
aWdyYXRpb24vY29sby5jICAgIHwgMjQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICBxYXBp
L21pZ3JhdGlvbi5qc29uIHwgMTUgKysrKysrKysrLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCg0KPiArKysgYi9xYXBpL21p
Z3JhdGlvbi5qc29uDQo+IEBAIC05ODMsMTkgKzk4MywyMiBAQA0KPiAgIyMNCj4gICMgQENPTE9F
eGl0UmVhc29uOg0KPiAgIw0KPiAtIyBUaGUgcmVhc29uIGZvciBhIENPTE8gZXhpdA0KPiArIyBE
ZXNjcmliZSB0aGUgcmVhc29uIGZvciBDT0xPIGV4aXQuDQo+ICAjDQo+IC0jIEBub25lOiBubyBm
YWlsb3ZlciBoYXMgZXZlciBoYXBwZW5lZC4gVGhpcyBjYW4ndCBvY2N1ciBpbiB0aGUgLSMgDQo+
IENPTE9fRVhJVCBldmVudCwgb25seSBpbiB0aGUgcmVzdWx0IG9mIHF1ZXJ5LWNvbG8tc3RhdHVz
Lg0KPiArIyBAbm9uZTogZmFpbG92ZXIgaGFzIG5ldmVyIGhhcHBlbmVkLiBUaGlzIHN0YXRlIGRv
ZXMgbm90IG9jY3VycmVkICMgDQo+ICtpbiB0aGUgQ09MT19FWElUIGV2ZW50LCBvbmx5IGhhcHBl
bmVkIGluIHRoZSByZXN1bHQgb2YgIyANCj4gK3F1ZXJ5LWNvbG8tc3RhdHVzLg0KDQpHcmFtbWFy
IHN1Z2dlc3Rpb246DQoNClRoaXMgc3RhdGUgZG9lcyBub3Qgb2NjdXIgaW4gdGhlIENPTE9fRVhJ
VCBldmVudCwgYW5kIGlzIG9ubHkgdmlzaWJsZSBpbiB0aGUgcmVzdWx0IG9mIHF1ZXJ5LWNvbG8t
c3RhdHVzLg0KDQpPS34gSSB3aWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gICMNCj4g
LSMgQHJlcXVlc3Q6IENPTE8gZXhpdCBpcyBkdWUgdG8gYW4gZXh0ZXJuYWwgcmVxdWVzdA0KPiAr
IyBAcmVxdWVzdDogQ09MTyBleGl0IGNhdXNlZCBieSBhbiBleHRlcm5hbCByZXF1ZXN0Lg0KPiAg
Iw0KPiAtIyBAZXJyb3I6IENPTE8gZXhpdCBpcyBkdWUgdG8gYW4gaW50ZXJuYWwgZXJyb3INCj4g
KyMgQGVycm9yOiBDT0xPIGV4aXQgY2F1c2VkIGJ5IGFuIGludGVybmFsIGVycm9yLg0KPiArIw0K
PiArIyBAcHJvY2Vzc2luZzogQ09MTyBpbiBmYWlsb3ZlciBoYW5kbGluZyBzdGF0ZS4NCg0KTWlz
c2luZyBhIChzaW5jZSA0LjApIHRhZy4gIE1heWJlOg0KDQpAcHJvY2Vzc2luZzogQ09MTyBpcyBj
dXJyZW50bHkgaGFuZGxpbmcgYSBmYWlsb3ZlciAoc2luY2UgNC4wKS4NCg0KU3VyZSwgdGhhbmsg
eW91IGZvciB5b3VyIGNvbW1lbnRzfg0KDQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQotLQ0KRXJp
YyBCbGFrZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyDQpSZWQgSGF0LCBJbmMuICAgICAg
ICAgICArMS05MTktMzAxLTMyMjYNClZpcnR1YWxpemF0aW9uOiAgcWVtdS5vcmcgfCBsaWJ2aXJ0
Lm9yZw0K
