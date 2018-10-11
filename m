Received: from eggs.gnu.org ([2001:4830:134:3::10]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhdC-0006wn-T4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhd6-0006sY-Us
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhd4-0006me-3w
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:19 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 11 Oct 2018 20:32:11 +0000
Message-ID: <20181011203115.18666-10-alistair.francis@wdc.com>
References: <20181011203115.18666-1-alistair.francis@wdc.com>
In-Reply-To: <20181011203115.18666-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C72D3A98312064CB875AE9ED8314FB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PULL 09/10] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>Alistair Francis <Alistair.Francis@wdc.com>

RnJvbTogTWljaGFlbCBDbGFyayA8bWpjQHNpZml2ZS5jb20+DQoNCkNjOiBQYWxtZXIgRGFiYmVs
dCA8cGFsbWVyQHNpZml2ZS5jb20+DQpDYzogU2FnYXIgS2FyYW5kaWthciA8c2FnYXJrQGVlY3Mu
YmVya2VsZXkuZWR1Pg0KQ2M6IEJhc3RpYW4gS29wcGVsbWFubiA8a2Jhc3RpYW5AbWFpbC51bmkt
cGFkZXJib3JuLmRlPg0KQ2M6IEFsaXN0YWlyIEZyYW5jaXMgPEFsaXN0YWlyLkZyYW5jaXNAd2Rj
LmNvbT4NClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgQ2xhcmsgPG1qY0BzaWZpdmUuY29tPg0KUmV2
aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NClJl
dmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQpS
ZXZpZXdlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBzaWZpdmUuY29tPg0KU2lnbmVkLW9m
Zi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQog
aHcvcmlzY3YvdmlydC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYw0KaW5kZXgg
NmQ5MTgxMGJjZi4uM2YzMGViNzRkMiAxMDA2NDQNCi0tLSBhL2h3L3Jpc2N2L3ZpcnQuYw0KKysr
IGIvaHcvcmlzY3YvdmlydC5jDQpAQCAtNDU3LDYgKzQ1Nyw4IEBAIHN0YXRpYyB2b2lkIHJpc2N2
X3ZpcnRfYm9hcmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQogICAgIHNlcmlhbF9tbV9p
bml0KHN5c3RlbV9tZW1vcnksIG1lbW1hcFtWSVJUX1VBUlQwXS5iYXNlLA0KICAgICAgICAgMCwg
cWRldl9nZXRfZ3Bpb19pbihERVZJQ0Uocy0+cGxpYyksIFVBUlQwX0lSUSksIDM5OTE5MywNCiAg
ICAgICAgIHNlcmlhbF9oZCgwKSwgREVWSUNFX0xJVFRMRV9FTkRJQU4pOw0KKw0KKyAgICBnX2Zy
ZWUocGxpY19oYXJ0X2NvbmZpZyk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHJpc2N2X3ZpcnRfYm9h
cmRfbWFjaGluZV9pbml0KE1hY2hpbmVDbGFzcyAqbWMpDQotLSANCjIuMTcuMQ0KDQo=
