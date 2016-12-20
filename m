Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTPv-0006Y3-VE
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTPs-0003v6-Ui
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:01:56 -0500
Resent-Message-Id: <E1cJTPs-0003v6-Ui@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cJTPs-0003ug-MO
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:01:52 -0500
In-Reply-To: <1482140507-23607-1-git-send-email-vlad.lungu@windriver.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148227490601.73.14307493005138844836@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 20 Dec 2016 15:01:47 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCHv4] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vlad.lungu@windriver.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSHY0XSBtdWx0aWJvb3Q6IGNvcHkgdGhlIGNtZGxpbmUgdmVyYmF0aW0sIHVu
ZXNjYXBlIG1vZHVsZSBzdHJpbmdzCk1lc3NhZ2UtaWQ6IDE0ODIxNDA1MDctMjM2MDctMS1naXQt
c2VuZC1lbWFpbC12bGFkLmx1bmd1QHdpbmRyaXZlci5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0
IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9w
dGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAt
LXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tp
bmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAg
ICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBm
aQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5NTFjOGJlIG11bHRpYm9vdDogY29weSB0aGUg
Y21kbGluZSB2ZXJiYXRpbSwgdW5lc2NhcGUgbW9kdWxlIHN0cmluZ3MKCj09PSBPVVRQVVQgQkVH
SU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogbXVsdGlib290OiBjb3B5IHRoZSBjbWRsaW5lIHZl
cmJhdGltLCB1bmVzY2FwZSBtb2R1bGUgc3RyaW5ncy4uLgpXQVJOSU5HOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojNDI6IEZJTEU6IGh3L2kzODYvbXVsdGlib290LmM6Mjk5OgorICAgICAgICAg
ICAgbmV4dF9pbml0cmQgPSAoY2hhciAqKWdldF9vcHRfdmFsdWUodG1wYnVmLCBzaXplb2YodG1w
YnVmKSwgaW5pdHJkX2ZpbGVuYW1lKTsKCkVSUk9SOiBkbyBub3QgdXNlIGFzc2lnbm1lbnQgaW4g
aWYgY29uZGl0aW9uCiM1MDogRklMRTogaHcvaTM4Ni9tdWx0aWJvb3QuYzozMDQ6CisgICAgICAg
ICAgICBpZiAoKG5leHRfc3BhY2UgPSBzdHJjaHIodG1wYnVmLCAnICcpKSkKCkVSUk9SOiBicmFj
ZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzUwOiBG
SUxFOiBody9pMzg2L211bHRpYm9vdC5jOjMwNDoKKyAgICAgICAgICAgIGlmICgobmV4dF9zcGFj
ZSA9IHN0cmNocih0bXBidWYsICcgJykpKQpbLi4uXQoKdG90YWw6IDIgZXJyb3JzLCAxIHdhcm5p
bmdzLCA0OCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
ZnJlZWxpc3RzLm9yZw==
