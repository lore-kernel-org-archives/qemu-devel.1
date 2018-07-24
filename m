Received: from eggs.gnu.org ([2001:4830:134:3::10]:54672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhn3X-0004i6-EN
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 22:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhn3T-00054v-GW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 22:28:07 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57876 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fhn3T-00053o-1n
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 22:28:03 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Tue, 24 Jul 2018 02:27:47 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC555086C843B@dggemm521-mbx.china.huawei.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<6c060312-5e49-8377-1e8a-5f86baf0eca7@redhat.com>
In-Reply-To: <6c060312-5e49-8377-1e8a-5f86baf0eca7@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SSBhbSBzb3JyeSBmb3IgdGhhdC4gSSBoYXZlIGNoYW5nZWQgdGhlIGdpdCBzZXR0aW5nIHRvIGF2
b2lkIHVzaW5nIHRoaXMgc3ltYm9sIG5leHQgdGltZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5jb21dDQo+
IFNlbnQ6IE1vbmRheSwgSnVseSAyMywgMjAxOCAxMDo1MiBQTQ0KPiBUbzogbGl1anVuamllIChB
KSA8bGl1anVuamllMjNAaHVhd2VpLmNvbT47IGFybWJydUByZWRoYXQuY29tDQo+IENjOiB3YW5n
eGluIChVKSA8d2FuZ3hpbnhpbi53YW5nQGh1YXdlaS5jb20+OyBHb25nbGVpIChBcmVpKQ0KPiA8
YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+OyBIdWFuZ3dlaWRvbmcgKEMpDQo+IDx3ZWlkb25nLmh1
YW5nQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIHFzdHJpbmc6IEZpeCBpbnRlZ2VyIG92ZXJmbG93DQo+IA0KPiBP
biAwNy8yMC8yMDE4IDA4OjA5IEFNLCBsaXVqdW5qaWUgd3JvdGU6DQo+ID4gRnJvbTogbDAwNDI1
MTcwIDxsaXVqdW5qaWUyM0BodWF3ZWkuY29tPg0KPiA+DQo+ID4gVGhlIGluY29taW5nIHBhcmFt
ZXRlcnMgInN0YXJ0IiBhbmQgImVuZCIgaXMgaW50IHR5cGUgaW4NCj4gPiBxc3RyaW5nX2Zyb21f
c3Vic3RyKCksIGJ1dCB0aGlzIGZ1bmN0aW9uIGNhbiBiZSBjYWxsZWQgYnkNCj4gPiBxc3RyaW5n
X2Zyb21fc3RyLCB3aGljaCBpcyBzaXplX3QgdHlwZSBpbiBzdHJsZW4oc3RyKS4NCj4gPiBJdCBt
YXkgcmVzdWx0IGluIGNvcmVkdW1wIHdoZW4gY2FsbGVkIGdfbWFsbG9jIGxhdGVyLg0KPiA+IE9u
ZSBzY2VuZSB0byB0cmlnZXIgaXMgdG8gY2FsbCBobXAgImludG8gdGxiIiwgd2hpY2ggbWF5IGhh
dmUgdG9vIGxvbmcNCj4gPiBsZW5ndGggb2Ygc3RyaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogbDAwNDI1MTcwIDxsaXVqdW5qaWUyM0BodWF3ZWkuY29tPg0KPiANCj4gVXNpbmcgd2hhdCBs
b29rcyBsaWtlIGEgdXNlcm5hbWUgZm9yIHlvdXIgQXV0aG9yIGFuZCBTLW8tYiBkZXNpZ25hdGlv
biByYXRoZXINCj4gdGhhbiBhIGxlZ2FsIG5hbWUgaXMgZmlzaHkuICBJZiAnbDAwNDI1MTcwJyBp
cyByZWFsbHkgYW4gYWxpYXMgdGhhdCB5b3UgaGF2ZQ0KPiBmcmVxdWVudGx5IHVzZWQgaW4gb3Ro
ZXIgb3BlbiBzb3VyY2UgcHJvamVjdHMsIGl0IG1pZ2h0IGJlIG9rYXkgKGFuZCBpZiBzbywgeW91
DQo+IGNvdWxkIGJhY2sgaXQgdXAgYnkgcG9pbnRpbmcgdXMgdG8gYSBVUkwgb2Ygc3VjaCBjb250
cmlidXRpb25zIHRvIG90aGVyIHByb2plY3RzKS4NCj4gQnV0IGluIGdlbmVyYWwsIGl0J3MgYmV0
dGVyIHRvIG93biB5b3VyIHBhdGNoZXMgd2l0aCB5b3VyIHJlYWwgbmFtZSAoZ2l0DQo+IHN1cHBv
cnRzIFVURi04LCBpZiB5b3Ugd291bGQgbGlrZSB5b3VyIG5hbWUgdG8gYXBwZWFyIGluIG5hdGl2
ZSBjaGFyYWN0ZXJzDQo+IGluc3RlYWQgb2Ygb3IgaW4gYWRkaXRpb24gdG8gYSBMYXRpbi1pemVk
IGZvcm0pLg0KPiANCj4gLS0NCj4gRXJpYyBCbGFrZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2lu
ZWVyDQo+IFJlZCBIYXQsIEluYy4gICAgICAgICAgICsxLTkxOS0zMDEtMzI2Ng0KPiBWaXJ0dWFs
aXphdGlvbjogIHFlbXUub3JnIHwgbGlidmlydC5vcmcNCg==
