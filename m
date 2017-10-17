Received: from eggs.gnu.org ([2001:4830:134:3::10]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e4Pmo-0003Rq-7I
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e4Pmj-00083d-Le
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:50 -0400
Resent-Message-Id: <E1e4Pmj-00083d-Le@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e4Pmj-00082p-DC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:45 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150823868225.365.12379287365371609539@b58463cdfd5f>
In-Reply-To: <20171017103514.5859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 17 Oct 2017 04:11:22 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: famz@redhat.com, riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDE3MTAzNTE0LjU4NTktMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGxpbnV4LXVzZXIvbWFpbjogc3VwcG9ydCBkZmls
dGVyCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2Ug
JEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0gg
JG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdp
dCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0k
KChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0JwphOTJmNzM4YzY3IGxpbnV4LXVzZXIvbWFpbjogc3VwcG9ydCBk
ZmlsdGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGxpbnV4LXVz
ZXIvbWFpbjogc3VwcG9ydCBkZmlsdGVyLi4uCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0
aGF0ICcsJyAoY3R4OlZ4VikKIzQwOiBGSUxFOiBsaW51eC11c2VyL21haW4uYzo0MDYzOgorICAg
ICAicmFuZ2VbLC4uLl0iLCJmaWx0ZXIgbG9nZ2luZyBiYXNlZCBvbiBhZGRyZXNzIHJhbmdlIn0s
CiAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE5IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMu
b3Jn
