Received: from eggs.gnu.org ([209.51.188.92]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h2c1B-0005oW-Dv
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 08:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h2c1A-00048N-M1
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 08:28:01 -0500
Resent-Message-Id: <E1h2c1A-00048N-M1@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1h2c1A-00046l-DL
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 08:28:00 -0500
Message-ID: <155213803483.8146.11652562967928517020@6acff2cf482b>
In-Reply-To: <20190307130323.9353-1-armbru@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 9 Mar 2019 05:27:16 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 00/14] pflash: Fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDMwNzEzMDMyMy45MzUz
LTEtYXJtYnJ1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
U0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIGh3L2Rpc3BsYXkvY2lycnVzX3ZnYS5vCiAgQ0MgICAgICBody9kaXNwbGF5L2NpcnJ1c192
Z2FfaXNhLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL3BmbGFzaF9jZmkwMi5jOiBJbiBm
dW5jdGlvbiAncGZsYXNoX2NmaTAyX3VucmVhbGl6ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9i
bG9jay9wZmxhc2hfY2ZpMDIuYzo2OTg6NTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdwZmxh
c2hfdCc7IGRpZCB5b3UgbWVhbiAnZnBvc190Jz8KICAgICBwZmxhc2hfdCAqcGZsID0gQ0ZJX1BG
TEFTSDAyKGRldik7CiAgICAgXn5+fn5+fn4KICAgICBmcG9zX3QKL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2Jsb2NrL3BmbGFzaF9jZmkwMi5jOjY5ODoyMTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uIG9mIGZ1bmN0aW9uICdDRklfUEZMQVNIMDInOyBkaWQgeW91IG1lYW4gJ0hXX0ZMQVNIX0gn
PyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICBwZmxhc2hfdCAq
cGZsID0gQ0ZJX1BGTEFTSDAyKGRldik7CiAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fgogICAgICAgICAgICAgICAgICAgICBIV19GTEFTSF9ICi90bXAvcWVtdS10ZXN0L3NyYy9ody9i
bG9jay9wZmxhc2hfY2ZpMDIuYzo2OTg6MjE6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0
aW9uIG9mICdDRklfUEZMQVNIMDInIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdG1wL3FlbXUt
dGVzdC9zcmMvaHcvYmxvY2svcGZsYXNoX2NmaTAyLmM6Njk4OjIxOiBlcnJvcjogaW5pdGlhbGl6
YXRpb24gb2YgJ2ludCAqJyBmcm9tICdpbnQnIG1ha2VzIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIHdp
dGhvdXQgYSBjYXN0IFstV2Vycm9yPWludC1jb252ZXJzaW9uXQovdG1wL3FlbXUtdGVzdC9zcmMv
aHcvYmxvY2svcGZsYXNoX2NmaTAyLmM6Njk5OjE5OiBlcnJvcjogcmVxdWVzdCBmb3IgbWVtYmVy
ICd0aW1lcicgaW4gc29tZXRoaW5nIG5vdCBhIHN0cnVjdHVyZSBvciB1bmlvbgogICAgIHRpbWVy
X2RlbCgmcGZsLT50aW1lcik7CiAgICAgICAgICAgICAgICAgICBefgpjYzE6IGFsbCB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAzMDcxMzAzMjMuOTM1My0xLWFybWJydUByZWRo
YXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
