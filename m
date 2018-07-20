Received: from eggs.gnu.org ([2001:4830:134:3::10]:43025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fgYQM-0004J6-PH
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fgYQI-00027b-Ex
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:38:34 -0400
Resent-Message-Id: <E1fgYQI-00027b-Ex@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fgYQI-000278-3u
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:38:30 -0400
In-Reply-To: <20180720083644.1431-1-tiwei.bie@intel.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153207674952.156.14125031656226934615@b489c0e6f1ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 20 Jul 2018 01:52:30 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tiwei.bie@intel.com
Cc: famz@redhat.com, mst@redhat.com, jasowang@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTgwNzIwMDgzNjQ0LjE0MzEt
MS10aXdlaS5iaWVAaW50ZWwuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHZob3N0
OiBjaGVjayByZWdpb24gdHlwZSBiZWZvcmUgY2FzdGluZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApzZXQgLWUKZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1pbml0IGR0Ywoj
IExldCBkb2NrZXIgdGVzdHMgZHVtcCBlbnZpcm9ubWVudCBpbmZvCmV4cG9ydCBTSE9XX0VOVj0x
CmV4cG9ydCBKPTgKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYQo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApmYXRhbDogdW5hYmxlIHRvIGFjY2VzcyAnaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11Lyc6IEVuY291bnRlcmVkIGVuZCBvZiBmaWxlCmVycm9yOiBDb3VsZCBu
b3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApUcmFjZWJh
Y2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL3Vzci9iaW4vcGF0Y2hldyIsIGxp
bmUgNDQyLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwg
clsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi91c3IvYmluL3BhdGNoZXciLCBsaW5lIDQ4LCBpbiBn
aXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0PWxvZ2YsIHN0ZGVycj1sb2dmKQogIEZpbGUgIi91c3Iv
bGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI5MSwgaW4gY2hlY2tfY2FsbAog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0JywgJ3JlbW90ZScsICdhZGQnLCAnLWYnLCAn
LS1taXJyb3I9ZmV0Y2gnLCAnM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NCcsICdodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUnXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMS4KCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
