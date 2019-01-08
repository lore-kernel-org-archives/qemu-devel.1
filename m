Received: from eggs.gnu.org ([209.51.188.92]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1ggloz-0004BW-LM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 02:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gglox-00024R-Ir
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 02:29:09 -0500
Date: Tue, 8 Jan 2019 14:42:19 +0800 (CST)
From: =?GBK?B?wO7Hvw==?= <liq3ea@163.com>
In-Reply-To: <20190107171029.35418046.cohuck@redhat.com>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<5C2F6ED2.33D0D1.16460@m12-13.163.com>
	<20190107164801.32e9d6dc.cohuck@redhat.com>
	<CAFEAcA_BzQaZM01_q29q+RfnqF2_YDSM0zfqKYDFwzRQOq7now@mail.gmail.com>
	<20190107165748.442cc0c1.cohuck@redhat.com>
	<CAFEAcA8pRzsVbnWDnLqhOeiJ9Ytw--8Cv9qHycr-pYHnaFs_2g@mail.gmail.com>
	<20190107171029.35418046.cohuck@redhat.com>
MIME-Version: 1.0
Message-ID: <57c35440.c1e9.1682c3296fc.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v2] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

CkF0IDIwMTktMDEtMDggMDA6MTA6MjksICJDb3JuZWxpYSBIdWNrIiA8Y29odWNrQHJlZGhhdC5j
b20+IHdyb3RlOgo+T24gTW9uLCA3IEphbiAyMDE5IDE2OjA0OjM1ICswMDAwCj5QZXRlciBNYXlk
ZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IHdyb3RlOgo+Cj4+IE9uIE1vbiwgNyBKYW4g
MjAxOSBhdCAxNTo1NywgQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+IHdyb3RlOgo+
PiA+IE9uIE1vbiwgNyBKYW4gMjAxOSAxNTo1NDoyMSArMDAwMAo+PiA+IFBldGVyIE1heWRlbGwg
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6ICAKPj4gPiA+IE9uIE1vbiwgNyBKYW4g
MjAxOSBhdCAxNTo0OCwgQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+IHdyb3RlOiAg
Cj4+ID4gPiA+IFNvdW5kcyBnb29kLiBCdXQgcGxlYXNlIHJldHVybiBhbnl3YXkgaW4gdGhlIHVu
cGx1ZyBjYXNlLCBzbyB0aGF0IHRoZQo+PiA+ID4gPiBjb2RlIGlzIGZpbmUgaWYgYXNzZXJ0cyBo
YXZlIGJlZW4gY29uZmlndXJlZCBvdXQuICAKPj4gPiA+Cj4+ID4gPiBIb3BlZnVsbHkgdGhhdCB3
b24ndCBjYXVzZSB0aGUgY29tcGlsZXIgdG8gY29tcGxhaW4gYWJvdXQKPj4gPiA+IHVucmVhY2hh
YmxlIGNvZGUgOi0pICAKPj4gPgo+PiA+IEJUVzogSXMgdGhlcmUgYSBjb21tb24gY29uZmlndXJh
dGlvbiB3aGVyZSBhc3NlcnRzIGFyZSBjb25maWd1cmVkIG91dD8KPj4gPiBOb3QgdGhhdCB0aGlz
IGlzIGFuIGFjY2lkZW50IHdhaXRpbmcgdG8gaGFwcGVuLi4uICAKPj4gCj4+IE5vIC0tIHdlIGlu
c2lzdCB0aGV5IGFyZSBhbHdheXMgZW5hYmxlZCwgYW5kIG9zZGVwLmggd2lsbCAjZXJyb3IKPj4g
b3V0IGlmIGVpdGhlciBOREVCVUcgb3IgR19ESVNBQkxFX0FTU0VSVCBhcmUgc2V0Lgo+Cj5BaCwg
bm93IEkgcmVtZW1iZXIgKEkgdGhvdWdodCB3ZSBzdGlsbCBoYWQgdGhhdCBwcm9ibGVtLikKPgoK
PkluIHRoYXQgY2FzZSwgbm8gcmV0dXJuIGlzIG5lZWRlZC4KCgpPaywgbGF0ZXIgSSB3aWxsIHNl
bmQgb3V0IGEgcmV2aXNlZCBwYXRjaC4KCgpUaGFua3MsCkxpIFFpYW5nCgo=
