Received: from eggs.gnu.org ([209.51.188.92]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gzYUD-0007yv-BB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gzYUB-0004uD-OG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:05:20 -0500
Resent-Message-Id: <E1gzYUB-0004uD-OG@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gzYUB-0004rJ-2q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:05:19 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <155140949496.7448.6634494885430703319@49fa7ef69f7b>
In-Reply-To: <20190301025140.4351-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 28 Feb 2019 19:04:56 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v6] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richardw.yang@linux.intel.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDMwMTAyNTE0MC40MzUx
LTEtcmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwMzAxMDI1MTQwLjQzNTEtMS1y
aWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENI
IHY2XSBpMzg2LCBhY3BpOiBjaGVjayBhY3BpX21lbW9yeV9ob3RwbHVnIGNhcGFjaXR5IGluIHBy
ZV9wbHVnClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBU
cnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRz
L2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBo
dHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAg
ICAgICAgICAgcGF0Y2hldy8yMDE5MDMwMTAyNTE0MC40MzUxLTEtcmljaGFyZHcueWFuZ0BsaW51
eC5pbnRlbC5jb20gLT4gcGF0Y2hldy8yMDE5MDMwMTAyNTE0MC40MzUxLTEtcmljaGFyZHcueWFu
Z0BsaW51eC5pbnRlbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphMGRjZjhi
MWVhIGkzODYsIGFjcGk6IGNoZWNrIGFjcGlfbWVtb3J5X2hvdHBsdWcgY2FwYWNpdHkgaW4gcHJl
X3BsdWcKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUg
dGhlIG9wZW4gcGFyZW50aGVzaXMgJygnCiM3NzogRklMRTogaHcvYWNwaS9waWl4NC5jOjM4MjoK
KyAgICAgICAgaWYoIXMtPmFjcGlfbWVtb3J5X2hvdHBsdWcuaXNfZW5hYmxlZCkgewoKRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojODE6IEZJTEU6IGh3L2FjcGkvcGlp
eDQuYzozODY6CiteSX0kCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDc2IGxpbmVzIGNo
ZWNrZWQKCkNvbW1pdCBhMGRjZjhiMWVhYzUgKGkzODYsIGFjcGk6IGNoZWNrIGFjcGlfbWVtb3J5
X2hvdHBsdWcgY2FwYWNpdHkgaW4gcHJlX3BsdWcpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
MzAxMDI1MTQwLjQzNTEtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
