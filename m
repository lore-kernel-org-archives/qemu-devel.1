Received: from eggs.gnu.org ([209.51.188.92]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIsvT-0004ve-CE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIsvS-00069U-5H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:45:23 -0400
Resent-Message-Id: <E1hIsvS-00069U-5H@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIsvR-00061A-Ti
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:45:22 -0400
In-Reply-To: <20190423103855.1257968-1-jakub.jermar@kernkonzept.com>
Message-ID: <155601627096.26689.2851011824444304661@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 23 Apr 2019 03:44:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] mips: Decide to map PAGE_EXEC in
 map_address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jakub.jermar@kernkonzept.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzEwMzg1NS4xMjU3
OTY4LTEtamFrdWIuamVybWFyQGtlcm5rb256ZXB0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNDIz
MTAzODU1LjEyNTc5NjgtMS1qYWt1Yi5qZXJtYXJAa2VybmtvbnplcHQuY29tClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIG1pcHM6IERlY2lkZSB0byBtYXAgUEFHRV9FWEVDIGluIG1hcF9h
ZGRyZXNzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRj
aGV3LzIwMTkwNDIzMTAzODU1LjEyNTc5NjgtMS1qYWt1Yi5qZXJtYXJAa2VybmtvbnplcHQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MjMxMDM4NTUuMTI1Nzk2OC0xLWpha3ViLmplcm1hckBrZXJua29u
emVwdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0MGUwZDcyMTU3IG1pcHM6
IERlY2lkZSB0byBtYXAgUEFHRV9FWEVDIGluIG1hcF9hZGRyZXNzCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMg
c3RhdGVtZW50CiM0NzogRklMRTogdGFyZ2V0L21pcHMvaGVscGVyLmM6MTA0OgorICAgICAgICAg
ICAgICAgIGlmICghKG4gPyB0bGItPlhJMSA6IHRsYi0+WEkwKSkKWy4uLl0KCnRvdGFsOiAxIGVy
cm9ycywgMCB3YXJuaW5ncywgNTIgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDQwZTBkNzIxNTcyNCAo
bWlwczogRGVjaWRlIHRvIG1hcCBQQUdFX0VYRUMgaW4gbWFwX2FkZHJlc3MpIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMTkwNDIzMTAzODU1LjEyNTc5NjgtMS1qYWt1Yi5qZXJtYXJAa2Vybmtvbnpl
cHQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
