Received: from eggs.gnu.org ([2001:4830:134:3::10]:59522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fBj5V-0002vM-UX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fBj5R-0006mn-Qb
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:45:37 -0400
Resent-Message-Id: <E1fBj5R-0006mn-Qb@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fBj5R-0006mM-82
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:45:33 -0400
In-Reply-To: <20180426154035.16155-1-alex.bennee@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152475749180.2340.1230613596329558666@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 26 Apr 2018 08:44:52 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFC PATCH] softfloat: re-factor float to float
 conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, richard.henderson@linaro.org, aurelien@aurel32.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNDI2MTU0MDM1LjE2MTU1LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZwpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1JGQyBQQVRDSF0gc29mdGZsb2F0OiByZS1mYWN0b3IgZmxv
YXQgdG8gZmxvYXQgY29udmVyc2lvbnMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwg
d2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1y
ZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5n
IFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAg
aWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkK
ICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20g
aHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAg
ICAgICAgICAgIHBhdGNoZXcvMjAxODA0MjYxNTQwMzUuMTYxNTUtMS1hbGV4LmJlbm5lZUBsaW5h
cm8ub3JnIC0+IHBhdGNoZXcvMjAxODA0MjYxNTQwMzUuMTYxNTUtMS1hbGV4LmJlbm5lZUBsaW5h
cm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOWUyODgxM2NiMCBzb2Z0Zmxv
YXQ6IHJlLWZhY3RvciBmbG9hdCB0byBmbG9hdCBjb252ZXJzaW9ucwoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBzb2Z0ZmxvYXQ6IHJlLWZhY3RvciBmbG9hdCB0byBm
bG9hdCBjb252ZXJzaW9ucy4uLgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCBj
bG9zZSBwYXJlbnRoZXNpcyAnKScKIzEwMzogRklMRTogZnB1L3NvZnRmbG9hdC5jOjEyMTY6Cisg
ICAgICAgIGlmIChpc19zbmFuKGEuY2xzKSB8fCBhcm1faHAgKSB7Cgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDU2NSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==
