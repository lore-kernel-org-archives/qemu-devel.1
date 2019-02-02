Received: from eggs.gnu.org ([209.51.188.92]:42734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gq6wI-0007gm-U6
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 20:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gq6wH-0001ha-S5
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 20:51:18 -0500
Resent-Message-Id: <E1gq6wH-0001ha-S5@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gq6wH-0001eZ-KG
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 20:51:17 -0500
Message-ID: <154914510871.29184.15581142770490504705@ebba9967afc0>
In-Reply-To: <20190122150543.16889-1-bala24@linux.vnet.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 2 Feb 2019 14:05:10 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/1] migration: calculate expected_downtime
 considering redirtied ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bala24@linux.vnet.ibm.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, david@gibson.dropbear.id.au

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEyMjE1MDU0My4xNjg4
OS0xLWJhbGEyNEBsaW51eC52bmV0LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgbmV0L3V0aWwubwogIENDICAgICAgbmV0L2h1Yi5vCi90bXAvcWVtdS10ZXN0L3NyYy9taWdy
YXRpb24vbWlncmF0aW9uLmM6IEluIGZ1bmN0aW9uICdtaWdyYXRpb25fdXBkYXRlX2NvdW50ZXJz
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9taWdyYXRpb24uYzoyOTA3Ojk6IGVycm9y
OiAncmVtYWluaW5nX3JhbV90cmFuc2Zlcl90aW1lJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbikKICAgICAgICAgcmVtYWluaW5nX3JhbV90cmFuc2Zlcl90aW1lID0gcmFt
X2NvdW50ZXJzLnJlbWFpbmluZyAvIGJhbmR3aWR0aAogICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9taWdyYXRpb24uYzoyOTA3
Ojk6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25j
ZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCi90bXAvcWVtdS10ZXN0L3NyYy9taWdy
YXRpb24vbWlncmF0aW9uLmM6MjkwNzo3MzogZXJyb3I6IGV4cGVjdGVkICc7JyBiZWZvcmUgJ25l
d2x5X2RpcnRpZWRfcmFtJwogICAgICAgICByZW1haW5pbmdfcmFtX3RyYW5zZmVyX3RpbWUgPSBy
YW1fY291bnRlcnMucmVtYWluaW5nIC8gYmFuZHdpZHRoCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA7CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDE5MDEyMjE1MDU0My4xNjg4OS0xLWJhbGEyNEBsaW51eC52bmV0LmlibS5j
b20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
