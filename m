Received: from eggs.gnu.org ([209.51.188.92]:51739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmJvZ-0006JN-Qt
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmJvY-00074o-Hc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:54:53 -0500
Resent-Message-Id: <E1gmJvY-00074o-Hc@eggs.gnu.org>
Message-ID: <154825524292.21.4589691216699401444@ebba9967afc0>
In-Reply-To: <20190108170655.29766-1-vsementsov@virtuozzo.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 23 Jan 2019 06:54:04 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 0/9] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vsementsov@virtuozzo.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, berto@igalia.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEwODE3MDY1NS4yOTc2
Ni0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBTSE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBxYXBpL3FhcGktY29tbWFuZHMtY3J5cHRvLm8KICBDQyAgICAgIHFhcGkvcWFwaS1jb21tYW5k
cy1pbnRyb3NwZWN0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6IEluIGZ1
bmN0aW9uICdmaW5kX3ZkaV9uYW1lJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9n
LmM6MTIzOTo1OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCAyNTYgZXF1YWxzIGRl
c3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICBzdHJuY3B5
KGJ1ZiArIFNEX01BWF9WRElfTEVOLCB0YWcsIFNEX01BWF9WRElfVEFHX0xFTik7CiAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDEwODE3MDY1NS4yOTc2Ni0x
LXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==
