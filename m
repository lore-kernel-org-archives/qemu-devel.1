Received: from eggs.gnu.org ([2001:4830:134:3::10]:57304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1d8ow3-0004uG-7A
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1d8ovy-0003mT-9R
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:19:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1d8ovx-0003lP-Mz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:19:14 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Thu, 11 May 2017 14:18:39 +0000
Message-ID: <B2D15215269B544CADD246097EACE747395ADA61@dggeml511-mbx.china.huawei.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<CANRm+CwvYa01CLChSOGjG6P0q2_Zybov3ZMSULsCGH5GtmRy8A@mail.gmail.com>
In-Reply-To: <CANRm+CwvYa01CLChSOGjG6P0q2_Zybov3ZMSULsCGH5GtmRy8A@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>

SGkgV2FucGVuZywNCg0KPiAyMDE3LTA1LTExIDIxOjQzIEdNVCswODowMCBXYW5wZW5nIExpIDxr
ZXJuZWxsd3BAZ21haWwuY29tPjoNCj4gPiAyMDE3LTA1LTExIDIwOjI0IEdNVCswODowMCBQYW9s
byBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjoNCj4gPj4NCj4gPj4NCj4gPj4gT24gMTEv
MDUvMjAxNyAxNDowNywgWmhvdWppYW4gKGpheSkgd3JvdGU6DQo+ID4+PiAtICAgICAgICAqIFNj
YW4gc3B0ZXMgaWYgZGlydHkgbG9nZ2luZyBoYXMgYmVlbiBzdG9wcGVkLCBkcm9wcGluZw0KPiB0
aG9zZQ0KPiA+Pj4gLSAgICAgICAgKiB3aGljaCBjYW4gYmUgY29sbGFwc2VkIGludG8gYSBzaW5n
bGUgbGFyZ2UtcGFnZSBzcHRlLg0KPiBMYXRlcg0KPiA+Pj4gLSAgICAgICAgKiBwYWdlIGZhdWx0
cyB3aWxsIGNyZWF0ZSB0aGUgbGFyZ2UtcGFnZSBzcHRlcy4NCj4gPj4+ICsgICAgICAgICogUmVz
ZXQgZWFjaCB2Y3B1J3MgbW11LCB0aGVuIHBhZ2UgZmF1bHRzIHdpbGwgY3JlYXRlIHRoZQ0KPiBs
YXJnZS1wYWdlDQo+ID4+PiArICAgICAgICAqIHNwdGVzIGxhdGVyLg0KPiA+Pj4gICAgICAgICAg
Ki8NCj4gPj4+ICAgICAgICAgaWYgKChjaGFuZ2UgIT0gS1ZNX01SX0RFTEVURSkgJiYNCj4gPj4+
ICAgICAgICAgICAgICAgICAob2xkLT5mbGFncyAmIEtWTV9NRU1fTE9HX0RJUlRZX1BBR0VTKSAm
Jg0KPiA+Pj4gLSAgICAgICAgICAgICAgICEobmV3LT5mbGFncyAmIEtWTV9NRU1fTE9HX0RJUlRZ
X1BBR0VTKSkNCj4gPj4+IC0gICAgICAgICAgICAgICBrdm1fbW11X3phcF9jb2xsYXBzaWJsZV9z
cHRlcyhrdm0sIG5ldyk7DQo+ID4NCj4gPiBUaGlzIGlzIGFuIHVubGlrZWx5IGJyYW5jaCh1bmxl
c3MgZ3Vlc3QgbGl2ZSBtaWdyYXRpb24gZmFpbHMgYW5kDQo+ID4gY29udGludWUgdG8gcnVuIG9u
IHRoZSBzb3VyY2UgbWFjaGluZSkgaW5zdGVhZCBvZiBob3QgcGF0aCwgZG8geW91DQo+ID4gaGF2
ZSBhbnkgcGVyZm9ybWFuY2UgbnVtYmVyIGZvciB5b3VyIHJlYWwgd29ya2xvYWRzPw0KPiANCj4g
SSBmaW5kIHRoZSBvcmlnaW5hbCBkaXNjdXNzaW9uIGJ5IGdvb2dsZS4NCj4gaHR0cHM6Ly9saXN0
cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTctMDQvbXNnMDQxNDMuaHRt
bA0KPiBZb3Ugd2lsbCBub3QgZ28gdG8gdGhpcyBicmFuY2ggaWYgdGhlIGd1ZXN0IGxpdmUgbWln
cmF0aW9uIHN1Y2Nlc3NmdWxseS4NCg0KIEluIG91ciB0ZXN0cywgdGhpcyBicmFuY2ggaXMgdGFr
ZW4gd2hlbiBsaXZpbmcgbWlncmF0aW9uIGlzIHN1Y2Nlc3NmdWwuDQogQUZBSUssIHRoZSBrbW9k
IGRvZXMgbm90IGtub3cgd2hldGhlciBsaXZpbmcgbWlncmF0aW9uIHN1Y2Nlc3NmdWwgb3Igbm90
DQogd2hlbiBkZWFsaW5nIHdpdGggS1ZNX1NFVF9VU0VSX01FTU9SWV9SRUdJT04gaW9jdGwuIERv
IEkgbWlzcyBzb21ldGhpbmc/DQoNClJlZ2FyZHMsDQpKYXkgWmhvdQ0K
