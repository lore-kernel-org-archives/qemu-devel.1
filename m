Received: from eggs.gnu.org ([2001:4830:134:3::10]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eOMmG-0004c8-KR
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eOMmD-0006dG-CR
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:01:44 -0500
Resent-Message-Id: <E1eOMmD-0006dG-CR@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eOMmD-0006cQ-5O
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:01:41 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151299275349.23197.16691982233632890977@bfc911d3884a>
In-Reply-To: <20171207145816.87347-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 11 Dec 2017 03:45:55 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH/RFC v2] s390x: start a new memory region if
 the old one exceeds KVM_MEM_MAX_NR_PAGES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: famz@redhat.com, cohuck@redhat.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzEyMDcxNDU4MTYuODczNDctMS1ib3JudHJhZWdlckBkZS5pYm0uY29tClN1YmplY3Q6IFtRZW11
LWRldmVsXSBbUEFUQ0gvUkZDIHYyXSBzMzkweDogc3RhcnQgYSBuZXcgbWVtb3J5IHJlZ2lvbiBp
ZiB0aGUgb2xkIG9uZSBleGNlZWRzIEtWTV9NRU1fTUFYX05SX1BBR0VTClR5cGU6IHNlcmllcwoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3Rh
bD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNF
Li4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0
b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hv
dyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
LTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisx
KSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAz
YzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRo
dWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBh
dGNoZXcvMjAxNzEyMDgwMDU4MjUuMTQ1ODctMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20g
LT4gcGF0Y2hldy8yMDE3MTIwODAwNTgyNS4xNDU4Ny0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjI4ZWJkZWU5ZTggczM5MHg6IHN0
YXJ0IGEgbmV3IG1lbW9yeSByZWdpb24gaWYgdGhlIG9sZCBvbmUgZXhjZWVkcyBLVk1fTUVNX01B
WF9OUl9QQUdFUwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBzMzkw
eDogc3RhcnQgYSBuZXcgbWVtb3J5IHJlZ2lvbiBpZiB0aGUgb2xkIG9uZSBleGNlZWRzIEtWTV9N
RU1fTUFYX05SX1BBR0VTLi4uCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJlZm9yZSB0aGF0IGNs
b3NlIHBhcmVudGhlc2lzICcpJwojMzE6IEZJTEU6IGh3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5j
OjE2MToKKyNkZWZpbmUgS1ZNX1NMT1RfTUFYICgoKCgxVUwgPDwgMzEpIC0gMSkgKiA0MDk2KSAm
IH4weGZmZmZmVUwgKQoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
NTg6IEZJTEU6IGh3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jOjE4NToKK15JbnVtYmVyKys7JAoK
dG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA0NCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNo
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
