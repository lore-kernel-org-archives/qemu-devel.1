Received: from eggs.gnu.org ([2001:4830:134:3::10]:34558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fOTMh-0005Oj-F7
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fOTMc-0001qI-I1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:36:03 -0400
Resent-Message-Id: <E1fOTMc-0001qI-I1@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fOTMc-0001p9-8j
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:35:58 -0400
In-Reply-To: <20180531192419.4592-1-samuel.thibault@ens-lyon.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152779532381.333.9900335485707587845@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 May 2018 12:35:24 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] slirp: Fix spurious error report when
 sending directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, jan.kiszka@siemens.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNTMxMTkyNDE5LjQ1OTItMS1zYW11ZWwudGhpYmF1bHRAZW5zLWx5b24u
b3JnClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHNsaXJwOiBGaXggc3B1cmlvdXMgZXJy
b3IgcmVwb3J0IHdoZW4gc2VuZGluZyBkaXJlY3RseQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1h
dD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAi
Q2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYyku
Li4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hv
CiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0
YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDUzMTE5MjQxOS40NTkyLTEtc2FtdWVsLnRo
aWJhdWx0QGVucy1seW9uLm9yZyAtPiBwYXRjaGV3LzIwMTgwNTMxMTkyNDE5LjQ1OTItMS1zYW11
ZWwudGhpYmF1bHRAZW5zLWx5b24ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
NzBmZTE3MTIzOSBzbGlycDogRml4IHNwdXJpb3VzIGVycm9yIHJlcG9ydCB3aGVuIHNlbmRpbmcg
ZGlyZWN0bHkKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogc2xpcnA6
IEZpeCBzcHVyaW91cyBlcnJvciByZXBvcnQgd2hlbiBzZW5kaW5nIGRpcmVjdGx5Li4uCkVSUk9S
OiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMjA6IEZJTEU6IHNsaXJwL3NvY2tldC5jOjM1NDoK
KwkJbGVuID0gbiA9IHNsaXJwX3NlbmQoc28sIHNiLT5zYl9ycHRyLCBzby0+c29fdXJnYywgKE1T
R19PT0IpKTsgLyogfE1TR19ET05UV0FJVCkpOyAqLwoKRVJST1I6IGNvZGUgaW5kZW50IHNob3Vs
ZCBuZXZlciB1c2UgdGFicwojMjA6IEZJTEU6IHNsaXJwL3NvY2tldC5jOjM1NDoKK15JXklsZW4g
PSBuID0gc2xpcnBfc2VuZChzbywgc2ItPnNiX3JwdHIsIHNvLT5zb191cmdjLCAoTVNHX09PQikp
OyAvKiB8TVNHX0RPTlRXQUlUKSk7ICovJAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA4
IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t
