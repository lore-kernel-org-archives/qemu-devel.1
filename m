Received: from eggs.gnu.org ([209.51.188.92]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=990829437=Alistair.Francis@wdc.com>)
	id 1hC71q-000211-G2
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=990829437=Alistair.Francis@wdc.com>)
	id 1hC6tv-0007yD-Nw
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:15:48 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 4 Apr 2019 18:15:34 +0000
Message-ID: <5a5be6c3ae42d8c585f221eb60995310ffee4103.1554401615.git.alistair.francis@wdc.com>
References: <cover.1554401615.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554401615.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH for 4.0 v3 2/2] riscv: plic: Log guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "palmer@sifive.com" <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

SW5zdGVhZCBvZiB1c2luZyBlcnJvcl9yZXBvcnQoKSB0byBwcmludCBndWVzdCBlcnJvcnMgbGV0
J3MgdXNlDQpxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwuLi4pIHRvIGxvZyB0aGUgZXJy
b3IuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbT4NCi0tLQ0KIGh3L3Jpc2N2L3NpZml2ZV9wbGljLmMgfCAxMiArKysrKysrKystLS0N
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvcmlzY3Yvc2lmaXZlX3BsaWMuYyBiL2h3L3Jpc2N2L3NpZml2ZV9wbGljLmMN
CmluZGV4IDAzMTVlMDM1ZTUuLjA3YTAzMmQ5M2QgMTAwNjQ0DQotLS0gYS9ody9yaXNjdi9zaWZp
dmVfcGxpYy5jDQorKysgYi9ody9yaXNjdi9zaWZpdmVfcGxpYy5jDQpAQCAtMjYzLDcgKzI2Myw5
IEBAIHN0YXRpYyB1aW50NjRfdCBzaWZpdmVfcGxpY19yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRy
IGFkZHIsIHVuc2lnbmVkIHNpemUpDQogICAgIH0NCiANCiBlcnI6DQotICAgIGVycm9yX3JlcG9y
dCgicGxpYzogaW52YWxpZCByZWdpc3RlciByZWFkOiAlMDh4IiwgKHVpbnQzMl90KWFkZHIpOw0K
KyAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCisgICAgICAgICAgICAgICAgICAi
JXM6IEludmFsaWQgcmVnaXN0ZXIgcmVhZCAweCUiIEhXQUREUl9QUkl4ICJcbiIsDQorICAgICAg
ICAgICAgICAgICAgX19mdW5jX18sIGFkZHIpOw0KICAgICByZXR1cm4gMDsNCiB9DQogDQpAQCAt
MjkwLDcgKzI5Miw5IEBAIHN0YXRpYyB2b2lkIHNpZml2ZV9wbGljX3dyaXRlKHZvaWQgKm9wYXF1
ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHZhbHVlLA0KICAgICB9IGVsc2UgaWYgKGFkZHIgPj0g
cGxpYy0+cGVuZGluZ19iYXNlICYmIC8qIDEgYml0IHBlciBzb3VyY2UgKi8NCiAgICAgICAgICAg
ICAgICBhZGRyIDwgcGxpYy0+cGVuZGluZ19iYXNlICsgKHBsaWMtPm51bV9zb3VyY2VzID4+IDMp
KQ0KICAgICB7DQotICAgICAgICBlcnJvcl9yZXBvcnQoInBsaWM6IGludmFsaWQgcGVuZGluZyB3
cml0ZTogJTA4eCIsICh1aW50MzJfdClhZGRyKTsNCisgICAgICAgIHFlbXVfbG9nX21hc2soTE9H
X0dVRVNUX0VSUk9SLA0KKyAgICAgICAgICAgICAgICAgICAgICAiJXM6IGludmFsaWQgcGVuZGlu
ZyB3cml0ZTogMHglIiBIV0FERFJfUFJJeCAiIiwNCisgICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18sIGFkZHIpOw0KICAgICAgICAgcmV0dXJuOw0KICAgICB9IGVsc2UgaWYgKGFkZHIgPj0g
cGxpYy0+ZW5hYmxlX2Jhc2UgJiYgLyogMSBiaXQgcGVyIHNvdXJjZSAqLw0KICAgICAgICAgYWRk
ciA8IHBsaWMtPmVuYWJsZV9iYXNlICsgcGxpYy0+bnVtX2FkZHJzICogcGxpYy0+ZW5hYmxlX3N0
cmlkZSkNCkBAIC0zNDAsNyArMzQ0LDkgQEAgc3RhdGljIHZvaWQgc2lmaXZlX3BsaWNfd3JpdGUo
dm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdWludDY0X3QgdmFsdWUsDQogICAgIH0NCiANCiBl
cnI6DQotICAgIGVycm9yX3JlcG9ydCgicGxpYzogaW52YWxpZCByZWdpc3RlciB3cml0ZTogJTA4
eCIsICh1aW50MzJfdClhZGRyKTsNCisgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1Is
DQorICAgICAgICAgICAgICAgICAgIiVzOiBJbnZhbGlkIHJlZ2lzdGVyIHdyaXRlIDB4JSIgSFdB
RERSX1BSSXggIlxuIiwNCisgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYWRkcik7DQogfQ0K
IA0KIHN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgc2lmaXZlX3BsaWNfb3BzID0gew0KLS0g
DQoyLjIxLjANCg0K
