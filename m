Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <8610_28@163.com>) id 1d8NuV-0001zX-Dy
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <8610_28@163.com>) id 1d8NuS-0007Tt-69
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:27:55 -0400
Received: from m12-16.163.com ([220.181.12.16]:35064)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <8610_28@163.com>) id 1d8NuR-0007Rq-CX
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:27:52 -0400
Date: Wed, 10 May 2017 16:57:10 +0800 (CST)
From: =?GBK?B?wO7B1g==?= <8610_28@163.com>
MIME-Version: 1.0
Message-ID: <1894a033.84c.15bf1938bed.Coremail.8610_28@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] ehci: fix "int" overflow for calculation
 ehci->last_run_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ICBJZiB3ZSBleHBlcmllbmNlIGxhcmdlIGRlbGF5cyBiZXR3ZWVuIGVjaGkgdGltZXIgY2FsbGJh
Y2tzIChpLmUuIGJlY2F1c2Ugb3RoZXIgcGVyaW9kaWMgaGFuZGxlcnMgaGF2ZSB0YWtlbiBhIGxv
dCBvZiB0aW1lIHRvIGNvbXBsZXRlKSB3ZSBnZXQgYSBsb3Qgb2Ygc2tpcHBlZCBmcmFtZXMgd2hp
Y2ggdGhlbiBkZWxheSBlaGNpIHRpbWVyIGNhbGxiYWNrLgogVGhlbiB3ZSB3aWxsIGNhbGN1bGF0
aW9uICBlaGNpLT5sYXN0X3J1bl9ucyxidXQgc2tpcHBlZF91ZnJhbWVzIGlzIGludCxzbyAiVUZS
QU1FX1RJTUVSX05TICogc2tpcHBlZF91ZnJhbWVzIiB3aWxsIGJlIGludCxhbmQgaWYgc2tpcHBl
ZF91ZnJhbWVzIGlzIGJpZyBlbm91Z2ggLGl0IGNhbiBvdmVyZmxvdyAsYW5kIHRoaXMgY2FuIG5v
dCBjYWxjdWxhdGlvbiB0aGUgcmlnaHQgbnVtYmVyLHRoZW4gaXQgY2FuICAgcmFpc2UgIGxhcmdl
IGFtb3VudHNpbnRlcnJ1cHRzOwogIE9ic2VydmFibGUgYmVoYXZpb3VyIGlzIHFlbXUgY29uc3Vt
aW5nIDEwMCUgaG9zdCBDUFUgdGltZSB3aGlsZSBndWVzdCBpcyB1bnJlc3BvbnNpdmUuIFRoaXMg
bWlzYmVoYXZpb3IgY291bGQgaGFwcGVuIGZvciBhIHdoaWxlIGFuZCBRRU1VIGRvZXMgbm90IGdl
dCBvdXQgZnJvbSB0aGlzIHN0YXRlIGF1dG9tYXRpY2FsbHkgd2l0aG91dCB0aGUgcGF0Y2ggaW4g
QnJhbmNoLW1hc3RlciByZXBvc2l0b3J5LgoKCmRpZmYgLS1naXQgYS9ody91c2IvaGNkLWVoY2ku
YyBiL2h3L3VzYi9oY2QtZWhjaS5jCmluZGV4IDUwZWY4MTdmOTMuLjhkZjJmMDg3ODMgMTAwNjQ0
Ci0tLSBhL2h3L3VzYi9oY2QtZWhjaS5jCisrKyBiL2h3L3VzYi9oY2QtZWhjaS5jCkBAIC0yMjM4
LDcgKzIyMzgsNyBAQCBzdGF0aWMgdm9pZCBlaGNpX2ZyYW1lX3RpbWVyKHZvaWQgKm9wYXF1ZSkK
ICAgICBpbnQgbmVlZF90aW1lciA9IDA7CiAgICAgaW50NjRfdCBleHBpcmVfdGltZSwgdF9ub3c7
CiAgICAgdWludDY0X3QgbnNfZWxhcHNlZDsKLSAgICBpbnQgdWZyYW1lcywgc2tpcHBlZF91ZnJh
bWVzOworICAgIHVpbnQ2NCB1ZnJhbWVzLCBza2lwcGVkX3VmcmFtZXM7CiAgICAgaW50IGk7CgoK
ICAgICB0X25vdyA9IHFlbXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfVklSVFVBTCk7
