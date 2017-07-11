Received: from eggs.gnu.org ([2001:4830:134:3::10]:54912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dUvfh-0005fw-O0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dUvfd-0004WK-1i
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:49 -0400
Resent-Message-Id: <E1dUvfd-0004WK-1i@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dUvfc-0004Vd-Oc
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:44 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149978145402.30.2091050176413200089@5d477a5b5989>
In-Reply-To: <20170711060802.00005020@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 11 Jul 2017 06:57:34 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] xen-mapcache: Fix the bug when overlapping
 emulated DMA operations may cause inconsistency in guest memory mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: x1917x@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHhlbi1tYXBjYWNoZTogRml4IHRoZSBidWcgd2hl
biBvdmVybGFwcGluZyBlbXVsYXRlZCBETUEgb3BlcmF0aW9ucyBtYXkgY2F1c2UgaW5jb25zaXN0
ZW5jeSBpbiBndWVzdCBtZW1vcnkgbWFwcGluZ3MKTWVzc2FnZS1pZDogMjAxNzA3MTEwNjA4MDIu
MDAwMDUwMjBAZ21haWwuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1s
KQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1h
dD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAi
Q2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYyku
Li4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hv
CiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiNGI4YWMwIHhlbi1tYXBjYWNoZTog
Rml4IHRoZSBidWcgd2hlbiBvdmVybGFwcGluZyBlbXVsYXRlZCBETUEgb3BlcmF0aW9ucyBtYXkg
Y2F1c2UgaW5jb25zaXN0ZW5jeSBpbiBndWVzdCBtZW1vcnkgbWFwcGluZ3MKCj09PSBPVVRQVVQg
QkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogeGVuLW1hcGNhY2hlOiBGaXggdGhlIGJ1ZyB3
aGVuIG92ZXJsYXBwaW5nIGVtdWxhdGVkIERNQSBvcGVyYXRpb25zIG1heSBjYXVzZSBpbmNvbnNp
c3RlbmN5IGluIGd1ZXN0IG1lbW9yeSBtYXBwaW5ncy4uLgpFUlJPUjogZWxzZSBzaG91bGQgZm9s
bG93IGNsb3NlIGJyYWNlICd9JwojMTY4OiBGSUxFOiBody9pMzg2L3hlbi94ZW4tbWFwY2FjaGUu
YzoyNjg6CisgICAgICAgIH0KKyAgICAgICAgZWxzZSBpZiAoIWVudHJ5LT5sb2NrIHx8ICFlbnRy
eS0+dmFkZHJfYmFzZSkgewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA0OCBsaW5lcyBj
aGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
