Received: from eggs.gnu.org ([209.51.188.92]:36437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLcGv-00088n-IV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLcGu-0000Wc-AA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:49 -0400
Resent-Message-Id: <E1hLcGu-0000Wc-AA@eggs.gnu.org>
In-Reply-To: <20190430231536.25353-1-jsnow@redhat.com>
Message-ID: <155666726797.10667.16771870824759307989@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 30 Apr 2019 16:34:29 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH RFC] migration/dirty-bitmaps: change bitmap
 enumeration method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.orgfam@euphon.net, vsementsov@virtuozzo.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQzMDIzMTUzNi4yNTM1
My0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDQzMDIzMTUzNi4yNTM1My0x
LWpzbm93QHJlZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBSRkNdIG1pZ3Jh
dGlvbi9kaXJ0eS1iaXRtYXBzOiBjaGFuZ2UgYml0bWFwIGVudW1lcmF0aW9uIG1ldGhvZAoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hl
dy1wcm9qZWN0L3FlbXUKIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQy
NDEwMzc0Ny4xMDE3My0xLXRodXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyNDEwMzc0
Ny4xMDE3My0xLXRodXRoQHJlZGhhdC5jb20KICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0
Y2hldy8yMDE5MDQzMDIzMTUzNi4yNTM1My0xLWpzbm93QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8y
MDE5MDQzMDIzMTUzNi4yNTM1My0xLWpzbm93QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcg
YnJhbmNoICd0ZXN0Jwo2YzQ1YzNmYmQ0IG1pZ3JhdGlvbi9kaXJ0eS1iaXRtYXBzOiBjaGFuZ2Ug
Yml0bWFwIGVudW1lcmF0aW9uIG1ldGhvZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1p
c3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAzOCBsaW5lcyBjaGVja2VkCgpDb21taXQgNmM0NWMzZmJkNDdkIChtaWdyYXRpb24vZGlydHkt
Yml0bWFwczogY2hhbmdlIGJpdG1hcCBlbnVtZXJhdGlvbiBtZXRob2QpIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkwNDMwMjMxNTM2LjI1MzUzLTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
