Received: from eggs.gnu.org ([209.51.188.92]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gglJ6-0003FL-RT
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gglJ4-0000NO-QQ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:56:12 -0500
Received: from m13-139.163.com ([220.181.13.139]:21581)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gglJ3-00006Q-G4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:56:10 -0500
Date: Tue, 8 Jan 2019 14:40:33 +0800 (CST)
From: =?GBK?B?wO7Hvw==?= <liq3ea@163.com>
In-Reply-To: <20190107162657.GB3249@lap1>
References: <20190103130338.49081-1-liq3ea@163.com>
	<fad70169-0cff-ede5-c07d-bff01d113f88@redhat.com>
	<20190107162657.GB3249@lap1>
MIME-Version: 1.0
Message-ID: <40b197f3.c113.1682c30f91c.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] hw: pvrdma: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@redhat.com>, marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

CkF0IDIwMTktMDEtMDggMDA6MjY6NTgsICJZdXZhbCBTaGFpYSIgPHl1dmFsLnNoYWlhQG9yYWNs
ZS5jb20+IHdyb3RlOgo+T24gVGh1LCBKYW4gMDMsIDIwMTkgYXQgMDI6NDc6MzdQTSArMDEwMCwg
UGhpbGlwcGUgTWF0aGlldS1EYXVkqKYgd3JvdGU6Cj4+IE9uIDEvMy8xOSAyOjAzIFBNLCBMaSBR
aWFuZyB3cm90ZToKPj4gPiBTcG90dGVkIGJ5IENvdmVyaXR5OiBDSUQgMTM5ODU5NQo+PiA+IAo+
PiAKPj4gRml4ZXM6IDJiMDU3MDVkYzgKPj4gCj4+ID4gU2lnbmVkLW9mZi1ieTogTGkgUWlhbmcg
PGxpcTNlYUAxNjMuY29tPgo+PiAKPj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZKimIDxwaGlsbWRAcmVkaGF0LmNvbT4KPj4gCj4+ID4gLS0tCj4+ID4gIGh3L3JkbWEvdm13L3B2
cmRtYV9xcF9vcHMuYyB8IDIgKysKPj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+PiA+IAo+PiA+IGRpZmYgLS1naXQgYS9ody9yZG1hL3Ztdy9wdnJkbWFfcXBfb3BzLmMgYi9o
dy9yZG1hL3Ztdy9wdnJkbWFfcXBfb3BzLmMKPj4gPiBpbmRleCAzMDA0NzFhNGM5Li41ODRiZTIw
NDNlIDEwMDY0NAo+PiA+IC0tLSBhL2h3L3JkbWEvdm13L3B2cmRtYV9xcF9vcHMuYwo+PiA+ICsr
KyBiL2h3L3JkbWEvdm13L3B2cmRtYV9xcF9vcHMuYwo+PiA+IEBAIC0xNjgsNiArMTY4LDcgQEAg
aW50IHB2cmRtYV9xcF9zZW5kKFBWUkRNQURldiAqZGV2LCB1aW50MzJfdCBxcF9oYW5kbGUpCj4+
ID4gICAgICAgICAgc2dpZCA9IHJkbWFfcm1fZ2V0X2dpZCgmZGV2LT5yZG1hX2Rldl9yZXMsIHdx
ZS0+aGRyLndyLnVkLmF2LmdpZF9pbmRleCk7Cj4+ID4gICAgICAgICAgaWYgKCFzZ2lkKSB7Cj4+
ID4gICAgICAgICAgICAgIHByX2RiZygiRmFpbCB0byBnZXQgZ2lkIGZvciBpZHggJWRcbiIsIHdx
ZS0+aGRyLndyLnVkLmF2LmdpZF9pbmRleCk7Cj4+ID4gKyAgICAgICAgICAgIGdfZnJlZShjb21w
X2N0eCk7Cj4+ID4gICAgICAgICAgICAgIHJldHVybiAtRUlPOwo+PiA+ICAgICAgICAgIH0KPj4g
PiAgICAgICAgICBwcl9kYmcoInNnaWRfaWQ9JWQsIHNnaWQ9MHglbGx4XG4iLCB3cWUtPmhkci53
ci51ZC5hdi5naWRfaW5kZXgsCj4+ID4gQEAgLTE3OSw2ICsxODAsNyBAQCBpbnQgcHZyZG1hX3Fw
X3NlbmQoUFZSRE1BRGV2ICpkZXYsIHVpbnQzMl90IHFwX2hhbmRsZSkKPj4gPiAgICAgICAgICBp
ZiAoc2dpZF9pZHggPD0gMCkgewo+PiA+ICAgICAgICAgICAgICBwcl9kYmcoIkZhaWwgdG8gZ2V0
IGJrIHNnaWRfaWR4IGZvciBzZ2lkX2lkeCAlZFxuIiwKPj4gPiAgICAgICAgICAgICAgICAgICAg
IHdxZS0+aGRyLndyLnVkLmF2LmdpZF9pbmRleCk7Cj4+ID4gKyAgICAgICAgICAgIGdfZnJlZShj
b21wX2N0eCk7Cj4+ID4gICAgICAgICAgICAgIHJldHVybiAtRUlPOwo+PiA+ICAgICAgICAgIH0K
Pgo+U2luY2UgY29tcF9jdHggaXMgbm90IHVzZWQgdW50aWwgdGhlIHR3byBjaGVja3MgYXJlIGRv
bmUgd2UganVzdCBjYW4KPnJlbG9jYXRlIHRoZSBhbGxvY2F0aW9uICYgaW5pdGlhbGl6YXRpb24g
cmlnaHQgYWZ0ZXIgdGhlIHR3byBjaGVja3MuCgo+CgoKT0ssIHdpbGwgc2VuZCBhIHJldmlzZWQg
dmVyc2lvbiBsYXRlci4KCgpUaGFua3MsCkxpIFFpYW5nCgoKPll1dmFsCj4KPj4gPiAgCj4+ID4g
Cg==
