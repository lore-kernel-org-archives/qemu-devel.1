Received: from eggs.gnu.org ([2001:4830:134:3::10]:51268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSLtL-0000xM-G9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSLtI-0005Jj-Dc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:25:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2276 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fSLtH-0005HH-Ve
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:25:44 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 11 Jun 2018 12:25:18 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB015FC4@dggeml511-mbx.china.huawei.com>
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
In-Reply-To: <679ab02f-b110-c80a-c99e-1301b7fa1725@redhat.com>
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

DQpIaSBEYXZpZCBhbmQgUGFvbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiBTZW50
OiBNb25kYXksIEp1bmUgMTEsIDIwMTggNjo0NCBQTQ0KPiBUbzog5rWZ5aSn6YKu566xIDxsaW56
Y0B6anUuZWR1LmNuPg0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47
IEdvbmdsZWkgKEFyZWkpDQo+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IElnb3IgTWFtbWVk
b3YgPGltYW1tZWRvQHJlZGhhdC5jb20+Ow0KPiB4dXlhbmRvbmcgPHh1eWFuZG9uZzJAaHVhd2Vp
LmNvbT47IFpoYW5naGFpbGlhbmcNCj4gPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47
IHdhbmd4aW4gKFUpDQo+IDx3YW5neGlueGluLndhbmdAaHVhd2VpLmNvbT47IGxpZG9uZ2xpbiA8
bGlkb25nbGluQGh1YXdlaS5jb20+Ow0KPiBrdm1Admdlci5rZXJuZWwub3JnOyBxZW11LWRldmVs
QG5vbmdudS5vcmc7IEh1YW5nd2VpZG9uZyAoQykNCj4gPHdlaWRvbmcuaHVhbmdAaHVhd2VpLmNv
bT4NCj4gU3ViamVjdDogUmU6IEFuIGVtdWxhdGlvbiBmYWlsdXJlIG9jY3VycyxpZiBJIGhvdHBs
dWcgdmNwdXMgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlDQo+IFZNIHN0YXJ0DQo+IA0KPiBPbiAwNy4w
Ni4yMDE4IDE4OjAzLCDmtZnlpKfpgq7nrrEgd3JvdGU6DQo+ID4gSGnvvIxhbGwNCj4gPiBJIHN0
aWxsIGhhdmUgYSBxdWVzdGlvbiBhZnRlciByZWFkaW5nIHlvdXIgZGlzY3Vzc2lvbjogV2lsbCBz
ZWFiaW9zIGRldGVjdCB0aGUNCj4gY2hhbmdlIG9mIGFkZHJlc3Mgc3BhY2UgZXZlbiBpZiB3ZSBh
ZGRfcmVnaW9uIGFuZCBkZWxfcmVnaW9uIGF1dG9tYXRpY2FsbHk/IEkNCj4gZ3Vlc3MgdGhhdCBz
ZWFiaW9zIG1heSBub3QgdGFrZSB0aGlzIGNoYW5nZSBpbnRvIGNvbnNpZGVyYXRpb24uDQo+IA0K
PiBIaSwNCj4gDQo+IFdlIHdvdWxkIGp1c3QgY2hhbmdlIHRoZSB3YXkgaG93IEtWTSBtZW1vcnkg
c2xvdHMgYXJlIHVwZGF0ZWQuIFRoaXMgaXMNCj4gcmlnaHQgbm93IG5vdCBhdG9taWMsIGJ1dCB3
b3VsZCBiZSBsYXRlciBvbi4gSXQgc2hvdWxkIG5vdCBoYXZlIGFueQ0KPiBvdGhlciBlZmZlY3Qu
DQo+IA0KWWVzLiBEbyB5b3UgaGF2ZSBhbnkgcGxhbnMgdG8gZG8gdGhhdD8gDQoNClRoYW5rcywN
Ci1Hb25nbGVpDQo=
