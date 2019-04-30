Received: from eggs.gnu.org ([209.51.188.92]:49225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ44-0002Sc-PH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ43-00077P-U1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:20 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 20:09:13 +0000
Message-ID: <f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFE9768B5F3E374CBD5CE5ABF90D21D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build warning
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
LmMNCmluZGV4IDk5NTQ4YjAxMmQuLjZkZTg1ZDk5ZTYgMTAwNjQ0DQotLS0gYS9ody91c2IvZGV2
LW10cC5jDQorKysgYi9ody91c2IvZGV2LW10cC5jDQpAQCAtMTcxMSw5ICsxNzExLDIyIEBAIHN0
YXRpYyB2b2lkIHVzYl9tdHBfd3JpdGVfbWV0YWRhdGEoTVRQU3RhdGUgKnMsIHVpbnQ2NF90IGRs
ZW4pDQogICAgIGFzc2VydCghcy0+d3JpdGVfcGVuZGluZyk7DQogICAgIGFzc2VydChwICE9IE5V
TEwpOw0KIA0KKy8qDQorICogV2UgYXJlIGFib3V0IHRvIGFjY2VzcyBhIHBhY2tlZCBzdHJ1Y3Qu
IFdlIGFyZSBjb25maWRlbnQgdGhhdCB0aGUgcG9pbnRlcg0KKyAqIGFkZHJlc3Mgd29uJ3QgYmUg
dW5hbGxpZ25lZCwgc28gd2UgaWdub3JlIEdDQyB3YXJuaW5ncy4NCisgKi8NCisjaWYgZGVmaW5l
ZChDT05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFKSAmJiBRRU1VX0dOVUNfUFJFUkVR
KDksIDApDQorI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwdXNoDQorI3ByYWdtYSBHQ0MgZGlhZ25v
c3RpYyBpZ25vcmVkICItV2FkZHJlc3Mtb2YtcGFja2VkLW1lbWJlciINCisjZW5kaWYNCisNCiAg
ICAgZmlsZW5hbWUgPSB1dGYxNl90b19zdHIoTUlOKGRhdGFzZXQtPmxlbmd0aCwgZmlsZW5hbWVf
Y2hhcnMpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhc2V0LT5maWxlbmFtZSk7
DQogDQorI2lmIGRlZmluZWQoQ09ORklHX1BSQUdNQV9ESUFHTk9TVElDX0FWQUlMQUJMRSkgJiYg
UUVNVV9HTlVDX1BSRVJFUSg5LCAwKQ0KKyNwcmFnbWEgR0NDIGRpYWdub3N0aWMgcG9wDQorI2Vu
ZGlmDQorDQogICAgIGlmIChzdHJjaHIoZmlsZW5hbWUsICcvJykpIHsNCiAgICAgICAgIHVzYl9t
dHBfcXVldWVfcmVzdWx0KHMsIFJFU19QQVJBTUVURVJfTk9UX1NVUFBPUlRFRCwgZC0+dHJhbnMs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwKTsNCi0tIA0KMi4yMS4w
DQoNCg==
