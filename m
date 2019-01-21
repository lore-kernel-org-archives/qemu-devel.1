Received: from eggs.gnu.org ([209.51.188.92]:41195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glX6Z-0002l7-Rh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glX6X-0005Dh-Fe
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:46:59 -0500
Resent-Message-Id: <E1glX6X-0005Dh-Fe@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glX6X-0005CE-9m
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:46:57 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190116101049.8929-1-kraxel@redhat.com>
Message-ID: <154806668362.5550.5892390758705065310@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 21 Jan 2019 02:31:24 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] vnc: detect and optimize pageflips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNjEwMTA0OS44OTI5
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
U0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcvY29y
ZS9wdGltZXIubwogIENDICAgICAgaHcvY29yZS9zeXNidXMubwovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svc2hlZXBkb2cuYzogSW4gZnVuY3Rpb24gJ2ZpbmRfdmRpX25hbWUnOgovdG1wL3FlbXUt
dGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzoxMjM5OjU6IGVycm9yOiAnc3RybmNweScgc3BlY2lm
aWVkIGJvdW5kIDI1NiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10
cnVuY2F0aW9uXQogICAgIHN0cm5jcHkoYnVmICsgU0RfTUFYX1ZESV9MRU4sIHRhZywgU0RfTUFY
X1ZESV9UQUdfTEVOKTsKICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKLS0tCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCkluIGZ1bmN0
aW9uICdhY3BpX3RhYmxlX2luc3RhbGwnLAogICAgaW5saW5lZCBmcm9tICdhY3BpX3RhYmxlX2Fk
ZCcgYXQgL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY29yZS5jOjI5Njo1OgovdG1wL3FlbXUt
dGVzdC9zcmMvaHcvYWNwaS9jb3JlLmM6MTg0Ojk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVk
IGJvdW5kIDQgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNh
dGlvbl0KICAgICAgICAgc3RybmNweShleHRfaGRyLT5zaWcsIGhkcnMtPnNpZywgc2l6ZW9mIGV4
dF9oZHItPnNpZyk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2NvcmUuYzoyMDM6
OTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgNiBlcXVhbHMgZGVzdGluYXRpb24g
c2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogICAgICAgICBzdHJuY3B5KGV4dF9o
ZHItPm9lbV9pZCwgaGRycy0+b2VtX2lkLCBzaXplb2YgZXh0X2hkci0+b2VtX2lkKTsKICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY29yZS5jOjIwNzo5OiBlcnJvcjog
J3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA4IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vy
cm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgICAgIHN0cm5jcHkoZXh0X2hkci0+b2VtX3Rh
YmxlX2lkLCBoZHJzLT5vZW1fdGFibGVfaWQsCiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgc2l6ZW9mIGV4
dF9oZHItPm9lbV90YWJsZV9pZCk7CiAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY29yZS5jOjIxNjo5OiBlcnJv
cjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA0IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFst
V2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgICAgIHN0cm5jcHkoZXh0X2hkci0+YXNs
X2NvbXBpbGVyX2lkLCBoZHJzLT5hc2xfY29tcGlsZXJfaWQsCiAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAg
ICAgICAgc2l6ZW9mIGV4dF9oZHItPmFzbF9jb21waWxlcl9pZCk7Ci0tLQpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3Ny
Yy9ydWxlcy5tYWs6Njk6IGh3L2FjcGkvY29yZS5vXSBFcnJvciAxCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9hY3BpL2FtbC1idWlsZC5jOiBJbiBmdW5jdGlvbiAnYnVpbGRfaGVhZGVyJzoKL3RtcC9x
ZW11LXRlc3Qvc3JjL2h3L2FjcGkvYW1sLWJ1aWxkLmM6MTUzNTo5OiBlcnJvcjogJ3N0cm5jcHkn
IHNwZWNpZmllZCBib3VuZCA2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmlu
Z29wLXRydW5jYXRpb25dCiAgICAgICAgIHN0cm5jcHkoKGNoYXIgKiloLT5vZW1faWQsIG9lbV9p
ZCwgc2l6ZW9mIGgtPm9lbV9pZCk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvYW1s
LWJ1aWxkLmM6MTU0MTo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA4IGVxdWFs
cyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgICAg
IHN0cm5jcHkoKGNoYXIgKiloLT5vZW1fdGFibGVfaWQsIG9lbV90YWJsZV9pZCwgc2l6ZW9mKGgt
Pm9lbV90YWJsZV9pZCkpOwogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAxMTYxMDEwNDkuODkyOS0xLWtyYXhlbEByZWRo
YXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
