Received: from eggs.gnu.org ([2001:4830:134:3::10]:59069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eDScI-00057X-DN
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 05:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eDScE-00036P-4S
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 05:02:22 -0500
Resent-Message-Id: <E1eDScE-00036P-4S@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eDScD-00034p-Ts
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 05:02:18 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151038811814.390.17991372140651087937@bafd83ae6430>
In-Reply-To: <20171111081111.32724-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 11 Nov 2017 00:15:18 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v1] highbank: validate register offset
 before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ppandit@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, robh@kernel.org, pjp@fedoraproject.org, peter.maydell@linaro.org, f4bug@amsat.org, qemu-arm@nongnu.org, shawn.guo@linaro.org, moguofang@huawei.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MV0gaGlnaGJhbms6IHZhbGlkYXRlIHJlZ2lzdGVyIG9mZnNldCBiZWZv
cmUgYWNjZXNzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE3MTExMTA4MTExMS4zMjcyNC0x
LXBwYW5kaXRAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAt
bCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3Jt
YXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8g
IkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMp
Li4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNo
bwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEz
Mzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiB0IFt0YWcg
dXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMTUxMDM0MzYyNi0yNTg2MS0xLWdpdC1zZW5kLWVt
YWlsLWNvdGFAYnJhYXAub3JnIC0+IHBhdGNoZXcvMTUxMDM0MzYyNi0yNTg2MS0xLWdpdC1zZW5k
LWVtYWlsLWNvdGFAYnJhYXAub3JnCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcv
MjAxNzEwMzAxNjMzMDkuNzU3NzAtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20gLT4gcGF0Y2hl
dy8yMDE3MTAzMDE2MzMwOS43NTc3MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbQogdCBbdGFn
IHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTcxMTEwMjIxMzI5LjI0MTc2LTEtbXJlaXR6
QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE3MTExMDIyMTMyOS4yNDE3Ni0xLW1yZWl0ekByZWRo
YXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxNzExMTEwODExMTEu
MzI3MjQtMS1wcGFuZGl0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE3MTExMTA4MTExMS4zMjcy
NC0xLXBwYW5kaXRAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjIz
ZGY4YWQwNjAgaGlnaGJhbms6IHZhbGlkYXRlIHJlZ2lzdGVyIG9mZnNldCBiZWZvcmUgYWNjZXNz
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGhpZ2hiYW5rOiB2YWxp
ZGF0ZSByZWdpc3RlciBvZmZzZXQgYmVmb3JlIGFjY2Vzcy4uLgpFUlJPUjogc3BhY2VzIHJlcXVp
cmVkIGFyb3VuZCB0aGF0ICcvJyAoY3R4OlZ4VikKIzUwOiBGSUxFOiBody9hcm0vaGlnaGJhbmsu
YzoxNDA6CisgICAgdmFsdWUgPSByZWdzW29mZnNldC80XTsKICAgICAgICAgICAgICAgICAgICAg
ICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNCBsaW5lcyBjaGVja2VkCgpZb3Vy
IHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
