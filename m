Received: from eggs.gnu.org ([209.51.188.92]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiq-0006Hz-OM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfik-0003gs-BT
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:16 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:27:02 +0000
Message-ID: <d32a88fc0506a7bc1cae31c2fdf1448d2469e9d3.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 3/8] target/riscv: Improve the scause logic
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

Tm8gZnVuY3Rpb25hbCBjaGFuZ2UsIGp1c3QgbWFraW5nIHRoZSBjb2RlIGVhc2llciB0byByZWFk
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jIHwgMiArLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4
IDU4MmQ1OGFhZDkuLmU3ZDlkZDk1Y2MgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtNTI1LDcgKzUyNSw3
IEBAIHZvaWQgcmlzY3ZfY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3MpDQogICAgICAgICBz
ID0gc2V0X2ZpZWxkKHMsIE1TVEFUVVNfU1BQLCBlbnYtPnByaXYpOw0KICAgICAgICAgcyA9IHNl
dF9maWVsZChzLCBNU1RBVFVTX1NJRSwgMCk7DQogICAgICAgICBlbnYtPm1zdGF0dXMgPSBzOw0K
LSAgICAgICAgZW52LT5zY2F1c2UgPSBjYXVzZSB8IH4oKCh0YXJnZXRfdWxvbmcpLTEpID4+IGFz
eW5jKTsNCisgICAgICAgIGVudi0+c2NhdXNlID0gY2F1c2UgfCAoKHRhcmdldF91bG9uZylhc3lu
YyA8PCAoVEFSR0VUX0xPTkdfQklUUyAtIDEpKTsNCiAgICAgICAgIGVudi0+c2VwYyA9IGVudi0+
cGM7DQogICAgICAgICBlbnYtPnNiYWRhZGRyID0gdHZhbDsNCiAgICAgICAgIGVudi0+cGMgPSAo
ZW52LT5zdHZlYyA+PiAyIDw8IDIpICsNCi0tIA0KMi4yMS4wDQoNCg==
