Received: from eggs.gnu.org ([2001:4830:134:3::10]:44879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cYXHe-0000Hc-Co
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cYXHZ-00027B-Pf
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:11:38 -0500
Resent-Message-Id: <E1cYXHZ-00027B-Pf@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cYXHZ-000270-Fz
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:11:33 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170131115913.6828.12266.stgit@PASHA-ISP>
Message-ID: <148586468644.33.894043856547178057@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 31 Jan 2017 04:11:27 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pavel.dovgaluk@ispras.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGF1ZGlvOiBtYWtlIGF1ZGlvIHBvbGwgdGltZXIg
ZGV0ZXJtaW5pc3RpYwpNZXNzYWdlLWlkOiAyMDE3MDEzMTExNTkxMy42ODI4LjEyMjY2LnN0Z2l0
QFBBU0hBLUlTUAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
YXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVk
PTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdp
dCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsg
ZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1m
b3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0x
CiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNzAxMzExMTU5MTMuNjgyOC4xMjI2
Ni5zdGdpdEBQQVNIQS1JU1AgLT4gcGF0Y2hldy8yMDE3MDEzMTExNTkxMy42ODI4LjEyMjY2LnN0
Z2l0QFBBU0hBLUlTUApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjljN2FjNTMgYXVk
aW86IG1ha2UgYXVkaW8gcG9sbCB0aW1lciBkZXRlcm1pbmlzdGljCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGF1ZGlvOiBtYWtlIGF1ZGlvIHBvbGwgdGltZXIgZGV0
ZXJtaW5pc3RpYy4uLgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5h
bWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiMyMzogRklMRTogYXVkaW8vYXVkaW8uYzoxMTE2
OgorICAgICAgICAgICAgdGltZXJfbW9kIChzLT50cywKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMTIgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QGZyZWVsaXN0cy5vcmc=
