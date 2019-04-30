Received: from eggs.gnu.org ([209.51.188.92]:34813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcBb-0003RR-Ia
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcBZ-0006Oi-Lj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:29:19 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 23:29:01 +0000
Message-ID: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <667FC14ACE4DD1458B8B48476394801A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJhmaWxsX3BzaW5m
b+KAmSBhdCAvaG9tZS9hbGlzdGFpci9xZW11L2xpbnV4LXVzZXIvZWxmbG9hZC5jOjMyMDg6MTIs
DQogICAgaW5saW5lZCBmcm9tIOKAmGZpbGxfbm90ZV9pbmZv4oCZIGF0IC9ob21lL2FsaXN0YWly
L3FlbXUvbGludXgtdXNlci9lbGZsb2FkLmM6MzM5MDo1LA0KICAgIGlubGluZWQgZnJvbSDigJhl
bGZfY29yZV9kdW1w4oCZIGF0IC9ob21lL2FsaXN0YWlyL3FlbXUvbGludXgtdXNlci9lbGZsb2Fk
LmM6MzUzOTo5Og0KL3Vzci9pbmNsdWRlL2JpdHMvc3RyaW5nX2ZvcnRpZmllZC5oOjEwNjoxMDog
ZXJyb3I6IOKAmF9fYnVpbHRpbl9zdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZCAxNiBlcXVhbHMg
ZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQ0KICAxMDYgfCAg
IHJldHVybiBfX2J1aWx0aW5fX19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9f
Ym9zIChfX2Rlc3QpKTsNCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogbGludXgt
dXNlci9lbGZsb2FkLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2VsZmxvYWQuYyBiL2xpbnV4
LXVzZXIvZWxmbG9hZC5jDQppbmRleCBjMWEyNjAyMWY4Li5kMDhmZTIzNDY2IDEwMDY0NA0KLS0t
IGEvbGludXgtdXNlci9lbGZsb2FkLmMNCisrKyBiL2xpbnV4LXVzZXIvZWxmbG9hZC5jDQpAQCAt
Mjg3Miw3ICsyODcyLDcgQEAgc3RydWN0IHRhcmdldF9lbGZfcHJwc2luZm8gew0KICAgICB0YXJn
ZXRfZ2lkX3QgcHJfZ2lkOw0KICAgICB0YXJnZXRfcGlkX3QgcHJfcGlkLCBwcl9wcGlkLCBwcl9w
Z3JwLCBwcl9zaWQ7DQogICAgIC8qIExvdHMgbWlzc2luZyAqLw0KLSAgICBjaGFyICAgIHByX2Zu
YW1lWzE2XTsgICAgICAgICAgIC8qIGZpbGVuYW1lIG9mIGV4ZWN1dGFibGUgKi8NCisgICAgY2hh
ciAgICBwcl9mbmFtZVsxNl0gUUVNVV9OT05TVFJJTkc7IC8qIGZpbGVuYW1lIG9mIGV4ZWN1dGFi
bGUgKi8NCiAgICAgY2hhciAgICBwcl9wc2FyZ3NbRUxGX1BSQVJHU1pdOyAvKiBpbml0aWFsIHBh
cnQgb2YgYXJnIGxpc3QgKi8NCiB9Ow0KIA0KLS0gDQoyLjIxLjANCg0K
