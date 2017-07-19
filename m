Received: from eggs.gnu.org ([2001:4830:134:3::10]:35874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dXok3-0003jb-FS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dXojz-0001Pw-Ew
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:10:15 -0400
Received: from m15-52.126.com ([220.181.15.52]:17542)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dXojx-0001B0-KC
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:10:11 -0400
Date: Wed, 19 Jul 2017 20:39:26 +0800 (CST)
From: indiffpig  <indiffpig@126.com>
In-Reply-To: <1500031677-2362-1-git-send-email-indiffPig@126.com>
References: <1500031677-2362-1-git-send-email-indiffPig@126.com>
MIME-Version: 1.0
Message-ID: <1b58cb8.a133.15d5adc3290.Coremail.indiffpig@126.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] dvs services stop then qemu may be accesse
 null address case core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: indiffPig@126.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

Ck5vIG9uZSByZXBsaWVkIHRvIG15IG1haWwuIFNvbWVvbmUgbWlnaHQgdGhpbmsgSSB3YXMgdGFs
a2luZyBub25zZW5zZS4gV2hlbiB0aGUgRFZTIHNlcnZpY2Ugc3RvcHBlZCwgYWxsIG91ciBRRU1V
IHByb2Nlc3NlcyBleGl0ZWQuIERWUyB1c2VycyBjb21wbGFpbiB0aGF0IGV2ZW4gaWYgdGhlaXIg
RFZTIHNlcnZpY2VzIGFyZSBzdG9wcGVkLCB2aG9zdC11c2VyIG5ldHdvcmtzIHNob3VsZCBub3Qg
YmUgYmxvY2tlZCwgYnV0IHZpcnR1YWwgbWFjaGluZXMgc2hvdWxkIG5vdCBiZSBhbGxvd2VkIHRv
IGV4aXQuIEkgZm91bmQgdGhlIHNlZ2RlZmF1bHQgZXJyb3IgaW4gdGhlIGhvc3QncyBsb2cgYWJv
dXQgUUVNVSwgYW5kIGFsbCBlcnJvcnMgYXJlIHBvaW50aW5nIHRvIHRoZSBudWxsIHBvaW50ZXIg
cmVmZXJyZWQgdG8gaW4gdGhlIHBhdGNoLiBXaGF0IGRvZXMgb3BlbiBzb3VyY2UgbWFpbnRlbmFu
Y2Ugc3RhZmYgdGhpbmsgYWJvdXQ/CgoKCgoKCgpBdCAyMDE3LTA3LTE0IDE5OjI3OjU3LCBpbmRp
ZmZQaWdAMTI2LmNvbSB3cm90ZToKPkZyb206ICJ5aW4uenVvd2VpIiA8aW5kaWZmUGlnQDEyNi5j
b20+Cj4KPlNpZ25lZC1vZmYtYnk6IHlpbi56dW93ZWkgPGluZGlmZlBpZ0AxMjYuY29tPgo+LS0t
Cj4gY2hhcmRldi9jaGFyLWZlLmMgfCA4ICsrKysrKystCj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvY2hhcmRldi9jaGFyLWZl
LmMgYi9jaGFyZGV2L2NoYXItZmUuYwo+aW5kZXggM2Y5MGYwNS4uODJmN2UyYiAxMDA2NDQKPi0t
LSBhL2NoYXJkZXYvY2hhci1mZS5jCj4rKysgYi9jaGFyZGV2L2NoYXItZmUuYwo+QEAgLTM1Myw3
ICszNTMsMTMgQEAgZ3VpbnQgcWVtdV9jaHJfZmVfYWRkX3dhdGNoKENoYXJCYWNrZW5kICpiZSwg
R0lPQ29uZGl0aW9uIGNvbmQsCj4gCj4gdm9pZCBxZW11X2Nocl9mZV9kaXNjb25uZWN0KENoYXJC
YWNrZW5kICpiZSkKPiB7Cj4tICAgIENoYXJkZXYgKmNociA9IGJlLT5jaHI7Cj4rICAgIENoYXJk
ZXYgKmNociA9IE5VTEw7Cj4rCj4rICAgIGlmIChiZSkgewo+KyAgICAgICAgY2hyID0gYmUtPmNo
cjsKPisgICAgfSBlbHNlIHsKPisgICAgICAgIHJldHVybiA7Cj4rICAgIH0KPiAKPiAgICAgaWYg
KGNociAmJiBDSEFSREVWX0dFVF9DTEFTUyhjaHIpLT5jaHJfZGlzY29ubmVjdCkgewo+ICAgICAg
ICAgQ0hBUkRFVl9HRVRfQ0xBU1MoY2hyKS0+Y2hyX2Rpc2Nvbm5lY3QoY2hyKTsKPi0tIAo+MS44
LjMuMQo+Cg==
