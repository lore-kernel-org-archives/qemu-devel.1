Received: from eggs.gnu.org ([209.51.188.92]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGkw-0007fb-28
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGkv-00016n-6p
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:08:06 -0500
Resent-Message-Id: <E1gpGkv-00016n-6p@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpGku-00016Y-TV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:08:05 -0500
Message-ID: <154895807297.23946.4476769951357932930@ebba9967afc0>
In-Reply-To: <mvmh8dt3vrp.fsf@suse.de>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 10:07:53 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix emulation of
 accept4/getpeername/getsockname/recvfrom syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: schwab@suse.de
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9tdm1oOGR0M3ZycC5mc2ZAc3Vz
ZS5kZS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxl
IHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gbGludXgtdXNlcjogZml4IGVtdWxhdGlvbiBvZiBhY2Nl
cHQ0L2dldHBlZXJuYW1lL2dldHNvY2tuYW1lL3JlY3Zmcm9tIHN5c2NhbGxzClR5cGU6IHNlcmll
cwpNZXNzYWdlLWlkOiBtdm1oOGR0M3ZycC5mc2ZAc3VzZS5kZQoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZm
ODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKY2E4YzYyNWYyYiBsaW51eC11c2VyOiBmaXggZW11bGF0aW9uIG9mIGFjY2VwdDQvZ2V0cGVl
cm5hbWUvZ2V0c29ja25hbWUvcmVjdmZyb20gc3lzY2FsbHMKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0
ZW1lbnQKIzQxOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzoyODc3OgorICAgICAgICBpZiAo
cHV0X3VzZXJfdTMyKHJldF9hZGRybGVuLCB0YXJnZXRfYWRkcmxlbl9hZGRyKSkKWy4uLl0KCkVS
Uk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1l
bnQKIzY1OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzoyOTA3OgorICAgICAgICBpZiAocHV0
X3VzZXJfdTMyKHJldF9hZGRybGVuLCB0YXJnZXRfYWRkcmxlbl9hZGRyKSkKWy4uLl0KCkVSUk9S
OiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQK
Izg5OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzoyOTM3OgorICAgICAgICBpZiAocHV0X3Vz
ZXJfdTMyKHJldF9hZGRybGVuLCB0YXJnZXRfYWRkcmxlbl9hZGRyKSkKWy4uLl0KCnRvdGFsOiAz
IGVycm9ycywgMCB3YXJuaW5ncywgOTggbGluZXMgY2hlY2tlZAoKQ29tbWl0IGNhOGM2MjVmMmIw
MCAobGludXgtdXNlcjogZml4IGVtdWxhdGlvbiBvZiBhY2NlcHQ0L2dldHBlZXJuYW1lL2dldHNv
Y2tuYW1lL3JlY3Zmcm9tIHN5c2NhbGxzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9tdm1oOGR0M3Zy
cC5mc2ZAc3VzZS5kZS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
