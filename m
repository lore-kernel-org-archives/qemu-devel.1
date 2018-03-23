Received: from eggs.gnu.org ([2001:4830:134:3::10]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ezeJX-0004Lt-Hm
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 04:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ezeJV-0000bn-4D
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 04:14:11 -0400
Resent-Message-Id: <E1ezeJV-0000bn-4D@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ezeJU-0000bd-Tu
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 04:14:09 -0400
In-Reply-To: <20180323143202.28879-1-lvivier@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152182237902.291.10506431455446754776@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 23 Mar 2018 09:26:21 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 0/5] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lvivier@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, agraf@suse.de, jcmvbkbc@gmail.com, berto@igalia.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, yongbok.kim@mips.com, armbru@redhat.com, rth@twiddle.netfamz@redhat.com, ehabkost@redhat.com, dgilbert@redhat.com, qemu-arm@nongnu.org, david@gibson.dropbear.id.au, kwolf@redhat.com, crosthwaite.peter@gmail.com, i.mitsyanko@gmail.com, mreitz@redhat.com, qemu-ppc@nongnu.org, pbonzini@redhat.com, aurelien@aurel32.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMzIzMTQzMjAyLjI4ODc5LTEtbHZpdmllckByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMC81XSBjb2NjaW5lbGxlOiByZS1ydW4gc2NyaXB0
cyBmcm9tIHNjcmlwdHMvY29jY2luZWxsZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4g
fCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAt
LXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tp
bmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAg
ICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBm
aQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4NGEwZTM0YjZjIFJlbW92ZSB1bm5lY2Vzc2Fy
eSB2YXJpYWJsZXMgZm9yIGZ1bmN0aW9uIHJldHVybiB2YWx1ZQoxNzU5NDExOGRjIHFkaWN0OiBy
ZW1vdmUgdXNlbGVzcyBjYXN0CjkyZTBlNjQ2YzIgZXJyb3I6IFJlbW92ZSBOVUxMIGNoZWNrcyBv
biBlcnJvcl9wcm9wYWdhdGUoKSBjYWxscwpkMzRlZDIzMTczIGVycm9yOiBTdHJpcCB0cmFpbGlu
ZyAnXG4nIGZyb20gZXJyb3Igc3RyaW5nIGFyZ3VtZW50cyAoYWdhaW4gYWdhaW4pCmExZDE1ODFh
ZDUgbWFrZTogaW1wcm92ZSBjaGVjayBmb3Igc3RhbGUgZ2VuZXJhdGVkIGZpbGVzIGluIHNvdXJj
ZSBkaXIKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvNTogbWFrZTogaW1w
cm92ZSBjaGVjayBmb3Igc3RhbGUgZ2VuZXJhdGVkIGZpbGVzIGluIHNvdXJjZSBkaXIuLi4KQ2hl
Y2tpbmcgUEFUQ0ggMi81OiBlcnJvcjogU3RyaXAgdHJhaWxpbmcgJ1xuJyBmcm9tIGVycm9yIHN0
cmluZyBhcmd1bWVudHMgKGFnYWluIGFnYWluKS4uLgpDaGVja2luZyBQQVRDSCAzLzU6IGVycm9y
OiBSZW1vdmUgTlVMTCBjaGVja3Mgb24gZXJyb3JfcHJvcGFnYXRlKCkgY2FsbHMuLi4KQ2hlY2tp
bmcgUEFUQ0ggNC81OiBxZGljdDogcmVtb3ZlIHVzZWxlc3MgY2FzdC4uLgpDaGVja2luZyBQQVRD
SCA1LzU6IFJlbW92ZSB1bm5lY2Vzc2FyeSB2YXJpYWJsZXMgZm9yIGZ1bmN0aW9uIHJldHVybiB2
YWx1ZS4uLgpFUlJPUjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUg
bm90IHJlcXVpcmVkCiMyNTM6IEZJTEU6IHRhcmdldC9taXBzL2RzcF9oZWxwZXIuYzozMjgxOgor
ICAgIHJldHVybiAodGVtcFsxXSA8PCA2MykgfCAodGVtcFswXSA+PiAxKTsKCkVSUk9SOiByZXR1
cm4gaXMgbm90IGEgZnVuY3Rpb24sIHBhcmVudGhlc2VzIGFyZSBub3QgcmVxdWlyZWQKIzI3Mjog
RklMRTogdGFyZ2V0L21pcHMvZHNwX2hlbHBlci5jOjMzMDg6CisgICAgcmV0dXJuICh0ZW1wWzFd
IDw8IDYzKSB8ICh0ZW1wWzBdID4+IDEpOwoKRVJST1I6IHJldHVybiBpcyBub3QgYSBmdW5jdGlv
biwgcGFyZW50aGVzZXMgYXJlIG5vdCByZXF1aXJlZAojMjkxOiBGSUxFOiB0YXJnZXQvbWlwcy9k
c3BfaGVscGVyLmM6MzM0MToKKyAgICByZXR1cm4gKHRlbXBbMV0gPDwgNjMpIHwgKHRlbXBbMF0g
Pj4gMSk7Cgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDgxNyBsaW5lcyBjaGVja2VkCgpZ
b3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
