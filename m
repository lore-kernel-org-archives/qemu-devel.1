Received: from eggs.gnu.org ([2001:4830:134:3::10]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fW8uN-0007KP-Lt
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 19:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fW8uK-0005gT-GP
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 19:22:31 -0400
Resent-Message-Id: <E1fW8uK-0005gT-GP@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fW8uK-0005do-7r
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 19:22:28 -0400
In-Reply-To: <20180621171925.28925-1-kwolf@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152960978840.840.4936658682667342998@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 21 Jun 2018 12:36:28 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] file-posix: Implement co versions of
 discard/flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjIxMTcxOTI1LjI4OTI1LTEta3dvbGZAcmVkaGF0LmNvbQpTdWJqZWN0
OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBmaWxlLXBvc2l4OiBJbXBsZW1lbnQgY28gdmVyc2lvbnMg
b2YgZGlzY2FyZC9mbHVzaAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoK
QkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkK
ZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2Ug
JEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0gg
JG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdp
dCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0k
KChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo1YzZhNTA4YjVjIGZpbGUtcG9zaXg6IEltcGxlbWVudCBjbyB2
ZXJzaW9ucyBvZiBkaXNjYXJkL2ZsdXNoCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQ
QVRDSCAxLzE6IGZpbGUtcG9zaXg6IEltcGxlbWVudCBjbyB2ZXJzaW9ucyBvZiBkaXNjYXJkL2Zs
dXNoLi4uCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJ3wnIChjdHg6VnhWKQoj
MTIzOiBGSUxFOiBibG9jay9maWxlLXBvc2l4LmM6Mjk0OToKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgUUVNVV9BSU9fRElTQ0FSRHxRRU1VX0FJT19CTEtERVYpOwogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBu
ZXZlciB1c2UgdGFicwojMTMzOiBGSUxFOiBibG9jay9maWxlLXBvc2l4LmM6MzA1MzoKKyAgICAu
YmRydl9jb19mbHVzaF90b19kaXNrXkk9IHJhd19jb19mbHVzaF90b19kaXNrLCQKCkVSUk9SOiBj
b2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE0MzogRklMRTogYmxvY2svZmlsZS1w
b3NpeC5jOjMxNzg6CisgICAgLmJkcnZfY29fZmx1c2hfdG9fZGlza15JPSByYXdfY29fZmx1c2hf
dG9fZGlzaywkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxNTI6
IEZJTEU6IGJsb2NrL2ZpbGUtcG9zaXguYzozMzA4OgorICAgIC5iZHJ2X2NvX2ZsdXNoX3RvX2Rp
c2teST0gcmF3X2NvX2ZsdXNoX3RvX2Rpc2ssJAoKdG90YWw6IDQgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxMzEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=
