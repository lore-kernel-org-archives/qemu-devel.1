Received: from eggs.gnu.org ([2001:4830:134:3::10]:45392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gaA4b-0007hO-B0
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 20:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gaA4Y-0003D0-0j
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 20:57:57 -0500
Received: from m13-21.163.com ([220.181.13.21]:46465)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gaA4X-0003BD-95
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 20:57:53 -0500
Date: Fri, 21 Dec 2018 09:57:47 +0800 (CST)
From: tugouxp <13824125580@163.com>
MIME-Version: 1.0
Message-ID: <130d7419.4ba1.167ce7b9ed6.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] is the "tcg translation" necessary when the "kvm
 acceleration" emulation mode enabled?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

aGkgZm9sa3M6CiAgICBpIGFtIHZlcnkgcHV6emxlZCBhYm91dCB0aGUgcmVsYXRpb25zaGlwIGJl
dHdlZW4gInRhcmdldCBjcHUgaW5zdHJ1Y3Rpb24iICB0cmFuc2xhdGVkIHRvIGhvc3QgaW5zdHJ1
Y3Rpb25zIHRocm91Z2ggVENHIG1vZHVsZSBhbmQgdGhlICJrdm0iIGFjY2VsZXJhdGlvbiIgbW9k
ZS4KCgp0aGluayBhYm91dCB0aHJlZSBzY2VuYXJpbyBvZiBlbXVsYXRpb246CnNjZW5hcmlvIDEs
IDIgYW5kIDMgYXMgZm9sbG93czoKCjEuIHRhcmdldCBjcHU6IHg4Nl82NCwKCiAgICBob3N0IGNw
dTogICB4ODRfNjQsCgogICAgZW11bGF0aW9uIE9TOiAgIHVidW50dV9kZXNrdG9wX2FtZDY0Lmlz
bwogICAga3ZtOiAgZW5hYmxlZC4KCgoyLiB0YXJnZXQgY3B1OiB4ODZfNjQsCgogICAgaG9zdCBj
cHU6ICAgeDg0XzY0LAoKICAgIGVtdWxhdGlvbiBPUzogICB1YnVudHVfZGVza3RvcF9hbWQ2NC5p
c28KICAgIGt2bTogIGRpc2FibGVkLgoKCjMuIHRhcmdldCBjcHUgIHg4Nl82NCwKICAgIGhvc3Qg
Y3B1OiAgYXJtdjgKICAgIGVtdWxhdGlvbk9TOiB1YnVudHVfZGVza3RvcF9hbWQ2NC5pc28KICAg
IGt2bTogIGVuYWJsZWQKCgpteSBxdWVzdGlvbiBpczoKc2NlbmFyaW8gMTogIGRpZCB0aGUgdGNn
IHRyYW5zbGF0aW9uIG5lZWQgdG8gYmUgZG9uZSBpbiB0aGlzIGNhc2Ugbm93IHRoYXQgdGhlIGhv
c3QgYW5kIHRhcmdldCBhcmNoIGlzIHRoZSBzYW1lPyAgb3IgIGxldCB0aGUga3ZtIGVtdWxhdGlv
biB0aGUgc3lzdGVtIHdpdCB0aGUgb3JpZ2luYWwgaW5zdHJ1Y3Rpb25zIHdpdGggb3V0IHRoZSBU
Q0cgICB0cmFuc2xhdGlvbqO/CnNjZW5hcmlvIDI6ICAgdGhlIHByZSBjb25kaXRpb24gaXMgc2Ft
ZSB3aXRoIHNjZW5hcmlvIDEgZXhjZXB0IHRoZSBrdm0gaXMgZGlzYWJsZaO/IHNvICxpbiB0aGlz
IHNjZW5hcmlvLCB0aGUgVENHIG11c3QgYmUgdXNlZCBpbiBvcmRlciB0byB0aGUgcHVyZSBzb2Z0
d2FyZSBlbXVsYXRpb24gd2l0aG91dCBhY2NlbGVyYXRpb24/CnNjZW5hcmlvIDM6ICBpbiB0aGlz
IHNjZW5hcmlvLCB0aGUgaG9zdCBhbmQgdGFyZ2V0IGFyY2ggaXMgbm90IHRoZSBzYW1lLCBzbyBo
b3cgdG8gdXNlIHRoZSAia3ZtIG1lY2hhaW5zaW0iIGluIHRoaXMgY2FzZT8gIHNvIHRoZSBpbnN0
cnVjdGlvbnMgZmVlZCB0byB0aGUga3ZtIG1vZHVsZSB0byBydW4gbXVzdCBiZSB0cmFuc2xhdGVk
IEJ5IFRDRyBtb2R1bGU/IHJpZ2h0PwoKCnRoYW5rcyBmb3IgeW91ciBraW5kbHkgc3VwcG9ydCBm
b3IgbXkgcHV6emxlLgoKCg==
