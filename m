Received: from eggs.gnu.org ([2001:4830:134:3::10]:46637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e7evk-0002Ij-BT
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e7evf-0006NK-GC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:58:28 -0400
Received: from m15-47.126.com ([220.181.15.47]:31979)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e7eve-0006Jk-Rp
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:58:23 -0400
Date: Thu, 26 Oct 2017 17:27:40 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <150896868721.17721.8644098584872122342@sif>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7f4779f8.a9e3.15f58023405.Coremail.chen_han_xiao@126.com>
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

CgpBdCAyMDE3LTEwLTI2IDA1OjU4OjA3LCAiTWljaGFlbCBSb3RoIiA8bWRyb3RoQGxpbnV4LnZu
ZXQuaWJtLmNvbT4gd3JvdGU6Cj5RdW90aW5nIFRvbcOhxaEgR29sZW1iaW92c2vDvSAoMjAxNy0w
OS0yOSAxNjozMTowMikKPj4gT24gRnJpLCAyOSBTZXAgMjAxNyAxNzoxMToyMiArMDgwMAo+PiBD
aGVuIEhhbnhpYW8gPGNoZW5faGFuX3hpYW9AMTI2LmNvbT4gd3JvdGU6Cj4+IAo+PiA+IEZyb206
IENoZW4gSGFueGlhbyA8Y2hlbmhhbnhpYW9AZ21haWwuY29tPgo+PiA+IAo+PiA+IE9uIHNvbWUg
b2Ygd2luZG93cyAod2luMDggc3AyKSwKPj4gPiBpdCBkb2Vzbid0IHdvcmsgYnkgY2FsbGluZyBM
b29rdXBBY2NvdW50U2lkVyB3aXRoCj4+ID4gd2VsbC1rbm93biBTSURzLAo+PiA+IFdlIGdvdCBh
biBlcnJvcjoKPj4gPiAgICAgZXJyb3IgOTk3IG92ZXJsYXBwZWQgSS9PIG9wZXJhdGlvbiBpcyBp
biBwcm9ncmVzcwo+PiA+IAo+PiA+IEJ1dCBoYXJkY29kZWQgbmFtZXMgd29yay4KPj4gPiAKPj4g
PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSB3b3JrYXJvdWQgZm9yIHRoaXMgaXNzdWU6Cj4+ID4g
aWYgTG9va3VwQWNjb3VudFNpZFcgZmFpbGVkLCB0cnkgaGFyZGNvZGVkIG9uZS4KPj4gPiAKPj4g
PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIEhhbnhpYW8gPGNoZW5oYW54aWFvQGdtYWlsLmNvbT4KPj4g
PiAtLS0KPj4gPiAgcWdhL3Zzcy13aW4zMi9pbnN0YWxsLmNwcCB8IDEwICsrKysrKysrLS0KPj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4gPiAK
Pj4gCj4+IEkgd29uZGVyIGlmIGl0J3MgY2F1c2VkIGJ5IHFnYSBpdHNlbGYgb3IgYSByYWNlL2Nv
bmZsaWN0IHdpdGggc29tZSBvdGhlcgo+PiBhcHAuIEJ1dCBzdGlsbC4uLgo+PiAKPj4gCj4+IFJl
dmlld2VkLWJ5OiBUb23DocWhIEdvbGVtYmlvdnNrw70gPHRnb2xlbWJpQHJlZGhhdC5jb20+Cj4K
PkkgdGhpbmsgaXQgbWlnaHQgYmUgZ2V0TmFtZUJ5U3RyaW5nU0lEKCkvTG9va3VwQWNjb3VudFNp
ZFcoKSByZXBvcnRpbmcgYQo+c3RhbGUgR2V0TGFzdEVycm9yKCkgdmFsdWUuCj4KPkRvZXMgdGhp
cyBmaXggdGhlIGlzc3VlPwoKTm90IGV4YWN0bHkuCkkgdGVzdGVkIHlvdXIgcGF0Y2ggc2V2ZXJh
bCB0aW1lcywgaXQgaW1wcm92ZWQgZ3JlYXRseS4KQnV0IGZhaWxlZCBvbmx5IG9uZSB0aW1lLApn
b3QgYW5vdGhlciBlcnJvciAxNzIyLgoKQnVpbGQgd2l0aCBteSBmYWxsYmFjayBwYXRjaCBhbmQg
eW91ciBzdWdnZXN0aW9uLCAKaW5zdGFsbGF0aW9uIHdvcmsgcGVyZmVjdGx5LgoKUmVnYXJkcywK
LSBDaGVuCgo+Cj5kaWZmIC0tZ2l0IGEvcWdhL3Zzcy13aW4zMi9pbnN0YWxsLmNwcCBiL3FnYS92
c3Mtd2luMzIvaW5zdGFsbC5jcHAKPmluZGV4IGJhN2M5NGViMjUuLjk0YzkyMWU4ZGUgMTAwNjQ0
Cj4tLS0gYS9xZ2EvdnNzLXdpbjMyL2luc3RhbGwuY3BwCj4rKysgYi9xZ2EvdnNzLXdpbjMyL2lu
c3RhbGwuY3BwCj5AQCAtMTQ5LDkgKzE0OSwxMCBAQCBzdGF0aWMgSFJFU1VMVCBnZXROYW1lQnlT
dHJpbmdTSUQoCj4gICAgIHdjaGFyX3QgZG9tYWluTmFtZVtCVUZGRVJfU0laRV07Cj4gCj4gICAg
IGNoayhDb252ZXJ0U3RyaW5nU2lkVG9TaWRXKHNpZCwgJnBzaWQpKTsKPi0gICAgTG9va3VwQWNj
b3VudFNpZFcoTlVMTCwgcHNpZCwgYnVmZmVyLCBidWZmZXJMZW4sCj4tICAgICAgICAgICAgICAg
IGRvbWFpbk5hbWUsICZkb21haW5OYW1lTGVuLCAmZ3JvdXBUeXBlKTsKPi0gICAgaHIgPSBIUkVT
VUxUX0ZST01fV0lOMzIoR2V0TGFzdEVycm9yKCkpOwo+KyAgICBpZiAoIUxvb2t1cEFjY291bnRT
aWRXKE5VTEwsIHBzaWQsIGJ1ZmZlciwgYnVmZmVyTGVuLAo+KyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRvbWFpbk5hbWUsICZkb21haW5OYW1lTGVuLCAmZ3JvdXBUeXBlKSkgewo+KyAgICAg
ICAgaHIgPSBIUkVTVUxUX0ZST01fV0lOMzIoR2V0TGFzdEVycm9yKCkpOwo+KyAgICB9Cj4gCj4g
ICAgIExvY2FsRnJlZShwc2lkKTsKPgo+PiAKPj4gCj4+IC0tIAo+PiBUb23DocWhIEdvbGVtYmlv
dnNrw70gPHRnb2xlbWJpQHJlZGhhdC5jb20+Cj4+IAo+Cg==
