Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gPicz-0005i0-QZ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gPicv-0003kx-Jg
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:38:17 -0500
Resent-Message-Id: <E1gPicv-0003kx-Jg@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gPicv-0003hL-At
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:38:13 -0500
In-Reply-To: <20181120184148.22501-1-pbonzini@redhat.com>
Message-ID: <154286865859.936.4908381150456798086@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 21 Nov 2018 22:37:42 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] nvme: fix out-of-bounds access to the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, keith.busch@intel.com, liq3ea@gmail.com, qemu-block@nongnu.org, mreitz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
ODExMjAxODQxNDguMjI1MDEtMS1wYm9uemluaUByZWRoYXQuY29tClR5cGU6IHNlcmllcwpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBudm1lOiBmaXggb3V0LW9mLWJvdW5kcyBhY2Nlc3Mg
dG8gdGhlIENNQgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
YXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVk
PTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0Uu
LikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRv
dGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93
ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAt
OyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEp
KQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1
Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8x
NTQyODY4MzcyLTI2MDItMS1naXQtc2VuZC1lbWFpbC1saXEzZWFAZ21haWwuY29tIC0+IHBhdGNo
ZXcvMTU0Mjg2ODM3Mi0yNjAyLTEtZ2l0LXNlbmQtZW1haWwtbGlxM2VhQGdtYWlsLmNvbQpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjUwNmVmYTQgbnZtZTogZml4IG91dC1vZi1ib3Vu
ZHMgYWNjZXNzIHRvIHRoZSBDTUIKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENI
IDEvMTogbnZtZTogZml4IG91dC1vZi1ib3VuZHMgYWNjZXNzIHRvIHRoZSBDTUIuLi4KRVJST1I6
IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMTA2OiBGSUxFOiB0ZXN0
cy9udm1lLXRlc3QuYzo1MzoKKyAgICBwZGV2ID0gcXBjaV9kZXZpY2VfZmluZChxcy0+cGNpYnVz
LCBRUENJX0RFVkZOKDQsMCkpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOTkgbGluZXMg
Y2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
