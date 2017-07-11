Received: from eggs.gnu.org ([2001:4830:134:3::10]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dUwUy-0007Od-Q8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dUwUx-0003VT-VV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:50:48 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Tue, 11 Jul 2017 14:50:11 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F2014DD643@DGGEMA503-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH resend v4 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>

RXJpYywNCiAgVGhhbmtzIGZvciB5b3VyIGZvbGxvdyB1cC4gDQpJdCBpcyBpbmRlZWQgdGhhdCBJ
IHNlbmQgdGhlIHBhdGNoZXMgb25lIGJ5IG9uZS4gdGhleSBzaG91bGQgYmUgc2VudCB0b2dldGhl
ci4NCkkgd2lsbCB1c2UgYmVsb3cgY29tbWFuZHMgdG8gZml4IHRoaXMgaXNzdWUsIG5vdyB0aGUg
Y2hpbmVzIHRpbWUgaXMgbWlkbmlnaHQsIHNvIEkgd2lsbCBoYXZlIHRvIHVwZGF0ZSBpdCB0b21v
cnJvdy4gDQoNCj4gU28gc2VuZCB0aGUgcGF0Y2hlcyB3aXRoDQo+IA0KPiAgIGdpdCBzZW5kLWVt
YWlsICoucGF0Y2gNCj4gDQo+IG9yIHB1dCBhbGwgdGhlIHBhdGNoZXMgaW50byBhIHRlbXBvcmFy
eSBkaXJlY3RvcnksIGFuZCBydW4NCj4gDQo+ICAgZ2l0IHNlbmQtZW1haWwgcGF0Y2gtZGlyLw0K
DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogRXJpYyBCbGFrZSBbbWFpbHRv
OmVibGFrZUByZWRoYXQuY29tXSANCuWPkemAgeaXtumXtDogMjAxN+W5tDfmnIgxMeaXpSAyMTo1
OA0K5pS25Lu25Lq6OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPjsgZ2VuZ2Rvbmdq
aXUgPGdlbmdkb25naml1QGh1YXdlaS5jb20+DQrmioTpgIE6IG1zdEByZWRoYXQuY29tOyBpbWFt
bWVkb0ByZWRoYXQuY29tOyBmYW16QHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
Wmhhb3NoZW5nbG9uZyA8emhhb3NoZW5nbG9uZ0BodWF3ZWkuY29tPjsgcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBxZW11LWFybUBub25nbnUub3JnOyBaaGVuZ3FpYW5nICh0dXJpbmcpIDx6aGVu
Z3FpYW5nMTBAaHVhd2VpLmNvbT47IEh1YW5nc2hhb3l1IDxodWFuZ3NoYW95dUBodWF3ZWkuY29t
PjsgV3VxdWFubWluZyA8d3VxdWFubWluZ0BodWF3ZWkuY29tPjsgR2FvemhpaHVpIDx6aGlodWku
Z2FvQGh1YXdlaS5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0ggcmVzZW5kIHY0IDAvM10gR2VuZXJh
dGUgQVBFSSBHSEVTIHRhYmxlIGFuZCBkeW5hbWljYWxseSByZWNvcmQgQ1BFUg0KDQpPbiAwNy8x
MS8yMDE3IDA4OjQzIEFNLCBMYXN6bG8gRXJzZWsgd3JvdGU6DQo+IFNvIHNlbmQgdGhlIHBhdGNo
ZXMgd2l0aA0KPiANCj4gICBnaXQgc2VuZC1lbWFpbCAqLnBhdGNoDQo+IA0KPiBvciBwdXQgYWxs
IHRoZSBwYXRjaGVzIGludG8gYSB0ZW1wb3JhcnkgZGlyZWN0b3J5LCBhbmQgcnVuDQo+IA0KPiAg
IGdpdCBzZW5kLWVtYWlsIHBhdGNoLWRpci8NCg0KT3IgeW91IGNhbiBldmVuIHNraXAgcGF0Y2gg
ZmlsZXMsIGFuZCBkaXJlY3RseSBzZW5kIHRoaW5ncyB3aXRoIG9uZSBsYXNzIGNoYW5jZSBpbiB5
b3VyIGVkaXRvcjoNCg0KZ2l0IHNlbmQtZW1haWwgLXY1IC0zIC0tYW5ub3RhdGUgLS1jb3Zlci1s
ZXR0ZXINCg0KW3NlbmQgdGhlIHRvcCB0aHJlZSBjb21taXRzIGluIG15IGN1cnJlbnQgZ2l0IGJy
YW5jaCBhcyBhIHZlcnNpb24gNSBwYXRjaCBzZXJpZXMsIHdoZXJlIEkgZ2V0IHRvIHdyaXRlIHRo
ZSBjb3ZlciBsZXR0ZXIgYW5kIHR3ZWFrIGFueSBvZiB0aGUgcGF0Y2hlcyBpbiBteSBwcmVmZXJy
ZWQgJEVESVRPUiBiZWZvcmUgc2VuZGluZyBhbnl0aGluZ10NCg0KLS0NCkVyaWMgQmxha2UsIFBy
aW5jaXBhbCBTb2Z0d2FyZSBFbmdpbmVlcg0KUmVkIEhhdCwgSW5jLiAgICAgICAgICAgKzEtOTE5
LTMwMS0zMjY2DQpWaXJ0dWFsaXphdGlvbjogIHFlbXUub3JnIHwgbGlidmlydC5vcmcNCg0K
