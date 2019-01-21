Received: from eggs.gnu.org ([209.51.188.92]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glhGU-0006yB-Jo
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glhGS-0000Qw-Hv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:37:54 -0500
Resent-Message-Id: <E1glhGS-0000Qw-Hv@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glhGS-0000Lu-BS
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:37:52 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115145256.9593-1-berrange@redhat.com>
Message-ID: <154806430393.5550.747609684336838084@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 21 Jan 2019 01:51:45 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 00/12] chardev: refactoring & many bugfixes
 related tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, lvivier@redhat.com, thuth@redhat.com, elohimes@gmail.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTE0NTI1Ni45NTkz
LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBTSE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9j
aGFyL2RlYnVnY29uLm8KSW4gZnVuY3Rpb24gJ2FjcGlfdGFibGVfaW5zdGFsbCcsCiAgICBpbmxp
bmVkIGZyb20gJ2FjcGlfdGFibGVfYWRkJyBhdCAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9j
b3JlLmM6Mjk2OjU6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2NvcmUuYzoxODQ6OTogZXJy
b3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgNCBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBb
LVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogICAgICAgICBzdHJuY3B5KGV4dF9oZHItPnNp
ZywgaGRycy0+c2lnLCBzaXplb2YgZXh0X2hkci0+c2lnKTsKICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2FjcGkvY29yZS5jOjIwMzo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3Vu
ZCA2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25d
CiAgICAgICAgIHN0cm5jcHkoZXh0X2hkci0+b2VtX2lkLCBoZHJzLT5vZW1faWQsIHNpemVvZiBl
eHRfaGRyLT5vZW1faWQpOwogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNw
aS9jb3JlLmM6MjA3Ojk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDggZXF1YWxz
IGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAg
c3RybmNweShleHRfaGRyLT5vZW1fdGFibGVfaWQsIGhkcnMtPm9lbV90YWJsZV9pZCwKICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAg
ICAgICAgICAgICAgICBzaXplb2YgZXh0X2hkci0+b2VtX3RhYmxlX2lkKTsKICAgICAgICAgICAg
ICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
YWNwaS9jb3JlLmM6MjE2Ojk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDQgZXF1
YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAg
ICAgc3RybmNweShleHRfaGRyLT5hc2xfY29tcGlsZXJfaWQsIGhkcnMtPmFzbF9jb21waWxlcl9p
ZCwKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KICAgICAgICAgICAgICAgICBzaXplb2YgZXh0X2hkci0+YXNsX2NvbXBpbGVy
X2lkKTsKLS0tCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcv
YWNwaS9jb3JlLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6IEluIGZ1bmN0aW9uICdm
aW5kX3ZkaV9uYW1lJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6MTIzOTo1
OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCAyNTYgZXF1YWxzIGRlc3RpbmF0aW9u
IHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICBzdHJuY3B5KGJ1ZiArIFNE
X01BWF9WRElfTEVOLCB0YWcsIFNEX01BWF9WRElfVEFHX0xFTik7CiAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3Jj
L3J1bGVzLm1hazo2OTogYmxvY2svc2hlZXBkb2cub10gRXJyb3IgMQovdG1wL3FlbXUtdGVzdC9z
cmMvaHcvYWNwaS9hbWwtYnVpbGQuYzogSW4gZnVuY3Rpb24gJ2J1aWxkX2hlYWRlcic6Ci90bXAv
cWVtdS10ZXN0L3NyYy9ody9hY3BpL2FtbC1idWlsZC5jOjE1MzU6OTogZXJyb3I6ICdzdHJuY3B5
JyBzcGVjaWZpZWQgYm91bmQgNiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJp
bmdvcC10cnVuY2F0aW9uXQogICAgICAgICBzdHJuY3B5KChjaGFyICopaC0+b2VtX2lkLCBvZW1f
aWQsIHNpemVvZiBoLT5vZW1faWQpOwogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2Ft
bC1idWlsZC5jOjE1NDE6OTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgOCBlcXVh
bHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogICAgICAg
ICBzdHJuY3B5KChjaGFyICopaC0+b2VtX3RhYmxlX2lkLCBvZW1fdGFibGVfaWQsIHNpemVvZiho
LT5vZW1fdGFibGVfaWQpKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMTE1MTQ1MjU2Ljk1OTMtMS1iZXJyYW5nZUBy
ZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t
