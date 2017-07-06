Received: from eggs.gnu.org ([2001:4830:134:3::10]:35408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXE-0002Wm-Iu
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXD-00083J-Lz
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:12 -0400
Resent-Message-Id: <E1dTGXD-00083J-Lz@eggs.gnu.org>
In-Reply-To: <1498734863-164338-1-git-send-email-imammedo@redhat.com>
Message-ID: <149938500132.27.16593111081087749477@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:50:02 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] qom: enforce readonly nature of link's
 check callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.orgfamz@redhat.com, mst@redhat.com, alistair.francis@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, edgar.iglesias@gmail.com, afaerber@suse.de

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gcW9tOiBlbmZvcmNlIHJlYWRvbmx5IG5hdHVyZSBvZiBsaW5rJ3MgY2hl
Y2sgY2FsbGJhY2sKTWVzc2FnZS1pZDogMTQ5ODczNDg2My0xNjQzMzgtMS1naXQtc2VuZC1lbWFp
bC1pbWFtbWVkb0ByZWRoYXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5l
ICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIk
KGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0
czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEg
LS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8
IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxl
ZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVk
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiBDYW5ub3QgdXBkYXRlIHBhdGhzIGFuZCBzd2l0Y2gg
dG8gYnJhbmNoICd0ZXN0JyBhdCB0aGUgc2FtZSB0aW1lLgpEaWQgeW91IGludGVuZCB0byBjaGVj
a291dCAnb3JpZ2luL3BhdGNoZXcvMTQ5ODczNDg2My0xNjQzMzgtMS1naXQtc2VuZC1lbWFpbC1p
bWFtbWVkb0ByZWRoYXQuY29tJyB3aGljaCBjYW4gbm90IGJlIHJlc29sdmVkIGFzIGNvbW1pdD8K
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21lL2ZhbS9iaW4v
cGF0Y2hldyIsIGxpbmUgNDQwLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUs
IHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi9ob21lL2ZhbS9iaW4vcGF0Y2hl
dyIsIGxpbmUgNTMsIGluIGdpdF9jbG9uZV9yZXBvCiAgICBjd2Q9Y2xvbmUpCiAgRmlsZSAiL3Vz
ci9saWI2NC9weXRob24zLjUvc3VicHJvY2Vzcy5weSIsIGxpbmUgMjcxLCBpbiBjaGVja19jYWxs
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAnY2hlY2tvdXQnLCAnb3JpZ2luL3Bh
dGNoZXcvMTQ5ODczNDg2My0xNjQzMzgtMS1naXQtc2VuZC1lbWFpbC1pbWFtbWVkb0ByZWRoYXQu
Y29tJywgJy1iJywgJ3Rlc3QnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMTI4CgoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZy
ZWVsaXN0cy5vcmc=
