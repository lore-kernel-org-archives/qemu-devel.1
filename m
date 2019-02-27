Received: from eggs.gnu.org ([209.51.188.92]:34529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz3ZL-00082O-Fd
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz3ZJ-0004VM-IT
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:04:34 -0500
Resent-Message-Id: <E1gz3ZJ-0004VM-IT@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gz3ZB-0004PO-LJ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:04:27 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <155129065167.2181.450874955675443689@49fa7ef69f7b>
In-Reply-To: <1550677216-5077-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 27 Feb 2019 10:04:12 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] chardev-socket: do not blindly reset
 handlers when switching GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, marcandre.lureau@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTUwNjc3MjE2LTUwNzctMS1n
aXQtc2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAxNTUwNjc3MjE2LTUwNzctMS1naXQt
c2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFU
Q0hdIGNoYXJkZXYtc29ja2V0OiBkbyBub3QgYmxpbmRseSByZXNldCBoYW5kbGVycyB3aGVuIHN3
aXRjaGluZyBHTWFpbkNvbnRleHQKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjNiOTBkN2UxZDcgY2hhcmRl
di1zb2NrZXQ6IGRvIG5vdCBibGluZGx5IHJlc2V0IGhhbmRsZXJzIHdoZW4gc3dpdGNoaW5nIEdN
YWluQ29udGV4dAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogQmxvY2sgY29tbWVudHMg
dXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzEwMjogRklMRTogdGVzdHMvdGVz
dC1jaGFyLmM6MTA3MToKKyAgICAvKiBTdGFydCBhIHNlY29uZCBjb25uZWN0aW9uIHdoaWxlIHRo
ZSBmaXJzdCBpcyBzdGlsbCBjb25uZWN0ZWQuCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMxMzY6IEZJTEU6IHRlc3RzL3Rlc3QtY2hhci5jOjE0NDE6CiteSV5JICAg
ICAgICAgY2hhcl9zb2NrZXRfc2VydmVyX3R3b19jbGllbnRzX3Rlc3QpOyQKCkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzEzODogRklMRTogdGVzdHMvdGVzdC1jaGFy
LmM6MTQ0MzoKK15JXkkgICAgICAgICBjaGFyX3NvY2tldF9zZXJ2ZXJfdHdvX2NsaWVudHNfdGVz
dCk7JAoKdG90YWw6IDIgZXJyb3JzLCAxIHdhcm5pbmdzLCAxMTUgbGluZXMgY2hlY2tlZAoKQ29t
bWl0IDNiOTBkN2UxZDc3OCAoY2hhcmRldi1zb2NrZXQ6IGRvIG5vdCBibGluZGx5IHJlc2V0IGhh
bmRsZXJzIHdoZW4gc3dpdGNoaW5nIEdNYWluQ29udGV4dCkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MTU1MDY3NzIxNi01MDc3LTEtZ2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
