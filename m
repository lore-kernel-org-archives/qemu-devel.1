Received: from eggs.gnu.org ([209.51.188.92]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0191b4fb4=Alistair.Francis@wdc.com>)
	id 1hMMHN-00046r-ED
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0191b4fb4=Alistair.Francis@wdc.com>)
	id 1hMMHJ-0006zo-LI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:19 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 3 May 2019 00:42:04 +0000
Message-ID: <20190503004021.13814-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <75BE263937E2B44880102891AF9D9B29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v3] hw/usb/hcd-xhci: Fix GCC 9 build warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

Rml4IHRoaXMgYnVpbGQgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9o
Y2QteGhjaS5jOjMzMzk6NjY6IGVycm9yOiDigJglZOKAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBi
ZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5dGVzIGludG8gYSByZWdpb24g
b2Ygc2l6ZSA1IFstV2Vycm9yPWZvcm1hdC10cnVuY2F0aW9uPV0NCiAzMzM5IHwgICAgICAgICAg
ICAgc25wcmludGYocG9ydC0+bmFtZSwgc2l6ZW9mKHBvcnQtPm5hbWUpLCAidXNiMiBwb3J0ICMl
ZCIsIGkrMSk7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCmh3L3VzYi9oY2QteGhjaS5jOjMzMzk6NTQ6
IG5vdGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0aGUgcmFuZ2UgWzEsIDIxNDc0ODM2NDddDQog
MzMzOSB8ICAgICAgICAgICAgIHNucHJpbnRmKHBvcnQtPm5hbWUsIHNpemVvZihwb3J0LT5uYW1l
KSwgInVzYjIgcG9ydCAjJWQiLCBpKzEpOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdGRpby5oOjg2NywNCiAgICAgICAgICAgICAgICAg
ZnJvbSAvaG9tZS9hbGlzdGFpci9xZW11L2luY2x1ZGUvcWVtdS9vc2RlcC5oOjk5LA0KICAgICAg
ICAgICAgICAgICBmcm9tIGh3L3VzYi9oY2QteGhjaS5jOjIxOg0KL3Vzci9pbmNsdWRlL2JpdHMv
c3RkaW8yLmg6Njc6MTA6IG5vdGU6IOKAmF9fYnVpbHRpbl9fX3NucHJpbnRmX2Noa+KAmSBvdXRw
dXQgYmV0d2VlbiAxMyBhbmQgMjIgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgMTYN
CiAgIDY3IHwgICByZXR1cm4gX19idWlsdGluX19fc25wcmludGZfY2hrIChfX3MsIF9fbiwgX19V
U0VfRk9SVElGWV9MRVZFTCAtIDEsDQogICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KICAgNjggfCAgICAg
ICAgX19ib3MgKF9fcyksIF9fZm10LCBfX3ZhX2FyZ19wYWNrICgpKTsNCiAgICAgIHwgICAgICAg
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KUmV2aWV3ZWQtYnk6
IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NClJldmlld2VkLWJ5OiBEYW5pZWwg
UC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCi0tLQ0KVGhpcyBpcyB0aGUgb25s
IHBhdGNoIGxlZnQgaWYgbXkgb3JpZ2luYWwgc2VyaWVzICJGaXggc29tZSBHQ0MgOSBidWlsZA0K
d2FybmluZ3MiIHRoYXQgaGFzbid0IGVpdGhlciBiZWVuIGFjY2VwZXRlZCBpbnRvIGEgbWFpbnRh
aW5lcnMgdHJlZSBvcg0KZml4ZWQgYnkgc29tZW9uZSBlbHNlLg0KDQogaHcvdXNiL2hjZC14aGNp
LmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvaHcvdXNiL2hjZC14aGNpLmMgYi9ody91c2IvaGNkLXhoY2kuYw0KaW5kZXggZWMyOGJlZTMx
OS4uYTE1YjEwM2I2NSAxMDA2NDQNCi0tLSBhL2h3L3VzYi9oY2QteGhjaS5jDQorKysgYi9ody91
c2IvaGNkLXhoY2kuYw0KQEAgLTMzMjEsNiArMzMyMSw4IEBAIHN0YXRpYyB2b2lkIHVzYl94aGNp
X2luaXQoWEhDSVN0YXRlICp4aGNpKQ0KIA0KICAgICB1c2JfYnVzX25ldygmeGhjaS0+YnVzLCBz
aXplb2YoeGhjaS0+YnVzKSwgJnhoY2lfYnVzX29wcywgZGV2KTsNCiANCisgICAgZ19hc3NlcnQo
dXNicG9ydHMgPD0gTUFYKE1BWFBPUlRTXzIsIE1BWFBPUlRTXzMpKTsNCisNCiAgICAgZm9yIChp
ID0gMDsgaSA8IHVzYnBvcnRzOyBpKyspIHsNCiAgICAgICAgIHNwZWVkbWFzayA9IDA7DQogICAg
ICAgICBpZiAoaSA8IHhoY2ktPm51bXBvcnRzXzIpIHsNCi0tIA0KMi4yMS4wDQoNCg==
