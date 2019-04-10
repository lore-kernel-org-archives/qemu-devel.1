Received: from eggs.gnu.org ([209.51.188.92]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMVA-0007i8-DC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNq-0001iE-Th
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:12:01 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 10 Apr 2019 23:10:42 +0000
Message-ID: <a832ae5e252c58c1ac4dd99d7d164fdb0de70f10.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH for 4.1 v3 4/6] riscv: virt: Allow specifying a
 CPU via commandline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "palmer@sifive.com" <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "ijc@hellion.org.uk" <ijc@hellion.org.uk>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogaHcvcmlzY3YvdmlydC5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMg
Yi9ody9yaXNjdi92aXJ0LmMNCmluZGV4IGZjNGM2YjMwNmUuLjViMjVmMDI4YWQgMTAwNjQ0DQot
LS0gYS9ody9yaXNjdi92aXJ0LmMNCisrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KQEAgLTQwMCw3ICs0
MDAsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl92aXJ0X2JvYXJkX2luaXQoTWFjaGluZVN0YXRlICpt
YWNoaW5lKQ0KICAgICAvKiBJbml0aWFsaXplIFNPQyAqLw0KICAgICBvYmplY3RfaW5pdGlhbGl6
ZV9jaGlsZChPQkpFQ1QobWFjaGluZSksICJzb2MiLCAmcy0+c29jLCBzaXplb2Yocy0+c29jKSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9SSVNDVl9IQVJUX0FSUkFZLCAmZXJy
b3JfYWJvcnQsIE5VTEwpOw0KLSAgICBvYmplY3RfcHJvcGVydHlfc2V0X3N0cihPQkpFQ1QoJnMt
PnNvYyksIFZJUlRfQ1BVLCAiY3B1LXR5cGUiLA0KKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X3N0
cihPQkpFQ1QoJnMtPnNvYyksIG1hY2hpbmUtPmNwdV90eXBlLCAiY3B1LXR5cGUiLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KICAgICBvYmplY3RfcHJvcGVy
dHlfc2V0X2ludChPQkpFQ1QoJnMtPnNvYyksIHNtcF9jcHVzLCAibnVtLWhhcnRzIiwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCkBAIC01MjYsNiArNTI2LDcg
QEAgc3RhdGljIHZvaWQgcmlzY3ZfdmlydF9ib2FyZF9tYWNoaW5lX2luaXQoTWFjaGluZUNsYXNz
ICptYykNCiAgICAgbWMtPmRlc2MgPSAiUklTQy1WIFZpcnRJTyBCb2FyZCAoUHJpdmlsZWdlZCBJ
U0EgdjEuMTApIjsNCiAgICAgbWMtPmluaXQgPSByaXNjdl92aXJ0X2JvYXJkX2luaXQ7DQogICAg
IG1jLT5tYXhfY3B1cyA9IDg7IC8qIGhhcmRjb2RlZCBsaW1pdCBpbiBCQkwgKi8NCisgICAgbWMt
PmRlZmF1bHRfY3B1X3R5cGUgPSBWSVJUX0NQVTsNCiB9DQogDQogREVGSU5FX01BQ0hJTkUoInZp
cnQiLCByaXNjdl92aXJ0X2JvYXJkX21hY2hpbmVfaW5pdCkNCi0tIA0KMi4yMS4wDQoNCg==
