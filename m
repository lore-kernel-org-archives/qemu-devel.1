Received: from eggs.gnu.org ([2001:4830:134:3::10]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSMrJ-00028x-JO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSMrG-0000JC-FL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:27:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2396 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fSMrG-0000Ho-00
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:27:42 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 11 Jun 2018 13:25:49 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB01644F@dggeml511-mbx.china.huawei.com>
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
	<e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
	<56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
	<4409ea2d-971d-8898-bd1a-9e9b9e9172dc@redhat.com>
	<ced449d6-1778-6641-d055-4fedda442a47@redhat.com>
	<AE460DFB-87F8-45A3-A007-E59C3B23BB67@zju.edu.cn>
	<679ab02f-b110-c80a-c99e-1301b7fa1725@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB015FC4@dggeml511-mbx.china.huawei.com>
	<97a9b33e-7dc1-e2cb-ce7d-ea0adb1a4dbe@redhat.com>
In-Reply-To: <97a9b33e-7dc1-e2cb-ce7d-ea0adb1a4dbe@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, =?utf-8?B?5rWZ5aSn6YKu566x?= <linzc@zju.edu.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGt2bS1vd25lckB2Z2VyLmtl
cm5lbC5vcmcgW21haWx0bzprdm0tb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbg0KPiBCZWhhbGYg
T2YgRGF2aWQgSGlsZGVuYnJhbmQNCj4gU2VudDogTW9uZGF5LCBKdW5lIDExLCAyMDE4IDg6MzYg
UE0NCj4gVG86IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IOa1meWk
p+mCrueusSA8bGluemNAemp1LmVkdS5jbj4NCj4gU3ViamVjdDogUmU6IEFuIGVtdWxhdGlvbiBm
YWlsdXJlIG9jY3VycyxpZiBJIGhvdHBsdWcgdmNwdXMgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlDQo+
IFZNIHN0YXJ0DQo+IA0KPiBPbiAxMS4wNi4yMDE4IDE0OjI1LCBHb25nbGVpIChBcmVpKSB3cm90
ZToNCj4gPg0KPiA+IEhpIERhdmlkIGFuZCBQYW9sbywNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCBbbWFpbHRvOmRhdmlk
QHJlZGhhdC5jb21dDQo+ID4+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMSwgMjAxOCA2OjQ0IFBNDQo+
ID4+IFRvOiDmtZnlpKfpgq7nrrEgPGxpbnpjQHpqdS5lZHUuY24+DQo+ID4+IENjOiBQYW9sbyBC
b256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgR29uZ2xlaSAoQXJlaSkNCj4gPj4gPGFyZWku
Z29uZ2xlaUBodWF3ZWkuY29tPjsgSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT47
DQo+ID4+IHh1eWFuZG9uZyA8eHV5YW5kb25nMkBodWF3ZWkuY29tPjsgWmhhbmdoYWlsaWFuZw0K
PiA+PiA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgd2FuZ3hpbiAoVSkNCj4gPj4g
PHdhbmd4aW54aW4ud2FuZ0BodWF3ZWkuY29tPjsgbGlkb25nbGluIDxsaWRvbmdsaW5AaHVhd2Vp
LmNvbT47DQo+ID4+IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
SHVhbmd3ZWlkb25nIChDKQ0KPiA+PiA8d2VpZG9uZy5odWFuZ0BodWF3ZWkuY29tPg0KPiA+PiBT
dWJqZWN0OiBSZTogQW4gZW11bGF0aW9uIGZhaWx1cmUgb2NjdXJzLGlmIEkgaG90cGx1ZyB2Y3B1
cyBpbW1lZGlhdGVseSBhZnRlcg0KPiB0aGUNCj4gPj4gVk0gc3RhcnQNCj4gPj4NCj4gPj4gT24g
MDcuMDYuMjAxOCAxODowMywg5rWZ5aSn6YKu566xIHdyb3RlOg0KPiA+Pj4gSGnvvIxhbGwNCj4g
Pj4+IEkgc3RpbGwgaGF2ZSBhIHF1ZXN0aW9uIGFmdGVyIHJlYWRpbmcgeW91ciBkaXNjdXNzaW9u
OiBXaWxsIHNlYWJpb3MgZGV0ZWN0IHRoZQ0KPiA+PiBjaGFuZ2Ugb2YgYWRkcmVzcyBzcGFjZSBl
dmVuIGlmIHdlIGFkZF9yZWdpb24gYW5kIGRlbF9yZWdpb24NCj4gYXV0b21hdGljYWxseT8gSQ0K
PiA+PiBndWVzcyB0aGF0IHNlYWJpb3MgbWF5IG5vdCB0YWtlIHRoaXMgY2hhbmdlIGludG8gY29u
c2lkZXJhdGlvbi4NCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+ID4+IFdlIHdvdWxkIGp1c3QgY2hh
bmdlIHRoZSB3YXkgaG93IEtWTSBtZW1vcnkgc2xvdHMgYXJlIHVwZGF0ZWQuIFRoaXMgaXMNCj4g
Pj4gcmlnaHQgbm93IG5vdCBhdG9taWMsIGJ1dCB3b3VsZCBiZSBsYXRlciBvbi4gSXQgc2hvdWxk
IG5vdCBoYXZlIGFueQ0KPiA+PiBvdGhlciBlZmZlY3QuDQo+ID4+DQo+ID4gWWVzLiBEbyB5b3Ug
aGF2ZSBhbnkgcGxhbnMgdG8gZG8gdGhhdD8NCj4gDQo+IFdlbGwsIEkgaGF2ZSBwbGFucyB0byB3
b3JrIG9uIGF0b21pY2FsbHkgcmVzaXphYmxlIG1lbW9yeSByZWdpb25zDQo+IChhdG9taWMgZGVs
ICsgYWRkKSwgYW5kIHdoYXQgUGFvbG8gZGVzY3JpYmVkIGNvdWxkIGFsc28gd29yayBmb3IgdGhh
dA0KPiB1c2UgY2FzZS4gSG93ZXZlciwgSSB3b24ndCBoYXZlIHRpbWUgdG8gbG9vayBpbnRvIHRo
YXQgaW4gdGhlIG5lYXINCj4gZnV0dXJlLiBTbyBpZiBzb21lYm9keSBlbHNlIHdhbnRzIHRvIGp1
bXAgaXQsIHBlcmZlY3QuIElmIG5vdCwgaXQgd2lsbA0KPiBoYXZlIHRvIHdhaXQgdW5mb3J0dW5h
dGVseS4NCj4gDQpHb3QgaXQuIDopDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=
