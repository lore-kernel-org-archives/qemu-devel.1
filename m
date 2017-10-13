Received: from eggs.gnu.org ([2001:4830:134:3::10]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2tPw-0005GD-Ly
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2tPs-0007pa-MF
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:25:56 -0400
Resent-Message-Id: <E1e2tPs-0007pa-MF@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e2tPs-0007oz-E9
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:25:52 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150787592230.294.1377578478383355546@b58463cdfd5f>
In-Reply-To: <20171013054842.32120-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 12 Oct 2017 23:25:22 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] oslib-posix: Fix compiler warning and
 some data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sw@weilnetz.de
Cc: famz@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDEzMDU0ODQyLjMyMTIwLTEtc3dAd2VpbG5ldHouZGUKU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gb3NsaWItcG9zaXg6IEZpeCBjb21waWxlciB3YXJuaW5n
IGFuZCBzb21lIGRhdGEgdHlwZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2Mg
LWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9y
bWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hv
ICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRj
KS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVj
aG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjQ4ZTMzMTVkYTIgb3NsaWItcG9z
aXg6IEZpeCBjb21waWxlciB3YXJuaW5nIGFuZCBzb21lIGRhdGEgdHlwZXMKCj09PSBPVVRQVVQg
QkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogb3NsaWItcG9zaXg6IEZpeCBjb21waWxlciB3
YXJuaW5nIGFuZCBzb21lIGRhdGEgdHlwZXMuLi4KRVJST1I6IFVzZSBvZiB2b2xhdGlsZSBpcyB1
c3VhbGx5IHdyb25nOiBzZWUgRG9jdW1lbnRhdGlvbi92b2xhdGlsZS1jb25zaWRlcmVkLWhhcm1m
dWwudHh0CiM1NjogRklMRTogdXRpbC9vc2xpYi1wb3NpeC5jOjMxNDoKKyAgICAgICAgdm9sYXRp
bGUgY2hhciAqYWRkciA9IG1lbXNldF9hcmdzLT5hZGRyOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCA0OCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAZnJlZWxpc3RzLm9yZw==
