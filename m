Received: from eggs.gnu.org ([2001:4830:134:3::10]:34739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fX4LW-0003fr-Sw
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 08:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fX4LS-0002Vf-VK
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 08:42:22 -0400
Resent-Message-Id: <E1fX4LS-0002Vf-VK@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fX4LS-0002VV-NB
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 08:42:18 -0400
In-Reply-To: <1529716721-28400-1-git-send-email-linux@roeck-us.net>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152972968974.939.5579728435885834082@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 22 Jun 2018 21:54:50 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Fix sam460ex devicetree when
 booting the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux@roeck-us.net
Cc: famz@redhat.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1Mjk3MTY3MjEtMjg0MDAtMS1naXQtc2VuZC1lbWFpbC1saW51eEByb2Vjay11
cy5uZXQKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gcHBjOiBGaXggc2FtNDYwZXgg
ZGV2aWNldHJlZSB3aGVuIGJvb3RpbmcgdGhlIExpbnV4IGtlcm5lbAoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1v
bmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxv
ZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwog
ICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1h
dD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAg
ICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1NWIyMWU2YTRmIHBw
YzogRml4IHNhbTQ2MGV4IGRldmljZXRyZWUgd2hlbiBib290aW5nIHRoZSBMaW51eCBrZXJuZWwK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogcHBjOiBGaXggc2FtNDYw
ZXggZGV2aWNldHJlZSB3aGVuIGJvb3RpbmcgdGhlIExpbnV4IGtlcm5lbC4uLgpFUlJPUjogYnJh
Y2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM0NDog
RklMRTogaHcvcHBjL3NhbTQ2MGV4LmM6MzE2OgorICAgIGlmIChvZmZzZXQgPj0gMCkKWy4uLl0K
CnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNDEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRj
aCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
