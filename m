Received: from eggs.gnu.org ([2001:4830:134:3::10]:57768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e9Urd-0004tf-CP
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e9Ura-0004rW-8k
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:37:49 -0400
Resent-Message-Id: <E1e9Ura-0004rW-8k@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e9Ura-0004ox-1O
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:37:46 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150944890436.171.17517658048327162090@bafd83ae6430>
In-Reply-To: <20171031104813.3079.66585.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 31 Oct 2017 04:21:45 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFCPATCH06/20] replay: fix save/load vm for
 non-empty queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel.Dovgaluk@ispras.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtSRkNQQVRDSDA2LzIwXSByZXBsYXk6IGZpeCBzYXZlL2xvYWQgdm0gZm9yIG5vbi1l
bXB0eSBxdWV1ZQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxNzEwMzExMDQ4MTMuMzA3OS42
NjU4NS5zdGdpdEBwYXNoYS1WaXJ0dWFsQm94Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0Uu
LiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxv
ZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwog
ICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1h
dD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAg
ICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkN2I4YTFjNTc4IHJl
cGxheTogZml4IHNhdmUvbG9hZCB2bSBmb3Igbm9uLWVtcHR5IHF1ZXVlCgo9PT0gT1VUUFVUIEJF
R0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHJlcGxheTogZml4IHNhdmUvbG9hZCB2bSBmb3Ig
bm9uLWVtcHR5IHF1ZXVlLi4uCkVSUk9SOiBFcnJvciBtZXNzYWdlcyBzaG91bGQgbm90IGNvbnRh
aW4gbmV3bGluZXMKIzU5OiBGSUxFOiBtaWdyYXRpb24vc2F2ZXZtLmM6MjMyMjoKKyAgICAgICAg
ICAgICAgICAgICAgICJyaWdodCBub3cuIFRyeSBvbmNlIG1vcmUgbGF0ZXIuXG4iKTsKCnRvdGFs
OiAxIGVycm9ycywgMCB3YXJuaW5ncywgNDggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
