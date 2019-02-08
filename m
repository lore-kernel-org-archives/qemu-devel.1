Received: from eggs.gnu.org ([209.51.188.92]:52937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1grxLk-0001OP-ES
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1grxLj-0001H1-K1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:01:12 -0500
Resent-Message-Id: <E1grxLj-0001H1-K1@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1grxLj-0001Es-CA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:01:11 -0500
Message-ID: <154959845867.29184.15672560764966908589@ebba9967afc0>
In-Reply-To: <20190208035551.3036-1-richard.henderson@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 7 Feb 2019 20:00:59 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] tcg: Diagnose referenced labels that have
 not been emitted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIwODAzNTU1MS4zMDM2
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0hdIHRjZzogRGlhZ25vc2UgcmVmZXJlbmNlZCBsYWJlbHMgdGhhdCBoYXZlIG5vdCBiZWVu
IGVtaXR0ZWQKTWVzc2FnZS1pZDogMjAxOTAyMDgwMzU1NTEuMzAzNi0xLXJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDIwODAzNTU1MS4zMDM2LTEtcmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIwMTkwMjA4MDM1NTUxLjMwMzYtMS1y
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKNzAyYTE1MiB0Y2c6IERpYWdub3NlIHJlZmVyZW5jZWQgbGFiZWxzIHRoYXQgaGF2ZSBub3Qg
YmVlbiBlbWl0dGVkCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2VzIHByb2hpYml0
ZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6V3hXKQojOTA6IEZJTEU6IHRjZy90Y2cuaDoyNDk6Cisg
ICAgdW5zaWduZWQgcHJlc2VudCA6IDE7CiAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjog
c3BhY2VzIHByb2hpYml0ZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6V3hXKQojOTM6IEZJTEU6IHRj
Zy90Y2cuaDoyNTE6CisgICAgdW5zaWduZWQgaWQgOiAxNDsKICAgICAgICAgICAgICAgICBeCgp0
b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDc5IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA3MDJh
MTUyZjdkMDYgKHRjZzogRGlhZ25vc2UgcmVmZXJlbmNlZCBsYWJlbHMgdGhhdCBoYXZlIG5vdCBi
ZWVuIGVtaXR0ZWQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMjA4MDM1NTUxLjMwMzYtMS1y
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t
