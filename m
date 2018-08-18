Received: from eggs.gnu.org ([2001:4830:134:3::10]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fqskK-0002Og-V7
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 00:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fqskJ-0006CQ-0Y
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 00:21:52 -0400
Resent-Message-Id: <E1fqskJ-0006CQ-0Y@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fqskI-0006Ac-Mi
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 00:21:50 -0400
In-Reply-To: <1534507432-2873-1-git-send-email-hans-erik.floryd@rt-labs.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153456608089.27000.15815652232399697540@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 17 Aug 2018 21:21:22 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] sdhci: add i.MX SD Stable Clock bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hans-erik.floryd@rt-labs.com
Cc: famz@redhat.com, qemu-trivial@nongnu.org, f4bug@amsat.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MzQ1MDc0MzItMjg3My0xLWdpdC1zZW5kLWVtYWlsLWhhbnMtZXJpay5mbG9y
eWRAcnQtbGFicy5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gc2RoY2k6IGFk
ZCBpLk1YIFNEIFN0YWJsZSBDbG9jayBiaXQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4u
IHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUgg
LS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNr
aW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgog
ICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNo
LnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAg
ZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZGQ4ZDY5NTIwNCBzZGhjaTogYWRkIGkuTVgg
U0QgU3RhYmxlIENsb2NrIGJpdAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0gg
MS8xOiBzZGhjaTogYWRkIGkuTVggU0QgU3RhYmxlIENsb2NrIGJpdC4uLgpFUlJPUjogc3VzcGVj
dCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cyAoNywgMTApCiMzNDogRklM
RTogaHcvc2Qvc2RoY2kuYzoxNjU3OgorICAgICAgIGlmIChzLT5jbGtjb24gJiBTREhDX0NMT0NL
X0lOVF9TVEFCTEUpIHsKKyAgICAgICAgICByZXQgfD0gRVNESENfUFJOU1RTX1NEU1RCOwoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
