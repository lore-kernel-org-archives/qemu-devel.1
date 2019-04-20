Received: from eggs.gnu.org ([209.51.188.92]:50707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj9-0006cH-Ty
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj8-0003yz-SZ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:39 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:27:35 +0000
Message-ID: <fee652e087d5bed01cccc67950cc49bf05268157.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 7/8] target/riscv: Add the HSTATUS register
 masks
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
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCAxOCArKysrKysrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KaW5kZXggNTJjMjE2
OTk3Ny4uYTE3OTEzN2JjMSAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQor
KysgYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KQEAgLTM4Miw2ICszODIsMjQgQEANCiAjZGVm
aW5lIFNTVEFUVVNfU0QgU1NUQVRVUzY0X1NEDQogI2VuZGlmDQogDQorLyogaHN0YXR1cyBDU1Ig
Yml0cyAqLw0KKyNkZWZpbmUgSFNUQVRVU19TUFJWICAgICAgICAgMHgwMDAwMDAwMQ0KKyNkZWZp
bmUgSFNUQVRVU19TVEwgICAgICAgICAgMHgwMDAwMDA0MA0KKyNkZWZpbmUgSFNUQVRVU19TUFYg
ICAgICAgICAgMHgwMDAwMDA4MA0KKyNkZWZpbmUgSFNUQVRVU19TUDJQICAgICAgICAgMHgwMDAw
MDEwMA0KKyNkZWZpbmUgSFNUQVRVU19TUDJWICAgICAgICAgMHgwMDAwMDIwMA0KKyNkZWZpbmUg
SFNUQVRVU19WVFZNICAgICAgICAgMHgwMDEwMDAwMA0KKyNkZWZpbmUgSFNUQVRVU19WVFNSICAg
ICAgICAgMHgwMDQwMDAwMA0KKw0KKyNkZWZpbmUgSFNUQVRVUzMyX1dQUkkgICAgICAgMHhGRjhG
Rjg3RQ0KKyNkZWZpbmUgSFNUQVRVUzY0X1dQUkkgICAgICAgMHhGRkZGRkZGRkZGOEZGODdFVUxM
DQorDQorI2lmIGRlZmluZWQoVEFSR0VUX1JJU0NWMzIpDQorI2RlZmluZSBIU1RBVFVTX1dQUkkg
SFNUQVRVUzMyX1dQUkkNCisjZWxpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjY0KQ0KKyNkZWZpbmUg
SFNUQVRVU19XUFJJIEhTVEFUVVM2NF9XUFJJDQorI2VuZGlmDQorDQogLyogUHJpdmlsZWdlIG1v
ZGVzICovDQogI2RlZmluZSBQUlZfVSAwDQogI2RlZmluZSBQUlZfUyAxDQotLSANCjIuMjEuMA0K
DQo=
