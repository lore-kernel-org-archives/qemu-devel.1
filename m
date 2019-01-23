Received: from eggs.gnu.org ([209.51.188.92]:40873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmNwz-0004GM-Lo
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmNwx-0007c7-Pv
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:12:37 -0500
Resent-Message-Id: <E1gmNwx-0007c7-Pv@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gmNws-0007Y2-HO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:12:31 -0500
Message-ID: <154827072741.21.15238243883709698749@ebba9967afc0>
In-Reply-To: <20190118122210.505-1-kraxel@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 23 Jan 2019 11:12:08 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExODEyMjIxMC41MDUt
MS1rcmF4ZWxAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTAxMTgxMjIyMTAuNTA1LTEta3JheGVsQHJlZGhhdC5j
b20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGF1ZGlvOiBmaXgg
cGMgc3BlYWtlciBpbml0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphNzYyYjI4IGF1ZGlvOiBmaXgg
cGMgc3BlYWtlciBpbml0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2UgcHJvaGli
aXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM2Mzog
RklMRTogaHcvYXVkaW8vcGNzcGsuYzoxNzU6CisgICAgICAgIGVycm9yX3NldGcgKGVycnAsICJJ
bml0aWFsaXppbmcgYXVkaW8gdm9pY2UgZmFpbGVkIik7CgpFUlJPUjogc3BhY2UgcHJvaGliaXRl
ZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM4NTogRklM
RTogaHcvYXVkaW8vcGNzcGsuYzoyMjc6CisgICAgaXNhX2NyZWF0ZV9zaW1wbGUgKGJ1cywgVFlQ
RV9QQ19TUEVBS0VSKTsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNzAgbGluZXMgY2hl
Y2tlZAoKQ29tbWl0IGE3NjJiMjg4ZTMyOCAoYXVkaW86IGZpeCBwYyBzcGVha2VyIGluaXQpIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMTE4MTIyMjEwLjUwNS0xLWtyYXhlbEByZWRoYXQuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
