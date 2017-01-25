Received: from eggs.gnu.org ([2001:4830:134:3::10]:34297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cWHD5-0008DD-2d
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 01:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cWHD1-00019U-VU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 01:37:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:7279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cWHD1-00017o-LC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 01:37:31 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 25 Jan 2017 06:37:23 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C1BA0F@SHSMSX101.ccr.corp.intel.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-17-git-send-email-peterx@redhat.com>
	<d04e7a7e-1d30-69ec-4902-7b5a5cfba02e@redhat.com>
	<20170124045242.GM26526@pxdev.xzpeter.org>
	<db3cf882-5825-5bc5-f097-ea65298917a0@redhat.com>
	<20170125034623.GA5151@pxdev.xzpeter.org>
In-Reply-To: <20170125034623.GA5151@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v4 16/20] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMjUsIDIwMTcgMTE6NDYgQU0NCj4gDQo+IE9uIFdlZCwgSmFuIDI1LCAy
MDE3IGF0IDExOjA5OjM5QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+ID4NCj4gPg0KPiA+
IE9uIDIwMTflubQwMeaciDI05pelIDEyOjUyLCBQZXRlciBYdSB3cm90ZToNCj4gPiA+T24gTW9u
LCBKYW4gMjMsIDIwMTcgYXQgMDY6MzY6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToNCj4g
PiA+Pg0KPiA+ID4+T24gMjAxN+W5tDAx5pyIMjDml6UgMjE6MDgsIFBldGVyIFh1IHdyb3RlOg0K
PiA+ID4+PkJlZm9yZSB0aGlzIG9uZSB3ZSBvbmx5IGludmFsaWRhdGUgY29udGV4dCBjYWNoZSB3
aGVuIHdlIHJlY2VpdmUgY29udGV4dA0KPiA+ID4+PmVudHJ5IGludmFsaWRhdGlvbnMuIEhvd2V2
ZXIgaXQncyBwb3NzaWJsZSB0aGF0IHRoZSBpbnZhbGlkYXRpb24gYWxzbw0KPiA+ID4+PmNvbnRh
aW5zIGEgZG9tYWluIHN3aXRjaCAob25seSBpZiBjYWNoZS1tb2RlIGlzIGVuYWJsZWQgZm9yIHZJ
T01NVSkuIEluDQo+ID4gPj4+dGhhdCBjYXNlIHdlIG5lZWQgdG8gbm90aWZ5IGFsbCB0aGUgcmVn
aXN0ZXJlZCBjb21wb25lbnRzIGFib3V0IHRoZSBuZXcNCj4gPiA+Pj5tYXBwaW5nLg0KPiA+ID4+
Pg0KPiA+ID4+PlNpZ25lZC1vZmYtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4g
PiA+Pj4tLS0NCj4gPiA+Pj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDEwICsrKysrKysrKysN
Cj4gPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gPj4+DQo+ID4g
Pj4+ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPiA+ID4+PmluZGV4IGY5YzUxNDIuLjRiMDhiNGQgMTAwNjQ0DQo+ID4gPj4+LS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPj4+KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+ID4gPj4+QEAgLTExNDYsNiArMTE0NiwxNiBAQCBzdGF0aWMgdm9pZA0KPiB2dGRfY29udGV4
dF9kZXZpY2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+ID4gPj4+ICAgICAgICAg
ICAgICAgICAgdHJhY2VfdnRkX2ludl9kZXNjX2NjX2RldmljZShidXNfbiwgVlREX1BDSV9TTE9U
KGRldmZuX2l0KSwNCj4gPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFZURF9QQ0lfRlVOQyhkZXZmbl9pdCkpOw0KPiA+ID4+PiAgICAgICAgICAgICAg
ICAgIHZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9lbnRyeS5jb250ZXh0X2NhY2hlX2dlbiA9IDA7DQo+
ID4gPj4+KyAgICAgICAgICAgICAgICAvKg0KPiA+ID4+PisgICAgICAgICAgICAgICAgICogU28g
YSBkZXZpY2UgaXMgbW92aW5nIG91dCBvZiAob3IgbW92aW5nIGludG8pIGENCj4gPiA+Pj4rICAg
ICAgICAgICAgICAgICAqIGRvbWFpbiwgYSByZXBsYXkoKSBzdWl0ZXMgaGVyZSB0byBub3RpZnkg
YWxsIHRoZQ0KPiA+ID4+PisgICAgICAgICAgICAgICAgICogSU9NTVVfTk9USUZJRVJfTUFQIHJl
Z2lzdGVycyBhYm91dCB0aGlzIGNoYW5nZS4NCj4gPiA+Pj4rICAgICAgICAgICAgICAgICAqIFRo
aXMgd29uJ3QgYnJpbmcgYmFkIGV2ZW4gaWYgd2UgaGF2ZSBubyBzdWNoDQo+ID4gPj4+KyAgICAg
ICAgICAgICAgICAgKiBub3RpZmllciByZWdpc3RlcmVkIC0gdGhlIElPTU1VIG5vdGlmaWNhdGlv
bg0KPiA+ID4+PisgICAgICAgICAgICAgICAgICogZnJhbWV3b3JrIHdpbGwgc2tpcCBNQVAgbm90
aWZpY2F0aW9ucyBpZiB0aGF0DQo+ID4gPj4+KyAgICAgICAgICAgICAgICAgKiBoYXBwZW5lZC4N
Cj4gPiA+Pj4rICAgICAgICAgICAgICAgICAqLw0KPiA+ID4+PisgICAgICAgICAgICAgICAgbWVt
b3J5X3JlZ2lvbl9pb21tdV9yZXBsYXlfYWxsKCZ2dGRfYXMtPmlvbW11KTsNCj4gPiA+PkRTSSBh
bmQgR0xPQkFMIHF1ZXN0aW9ucyBjb21lIGJhY2sgYWdhaW4gb3Igbm8gbmVlZCB0byBjYXJlIGFi
b3V0IHRoZW0gOikgPw0KPiA+ID5EU0kvR0xPQkFMIGhhbmxkaW5ncyBhcmUgaW4gcGF0Y2ggMjAg
KHRob3VnaCBpdCdsbCBiZSBzcXVhc2hlZCBpbnRvIDE4DQo+ID4gPmluIG15IG5leHQgcG9zdCku
IElzIHRoYXQgd2hhdCB5b3UgbWVhbiBhYm92ZT8NCj4gPg0KPiA+IFNlZW1zIG5vdCwgSSBtZWFu
IERTSS9HTE9CQUwgZm9yIGNvbnRleHQgY2FjaGUgaW52YWxpZGF0aW9uIGluc3RlYWQgb2YgSU9U
TEINCj4gPiA6KQ0KPiANCj4gWWVzLCBJIHNob3VsZCBwb3NzaWJseSBkbyB0aGUgc2FtZSB0aGlu
ZyBmb3IgY29udGV4dCBjYWNoZSBnbG9iYWwNCj4gaW52YWxpZGF0aW9ucy4gSUlVQyBjb250ZXh0
IGdsb2JhbCBpbnZhbGlkYXRpb24gc2hvdWxkIGJlIGEgc3VwZXJzZXQNCj4gb2YgaW90bGIgaW52
YWxpZGF0aW9uLCBzbyBtYXliZSBJJ2xsIGFkZCBvbmUgbW9yZSBwYXRjaCB0byBjYWxsIGlvdGxi
DQo+IGludmFsaWRhdGlvbiBpbiBjb250ZXh0IGludmFsaWRhdGlvbiBhcyB3ZWxsLiBLZXZpbi9v
dGhlcnMsIHBsZWFzZQ0KPiBjb3JyZWN0IG1lIGlmIEkgbWlzdW5kZXJzdG9vZCB0aGUgc3BlYy4g
VGhhbmtzLA0KPiANCg0KY29udGV4dCBpbnZhbGlkYXRpb24gaXMgbm90IHN1cGVyc2V0IG9mIGlv
dGxiIGludmFsaWRhdGlvbi4gVGhlIHNwZWMganVzdA0KcmVxdWlyZXMgc29mdHdhcmUgdG8gYWx3
YXlzIGZvbGxvdyBhIGNvbnRleHQtY2FjaGUgaW52YWxpZGF0aW9uIHdpdGgNCmEgUEFTSUQtY2Fj
aGUgaW52YWxpZGF0aW9uLCBmb2xsb3dlZCBieSBhbiBJT1RMQiBpbnZhbGlkYXRpb24uDQoNClRo
YW5rcw0KS2V2aW4NCg==
