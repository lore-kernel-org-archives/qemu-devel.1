Received: from eggs.gnu.org ([2001:4830:134:3::10]:55490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gPfJg-0005Iy-FK
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gPfJf-0002NP-OQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:06:08 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Thu, 22 Nov 2018 03:05:41 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201F7D7EB@DGGEMA503-MBX.china.huawei.com>
References: <1541672989-15967-1-git-send-email-gengdongjiu@huawei.com>
	<1541672989-15967-11-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-6UKk-WF+M+z0=AN-X7q0XRFLo2RG_yBadDeCas4A5wQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-6UKk-WF+M+z0=AN-X7q0XRFLo2RG_yBadDeCas4A5wQ@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBbUEFUQ0ggUkVTRU5EIHYxNSAxMC8x?=
 =?utf-8?q?0=5D_target-arm=3A_kvm64=3A_handle_SIGBUS_signal_from_kernel_or?=
 =?utf-8?q?_KVM?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Peter Maydell' <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, "zhengxiang (A)" <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

PiA+DQo+ID4gK3ZvaWQga3ZtX2FyY2hfb25fc2lnYnVzX3ZjcHUoQ1BVU3RhdGUgKmMsIGludCBj
b2RlLCB2b2lkICphZGRyKSB7DQo+ID4gKyAgICByYW1fYWRkcl90IHJhbV9hZGRyOw0KPiA+ICsg
ICAgaHdhZGRyIHBhZGRyOw0KPiA+ICsNCj4gPiArICAgIGFzc2VydChjb2RlID09IEJVU19NQ0VF
UlJfQVIgfHwgY29kZSA9PSBCVVNfTUNFRVJSX0FPKTsNCj4gPiArICAgIGlmIChhZGRyKSB7DQo+
ID4gKyAgICAgICAgcmFtX2FkZHIgPSBxZW11X3JhbV9hZGRyX2Zyb21faG9zdChhZGRyKTsNCj4g
PiArICAgICAgICBpZiAocmFtX2FkZHIgIT0gUkFNX0FERFJfSU5WQUxJRCAmJg0KPiA+ICsgICAg
ICAgICAgICBrdm1fcGh5c2ljYWxfbWVtb3J5X2FkZHJfZnJvbV9ob3N0KGMtPmt2bV9zdGF0ZSwg
YWRkciwgJnBhZGRyKSkgew0KPiA+ICsgICAgICAgICAgICBrdm1faHdwb2lzb25fcGFnZV9hZGQo
cmFtX2FkZHIpOw0KPiA+ICsgICAgICAgICAgICBpZiAoY29kZSA9PSBCVVNfTUNFRVJSX0FSKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICBrdm1fY3B1X3N5bmNocm9uaXplX3N0YXRlKGMpOw0KPiA+
ICsgICAgICAgICAgICAgICAgaWYgKGdoZXNfcmVjb3JkX2Vycm9ycyhBQ1BJX0hFU1RfTk9USUZZ
X1NFQSwgcGFkZHIpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAga3ZtX2luamVjdF9hcm1f
c2VhKGMpOw0KPiA+ICsgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICBmcHJpbnRmKHN0ZGVyciwgImZhaWxlZCB0byByZWNvcmQgdGhlIGVycm9yXG4iKTsN
Cj4gPiArICAgICAgICAgICAgICAgIH0NCj4gDQo+IFNob3VsZG4ndCB0aGVyZSBiZSBzb21ldGhp
bmcgaW4gaGVyZSB0byBzYXkgIm9ubHkgcmVwb3J0IHRoaXMgZXJyb3IgdG8gdGhlIGd1ZXN0IGlm
IHdlIGFyZSBhY3R1YWxseSByZXBvcnRpbmcgUkFTIGVycm9ycyB0byB0aGUgZ3Vlc3QiID8NCg0K
WWVzLCBXZSBjYW4gc2F5IHNvbWV0aGluZyB0aGF0IHN1Y2ggYXMgInJlcG9ydCB0aGlzIGVycm9y
IHRvIHRoZSBndWVzdCIsIGJlY2F1c2UgdGhpcyBlcnJvciBpcyBpbmRlZWQgdHJpZ2dlcmVkIGJ5
IGd1ZXN0LCB3aGljaCBpcyBndWVzdCBlcnJvci4NCg0KPiANCj4gPiArICAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGZw
cmludGYoc3RkZXJyLCAiSGFyZHdhcmUgbWVtb3J5IGVycm9yIGZvciBtZW1vcnkgdXNlZCBieSAi
DQo+ID4gKyAgICAgICAgICAgICAgICAiUUVNVSBpdHNlbGYgaW5zdGVhZCBvZiBndWVzdCBzeXN0
ZW0hXG4iKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBpZiAoY29kZSA9PSBCVVNfTUNF
RVJSX0FSKSB7DQo+ID4gKyAgICAgICAgZnByaW50ZihzdGRlcnIsICJIYXJkd2FyZSBtZW1vcnkg
ZXJyb3IhXG4iKTsNCj4gPiArICAgICAgICBleGl0KDEpOw0KPiA+ICsgICAgfQ0KPiA+ICt9DQo+
ID4gKw0KPiA+ICAvKiBDNi42LjI5IEJSSyBpbnN0cnVjdGlvbiAqLw0KPiA+ICBzdGF0aWMgY29u
c3QgdWludDMyX3QgYnJrX2luc24gPSAweGQ0MjAwMDAwOw0KPiANCj4gdGhhbmtzDQo+IC0tIFBN
TQ0K
