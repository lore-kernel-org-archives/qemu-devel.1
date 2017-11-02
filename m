Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eAPpW-0002nc-0u
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 20:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eAPpS-0005sZ-TZ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 20:27:26 -0400
Resent-Message-Id: <E1eAPpS-0005sZ-TZ@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eAPpS-0005lW-Lf
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 20:27:22 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150964073694.216.3626923485460882393@bafd83ae6430>
In-Reply-To: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 2 Nov 2017 09:38:57 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] cpu-exec: Exit exclusive region on
 longjmp from step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, cota@braap.org, alex.bennee@linaro.org, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2Ml0gY3B1LWV4ZWM6IEV4aXQgZXhjbHVzaXZlIHJlZ2lvbiBvbiBsb25n
am1wIGZyb20gc3RlcF9hdG9taWMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1MDk2NDA1MzYt
MzIxNjAtMS1naXQtc2VuZC1lbWFpbC1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQg
bG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9y
IGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQo
Z2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1m
b3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4K
ICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUK
CmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1
MDk2NDA1MzYtMzIxNjAtMS1naXQtc2VuZC1lbWFpbC1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcg
LT4gcGF0Y2hldy8xNTA5NjQwNTM2LTMyMTYwLTEtZ2l0LXNlbmQtZW1haWwtcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmYyNDVjYjNkYiBj
cHUtZXhlYzogRXhpdCBleGNsdXNpdmUgcmVnaW9uIG9uIGxvbmdqbXAgZnJvbSBzdGVwX2F0b21p
YwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBjcHUtZXhlYzogRXhp
dCBleGNsdXNpdmUgcmVnaW9uIG9uIGxvbmdqbXAgZnJvbSBzdGVwX2F0b21pYy4uLgpFUlJPUjog
VXNlIG9mIHZvbGF0aWxlIGlzIHVzdWFsbHkgd3Jvbmc6IHNlZSBEb2N1bWVudGF0aW9uL3ZvbGF0
aWxlLWNvbnNpZGVyZWQtaGFybWZ1bC50eHQKIzM3OiBGSUxFOiBhY2NlbC90Y2cvY3B1LWV4ZWMu
YzoyMzc6CisgICAgdm9sYXRpbGUgYm9vbCBpbl9leGNsdXNpdmVfcmVnaW9uID0gZmFsc2U7Cgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDM4IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2gg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
