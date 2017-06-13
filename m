Received: from eggs.gnu.org ([2001:4830:134:3::10]:37515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dKiux-0000FV-EY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dKiut-00057p-Gt
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:19:23 -0400
Resent-Message-Id: <E1dKiut-00057p-Gt@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dKiut-00057T-7t
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:19:19 -0400
In-Reply-To: <1497346256-10073-1-git-send-email-gi-oh.kim@profitbricks.com>
Message-ID: <149734914886.12819.8513153919786826492@84b42461e25a>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 13 Jun 2017 03:19:09 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: drain block before cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gi-oh.kim@profitbricks.com
Cc: famz@redhat.com, pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHZpcnRpby1ibGs6IGRyYWluIGJsb2NrIGJlZm9y
ZSBjbGVhbnVwCk1lc3NhZ2UtaWQ6IDE0OTczNDYyNTYtMTAwNzMtMS1naXQtc2VuZC1lbWFpbC1n
aS1vaC5raW1AcHJvZml0YnJpY2tzLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4g
fCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cg
LS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAg
IGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9
JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAg
ICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTQ5NzM0NjU5My04NzkxLTEtZ2l0LXNlbmQtZW1h
aWwtYS5wZXJldmFsb3ZAc2Ftc3VuZy5jb20gLT4gcGF0Y2hldy8xNDk3MzQ2NTkzLTg3OTEtMS1n
aXQtc2VuZC1lbWFpbC1hLnBlcmV2YWxvdkBzYW1zdW5nLmNvbQogKiBbbmV3IHRhZ10gICAgICAg
ICBwYXRjaGV3LzE0OTczNDg1MTUtNjM5MS0xLWdpdC1zZW5kLWVtYWlsLXNiYXRlc0ByYWl0aGxp
bi5jb20gLT4gcGF0Y2hldy8xNDk3MzQ4NTE1LTYzOTEtMS1naXQtc2VuZC1lbWFpbC1zYmF0ZXNA
cmFpdGhsaW4uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNGI5ODFkNiB2aXJ0
aW8tYmxrOiBkcmFpbiBibG9jayBiZWZvcmUgY2xlYW51cAoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
Q2hlY2tpbmcgUEFUQ0ggMS8xOiB2aXJ0aW8tYmxrOiBkcmFpbiBibG9jayBiZWZvcmUgY2xlYW51
cC4uLgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMg
c3RhdGVtZW50CiMxNTc6IEZJTEU6IGh3L2Jsb2NrL3ZpcnRpby1ibGsuYzo5NzY6CisgICAgaWYg
KGJsa19icyhzLT5ibGspICYmIGJkcnZfcmVxdWVzdHNfcGVuZGluZygoYmxrX2JzKHMtPmJsaykp
KSkKWy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2VkCgpZ
b3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
