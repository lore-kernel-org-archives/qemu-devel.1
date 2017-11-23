Received: from eggs.gnu.org ([2001:4830:134:3::10]:41524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eHvZl-000555-Mt
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eHvZh-0005oT-Ik
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:46:13 -0500
Resent-Message-Id: <E1eHvZh-0005oT-Ik@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eHvZh-0005nV-9h
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:46:09 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151145276935.612.7049114439414506628@bafd83ae6430>
In-Reply-To: <1511452598-6077-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 23 Nov 2017 07:59:29 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH for-2.11?] osdep.h: Make TIME_MAX handle
 different time_t types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, brad@comstyle.com, n54@gmx.com, patches@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCBmb3ItMi4xMT9dIG9zZGVwLmg6IE1ha2UgVElNRV9NQVggaGFuZGxlIGRp
ZmZlcmVudCB0aW1lX3QgdHlwZXMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1MTE0NTI1OTgt
NjA3Ny0xLWdpdC1zZW5kLWVtYWlsLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBs
b2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
Cgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3Ig
YyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChn
aXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZv
cm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgog
ICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoK
ZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMTUx
MTQ1MjU5OC02MDc3LTEtZ2l0LXNlbmQtZW1haWwtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+
IHBhdGNoZXcvMTUxMTQ1MjU5OC02MDc3LTEtZ2l0LXNlbmQtZW1haWwtcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMWZjNDZlMzhkMCBvc2Rl
cC5oOiBNYWtlIFRJTUVfTUFYIGhhbmRsZSBkaWZmZXJlbnQgdGltZV90IHR5cGVzCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IG9zZGVwLmg6IE1ha2UgVElNRV9NQVgg
aGFuZGxlIGRpZmZlcmVudCB0aW1lX3QgdHlwZXMuLi4KRVJST1I6IHNwYWNlcyByZXF1aXJlZCBh
cm91bmQgdGhhdCAnLScgKGN0eDpWeFYpCiM0MTogRklMRTogaW5jbHVkZS9xZW11L29zZGVwLmg6
MTY0OgorI2RlZmluZSBUWVBFX1NJR05FRCh0KSAoISgodCkwIDwgKHQpLTEpKQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91
bmQgdGhhdCAnLScgKGN0eDpWeFYpCiM1MTogRklMRTogaW5jbHVkZS9xZW11L29zZGVwLmg6MTc0
OgorICAgICAgICA/ICh0KS0xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgXgoKdG90YWw6IDIgZXJyb3JzLCAwIHdh
cm5pbmdzLCAzNiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAZnJlZWxpc3RzLm9yZw==
