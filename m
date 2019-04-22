Received: from eggs.gnu.org ([209.51.188.92]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIQ6r-000193-5p
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIPwS-0007qc-5y
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:48:31 -0400
Resent-Message-Id: <E1hIPwS-0007qc-5y@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIPwR-0007fL-R1
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:48:28 -0400
In-Reply-To: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
Message-ID: <155590486009.24.10885425548462800415@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 21 Apr 2019 20:47:41 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hvf: Add missing break statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8wODdGMUQ5Qy0xMDlELTQxRDEt
QkUyQy1DRTVEODQwQzk4MUJAbWUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMDg3RjFEOUMtMTA5RC00MUQx
LUJFMkMtQ0U1RDg0MEM5ODFCQG1lLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBo
dmY6IEFkZCBtaXNzaW5nIGJyZWFrIHN0YXRlbWVudAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25l
dyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8wODdGMUQ5Qy0xMDlELTQxRDEtQkUyQy1DRTVE
ODQwQzk4MUJAbWUuY29tIC0+IHBhdGNoZXcvMDg3RjFEOUMtMTA5RC00MUQxLUJFMkMtQ0U1RDg0
MEM5ODFCQG1lLmNvbQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDIw
MDkxMDE2LjIxMzE2MC0xLWZlbmdsaUBzbWFydHguY29tIC0+IHBhdGNoZXcvMjAxOTA0MjAwOTEw
MTYuMjEzMTYwLTEtZmVuZ2xpQHNtYXJ0eC5jb20KIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAg
cGF0Y2hldy8yMDE5MDQyMDE2MTQ0Ni4yMjc0LTEtbGlxM2VhQDE2My5jb20gLT4gcGF0Y2hldy8y
MDE5MDQyMDE2MTQ0Ni4yMjc0LTEtbGlxM2VhQDE2My5jb20KIHQgW3RhZyB1cGRhdGVdICAgICAg
ICAgICAgcGF0Y2hldy8yMDE5MDQyMDE5MTQyNS43ZDFkYWI4MkBsdWtsYXAgLT4gcGF0Y2hldy8y
MDE5MDQyMDE5MTQyNS43ZDFkYWI4MkBsdWtsYXAKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo5Njg4M2I5ZjJiIGh2ZjogQWRkIG1pc3NpbmcgYnJlYWsgc3RhdGVtZW50Cgo9PT0gT1VU
UFVUIEJFR0lOID09PQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMgbWFuZ2xlZCBieSB0
aGUgbWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBDaGVuIFpoYW5nIHZpYSBRZW11LWRldmVsIDxx
ZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDcgbGlu
ZXMgY2hlY2tlZAoKQ29tbWl0IDk2ODgzYjlmMmI4ZSAoaHZmOiBBZGQgbWlzc2luZyBicmVhayBz
dGF0ZW1lbnQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzA4N0YxRDlDLTEwOUQtNDFEMS1CRTJDLUNF
NUQ4NDBDOTgxQkBtZS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t
