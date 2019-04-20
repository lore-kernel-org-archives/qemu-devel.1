Received: from eggs.gnu.org ([209.51.188.92]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfg1-0003O9-Qz
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffN-0002B1-Sk
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:23:46 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:23:36 +0000
Message-ID: <cover.1555726824.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/6]  RISC-V: Add properties to the CPUs
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

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdGhlIHByZXZpb3VzICJSSVNDLVY6IEFsbG93IHNwZWNp
ZnlpbmcgQ1BVIElTQQ0KdmlhIGNvbW1hbmQgbGluZSIgc2VyaWVzLiBUaGlzIHNlcmllcyBkb2Vz
IG5vdCBhbGxvdyBjdXN0b20gSVNBDQpleHRlbnNpb25zIGluc3RlYWQgaXQganVzdCBhbGxvd3Mg
b3RoZXIgcHJvcGVydHkgc2V0dGluZy4NCg0KVGhpcyBzZXJpZXMgYWxsb3dzIHVzZXJzIHRvIHNw
ZWNpZnkgc3BlYyB2ZXJzaW9ucywgTU1VIHN1cHBvcnQgYW5kIFBNUA0Kc3VwcG9ydCBmcm9tIHRo
ZSBjb21tYW5kIGxpbmUuDQoNClRoaXMgc2VyaWVzIGRlcHJlYXRlcyBzb21lIGV4aXN0aW5nIENQ
VXMgYW5kIG1hY2hpbmVzIGFzIHRoZXkgYXJlIG5vDQpsb25nZXIgcmVxdWlyZWQuDQoNCkFsaXN0
YWlyIEZyYW5jaXMgKDYpOg0KICBsaW51eC11c2VyL3Jpc2N2OiBBZGQgdGhlIENQVSB0eXBlIGFz
IGEgY29tbWVudA0KICByaXNjdjogdmlydDogQWxsb3cgc3BlY2lmeWluZyBhIENQVSB2aWEgY29t
bWFuZGxpbmUNCiAgdGFyZ2V0L3Jpc2N2OiBDcmVhdGUgc2V0dGFibGUgQ1BVIHByb3BlcnRpZXMN
CiAgdGFyZ2V0L3Jpc2N2OiBBZGQgYSBiYXNlIDMyIGFuZCA2NCBiaXQgQ1BVDQogIHRhcmdldC9y
aXNjdjogRGVwcmVjYXRlIHRoZSBnZW5lcmljIG5vIE1NVSBDUFVzDQogIHJpc2N2OiBzcGlrZTog
QWRkIGEgZ2VuZXJpYyBzcGlrZSBtYWNoaW5lDQoNCiBody9yaXNjdi9zcGlrZS5jICAgICAgICAg
ICAgICB8IDEwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogaHcvcmlzY3Yv
dmlydC5jICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBpbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaCAg
ICAgICB8ICAgNCArLQ0KIGxpbnV4LXVzZXIvcmlzY3YvdGFyZ2V0X2VsZi5oIHwgICAxICsNCiBx
ZW11LWRlcHJlY2F0ZWQudGV4aSAgICAgICAgICB8ICAyMSArKysrKysrDQogdGFyZ2V0L3Jpc2N2
L2NwdS5jICAgICAgICAgICAgfCAgNjMgKysrKysrKysrKysrKysrKysrKysNCiB0YXJnZXQvcmlz
Y3YvY3B1LmggICAgICAgICAgICB8ICAxMCArKysrDQogNyBmaWxlcyBjaGFuZ2VkLCAyMDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIxLjANCg0K
