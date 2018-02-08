Received: from eggs.gnu.org ([2001:4830:134:3::10]:41708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eju4o-00031h-E8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eju4l-00083J-B7
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:49:54 -0500
Resent-Message-Id: <E1eju4l-00083J-B7@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eju4l-00082Q-2u
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:49:51 -0500
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151812384146.315.18040123279259830558@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 8 Feb 2018 13:04:02 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 00/24] re-factor and add fp16 using glibc
 soft-fp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org, alex.bennee@linaro.org, hsp.cat7@gmail.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMjA0MDQxMTM2LjE3NTI1LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAwLzI0XSByZS1mYWN0b3IgYW5kIGFk
ZCBmcDE2IHVzaW5nIGdsaWJjIHNvZnQtZnAKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4u
IHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9n
IC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAg
ICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0
PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAg
ICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NAplcnJvcjogUlBDIGZhaWxlZDsgY3VybCAxOCB0cmFuc2ZlciBjbG9zZWQgd2l0
aCBvdXRzdGFuZGluZyByZWFkIGRhdGEgcmVtYWluaW5nCmZhdGFsOiBUaGUgcmVtb3RlIGVuZCBo
dW5nIHVwIHVuZXhwZWN0ZWRseQplcnJvcjogQ291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi91c3IvYmluL3BhdGNoZXciLCBsaW5lIDQ0MiwgaW4gdGVzdF9vbmUKICAg
IGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZikKICBGaWxl
ICIvdXNyL2Jpbi9wYXRjaGV3IiwgbGluZSA0OCwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN0ZG91
dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9j
ZXNzLnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5k
ICdbJ2dpdCcsICdyZW1vdGUnLCAnYWRkJywgJy1mJywgJy0tbWlycm9yPWZldGNoJywgJzNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEu
CgoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QGZyZWVsaXN0cy5vcmc=
