Received: from eggs.gnu.org ([2001:4830:134:3::10]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eR2fr-0003J8-GJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eR2fn-0004JP-Rm
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:10:11 -0500
Resent-Message-Id: <E1eR2fn-0004JP-Rm@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eR2fn-0004HR-IE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:10:07 -0500
In-Reply-To: <20171218130309.2682-1-pbonzini@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151360340725.51.9761366417121462388@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 18 Dec 2017 05:23:28 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: volatile with a comment or
 sig_atomic_t is okay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.orgfamz@redhat.com, lersek@redhat.com, marcandre.lureau@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMjE4MTMwMzA5LjI2ODItMS1wYm9uemluaUByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGNoZWNrcGF0Y2g6IHZvbGF0aWxlIHdpdGggYSBj
b21tZW50IG9yIHNpZ19hdG9taWNfdCBpcyBva2F5Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJB
U0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0
IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBk
bwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZv
cm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEK
ICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphYzFlYTRjNjIy
IGNoZWNrcGF0Y2g6IHZvbGF0aWxlIHdpdGggYSBjb21tZW50IG9yIHNpZ19hdG9taWNfdCBpcyBv
a2F5Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGNoZWNrcGF0Y2g6
IHZvbGF0aWxlIHdpdGggYSBjb21tZW50IG9yIHNpZ19hdG9taWNfdCBpcyBva2F5Li4uCkVSUk9S
OiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzU6IEZJTEU6IHNjcmlwdHMvY2hlY2twYXRjaC5w
bDoyNDgxOgorCQkJbXkgJG1zZyA9ICJVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywg
cGxlYXNlIGFkZCBhIGNvbW1lbnRcbiIgLiAkaGVyZWN1cnI7Cgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDEzIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEBmcmVlbGlzdHMub3Jn
