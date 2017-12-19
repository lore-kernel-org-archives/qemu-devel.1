Received: from eggs.gnu.org ([2001:4830:134:3::10]:40049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eRuEY-0007Ao-Be
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eRuEV-0003sF-7m
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:21:34 -0500
Resent-Message-Id: <E1eRuEV-0003sF-7m@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eRuEU-0003rh-Ul
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:21:31 -0500
In-Reply-To: <20171219101122.31711-1-ybettan@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151367948848.78.420383713099037505@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 19 Dec 2017 02:31:29 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH V3] vl.c && linux-user/main.c : removed
 **envp from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ybettan@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu, kraxel@redhat.com, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMjE5MTAxMTIyLjMxNzExLTEteWJldHRhbkByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggVjNdIHZsLmMgJiYgbGludXgtdXNlci9tYWluLmMgOiBy
ZW1vdmVkICoqZW52cCBmcm9tIG1haW4oKSBhcmd1bWVudHMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGlu
ZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0i
JChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1p
dHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAx
IC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwg
fCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWls
ZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxl
ZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2pl
Y3QvcWVtdQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTcxMjE5MDgyNTE4
LjE5NzI0LTEtbG1hQHN1c2UuY29tIC0+IHBhdGNoZXcvMjAxNzEyMTkwODI1MTguMTk3MjQtMS1s
bWFAc3VzZS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozNTQ1MDJlODRmIHZs
LmMgJiYgbGludXgtdXNlci9tYWluLmMgOiByZW1vdmVkICoqZW52cCBmcm9tIG1haW4oKSBhcmd1
bWVudHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogdmwuYyAmJiBs
aW51eC11c2VyL21haW4uYyA6IHJlbW92ZWQgKiplbnZwIGZyb20gbWFpbigpIGFyZ3VtZW50cy4u
LgpFUlJPUjogZXh0ZXJucyBzaG91bGQgYmUgYXZvaWRlZCBpbiAuYyBmaWxlcwojODU6IEZJTEU6
IHZsLmM6Mzg6CitpbnQgcWVtdV9tYWluKGludCBhcmdjLCBjaGFyICoqYXJndik7Cgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDY2IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
