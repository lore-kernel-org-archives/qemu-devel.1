Received: from eggs.gnu.org ([209.51.188.92]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4C-0002WG-R7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4B-00079e-Ta
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:28 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 20:09:21 +0000
Message-ID: <66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2A8B247E6C6464DAB913E199DE06298@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
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
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJhzeXNfdW5hbWXi
gJkgYXQgL2hvbWUvYWxpc3RhaXIvcWVtdS9saW51eC11c2VyL3VuYW1lLmM6OTQ6MzoNCi91c3Iv
aW5jbHVkZS9iaXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0
aW5fc3RybmNweeKAmSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCBjb3B5aW5nIDY0IGJ5dGVzIGZy
b20gYSBzdHJpbmcgb2YgbGVuZ3RoIDY0IFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dDQog
IDEwNiB8ICAgcmV0dXJuIF9fYnVpbHRpbl9fX3N0cm5jcHlfY2hrIChfX2Rlc3QsIF9fc3JjLCBf
X2xlbiwgX19ib3MgKF9fZGVzdCkpOw0KICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpTaWduZWQt
b2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0N
CiBsaW51eC11c2VyL3VuYW1lLmMgfCA4ICsrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci91bmFtZS5jIGIvbGludXgtdXNl
ci91bmFtZS5jDQppbmRleCAzMTNiNzlkYmFkLi4yOTNiMjIzOGYyIDEwMDY0NA0KLS0tIGEvbGlu
dXgtdXNlci91bmFtZS5jDQorKysgYi9saW51eC11c2VyL3VuYW1lLmMNCkBAIC05MCw2ICs5MCwx
MSBAQCBpbnQgc3lzX3VuYW1lKHN0cnVjdCBuZXdfdXRzbmFtZSAqYnVmKQ0KICAgICogc3RydWN0
IGxpbnV4IGtlcm5lbCB1c2VzKS4NCiAgICAqLw0KIA0KKyNpZiBkZWZpbmVkKENPTkZJR19QUkFH
TUFfRElBR05PU1RJQ19BVkFJTEFCTEUpICYmIFFFTVVfR05VQ19QUkVSRVEoOSwgMCkNCisjcHJh
Z21hIEdDQyBkaWFnbm9zdGljIHB1c2gNCisjcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQg
Ii1Xc3RyaW5nb3AtdHJ1bmNhdGlvbiINCisjZW5kaWYNCisNCiAgIG1lbXNldChidWYsIDAsIHNp
emVvZigqYnVmKSk7DQogICBDT1BZX1VUU05BTUVfRklFTEQoYnVmLT5zeXNuYW1lLCB1dHNfYnVm
LnN5c25hbWUpOw0KICAgQ09QWV9VVFNOQU1FX0ZJRUxEKGJ1Zi0+bm9kZW5hbWUsIHV0c19idWYu
bm9kZW5hbWUpOw0KQEAgLTEwMSw2ICsxMDYsOSBAQCBpbnQgc3lzX3VuYW1lKHN0cnVjdCBuZXdf
dXRzbmFtZSAqYnVmKQ0KICNlbmRpZg0KICAgcmV0dXJuICgwKTsNCiANCisjaWYgZGVmaW5lZChD
T05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFKSAmJiBRRU1VX0dOVUNfUFJFUkVRKDks
IDApDQorI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwb3ANCisjZW5kaWYNCiAjdW5kZWYgQ09QWV9V
VFNOQU1FX0ZJRUxEDQogfQ0KIA0KLS0gDQoyLjIxLjANCg0K
