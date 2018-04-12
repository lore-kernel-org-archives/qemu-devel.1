Received: from eggs.gnu.org ([2001:4830:134:3::10]:50681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f6W66-0002YT-Jp
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 02:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f6W63-0007TT-I1
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 02:52:42 -0400
Resent-Message-Id: <E1f6W63-0007TT-I1@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f6W63-0007So-8A
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 02:52:39 -0400
In-Reply-To: <20180412060358.9118-1-peterx@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152351322708.1854.4413712485366884044@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 11 Apr 2018 23:07:08 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNDEyMDYwMzU4LjkxMTgtMS1wZXRlcnhAcmVkaGF0LmNvbQpTdWJqZWN0
OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyXSBtb25pdG9yOiBsZXQgY3VyX21vbiBiZSBwZXItdGhy
ZWFkCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9y
IGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQo
Z2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1m
b3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4K
ICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUK
CmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIw
MTgwNDEyMDYwMzU4LjkxMTgtMS1wZXRlcnhAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTgwNDEy
MDYwMzU4LjkxMTgtMS1wZXRlcnhAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCmU4OThmYThkZTMgbW9uaXRvcjogbGV0IGN1cl9tb24gYmUgcGVyLXRocmVhZAoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBtb25pdG9yOiBsZXQgY3VyX21v
biBiZSBwZXItdGhyZWFkLi4uCkVSUk9SOiBkbyBub3QgaW5pdGlhbGlzZSBnbG9iYWxzIHRvIDAg
b3IgTlVMTAojNjI6IEZJTEU6IHN0dWJzL21vbml0b3IuYzo2OgorX190aHJlYWQgTW9uaXRvciAq
Y3VyX21vbiA9IE5VTEw7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDMyIGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
