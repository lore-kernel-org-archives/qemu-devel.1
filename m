Received: from eggs.gnu.org ([2001:4830:134:3::10]:43737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eZxdt-0003mi-5N
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eZxdo-0000t5-MH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:37:01 -0500
Resent-Message-Id: <E1eZxdo-0000t5-MH@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eZxdo-0000sO-Db
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:36:56 -0500
In-Reply-To: <20180112101356.27044-1-zhengxiang9@huawei.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151575698010.530.10584433403846190388@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 12 Jan 2018 03:36:21 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] vhost: fix corrupting GPA 0 when using
 uninitialized queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhengxiang9@huawei.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, zhaoshenglong@huawei.com, pbonzini@redhat.com, lersek@redhat.com, christoffer.dall@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTEyMTAxMzU2LjI3MDQ0LTEtemhlbmd4aWFuZzlAaHVhd2VpLmNvbQpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSB2aG9zdDogZml4IGNvcnJ1cHRpbmcgR1BBIDAg
d2hlbiB1c2luZyB1bmluaXRpYWxpemVkIHF1ZXVlcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZmI2NmYxODRh
ZSB2aG9zdDogZml4IGNvcnJ1cHRpbmcgR1BBIDAgd2hlbiB1c2luZyB1bmluaXRpYWxpemVkIHF1
ZXVlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiB2aG9zdDogZml4
IGNvcnJ1cHRpbmcgR1BBIDAgd2hlbiB1c2luZyB1bmluaXRpYWxpemVkIHF1ZXVlcy4uLgpFUlJP
UjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMzI6IEZJTEU6IGh3L3ZpcnRpby92aG9zdC5jOjE1MzU6
CisgICAgICAgIGlmICh2aXJ0aW9fcXVldWVfZ2V0X2Rlc2NfYWRkcih2ZGV2LCBoZGV2LT52cV9p
bmRleCArIGkpID09IDApICQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBj
aGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
