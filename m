Received: from eggs.gnu.org ([2001:4830:134:3::10]:47606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cLyO0-0003jC-DE
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cLyNx-0001MT-A4
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:30:16 -0500
Resent-Message-Id: <E1cLyNx-0001MT-A4@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cLyNx-0001LV-2A
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:30:13 -0500
In-Reply-To: <20161227165947.20184-1-Sergio.G.DelReal@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148287060398.127.456458115700006245@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 27 Dec 2016 12:30:05 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] hw/dma: Fix dead code in pl080.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sergio.g.delreal@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, Sergio.G.DelReal@gmail.com, peter.maydell@linaro.org

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NjEyMjcxNjU5NDcuMjAxODQtMS1TZXJnaW8uRy5EZWxSZWFsQGdtYWlsLmNvbQpUeXBlOiBzZXJp
ZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gaHcvZG1hOiBGaXggZGVhZCBjb2RlIGlu
IHBsMDgwLmMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFz
ZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0w
CgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTYxMjI3MTY1OTQ3LjIwMTg0LTEtU2Vy
Z2lvLkcuRGVsUmVhbEBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE2MTIyNzE2NTk0Ny4yMDE4NC0x
LVNlcmdpby5HLkRlbFJlYWxAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKNjgyY2ZhMiBody9kbWE6IEZpeCBkZWFkIGNvZGUgaW4gcGwwODAuYwoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBody9kbWE6IEZpeCBkZWFkIGNvZGUgaW4gcGww
ODAuYy4uLgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICctJyAoY3R4OlZ4VikK
IzI4OiBGSUxFOiBody9kbWEvcGwwODAuYzoyNTg6CisgICAgICAgIHN3aXRjaCAoKG9mZnNldC0w
eDEwMCkgPj4gMikgewogICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICctJyAoY3R4OlZ4VikKIzM3OiBGSUxFOiBody9kbWEvcGwwODAu
YzozMTk6CisgICAgICAgIHN3aXRjaCAoKG9mZnNldC0weDEwMCkgPj4gMikgewogICAgICAgICAg
ICAgICAgICAgICAgICBeCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDE2IGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
