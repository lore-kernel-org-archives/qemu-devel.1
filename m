Received: from eggs.gnu.org ([2001:4830:134:3::10]:52322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ewWKC-00080o-Lw
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ewWK8-0007VJ-FL
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:05:56 -0400
Resent-Message-Id: <E1ewWK8-0007VJ-FL@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ewWK8-0007Sm-7m
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:05:52 -0400
In-Reply-To: <20180315151348.6451-1-james.cowgill@mips.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152112716428.51.16694361292656461880@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 15 Mar 2018 08:19:25 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: james.cowgill@mips.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu, richard.henderson@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMzE1MTUxMzQ4LjY0NTEtMS1qYW1lcy5jb3dnaWxsQG1pcHMuY29tClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGxpbnV4LXVzZXI6IGltcGxlbWVudCBIV0NB
UCBiaXRzIG9uIE1JUFMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJB
U0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZh
aWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0
aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRC
QVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRu
LyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQg
c2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgo
bisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIDYyNjVlMjNiMWMuLjU2ZTg2OThmZmEg
IG1hc3RlciAgICAgLT4gbWFzdGVyCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcv
MjAxODAzMTUxMTUxNDQuODAxMjAyLTEtZWJsYWtlQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE4
MDMxNTExNTE0NC44MDEyMDItMS1lYmxha2VAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTgwMzE1MTUxMzQ4LjY0NTEtMS1qYW1lcy5jb3dnaWxsQG1pcHMu
Y29tIC0+IHBhdGNoZXcvMjAxODAzMTUxNTEzNDguNjQ1MS0xLWphbWVzLmNvd2dpbGxAbWlwcy5j
b20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozMWVkM2IzNGRmIGxpbnV4LXVzZXI6
IGltcGxlbWVudCBIV0NBUCBiaXRzIG9uIE1JUFMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogbGludXgtdXNlcjogaW1wbGVtZW50IEhXQ0FQIGJpdHMgb24gTUlQUy4u
LgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3Rh
dGVtZW50CiMzNTogRklMRTogbGludXgtdXNlci9lbGZsb2FkLmM6OTY3OgorICAgIGRvIHsgaWYg
KGNwdS0+ZW52Lmluc25fZmxhZ3MgJiAoZmxhZykpIHsgaHdjYXBzIHw9IGh3Y2FwOyB9IH0gd2hp
bGUgKDApClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDMwIGxpbmVzIGNoZWNr
ZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
