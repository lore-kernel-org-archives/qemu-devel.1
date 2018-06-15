Received: from eggs.gnu.org ([2001:4830:134:3::10]:53804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fTjbN-0006b4-EV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fTjbJ-0001Zy-4X
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:56:57 -0400
Resent-Message-Id: <E1fTjbJ-0001Zy-4X@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fTjbI-0001Xo-QE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:56:53 -0400
In-Reply-To: <20180615064701.40928-1-tomeu.vizoso@collabora.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152904939063.705.12039469404858691064@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 15 Jun 2018 00:56:31 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] egl-headless: Allow OpenGL ES context
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tomeu.vizoso@collabora.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kernel@collabora.com, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjE1MDY0NzAxLjQwOTI4LTEtdG9tZXUudml6b3NvQGNvbGxhYm9yYS5j
b20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gZWdsLWhlYWRsZXNzOiBBbGxvdyBPcGVu
R0wgRVMgY29udGV4dCBjcmVhdGlvbgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3
YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJl
dmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcg
UEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBp
ZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQog
ICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBo
dHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAg
ICAgICAgICAgcGF0Y2hldy8yMDE4MDYxNTA2NDcwMS40MDkyOC0xLXRvbWV1LnZpem9zb0Bjb2xs
YWJvcmEuY29tIC0+IHBhdGNoZXcvMjAxODA2MTUwNjQ3MDEuNDA5MjgtMS10b21ldS52aXpvc29A
Y29sbGFib3JhLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmI0MDE1ZTkyMTEg
ZWdsLWhlYWRsZXNzOiBBbGxvdyBPcGVuR0wgRVMgY29udGV4dCBjcmVhdGlvbgoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBlZ2wtaGVhZGxlc3M6IEFsbG93IE9wZW5H
TCBFUyBjb250ZXh0IGNyZWF0aW9uLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBm
b3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzEyMjogRklMRTogdWkvZWdsLWhlbHBlcnMu
Yzo0MzM6CisgICAgaWYgKGdsZXMpClsuLi5dCisgICAgZWxzZQpbLi4uXQoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCAxNjkgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
