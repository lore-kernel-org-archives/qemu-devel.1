Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cHnCg-0006iW-47
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 02:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cHnCc-0001ap-Lt
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 02:45:18 -0500
Resent-Message-Id: <E1cHnCc-0001ap-Lt@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cHnCc-0001Yl-DL
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 02:45:14 -0500
In-Reply-To: <20161216073557.2688-1-hangaohuai@huawei.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148187430669.26.1054213278438199906@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 15 Dec 2016 23:45:08 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hangaohuai@huawei.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, arei.gonglei@huawei.com, mst@redhat.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGJ1Z2ZpeDogdm0gaGFsdCB3aGVuIGluIHJl
c2V0IGxvb3BpbmcKTWVzc2FnZS1pZDogMjAxNjEyMTYwNzM1NTcuMjY4OC0xLWhhbmdhb2h1YWlA
aHVhd2VpLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
YXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVk
PTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNjEyMTYwNzM1NTcuMjY4OC0xLWhh
bmdhb2h1YWlAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzIwMTYxMjE2MDczNTU3LjI2ODgtMS1oYW5n
YW9odWFpQGh1YXdlaS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyNWQxYzJl
IGJ1Z2ZpeDogdm0gaGFsdCB3aGVuIGluIHJlc2V0IGxvb3BpbmcKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkNoZWNraW5nIFBBVENIIDEvMTogYnVnZml4OiB2bSBoYWx0IHdoZW4gaW4gcmVzZXQgbG9v
cGluZy4uLgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMzA6IEZJTEU6IGh3L3RpbWVyL21j
MTQ2ODE4cnRjLmM6OTUzOgorICAgIC8qIFJlYXNvbjogVk0gZG8gc3VzcGVuZCBzZWxmIHdpbGwg
c2V0IDB4ZmUgJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMiBsaW5lcyBjaGVja2Vk
CgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
