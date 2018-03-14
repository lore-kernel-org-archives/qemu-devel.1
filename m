Received: from eggs.gnu.org ([2001:4830:134:3::10]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ew8V2-00046H-MC
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ew8Uy-0001Ut-OG
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:39:32 -0400
Resent-Message-Id: <E1ew8Uy-0001Ut-OG@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ew8Uy-0001Tt-GB
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:39:28 -0400
In-Reply-To: <20180314153121.23838-1-james.cowgill@mips.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152104190857.51.3339183123690408321@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 14 Mar 2018 08:38:29 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: james.cowgill@mips.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMzE0MTUzMTIxLjIzODM4LTEtamFtZXMuY293Z2lsbEBtaXBzLmNvbQpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBsaW51eC11c2VyOiBpbXBsZW1lbnQgSFdDQVAg
Yml0cyBvbiBNSVBTCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNF
PWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWls
ZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFT
RS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8k
dG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNo
b3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4r
MSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBw
YXRjaGV3LzIwMTgwMzE0MTUzMTIxLjIzODM4LTEtamFtZXMuY293Z2lsbEBtaXBzLmNvbSAtPiBw
YXRjaGV3LzIwMTgwMzE0MTUzMTIxLjIzODM4LTEtamFtZXMuY293Z2lsbEBtaXBzLmNvbQpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjRiMDAxMTU3MjYgbGludXgtdXNlcjogaW1wbGVt
ZW50IEhXQ0FQIGJpdHMgb24gTUlQUwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFU
Q0ggMS8xOiBsaW51eC11c2VyOiBpbXBsZW1lbnQgSFdDQVAgYml0cyBvbiBNSVBTLi4uCkVSUk9S
OiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQK
IzM1OiBGSUxFOiBsaW51eC11c2VyL2VsZmxvYWQuYzo5Njc6CisgICAgZG8geyBpZiAoY3B1LT5l
bnYuaW5zbl9mbGFncyAmIChmbGFnKSkgeyBod2NhcHMgfD0gaHdjYXA7IH0gfSB3aGlsZSAoMCkK
Wy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzAgbGluZXMgY2hlY2tlZAoKWW91
ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
