Received: from eggs.gnu.org ([209.51.188.92]:36194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGI-0007YA-SS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGH-0000HQ-UE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:10 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 23:28:51 +0000
Message-ID: <14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD885F69E374B48B23CF9E3994BDC7C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
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
CiBsaW51eC11c2VyL3VuYW1lLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saW51eC11c2VyL3VuYW1lLmMgYi9s
aW51eC11c2VyL3VuYW1lLmMNCmluZGV4IDMxM2I3OWRiYWQuLjJmYzYwOTZhNWIgMTAwNjQ0DQot
LS0gYS9saW51eC11c2VyL3VuYW1lLmMNCisrKyBiL2xpbnV4LXVzZXIvdW5hbWUuYw0KQEAgLTcz
LDcgKzczLDcgQEAgY29uc3QgY2hhciAqY3B1X3RvX3VuYW1lX21hY2hpbmUodm9pZCAqY3B1X2Vu
dikNCiAjZGVmaW5lIENPUFlfVVRTTkFNRV9GSUVMRChkZXN0LCBzcmMpIFwNCiAgIGRvIHsgXA0K
ICAgICAgIC8qIF9fTkVXX1VUU19MRU4gZG9lc24ndCBpbmNsdWRlIHRlcm1pbmF0aW5nIG51bGwg
Ki8gXA0KLSAgICAgICh2b2lkKSBzdHJuY3B5KChkZXN0KSwgKHNyYyksIF9fTkVXX1VUU19MRU4p
OyBcDQorICAgICAgKHZvaWQpIG1lbWNweSgoZGVzdCksIChzcmMpLCBNSU4oc3RybGVuKHNyYyks
IF9fTkVXX1VUU19MRU4pKTsgXA0KICAgICAgIChkZXN0KVtfX05FV19VVFNfTEVOXSA9ICdcMCc7
IFwNCiAgIH0gd2hpbGUgKDApDQogDQotLSANCjIuMjEuMA0KDQo=
