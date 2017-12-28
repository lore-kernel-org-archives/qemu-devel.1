Received: from eggs.gnu.org ([2001:4830:134:3::10]:46756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eUfqb-0003SQ-VN
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 16:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eUfqX-0001bF-82
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 16:36:17 -0500
Resent-Message-Id: <E1eUfqX-0001bF-82@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eUfqW-0001Te-QU
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 16:36:13 -0500
In-Reply-To: <20171228193439.18835-1-samuel.thibault@ens-lyon.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151449053317.129.7495793563712670263@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 28 Dec 2017 11:48:54 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMjI4MTkzNDM5LjE4ODM1LTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9u
Lm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBsaW51eC11c2VyOiBGaXggc2NoZWRf
Z2V0L3NldGFmZmluaXR5IGNvbnZlcnNpb24KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4u
IHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9n
IC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAg
ICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0
PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAg
ICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjEwMTQ3MDJmMWIgbGlu
dXgtdXNlcjogRml4IHNjaGVkX2dldC9zZXRhZmZpbml0eSBjb252ZXJzaW9uCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGxpbnV4LXVzZXI6IEZpeCBzY2hlZF9nZXQv
c2V0YWZmaW5pdHkgY29udmVyc2lvbi4uLgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMK
IzI0OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzo3NzE5Ogorc3RhdGljIGludCB0YXJnZXRf
dG9faG9zdF9jcHVfbWFzayh1bnNpZ25lZCBsb25nICpob3N0X21hc2ssIHNpemVfdCBob3N0X3Np
emUsIGFiaV91bG9uZyB0YXJnZXRfYWRkciwgc2l6ZV90IHRhcmdldF9zaXplKQoKRVJST1I6IGxp
bmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1NTogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6Nzc1
MDoKK3N0YXRpYyBpbnQgaG9zdF90b190YXJnZXRfY3B1X21hc2soY29uc3QgdW5zaWduZWQgbG9u
ZyAqaG9zdF9tYXNrLCBzaXplX3QgaG9zdF9zaXplLCBhYmlfdWxvbmcgdGFyZ2V0X2FkZHIsIHNp
emVfdCB0YXJnZXRfc2l6ZSkKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTAxIGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
