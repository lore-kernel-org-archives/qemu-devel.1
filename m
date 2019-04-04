Received: from eggs.gnu.org ([209.51.188.92]:58578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBvoV-00029g-VH
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBvoS-0003Na-L6
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:25:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:63313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hBvoR-0003HM-MN
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:25:24 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Thu, 4 Apr 2019 06:25:15 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060B88A6@shsmsx102.ccr.corp.intel.com>
References: <20190329200445.28512-1-chen.zhang@intel.com>
	<CAFEAcA9PU4=C8yApkU8bRd2-rCHd2DqtnDv5v=pC5M+PK8rkMw@mail.gmail.com>
In-Reply-To: <CAFEAcA9PU4=C8yApkU8bRd2-rCHd2DqtnDv5v=pC5M+PK8rkMw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] bitops.h: Remove unused bitops function
 test_and_change_bit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-dev <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCBb
bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogVGh1cnNkYXksIEFwcmls
IDQsIDIwMTkgOTo0MyBBTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29t
Pg0KPiBDYzogRHIuIERhdmlkIEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRAcmVkaGF0LmNvbT47IHFl
bXUtZGV2IDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPjsgSm9obiBTbm93IDxqc25vd0ByZWRo
YXQuY29tPjsgRmFtIFpoZW5nDQo+IDxmYW1AZXVwaG9uLm5ldD4NCj4gU3ViamVjdDogUmU6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIGJpdG9wcy5oOiBSZW1vdmUgdW51c2VkIGJpdG9wcyBmdW5jdGlv
bg0KPiB0ZXN0X2FuZF9jaGFuZ2VfYml0KCkNCj4gDQo+IE9uIFNhdCwgMzAgTWFyIDIwMTkgYXQg
MDM6MDksIFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
IEZyb206IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gSW4gY3Vy
cmVudCBjb2RlcyB3ZSB1c2UgY2hhbmdlX2JpdCgpIHRvIGZpbmlzaCB0aGUgam9iLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGluY2x1ZGUvcWVtdS9iaXRtYXAuaCB8ICAxIC0NCj4gPiAgaW5jbHVkZS9xZW11
L2JpdG9wcy5oIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYg
ZGVsZXRpb25zKC0pDQo+IA0KPiBEbyB3ZSBnYWluIGFueXRoaW5nIGJ5IHJlbW92aW5nIHRoaXMg
ZnVuY3Rpb24/IElJUkMgdGhlc2UgZnVuY3Rpb25zIGFyZSBhbGwNCj4gYm9ycm93ZWQgZnJvbSB0
aGUgTGludXgga2VybmVsLCBzbyBrZWVwaW5nIHRoZSBzYW1lIEFQSSBhcyB0aGUga2VybmVsIGRv
ZXMNCj4gd291bGQgbWFrZSBzZW5zZSB0byBtZSwgZXZlbiBpZiB3ZSBoYXBwZW4gbm90IHRvIHVz
ZSBhbGwgb2YgaXQgcmlnaHQgbm93Lg0KPiANCg0KSGkgUGV0ZXIsDQoNCk9LLCBJIGFncmVlIHdp
dGggeW91Lg0KQnV0IGFub3RoZXIgcXVlc3Rpb24gYXJlIHRoZSBiaXRtYXAuaCBhbmQgYml0b3Bz
LmggbGFjayBvZiBtYWludGVuYW5jZS4NClBsZWFzZSBsb29rIGF0IHRoaXMgcGF0Y2g6DQpbUEFU
Q0hdIE1BSU5UQUlORVJTOiBBZGQgdW5tYWludGFpbmVkIGJpdG1hcCBmaWxlIHRvIHJlbGF0ZWQg
ZmllbGQNCg0KRG8geW91IGhhdmUgYW55IGNvbW1lbnRzPw0KDQpUaGFua3MNClpoYW5nIENoZW4N
Cg0KPiB0aGFua3MNCj4gLS0gUE1NDQo=
