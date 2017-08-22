Received: from eggs.gnu.org ([2001:4830:134:3::10]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dk0gM-0007kO-PT
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dk0gH-0006Ry-VR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:20:50 -0400
Resent-Message-Id: <E1dk0gH-0006Ry-VR@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dk0gH-0006PM-Lb
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:20:45 -0400
Message-ID: <150337563395.30.17715522257119694180@205a2245145f>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170821211320.7026-1-mtparkr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 21 Aug 2017 21:20:34 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] audio: intel-hda: do not use old_mmio
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mtparkr@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwODIxMjExMzIwLjcwMjYtMS1tdHBhcmtyQGdtYWlsLmNvbQpTdWJqZWN0
OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBhdWRpbzogaW50ZWwtaGRhOiBkbyBub3QgdXNlIG9sZF9t
bWlvIGFjY2Vzc2VzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNF
PWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWls
ZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAt
LXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tp
bmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAg
ICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBm
aQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4N2VhMzc1YjFlIGF1ZGlvOiBpbnRlbC1oZGE6
IGRvIG5vdCB1c2Ugb2xkX21taW8gYWNjZXNzZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogYXVkaW86IGludGVsLWhkYTogZG8gbm90IHVzZSBvbGRfbW1pbyBhY2Nl
c3Nlcy4uLgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTk6IEZJTEU6IGh3L2F1
ZGlvL2ludGVsLWhkYS5jOjEwNDY6CitzdGF0aWMgdm9pZCBpbnRlbF9oZGFfbW1pb193cml0ZSh2
b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWwsIHVuc2lnbmVkIHNpemUpCgpF
UlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDEg
d2FybmluZ3MsIDc1IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEBmcmVlbGlzdHMub3Jn
