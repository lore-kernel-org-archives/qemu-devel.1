Received: from eggs.gnu.org ([209.51.188.92]:50621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiy-0006Pf-9u
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiw-0003r3-DB
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:28 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:27:10 +0000
Message-ID: <0ce46ddcaf8009df9a4f53aa7516455c1dda016d.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 4/8] target/riscv: Add the MPV and MTL
 mstatus bits
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

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCA1ICsrLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCmluZGV4IDk0NWFh
OGRiYjguLmZlNzE2NDc1NGIgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0K
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCkBAIC0zMTYsMTQgKzMxNiwxMSBAQA0KIC8q
IG1zdGF0dXMgQ1NSIGJpdHMgKi8NCiAjZGVmaW5lIE1TVEFUVVNfVUlFICAgICAgICAgMHgwMDAw
MDAwMQ0KICNkZWZpbmUgTVNUQVRVU19TSUUgICAgICAgICAweDAwMDAwMDAyDQotI2RlZmluZSBN
U1RBVFVTX0hJRSAgICAgICAgIDB4MDAwMDAwMDQNCiAjZGVmaW5lIE1TVEFUVVNfTUlFICAgICAg
ICAgMHgwMDAwMDAwOA0KICNkZWZpbmUgTVNUQVRVU19VUElFICAgICAgICAweDAwMDAwMDEwDQog
I2RlZmluZSBNU1RBVFVTX1NQSUUgICAgICAgIDB4MDAwMDAwMjANCi0jZGVmaW5lIE1TVEFUVVNf
SFBJRSAgICAgICAgMHgwMDAwMDA0MA0KICNkZWZpbmUgTVNUQVRVU19NUElFICAgICAgICAweDAw
MDAwMDgwDQogI2RlZmluZSBNU1RBVFVTX1NQUCAgICAgICAgIDB4MDAwMDAxMDANCi0jZGVmaW5l
IE1TVEFUVVNfSFBQICAgICAgICAgMHgwMDAwMDYwMA0KICNkZWZpbmUgTVNUQVRVU19NUFAgICAg
ICAgICAweDAwMDAxODAwDQogI2RlZmluZSBNU1RBVFVTX0ZTICAgICAgICAgIDB4MDAwMDYwMDAN
CiAjZGVmaW5lIE1TVEFUVVNfWFMgICAgICAgICAgMHgwMDAxODAwMA0KQEAgLTMzNSw2ICszMzIs
OCBAQA0KICNkZWZpbmUgTVNUQVRVU19UVk0gICAgICAgICAweDAwMTAwMDAwIC8qIHNpbmNlOiBw
cml2LTEuMTAgKi8NCiAjZGVmaW5lIE1TVEFUVVNfVFcgICAgICAgICAgMHgyMDAwMDAwMCAvKiBz
aW5jZTogcHJpdi0xLjEwICovDQogI2RlZmluZSBNU1RBVFVTX1RTUiAgICAgICAgIDB4NDAwMDAw
MDAgLyogc2luY2U6IHByaXYtMS4xMCAqLw0KKyNkZWZpbmUgTVNUQVRVU19NVEwgICAgICAgICAw
eDQwMDAwMDAwMDBVTEwNCisjZGVmaW5lIE1TVEFUVVNfTVBWICAgICAgICAgMHg4MDAwMDAwMDAw
VUxMDQogDQogI2RlZmluZSBNU1RBVFVTNjRfVVhMICAgICAgIDB4MDAwMDAwMDMwMDAwMDAwMFVM
TA0KICNkZWZpbmUgTVNUQVRVUzY0X1NYTCAgICAgICAweDAwMDAwMDBDMDAwMDAwMDBVTEwNCi0t
IA0KMi4yMS4wDQoNCg==
