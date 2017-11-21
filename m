Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eH2LX-0003CL-Sa
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eH2LU-0003kz-OU
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:47:51 -0500
Resent-Message-Id: <E1eH2LU-0003kz-OU@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eH2LU-0003je-Ga
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:47:48 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151124680146.525.9360032898947517739@bafd83ae6430>
In-Reply-To: <20171121064106.13721-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 20 Nov 2017 22:46:42 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] vl.c && linux-user/main.c : removed **envp
 from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ybettan@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gdmwuYyAmJiBsaW51eC11c2VyL21haW4uYyA6IHJlbW92ZWQgKiplbnZw
IGZyb20gbWFpbigpIGFyZ3VtZW50cwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxNzExMjEw
NjQxMDYuMTM3MjEtMS15YmV0dGFuQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAk
QkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChn
aXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7
IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0t
Zm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAu
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9
MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTcxMTIxMDY0MTA2LjEz
NzIxLTEteWJldHRhbkByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxNzExMjEwNjQxMDYuMTM3MjEt
MS15YmV0dGFuQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3NjU3
YjI0ZTVhIHZsLmMgJiYgbGludXgtdXNlci9tYWluLmMgOiByZW1vdmVkICoqZW52cCBmcm9tIG1h
aW4oKSBhcmd1bWVudHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTog
dmwuYyAmJiBsaW51eC11c2VyL21haW4uYyA6IHJlbW92ZWQgKiplbnZwIGZyb20gbWFpbigpIGFy
Z3VtZW50cy4uLgpFUlJPUjogZXh0ZXJucyBzaG91bGQgYmUgYXZvaWRlZCBpbiAuYyBmaWxlcwoj
Mzc6IEZJTEU6IHZsLmM6Mzg6CitpbnQgcWVtdV9tYWluKGludCBhcmdjLCBjaGFyICoqYXJndik7
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDI4IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0
Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
