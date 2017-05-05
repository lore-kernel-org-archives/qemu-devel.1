Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d6gZS-0005kz-0w
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d6gZR-0006Wx-1N
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:59:10 -0400
Resent-Message-Id: <E1d6gZR-0006Wx-1N@eggs.gnu.org>
In-Reply-To: <20170505101930.45837-1-aik@ozlabs.ru>
Message-ID: <149400352505.195.6424501929960866515@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 5 May 2017 09:58:45 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggcWVtdSB2Nl0gbWVtb3J5L2lvbW11OiBRT00nZnkg
SU9NTVUgTWVtb3J5UmVnaW9uCk1lc3NhZ2UtaWQ6IDIwMTcwNTA1MTAxOTMwLjQ1ODM3LTEtYWlr
QG96bGFicy5ydQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1i
YXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVk
PTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1y
ZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5n
IFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAg
aWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkK
ICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKY2UxZDQ0NyBtZW1vcnkvaW9tbXU6IFFPTSdmeSBJ
T01NVSBNZW1vcnlSZWdpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEv
MTogbWVtb3J5L2lvbW11OiBRT00nZnkgSU9NTVUgTWVtb3J5UmVnaW9uLi4uCkVSUk9SOiBzcGFj
ZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hPKQojMTU3OiBGSUxFOiBody9kbWEv
cmM0MDMwLmM6NzIwOgorRGV2aWNlU3RhdGUgKnJjNDAzMF9pbml0KHJjNDAzMF9kbWEgKipkbWFz
LCBJT01NVU1lbW9yeVJlZ2lvbiAqKmRtYV9tcikKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgODQ0IGxpbmVzIGNoZWNr
ZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
