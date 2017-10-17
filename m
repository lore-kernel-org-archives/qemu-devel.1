Received: from eggs.gnu.org ([2001:4830:134:3::10]:38608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e4cL2-0005cc-SY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e4cKz-0004Zc-NO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:36:00 -0400
Resent-Message-Id: <E1e4cKz-0004Zc-NO@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e4cKz-0004XR-Ba
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:35:57 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150828419145.368.17867352006215177263@b58463cdfd5f>
In-Reply-To: <20171017225025.25451-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 17 Oct 2017 16:49:52 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hw/alpha/typhoon: simplify using the
 "unimplemented" sysbus device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org
Cc: famz@redhat.com, rth@twiddle.net, peter.maydell@linaro.org, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDE3MjI1MDI1LjI1NDUxLTEtZjRidWdAYW1zYXQub3JnClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0hdIGh3L2FscGhhL3R5cGhvb246IHNpbXBsaWZ5IHVzaW5nIHRo
ZSAidW5pbXBsZW1lbnRlZCIgc3lzYnVzIGRldmljZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
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
ZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvY292ZXIuMTUwODI3OTQyMS5n
aXQuYWxpc3RhaXIuZnJhbmNpc0B4aWxpbnguY29tIC0+IHBhdGNoZXcvY292ZXIuMTUwODI3OTQy
MS5naXQuYWxpc3RhaXIuZnJhbmNpc0B4aWxpbnguY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKN2EzOTEwZjdiMiBody9hbHBoYS90eXBob29uOiBzaW1wbGlmeSB1c2luZyB0aGUg
InVuaW1wbGVtZW50ZWQiIHN5c2J1cyBkZXZpY2UKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogaHcvYWxwaGEvdHlwaG9vbjogc2ltcGxpZnkgdXNpbmcgdGhlICJ1bmlt
cGxlbWVudGVkIiBzeXNidXMgZGV2aWNlLi4uCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5k
IHRoYXQgJyonIChjdHg6VnhWKQojODI6IEZJTEU6IGh3L2FscGhhL3R5cGhvb24uYzo4ODA6Cisg
ICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJwY2kwLWlvIiwgMHg4MDFmYzAwMDAwMFVM
TCwgMzIqTUIpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1NyBsaW5l
cyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9y
Zw==
