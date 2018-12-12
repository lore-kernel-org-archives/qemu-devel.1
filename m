Received: from eggs.gnu.org ([2001:4830:134:3::10]:51228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gWtTW-00049M-CA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gWtTT-0004nB-4J
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:38:10 -0500
Received: from m13-37.163.com ([220.181.13.37]:45275)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gWtTR-0004iV-QP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:38:06 -0500
Date: Wed, 12 Dec 2018 09:22:40 +0800 (CST)
From: =?GBK?B?wO7Hvw==?= <liq3ea@163.com>
In-Reply-To: <20181211152231.GB28105@lap1>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-3-ppandit@redhat.com>
	<20181211152231.GB28105@lap1>
MIME-Version: 1.0
Message-ID: <127f18bd.4e6d.167a0023dbd.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 2/5] pvrdma: add uar_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, pbonzini@redhat.com, peter.maydell@linaro.org, liq3ea@gmail.com

CgoKQXQgMjAxOC0xMi0xMSAyMzoyMjozMiwgIll1dmFsIFNoYWlhIiA8eXV2YWwuc2hhaWFAb3Jh
Y2xlLmNvbT4gd3JvdGU6Cj5PbiBUdWUsIERlYyAxMSwgMjAxOCBhdCAwNjo1NjozOVBNICswNTMw
LCBQIEogUCB3cm90ZToKPj4gRnJvbTogUHJhc2FkIEogUGFuZGl0IDxwanBAZmVkb3JhcHJvamVj
dC5vcmc+Cj4+IAo+PiBEZWZpbmUgc2tlbGV0b24gJ3Vhcl9yZWFkJyByb3V0aW5lLiBBdm9pZCBO
VUxMIGRlcmVmZXJlbmNlLgo+PiAKPj4gUmVwb3J0ZWQtYnk6IExpIFFpYW5nIDxsaXEzZWFAMTYz
LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogUHJhc2FkIEogUGFuZGl0IDxwanBAZmVkb3JhcHJvamVj
dC5vcmc+Cj4+IC0tLQo+PiAgaHcvcmRtYS92bXcvcHZyZG1hX21haW4uYyB8IDYgKysrKysrCj4+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4+IAo+PiBkaWZmIC0tZ2l0IGEvaHcv
cmRtYS92bXcvcHZyZG1hX21haW4uYyBiL2h3L3JkbWEvdm13L3B2cmRtYV9tYWluLmMKPj4gaW5k
ZXggY2E1ZmE4ZDk4MS4uYTYyMTFkNDE2ZCAxMDA2NDQKPj4gLS0tIGEvaHcvcmRtYS92bXcvcHZy
ZG1hX21haW4uYwo+PiArKysgYi9ody9yZG1hL3Ztdy9wdnJkbWFfbWFpbi5jCj4+IEBAIC00NTUs
NiArNDU1LDExIEBAIHN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgcmVnc19vcHMgPSB7Cj4+
ICAgICAgfSwKPj4gIH07Cj4+ICAKPj4gK3N0YXRpYyB1aW50NjRfdCB1YXJfcmVhZCh2b2lkICpv
cGFxdWUsIGh3YWRkciBhZGRyLCB1bnNpZ25lZCBzaXplKQo+PiArewo+PiArICAgIHJldHVybiAw
Owo+PiArfQo+PiArCj4+ICBzdGF0aWMgdm9pZCB1YXJfd3JpdGUodm9pZCAqb3BhcXVlLCBod2Fk
ZHIgYWRkciwgdWludDY0X3QgdmFsLCB1bnNpZ25lZCBzaXplKQo+PiAgewo+PiAgICAgIFBWUkRN
QURldiAqZGV2ID0gb3BhcXVlOwo+PiBAQCAtNDk2LDYgKzUwMSw3IEBAIHN0YXRpYyB2b2lkIHVh
cl93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWwsIHVuc2lnbmVk
IHNpemUpCj4+ICB9Cj4+ICAKPj4gIHN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgdWFyX29w
cyA9IHsKPj4gKyAgICAucmVhZCA9IHVhcl9yZWFkLAo+Cgo+QXJlIHlvdSBzdXJlIGl0IGlzIG5l
ZWRlZD8KCgpJJ20gcXVpdGUgc3VyZSB0aGlzLgpUaGUgaXNzdWUgaGVyZSBpcyB0aGF0IGluIG1l
bW9yeV9yZWdpb25fZGlzcGF0Y2hfcmVhZDEKaWYgdGhlcmUgaXMgbm8gbXIncyByZWFkIGNhbGxi
YWNrLCB0aGUgJ21lbW9yeV9yZWdpb25fcmVhZF93aXRoX2F0dHJzX2FjY2Vzc29yJyAKd2lsbCBi
ZSBjYWxsZWQsIGJ1dCBpbiB0aGF0IHRoZSAnbXItPm9wcy0+cmFlZF93aXRoX2F0dHJzJyBoYXMg
bm8gY2hlY2suCgoKSW4gZmFjdCwgSSBoYXZlIHNlbmQgb3V0IGEgcGF0Y2ggZm9yIHRoZSBmcmFt
ZXdvcms6Ci0tPmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8y
MDE4LTExL21zZzAyMjY1Lmh0bWwKCgpCdXQgbm8gbW9yZSByZXNwb25zZS4KCgo+TG9va2luZyBh
dCBtZW1vcnlfcmVnaW9uX2Rpc3BhdGNoX3JlYWQxIGkgY2FuIHNlZSB0aGF0IHRoZXJlIGlzIGEg
Y2hlY2sgYnV0ID5ub3Qgc3VyZSB0aGlzIGlzIHRoZSByaWdodCBwbGFjZS4gQW55d2F5cywgaWYg
aXQgaXMgbm90LCBpIGJlbGlldmUgdGhpcwo+c2hvdWxkIGJlIGZyYW1ld29yayByZXNwb25zaWJp
bGl0eS4KCgpSZWZlcmVuY2UgUGV0ZXIncyBhbnN3ZXIgaGVyZToKLS0+aHR0cHM6Ly9saXN0cy5n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMDkvbXNnMDE0MDQuaHRtbAoKCiJD
dXJyZW50bHkgb3VyIHNlbWFudGljcyBhcmUgInlvdSBtdXN0IHByb3ZpZGUgYm90aCByZWFkIGFu
ZCB3cml0ZSwgZXZlbgppZiBvbmUgb2YgdGhlbSBqdXN0IGFsd2F5cyByZXR1cm5zIDAgLyBkb2Vz
IG5vdGhpbmcgLyByZXR1cm5zIGFuIGVycm9yIi4KV2UgY291bGQgcHJvYmFibHkgcmVhc29uYWJs
eSBhc3NlcnQgdGhpcyBhdCB0aGUgcG9pbnQgd2hlbiB0aGUKTWVtb3J5UmVnaW9uT3BzIGlzIHJl
Z2lzdGVyZWQuIgoKCgoKVGhhbmtzLApMaSBRaWFuZwoKCj4gPj4gLndyaXRlID0gdWFyX3dyaXRl
LCA+PiAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLCA+PiAuaW1wbCA9IHsgPj4g
LS0gPj4gMi4xOS4yID4+
