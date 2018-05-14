Received: from eggs.gnu.org ([2001:4830:134:3::10]:39549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fIqIt-00063l-Dm
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fIqIq-0005cm-9c
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:52:51 -0400
Resent-Message-Id: <E1fIqIq-0005cm-9c@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fIqIq-0005cD-1K
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:52:48 -0400
In-Reply-To: <20180514065700.22202-1-clg@kaod.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152628148497.72.13531163263342901933@1f70390a8372>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 14 May 2018 00:04:46 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v4] migration: discard non-migratable
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
c3NhZ2UtaWQ6IDIwMTgwNTE0MDY1NzAwLjIyMjAyLTEtY2xnQGthb2Qub3JnClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggdjRdIG1pZ3JhdGlvbjogZGlzY2FyZCBub24tbWlncmF0YWJsZSBS
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
ZXcvMjAxODA1MTQwNjU3MDAuMjIyMDItMS1jbGdAa2FvZC5vcmcgLT4gcGF0Y2hldy8yMDE4MDUx
NDA2NTcwMC4yMjIwMi0xLWNsZ0BrYW9kLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjZjMWQ4ODNmNzQgbWlncmF0aW9uOiBkaXNjYXJkIG5vbi1taWdyYXRhYmxlIFJBTUJsb2Nr
cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBtaWdyYXRpb246IGRp
c2NhcmQgbm9uLW1pZ3JhdGFibGUgUkFNQmxvY2tzLi4uCkVSUk9SOiBNYWNyb3Mgd2l0aCBtdWx0
aXBsZSBzdGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBhIGRvIC0gd2hpbGUgbG9vcAoj
MTg4OiBGSUxFOiBtaWdyYXRpb24vcmFtLmM6MTU3OgorI2RlZmluZSBSQU1CTE9DS19GT1JFQUNI
X01JR1JBVEFCTEUoYmxvY2spICAgICAgICAgICAgIFwKKyAgICBSQU1CTE9DS19GT1JFQUNIKGJs
b2NrKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgIGlmICghcWVtdV9yYW1f
aXNfbWlncmF0YWJsZShibG9jaykpIHt9IGVsc2UKCkVSUk9SOiB0cmFpbGluZyBzdGF0ZW1lbnRz
IHNob3VsZCBiZSBvbiBuZXh0IGxpbmUKIzE5MDogRklMRTogbWlncmF0aW9uL3JhbS5jOjE1OToK
KyAgICAgICAgaWYgKCFxZW11X3JhbV9pc19taWdyYXRhYmxlKGJsb2NrKSkge30gZWxzZQoKdG90
YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNzMgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
