Received: from eggs.gnu.org ([2001:4830:134:3::10]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dFz2C-0001vX-Hp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dFz28-0006Ay-6b
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:31:16 -0400
Resent-Message-Id: <E1dFz28-0006Ay-6b@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dFz27-0006Af-Tl
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:31:12 -0400
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170531075814.4851-1-slyfox@gentoo.org>
Message-ID: <149621942864.1217.16705181218943765818@f98a8425f76e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 31 May 2017 01:30:29 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] alpha-user: wire epoll_create, epoll_ctl,
 epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: slyfox@gentoo.org
Cc: famz@redhat.com, peter.maydell@linaro.org, riku.voipio@iki.fi, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwNTMxMDc1ODE0LjQ4NTEtMS1zbHlmb3hAZ2VudG9vLm9yZwpTdWJqZWN0
OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyXSBhbHBoYS11c2VyOiB3aXJlIGVwb2xsX2NyZWF0ZSwg
ZXBvbGxfY3RsLCBlcG9sbF93YWl0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdj
IC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZv
cm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNo
byAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAk
YykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBl
Y2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4OTIxN2ZkIGFscGhhLXVzZXI6
IHdpcmUgZXBvbGxfY3JlYXRlLCBlcG9sbF9jdGwsIGVwb2xsX3dhaXQKCj09PSBPVVRQVVQgQkVH
SU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogYWxwaGEtdXNlcjogd2lyZSBlcG9sbF9jcmVhdGUs
IGVwb2xsX2N0bCwgZXBvbGxfd2FpdC4uLgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiM0MTogRklMRTogbGludXgtdXNlci9hbHBoYS9zeXNjYWxsX25yLmg6MzQ2Ogor
I2RlZmluZSBUQVJHRVRfTlJfZXBvbGxfY3JlYXRlXkleSV5JNDA3JAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDI6IEZJTEU6IGxpbnV4LXVzZXIvYWxwaGEvc3lz
Y2FsbF9uci5oOjM0NzoKKyNkZWZpbmUgVEFSR0VUX05SX2Vwb2xsX2N0bF5JXkleSTQwOCQKCkVS
Uk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzQzOiBGSUxFOiBsaW51eC11
c2VyL2FscGhhL3N5c2NhbGxfbnIuaDozNDg6CisjZGVmaW5lIFRBUkdFVF9OUl9lcG9sbF93YWl0
XkleSV5JNDA5JAoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNyBsaW5lcyBjaGVja2Vk
CgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
