Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXjBz-00078E-44
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXjBx-0004tR-VZ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:51:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Dec 2018 08:51:12 +0000
Message-ID: <9c2119e3-d471-a770-852b-04d2103a40d4@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
	<20181211164317.32893-5-vsementsov@virtuozzo.com>
	<af0ed3b1-bb0e-3575-0e3a-7097cd75b621@redhat.com>
In-Reply-To: <af0ed3b1-bb0e-3575-0e3a-7097cd75b621@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <68C86425760F134789683458A5E1D21B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/8] qcow2-threads: split out generic
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

MTQuMTIuMjAxOCAyOjI4LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiBPbiAxMS8xMi8xOCAxNzo0
MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+ICsgICAgVGhyZWFkUG9v
bCAqcG9vbCA9IGFpb19nZXRfdGhyZWFkX3Bvb2woYmRydl9nZXRfYWlvX2NvbnRleHQoYnMpKTsN
Cj4+ICsNCj4+ICsgICAgd2hpbGUgKHMtPm5iX3RocmVhZHMgPj0gUUNPVzJfTUFYX1RIUkVBRFMp
IHsNCj4+ICsgICAgICAgIHFlbXVfY29fcXVldWVfd2FpdCgmcy0+dGhyZWFkX3Rhc2tfcXVldWUs
IE5VTEwpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHMtPm5iX3RocmVhZHMrKzsNCj4+ICsg
ICAgcmV0ID0gdGhyZWFkX3Bvb2xfc3VibWl0X2NvKHBvb2wsIGZ1bmMsIGFyZyk7DQo+PiArICAg
IHMtPm5iX3RocmVhZHMtLTsNCj4+ICsNCj4+ICsgICAgcWVtdV9jb19xdWV1ZV9uZXh0KCZzLT50
aHJlYWRfdGFza19xdWV1ZSk7DQo+IA0KPiBXaGF0IGxvY2sgaXMgcHJvdGVjdGluZyB0aGlzIG1h
bmlwdWxhdGlvbj8gIEknZCByYXRoZXIgYXZvaWQgYWRkaW5nIG1vcmUNCj4gdXNlcnMgb2YgdGhl
IEFpb0NvbnRleHQgbG9jaywgZXNwZWNpYWxseSBtYW5pcHVsYXRpb24gb2YgQ29RdWV1ZXMuDQo+
IA0KPiBPbmUgcG9zc2liaWxpdHkgaXMgdG8gZG8gdGhlIHMtPmxvY2sgdW5sb2NrL2xvY2sgaGVy
ZSwgYW5kIHRoZW4gYWxzbw0KPiByZWx5IG9uIHRoYXQgaW4gcGF0Y2ggOC4NCj4gDQo+IFBhb2xv
DQo+IA0KDQpIbSwgY2FuIHlvdSBwbGVhc2UgZ2l2ZSBtb3JlIGRldGFpbHM/IEl0J3MgcmVmYWN0
b3JpbmcgY29tbWl0LCBzbywgZG8geW91IG1lYW4NCnRoYXQgdGhlcmUgaXMgYW4gZXhpc3Rpbmcg
YnVnPyBXZSBhcmUgaW4gY29yb3V0aW5lLCBzbywgaXQncyBub3Qgc2FmZSB0byBjYWxsDQpxZW11
X2NvX3F1ZXVlX25leHQ/DQoNCkkgZmVlbCwgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBmdXR1cmUg
d2l0aG91dCBBaW9Db250ZXh0IGxvY2ssIGFuZCBob3cgaXQgaW5mbHVlbmNlDQpjb250ZXh0cy90
aHJlYWRzL2Nvcm91dGluZXMuLiBTbywgZnJvbSB0aGlzIGNvbnRleHQsIHMtPnRocmVhZF90YXNr
X3F1ZXVlIG1heSBiZQ0KYWNjZXNzZWQgZnJvbSBvdGhlciB0aHJlYWQsIHdoZW4gd2UgYXJlIGhl
cmUsIGFuZCBjYWxsaW5nIHFlbXVfY29fcXVldWVfbmV4dCBmcm9tDQpvdXIgYWlvIGNvbnRleHQ/
IEJ1dCBmcm9tIHdoZXJlPyAvU29ycnkgZm9yIG1heSBiZSBzdHVwaWQgcXVlc3Rpb25zLw0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
