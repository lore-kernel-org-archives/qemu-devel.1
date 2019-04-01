Received: from eggs.gnu.org ([209.51.188.92]:58778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hB5Sv-0004fu-Hw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 18:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hB5St-0002GA-Q6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 18:31:41 -0400
Resent-Message-Id: <E1hB5St-0002GA-Q6@eggs.gnu.org>
Message-ID: <155415785652.12882.6768623089892460575@76452e4e88f2>
In-Reply-To: <20190401214847.27600-1-walling@linux.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 1 Apr 2019 15:30:58 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3] s390: diagnose 318 info reset and
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwMTIxNDg0Ny4yNzYw
MC0xLXdhbGxpbmdAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MDEyMTQ4NDcuMjc2MDAtMS13YWxsaW5n
QGxpbnV4LmlibS5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2M10gczM5MDogZGlh
Z25vc2UgMzE4IGluZm8gcmVzZXQgYW5kIG1pZ3JhdGlvbiBzdXBwb3J0ClR5cGU6IHNlcmllcwoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2Ug
PiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5
MDQwMTIxNDg0Ny4yNzYwMC0xLXdhbGxpbmdAbGludXguaWJtLmNvbSAtPiBwYXRjaGV3LzIwMTkw
NDAxMjE0ODQ3LjI3NjAwLTEtd2FsbGluZ0BsaW51eC5pYm0uY29tClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKM2QzZmUxMWE5OSBzMzkwOiBkaWFnbm9zZSAzMTggaW5mbyByZXNldCBh
bmQgbWlncmF0aW9uIHN1cHBvcnQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBpbml0aWFs
aXplciBmb3Igc3RydWN0IFZNU3RhdGVEZXNjcmlwdGlvbiBzaG91bGQgbm9ybWFsbHkgYmUgY29u
c3QKIzE0MzogRklMRTogdGFyZ2V0L3MzOTB4L2RpYWcuYzoxNzM6CitWTVN0YXRlRGVzY3JpcHRp
b24gdm1zdGF0ZV9kaWFnMzE4ID0gewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMDMg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IDNkM2ZlMTFhOTllNyAoczM5MDogZGlhZ25vc2UgMzE4IGlu
Zm8gcmVzZXQgYW5kIG1pZ3JhdGlvbiBzdXBwb3J0KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
Lgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5
MDQwMTIxNDg0Ny4yNzYwMC0xLXdhbGxpbmdAbGludXguaWJtLmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
