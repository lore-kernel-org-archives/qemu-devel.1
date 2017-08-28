Received: from eggs.gnu.org ([2001:4830:134:3::10]:52356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dmJrW-00022d-Fy
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dmJrQ-0007Vt-Nd
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:13:54 -0400
Resent-Message-Id: <E1dmJrQ-0007Vt-Nd@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dmJrQ-0007Vc-G5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:13:48 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150392599255.51.8963072091091627194@2c699d6fd5aa>
In-Reply-To: <1503924917-12687-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 28 Aug 2017 06:13:13 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] qemu crashes when a negative number
 used for 'maxcpus'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: s1seetee@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIHFlbXUgY3Jhc2hlcyB3aGVuIGEgbmVnYXRp
dmUgbnVtYmVyIHVzZWQgZm9yICdtYXhjcHVzJwpNZXNzYWdlLWlkOiAxNTAzOTI0OTE3LTEyNjg3
LTEtZ2l0LXNlbmQtZW1haWwtczFzZWV0ZWVAbGludXgudm5ldC5pYm0uY29tCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxv
ZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
CmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBj
IGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdp
dCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9y
bWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAg
ICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpl
eGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTAz
OTI0OTE3LTEyNjg3LTEtZ2l0LXNlbmQtZW1haWwtczFzZWV0ZWVAbGludXgudm5ldC5pYm0uY29t
IC0+IHBhdGNoZXcvMTUwMzkyNDkxNy0xMjY4Ny0xLWdpdC1zZW5kLWVtYWlsLXMxc2VldGVlQGxp
bnV4LnZuZXQuaWJtLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmJkYzc2NzBi
YjIgcWVtdSBjcmFzaGVzIHdoZW4gYSBuZWdhdGl2ZSBudW1iZXIgdXNlZCBmb3IgJ21heGNwdXMn
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHFlbXUgY3Jhc2hlcyB3
aGVuIGEgbmVnYXRpdmUgbnVtYmVyIHVzZWQgZm9yICdtYXhjcHVzJy4uLgpFUlJPUjogY29kZSBp
bmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzOTogRklMRTogdmwuYzoxMjQ4OgorXklpZiAo
bWF4X2NwdXMgPCAwKSB7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFi
cwojNDA6IEZJTEU6IHZsLmM6MTI0OToKK15JXkllcnJvcl9yZXBvcnQoIkludmFsaWQgbWF4X2Nw
dXMgOiAlZCIsIG1heF9jcHVzKTskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiM0MTogRklMRTogdmwuYzoxMjUwOgorXkleSWV4aXQoMSk7JAoKRVJST1I6IGNvZGUg
aW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDI6IEZJTEU6IHZsLmM6MTI1MToKK15JfSQK
CnRvdGFsOiA0IGVycm9ycywgMCB3YXJuaW5ncywgMTEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRj
aCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
