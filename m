Received: from eggs.gnu.org ([2001:4830:134:3::10]:57676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gSNVD-0008PF-7D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gSNVA-0003QN-4Q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:41:15 -0500
Resent-Message-Id: <E1gSNVA-0003QN-4Q@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gSNV9-0003PP-Qh
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:41:12 -0500
In-Reply-To: <1543352837-21529-1-git-send-email-bijan.mottahedeh@oracle.com>
Message-ID: <154350245267.24722.16191258784592311202@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 29 Nov 2018 06:40:53 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC QEMU v2 0/2] arm/virt: Account for guest
 pause time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bijan.mottahedeh@oracle.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUkZDIFFFTVUgdjIgMC8yXSBhcm0vdmlydDogQWNjb3VudCBm
b3IgZ3Vlc3QgcGF1c2UgdGltZQpNZXNzYWdlLWlkOiAxNTQzMzUyODM3LTIxNTI5LTEtZ2l0LXNl
bmQtZW1haWwtYmlqYW4ubW90dGFoZWRlaEBvcmFjbGUuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxp
bmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0t
Zm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBl
Y2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVz
ICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAg
IGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmJmN2I2ZGMgYXJtL3ZpcnQ6
IEFjY291bnQgZm9yIGd1ZXN0IHBhdXNlIHRpbWUKMjE0MjNmNCBhcm0vdmlydDogSW5pdGlhbGl6
ZSBnZW5lcmljIHRpbWVyIHNjYWxlIGZhY3RvciBkeW5hbWljYWxseQoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8yOiBhcm0vdmlydDogSW5pdGlhbGl6ZSBnZW5lcmljIHRp
bWVyIHNjYWxlIGZhY3RvciBkeW5hbWljYWxseS4uLgpFUlJPUjogZXhhY3RseSBvbmUgc3BhY2Ug
cmVxdWlyZWQgYWZ0ZXIgdGhhdCAjaWZkZWYKIzMzOiBGSUxFOiBody9hcm0vdmlydC5jOjE3NTc6
CisjaWZkZWYgIENPTkZJR19LVk0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA2IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCkNoZWNr
aW5nIFBBVENIIDIvMjogYXJtL3ZpcnQ6IEFjY291bnQgZm9yIGd1ZXN0IHBhdXNlIHRpbWUuLi4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=
