Received: from eggs.gnu.org ([2001:4830:134:3::10]:58478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cjlXp-0002oJ-A0
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cjlXl-0006k4-Bk
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:38:45 -0500
Resent-Message-Id: <E1cjlXl-0006k4-Bk@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cjlXl-0006iq-3b
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:38:41 -0500
In-Reply-To: <20170303113255.28262-1-berrange@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148854110904.285.8506952729487456540@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 3 Mar 2017 03:38:29 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, aarcange@redhat.com, mprivozn@redhat.com, jitendra.kolhe@hpe.com, stefanha@redhat.com, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzAzMDMxMTMyNTUuMjgyNjItMS1iZXJyYW5nZUByZWRoYXQuY29tClR5cGU6IHNlcmllcwpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzXSBvczogZG9uJ3QgY29ycnVwdCBwcmUtZXhpc3Rp
bmcgbWVtb3J5LWJhY2tlbmQgZGF0YSB3aXRoIHByZWFsbG9jCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxp
bmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJB
U0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4v
JHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBz
aG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChu
KzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5n
IDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0Jwo0MjEwOTQwIG9zOiBkb24ndCBjb3JydXB0IHByZS1leGlzdGluZyBt
ZW1vcnktYmFja2VuZCBkYXRhIHdpdGggcHJlYWxsb2MKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNo
ZWNraW5nIFBBVENIIDEvMTogb3M6IGRvbid0IGNvcnJ1cHQgcHJlLWV4aXN0aW5nIG1lbW9yeS1i
YWNrZW5kIGRhdGEgd2l0aCBwcmVhbGxvYy4uLgpFUlJPUjogVXNlIG9mIHZvbGF0aWxlIGlzIHVz
dWFsbHkgd3Jvbmc6IHNlZSBEb2N1bWVudGF0aW9uL3ZvbGF0aWxlLWNvbnNpZGVyZWQtaGFybWZ1
bC50eHQKIzQzOiBGSUxFOiB1dGlsL29zbGliLXBvc2l4LmM6MzcxOgorICAgICAgICAgICAgKih2
b2xhdGlsZSBjaGFyICopcGFnZSA9ICpwYWdlOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAyMSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJl
ZWxpc3RzLm9yZw==
