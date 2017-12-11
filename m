Received: from eggs.gnu.org ([2001:4830:134:3::10]:52368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eOHlw-0007ym-OM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eOHlr-00035c-V8
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:41:04 -0500
Resent-Message-Id: <E1eOHlr-00035c-V8@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eOHlr-00034j-NU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:40:59 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151297444378.23194.17491359364370956694@bfc911d3884a>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 10 Dec 2017 22:40:45 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, cota@braap.orgfamz@redhat.com, stefanha@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzEyMDgxMDU1NTMuMTIyNDktMS1wYm9uemluaUByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRl
dmVsXSBbUkZDIFBBVENIIDAvNV0gU2NvcGVkIGxvY2tzIHVzaW5nIGF0dHJpYnV0ZSgoY2xlYW51
cCkpClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoK
QkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkK
ZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9
JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNo
ZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4u
IgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwog
ICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOGU5ZmZjMDQ2ZCB0aHJlYWQtcG9vbDog
Y29udmVydCB0byB1c2UgbG9jayBndWFyZHMKMDA3YjViYzdiMyBxaHQ6IGNvbnZlcnQgdG8gdXNl
IGxvY2sgZ3VhcmRzCjZmZDMzM2NhY2MgcWVtdS10aW1lcjogY29udmVydCB0byB1c2UgbG9jayBn
dWFyZHMKMWE4OTU2MDhiYiBsb2NrLWd1YXJkOiBhZGQgc2NvcGVkIGxvY2sgaW1wbGVtZW50YXRp
b24KMjE4OGE4M2JlMiBjb21waWxlcjogYWRkIGEgaGVscGVyIGZvciBDOTkgaW5saW5lIGZ1bmN0
aW9ucwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS81OiBjb21waWxlcjog
YWRkIGEgaGVscGVyIGZvciBDOTkgaW5saW5lIGZ1bmN0aW9ucy4uLgpDaGVja2luZyBQQVRDSCAy
LzU6IGxvY2stZ3VhcmQ6IGFkZCBzY29wZWQgbG9jayBpbXBsZW1lbnRhdGlvbi4uLgpDaGVja2lu
ZyBQQVRDSCAzLzU6IHFlbXUtdGltZXI6IGNvbnZlcnQgdG8gdXNlIGxvY2sgZ3VhcmRzLi4uCldB
Uk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM1NDogRklMRTogdXRpbC9xZW11LXRpbWVy
LmM6NDEwOgorICAgICAgICBRRU1VX0xPQ0tfR1VBUkQoUWVtdU11dGV4LCB0aW1lcnNfZ3VhcmQs
ICZ0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzX2xvY2spOwoKRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzExNTogRklMRTogdXRpbC9xZW11LXRp
bWVyLmM6NTE5OgorICAgICAgICBmb3IoOzspIHsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5n
cywgMTI5IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCkNoZWNraW5nIFBBVENIIDQvNTogcWh0OiBjb252ZXJ0IHRvIHVzZSBsb2NrIGd1YXJkcy4u
LgpDaGVja2luZyBQQVRDSCA1LzU6IHRocmVhZC1wb29sOiBjb252ZXJ0IHRvIHVzZSBsb2NrIGd1
YXJkcy4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAZnJlZWxpc3RzLm9yZw==
