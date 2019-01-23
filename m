Received: from eggs.gnu.org ([209.51.188.92]:59532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmIwj-000807-Bm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmIwh-00034J-01
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:52:00 -0500
Resent-Message-Id: <E1gmIwh-00034J-01@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gmIwg-00033h-NN
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:51:58 -0500
Message-ID: <154825147722.21.14321288500008236231@ebba9967afc0>
In-Reply-To: <20190117153338.11820-1-alex.bennee@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 23 Jan 2019 05:51:18 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] scripts/replay-dump.py: fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: fam@euphon.net, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, ehabkost@redhat.com, crosa@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNzE1MzMzOC4xMTgy
MC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
Y3J5cHRvL2Fmc3BsaXQubwogIENDICAgICAgY3J5cHRvL3h0cy5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9zaGVlcGRvZy5jOiBJbiBmdW5jdGlvbiAnZmluZF92ZGlfbmFtZSc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOjEyMzk6NTogZXJyb3I6ICdzdHJuY3B5JyBzcGVj
aWZpZWQgYm91bmQgMjU2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29w
LXRydW5jYXRpb25dCiAgICAgc3RybmNweShidWYgKyBTRF9NQVhfVkRJX0xFTiwgdGFnLCBTRF9N
QVhfVkRJX1RBR19MRU4pOwogICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVy
cm9ycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTAxMTcxNTMzMzguMTE4MjAtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3Rpbmcu
ZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
