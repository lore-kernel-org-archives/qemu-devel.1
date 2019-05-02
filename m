Received: from eggs.gnu.org ([209.51.188.92]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM78h-0001Hz-Tq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM78f-0001c3-NH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:32:22 -0400
Resent-Message-Id: <E1hM78f-0001c3-NH@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hM78d-00011L-MV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:32:21 -0400
In-Reply-To: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Message-ID: <155678585404.10667.17833237501293004416@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 2 May 2019 01:30:55 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] vhost: fix incorrect print type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangjie88@huawei.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com, mst@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU2NjA1NzczLTQyMDE5LTEt
Z2l0LXNlbmQtZW1haWwtd2FuZ2ppZTg4QGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVz
dC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKICBDT1BZICAgIFJVTk5FUgogICAgUlVOIHRlc3QtbWluZ3cgaW4gcWVtdTpmZWRv
cmEgCmNvbnRhaW5lcl9saW51eC5nbzoyNDc6IHN0YXJ0aW5nIGNvbnRhaW5lciBwcm9jZXNzIGNh
dXNlZCAicHJvY2Vzc19saW51eC5nbzoyNTg6IGFwcGx5aW5nIGNncm91cCBjb25maWd1cmF0aW9u
IGZvciBwcm9jZXNzIGNhdXNlZCBcIlRoZSBtYXhpbXVtIG51bWJlciBvZiBhY3RpdmUgY29ubmVj
dGlvbnMgZm9yIFVJRCAwIGhhcyBiZWVuIHJlYWNoZWRcIiIKL3Vzci9iaW4vZG9ja2VyLWN1cnJl
bnQ6IEVycm9yIHJlc3BvbnNlIGZyb20gZGFlbW9uOiBvY2kgcnVudGltZSBlcnJvcjogVGhlIG1h
eGltdW0gbnVtYmVyIG9mIGFjdGl2ZSBjb25uZWN0aW9ucyBmb3IgVUlEIDAgaGFzIGJlZW4gcmVh
Y2hlZC4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMv
ZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjE1LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFp
bigpKQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMTU1NjYwNTc3My00MjAxOS0xLWdpdC1zZW5kLWVtYWlsLXdhbmdqaWU4OEBodWF3ZWkuY29t
L3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
