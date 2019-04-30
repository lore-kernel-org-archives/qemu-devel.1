Received: from eggs.gnu.org ([209.51.188.92]:34325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAy-0002jy-54
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAo-0005x5-FJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:31 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 23:28:22 +0000
Message-ID: <002f222d86322a66276de39cb29796acffe384c1.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DACA981F99FAD42A18EF4D27F084E13@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 1/5] util/qemu-sockets: Fix GCC 9 build
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
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJh1bml4X2Nvbm5l
Y3Rfc2FkZHIuaXNyYS4w4oCZIGF0IHV0aWwvcWVtdS1zb2NrZXRzLmM6OTI1OjU6DQovdXNyL2lu
Y2x1ZGUvYml0cy9zdHJpbmdfZm9ydGlmaWVkLmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGlu
X3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5kIDEwOCBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBb
LVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQ0KICAxMDYgfCAgIHJldHVybiBfX2J1aWx0aW5f
X19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9fYm9zIChfX2Rlc3QpKTsNCiAg
ICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZ1bmN0aW9uIOKAmHN0cm5jcHnigJksDQogICAgaW5s
aW5lZCBmcm9tIOKAmHVuaXhfbGlzdGVuX3NhZGRyLmlzcmEuMOKAmSBhdCB1dGlsL3FlbXUtc29j
a2V0cy5jOjg4MDo1Og0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiB1dGlsL3FlbXUtc29ja2V0cy5jIHwgNCArKy0tDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3V0aWwvcWVtdS1zb2NrZXRzLmMgYi91dGlsL3FlbXUtc29ja2V0cy5jDQppbmRleCA5
NzA1MDUxNjkwLi44YzMzMjI5NThmIDEwMDY0NA0KLS0tIGEvdXRpbC9xZW11LXNvY2tldHMuYw0K
KysrIGIvdXRpbC9xZW11LXNvY2tldHMuYw0KQEAgLTgyOSw3ICs4MjksNyBAQCBzdGF0aWMgaW50
IHVuaXhfbGlzdGVuX3NhZGRyKFVuaXhTb2NrZXRBZGRyZXNzICpzYWRkciwNCiAgICAgc3RydWN0
IHNvY2thZGRyX3VuIHVuOw0KICAgICBpbnQgc29jaywgZmQ7DQogICAgIGNoYXIgKnBhdGhidWYg
PSBOVUxMOw0KLSAgICBjb25zdCBjaGFyICpwYXRoOw0KKyAgICBjb25zdCBjaGFyICpwYXRoIFFF
TVVfTk9OU1RSSU5HOw0KIA0KICAgICBzb2NrID0gcWVtdV9zb2NrZXQoUEZfVU5JWCwgU09DS19T
VFJFQU0sIDApOw0KICAgICBpZiAoc29jayA8IDApIHsNCkBAIC05MjIsNyArOTIyLDcgQEAgc3Rh
dGljIGludCB1bml4X2Nvbm5lY3Rfc2FkZHIoVW5peFNvY2tldEFkZHJlc3MgKnNhZGRyLCBFcnJv
ciAqKmVycnApDQogDQogICAgIG1lbXNldCgmdW4sIDAsIHNpemVvZih1bikpOw0KICAgICB1bi5z
dW5fZmFtaWx5ID0gQUZfVU5JWDsNCi0gICAgc3RybmNweSh1bi5zdW5fcGF0aCwgc2FkZHItPnBh
dGgsIHNpemVvZih1bi5zdW5fcGF0aCkpOw0KKyAgICBtZW1jcHkodW4uc3VuX3BhdGgsIHNhZGRy
LT5wYXRoLCBNSU4oc3RybGVuKHNhZGRyLT5wYXRoKSwgc2l6ZW9mKHVuLnN1bl9wYXRoKSkpOw0K
IA0KICAgICAvKiBjb25uZWN0IHRvIHBlZXIgKi8NCiAgICAgZG8gew0KLS0gDQoyLjIxLjANCg0K
