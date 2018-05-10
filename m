Received: from eggs.gnu.org ([2001:4830:134:3::10]:42727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fHUz4-0000Ul-WC
	for qemu-devel@nongnu.org; Sat, 12 May 2018 09:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fHUz1-0004eP-A8
	for qemu-devel@nongnu.org; Sat, 12 May 2018 09:54:51 -0400
Resent-Message-Id: <E1fHUz1-0004eP-A8@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fHUz1-0004dN-1K
	for qemu-devel@nongnu.org; Sat, 12 May 2018 09:54:47 -0400
In-Reply-To: <20180510220248.10272-1-clg@kaod.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152599001965.2838.8997910885648763807@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 10 May 2018 15:07:01 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3] migration: discard non-migratable
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
c3NhZ2UtaWQ6IDIwMTgwNTEwMjIwMjQ4LjEwMjcyLTEtY2xnQGthb2Qub3JnClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggdjNdIG1pZ3JhdGlvbjogZGlzY2FyZCBub24tbWlncmF0YWJsZSBS
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
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNo
ZXcvMjAxODA1MTAyMjAyNDguMTAyNzItMS1jbGdAa2FvZC5vcmcgLT4gcGF0Y2hldy8yMDE4MDUx
MDIyMDI0OC4xMDI3Mi0xLWNsZ0BrYW9kLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjBmYjY4YWUyZWIgbWlncmF0aW9uOiBkaXNjYXJkIG5vbi1taWdyYXRhYmxlIFJBTUJsb2Nr
cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBtaWdyYXRpb246IGRp
c2NhcmQgbm9uLW1pZ3JhdGFibGUgUkFNQmxvY2tzLi4uCkVSUk9SOiBNYWNyb3Mgd2l0aCBtdWx0
aXBsZSBzdGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBhIGRvIC0gd2hpbGUgbG9vcAoj
OTI6IEZJTEU6IG1pZ3JhdGlvbi9yYW0uYzoxOTE6CisjZGVmaW5lIFJBTUJMT0NLX0ZPUkVBQ0hf
TUlHUkFUQUJMRShibG9jaykgICAgICAgICAgICAgXAorICAgIFJBTUJMT0NLX0ZPUkVBQ0goYmxv
Y2spICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgaWYgKCFxZW11X3JhbV9p
c19taWdyYXRhYmxlKGJsb2NrKSkge30gZWxzZQoKRVJST1I6IHRyYWlsaW5nIHN0YXRlbWVudHMg
c2hvdWxkIGJlIG9uIG5leHQgbGluZQojOTQ6IEZJTEU6IG1pZ3JhdGlvbi9yYW0uYzoxOTM6Cisg
ICAgICAgIGlmICghcWVtdV9yYW1faXNfbWlncmF0YWJsZShibG9jaykpIHt9IGVsc2UKCnRvdGFs
OiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTc5IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
