Received: from eggs.gnu.org ([208.118.235.92]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gTzeY-0003WX-B5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gTzWH-0002Wl-Q9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:29:06 -0500
Resent-Message-Id: <E1gTzWH-0002Wl-Q9@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gTzW9-0002R8-MC
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:28:55 -0500
In-Reply-To: <20181203170105.2367492-1-stefanb@linux.vnet.ibm.com>
Message-ID: <154388690188.15376.11474455213164869616@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 3 Dec 2018 17:28:23 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Cleanup and locality range check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, marcandre.lureau@gmail.com, ppandit@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE4MTIwMzE3MDEwNS4yMzY3
NDkyLTEtc3RlZmFuYkBsaW51eC52bmV0LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMC8y
XSBDbGVhbnVwIGFuZCBsb2NhbGl0eSByYW5nZSBjaGVjawpNZXNzYWdlLWlkOiAyMDE4MTIwMzE3
MDEwNS4yMzY3NDkyLTEtc3RlZmFuYkBsaW51eC52bmV0LmlibS5jb20KVHlwZTogc2VyaWVzCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFs
PSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29t
bWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4g
JGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxv
ZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9
ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAg
ICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQg
JGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjhlNzk4YzQgdHBtOiBNYWtlIHN1cmUgbmV3IGxvY2FsaXR5IHBhc3NlZCB0byB0cG1fdGlzX3By
ZXBfYWJvcnQoKSBpcyB2YWxpZApiM2RmY2RmIHRwbTogUmVtb3ZlIHVudXNlZCBsb2N0eSBwYXJh
bWV0ZXIgZnJvbSB0cG1fdGlzX2Fib3J0KCkKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5n
IFBBVENIIDEvMjogdHBtOiBSZW1vdmUgdW51c2VkIGxvY3R5IHBhcmFtZXRlciBmcm9tIHRwbV90
aXNfYWJvcnQoKS4uLgpDaGVja2luZyBQQVRDSCAyLzI6IHRwbTogTWFrZSBzdXJlIG5ldyBsb2Nh
bGl0eSBwYXNzZWQgdG8gdHBtX3Rpc19wcmVwX2Fib3J0KCkgaXMgdmFsaWQuLi4KRVJST1I6IGJy
YWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojMjY6
IEZJTEU6IGh3L3RwbS90cG1fdGlzLmM6MjY2OgorICAgIGlmICghVFBNX1RJU19JU19WQUxJRF9M
T0NUWShuZXdsb2N0eSkpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDExIGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTgxMjAzMTcw
MTA1LjIzNjc0OTItMS1zdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
