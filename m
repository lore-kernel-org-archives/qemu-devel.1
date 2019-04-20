Received: from eggs.gnu.org ([209.51.188.92]:50680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj4-0006XD-TE
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj3-0003wL-Na
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:34 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:27:26 +0000
Message-ID: <68ede3d1b281db3709a35c525e21ce1fed8c966a.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 6/8] target/riscv: Add Hypervisor CSR macros
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

QWRkIHRoZSAxLjEwLjEgSHlwZXJ2aXNvciBDU1JzIGFuZCByZW1vdmUgdGhlIDEuOS4xIHNwZWMg
dmVyc2lvbnMuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCi0tLQ0KIHRhcmdldC9yaXNjdi9jcHVfYml0cy5oIHwgOSArKysrKyst
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQvcmlzY3YvY3B1X2Jp
dHMuaA0KaW5kZXggZmU3MTY0NzU0Yi4uNTJjMjE2OTk3NyAxMDA2NDQNCi0tLSBhL3RhcmdldC9y
aXNjdi9jcHVfYml0cy5oDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KQEAgLTIwMiw2
ICsyMDIsMTIgQEANCiAjZGVmaW5lIENTUl9EUEMgICAgICAgICAgICAgMHg3YjENCiAjZGVmaW5l
IENTUl9EU0NSQVRDSCAgICAgICAgMHg3YjINCiANCisvKiBIcGVydmlzb3IgQ1NScyAqLw0KKyNk
ZWZpbmUgQ1NSX0hTVEFUVVMgICAgICAgICAweGEwMA0KKyNkZWZpbmUgQ1NSX0hFREVMRUcgICAg
ICAgICAweGEwMg0KKyNkZWZpbmUgQ1NSX0hJREVMRUcgICAgICAgICAweGEwMw0KKyNkZWZpbmUg
Q1NSX0hHQVRQICAgICAgICAgICAweGE4MA0KKw0KIC8qIFBlcmZvcm1hbmNlIENvdW50ZXJzICov
DQogI2RlZmluZSBDU1JfTUhQTUNPVU5URVIzICAgIDB4YjAzDQogI2RlZmluZSBDU1JfTUhQTUNP
VU5URVI0ICAgIDB4YjA0DQpAQCAtMjkyLDkgKzI5OCw2IEBADQogI2RlZmluZSBDU1JfTUhQTUNP
VU5URVIzMUggIDB4YjlmDQogDQogLyogTGVnYWN5IEh5cGVydmlzb3IgVHJhcCBTZXR1cCAocHJp
diB2MS45LjEpICovDQotI2RlZmluZSBDU1JfSFNUQVRVUyAgICAgICAgIDB4MjAwDQotI2RlZmlu
ZSBDU1JfSEVERUxFRyAgICAgICAgIDB4MjAyDQotI2RlZmluZSBDU1JfSElERUxFRyAgICAgICAg
IDB4MjAzDQogI2RlZmluZSBDU1JfSElFICAgICAgICAgICAgIDB4MjA0DQogI2RlZmluZSBDU1Jf
SFRWRUMgICAgICAgICAgIDB4MjA1DQogDQotLSANCjIuMjEuMA0KDQo=
