Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e7gS1-0001Dt-JM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 07:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e7gRy-0002Z6-DQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 07:35:53 -0400
Received: from m50-156.163.com ([123.125.50.156]:11045)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e7gRx-0002YR-Nh
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 07:35:50 -0400
Date: Thu, 26 Oct 2017 19:01:47 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <150901197477.2572.8281272155306151642@sif>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
	<7f4779f8.a9e3.15f58023405.Coremail.chen_han_xiao@126.com>
	<150901197477.2572.8281272155306151642@sif>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3d0fccaf.b41a.15f58586052.Coremail.chen_han_xiao@126.com>
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

CkF0IDIwMTctMTAtMjYgMTc6NTk6MzQsICJNaWNoYWVsIFJvdGgiIDxtZHJvdGhAbGludXgudm5l
dC5pYm0uY29tPiB3cm90ZToKPlF1b3RpbmcgQ2hlbiBIYW54aWFvICgyMDE3LTEwLTI2IDA0OjI3
OjQwKQo+PiAKPj4gCj4+IEF0IDIwMTctMTAtMjYgMDU6NTg6MDcsICJNaWNoYWVsIFJvdGgiIDxt
ZHJvdGhAbGludXgudm5ldC5pYm0uY29tPiB3cm90ZToKPj4gPlF1b3RpbmcgVG9tw6HFoSBHb2xl
bWJpb3Zza8O9ICgyMDE3LTA5LTI5IDE2OjMxOjAyKQo+PiA+PiBPbiBGcmksIDI5IFNlcCAyMDE3
IDE3OjExOjIyICswODAwCj4+ID4+IENoZW4gSGFueGlhbyA8Y2hlbl9oYW5feGlhb0AxMjYuY29t
PiB3cm90ZToKPj4gPj4gCj4+ID4+ID4gRnJvbTogQ2hlbiBIYW54aWFvIDxjaGVuaGFueGlhb0Bn
bWFpbC5jb20+Cj4+ID4+ID4gCj4+ID4+ID4gT24gc29tZSBvZiB3aW5kb3dzICh3aW4wOCBzcDIp
LAo+PiA+PiA+IGl0IGRvZXNuJ3Qgd29yayBieSBjYWxsaW5nIExvb2t1cEFjY291bnRTaWRXIHdp
dGgKPj4gPj4gPiB3ZWxsLWtub3duIFNJRHMsCj4+ID4+ID4gV2UgZ290IGFuIGVycm9yOgo+PiA+
PiA+ICAgICBlcnJvciA5OTcgb3ZlcmxhcHBlZCBJL08gb3BlcmF0aW9uIGlzIGluIHByb2dyZXNz
Cj4+ID4+ID4gCj4+ID4+ID4gQnV0IGhhcmRjb2RlZCBuYW1lcyB3b3JrLgo+PiA+PiA+IAo+PiA+
PiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIHdvcmthcm91ZCBmb3IgdGhpcyBpc3N1ZToKPj4g
Pj4gPiBpZiBMb29rdXBBY2NvdW50U2lkVyBmYWlsZWQsIHRyeSBoYXJkY29kZWQgb25lLgo+PiA+
PiA+IAo+PiA+PiA+IFNpZ25lZC1vZmYtYnk6IENoZW4gSGFueGlhbyA8Y2hlbmhhbnhpYW9AZ21h
aWwuY29tPgo+PiA+PiA+IC0tLQo+PiA+PiA+ICBxZ2EvdnNzLXdpbjMyL2luc3RhbGwuY3BwIHwg
MTAgKysrKysrKystLQo+PiA+PiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+PiA+PiA+IAo+PiA+PiAKPj4gPj4gSSB3b25kZXIgaWYgaXQncyBjYXVz
ZWQgYnkgcWdhIGl0c2VsZiBvciBhIHJhY2UvY29uZmxpY3Qgd2l0aCBzb21lIG90aGVyCj4+ID4+
IGFwcC4gQnV0IHN0aWxsLi4uCj4+ID4+IAo+PiA+PiAKPj4gPj4gUmV2aWV3ZWQtYnk6IFRvbcOh
xaEgR29sZW1iaW92c2vDvSA8dGdvbGVtYmlAcmVkaGF0LmNvbT4KPj4gPgo+PiA+SSB0aGluayBp
dCBtaWdodCBiZSBnZXROYW1lQnlTdHJpbmdTSUQoKS9Mb29rdXBBY2NvdW50U2lkVygpIHJlcG9y
dGluZyBhCj4+ID5zdGFsZSBHZXRMYXN0RXJyb3IoKSB2YWx1ZS4KPj4gPgo+PiA+RG9lcyB0aGlz
IGZpeCB0aGUgaXNzdWU/Cj4+IAo+PiBOb3QgZXhhY3RseS4KPj4gSSB0ZXN0ZWQgeW91ciBwYXRj
aCBzZXZlcmFsIHRpbWVzLCBpdCBpbXByb3ZlZCBncmVhdGx5Lgo+PiBCdXQgZmFpbGVkIG9ubHkg
b25lIHRpbWUsCj4+IGdvdCBhbm90aGVyIGVycm9yIDE3MjIuCj4KPkhtbSwgd2FzIHRoYXQgZXJy
b3IgYWxzbyBmcm9tIHRoZSBnZXROYW1lQnlTdHJpbmdTSUQoKSBjYWxsPwoKSSBkb24ndCBrbm93
IGhvdyB0byB0cmFjZSBxZW11LWdhLXdpbiwKYnV0IGFkZGVkIHNvbWUgZnByaW50ZihzdGRvdXQp
LgoKKyAgICBociA9IGdldE5hbWVCeVN0cmluZ1NJRChhZG1pbmlzdHJhdG9yc0dyb3VwU0lELCBi
dWZmZXIsICZidWZmZXJMZW4pOworICAgIGlmIChGQUlMRUQoaHIpKSB7CgpJIHNhdyBteSBsb2dz
IGluc2lkZSBpZiAoRkFJTEVEKGhyKSkgewoKQnV0IGl0IGxvb2tzIHdlaXJkLCBhcyB5b3VyIHBh
dGNoIGFscmVhZHkgZGVhbGluZyB3aXRoIHRoaXMgc2VuYXJpby4KCgpSZWdhcmRzLAotIENoZW4K
Cj4KPj4gCj4+IEJ1aWxkIHdpdGggbXkgZmFsbGJhY2sgcGF0Y2ggYW5kIHlvdXIgc3VnZ2VzdGlv
biwgCj4+IGluc3RhbGxhdGlvbiB3b3JrIHBlcmZlY3RseS4KPgo+VGhhbmtzIGZvciB0ZXN0aW5n
Lgo+Cj4+IAo=
