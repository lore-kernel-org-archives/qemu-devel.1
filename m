Received: from eggs.gnu.org ([2001:4830:134:3::10]:49046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1chHFU-0002YJ-HE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1chHFR-0000A8-AN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:53:32 -0500
Resent-Message-Id: <E1chHFR-0000A8-AN@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1chHFR-00008u-1L
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:53:29 -0500
In-Reply-To: <20170224134411.28882-1-mmarek@suse.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148794791903.177.12506775196291811914@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 24 Feb 2017 06:51:59 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mmarek@suse.com
Cc: famz@redhat.com, rth@twiddle.net, agraf@suse.de, ebischoff@suse.com, mbenes@suse.cz, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzAyMjQxMzQ0MTEuMjg4ODItMS1tbWFyZWtAc3VzZS5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0hdIHRhcmdldC1zMzkweDogSW1wbGVtZW50IHN0ZmwgYW5kIHN0
ZmxlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBV
c2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAt
LWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAg
ZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0l
cyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRz
L2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAg
ICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE3MDIyNDEzNDQxMS4yODg4Mi0xLW1tYXJla0Bz
dXNlLmNvbSAtPiBwYXRjaGV3LzIwMTcwMjI0MTM0NDExLjI4ODgyLTEtbW1hcmVrQHN1c2UuY29t
CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxNzAyMjQxMzUwNDUuMTA2MTMtMS1tYmVu
ZXNAc3VzZS5jeiAtPiBwYXRjaGV3LzIwMTcwMjI0MTM1MDQ1LjEwNjEzLTEtbWJlbmVzQHN1c2Uu
Y3oKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozZGFiYTliIHRhcmdldC1zMzkweDog
SW1wbGVtZW50IHN0ZmwgYW5kIHN0ZmxlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQ
QVRDSCAxLzE6IHRhcmdldC1zMzkweDogSW1wbGVtZW50IHN0ZmwgYW5kIHN0ZmxlLi4uCkVSUk9S
OiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQK
IzEwODogRklMRTogdGFyZ2V0L3MzOTB4L21pc2NfaGVscGVyLmM6NTIyOgorICAgIGlmIChuZWVk
IDw9IGxlbikKWy4uLl0KKyAgICBlbHNlClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDExMSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
ZnJlZWxpc3RzLm9yZw==
