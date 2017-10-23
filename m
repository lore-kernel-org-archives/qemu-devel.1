Received: from eggs.gnu.org ([2001:4830:134:3::10]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhiyong.wu@ucloud.cn>) id 1e6aAE-0003Ux-Dh
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhiyong.wu@ucloud.cn>) id 1e6aAA-0003F9-9Q
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:40:58 -0400
Received: from m97106.mail.qiye.163.com ([220.181.97.106]:53118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhiyong.wu@ucloud.cn>) id 1e6aA9-0003AQ-EX
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:40:54 -0400
Date: Mon, 23 Oct 2017 18:40:47 +0800 (CST)
From: "Zhi Yong Wu" <zhiyong.wu@ucloud.cn>
MIME-Version: 1.0
Message-ID: <4b7f4023.1a1fb.15f48d21004.Coremail.zhiyong.wu@ucloud.cn>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] [PATCH] COLO: remove the operation to clear connection
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wuzhiyong <zhiyong.wu@ucloud.cn>

RnJvbSA0NDM5ZTU4NTNmOThmYjRiMzJmMzQ2MjQ1YTQ2NDE0ZDNjN2UyMjIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGkgWW9uZyBXdSA8emhpeW9uZy53dUB1Y2xvdWQuY24+CkRh
dGU6IFR1ZSwgMjQgT2N0IDIwMTcgMDM6MTk6MDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBDT0xP
OiByZW1vdmUgdGhlIG9wZXJhdGlvbiB0byBjbGVhciBjb25uZWN0aW9uIGxpc3QKCgpXaGVuIGhh
c2ggdGFibGUgaXMgY3JlYXRlZCB3aXRoIGdfaGFzaF90YWJsZV9uZXdfZnVsbCgpLAp0aGUgZnJl
ZSBmdW5jdGlvbiBoYXMgYmVlbiByZWdpc3RlcmVkLiBTbyBpdCBpc24ndCBuZWNlc3NhcnkKc2lu
Y2UgZ19oYXNoX3RhYmxlX3JlbW92ZV9hbGwoKSB3aWxsIGNhbGwgY29ubmVjdGlvbl9kZXN0cm95
KCkKZm9yIGVhY2ggY29ubmVjdGlvbiBzdHJ1Y3QgYXV0b21hdGljYWxseS4KCgpTaWduZWQtb2Zm
LWJ5OiBaaGkgWW9uZyBXdSA8emhpeW9uZy53dUB1Y2xvdWQuY24+Ci0tLQogbmV0L2NvbG8uYyB8
ICAgIDYgLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKCgpkaWZmIC0tZ2l0IGEvbmV0L2NvbG8uYyBiL25ldC9jb2xvLmMKaW5kZXggMjhjZTdj
OC4uNjY4YWJiNyAxMDA2NDQKLS0tIGEvbmV0L2NvbG8uYworKysgYi9uZXQvY29sby5jCkBAIC0x
OTcsMTIgKzE5Nyw2IEBAIENvbm5lY3Rpb24gKmNvbm5lY3Rpb25fZ2V0KEdIYXNoVGFibGUgKmNv
bm5lY3Rpb25fdHJhY2tfdGFibGUsCiAgICAgICAgICAgICB0cmFjZV9jb2xvX3Byb3h5X21haW4o
ImNvbG8gcHJveHkgY29ubmVjdGlvbiBoYXNodGFibGUgZnVsbCwiCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIiBjbGVhciBpdCIpOwogICAgICAgICAgICAgY29ubmVjdGlvbl9o
YXNodGFibGVfcmVzZXQoY29ubmVjdGlvbl90cmFja190YWJsZSk7Ci0gICAgICAgICAgICAvKgot
ICAgICAgICAgICAgICogY2xlYXIgdGhlIGNvbm5fbGlzdAotICAgICAgICAgICAgICovCi0gICAg
ICAgICAgICB3aGlsZSAoIWdfcXVldWVfaXNfZW1wdHkoY29ubl9saXN0KSkgewotICAgICAgICAg
ICAgICAgIGNvbm5lY3Rpb25fZGVzdHJveShnX3F1ZXVlX3BvcF9oZWFkKGNvbm5fbGlzdCkpOwot
ICAgICAgICAgICAgfQogICAgICAgICB9CiAKICAgICAgICAgZ19oYXNoX3RhYmxlX2luc2VydChj
b25uZWN0aW9uX3RyYWNrX3RhYmxlLCBuZXdfa2V5LCBjb25uKTsKLS0gCjEuNy4x
