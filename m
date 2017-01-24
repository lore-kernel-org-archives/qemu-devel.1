Received: from eggs.gnu.org ([2001:4830:134:3::10]:43752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cVxjy-0006ZT-Kg
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cVxju-0004Pw-Jo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:50:14 -0500
Resent-Message-Id: <E1cVxju-0004Pw-Jo@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cVxju-0004P8-Bj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:50:10 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <58871f9b.d635240a.4cda6.5322@mx.google.com>
Message-ID: <148525139963.27.2288529185359231587@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 24 Jan 2017 01:50:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liq3ea@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, ghoffman@redhat.com, liqiang6-s@360.cn

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGNpcnJ1czogZml4IG9vYiBhY2Nlc3MgaXNzdWUK
TWVzc2FnZS1pZDogNTg4NzFmOWIuZDYzNTI0MGEuNGNkYTYuNTMyMkBteC5nb29nbGUuY29tCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFs
PSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwg
Z2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1h
dD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAi
Q2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYyku
Li4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hv
CiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0
YWddICAgICAgICAgcGF0Y2hldy81ODg3MWY5Yi5kNjM1MjQwYS40Y2RhNi41MzIyQG14Lmdvb2ds
ZS5jb20gLT4gcGF0Y2hldy81ODg3MWY5Yi5kNjM1MjQwYS40Y2RhNi41MzIyQG14Lmdvb2dsZS5j
b20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowODAzMzNjIGNpcnJ1czogZml4IG9v
YiBhY2Nlc3MgaXNzdWUKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTog
Y2lycnVzOiBmaXggb29iIGFjY2VzcyBpc3N1ZS4uLgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFy
b3VuZCB0aGF0ICctJyAoY3R4OlZ4VikKIzIxOiBGSUxFOiBody9kaXNwbGF5L2NpcnJ1c192Z2Eu
YzoyODA6CisgICAgICAgICAgICArICgoaW50NjRfdClzLT5jaXJydXNfYmx0X2hlaWdodC0xKSAq
IHBpdGNoCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
