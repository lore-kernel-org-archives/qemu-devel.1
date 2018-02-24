Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1epUie-0001JC-OF
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 02:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1epUia-00066k-8t
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 02:58:08 -0500
Resent-Message-Id: <E1epUia-00066k-8t@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1epUia-00065A-0f
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 02:58:04 -0500
In-Reply-To: <alpine.LSU.2.21.1802231729040.10187@wotan.suse.de>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151945905143.936.8470010691200923247@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 23 Feb 2018 23:57:32 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix size of ppc64 xer register (fwd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: matz@suse.de
Cc: famz@redhat.com, qemu-devel@nongnu.org, duwe@suse.de

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IGFscGluZS5MU1UuMi4yMS4xODAyMjMxNzI5MDQwLjEwMTg3QHdvdGFuLnN1c2Uu
ZGUKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gcHBjOiBGaXggc2l6ZSBvZiBwcGM2NCB4
ZXIgcmVnaXN0ZXIgKGZ3ZCkKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
CkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwp
CmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNl
ICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENI
ICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBn
aXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49
JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRh
dGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKNDFiMjU4NWY0ZCBwcGM6IEZpeCBzaXplIG9mIHBwYzY0IHhl
ciByZWdpc3RlciAoZndkKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8x
OiBwcGM6IEZpeCBzaXplIG9mIHBwYzY0IHhlciByZWdpc3RlciAoZndkKS4uLgpFUlJPUjogc3Bh
Y2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcrJyAoY3R4OlZ4VikKIzM5OiBGSUxFOiB0YXJnZXQv
cHBjL2dkYnN0dWIuYzo0MzoKKyAgICBjYXNlIDY5KzMyOiAvKiB4ZXIgKi8KICAgICAgICAgICAg
XgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1OSBsaW5lcyBjaGVja2VkCgpZb3VyIHBh
dGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
