Received: from eggs.gnu.org ([2001:4830:134:3::10]:46579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dNX7q-0004Yh-Jn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dNX7n-0008Cu-GF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:20:18 -0400
Resent-Message-Id: <E1dNX7n-0008Cu-GF@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dNX7n-0008CJ-1n
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:20:15 -0400
In-Reply-To: <1498014889-52658-1-git-send-email-wanpeng.li@hotmail.com>
Message-ID: <149801879191.32250.2570133969821880694@4a9a010726c0>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 20 Jun 2017 21:19:53 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] KVM: Add async pf flag to
 KVM_GET/SET_VCPU_EVENTS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kernellwp@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, wanpeng.li@hotmail.com, rkrcmar@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gS1ZNOiBBZGQgYXN5bmMgcGYgZmxhZyB0byBLVk1fR0VUL1NFVF9WQ1BV
X0VWRU5UUyBpbnRlcmZhY2UKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE0OTgwMTQ4ODktNTI2
NTgtMS1naXQtc2VuZC1lbWFpbC13YW5wZW5nLmxpQGhvdG1haWwuY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAt
LW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNv
bW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGlu
ICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBs
b2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0
PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAg
ICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0
ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
Jwo0OTEwZDVmIEtWTTogQWRkIGFzeW5jIHBmIGZsYWcgdG8gS1ZNX0dFVC9TRVRfVkNQVV9FVkVO
VFMgaW50ZXJmYWNlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IEtW
TTogQWRkIGFzeW5jIHBmIGZsYWcgdG8gS1ZNX0dFVC9TRVRfVkNQVV9FVkVOVFMgaW50ZXJmYWNl
Li4uCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzYxOiBGSUxFOiB0
YXJnZXQvaTM4Ni9rdm0uYzoyNTM1OgorXkleSSAgICAgICAgICAgICBLVk1fVkNQVUVWRU5UX1ZB
TElEX0FTWU5DX1BGOyQKCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFy
bXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzY5OiBGSUxFOiB0YXJnZXQvaTM4Ni9rdm0uYzoyNTYwOgor
ICAgIGlmIChldmVudHMuZmxhZ3MgJiBLVk1fVkNQVUVWRU5UX1ZBTElEX0FTWU5DX1BGKQpbLi4u
XQoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA0NSBsaW5lcyBjaGVja2VkCgpZb3VyIHBh
dGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
