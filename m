Received: from eggs.gnu.org ([2001:4830:134:3::10]:43839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f6ton-0007Sa-NW
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1f6toj-0006ff-Ke
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:12:25 -0400
Resent-Message-Id: <E1f6toj-0006ff-Ke@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1f6toj-0006US-E8
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:12:21 -0400
In-Reply-To: <20180413075200.15217-1-clg@kaod.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152360619100.1854.4118391342119729453@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 13 Apr 2018 00:56:32 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: clg@kaod.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peter.maydell@linaro.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, kwankhede@nvidia.com, zhenyuw@linux.intel.com, yulei.zhang@intel.com, alex.williamson@redhat.com, pbonzini@redhat.com, zhi.a.wang@intel.com, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNDEzMDc1MjAwLjE1MjE3LTEtY2xnQGthb2Qub3JnClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggdjJdIG1pZ3JhdGlvbjogZGlzY2FyZCBub24tbWlncmF0YWJsZSBS
QU1CbG9ja3MKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFz
ZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0w
CgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4p
Igpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3Rh
bDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAk
YyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsg
dGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkK
ZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNo
ZXcvMTUyMzM3MjQ4Ni0xMzE5MC0xLWdpdC1zZW5kLWVtYWlsLXdhbGxpbmdAbGludXguaWJtLmNv
bSAtPiBwYXRjaGV3LzE1MjMzNzI0ODYtMTMxOTAtMS1naXQtc2VuZC1lbWFpbC13YWxsaW5nQGxp
bnV4LmlibS5jb20KICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDQxMzA3
NTIwMC4xNTIxNy0xLWNsZ0BrYW9kLm9yZyAtPiBwYXRjaGV3LzIwMTgwNDEzMDc1MjAwLjE1MjE3
LTEtY2xnQGthb2Qub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNTlmN2RkNDM1
MSBtaWdyYXRpb246IGRpc2NhcmQgbm9uLW1pZ3JhdGFibGUgUkFNQmxvY2tzCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IG1pZ3JhdGlvbjogZGlzY2FyZCBub24tbWln
cmF0YWJsZSBSQU1CbG9ja3MuLi4KRVJST1I6IE1hY3JvcyB3aXRoIG11bHRpcGxlIHN0YXRlbWVu
dHMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIGEgZG8gLSB3aGlsZSBsb29wCiM5NjogRklMRTogbWln
cmF0aW9uL3JhbS5jOjE5MToKKyNkZWZpbmUgUkFNQkxPQ0tfRk9SRUFDSF9NSUdSQVRBQkxFKGJs
b2NrKSAgICAgICAgICAgICBcCisgICAgUkFNQkxPQ0tfRk9SRUFDSChibG9jaykgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAorICAgICAgICBpZiAoIXFlbXVfcmFtX2lzX21pZ3JhdGFibGUo
YmxvY2spKSB7fSBlbHNlCgpFUlJPUjogdHJhaWxpbmcgc3RhdGVtZW50cyBzaG91bGQgYmUgb24g
bmV4dCBsaW5lCiM5ODogRklMRTogbWlncmF0aW9uL3JhbS5jOjE5MzoKKyAgICAgICAgaWYgKCFx
ZW11X3JhbV9pc19taWdyYXRhYmxlKGJsb2NrKSkge30gZWxzZQoKdG90YWw6IDIgZXJyb3JzLCAw
IHdhcm5pbmdzLCAxNjcgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=
