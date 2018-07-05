Received: from eggs.gnu.org ([2001:4830:134:3::10]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fbE85-0007lW-Cq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 19:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fbE80-0003xn-V3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 19:57:41 -0400
Resent-Message-Id: <E1fbE80-0003xn-V3@eggs.gnu.org>
In-Reply-To: <20180705235305.124423-1-mst@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153083503965.1284.12951312751119282699@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 5 Jul 2018 16:57:20 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] acpi: generalize aml_package /
 aml_varpackage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com, qemu-arm@nongnu.org, zhaoshenglong@huawei.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzA1MjM1MzA1LjEyNDQyMy0xLW1zdEByZWRoYXQuY29tClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0hdIGFjcGk6IGdlbmVyYWxpemUgYW1sX3BhY2thZ2UgLyBhbWxf
dmFycGFja2FnZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
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
Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0
Y2hldy8yMDE4MDcwNTIzNTMwNS4xMjQ0MjMtMS1tc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIw
MTgwNzA1MjM1MzA1LjEyNDQyMy0xLW1zdEByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKY2JiNzJkNWEzYSBhY3BpOiBnZW5lcmFsaXplIGFtbF9wYWNrYWdlIC8gYW1s
X3ZhcnBhY2thZ2UKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogYWNw
aTogZ2VuZXJhbGl6ZSBhbWxfcGFja2FnZSAvIGFtbF92YXJwYWNrYWdlLi4uCkVSUk9SOiBicmFj
ZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzMzOiBG
SUxFOiBody9hY3BpL2FtbC1idWlsZC5jOjEwMDc6CisgICAgaWYgKG51bV9lbGVtZW50cyA+IDB4
RkYpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDc0IGxpbmVzIGNoZWNrZWQK
CllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
