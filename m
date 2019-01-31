Received: from eggs.gnu.org ([209.51.188.92]:53346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGf8-0002rE-NR
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGf3-0007Tw-1V
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:02:06 -0500
Resent-Message-Id: <E1gpGf3-0007Tw-1V@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpGf2-0007T3-Nb
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:02:00 -0500
Message-ID: <154895769070.23946.11678939191059468727@ebba9967afc0>
In-Reply-To: <23B229B3-3095-4DFB-8369-866784808D30@me.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 10:01:31 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] ui/egl-helpers: Augment parameter list
 of egl_texture_blend() to convey scales of viewport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, kraxel@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yM0IyMjlCMy0zMDk1LTRERkIt
ODM2OS04NjY3ODQ4MDhEMzBAbWUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyM0IyMjlCMy0zMDk1LTRERkItODM2OS04NjY3ODQ4
MDhEMzBAbWUuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIHVpL2VnbC1oZWxw
ZXJzOiBBdWdtZW50IHBhcmFtZXRlciBsaXN0IG9mIGVnbF90ZXh0dXJlX2JsZW5kKCkgdG8gY29u
dmV5IHNjYWxlcyBvZiB2aWV3cG9ydApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjIxNzZlZjQgdWkvZWdsLWhlbHBlcnM6IEF1Z21lbnQgcGFyYW1ldGVyIGxpc3Qgb2YgZWdsX3Rl
eHR1cmVfYmxlbmQoKSB0byBjb252ZXkgc2NhbGVzIG9mIHZpZXdwb3J0Cgo9PT0gT1VUUFVUIEJF
R0lOID09PQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUgbWFp
bGluZyBsaXN0CiMyOiAKQXV0aG9yOiBDaGVuIFpoYW5nIHZpYSBRZW11LWRldmVsIDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDUzIGxpbmVzIGNo
ZWNrZWQKCkNvbW1pdCAyMTc2ZWY0M2FmZDQgKHVpL2VnbC1oZWxwZXJzOiBBdWdtZW50IHBhcmFt
ZXRlciBsaXN0IG9mIGVnbF90ZXh0dXJlX2JsZW5kKCkgdG8gY29udmV5IHNjYWxlcyBvZiB2aWV3
cG9ydCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjNCMjI5QjMtMzA5NS00REZCLTgzNjktODY2Nzg0
ODA4RDMwQG1lLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
