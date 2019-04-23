Received: from eggs.gnu.org ([209.51.188.92]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJ45f-0004iA-S7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJ3xI-00019H-6U
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:32:02 -0400
Resent-Message-Id: <E1hJ3xI-00019H-6U@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hJ3xA-00015C-Cl
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:31:55 -0400
In-Reply-To: <20190423222005.246981-1-ek@google.com>
Message-ID: <155605868672.26689.361609451910466337@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 23 Apr 2019 15:31:28 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, ek@google.com, ek@loon.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzIyMjAwNS4yNDY5
ODEtMS1la0Bnb29nbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA0MjMyMjIwMDUuMjQ2OTgxLTEt
ZWtAZ29vZ2xlLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBUaGUgaW9jdGwoU0lP
Q0dJRk5BTUUpIGNhbGwgcmVxdWlyZXMgYSBzdHJ1Y3QgaWZyZXEuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDE2MTI1NzQ0LjI3Nzcw
LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAxOTA0MTYxMjU3NDQuMjc3
NzAtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAg
cGF0Y2hldy8yMDE5MDQyMDA3MzQ0Mi43NDg4LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
ZyAtPiBwYXRjaGV3LzIwMTkwNDIwMDczNDQyLjc0ODgtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MjMyMTIyNDYu
MzU0Mi0xLWVoYWJrb3N0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyMzIxMjI0Ni4zNTQy
LTEtZWhhYmtvc3RAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwNDIzMjIyMDA1LjI0Njk4MS0xLWVrQGdvb2dsZS5jb20gLT4gcGF0Y2hldy8yMDE5MDQy
MzIyMjAwNS4yNDY5ODEtMS1la0Bnb29nbGUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKZWVhOGM4MDYwOSBUaGUgaW9jdGwoU0lPQ0dJRk5BTUUpIGNhbGwgcmVxdWlyZXMgYSBz
dHJ1Y3QgaWZyZXEuCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogQXV0aG9yIGVtYWlsIGFk
ZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBFcmlrIEts
aW5lIHZpYSBRZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKQ29tbWl0IGVlYThjODA2MDk4MiAoVGhl
IGlvY3RsKFNJT0NHSUZOQU1FKSBjYWxsIHJlcXVpcmVzIGEgc3RydWN0IGlmcmVxLikgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAxOTA0MjMyMjIwMDUuMjQ2OTgxLTEtZWtAZ29vZ2xlLmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
