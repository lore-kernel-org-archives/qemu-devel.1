Received: from eggs.gnu.org ([2001:4830:134:3::10]:60052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cQY6Q-0003RY-My
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cQY6M-0001sk-PC
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:27:02 -0500
Resent-Message-Id: <E1cQY6M-0001sk-PC@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cQY6M-0001sG-GJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:26:58 -0500
In-Reply-To: <20170109112338.5629-1-rka@sysgo.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148396120962.205.623546213408864755@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 9 Jan 2017 03:26:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] ppc: Prevent inifnite loop in decrementer
 auto-reload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rka@sysgo.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzAxMDkxMTIzMzguNTYyOS0xLXJrYUBzeXNnby5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIHBwYzogUHJldmVudCBpbmlmbml0ZSBsb29wIGluIGRlY3JlbWVu
dGVyIGF1dG8tcmVsb2FkLgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoK
QkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkK
ZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRz
PSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29t
bWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1u
IDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFp
bCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZh
aWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFp
bGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNzAxMDkxMTIzMzguNTYy
OS0xLXJrYUBzeXNnby5jb20gLT4gcGF0Y2hldy8yMDE3MDEwOTExMjMzOC41NjI5LTEtcmthQHN5
c2dvLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjU3MWNhNGIgcHBjOiBQcmV2
ZW50IGluaWZuaXRlIGxvb3AgaW4gZGVjcmVtZW50ZXIgYXV0by1yZWxvYWQuCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHBwYzogUHJldmVudCBpbmlmbml0ZSBsb29w
IGluIGRlY3JlbWVudGVyIGF1dG8tcmVsb2FkLi4uLgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVm
b3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwojMzA6IEZJTEU6IGh3L3BwYy9wcGNfYm9va2Uu
YzoyMDM6CisgICAgICAgIGlmKGVudi0+c3ByW1NQUl9CT09LRV9ERUNBUl0gIT0gMCkgewoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
