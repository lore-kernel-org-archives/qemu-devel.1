Received: from eggs.gnu.org ([2001:4830:134:3::10]:47777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2Bnf-0001T0-BE
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2Bnc-0000xQ-7n
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:51:31 -0400
Resent-Message-Id: <E1e2Bnc-0000xQ-7n@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e2Bnb-0000vN-Vf
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:51:28 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150770825027.288.14016348862385661354@b58463cdfd5f>
In-Reply-To: <20171011071423.20179-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 11 Oct 2017 00:50:50 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access in mode4and5 write
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, niuguoxiang@huawei.com, pjp@fedoraproject.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMDExMDcxNDIzLjIwMTc5LTEta3JheGVsQHJlZGhhdC5jb20KU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gY2lycnVzOiBmaXggb29iIGFjY2VzcyBpbiBtb2RlNGFu
ZDUgd3JpdGUgZnVuY3Rpb25zCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1s
KQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1h
dD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAi
Q2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYyku
Li4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hv
CiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIHQgW3RhZyB1
cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE3MTAxMTAwMDY0OS4yMjAxMi0xLWRhdmlkQGdp
YnNvbi5kcm9wYmVhci5pZC5hdSAtPiBwYXRjaGV3LzIwMTcxMDExMDAwNjQ5LjIyMDEyLTEtZGF2
aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
Y2I0NThhYjY5MSBjaXJydXM6IGZpeCBvb2IgYWNjZXNzIGluIG1vZGU0YW5kNSB3cml0ZSBmdW5j
dGlvbnMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogY2lycnVzOiBm
aXggb29iIGFjY2VzcyBpbiBtb2RlNGFuZDUgd3JpdGUgZnVuY3Rpb25zLi4uCkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzI0OiBGSUxFOiBody9kaXNwbGF5L2NpcnJ1
c192Z2EuYzoyMDQyOgorXklkc3QgPSBzLT52Z2EudnJhbV9wdHIgKyAoKG9mZnNldCt4KSAmIHMt
PmNpcnJ1c19hZGRyX21hc2spOyQKCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQg
JysnIChjdHg6VnhWKQojMjQ6IEZJTEU6IGh3L2Rpc3BsYXkvY2lycnVzX3ZnYS5jOjIwNDI6CisJ
ZHN0ID0gcy0+dmdhLnZyYW1fcHRyICsgKChvZmZzZXQreCkgJiBzLT5jaXJydXNfYWRkcl9tYXNr
KTsKIAkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBjb2RlIGluZGVu
dCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzQxOiBGSUxFOiBody9kaXNwbGF5L2NpcnJ1c192Z2Eu
YzoyMDYzOgorXklkc3QgPSBzLT52Z2EudnJhbV9wdHIgKyAoKG9mZnNldCArIDIgKiB4KSAmIHMt
PmNpcnJ1c19hZGRyX21hc2sgJiB+MSk7JAoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAz
MiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxp
c3RzLm9yZw==
