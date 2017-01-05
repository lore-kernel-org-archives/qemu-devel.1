Received: from eggs.gnu.org ([2001:4830:134:3::10]:36025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cPEAm-0008Uo-E1
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 14:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cPEAl-0008RJ-CS
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 14:58:04 -0500
Resent-Message-Id: <E1cPEAl-0008RJ-CS@eggs.gnu.org>
In-Reply-To: <20170105195349.28031-1-andrew.smirnov@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148364626740.172.15001610034048262405@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 5 Jan 2017 11:57:48 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] fsl_etsec: Fix Tx BD ring wrapping
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: andrew.smirnov@gmail.com
Cc: famz@redhat.com, qemu-ppc@nongnu.org, scottwood@freescale.com, jasowang@redhat.com, agraf@suse.de, qemu-devel@nongnu.org

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwMTA1MTk1MzQ5LjI4MDMxLTEtYW5kcmV3LnNtaXJub3ZAZ21haWwuY29t
ClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGZzbF9ldHNlYzogRml4IFR4IEJEIHJp
bmcgd3JhcHBpbmcgaGFuZGxpbmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2Mg
LWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29t
bWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4g
JGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxv
ZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9
ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAg
ICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQg
JGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTcwMTA1MTk1MzQ5
LjI4MDMxLTEtYW5kcmV3LnNtaXJub3ZAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAxNzAxMDUxOTUz
NDkuMjgwMzEtMS1hbmRyZXcuc21pcm5vdkBnbWFpbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwoxOWNlNDQ5IGZzbF9ldHNlYzogRml4IFR4IEJEIHJpbmcgd3JhcHBpbmcgaGFu
ZGxpbmcKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogZnNsX2V0c2Vj
OiBGaXggVHggQkQgcmluZyB3cmFwcGluZyBoYW5kbGluZy4uLgpFUlJPUjogYnJhY2VzIHt9IGFy
ZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM5NDogRklMRTogaHcv
bmV0L2ZzbF9ldHNlYy9yaW5ncy5jOjM2MToKKyAgICAgICAgaWYgKCEoYmRfZmxhZ3MgJiBCRF9U
WF9SRUFEWSkpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDMyIGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
