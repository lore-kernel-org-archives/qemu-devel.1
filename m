Received: from eggs.gnu.org ([2001:4830:134:3::10]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cfpzC-0005G9-AU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cfpz9-0002uQ-1B
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:34:46 -0500
Resent-Message-Id: <E1cfpz9-0002uQ-1B@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cfpz8-0002tU-P4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:34:42 -0500
In-Reply-To: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148760487755.30.18440037856821614050@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 20 Feb 2017 07:34:38 -0800 (PST)
Subject: Re: [Qemu-devel] [RfC PATCH] vga: wire up -g <width>x<height>
 switch for virtio and qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUmZDIFBBVENIXSB2Z2E6IHdpcmUgdXAgLWcgPHdpZHRoPng8
aGVpZ2h0PiBzd2l0Y2ggZm9yIHZpcnRpbyBhbmQgcXhsCk1lc3NhZ2UtaWQ6IDE0ODc2MDM3NjMt
MTQ5MzItMS1naXQtc2VuZC1lbWFpbC1rcmF4ZWxAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1v
bmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNl
ICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENI
ICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBn
aXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49
JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRh
dGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMTQ4NzYwMzc2My0xNDkzMi0xLWdpdC1zZW5kLWVtYWlsLWtyYXhlbEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMTQ4NzYwMzc2My0xNDkzMi0xLWdpdC1zZW5kLWVtYWlsLWtyYXhlbEByZWRo
YXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYWJiYWZlYSB2Z2E6IHdpcmUg
dXAgLWcgPHdpZHRoPng8aGVpZ2h0PiBzd2l0Y2ggZm9yIHZpcnRpbyBhbmQgcXhsCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHZnYTogd2lyZSB1cCAtZyA8d2lkdGg+
eDxoZWlnaHQ+IHN3aXRjaCBmb3IgdmlydGlvIGFuZCBxeGwuLi4KRVJST1I6IGlmIHRoaXMgY29k
ZSBpcyByZWR1bmRhbnQgY29uc2lkZXIgcmVtb3ZpbmcgaXQKIzQ1OiBGSUxFOiBody9kaXNwbGF5
L3F4bC5jOjM3MToKKyNpZiAwCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDc0IGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
