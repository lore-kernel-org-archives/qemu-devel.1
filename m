Received: from eggs.gnu.org ([2001:4830:134:3::10]:41610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gSZoy-0006VG-3O
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 22:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gSZou-0002M5-T4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 22:50:28 -0500
Resent-Message-Id: <E1gSZou-0002M5-T4@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gSZou-0002K9-Jh
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 22:50:24 -0500
In-Reply-To: <20181129031230.31082-1-jasowang@redhat.com>
Message-ID: <154354976410.27426.17989620819328270872@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 29 Nov 2018 19:49:25 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKCgpUeXBlOiBzZXJpZXMK
U3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBmb3IgMy4xIDAvNF0gRml4IHBvc3NpYmxlIE9P
QiBkdXJpbmcgcXVldWluZyBwYWNrZXRzCk1lc3NhZ2UtaWQ6IDIwMTgxMTI5MDMxMjMwLjMxMDgy
LTEtamFzb3dhbmdAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
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
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3NGU0YTEwIHZpcnRpby1uZXQtdGVzdDogYWRkIGxh
cmdlIHR4IGJ1ZmZlciB0ZXN0CmQ5OTBkNGUgdmlydGlvLW5ldC10ZXN0OiBhY2NlcHQgdmFyaWFi
bGUgbGVuZ3RoIGFyZ3VtZW50IGluIHBjaV90ZXN0X3N0YXJ0KCkKYmIyZDhmZiB2aXJ0aW8tbmV0
LXRlc3Q6IHJlbW92ZSB1bnVzZWQgbWFjcm8KM2E0MmQwYSBuZXQ6IGRyb3AgdG9vIGxhcmdlIHBh
Y2tldCBlYXJseQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS80OiBuZXQ6
IGRyb3AgdG9vIGxhcmdlIHBhY2tldCBlYXJseS4uLgpDaGVja2luZyBQQVRDSCAyLzQ6IHZpcnRp
by1uZXQtdGVzdDogcmVtb3ZlIHVudXNlZCBtYWNyby4uLgpDaGVja2luZyBQQVRDSCAzLzQ6IHZp
cnRpby1uZXQtdGVzdDogYWNjZXB0IHZhcmlhYmxlIGxlbmd0aCBhcmd1bWVudCBpbiBwY2lfdGVz
dF9zdGFydCgpLi4uCkNoZWNraW5nIFBBVENIIDQvNDogdmlydGlvLW5ldC10ZXN0OiBhZGQgbGFy
Z2UgdHggYnVmZmVyIHRlc3QuLi4KRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQg
JysrJyAoY3R4Old4QikKIzQ3OiBGSUxFOiB0ZXN0cy92aXJ0aW8tbmV0LXRlc3QuYzoyNzQ6Cisg
ICAgZm9yIChpID0gMDsgaSA8IDY0OyBpICsrKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBz
dGF0ZW1lbnQKIzQ4OiBGSUxFOiB0ZXN0cy92aXJ0aW8tbmV0LXRlc3QuYzoyNzU6CisgICAgICAg
IGlmIChpID09IDApClsuLi5dCisgICAgICAgIGVsc2UKWy4uLl0KCnRvdGFsOiAyIGVycm9ycywg
MCB3YXJuaW5ncywgNTggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t
