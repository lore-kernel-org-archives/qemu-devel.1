Received: from eggs.gnu.org ([2001:4830:134:3::10]:47735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f1UVT-0005C0-V1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f1UVP-0005DC-JE
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:10:07 -0400
Resent-Message-Id: <E1f1UVP-0005DC-JE@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f1UVP-0005Ck-Bt
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:10:03 -0400
In-Reply-To: <1522204637-29589-1-git-send-email-zhenwei.pi@youruncloud.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152231818320.714.14936280462660778373@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 29 Mar 2018 03:09:44 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] file-posix: Support fallocate for block
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhenwei.pi@youruncloud.com
Cc: famz@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MjIyMDQ2MzctMjk1ODktMS1naXQtc2VuZC1lbWFpbC16aGVud2VpLnBpQHlv
dXJ1bmNsb3VkLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBmaWxlLXBvc2l4OiBT
dXBwb3J0IGZhbGxvY2F0ZSBmb3IgYmxvY2sgZGV2aWNlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUg
JEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9y
bWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hv
ICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRj
KS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVj
aG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM5NTVjMDg1MTUgZmlsZS1wb3Np
eDogU3VwcG9ydCBmYWxsb2NhdGUgZm9yIGJsb2NrIGRldmljZQoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBmaWxlLXBvc2l4OiBTdXBwb3J0IGZhbGxvY2F0ZSBmb3Ig
YmxvY2sgZGV2aWNlLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFy
bXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzY2OiBGSUxFOiBibG9jay9maWxlLXBvc2l4LmM6MTM4NToK
KyAgICAgICAgaWYgKHJldCA9PSAwKSB7ClsuLi5dCi0gICAgICAgIH0KWy4uLl0KCkVSUk9SOiBi
cmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzcw
OiBGSUxFOiBibG9jay9maWxlLXBvc2l4LmM6MTM4NzoKKyAgICAgICAgfSBlbHNlIGlmIChyZXQg
PT0gLUVOT1RTVVApClsuLi5dCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDU3IGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
