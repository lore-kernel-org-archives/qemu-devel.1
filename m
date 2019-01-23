Received: from eggs.gnu.org ([209.51.188.92]:58190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmGjS-0001jQ-Ib
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmGjQ-000508-PJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:30:10 -0500
Resent-Message-Id: <E1gmGjQ-000508-PJ@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gmGjQ-0004ur-GW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:30:08 -0500
Message-ID: <154824297393.21.15334193222138569572@ebba9967afc0>
In-Reply-To: <20181226034254.17842-1-richard.henderson@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 23 Jan 2019 03:29:36 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE4MTIyNjAzNDI1NC4xNzg0
Mi0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1t
aW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgY3J5cHRvL2Jsb2NrLm8KICBDQyAgICAgIGNyeXB0by9ibG9jay1xY293Lm8KL3RtcC9x
ZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6IEluIGZ1bmN0aW9uICdmaW5kX3ZkaV9uYW1l
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6MTIzOTo1OiBlcnJvcjogJ3N0
cm5jcHknIHNwZWNpZmllZCBib3VuZCAyNTYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJy
b3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICBzdHJuY3B5KGJ1ZiArIFNEX01BWF9WRElfTEVO
LCB0YWcsIFNEX01BWF9WRElfVEFHX0xFTik7CiAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDE4MTIyNjAzNDI1NC4xNzg0Mi0xLXJpY2hhcmQuaGVuZGVyc29uQGxp
bmFyby5vcmcvdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=
