Received: from eggs.gnu.org ([209.51.188.92]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glXHD-0000QS-Ru
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glXHD-0005c5-33
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:57:59 -0500
Resent-Message-Id: <E1glXHD-0005c5-33@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glXHC-0005aB-RF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:57:59 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115143650.15725-1-jusual@mail.ru>
Message-ID: <154804030872.5550.14318378720632467069@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 20 Jan 2019 19:11:49 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, alistair@alistair23.me, jusual@mail.ru

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTE0MzY1MC4xNTcy
NS0xLWp1c3VhbEBtYWlsLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIFNI
T1dfRU5WPTEgSj0xNAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHFhcGkvcWFw
aS1jb21tYW5kcy10cmFuc2FjdGlvbi5vCiAgQ0MgICAgICBxYXBpL3FhcGktY29tbWFuZHMtdWku
bwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzogSW4gZnVuY3Rpb24gJ2ZpbmRf
dmRpX25hbWUnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzoxMjM5OjU6IGVy
cm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDI1NiBlcXVhbHMgZGVzdGluYXRpb24gc2l6
ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogICAgIHN0cm5jcHkoYnVmICsgU0RfTUFY
X1ZESV9MRU4sIHRhZywgU0RfTUFYX1ZESV9UQUdfTEVOKTsKICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMTE1MTQzNjUwLjE1NzI1LTEtanVzdWFsQG1haWwu
cnUvdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
