Received: from eggsout.gnu.org ([209.51.188.92]:55395 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gfY1e-0004nW-Ng
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gfY1b-0003lj-In
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:33:10 -0500
Resent-Message-Id: <E1gfY1b-0003lj-In@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gfY1b-0003kr-6m
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:33:07 -0500
In-Reply-To: <20190104153951.32306-1-eblake@redhat.com>
Message-ID: <154663843998.31063.6088337642335462195@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 4 Jan 2019 13:47:21 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEwNDE1Mzk1MS4zMjMw
Ni0xLWVibGFrZUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRv
czcgU0hPV19FTlY9MSBKPTgKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmxpYnBtZW0gc3VwcG9y
dCAgIG5vCmxpYnVkZXYgICAgICAgICAgIG5vCgpXQVJOSU5HOiBVc2Ugb2YgU0RMIDEuMiBpcyBk
ZXByZWNhdGVkIGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4KV0FSTklORzogZnV0dXJlIHJlbGVhc2Vz
LiBQbGVhc2Ugc3dpdGNoIHRvIHVzaW5nIFNETCAyLjAKCk5PVEU6IGNyb3NzLWNvbXBpbGVycyBl
bmFibGVkOiAgJ2NjJwogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvY29uZmlnLWRldmljZXMubWFr
LnRtcAotLS0KICBDQyAgICAgIGJsb2NrL2NvbW1pdC5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAv
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5jOjEzOjA6Ci90bXAvcWVtdS10
ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6IEluIGZ1bmN0aW9uICdibGtfZ2V0X21heF90
cmFuc2Zlcic6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvb3NkZXAuaDoyNTc6OTog
ZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdfX2F1dG9fdHlwZScKICAgICAgICAgX19hdXRvX3R5
cGUgX2EgPSAoYSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgICBeCi90bXAv
cWVtdS10ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6MTgxNzoxMjogbm90ZTogaW4gZXhw
YW5zaW9uIG9mIG1hY3JvICdNSU5fTk9OX1pFUk8nCiAgICAgcmV0dXJuIE1JTl9OT05fWkVSTyht
YXgsIElOVF9NQVgpOwogICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3Fl
bXUvb3NkZXAuaDoyNTg6OTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdfX2F1dG9fdHlwZScK
ICAgICAgICAgX19hdXRvX3R5cGUgX2IgPSAoYik7ICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAogICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6MTgx
NzoxMjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdNSU5fTk9OX1pFUk8nCiAgICAgcmV0
dXJuIE1JTl9OT05fWkVSTyhtYXgsIElOVF9NQVgpOwogICAgICAgICAgICBeCi90bXAvcWVtdS10
ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6IEF0IHRvcCBsZXZlbDoKY2MxOiBlcnJvcjog
dW5yZWNvZ25pemVkIGNvbW1hbmQgbGluZSBvcHRpb24gIi1Xbm8tZm9ybWF0LXRydW5jYXRpb24i
IFstV2Vycm9yXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
OiAqKiogW2Jsb2NrL2Jsb2NrLWJhY2tlbmQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAxMDQxNTM5NTEuMzIzMDYtMS1lYmxha2VAcmVkaGF0
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
