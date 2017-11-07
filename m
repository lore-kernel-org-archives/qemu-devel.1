Received: from eggs.gnu.org ([2001:4830:134:3::10]:34199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eC6nA-0003H0-TJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eC6n6-0001mN-LV
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:32:00 -0500
Resent-Message-Id: <E1eC6n6-0001mN-LV@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eC6n6-0001f8-Et
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:31:56 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151005871486.339.6119121339899699894@bafd83ae6430>
In-Reply-To: <20171107122234.8439-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 7 Nov 2017 04:45:15 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] disas: Dump insn bytes along with capstone
 disassembly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gZGlzYXM6IER1bXAgaW5zbiBieXRlcyBhbG9uZyB3aXRoIGNhcHN0b25l
IGRpc2Fzc2VtYmx5ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE3MTEwNzEyMjIzNC44NDM5
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxNzExMDcxMjIyMzQuODQz
OS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE3MTEwNzEyMjIz
NC44NDM5LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCjA4NzNjNjcxZGYgZGlzYXM6IER1bXAgaW5zbiBieXRlcyBhbG9uZyB3aXRo
IGNhcHN0b25lIGRpc2Fzc2VtYmx5Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRD
SCAxLzE6IGRpc2FzOiBEdW1wIGluc24gYnl0ZXMgYWxvbmcgd2l0aCBjYXBzdG9uZSBkaXNhc3Nl
bWJseS4uLgpFUlJPUjogc3VzcGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVt
ZW50cyAoOCwgMTEpCiM5ODogRklMRTogZGlzYXMuYzozMTU6CiAgICAgICAgIHdoaWxlIChjc19k
aXNhc21faXRlcihoYW5kbGUsICZjYnVmLCAmY3NpemUsICZwYywgaW5zbikpIHsKKyAgICAgICAg
ICAgY2FwX2R1bXBfaW5zbihpbmZvLCBpbnNuKTsKCkVSUk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50
IGZvciBjb25kaXRpb25hbCBzdGF0ZW1lbnRzICg0LCA3KQojMTEwOiBGSUxFOiBkaXNhcy5jOjM2
MDoKICAgICB3aGlsZSAoY3NfZGlzYXNtX2l0ZXIoaGFuZGxlLCAmY2J1ZiwgJnNpemUsICZwYywg
aW5zbikpIHsKKyAgICAgICBjYXBfZHVtcF9pbnNuKGluZm8sIGluc24pOwoKdG90YWw6IDIgZXJy
b3JzLCAwIHdhcm5pbmdzLCAxODQgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
