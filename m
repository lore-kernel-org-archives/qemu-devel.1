Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ewIMQ-00044p-Qq
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 22:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ewIMM-0001CF-Ds
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 22:11:18 -0400
Resent-Message-Id: <E1ewIMM-0001CF-Ds@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ewIMM-0001B3-50
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 22:11:14 -0400
In-Reply-To: <20180314142133.14166-1-drjones@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152103749688.51.951110294839758890@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 14 Mar 2018 07:24:57 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory: more descriptive
 lookup_type failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: drjones@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com, lersek@redhat.com, marcandre.lureau@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMzE0MTQyMTMzLjE0MTY2LTEtZHJqb25lc0ByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGR1bXAtZ3Vlc3QtbWVtb3J5OiBtb3JlIGRlc2NyaXB0
aXZlIGxvb2t1cF90eXBlIGZhaWx1cmUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
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
ICAgICAgICAgIHBhdGNoZXcvMjAxODAzMTQxNDIxMzMuMTQxNjYtMS1kcmpvbmVzQHJlZGhhdC5j
b20gLT4gcGF0Y2hldy8yMDE4MDMxNDE0MjEzMy4xNDE2Ni0xLWRyam9uZXNAcmVkaGF0LmNvbQpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhkYmEyMjA2OTQgZHVtcC1ndWVzdC1tZW1v
cnk6IG1vcmUgZGVzY3JpcHRpdmUgbG9va3VwX3R5cGUgZmFpbHVyZQoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBkdW1wLWd1ZXN0LW1lbW9yeTogbW9yZSBkZXNjcmlw
dGl2ZSBsb29rdXBfdHlwZSBmYWlsdXJlLi4uCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiMzNDogRklMRTogc2NyaXB0cy9kdW1wLWd1ZXN0LW1lbW9yeS5weToyMjoKKyAgICByYWlz
ZSBnZGIuR2RiRXJyb3IoIlN5bWJvbHMgbXVzdCBiZSBsb2FkZWQgcHJpb3IgdG8gc291cmNpbmcg
ZHVtcC1ndWVzdC1tZW1vcnkuXG4iCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzM1
OiBGSUxFOiBzY3JpcHRzL2R1bXAtZ3Vlc3QtbWVtb3J5LnB5OjIzOgorICAgICAgICAgICAgICAg
ICAgICAgICAiU3ltYm9scyBtYXkgYmUgbG9hZGVkIGJ5IGZpcnN0ICdhdHRhY2gnaW5nIGEgUUVN
VSBwcm9jZXNzIGlkIG9yIGJ5ICdsb2FkJ2luZyBhIFFFTVUgYmluYXJ5LiIpCgp0b3RhbDogMSBl
cnJvcnMsIDEgd2FybmluZ3MsIDEyIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
