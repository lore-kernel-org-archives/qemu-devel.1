Received: from eggs.gnu.org ([2001:4830:134:3::10]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e9zl3-0004Gp-Ts
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e9zkz-0001dj-6J
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:37:05 -0400
Resent-Message-Id: <E1e9zkz-0001dj-6J@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e9zky-0001ca-US
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:37:01 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150945407694.171.3840260638410608643@bafd83ae6430>
In-Reply-To: <20171031104835.3079.2722.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 31 Oct 2017 05:47:57 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFCPATCH10/20] icount: fixed saving/restoring of
 icount warp timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel.Dovgaluk@ispras.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtSRkNQQVRDSDEwLzIwXSBpY291bnQ6IGZpeGVkIHNhdmluZy9yZXN0b3Jpbmcgb2Yg
aWNvdW50IHdhcnAgdGltZXJzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE3MTAzMTEwNDgz
NS4zMDc5LjI3MjIuc3RnaXRAcGFzaGEtVmlydHVhbEJveAoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5l
ICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIk
KGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0
czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEg
LS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8
IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxl
ZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVk
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODlkY2U0
NGY1NyBpY291bnQ6IGZpeGVkIHNhdmluZy9yZXN0b3Jpbmcgb2YgaWNvdW50IHdhcnAgdGltZXJz
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGljb3VudDogZml4ZWQg
c2F2aW5nL3Jlc3RvcmluZyBvZiBpY291bnQgd2FycCB0aW1lcnMuLi4KRVJST1I6IHNwYWNlcyBy
ZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpWeFYpCiMxNzA6IEZJTEU6IGNwdXMuYzo2ODg6
CisgICAgLnN1YnNlY3Rpb25zID0gKGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbipbXSkgewogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDE3NCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
