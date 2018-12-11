Received: from eggs.gnu.org ([2001:4830:134:3::10]:33710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gWk2h-0007Ef-M5
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gWk2d-0005mK-IU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:33:51 -0500
Resent-Message-Id: <E1gWk2d-0005mK-IU@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gWk2d-0005lZ-AL
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:33:47 -0500
In-Reply-To: <20181211143745.17342-1-cfergeau@redhat.com>
Message-ID: <154454241047.23.14882812318008967995@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 11 Dec 2018 07:33:31 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] spice: Make logging printing go through
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cfergeau@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE4MTIxMTE0Mzc0NS4xNzM0
Mi0xLWNmZXJnZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTgxMjExMTQzNzQ1LjE3MzQyLTEtY2ZlcmdlYXVA
cmVkaGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBzcGljZTogTWFrZSBsb2dn
aW5nIHByaW50aW5nIGdvIHRocm91Z2ggUUVNVQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0t
b25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBs
b2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8K
ICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3Jt
YXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAg
ICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZWJhNmMwZCBzcGlj
ZTogTWFrZSBsb2dnaW5nIHByaW50aW5nIGdvIHRocm91Z2ggUUVNVQoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBzcGljZTogTWFrZSBsb2dnaW5nIHByaW50aW5nIGdv
IHRocm91Z2ggUUVNVS4uLgpFUlJPUjogc3dpdGNoIGFuZCBjYXNlIHNob3VsZCBiZSBhdCB0aGUg
c2FtZSBpbmRlbnQKIzMzOiBGSUxFOiB1aS9zcGljZS1jb3JlLmM6NjQwOgorICAgIHN3aXRjaCAo
bG9nX2xldmVsICYgR19MT0dfTEVWRUxfTUFTSykgeworICAgICAgICBjYXNlIEdfTE9HX0xFVkVM
X0RFQlVHOgpbLi4uXQorICAgICAgICBjYXNlIEdfTE9HX0xFVkVMX0lORk86ClsuLi5dCisgICAg
ICAgIGNhc2UgR19MT0dfTEVWRUxfTUVTU0FHRToKWy4uLl0KKyAgICAgICAgY2FzZSBHX0xPR19M
RVZFTF9XQVJOSU5HOgpbLi4uXQorICAgICAgICBjYXNlIEdfTE9HX0xFVkVMX0NSSVRJQ0FMOgpb
Li4uXQorICAgICAgICBjYXNlIEdfTE9HX0xFVkVMX0VSUk9SOgoKdG90YWw6IDEgZXJyb3JzLCAw
IHdhcm5pbmdzLCAzNyBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE4MTIxMTE0Mzc0NS4xNzM0Mi0xLWNmZXJnZWF1QHJlZGhhdC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
