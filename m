Received: from eggs.gnu.org ([2001:4830:134:3::10]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d5iM5-00013y-Ex
	for qemu-devel@nongnu.org; Tue, 02 May 2017 20:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d5iM2-0000Sv-BJ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 20:41:21 -0400
Resent-Message-Id: <E1d5iM2-0000Sv-BJ@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1d5iM2-0000Sc-2X
	for qemu-devel@nongnu.org; Tue, 02 May 2017 20:41:18 -0400
In-Reply-To: <alpine.DEB.2.10.1705021646310.8859@sstabellini-ThinkPad-X260>
Message-ID: <149377204349.168.2323234965726314465@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 2 May 2017 17:40:44 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH RFC] xen/mapcache: store dma information in
 revmapcache entries for debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org
Cc: famz@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xensource.com, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org, x1917x@gmail.com, pbonzini@redhat.com, hrgstephen@gmail.com, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCBSRkNdIHhlbi9tYXBjYWNoZTogc3RvcmUgZG1hIGluZm9ybWF0aW9uIGlu
IHJldm1hcGNhY2hlIGVudHJpZXMgZm9yIGRlYnVnZ2luZwpNZXNzYWdlLWlkOiBhbHBpbmUuREVC
LjIuMTAuMTcwNTAyMTY0NjMxMC44ODU5QHNzdGFiZWxsaW5pLVRoaW5rUGFkLVgyNjAKVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UK
bj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoK
IyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxv
ZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwog
ICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1h
dD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAg
ICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4NjhmZjU1IHhlbi9t
YXBjYWNoZTogc3RvcmUgZG1hIGluZm9ybWF0aW9uIGluIHJldm1hcGNhY2hlIGVudHJpZXMgZm9y
IGRlYnVnZ2luZwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiB4ZW4v
bWFwY2FjaGU6IHN0b3JlIGRtYSBpbmZvcm1hdGlvbiBpbiByZXZtYXBjYWNoZSBlbnRyaWVzIGZv
ciBkZWJ1Z2dpbmcuLi4KRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJt
cyBvZiB0aGlzIHN0YXRlbWVudAojMTIzOiBGSUxFOiBody9pMzg2L3hlbi94ZW4tbWFwY2FjaGUu
Yzo0MzE6CisgICAgICAgIGlmICghcmV2ZW50cnktPmRtYSkKWy4uLl0KCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgODkgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
