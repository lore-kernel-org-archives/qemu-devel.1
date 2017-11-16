Received: from eggs.gnu.org ([2001:4830:134:3::10]:41196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eFNTS-0003Ob-5N
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eFNTP-0001ef-21
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:57:10 -0500
Resent-Message-Id: <E1eFNTP-0001ef-21@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eFNTO-0001cl-Qq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:57:06 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151084505905.408.1535217155620668296@bafd83ae6430>
In-Reply-To: <20171116052511.16236-1-caoxinhua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 16 Nov 2017 07:11:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] ipmi: check ibe status before ibe outlen
 at ipmi_bmc_extern_handle_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: caoxinhua@huawei.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, f4bug@amsat.org, anton.nefedov@virtuozzo.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, weidong.huang@huawei.com, weifuqiang@huawei.com, yanqiangjun@huawei.com, king.wang@huawei.com, arei.gonglei@huawei.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gaXBtaTogY2hlY2sgaWJlIHN0YXR1cyBiZWZvcmUgaWJlIG91dGxlbiBh
dCBpcG1pX2JtY19leHRlcm5faGFuZGxlX2NvbW1hbmQKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6
IDIwMTcxMTE2MDUyNTExLjE2MjM2LTEtY2FveGluaHVhQGh1YXdlaS5jb20KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9n
IC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoK
Y29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMg
aW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0
IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3Jt
YXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAg
ICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4
aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTcx
MTE2MDUyNTExLjE2MjM2LTEtY2FveGluaHVhQGh1YXdlaS5jb20gLT4gcGF0Y2hldy8yMDE3MTEx
NjA1MjUxMS4xNjIzNi0xLWNhb3hpbmh1YUBodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKYjIzNjRkZTA1MCBpcG1pOiBjaGVjayBpYmUgc3RhdHVzIGJlZm9yZSBpYmUg
b3V0bGVuIGF0IGlwbWlfYm1jX2V4dGVybl9oYW5kbGVfY29tbWFuZAoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBpcG1pOiBjaGVjayBpYmUgc3RhdHVzIGJlZm9yZSBp
YmUgb3V0bGVuIGF0IGlwbWlfYm1jX2V4dGVybl9oYW5kbGVfY29tbWFuZC4uLgpFUlJPUjogbGlu
ZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzk0OiBGSUxFOiBody9pcG1pL2lwbWlfYm1jX2V4dGVybi5j
OjIxOToKKyAgICAgICAgUUVNVV9MT0coTE9HX0VSUiwgIklQTUkgS0NTOiBHb3QgY29tbWFuZCB3
aGVuIG5vdCBmaW5pc2hlZCB3aXRoIHRoZSBwcmV2aW91cyBjb21tYW5kXG4iKTsKCkVSUk9SOiBN
aXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5n
cywgNDIgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZy
ZWVsaXN0cy5vcmc=
