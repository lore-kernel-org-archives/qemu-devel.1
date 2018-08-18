Received: from eggs.gnu.org ([2001:4830:134:3::10]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fr2RL-0002QF-Aq
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 10:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fr2Hd-0005J0-9G
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 10:32:56 -0400
Resent-Message-Id: <E1fr2Hd-0005J0-9G@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fr2Hd-0005HV-0Y
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 10:32:53 -0400
In-Reply-To: <20180817173104.14691-1-marcandre.lureau@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153460272477.29407.16328828202759582485@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 18 Aug 2018 07:32:21 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] vnc: call sasl_server_init() only when
 required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwODE3MTczMTA0LjE0NjkxLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQu
Y29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHZuYzogY2FsbCBzYXNsX3NlcnZlcl9p
bml0KCkgb25seSB3aGVuIHJlcXVpcmVkCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8
IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0t
cmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2lu
ZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAg
IGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZp
CiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmMwYzVmYmNlOGEgdm5jOiBjYWxsIHNhc2xfc2Vy
dmVyX2luaXQoKSBvbmx5IHdoZW4gcmVxdWlyZWQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogdm5jOiBjYWxsIHNhc2xfc2VydmVyX2luaXQoKSBvbmx5IHdoZW4gcmVx
dWlyZWQuLi4KRVJST1I6IGRvIG5vdCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24KIzM1
OiBGSUxFOiB1aS92bmMuYzo0MDU3OgorICAgIGlmIChzYXNsICYmICgoc2FzbEVyciA9IHNhc2xf
c2VydmVyX2luaXQoTlVMTCwgInFlbXUiKSkgIT0gU0FTTF9PSykpIHsKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==
