Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d1OGB-0008RF-H4
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d1OG7-0001qR-50
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:25:23 -0400
Resent-Message-Id: <E1d1OG7-0001qR-50@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1d1OG6-0001q6-Sk
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:25:19 -0400
In-Reply-To: <20170420202745.149601-1-lepton@google.com>
Message-ID: <149274150681.45.13947934975578154787@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 20 Apr 2017 19:25:07 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] Fix wrong length in IP header in
 tcp_respond.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ytht.net@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, lepton@google.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwNDIwMjAyNzQ1LjE0OTYwMS0xLWxlcHRvbkBnb29nbGUuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIEZpeCB3cm9uZyBsZW5ndGggaW4gSVAgaGVhZGVyIGlu
IHRjcF9yZXNwb25kLgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFT
RT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFp
bGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIk
KGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0
czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEg
LS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8
IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxl
ZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVk
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAxNzA0MTQwODM3MTcuMTM2NDEt
MS1sdml2aWVyQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE3MDQxNDA4MzcxNy4xMzY0MS0xLWx2
aXZpZXJAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmIzMTA1YmUg
Rml4IHdyb25nIGxlbmd0aCBpbiBJUCBoZWFkZXIgaW4gdGNwX3Jlc3BvbmQuCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IEZpeCB3cm9uZyBsZW5ndGggaW4gSVAgaGVh
ZGVyIGluIHRjcF9yZXNwb25kLi4uLgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiMyNDogRklMRTogc2xpcnAvdGNwX3N1YnIuYzoyMDc6CiteSSAgICBpcC0+aXBfbGVu
ID0gbS0+bV9sZW47JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MzM6IEZJTEU6IHNsaXJwL3RjcF9zdWJyLmM6MjI3OgorXkkgICAgaXA2LT5pcF9wbCA9IHRjcGlw
aF9zYXZlLnRpX2xlbjskCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDE2IGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
