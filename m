Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eGgbn-0004JE-IF
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eGgbl-0002ol-7N
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:35:11 -0500
Resent-Message-Id: <E1eGgbl-0002ol-7N@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eGgbk-0002nq-Vu
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:35:09 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151116233520.519.2313246296341795954@bafd83ae6430>
In-Reply-To: <20171120071423.11693-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 19 Nov 2017 23:18:55 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] spapr: Implement bug in spapr-vty device
 to be compatible with PowerVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au
Cc: famz@redhat.com, lvivier@redhat.com, paulus@samba.org, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gc3BhcHI6IEltcGxlbWVudCBidWcgaW4gc3BhcHItdnR5IGRldmljZSB0
byBiZSBjb21wYXRpYmxlIHdpdGggUG93ZXJWTQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAx
NzExMjAwNzE0MjMuMTE2OTMtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUKCj09PSBURVNU
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
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIw
MTcxMTIwMDcxNDIzLjExNjkzLTEtZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1IC0+IHBhdGNo
ZXcvMjAxNzExMjAwNzE0MjMuMTE2OTMtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowOGU5ZDhmZTgyIHNwYXByOiBJbXBsZW1lbnQg
YnVnIGluIHNwYXByLXZ0eSBkZXZpY2UgdG8gYmUgY29tcGF0aWJsZSB3aXRoIFBvd2VyVk0KCj09
PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogc3BhcHI6IEltcGxlbWVudCBi
dWcgaW4gc3BhcHItdnR5IGRldmljZSB0byBiZSBjb21wYXRpYmxlIHdpdGggUG93ZXJWTS4uLgpF
UlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICctJyAoY3R4OlZ4VikKIzQwOiBGSUxF
OiBody9jaGFyL3NwYXByX3Z0eS5jOjY4OgorICAgICAgICBpZiAoYnVmW24tMV0gPT0gJ1xyJykg
ewogICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDI0IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMu
b3Jn
