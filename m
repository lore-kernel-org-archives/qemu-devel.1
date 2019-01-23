Received: from eggs.gnu.org ([209.51.188.92]:42134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmJZo-0005Q9-KI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmJRC-0004ra-JU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:23:32 -0500
Resent-Message-Id: <E1gmJRC-0004ra-JU@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gmJRC-0004qD-9c
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:23:30 -0500
Message-ID: <154825338186.21.2661799743092991292@ebba9967afc0>
In-Reply-To: <20190117210245.18364-1-eric.auger@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 23 Jan 2019 06:23:03 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com
Cc: fam@euphon.net, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, aik@ozlabs.ru, groug@kaod.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNzIxMDI0NS4xODM2
NC0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBTSE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBq
b2ItcW1wLm8KICBDQyAgICAgIHFkZXYtbW9uaXRvci5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9zaGVlcGRvZy5jOiBJbiBmdW5jdGlvbiAnZmluZF92ZGlfbmFtZSc6Ci90bXAvcWVtdS10ZXN0
L3NyYy9ibG9jay9zaGVlcGRvZy5jOjEyMzk6NTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQg
Ym91bmQgMjU2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5j
YXRpb25dCiAgICAgc3RybmNweShidWYgKyBTRF9NQVhfVkRJX0xFTiwgdGFnLCBTRF9NQVhfVkRJ
X1RBR19MRU4pOwogICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTAxMTcyMTAyNDUuMTgzNjQtMS1lcmljLmF1Z2VyQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXIt
bWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
