Received: from eggs.gnu.org ([2001:4830:134:3::10]:36670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fWMfw-0008Uh-2U
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fWMfs-00041V-T1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:04:32 -0400
Resent-Message-Id: <E1fWMfs-00041V-T1@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fWMfs-00041K-Jc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:04:28 -0400
In-Reply-To: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152967353172.876.8679943897946809404@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 22 Jun 2018 06:18:52 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix psci conduit in acpi when
 el3 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hongbo.zhang@linaro.org
Cc: famz@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1Mjk2NjM4MjctMjg4NTQtMS1naXQtc2VuZC1lbWFpbC1ob25nYm8uemhhbmdA
bGluYXJvLm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBody9hcm0vdmlydDogZml4
IHBzY2kgY29uZHVpdCBpbiBhY3BpIHdoZW4gZWwzIGVuYWJsZWQKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25l
bGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cg
LS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAg
IGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9
JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAg
ICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMzE3YTBjYzg0NyBody9h
cm0vdmlydDogZml4IHBzY2kgY29uZHVpdCBpbiBhY3BpIHdoZW4gZWwzIGVuYWJsZWQKCj09PSBP
VVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogaHcvYXJtL3ZpcnQ6IGZpeCBwc2Np
IGNvbmR1aXQgaW4gYWNwaSB3aGVuIGVsMyBlbmFibGVkLi4uCkVSUk9SOiB0cmFpbGluZyB3aGl0
ZXNwYWNlCiMyNzogRklMRTogaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jOjcyMToKKyAgICAgICAg
ICovICQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTIgbGluZXMgY2hlY2tlZAoKWW91
ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
