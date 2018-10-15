Received: from eggs.gnu.org ([2001:4830:134:3::10]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Stewart.Hildebrand@dornerworks.com>)
	id 1gCAO0-0002WD-SS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Stewart.Hildebrand@dornerworks.com>)
	id 1gCAO0-0001Ct-07
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:26:48 -0400
From: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>
Date: Mon, 15 Oct 2018 21:26:39 +0000
Message-ID: <40eb19fb56b24e10a5eaa99ccb78aff6@dornerworks.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] hw/arm/boot: Increase compliance with kernel
 arm64 boot protocol.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Peter Maydell <peter.maydell@linaro.org>, Julien Grall <julien.grall@arm.com>

IlRoZSBJbWFnZSBtdXN0IGJlIHBsYWNlZCB0ZXh0X29mZnNldCBieXRlcyBmcm9tIGEgMk1CIGFs
aWduZWQgYmFzZQ0KYWRkcmVzcyBhbnl3aGVyZSBpbiB1c2FibGUgc3lzdGVtIFJBTSBhbmQgY2Fs
bGVkIHRoZXJlLiINCg0KRm9yIHRoZSB2aXJ0IGJvYXJkLCB3ZSB3cml0ZSBvdXIgc3RhcnR1cCBi
b290bG9hZGVyIGF0IHRoZSB2ZXJ5DQpib3R0b20gb2YgUkFNLCBzbyB0aGF0IGJpdCBjYW4ndCBi
ZSB1c2VkIGZvciB0aGUgaW1hZ2UuIFRvIGF2b2lkDQpvdmVybGFwIGluIGNhc2UgdGhlIGltYWdl
IHJlcXVlc3RzIHRvIGJlIGxvYWRlZCBhdCBhbiBvZmZzZXQNCnNtYWxsZXIgdGhhbiBvdXIgYm9v
dGxvYWRlciwgd2UgaW5jcmVtZW50IHRoZSBsb2FkIG9mZnNldCB0byB0aGUNCm5leHQgMk1CLg0K
DQpUaGlzIGZpeGVzIGEgYm9vdCBmYWlsdXJlIGZvciBYZW4gQUFyY2g2NC4NCg0KU2lnbmVkLW9m
Zi1ieTogU3Rld2FydCBIaWxkZWJyYW5kIDxzdGV3YXJ0LmhpbGRlYnJhbmRAZG9ybmVyd29ya3Mu
Y29tPg0KLS0tDQogaHcvYXJtL2Jvb3QuYyB8IDEwICsrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvYXJtL2Jvb3QuYyBiL2h3L2Fy
bS9ib290LmMNCmluZGV4IDIwYzcxZDdkOTYuLjU1OWRkYmNkNTMgMTAwNjQ0DQotLS0gYS9ody9h
cm0vYm9vdC5jDQorKysgYi9ody9hcm0vYm9vdC5jDQpAQCAtOTE5LDYgKzkxOSwxNiBAQCBzdGF0
aWMgdWludDY0X3QgbG9hZF9hYXJjaDY0X2ltYWdlKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBod2Fk
ZHIgbWVtX2Jhc2UsDQogICAgICAgICBtZW1jcHkoJmhkcnZhbHMsIGJ1ZmZlciArIEFSTTY0X1RF
WFRfT0ZGU0VUX09GRlNFVCwgc2l6ZW9mKGhkcnZhbHMpKTsNCiAgICAgICAgIGlmIChoZHJ2YWxz
WzFdICE9IDApIHsNCiAgICAgICAgICAgICBrZXJuZWxfbG9hZF9vZmZzZXQgPSBsZTY0X3RvX2Nw
dShoZHJ2YWxzWzBdKTsNCisNCisgICAgICAgICAgICAvKiBGb3IgdGhlIHZpcnQgYm9hcmQsIHdl
IHdyaXRlIG91ciBzdGFydHVwICJib290bG9hZGVyIiBhdCB0aGUgdmVyeQ0KKyAgICAgICAgICAg
ICAqIGJvdHRvbSBvZiBSQU0sIHNvIHRoYXQgYml0IGNhbid0IGJlIHVzZWQgZm9yIHRoZSBpbWFn
ZS4gVG8gYXZvaWQNCisgICAgICAgICAgICAgKiBvdmVybGFwIGluIGNhc2UgdGhlIGltYWdlIHJl
cXVlc3RzIHRvIGJlIGxvYWRlZCBhdCBhbiBvZmZzZXQNCisgICAgICAgICAgICAgKiBzbWFsbGVy
IHRoYW4gb3VyIGJvb3Rsb2FkZXIsIHdlIGluY3JlbWVudCB0aGUgbG9hZCBvZmZzZXQgdG8gdGhl
DQorICAgICAgICAgICAgICogbmV4dCAyTUIuDQorICAgICAgICAgICAgICovDQorICAgICAgICAg
ICAgaWYgKGtlcm5lbF9sb2FkX29mZnNldCA8IEZJWFVQX01BWCkgew0KKyAgICAgICAgICAgICAg
ICBrZXJuZWxfbG9hZF9vZmZzZXQgKz0gMiA8PCAyMDsNCisgICAgICAgICAgICB9DQogICAgICAg
ICB9DQogICAgIH0NCiANCi0tIA0KMi4xNy4xDQo=
