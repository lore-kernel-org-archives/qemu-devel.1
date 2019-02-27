Received: from eggs.gnu.org ([209.51.188.92]:57984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz1XB-0000Ly-Qr
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz1XA-0003Jo-H2
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:54:13 -0500
Resent-Message-Id: <E1gz1XA-0003Jo-H2@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gz1XA-0003Ip-8m
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:54:12 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <155128177405.1544.2035274805815542420@49fa7ef69f7b>
In-Reply-To: <20190221093459.22547-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 27 Feb 2019 07:36:15 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v1] include/exec/helper-head.h: support
 "const void *" in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIyMTA5MzQ1OS4yMjU0
Ny0xLWRhdmlkQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwMjIxMDkzNDU5LjIyNTQ3LTEtZGF2aWRAcmVkaGF0
LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxXSBpbmNsdWRlL2V4ZWMvaGVscGVy
LWhlYWQuaDogc3VwcG9ydCAiY29uc3Qgdm9pZCAqIiBpbiBoZWxwZXIgY2FsbHMKVHlwZTogc2Vy
aWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2Ug
YmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwMjIxMDkzNDU5LjIyNTQ3LTEtZGF2aWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkw
MjIxMDkzNDU5LjIyNTQ3LTEtZGF2aWRAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICAg
ICAgICBwYXRjaGV3LzIwMTkwMjI1MDEyNTMwLjI4MjI1LTEtcmljaGFyZHcueWFuZ0BsaW51eC5p
bnRlbC5jb20gLT4gcGF0Y2hldy8yMDE5MDIyNTAxMjUzMC4yODIyNS0xLXJpY2hhcmR3LnlhbmdA
bGludXguaW50ZWwuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTAy
MjUxNjIzMjUuMjQwMDgtMS1tYXhpd2VsbEBsaW51eC5pYm0uY29tIC0+IHBhdGNoZXcvMjAxOTAy
MjUxNjIzMjUuMjQwMDgtMS1tYXhpd2VsbEBsaW51eC5pYm0uY29tClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKCj09PSBPVVRQVVQgQkVHSU4gPT09CmNoZWNrcGF0Y2gucGw6IG5vIHJl
dmlzaW9ucyByZXR1cm5lZCBmb3IgcmV2bGlzdCAnMScKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMjU1CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDIyMTA5MzQ1OS4yMjU0Ny0xLWRhdmlk
QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
