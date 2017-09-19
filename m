Received: from eggs.gnu.org ([2001:4830:134:3::10]:35494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1duJ1M-0007LQ-Ar
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1duJ1I-0002kN-B9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:57:04 -0400
Resent-Message-Id: <E1duJ1I-0002kN-B9@eggs.gnu.org>
In-Reply-To: <20170919125041.2153-1-f4bug@amsat.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150582940762.57.11503092763565098162@69b6ddf88678>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 19 Sep 2017 06:56:48 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hw/input/lm832x: move LM8323 declarations
 to input/keypad.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org
Cc: famz@redhat.com, peter.maydell@linaro.org, balrogg@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gaHcvaW5wdXQvbG04MzJ4OiBtb3ZlIExNODMyMyBkZWNsYXJhdGlvbnMg
dG8gaW5wdXQva2V5cGFkLmgKTWVzc2FnZS1pZDogMjAxNzA5MTkxMjUwNDEuMjE1My0xLWY0YnVn
QGFtc2F0Lm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwg
d2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0t
Zm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBl
Y2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVz
ICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAg
IGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NAplcnJvcjogUlBDIGZhaWxlZDsgY3VybCAxOCB0cmFuc2ZlciBjbG9zZWQgd2l0aCBv
dXRzdGFuZGluZyByZWFkIGRhdGEgcmVtYWluaW5nCmZhdGFsOiBUaGUgcmVtb3RlIGVuZCBodW5n
IHVwIHVuZXhwZWN0ZWRseQplcnJvcjogQ291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi91c3IvYmluL3BhdGNoZXciLCBsaW5lIDQ0MiwgaW4gdGVzdF9vbmUKICAgIGdp
dF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZikKICBGaWxlICIv
dXNyL2Jpbi9wYXRjaGV3IiwgbGluZSA0OCwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN0ZG91dD1s
b2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNz
LnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J2dpdCcsICdyZW1vdGUnLCAnYWRkJywgJy1mJywgJy0tbWlycm9yPWZldGNoJywgJzNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEuCgoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZy
ZWVsaXN0cy5vcmc=
