Received: from eggs.gnu.org ([2001:4830:134:3::10]:57155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d3KS6-0005fn-Qv
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d3KS3-00057Q-OH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:45:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3911
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d3KS3-00056B-50
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:45:39 -0400
From: wangyunjian <wangyunjian@huawei.com>
Date: Wed, 26 Apr 2017 10:45:14 +0000
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60BB3BFFB@DGGEMA505-MBS.china.huawei.com>
References: <1493189156-14656-1-git-send-email-wangyunjian@huawei.com>
	<ff33adcb-3992-1cd8-346c-90224840d9c3@redhat.com>
In-Reply-To: <ff33adcb-3992-1cd8-346c-90224840d9c3@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-net: fix wild pointer when remove
 virtio-net queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: caihe <caihe@huawei.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86
amFzb3dhbmdAcmVkaGF0LmNvbV0gDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjYsIDIwMTcg
NToxOCBQTQ0KPiBUbzogd2FuZ3l1bmppYW4gPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+OyBtc3RA
cmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBjYWloZSA8Y2FpaGVAaHVh
d2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHZpcnRpby1uZXQ6
IGZpeCB3aWxkIHBvaW50ZXIgd2hlbiByZW1vdmUgdmlydGlvLW5ldCBxdWV1ZXMNCj4gDQo+IA0K
PiANCj4gT24gMjAxN+W5tDA05pyIMjbml6UgMTQ6NDUsIFl1bmppYW4gV2FuZyB3cm90ZToNCj4g
PiBUaGUgdHhfYmggb3IgdHhfdGltZXIgd2lsbCBmcmVlIGluIHZpcnRpb19uZXRfZGVsX3F1ZXVl
KCkgZnVuY3Rpb24sIA0KPiA+IHdoZW4gcmVtb3ZpbmcgdmlydGlvLW5ldCBxdWV1ZXMgaWYgdGhl
IGd1ZXN0IGRvZXNuJ3Qgc3VwcG9ydCANCj4gPiBtdWx0aXF1ZXVlLiBCdXQgaXQgbWlnaHQgYmUg
c3RpbGwgcmVmZXJlbmNlZCBieSANCj4gPiB2aXJ0aW9fbmV0X3NldF9zdGF0dXMoKSwgd2hpY2gg
bmVlZHMgdG8gYmUgc2V0IE5VTEwuIEFuZCBhbHNvIHRoZSANCj4gPiB0eF93YWl0aW5nIG5lZWRz
IHRvIGJlIHNldCB6ZXJvIHRvIHByZXZlbnQNCj4gPiB2aXJ0aW9fbmV0X3NldF9zdGF0dXMoKSBh
Y2Nlc3NpbmcgdHhfYmggb3IgdHhfdGltZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdW5q
aWFuIFdhbmcgPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBody9uZXQv
dmlydGlvLW5ldC5jIHwgMyArKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9uZXQvdmlydGlvLW5ldC5jIGIvaHcvbmV0L3Zp
cnRpby1uZXQuYyBpbmRleCANCj4gPiA3ZDA5MWM5Li45OGJkNjgzIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L25ldC92aXJ0aW8tbmV0LmMNCj4gPiArKysgYi9ody9uZXQvdmlydGlvLW5ldC5jDQo+ID4g
QEAgLTE1MjIsOSArMTUyMiwxMiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fbmV0X2RlbF9xdWV1ZShW
aXJ0SU9OZXQgKm4sIGludCBpbmRleCkNCj4gPiAgICAgICBpZiAocS0+dHhfdGltZXIpIHsNCj4g
PiAgICAgICAgICAgdGltZXJfZGVsKHEtPnR4X3RpbWVyKTsNCj4gPiAgICAgICAgICAgdGltZXJf
ZnJlZShxLT50eF90aW1lcik7DQo+ID4gKyAgICAgICAgcS0+dHhfdGltZXIgPSBOVUxMOw0KPiA+
ICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgIHFlbXVfYmhfZGVsZXRlKHEtPnR4X2JoKTsN
Cj4gPiArICAgICAgICBxLT50eF9iaCA9IE5VTEw7DQo+ID4gICAgICAgfQ0KPiA+ICsgICAgcS0+
dHhfd2FpdGluZyA9IDA7DQo+ID4gICAgICAgdmlydGlvX2RlbF9xdWV1ZSh2ZGV2LCBpbmRleCAq
IDIgKyAxKTsNCj4gPiAgIH0NCj4gPiAgIA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+
IA0KPiBJdCBsb29rcyB0byBtZSB0aGF0IGNsZWFyaW5nIHR4X3dhaXRpbmcgaXMgc3VmZmljaWVu
dCBvciBpcyB0aGVyZSBhbnkNCj4gb3RoZXIgcmVhc29uIHRoYXQgeW91bmVlZCBzZXQgdHhfdGlt
ZXIvdHhfYmggdG8gTlVMTD8NCg0KSXQncyBqdXN0IGNvZGluZyBoYWJpdCB0byBhdm9pZCBhY2Nl
c3Mgd2lsZCBwb2ludGVyLCBzdWNoIGFzDQp1c2VkLWFmdGVyLWZyZWUgcG9yYmxlbSwgaXQgaGFy
ZCB0byBsb2NhdGUgdGhlIGNvZGUgdGhhdCBjYXVzZSB0aGUgYnVnLg0KDQpUaGFua3MNCg0KPiAN
Cj4gVGhhbmtzDQoNCg==
