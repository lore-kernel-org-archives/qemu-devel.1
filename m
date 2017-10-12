Received: from eggs.gnu.org ([2001:4830:134:3::10]:50920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2j4M-0001Wq-2I
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2j4J-0000tA-Ce
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:22:58 -0400
Resent-Message-Id: <E1e2j4J-0000tA-Ce@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e2j4J-0000sE-3g
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:22:55 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150783522220.294.9273927523316867120@b58463cdfd5f>
In-Reply-To: <20171012143548.18581-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 12 Oct 2017 12:07:02 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: trap on instructions
 longer than >15 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, richard.henderson@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDEyMTQzNTQ4LjE4NTgxLTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvMl0gdGFyZ2V0L2kzODY6IHRyYXAgb24gaW5zdHJ1
Y3Rpb25zIGxvbmdlciB0aGFuID4xNSBieXRlcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNF
Li4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBs
b2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8K
ICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3Jt
YXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAg
ICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNGU0OTU1MTA3MiB0
YXJnZXQvaTM4NjogdHJhcCBvbiBpbnN0cnVjdGlvbnMgbG9uZ2VyIHRoYW4gPjE1IGJ5dGVzCjc0
MjAyYTdhZWYgdGFyZ2V0L2kzODY6IGludHJvZHVjZSB4ODZfbGQqX2NvZGUKCj09PSBPVVRQVVQg
QkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMjogdGFyZ2V0L2kzODY6IGludHJvZHVjZSB4ODZf
bGQqX2NvZGUuLi4KQ2hlY2tpbmcgUEFUQ0ggMi8yOiB0YXJnZXQvaTM4NjogdHJhcCBvbiBpbnN0
cnVjdGlvbnMgbG9uZ2VyIHRoYW4gPjE1IGJ5dGVzLi4uCkVSUk9SOiBVc2Ugb2Ygdm9sYXRpbGUg
aXMgdXN1YWxseSB3cm9uZzogc2VlIERvY3VtZW50YXRpb24vdm9sYXRpbGUtY29uc2lkZXJlZC1o
YXJtZnVsLnR4dAojNjk6IEZJTEU6IHRhcmdldC9pMzg2L3RyYW5zbGF0ZS5jOjE4ODE6CisgICAg
ICAgICAgICB2b2xhdGlsZSB1aW50OF90IHVudXNlZCA9Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDUzIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEBmcmVlbGlzdHMub3Jn
