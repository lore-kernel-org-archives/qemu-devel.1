Received: from eggs.gnu.org ([2001:4830:134:3::10]:47181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eDFMj-00058l-GL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eDFMg-00062K-Es
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:25 -0500
Resent-Message-Id: <E1eDFMg-00062K-Es@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eDFMg-000621-7N
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:22 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151034356959.387.14630061645518323389@bafd83ae6430>
In-Reply-To: <20171110194935.17541-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 10 Nov 2017 11:52:50 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] linux-user,
 s390x: ignore OS ABI value in ELF header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: famz@redhat.com, qemu-devel@nongnu.org, huth@tuxfamily.org, peter.maydell@linaro.org, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gbGludXgtdXNlciwgczM5MHg6IGlnbm9yZSBPUyBBQkkgdmFsdWUgaW4g
RUxGIGhlYWRlcgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxNzExMTAxOTQ5MzUuMTc1NDEt
MS1sYXVyZW50QHZpdmllci5ldQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAt
bCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3Jt
YXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8g
IkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMp
Li4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNo
bwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEz
Mzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcg
dGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxNzExMTAxOTQ5MzUuMTc1NDEtMS1sYXVyZW50
QHZpdmllci5ldSAtPiBwYXRjaGV3LzIwMTcxMTEwMTk0OTM1LjE3NTQxLTEtbGF1cmVudEB2aXZp
ZXIuZXUKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowN2QwMGNlYTVlIGxpbnV4LXVz
ZXIsIHMzOTB4OiBpZ25vcmUgT1MgQUJJIHZhbHVlIGluIEVMRiBoZWFkZXIKCj09PSBPVVRQVVQg
QkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogbGludXgtdXNlciwgczM5MHg6IGlnbm9yZSBP
UyBBQkkgdmFsdWUgaW4gRUxGIGhlYWRlci4uLgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3Rl
cnMKIzM5OiBGSUxFOiBzY3JpcHRzL3FlbXUtYmluZm10LWNvbmYuc2g6ODg6CitzMzkweF9tYXNr
PSdceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHgwMFx4ZmZceGZmXHhmZlx4ZmZceGZmXHhm
Zlx4ZmZceGZmXHhmZlx4ZmVceGZmXHhmZicKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
OCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxp
c3RzLm9yZw==
