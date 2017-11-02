Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eADhk-0006EI-Iv
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eADhf-0005As-L7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:30:36 -0400
Received: from m15-10.126.com ([220.181.15.10]:11116)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eADhf-00056F-0e
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:30:31 -0400
Date: Thu, 2 Nov 2017 18:58:49 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <150906632596.2572.511583404169655715@sif>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
	<20171026155437.5f260b7b@fiorina>
	<150906632596.2572.511583404169655715@sif>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7cc46892.bc57.15f7c622d65.Coremail.chen_han_xiao@126.com>
Subject: Re: [Qemu-devel] [PATCH] qga-win: fall back to hardcoded user and
 group names if LookupAccountSidW failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?Q?Tom=C3=A1=C5=A1_Golembiovsk=C3=BD?= <tgolembi@redhat.com>, qemu-devel@nongnu.org

CkF0IDIwMTctMTAtMjcgMDk6MDU6MjUsICJNaWNoYWVsIFJvdGgiIDxtZHJvdGhAbGludXgudm5l
dC5pYm0uY29tPiB3cm90ZToKPlF1b3RpbmcgVG9tw6HFoSBHb2xlbWJpb3Zza8O9ICgyMDE3LTEw
LTI2IDA4OjU0OjM3KQo+PiBPbiBXZWQsIDI1IE9jdCAyMDE3IDE2OjU4OjA3IC0wNTAwCj4+IE1p
Y2hhZWwgUm90aCA8bWRyb3RoQGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4+IAo+PiA+IFF1
b3RpbmcgVG9tw6HFoSBHb2xlbWJpb3Zza8O9ICgyMDE3LTA5LTI5IDE2OjMxOjAyKQo+PiA+ID4g
T24gRnJpLCAyOSBTZXAgMjAxNyAxNzoxMToyMiArMDgwMAo+PiA+ID4gQ2hlbiBIYW54aWFvIDxj
aGVuX2hhbl94aWFvQDEyNi5jb20+IHdyb3RlOgo+PiA+ID4gCj4+ID4gPiBSZXZpZXdlZC1ieTog
VG9tw6HFoSBHb2xlbWJpb3Zza8O9IDx0Z29sZW1iaUByZWRoYXQuY29tPiAgCj4+ID4gCj4+ID4g
SSB0aGluayBpdCBtaWdodCBiZSBnZXROYW1lQnlTdHJpbmdTSUQoKS9Mb29rdXBBY2NvdW50U2lk
VygpIHJlcG9ydGluZyBhCj4+ID4gc3RhbGUgR2V0TGFzdEVycm9yKCkgdmFsdWUuCj4+ID4gCj4+
IAo+PiBJIHN1cHBvc2UgeW91J3JlIHJpZ2h0ISBUYWtpbmcgYSBjbG9zZXIgbG9vayB0aGVyZSdz
IG9uZSBtb3JlIGlzc3VlIHdpdGgKPj4gZ2V0TmFtZUJ5U3RyaW5nU0lEKCkuIFRoZSBjYWxsIENv
bnZlcnRTdHJpbmdTaWRUb1NpZFcoKSBkb2VzIG5vdCByZXR1cm4KPj4gSFJFU1VMVCBzbyB1c2lu
ZyBjaGsoKSBtYWtlcyBubyBzZW5zZS4KPj4gCj4+IEkgcHJvcG9zZSBzbGlnaHRseSBtb2RpZmll
ZCB2ZXJzaW9uIG9mIHlvdXIgZml4Ogo+PiAKPj4gZGlmZiAtLWdpdCBhL3FnYS92c3Mtd2luMzIv
aW5zdGFsbC5jcHAgYi9xZ2EvdnNzLXdpbjMyL2luc3RhbGwuY3BwCj4+IGluZGV4IGJhN2M5NGVi
MjUuLjY1ZjY4Zjk0YTMgMTAwNjQ0Cj4+IC0tLSBhL3FnYS92c3Mtd2luMzIvaW5zdGFsbC5jcHAK
Pj4gKysrIGIvcWdhL3Zzcy13aW4zMi9pbnN0YWxsLmNwcAo+PiBAQCAtMTQ4LDEwICsxNDgsMTUg
QEAgc3RhdGljIEhSRVNVTFQgZ2V0TmFtZUJ5U3RyaW5nU0lEKAo+PiAgICAgIERXT1JEIGRvbWFp
bk5hbWVMZW4gPSBCVUZGRVJfU0laRTsKPj4gICAgICB3Y2hhcl90IGRvbWFpbk5hbWVbQlVGRkVS
X1NJWkVdOwo+PiAgCj4+IC0gICAgY2hrKENvbnZlcnRTdHJpbmdTaWRUb1NpZFcoc2lkLCAmcHNp
ZCkpOwo+PiAtICAgIExvb2t1cEFjY291bnRTaWRXKE5VTEwsIHBzaWQsIGJ1ZmZlciwgYnVmZmVy
TGVuLAo+PiAtICAgICAgICAgICAgICAgIGRvbWFpbk5hbWUsICZkb21haW5OYW1lTGVuLCAmZ3Jv
dXBUeXBlKTsKPj4gLSAgICBociA9IEhSRVNVTFRfRlJPTV9XSU4zMihHZXRMYXN0RXJyb3IoKSk7
Cj4+ICsgICAgaWYgKCFDb252ZXJ0U3RyaW5nU2lkVG9TaWRXKHNpZCwgJnBzaWQpIHsKPj4gKyAg
ICAgICAgaHIgPSBIUkVTVUxUX0ZST01fV0lOMzIoR2V0TGFzdEVycm9yKCkpOwo+PiArICAgICAg
ICBnb3RvIG91dDsKPj4gKyAgICB9Cj4+ICsgICAgaWYgKCFMb29rdXBBY2NvdW50U2lkVyhOVUxM
LCBwc2lkLCBidWZmZXIsIGJ1ZmZlckxlbiwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRvbWFpbk5hbWUsICZkb21haW5OYW1lTGVuLCAmZ3JvdXBUeXBlKSkgewo+PiArICAgICAgICBo
ciA9IEhSRVNVTFRfRlJPTV9XSU4zMihHZXRMYXN0RXJyb3IoKSk7Cj4+ICsgICAgICAgIC8qIEZh
bGwgdGhyb3VnaCBhbmQgZnJlZSBwc2lkICovCj4+ICsgICAgfQo+PiAgCj4+ICAgICAgTG9jYWxG
cmVlKHBzaWQpOwo+Cj4KPlRoYW5rcyEgSXQncyBub3QgeWV0IGNsZWFyIGlmIHRoaXMgZml4ZXMg
dGhlIGlzc3VlIGNvbXBsZXRlbHkgKHRob3VnaCBpdAo+c2VlbXMgbGlrZWx5KSwgYnV0IGl0J3Mg
Y2xlYXJseSBhIGJ1ZyBlaXRoZXIgd2F5IHNvIEkndmUgZ29uZSBhaGVhZCBhbmQKPmFwcGxpZWQg
aXQgdG8gdGhlIHFnYSB0cmVlOgo+Cj4gIGh0dHBzOi8vZ2l0aHViLmNvbS9tZHJvdGgvcWVtdS9j
b21taXQvOGNlZGM4MDU1NWU1YTM5NWE0ZmRhNzEzMGIwMTE1MDE1ZTc3NWM0OAo+Cj5DaGVuLCBp
ZiB0aGVyZSdzIHN0aWxsIGFuIGlzc3VlIHdpdGggdGhlIHVwZGF0ZWQgcGF0Y2ggcGxlYXNlIGxl
dCBtZSBrbm93LgoKU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LgoKSSB0ZXN0ZWQgdGhlIHVwc3Ry
ZWFtIHFnYS13aW4gb24gdGhhdCB3aW5kb3dzIFZNIGZvciBzZXZlcmFsIHRpbWVzLgpJdCB3b3Jr
cyBmaW5lIGJ5IG15IGxpbWl0IHRlc3RzLgoKUmVnYXJkcywKLSBDaGVuCgoKCj4KPj4gIAo+PiAK
Pj4gLS0gCj4+IFRvbcOhxaEgR29sZW1iaW92c2vDvSA8dGdvbGVtYmlAcmVkaGF0LmNvbT4KPj4g
Cj4K
