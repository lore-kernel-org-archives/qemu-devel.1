Received: from eggs.gnu.org ([2001:4830:134:3::10]:59769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e1vuZ-0004ya-Lo
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e1vuW-0000cZ-D3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:53:35 -0400
Resent-Message-Id: <E1e1vuW-0000cZ-D3@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e1vuW-0000bx-4i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:53:32 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150764717181.276.1128938262871781766@b58463cdfd5f>
In-Reply-To: <1507638879-200718-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 10 Oct 2017 07:52:52 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that plugged CPUs are of the
 same type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, groug@kaod.org, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MDc2Mzg4NzktMjAwNzE4LTEtZ2l0LXNlbmQtZW1haWwtaW1hbW1lZG9AcmVk
aGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBwYzogbWFrZSBzdXJlIHRoYXQg
cGx1Z2dlZCBDUFVzIGFyZSBvZiB0aGUgc2FtZSB0eXBlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUg
JEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQo
Z2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRz
OyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAt
LWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwg
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVk
PTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQK
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE3MTAxMDEwMjQxOC4x
MzQ4Ny0xLWFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20gLT4gcGF0Y2hldy8yMDE3MTAxMDEwMjQx
OC4xMzQ4Ny0xLWFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0Jwo2MDZkNmIyOTU2IHBjOiBtYWtlIHN1cmUgdGhhdCBwbHVnZ2VkIENQVXMgYXJl
IG9mIHRoZSBzYW1lIHR5cGUKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEv
MTogcGM6IG1ha2Ugc3VyZSB0aGF0IHBsdWdnZWQgQ1BVcyBhcmUgb2YgdGhlIHNhbWUgdHlwZS4u
LgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoj
MzM6IEZJTEU6IGh3L2kzODYvcGMuYzoxODgyOgorICAgIGlmKCFvYmplY3RfZHluYW1pY19jYXN0
KE9CSkVDVChjcHUpLCBtcy0+Y3B1X3R5cGUpKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDE1IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBm
cmVlbGlzdHMub3Jn
