Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cUavn-00022O-Fv
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cUavm-0003eh-8R
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:16:47 -0500
Resent-Message-Id: <E1cUavm-0003eh-8R@eggs.gnu.org>
Message-ID: <148492538828.28.1259083181223489954@b042e9bf0dd0>
In-Reply-To: <1484903866-17940-1-git-send-email-bharata@linux.vnet.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 20 Jan 2017 07:16:29 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH v1] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtSRkMgUEFUQ0ggdjFdIHNvZnRmbG9hdDogQWRkIHJvdW5kLXRvLW9kZCByb3VuZGlu
ZyBtb2RlCk1lc3NhZ2UtaWQ6IDE0ODQ5MDM4NjYtMTc5NDAtMS1naXQtc2VuZC1lbWFpbC1iaGFy
YXRhQGxpbnV4LnZuZXQuaWJtLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGlu
ZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFT
RS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8k
dG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNo
b3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4r
MSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjBkMWY3ZWEgc29mdGZsb2F0OiBBZGQgcm91bmQtdG8tb2RkIHJvdW5k
aW5nIG1vZGUKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogc29mdGZs
b2F0OiBBZGQgcm91bmQtdG8tb2RkIHJvdW5kaW5nIG1vZGUuLi4KRVJST1I6IHNwYWNlIHByb2hp
Yml0ZWQgYWZ0ZXIgdGhhdCBvcGVuIHBhcmVudGhlc2lzICcoJwojNDc6IEZJTEU6IGZwdS9zb2Z0
ZmxvYXQuYzoxMTc3OgorICAgICAgICAgICAgICAgICB8fCAoIHJvdW5kaW5nTW9kZSA9PSBmbG9h
dF9yb3VuZF90b19vZGQgKQoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQgY2xv
c2UgcGFyZW50aGVzaXMgJyknCiM0NzogRklMRTogZnB1L3NvZnRmbG9hdC5jOjExNzc6CisgICAg
ICAgICAgICAgICAgIHx8ICggcm91bmRpbmdNb2RlID09IGZsb2F0X3JvdW5kX3RvX29kZCApCgp0
b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDQyIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2gg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
