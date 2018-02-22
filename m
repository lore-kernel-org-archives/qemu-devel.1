Received: from eggs.gnu.org ([2001:4830:134:3::10]:54642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eoqH3-0007h9-OC
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eoqH0-0000VB-Kw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:46:57 -0500
Resent-Message-Id: <E1eoqH0-0000VB-Kw@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eoqH0-0000SZ-4I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:46:54 -0500
In-Reply-To: <20180220132627.4163-1-hlandau@devever.net>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151930359638.714.459231859886199028@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 22 Feb 2018 04:46:37 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] Fix ast2500 protection register emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hlandau@devever.net
Cc: famz@redhat.com, qemu-devel@nongnu.org, clg@kaod.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMjIwMTMyNjI3LjQxNjMtMS1obGFuZGF1QGRldmV2ZXIubmV0ClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIEZpeCBhc3QyNTAwIHByb3RlY3Rpb24gcmVnaXN0ZXIg
ZW11bGF0aW9uCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4u
KSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90
YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cg
JGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07
IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkp
CmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCjhiNjEwZTRlZDIgRml4IGFzdDI1MDAgcHJvdGVjdGlvbiByZWdpc3RlciBl
bXVsYXRpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogRml4IGFz
dDI1MDAgcHJvdGVjdGlvbiByZWdpc3RlciBlbXVsYXRpb24uLi4KRVJST1I6IHN1c3BlY3QgY29k
ZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDQsIDYpCiM3NTogRklMRTogaHcv
bWlzYy9hc3BlZWRfc2RtYy5jOjExMzoKKyAgICBpZiAoYWRkciA9PSBSX1BST1QpIHsKKyAgICAg
IHMtPnJlZ3NbYWRkcl0gPSAoZGF0YSA9PSBQUk9UX0tFWV9VTkxPQ0spID8gMSA6IDA7Cgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDM4IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
