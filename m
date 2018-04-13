Received: from eggs.gnu.org ([2001:4830:134:3::10]:45002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1f6t9a-0002IL-82
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1f6t9W-0008Db-8B
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:29:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2390 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
	id 1f6t9V-0008BG-Tb
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:29:46 -0400
From: xuyandong <xuyandong2@huawei.com>
Date: Fri, 13 Apr 2018 07:27:33 +0000
Message-ID: <7CECC2DFC21538489F72729DF5EFB4D9BF91DA@dggemm501-mbs.china.huawei.com>
References: <20180411111602.20156-1-linzhecheng@huawei.com>
	<20180411134600.0ed8158a@redhat.com>
In-Reply-To: <20180411134600.0ed8158a@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cpu: skip unpluged cpu when querying cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, linzhecheng <linzhecheng@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "rth@twiddle.net" <rth@twiddle.net>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>

WWVzLCB3ZSBzaG91bGQgYWRkIGl0IGF0IHFtcF9xdWVyeV9jcHVzX2Zhc3QoKSAuDQpJbiB0aGlz
IGNhc2UsIHFtcF9xdWVyeV9jcHVzKCkgbWF5IGtpY2sgYSB2Y3B1IHRocmVhZCB0aGF0IGhhcw0K
c3RvcHBlZCBjYXVzaW5nIHRoZSBxZW11IHByb2Nlc3MgdG8gZXhpdCwgIHFtcF9xdWVyeV9jcHVz
X2Zhc3QoKSBkb2VzIG5vdCANCmludGVycnVwdCB2Q1BVIHRocmVhZHMsIGJ1dCBtYXkgcmV0dXJu
IGludmFsaWQgdkNQVSBpbmZvcm1hdGlvbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBJZ29yIE1hbW1lZG92IFttYWlsdG86aW1hbW1lZG9AcmVkaGF0LmNvbV0NCj4g
U2VudDogV2VkbmVzZGF5LCBBcHJpbCAxMSwgMjAxOCA3OjQ2IFBNDQo+IFRvOiBsaW56aGVjaGVu
ZyA8bGluemhlY2hlbmdAaHVhd2VpLmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
eHV5YW5kb25nIDx4dXlhbmRvbmcyQGh1YXdlaS5jb20+Ow0KPiBwYm9uemluaUByZWRoYXQuY29t
OyB3YW5neGluIChVKSA8d2FuZ3hpbnhpbi53YW5nQGh1YXdlaS5jb20+Ow0KPiBydGhAdHdpZGRs
ZS5uZXQ7IGNyb3N0aHdhaXRlLnBldGVyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gY3B1OiBza2lwIHVucGx1Z2VkIGNwdSB3aGVuIHF1ZXJ5aW5nDQo+IGNw
dXMNCj4gDQo+IE9uIFdlZCwgMTEgQXByIDIwMTggMTk6MTY6MDIgKzA4MDANCj4gbGluemhlY2hl
bmcgPGxpbnpoZWNoZW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBYdVlhbmRv
bmcgPHh1eWFuZG9uZzJAaHVhd2VpLmNvbT4NCj4gPg0KPiA+IEFmdGVyIHZjcHUxIHRocmVhZCBl
eGl0aW5nLCB2Y3B1MCB0aHJlYWQgKHJlY2VpdmVkIG5vdGlmaWNhdGlvbikgaXMNCj4gPiBzdGls
bCB3YWl0aW5nIGZvciBob2xkaW5nIHFlbXVfZ2xvYmFsX211dGV4IGluIGNwdV9yZW1vdmVfc3lu
YywgYXQgdGhpcw0KPiBtb21lbnQsIHZjcHUxIGlzIHN0aWxsIGluIGdsb2JhbCBjcHVzIGxpc3Qu
DQo+ID4gSWYgbWFpbiB0aHJlYWQgZ3JhYiBxZW11X2dsb2JhbF9tdXRleCBpbiBvcmRlciB0byBo
YW5kbGUgcW1wIGNvbW1hbmQNCj4gPiAiaW5mbyBjcHVzIiwgcW1wX3F1ZXJ5X2NwdXMgdmlzaXQg
dW5wbHVnZWQgdmNwdTEgd2lsbCBsZWFkIHFlbXUgcHJvY2Vzcw0KPiB0byBleGl0Lg0KPiBBZGQg
aGVyZSBleGFjdCBlcnJvciBvciBiZXR0ZXIgc3RhY2sgdHJhY2UgaW4gY2FzZSBpdCBjcmFzaGVz
Lg0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWHVZYW5kb25nIDx4dXlhbmRvbmcyQGh1YXdl
aS5jb20+DQo+ID4gLS0tDQo+ID4gIGNwdXMuYyB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NwdXMuYyBiL2NwdXMu
Yw0KPiA+IGluZGV4IDJjYjBhZjkuLjliM2E2YzQgMTAwNjQ0DQo+ID4gLS0tIGEvY3B1cy5jDQo+
ID4gKysrIGIvY3B1cy5jDQo+ID4gQEAgLTIwMTgsNiArMjAxOCwxMSBAQCBDcHVJbmZvTGlzdCAq
cW1wX3F1ZXJ5X2NwdXMoRXJyb3IgKiplcnJwKQ0KPiA+DQo+ID4gICAgICBDUFVfRk9SRUFDSChj
cHUpIHsNCj4gPiAgICAgICAgICBDcHVJbmZvTGlzdCAqaW5mbzsNCj4gPiArDQo+ID4gKyAgICAg
ICAgaWYgKGNwdS0+dW5wbHVnKSB7DQo+ID4gKyAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsg
ICAgICAgIH0NCj4gU2hvdWxkbid0IGJlIGl0IGRvbmUgZm9yIHFtcF9xdWVyeV9jcHVzX2Zhc3Qo
KSBhcyB3ZWxsPw0KPiANCj4gPiArDQo+ID4gICNpZiBkZWZpbmVkKFRBUkdFVF9JMzg2KQ0KPiA+
ICAgICAgICAgIFg4NkNQVSAqeDg2X2NwdSA9IFg4Nl9DUFUoY3B1KTsNCj4gPiAgICAgICAgICBD
UFVYODZTdGF0ZSAqZW52ID0gJng4Nl9jcHUtPmVudjsNCg0K
