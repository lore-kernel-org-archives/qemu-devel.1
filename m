Received: from eggs.gnu.org ([209.51.188.92]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMVC-0007jM-C1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMMh-00016X-Rg
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:10:54 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 10 Apr 2019 23:10:07 +0000
Message-ID: <cover.1554937288.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH for 4.1 v3 0/6] RISC-V: Allow specifying CPU
 ISA via command line
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

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBhIGdlbmVyaWMgUklTQy1WIENQVSB0aGF0IGNhbiBiZSBn
ZW5lcmF0ZWQgYXQgcnVuDQp0aW1lIGJhc2VkIG9uIHRoZSBJU0Egc3RyaW5nIHNwZWNpZmllZCB0
byBRRU1VIHZpYSB0aGUgLWNwdSBhcmd1bWVudC4gVGhpcw0KaXMgc3VwcG9ydGVkIG9uIHRoZSB2
aXJ0IGFuZCBzcGlrZSBib2FyZHMgYWxsb3dpbmcgdXNlcnMgdG8gc3BlY2lmeSB0aGUNCg0KUklT
Qy1WIGV4dGVuc2lvbnMgYXMgd2VsbCBhcyB0aGUgSVNBIHZlcnNpb24uDQpBcyBwYXJ0IG9mIHRo
ZSBjb252ZXJzaW9uIHdlIGhhdmUgZGVwcmVjYXRlZCB0aGUgdmVyc2lvbiBzcGVjaWZpIFNwaWtl
DQptYWNoaW5lcy4NCg0KdjM6DQogLSBFbnN1cmUgYSBtaW5pbWFsIGxlbmd0aCBzbyB3ZSBkb24n
dCBydW4gb2ZmIHRoZSBlbmQgb2YgdGhlIHN0cmluZy4NCiAtIERvbid0IHBhcnNlIHRoZSBydjMy
L3J2NjQgaW4gdGhlIHJpc2N2X2dlbmVyYXRlX2NwdV9pbml0KCkgbG9vcA0KdjI6DQogLSBLZWVw
IHRoZSBhbnkgQ1BVIGZvciBsaW51eC11c2VyDQoNCkFsaXN0YWlyIEZyYW5jaXMgKDYpOg0KICBs
aW51eC11c2VyL3Jpc2N2OiBBZGQgdGhlIENQVSB0eXBlIGFzIGEgY29tbWVudA0KICB0YXJnZXQv
cmlzY3Y6IEZhbGwgYmFjayB0byBnZW5lcmF0aW5nIGEgUklTQy1WIENQVQ0KICB0YXJnZXQvcmlz
Y3Y6IENyZWF0ZSBzZXR0YWJsZSBDUFUgcHJvcGVydGllcw0KICByaXNjdjogdmlydDogQWxsb3cg
c3BlY2lmeWluZyBhIENQVSB2aWEgY29tbWFuZGxpbmUNCiAgdGFyZ2V0L3Jpc2N2OiBSZW1vdmUg
dGhlIGdlbmVyaWMgbm8gTU1VIENQVXMNCiAgcmlzY3Y6IEFkZCBhIGdlbmVyaWMgc3Bpa2UgbWFj
aGluZQ0KDQogaHcvcmlzY3Yvc3Bpa2UuYyAgICAgICAgICAgICAgfCAxMDYgKysrKysrKysrKysr
KysrKysrKysrKystDQogaHcvcmlzY3YvdmlydC5jICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBs
aW51eC11c2VyL3Jpc2N2L3RhcmdldF9lbGYuaCB8ICAgMSArDQogdGFyZ2V0L3Jpc2N2L2NwdS5j
ICAgICAgICAgICAgfCAxNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIHRh
cmdldC9yaXNjdi9jcHUuaCAgICAgICAgICAgIHwgIDEyICsrLQ0KIDUgZmlsZXMgY2hhbmdlZCwg
MjYyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4wDQoNCg==
