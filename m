Received: from eggs.gnu.org ([209.51.188.92]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4N-0002fM-Jt
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4L-0007DA-QG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:39 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 20:09:29 +0000
Message-ID: <6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A83FF89C78ED949B2F2FF24B129CC78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
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
dXNlci9lbGZsb2FkLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9lbGZsb2FkLmMgYi9s
aW51eC11c2VyL2VsZmxvYWQuYw0KaW5kZXggYzFhMjYwMjFmOC4uY2JiN2ZjMTBmYSAxMDA2NDQN
Ci0tLSBhL2xpbnV4LXVzZXIvZWxmbG9hZC5jDQorKysgYi9saW51eC11c2VyL2VsZmxvYWQuYw0K
QEAgLTMyMDYsNyArMzIwNiw3IEBAIHN0YXRpYyBpbnQgZmlsbF9wc2luZm8oc3RydWN0IHRhcmdl
dF9lbGZfcHJwc2luZm8gKnBzaW5mbywgY29uc3QgVGFza1N0YXRlICp0cykNCiAgICAgICogdGhp
cyBmaWVsZCBpcyBub3QgTlVMLXRlcm1pbmF0ZWQuDQogICAgICAqLw0KICAgICAodm9pZCkgc3Ry
bmNweShwc2luZm8tPnByX2ZuYW1lLCBiYXNlX2ZpbGVuYW1lLA0KLSAgICAgICAgICAgICAgICAg
ICBzaXplb2YocHNpbmZvLT5wcl9mbmFtZSkpOw0KKyAgICAgICAgICAgICAgICAgICBzaXplb2Yo
cHNpbmZvLT5wcl9mbmFtZSkgLSAxKTsNCiANCiAgICAgZ19mcmVlKGJhc2VfZmlsZW5hbWUpOw0K
ICAgICBic3dhcF9wc2luZm8ocHNpbmZvKTsNCkBAIC0zMzg5LDcgKzMzODksNyBAQCBzdGF0aWMg
aW50IGZpbGxfbm90ZV9pbmZvKHN0cnVjdCBlbGZfbm90ZV9pbmZvICppbmZvLA0KICAgICAgICAg
ICAgICAgc2l6ZW9mICgqaW5mby0+cHJzdGF0dXMpLCBpbmZvLT5wcnN0YXR1cyk7DQogICAgIGZp
bGxfcHNpbmZvKGluZm8tPnBzaW5mbywgdHMpOw0KICAgICBmaWxsX25vdGUoJmluZm8tPm5vdGVz
WzFdLCAiQ09SRSIsIE5UX1BSUFNJTkZPLA0KLSAgICAgICAgICAgICAgc2l6ZW9mICgqaW5mby0+
cHNpbmZvKSwgaW5mby0+cHNpbmZvKTsNCisgICAgICAgICAgICAgIHNpemVvZigqaW5mby0+cHNp
bmZvKSAtIDEsIGluZm8tPnBzaW5mbyk7DQogICAgIGZpbGxfYXV4dl9ub3RlKCZpbmZvLT5ub3Rl
c1syXSwgdHMpOw0KICAgICBpbmZvLT5udW1ub3RlID0gMzsNCiANCi0tIA0KMi4yMS4wDQoNCg==
