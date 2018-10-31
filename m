Received: from eggs.gnu.org ([2001:4830:134:3::10]:47223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gHifE-00042C-Df
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 01:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gHif0-0004q8-KP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 01:03:27 -0400
Resent-Message-Id: <E1gHif0-0004q8-KP@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gHiex-0004Zf-4t
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 01:03:18 -0400
Message-ID: <154096215214.6332.16173638540950760088@015909e0f939>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20181030082340.17170-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 30 Oct 2018 22:02:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, ppandit@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgxMDMwMDgyMzQwLjE3MTcwLTEta3JheGVsQHJlZGhhdC5jb20KU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gZm1vcHM6IGZpeCBvZmYtYnktb25lIGluIEFSX1RBQkxF
IGFuZCBEUl9UQUJMRSBhcnJheSBzaXplCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
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
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM4N2Y4ZTRjNWMgZm1vcHM6IGZpeCBvZmYtYnkt
b25lIGluIEFSX1RBQkxFIGFuZCBEUl9UQUJMRSBhcnJheSBzaXplCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGZtb3BzOiBmaXggb2ZmLWJ5LW9uZSBpbiBBUl9UQUJM
RSBhbmQgRFJfVEFCTEUgYXJyYXkgc2l6ZS4uLgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMyNzogRklMRTogaHcvYXVkaW8vZm1vcGwuaDo3NToKK15JaW50MzJfdCBB
Ul9UQUJMRVs3Nl07XkkvKiBhdHR0YWNrIHJhdGUgdGFibGVzICovJAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjg6IEZJTEU6IGh3L2F1ZGlvL2Ztb3BsLmg6NzY6
CiteSWludDMyX3QgRFJfVEFCTEVbNzZdO15JLyogZGVjYXkgcmF0ZSB0YWJsZXMgICAqLyQKCnRv
dGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTAgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
