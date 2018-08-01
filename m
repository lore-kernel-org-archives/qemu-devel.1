Received: from eggs.gnu.org ([2001:4830:134:3::10]:37689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fkwCM-0007mr-Ra
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fkwCH-0002pw-So
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 14:50:14 -0400
Resent-Message-Id: <E1fkwCH-0002pw-So@eggs.gnu.org>
In-Reply-To: <20180801131905.148778-1-frankja@linux.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153314939702.10779.5220477567566657488@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 1 Aug 2018 11:49:58 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v4 0/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: frankja@linux.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwODAxMTMxOTA1LjE0ODc3OC0xLWZyYW5ramFAbGludXguaWJtLmNvbQpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0IDAvMl0gczM5MHg6IEVuYWJsZSBLVk0gaHVn
ZSBwYWdlIGJhY2tpbmcgc3VwcG9ydAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3
YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJl
dmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcg
UEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBp
ZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQog
ICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0MjkwZGJlODU3IHMzOTB4OiBFbmFibGUgS1ZNIGh1
Z2UgcGFnZSBiYWNraW5nIHN1cHBvcnQKYWRmZDdhNjg5MCBrdm06IHN5bmMgbGludXggaGVhZGVy
cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8yOiBrdm06IHN5bmMgbGlu
dXggaGVhZGVycy4uLgpDaGVja2luZyBQQVRDSCAyLzI6IHMzOTB4OiBFbmFibGUgS1ZNIGh1Z2Ug
cGFnZSBiYWNraW5nIHN1cHBvcnQuLi4KRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZv
ciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNTk6IEZJTEU6IHRhcmdldC9zMzkweC9rdm0u
YzoyOTE6CisgICAgaWYgKHBhdGhfcHNpemUgPT0gNCAqIEtpQikKWy4uLl0KCnRvdGFsOiAxIGVy
cm9ycywgMCB3YXJuaW5ncywgNjMgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
