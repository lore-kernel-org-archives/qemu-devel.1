Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1daiqN-0007kW-Ls
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1daiqI-0001Z2-Qb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:28:47 -0400
Resent-Message-Id: <E1daiqI-0001Z2-Qb@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1daiqI-0001Y2-I0
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:28:42 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150116211032.114.8342194611666421616@5d477a5b5989>
In-Reply-To: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 27 Jul 2017 06:28:31 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/4] mc146818rtc: implement UIP latching as
 intended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peng.hao2@zte.com.cn, liu.yi24@zte.com.cn

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC80XSBtYzE0NjgxOHJ0YzogaW1wbGVtZW50IFVJ
UCBsYXRjaGluZyBhcyBpbnRlbmRlZApNZXNzYWdlLWlkOiAxNTAwOTkwNTE0LTMwMzI2LTEtZ2l0
LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzA3Y2Q2YSBt
YzE0NjgxOHJ0YzogaW1wbGVtZW50IFVJUCBsYXRjaGluZyBhcyBpbnRlbmRlZApmNDgxN2U0IG1j
MTQ2ODE4cnRjOiBzaW1wbGlmeSBjaGVja191cGRhdGVfdGltZXIKZmJhMWIwNyBydGMtdGVzdDog
aW50cm9kdWNlIG1vcmUgdXBkYXRlIHRlc3RzCmNhYzkzNjUgcnRjLXRlc3Q6IGNsZWFudXAgcmVn
aXN0ZXJfYl9zZXRfZmxhZyB0ZXN0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRD
SCAxLzQ6IHJ0Yy10ZXN0OiBjbGVhbnVwIHJlZ2lzdGVyX2Jfc2V0X2ZsYWcgdGVzdC4uLgpFUlJP
Ujogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwojNzM6IEZJ
TEU6IHRlc3RzL3J0Yy10ZXN0LmM6MzQ0OgorICAgIH0gd2hpbGUoMCkKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMTE1IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCkNoZWNraW5nIFBBVENIIDIvNDogcnRjLXRlc3Q6IGludHJvZHVjZSBt
b3JlIHVwZGF0ZSB0ZXN0cy4uLgpDaGVja2luZyBQQVRDSCAzLzQ6IG1jMTQ2ODE4cnRjOiBzaW1w
bGlmeSBjaGVja191cGRhdGVfdGltZXIuLi4KQ2hlY2tpbmcgUEFUQ0ggNC80OiBtYzE0NjgxOHJ0
YzogaW1wbGVtZW50IFVJUCBsYXRjaGluZyBhcyBpbnRlbmRlZC4uLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
