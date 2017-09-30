Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dyFoI-0002Yq-IE
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 07:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dyFoF-0001FQ-Mu
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 07:19:54 -0400
Resent-Message-Id: <E1dyFoF-0001FQ-Mu@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dyFoF-0001CQ-9o
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 07:19:51 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150676401986.93.8156901515684423207@b58463cdfd5f>
In-Reply-To: <20170930090240.23729-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 30 Sep 2017 02:33:40 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFC PATCH] tests/tcg: add write tests for nbyte =
 0
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: carenas@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.com, zhuoweizhang@yahoo.com, laurent@vivier.eu
List-ID: <qemu-devel.nongnu.org>

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwOTMwMDkwMjQwLjIzNzI5LTEtY2FyZW5hc0BnbWFpbC5jb20KU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtSRkMgUEFUQ0hdIHRlc3RzL3RjZzogYWRkIHdyaXRlIHRlc3RzIGZv
ciBuYnl0ZSA9IDAKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9
YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxl
ZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0t
cmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2lu
ZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAg
IGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZp
CiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmUxYTQ1YjJhOGYgdGVzdHMvdGNnOiBhZGQgd3Jp
dGUgdGVzdHMgZm9yIG5ieXRlID0gMAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFU
Q0ggMS8xOiB0ZXN0cy90Y2c6IGFkZCB3cml0ZSB0ZXN0cyBmb3IgbmJ5dGUgPSAwLi4uCkVSUk9S
OiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQK
IzEwMzogRklMRTogdGVzdHMvdGNnL2xpbnV4LXRlc3QuYzoxMTI6CisgICAgaWYgKGxlbiAhPSAw
KQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0
aGlzIHN0YXRlbWVudAojMTA2OiBGSUxFOiB0ZXN0cy90Y2cvbGludXgtdGVzdC5jOjExNToKKyAg
ICBpZiAobGVuICE9IDApClsuLi5dCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiMxMDc6IEZJTEU6IHRlc3RzL3RjZy9saW51eC10ZXN0LmM6MTE2OgorXkllcnJvcigi
d3JpdGUgTlVMTCBidWYiKTskCgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzEx
NjogRklMRTogdGVzdHMvdGNnL2xpbnV4LXRlc3QuYzo1NDM6CisgICAgLy90ZXN0X3NpZ25hbCgp
OwoKdG90YWw6IDQgZXJyb3JzLCAwIHdhcm5pbmdzLCA3MiBsaW5lcyBjaGVja2VkCgpZb3VyIHBh
dGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
