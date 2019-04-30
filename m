Received: from eggs.gnu.org ([209.51.188.92]:36209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGJ-0007Z9-Ml
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGI-0000Ho-Mz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:11 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 23:28:31 +0000
Message-ID: <ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5CC77A795856C4BB7501572F80D9079@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build warning
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

Rml4IHRoaXMgYnVpbGQgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9o
Y2QteGhjaS5jOjMzMzk6NjY6IGVycm9yOiDigJglZOKAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBi
ZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5dGVzIGludG8gYSByZWdpb24g
b2Ygc2l6ZSA1IFstV2Vycm9yPWZvcm1hdC10cnVuY2F0aW9uPV0NCiAzMzM5IHwgICAgICAgICAg
ICAgc25wcmludGYocG9ydC0+bmFtZSwgc2l6ZW9mKHBvcnQtPm5hbWUpLCAidXNiMiBwb3J0ICMl
ZCIsIGkrMSk7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCmh3L3VzYi9oY2QteGhjaS5jOjMzMzk6NTQ6
IG5vdGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0aGUgcmFuZ2UgWzEsIDIxNDc0ODM2NDddDQog
MzMzOSB8ICAgICAgICAgICAgIHNucHJpbnRmKHBvcnQtPm5hbWUsIHNpemVvZihwb3J0LT5uYW1l
KSwgInVzYjIgcG9ydCAjJWQiLCBpKzEpOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdGRpby5oOjg2NywNCiAgICAgICAgICAgICAgICAg
ZnJvbSAvaG9tZS9hbGlzdGFpci9xZW11L2luY2x1ZGUvcWVtdS9vc2RlcC5oOjk5LA0KICAgICAg
ICAgICAgICAgICBmcm9tIGh3L3VzYi9oY2QteGhjaS5jOjIxOg0KL3Vzci9pbmNsdWRlL2JpdHMv
c3RkaW8yLmg6Njc6MTA6IG5vdGU6IOKAmF9fYnVpbHRpbl9fX3NucHJpbnRmX2Noa+KAmSBvdXRw
dXQgYmV0d2VlbiAxMyBhbmQgMjIgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgMTYN
CiAgIDY3IHwgICByZXR1cm4gX19idWlsdGluX19fc25wcmludGZfY2hrIChfX3MsIF9fbiwgX19V
U0VfRk9SVElGWV9MRVZFTCAtIDEsDQogICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KICAgNjggfCAgICAg
ICAgX19ib3MgKF9fcyksIF9fZm10LCBfX3ZhX2FyZ19wYWNrICgpKTsNCiAgICAgIHwgICAgICAg
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogaHcvdXNi
L2hjZC14aGNpLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlm
ZiAtLWdpdCBhL2h3L3VzYi9oY2QteGhjaS5jIGIvaHcvdXNiL2hjZC14aGNpLmMNCmluZGV4IGVj
MjhiZWUzMTkuLjJiMDYxNzcyYjIgMTAwNjQ0DQotLS0gYS9ody91c2IvaGNkLXhoY2kuYw0KKysr
IGIvaHcvdXNiL2hjZC14aGNpLmMNCkBAIC0zMzIyLDYgKzMzMjIsNyBAQCBzdGF0aWMgdm9pZCB1
c2JfeGhjaV9pbml0KFhIQ0lTdGF0ZSAqeGhjaSkNCiAgICAgdXNiX2J1c19uZXcoJnhoY2ktPmJ1
cywgc2l6ZW9mKHhoY2ktPmJ1cyksICZ4aGNpX2J1c19vcHMsIGRldik7DQogDQogICAgIGZvciAo
aSA9IDA7IGkgPCB1c2Jwb3J0czsgaSsrKSB7DQorICAgICAgICBnX2Fzc2VydChpIDwgTUFYKE1B
WFBPUlRTXzIsIE1BWFBPUlRTXzMpKTsNCiAgICAgICAgIHNwZWVkbWFzayA9IDA7DQogICAgICAg
ICBpZiAoaSA8IHhoY2ktPm51bXBvcnRzXzIpIHsNCiAgICAgICAgICAgICBpZiAoeGhjaV9nZXRf
ZmxhZyh4aGNpLCBYSENJX0ZMQUdfU1NfRklSU1QpKSB7DQotLSANCjIuMjEuMA0KDQo=
