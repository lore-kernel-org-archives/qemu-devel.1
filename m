Received: from eggs.gnu.org ([208.118.235.92]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gbeEg-0004zO-KD
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 23:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gbeEc-0004j7-Ml
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 23:22:30 -0500
Received: from m13-153.163.com ([220.181.13.153]:50857)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gbeEb-0004eW-Jd
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 23:22:26 -0500
Date: Tue, 25 Dec 2018 12:06:41 +0800 (CST)
From: tugouxp  <13824125580@163.com>
In-Reply-To: <CAFEAcA8TOPHViUG0B0KAnDCpuoygkn51KVXNniQvjdcEf2R9ng@mail.gmail.com>
References: <1bd5a622.e60b.167dfb192d3.Coremail.13824125580@163.com>
	<CAFEAcA8TOPHViUG0B0KAnDCpuoygkn51KVXNniQvjdcEf2R9ng@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <55c3b715.72b5.167e38b1206.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] what is the behavier precisely if a tb was
 interrupted by a interrupt or signal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

dGhhbmsgeW91LgoKCmlmIHNvICx0aGUgaW50ZXJydXB0ICBncmFudWxhcml0eSBjYW50IGJlIGlu
c3RydWN0aW9ucyBwcmVjaXNlbHksIGJ1dCB0YiBwcmVjaXNlbHksICBmb3IgcWVtdSBjYW50IGNo
ZWNrIHRoZSBpbnRlcnJ1cHQgYXQgZWFjaCBpbnN0cnVjdGlvbnMgZXhlY3V0aW9uIHN0YWdlLCBy
aWdodD8KCgoKCgoKCkF0IDIwMTgtMTItMjQgMjE6NDk6MDcsICJQZXRlciBNYXlkZWxsIiA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToKPk9uIE1vbiwgMjQgRGVjIDIwMTggYXQgMTA6
MTEsIHR1Z291eHAgPDEzODI0MTI1NTgwQDE2My5jb20+IHdyb3RlOgo+PiAgdGhpbmsgYWJvdXQg
dGhlIHNjZW5hcmlvIGxpa2UgdGhhdCwgYSB0YiBibG9jayBjb250YWluICA5IG5hdGl2ZSBpbnN0
cnVjdGlvbnMgIGV4ZWN1dGUgc2VxdWVudGlhbGx5Cj4+Cj4+ICBpZiBhIGludGVycnVwdCBvciBh
IHNpZ25hbCBoYXBwZW5zICBiZWZvcmUgaW5zdHJ1Y3Rpb24gNiBleGVjdXRlZCwgIGRpZCB0aGUg
dGIgIGJlIGZpbmlzaGVkIGJlZm9yZSByZXNwb25zZSB0byB0aGUgaW50ZXJydXB0ICBvcgo+Pgo+
PiB0aGUgIGV4aXRlZCBhdCBvbmNlIHRvIHJlc3BvbnNlIHRoZSBpbnRlcnJ1cHQ/Cj4KPldlIGRv
bid0IGNoZWNrIGluIHRoZSBtaWRkbGUgb2YgYSBUQiBmb3IgY29uZGl0aW9ucyBsaWtlCj5pbnRl
cnJ1cHRzLiBUaGUgb25seSB0aGluZyB0aGF0IGNhbiBjYXVzZSBhIFRCIHRvIHN0b3AKPmV4ZWN1
dGlvbiBoYWxmd2F5IHRocm91Z2ggaXMgaWYgaXQgZG9lcyBzb21ldGhpbmcgdGhhdAo+cHJvdm9r
ZXMgYSBzeW5jaHJvbm91cyBleGNlcHRpb24gKGZvciBpbnN0YW5jZSwgaWYgaXQKPmRvZXMgYSBn
dWVzdCBtZW1vcnkgYWNjZXNzIHRoYXQgdHJpZ2dlcnMgYSBndWVzdCBDUFUKPnBhZ2UgZmF1bHQs
IG9yIGlmIGl0IGVtdWxhdGVzIGEgZ3Vlc3QgaW5zdHJ1Y3Rpb24gdGhhdAo+aXMgcmVxdWlyZWQg
dG8gdHJhcCkuIFRob3NlIHdlIGVtdWxhdGUgYnkgbG9uZ2p1bXBpbmcgb3V0Cj5mcm9tIHRoZSBn
ZW5lcmF0ZWQgY29kZSB0byB0aGUgdG9wIGxldmVsIGxvb3AuCj5Bc3luY2hyb25vdXMgZXZlbnRz
IGxpa2UgZW11bGF0ZWQgaW50ZXJydXB0cyB3ZSBvbmx5Cj5jaGVjayBhdCB0aGUgYmVnaW5uaW5n
IG9mIHRoZSBUQjogd2UgZW1pdCBjb2RlIHdoaWNoCj50ZXN0cyBhIGZsYWcgYW5kIHJldHVybnMg
ZWFybHkuCj4KPnRoYW5rcwo+LS0gUE1NCg==
