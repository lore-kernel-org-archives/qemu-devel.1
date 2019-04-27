Received: from eggs.gnu.org ([209.51.188.92]:55389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKPd3-0006QS-3Z
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKPd1-0007dl-PJ
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:52:41 -0400
Resent-Message-Id: <E1hKPd1-0007dl-PJ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hKPd1-0007cx-Hi
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:52:39 -0400
In-Reply-To: <20190427153031.5119-1-samuel.thibault@ens-lyon.org>
Message-ID: <155638031671.10667.7688967011446219214@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 27 Apr 2019 08:51:58 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] curses: Do not assume wchar_t contains
 unicode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, kamil@netbsd.org, kraxel@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNzE1MzAzMS41MTE5
LTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMg
YW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91
IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJH
RVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBBUyAgICAgIG9wdGlvbnJvbS9saW51eGJvb3QubwogIEFTICAgICAgb3B0aW9ucm9t
L2t2bXZhcGljLm8KICBBUyAgICAgIG9wdGlvbnJvbS9wdmgubwovdG1wL3FlbXUtdGVzdC9zcmMv
dWkvY3Vyc2VzLmM6NDgyOjI1OiBlcnJvcjogdmFyaWFibGUgJ3VjaCcgaXMgdW5pbml0aWFsaXpl
ZCB3aGVuIHVzZWQgaGVyZSBbLVdlcnJvciwtV3VuaW5pdGlhbGl6ZWRdCiAgICAgICAgICAgICAg
ICAgICAgICAgIHVjaCwgc3RyZXJyb3IoZXJybm8pKTsKICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+Ci90bXAvcWVtdS10ZXN0L3NyYy91aS9jdXJzZXMuYzo0NzM6MTc6IG5vdGU6IGluaXRpYWxp
emUgdGhlIHZhcmlhYmxlICd1Y2gnIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQyNzE1MzAz
MS41MTE5LTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZy90ZXN0aW5nLmFzYW4vP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=
