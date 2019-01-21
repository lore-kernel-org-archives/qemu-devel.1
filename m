Received: from eggs.gnu.org ([209.51.188.92]:42750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glQAp-0005Xa-3s
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 22:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glQAl-0002xR-KY
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 22:22:55 -0500
Resent-Message-Id: <E1glQAl-0002xR-KY@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glQAl-0002vt-Bn
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 22:22:51 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115143650.15725-1-jusual@mail.ru>
Message-ID: <154804092806.5550.6525959750585282623@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 20 Jan 2019 19:22:09 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, alistair@alistair23.me, jusual@mail.ru

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTE0MzY1MC4xNTcy
NS0xLWp1c3VhbEBtYWlsLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTAxMTUxNDM2NTAuMTU3MjUtMS1q
dXN1YWxAbWFpbC5ydQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBody9jb3JlL2dlbmVy
aWMtbG9hZGVyOiBGaXggUEMgb3ZlcndyaXRpbmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmJlMTc1
ZTkgaHcvY29yZS9nZW5lcmljLWxvYWRlcjogRml4IFBDIG92ZXJ3cml0aW5nCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUg
bWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBKdWxpYSBTdXZvcm92YSB2aWEgUWVtdS1kZXZlbCA8
cWVtdS1kZXZlbEBub25nbnUub3JnPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxp
bmVzIGNoZWNrZWQKCkNvbW1pdCBiZTE3NWU5ZjA1MmUgKGh3L2NvcmUvZ2VuZXJpYy1sb2FkZXI6
IEZpeCBQQyBvdmVyd3JpdGluZykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAxMTUxNDM2NTAu
MTU3MjUtMS1qdXN1YWxAbWFpbC5ydS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==
