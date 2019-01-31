Received: from eggs.gnu.org ([209.51.188.92]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGZw-0006J6-DK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGZp-0005FN-NK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:38 -0500
Resent-Message-Id: <E1gpGZp-0005FN-NK@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpGZe-0005AZ-BW
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:31 -0500
Message-ID: <154895735984.23946.3842399831769514791@ebba9967afc0>
In-Reply-To: <20190129121817.7109-1-jusual@mail.ru>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 09:56:01 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] arm: Clarify the logic of set_pc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, jusual@mail.ru, stefanha@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEyOTEyMTgxNy43MTA5
LTEtanVzdWFsQG1haWwucnUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGFybTogQ2xhcmlmeSB0aGUgbG9n
aWMgb2Ygc2V0X3BjKCkKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwMTI5MTIxODE3Ljcx
MDktMS1qdXN1YWxAbWFpbC5ydQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZWViMmJmYjY3ZiBhcm06
IENsYXJpZnkgdGhlIGxvZ2ljIG9mIHNldF9wYygpCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJP
UjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBsaXN0CiMy
OiAKQXV0aG9yOiBKdWxpYSBTdXZvcm92YSB2aWEgUWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25n
bnUub3JnPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMTAgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IGVlYjJiZmI2N2Y4ZCAoYXJtOiBDbGFyaWZ5IHRoZSBsb2dpYyBvZiBzZXRfcGMoKSkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAxMjkxMjE4MTcuNzEwOS0xLWp1c3VhbEBtYWlsLnJ1
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
