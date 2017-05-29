Received: from eggs.gnu.org ([2001:4830:134:3::10]:41764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dFBnp-0007KO-Q7
	for qemu-devel@nongnu.org; Sun, 28 May 2017 23:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dFBnm-0004tO-PZ
	for qemu-devel@nongnu.org; Sun, 28 May 2017 23:57:09 -0400
Resent-Message-Id: <E1dFBnm-0004tO-PZ@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dFBnm-0004tF-Gh
	for qemu-devel@nongnu.org; Sun, 28 May 2017 23:57:06 -0400
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <1496029936-6381-1-git-send-email-peterx@redhat.com>
Message-ID: <149603021420.687.1971038533457847767@750cb16fd6f2>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 28 May 2017 20:56:54 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] exec: fix address_space_get_iotlb_entry
 page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGV4ZWM6IGZpeCBhZGRyZXNzX3NwYWNlX2dldF9p
b3RsYl9lbnRyeSBwYWdlIG1hc2sKTWVzc2FnZS1pZDogMTQ5NjAyOTkzNi02MzgxLTEtZ2l0LXNl
bmQtZW1haWwtcGV0ZXJ4QHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4u
IHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9n
IC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAg
ICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0
PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAg
ICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
KiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzE0OTYwMjk5MzYtNjM4MS0xLWdpdC1zZW5kLWVt
YWlsLXBldGVyeEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMTQ5NjAyOTkzNi02MzgxLTEtZ2l0LXNl
bmQtZW1haWwtcGV0ZXJ4QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
Jwo4Nzc4YTQyIGV4ZWM6IGZpeCBhZGRyZXNzX3NwYWNlX2dldF9pb3RsYl9lbnRyeSBwYWdlIG1h
c2sKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogZXhlYzogZml4IGFk
ZHJlc3Nfc3BhY2VfZ2V0X2lvdGxiX2VudHJ5IHBhZ2UgbWFzay4uLgpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICctJyAoY3R4OlZ4VikKIzI0OiBGSUxFOiBleGVjLmM6NTIyOgor
ICAgIGlmIChwbGVuID09IChod2FkZHIpLTEpIHsKICAgICAgICAgICAgICAgICAgICAgICAgIF4K
CnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzIgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRj
aCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
