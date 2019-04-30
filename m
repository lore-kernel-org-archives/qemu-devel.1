Received: from eggs.gnu.org ([209.51.188.92]:36226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGK-0007aV-Q8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGJ-0000IX-QC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:12 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 23:28:41 +0000
Message-ID: <aeb0e851e027a591eaba99c175011158b1012876.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9ADAB462B3E164EAF1B1DA248BF794D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 3/5] hw/usb/dev-mtp: Fix GCC 9 build warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Rml4IHRoaXMgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9kZXYtbXRw
LmM6MTcxNTozNjogZXJyb3I6IHRha2luZyBhZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgb2Yg4oCY
c3RydWN0IDxhbm9ueW1vdXM+4oCZIG1heSByZXN1bHQgaW4gYW4gdW5hbGlnbmVkIHBvaW50ZXIg
dmFsdWUgWy1XZXJyb3I9YWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyXQ0KIDE3MTUgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGF0YXNldC0+ZmlsZW5hbWUpOw0KICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fl5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogaHcvdXNi
L2Rldi1tdHAuYyB8IDEzICsrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvdXNiL2Rldi1tdHAuYyBiL2h3L3VzYi9kZXYtbXRw
LmMNCmluZGV4IDk5NTQ4YjAxMmQuLjgyMzNiZWFjYWIgMTAwNjQ0DQotLS0gYS9ody91c2IvZGV2
LW10cC5jDQorKysgYi9ody91c2IvZGV2LW10cC5jDQpAQCAtMTcxMSw5ICsxNzExLDIyIEBAIHN0
YXRpYyB2b2lkIHVzYl9tdHBfd3JpdGVfbWV0YWRhdGEoTVRQU3RhdGUgKnMsIHVpbnQ2NF90IGRs
ZW4pDQogICAgIGFzc2VydCghcy0+d3JpdGVfcGVuZGluZyk7DQogICAgIGFzc2VydChwICE9IE5V
TEwpOw0KIA0KKy8qDQorICogV2UgYXJlIGFib3V0IHRvIGFjY2VzcyBhIHBhY2tlZCBzdHJ1Y3Qu
IFdlIGFyZSBjb25maWRlbnQgdGhhdCB0aGUgcG9pbnRlcg0KKyAqIGFkZHJlc3Mgd29uJ3QgYmUg
dW5hbGlnbmVkLCBzbyB3ZSBpZ25vcmUgR0NDIHdhcm5pbmdzLg0KKyAqLw0KKyNpZiBkZWZpbmVk
KENPTkZJR19QUkFHTUFfRElBR05PU1RJQ19BVkFJTEFCTEUpICYmIFFFTVVfR05VQ19QUkVSRVEo
OSwgMCkNCisjcHJhZ21hIEdDQyBkaWFnbm9zdGljIHB1c2gNCisjcHJhZ21hIEdDQyBkaWFnbm9z
dGljIGlnbm9yZWQgIi1XYWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyIg0KKyNlbmRpZg0KKw0KICAg
ICBmaWxlbmFtZSA9IHV0ZjE2X3RvX3N0cihNSU4oZGF0YXNldC0+bGVuZ3RoLCBmaWxlbmFtZV9j
aGFycyksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFzZXQtPmZpbGVuYW1lKTsN
CiANCisjaWYgZGVmaW5lZChDT05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFKSAmJiBR
RU1VX0dOVUNfUFJFUkVRKDksIDApDQorI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwb3ANCisjZW5k
aWYNCisNCiAgICAgaWYgKHN0cmNocihmaWxlbmFtZSwgJy8nKSkgew0KICAgICAgICAgdXNiX210
cF9xdWV1ZV9yZXN1bHQocywgUkVTX1BBUkFNRVRFUl9OT1RfU1VQUE9SVEVELCBkLT50cmFucywN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIDAsIDAsIDApOw0KLS0gDQoyLjIxLjAN
Cg0K
