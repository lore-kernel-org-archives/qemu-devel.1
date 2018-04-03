Received: from eggs.gnu.org ([2001:4830:134:3::10]:38740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f3O0J-00012g-Bi
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f3O0G-0000Cq-2B
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:37:47 -0400
Resent-Message-Id: <E1f3O0G-0000Cq-2B@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f3O0F-0000Cd-Q8
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:37:43 -0400
In-Reply-To: <1522769426-6056-1-git-send-email-suhang16@mails.ucas.ac.cn>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152276983686.1416.16137563993301721352@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 3 Apr 2018 08:37:17 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2 RFC] Implement Hex file loader and add
 test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: suhang16@mails.ucas.ac.cn
Cc: famz@redhat.com, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MjI3Njk0MjYtNjA1Ni0xLWdpdC1zZW5kLWVtYWlsLXN1aGFuZzE2QG1haWxz
LnVjYXMuYWMuY24KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzIgUkZDXSBJbXBsZW1l
bnQgSGV4IGZpbGUgbG9hZGVyIGFuZCBhZGQgdGVzdCBjYXNlCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxp
bmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0t
Zm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBl
Y2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVz
ICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAg
IGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBb
bmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1MjI3Njk0MjYtNjA1Ni0xLWdpdC1zZW5k
LWVtYWlsLXN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24gLT4gcGF0Y2hldy8xNTIyNzY5NDI2LTYw
NTYtMS1naXQtc2VuZC1lbWFpbC1zdWhhbmcxNkBtYWlscy51Y2FzLmFjLmNuClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKMzc0NWM3OGJkZCBBZGQgUVRlc3QgdGVzdGNhc2UgZm9yIHRo
ZSBIZXggRmlsZSBMb2FkZXIKZWY0OWI5NDA4YiBJbXBsZW1lbnQgLmhleCBmaWxlIGxvYWRlcgoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8yOiBJbXBsZW1lbnQgLmhleCBm
aWxlIGxvYWRlci4uLgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1z
IG9mIHRoaXMgc3RhdGVtZW50CiMyMjA6IEZJTEU6IGh3L2NvcmUvbG9hZGVyLmM6MTQ2MzoKKyAg
ICB9IHdoaWxlICgrK2hleF9ibG9iICE9IGVuZCk7ClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDMyOCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgpDaGVja2luZyBQQVRDSCAyLzI6IEFkZCBRVGVzdCB0ZXN0Y2FzZSBmb3IgdGhl
IEhleCBGaWxlIExvYWRlci4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
