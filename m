Received: from eggs.gnu.org ([209.51.188.92]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffz-0003O9-2o
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffY-0002GB-Rv
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:23:57 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:23:53 +0000
Message-ID: <6480a4d099d59afc8103313a3ac51262fac43cbc.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 2/6] riscv: virt: Allow specifying a CPU via
 commandline
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

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KUmV2aWV3ZWQtYnk6IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+DQotLS0N
CiBody9yaXNjdi92aXJ0LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jp
c2N2L3ZpcnQuYw0KaW5kZXggZmM0YzZiMzA2ZS4uNWIyNWYwMjhhZCAxMDA2NDQNCi0tLSBhL2h3
L3Jpc2N2L3ZpcnQuYw0KKysrIGIvaHcvcmlzY3YvdmlydC5jDQpAQCAtNDAwLDcgKzQwMCw3IEBA
IHN0YXRpYyB2b2lkIHJpc2N2X3ZpcnRfYm9hcmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUp
DQogICAgIC8qIEluaXRpYWxpemUgU09DICovDQogICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxk
KE9CSkVDVChtYWNoaW5lKSwgInNvYyIsICZzLT5zb2MsIHNpemVvZihzLT5zb2MpLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1JJU0NWX0hBUlRfQVJSQVksICZlcnJvcl9hYm9y
dCwgTlVMTCk7DQotICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfc3RyKE9CSkVDVCgmcy0+c29jKSwg
VklSVF9DUFUsICJjcHUtdHlwZSIsDQorICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfc3RyKE9CSkVD
VCgmcy0+c29jKSwgbWFjaGluZS0+Y3B1X3R5cGUsICJjcHUtdHlwZSIsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQogICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
aW50KE9CSkVDVCgmcy0+c29jKSwgc21wX2NwdXMsICJudW0taGFydHMiLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KQEAgLTUyNiw2ICs1MjYsNyBAQCBzdGF0
aWMgdm9pZCByaXNjdl92aXJ0X2JvYXJkX21hY2hpbmVfaW5pdChNYWNoaW5lQ2xhc3MgKm1jKQ0K
ICAgICBtYy0+ZGVzYyA9ICJSSVNDLVYgVmlydElPIEJvYXJkIChQcml2aWxlZ2VkIElTQSB2MS4x
MCkiOw0KICAgICBtYy0+aW5pdCA9IHJpc2N2X3ZpcnRfYm9hcmRfaW5pdDsNCiAgICAgbWMtPm1h
eF9jcHVzID0gODsgLyogaGFyZGNvZGVkIGxpbWl0IGluIEJCTCAqLw0KKyAgICBtYy0+ZGVmYXVs
dF9jcHVfdHlwZSA9IFZJUlRfQ1BVOw0KIH0NCiANCiBERUZJTkVfTUFDSElORSgidmlydCIsIHJp
c2N2X3ZpcnRfYm9hcmRfbWFjaGluZV9pbml0KQ0KLS0gDQoyLjIxLjANCg0K
