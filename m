Received: from eggs.gnu.org ([209.51.188.92]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiU-0005wY-4Y
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiT-0003YT-1a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:58 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:26:45 +0000
Message-ID: <ab34b0e532abd2a106797afda50cb81e7ee4bcd9.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/8] target/riscv: Mark privilege level 2 as
 reserved
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
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlz
Y3YvY3B1X2JpdHMuaCBiL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQppbmRleCA3MTgwZmNjZjU0
Li45NDVhYThkYmI4IDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCisrKyBi
L3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQpAQCAtMzgzLDcgKzM4Myw3IEBADQogLyogUHJpdmls
ZWdlIG1vZGVzICovDQogI2RlZmluZSBQUlZfVSAwDQogI2RlZmluZSBQUlZfUyAxDQotI2RlZmlu
ZSBQUlZfSCAyDQorI2RlZmluZSBQUlZfSCAyIC8qIFJlc2VydmVkICovDQogI2RlZmluZSBQUlZf
TSAzDQogDQogLyogUlYzMiBzYXRwIENTUiBmaWVsZCBtYXNrcyAqLw0KLS0gDQoyLjIxLjANCg0K
