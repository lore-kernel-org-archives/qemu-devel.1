Received: from eggs.gnu.org ([2001:4830:134:3::10]:58800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dswDz-0004nG-TL
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dswDv-0000ro-NK
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:24:27 -0400
Resent-Message-Id: <E1dswDv-0000ro-NK@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dswDv-0000qr-G8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:24:23 -0400
In-Reply-To: <20170915190748.82389-1-jrtc27@jrtc27.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150550344628.36.3236693333533070993@69b6ddf88678>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 15 Sep 2017 12:24:06 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jrtc27@jrtc27.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, richard.henderson@linaro.org, f4bug@amsat.org, laurent@vivier.eu, glaubitz@physik.fu-berlin.de

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2Ml0gbGludXgtdXNlci9zeXNjYWxsLmM6IEhhbmRsZSBTSDQncyBleGNl
cHRpb25hbCBhbGlnbm1lbnQgZm9yIHB7cmVhZCwgd3JpdGV9NjQKTWVzc2FnZS1pZDogMjAxNzA5
MTUxOTA3NDguODIzODktMS1qcnRjMjdAanJ0YzI3LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQg
bG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9y
IGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQo
Z2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1m
b3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4K
ICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUK
CmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzE1
MDQ4ODg5MDUtMjIzOTYtMS1naXQtc2VuZC1lbWFpbC1jaHVnaC5pc2hhbmlAcmVzZWFyY2guaWlp
dC5hYy5pbiAtPiBwYXRjaGV3LzE1MDQ4ODg5MDUtMjIzOTYtMS1naXQtc2VuZC1lbWFpbC1jaHVn
aC5pc2hhbmlAcmVzZWFyY2guaWlpdC5hYy5pbgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjVjNGEzMzhlMTIgbGludXgtdXNlci9zeXNjYWxsLmM6IEhhbmRsZSBTSDQncyBleGNlcHRp
b25hbCBhbGlnbm1lbnQgZm9yIHB7cmVhZCwgd3JpdGV9NjQKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkNoZWNraW5nIFBBVENIIDEvMTogbGludXgtdXNlci9zeXNjYWxsLmM6IEhhbmRsZSBTSDQncyBl
eGNlcHRpb25hbCBhbGlnbm1lbnQgZm9yIHB7cmVhZCwgd3JpdGV9NjQuLi4KRVJST1I6IG9wZW4g
YnJhY2UgJ3snIGZvbGxvd2luZyBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgZ28gb24gdGhlIG5leHQg
bGluZQojMjA6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjY3MDoKK3N0YXRpYyBpbmxpbmUg
aW50IHJlZ3BhaXJzX2FsaWduZWQodm9pZCAqY3B1X2VudiwgaW50IG51bSkgewoKRVJST1I6IG9w
ZW4gYnJhY2UgJ3snIGZvbGxvd2luZyBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgZ28gb24gdGhlIG5l
eHQgbGluZQojMzQ6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjY4MjoKK3N0YXRpYyBpbmxp
bmUgaW50IHJlZ3BhaXJzX2FsaWduZWQodm9pZCAqY3B1X2VudiwgaW50IG51bSkgewoKdG90YWw6
IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA5MCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
