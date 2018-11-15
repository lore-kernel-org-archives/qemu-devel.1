Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gNEEs-0002FJ-3a
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gNEEp-0007RM-E7
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:47:06 -0500
Resent-Message-Id: <E1gNEEp-0007RM-E7@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gNEEp-0007Qh-5O
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:47:03 -0500
In-Reply-To: <20181115032259.23968-1-sjitindarsingh@gmail.com>
Message-ID: <154227427764.21.9537354069267579390@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 15 Nov 2018 01:31:18 -0800 (PST)
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: tcg: Implement
 addex instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sjitindarsingh@gmail.com
Cc: famz@redhat.com, qemu-ppc@nongnu.org, tg@gmplib.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
ODExMTUwMzIyNTkuMjM5NjgtMS1zaml0aW5kYXJzaW5naEBnbWFpbC5jb20KVHlwZTogc2VyaWVz
ClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUUVNVS1QUENdIFtQQVRDSF0gdGFyZ2V0L3BwYzogdGNn
OiBJbXBsZW1lbnQgYWRkZXggaW5zdHJ1Y3Rpb24KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9
JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNo
ZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4u
IgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwog
ICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMTFhYzg3YSB0YXJnZXQvcHBjOiB0Y2c6
IEltcGxlbWVudCBhZGRleCBpbnN0cnVjdGlvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tp
bmcgUEFUQ0ggMS8xOiB0YXJnZXQvcHBjOiB0Y2c6IEltcGxlbWVudCBhZGRleCBpbnN0cnVjdGlv
bi4uLgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCiM0MTog
RklMRTogZGlzYXMvcHBjLmM6MzczNzoKK3sgImFkZGV4IiwgICBYTygzMSwxNzAsMCwwKSwgWE9f
TUFTSywgICBQT1dFUjksICAgICAgICAgeyBSVCwgUkEsIFJCIH0gfSwKICAgICAgICAgICAgICAg
ICAgIF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzQx
OiBGSUxFOiBkaXNhcy9wcGMuYzozNzM3OgoreyAiYWRkZXgiLCAgIFhPKDMxLDE3MCwwLDApLCBY
T19NQVNLLCAgIFBPV0VSOSwgICAgICAgICB7IFJULCBSQSwgUkIgfSB9LAogICAgICAgICAgICAg
ICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4
VikKIzQxOiBGSUxFOiBkaXNhcy9wcGMuYzozNzM3OgoreyAiYWRkZXgiLCAgIFhPKDMxLDE3MCww
LDApLCBYT19NQVNLLCAgIFBPV0VSOSwgICAgICAgICB7IFJULCBSQSwgUkIgfSB9LAogICAgICAg
ICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNTYgbGlu
ZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
