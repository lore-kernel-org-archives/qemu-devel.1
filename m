Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1daiUf-00006f-1z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1daiUb-0000h3-QS
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:06:21 -0400
Resent-Message-Id: <E1daiUb-0000h3-QS@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150116076330.114.13671731807618011950@5d477a5b5989>
In-Reply-To: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 27 Jul 2017 06:06:04 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Avoid unnecessary sleeps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHFlbXUtaW90ZXN0czogQXZvaWQgdW5uZWNlc3Nh
cnkgc2xlZXBzCk1lc3NhZ2UtaWQ6IDE1MDA2NDk4MjAtMzA0NTAtMS1naXQtc2VuZC1lbWFpbC1r
d29sZkByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpC
QVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpm
YWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0l
SCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hl
Y2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4i
CiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAg
ICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4ZDVlMTE0IHFlbXUtaW90ZXN0czogQXZv
aWQgdW5uZWNlc3Nhcnkgc2xlZXBzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRD
SCAxLzE6IHFlbXUtaW90ZXN0czogQXZvaWQgdW5uZWNlc3Nhcnkgc2xlZXBzLi4uCkVSUk9SOiBs
aW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMTgxOiBGSUxFOiB0ZXN0cy9xZW11LWlvdGVzdHMvaW90
ZXN0cy5weTozNzI6CisgICAgICAgICAgICAgICAgICAgIGlmIGpvYlsnZGV2aWNlJ10gPT0gam9i
X2lkIGFuZCBqb2JbJ3BhdXNlZCddID09IFRydWUgYW5kIGpvYlsnYnVzeSddID09IEZhbHNlOgoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNDEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRj
aCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
