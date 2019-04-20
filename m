Received: from eggs.gnu.org ([209.51.188.92]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfl5-0008Mh-Eo
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfl4-0004sK-Hh
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:29:39 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:24:18 +0000
Message-ID: <e327e7d2a5e0fd44b6f81c454fc830b18daa9365.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 5/6] target/riscv: Deprecate the generic no
 MMU CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "palmer@sifive.com" <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "imammedo@redhat.com" <imammedo@redhat.com>

VGhlc2UgY2FuIG5vdyBiZSBzcGVjaWZpZWQgdmlhIHRoZSBjb21tYW5kIGxpbmUgc28gd2Ugbm8g
bG9uZ2VyIG5lZWQNCnRoZXNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiBxZW11LWRlcHJlY2F0ZWQudGV4aSB8IDYg
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
cWVtdS1kZXByZWNhdGVkLnRleGkgYi9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KaW5kZXggOTJjZTkw
OWU1MC4uZDAxZmRmOTkwNyAxMDA2NDQNCi0tLSBhL3FlbXUtZGVwcmVjYXRlZC50ZXhpDQorKysg
Yi9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KQEAgLTEzNyw2ICsxMzcsMTIgQEAgZm91ciBDUFVzIGFy
ZTogYGBydjMyZ2NzdS12MS45LjFgYCwgYGBydjMyZ2NzdS12MS4xMC4wYGAsIGBgcnY2NGdjc3Ut
djEuOS4xYGAgYW4NCiBgYHJ2NjRnY3N1LXYxLjEwLjBgYC4gSW5zdGVhZCB0aGUgdmVyc2lvbiBj
YW4gYmUgc3BlY2lmaWVkIHZpYSB0aGUgQ1BVIGBgcHJpdl9zcGVjYGANCiBvcHRpb24gd2hlbiB1
c2luZyB0aGUgYGBydjMyYGAgb3IgYGBydjY0YGAgQ1BVcy4NCiANCitAc3Vic2VjdGlvbiBSSVND
LVYgSVNBIENQVXMgKHNpbmNlIDQuMSkNCisNCitUaGUgUklTQy1WIG5vIE1NVSBjcHVzIGhhdmUg
YmVlbiBkZXBjcmVhdGVkLiBUaGUgdHdvIENQVXM6IGBgcnYzMmltYWN1LW5vbW11YGAgYW5kDQor
YGBydjY0aW1hY3Utbm9tbXVgYCBzaG91bGQgbm8gbG9uZ2VyIGJlIHVzZWQuIEluc3RlYWQgdGhl
IE1NVSBzdGF0dXMgY2FuIGJlIHNwZWNpZmllZA0KK3ZpYSB0aGUgQ1BVIGBgbW11YGAgb3B0aW9u
IHdoZW4gdXNpbmcgdGhlIGBgcnYzMmBgIG9yIGBgcnY2NGBgIENQVXMuDQorDQogQHNlY3Rpb24g
U3lzdGVtIGVtdWxhdG9yIGRldmljZXMNCiANCiBAc3Vic2VjdGlvbiBibHVldG9vdGggKHNpbmNl
IDMuMSkNCi0tIA0KMi4yMS4wDQoNCg==
