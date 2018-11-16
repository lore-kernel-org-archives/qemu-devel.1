Received: from eggs.gnu.org ([2001:4830:134:3::10]:36495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZMJ-0001XA-TB
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZMG-0007P7-27
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:20:11 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2294 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNZMF-0007MR-Kc
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:20:07 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Fri, 16 Nov 2018 08:19:55 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B43CC975C9@DGGEML532-MBX.china.huawei.com>
References: <cover.1542301855.git.xiezhide@huawei.com>
	<37e2a76b4020a5f9e48fe3b7c36d8e4bfb111569.1542301855.git.xiezhide@huawei.com>
	<df1afb51-f027-d5f8-d5e2-b9869cf104f7@redhat.com>
	<2d858252-f6ff-55d6-42f9-48aa56d5e294@redhat.com>
In-Reply-To: <2d858252-f6ff-55d6-42f9-48aa56d5e294@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/4] fsdev-throttle-qmp: move struct
 ThrottleLimits to new file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "berto@igalia.com" <berto@igalia.com>, "armbru@redhat.com" <armbru@redhat.com>, zengcanfu 00215970 <zengcanfu@huawei.com>, "groug@kaod.org" <groug@kaod.org>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, Jinxuefeng <jinxuefeng@huawei.com>, "Chenhui (Felix, Euler)" <chenhui.rtos@huawei.com>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86
ZWJsYWtlQHJlZGhhdC5jb21dIA0KU2VudDogMjAxOOW5tDEx5pyIMTbml6UgNjowMw0KVG86IHhp
ZXpoaWRlIDx4aWV6aGlkZUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpDYzog
YmVydG9AaWdhbGlhLmNvbTsgYXJtYnJ1QHJlZGhhdC5jb207IHplbmdjYW5mdSAwMDIxNTk3MCA8
emVuZ2NhbmZ1QGh1YXdlaS5jb20+OyBncm91Z0BrYW9kLm9yZzsgYW5lZXNoLmt1bWFyQGxpbnV4
LnZuZXQuaWJtLmNvbTsgSmlueHVlZmVuZyA8amlueHVlZmVuZ0BodWF3ZWkuY29tPjsgQ2hlbmh1
aSAoRmVsaXgsIEV1bGVyKSA8Y2hlbmh1aS5ydG9zQGh1YXdlaS5jb20+DQpTdWJqZWN0OiBSZTog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2NCAyLzRdIGZzZGV2LXRocm90dGxlLXFtcDogbW92ZSBzdHJ1
Y3QgVGhyb3R0bGVMaW1pdHMgdG8gbmV3IGZpbGUNCg0KT24gMTEvMTUvMTggMzo0MSBQTSwgRXJp
YyBCbGFrZSB3cm90ZToNCj4gT24gMTEvMTUvMTggMjo1NSBBTSwgeGllemhpZGUgd3JvdGU6DQo+
PiB0aGlzIHBhdGNoIG1vdmUgVGhyb3R0bGVMaW1pdHMgdG8gbmV3IGZpbGUgYW5kIHJlbmFtZSBz
dHJ1Y3QgZmllbGQgDQo+PiB3aXRoIGNvbW1vbiBmb3JtYXQNCj4gDQo+IEFzIHdyaXR0ZW4sIHlv
dSBuZWVkIHMvbW92ZS9tb3Zlcy8gYW5kIHMvcmVuYW1lL3JlbmFtZXMvIHRvIG1hdGNoIHRoZSAN
Cj4gc2luZ3VsYXIgYWN0b3IgJ3RoaXMgcGF0Y2gnLsKgIE9yLCBpZiB5b3Ugc3RpY2sgd2l0aCBt
eSBwcmVmZXJlbmNlIGZvciANCj4gaW1wZXJhdGl2ZSBzZW5zZSwgcy90aGlzIHBhdGNoIG1vdmUv
TW92ZS8NCj4gDQo+IHMvdG8gbmV3L3RvIGEgbmV3Lw0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiB4aWV6aGlkZSA8eGllemhpZGVAaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPiANCj4+ICsrKyBiL01h
a2VmaWxlDQo+PiBAQCAtMTA2LDYgKzEwNiw3IEBAIEdFTkVSQVRFRF9GSUxFUyArPSBxYXBpL3Fh
cGktdHlwZXMtc29ja2V0cy5oIA0KPj4gcWFwaS9xYXBpLXR5cGVzLXNvY2tldHMuYw0KPj4gwqAg
R0VORVJBVEVEX0ZJTEVTICs9IHFhcGkvcWFwaS10eXBlcy10cG0uaCBxYXBpL3FhcGktdHlwZXMt
dHBtLmMNCj4+IMKgIEdFTkVSQVRFRF9GSUxFUyArPSBxYXBpL3FhcGktdHlwZXMtdHJhY2UuaCBx
YXBpL3FhcGktdHlwZXMtdHJhY2UuYw0KPj4gwqAgR0VORVJBVEVEX0ZJTEVTICs9IHFhcGkvcWFw
aS10eXBlcy10cmFuc2FjdGlvbi5oIA0KPj4gcWFwaS9xYXBpLXR5cGVzLXRyYW5zYWN0aW9uLmMN
Cj4+ICtHRU5FUkFURURfRklMRVMgKz0gcWFwaS9xYXBpLXR5cGVzLXRsaW1pdHMuaCANCj4+ICtx
YXBpL3FhcGktdHlwZXMtdGxpbWl0cy5jDQo+IA0KPiB0bGltaXRzIGNvbWVzIGJlZm9yZSB0cG0s
IG5vdCBhZnRlciB0cmFuc2FjdGlvbi7CoCAoTXVsdGlwbGUgdGltZXMgaW4gDQo+IHRoaXMgZmls
ZSkNCg0KT3IsIGp1c3QgYXBwbHkgeW91ciBwYXRjaCBhZnRlciBtaW5lWzFdLCBmb3IgYSBtdWNo
IHNpbXBsZXIgdGFzayBvZiBpbnNlcnRpbmcgJ3RsaW1pdHMnIGluIHRoZSByaWdodCBwbGFjZSB3
aXRoaW4gUUFQSV9NT0RVTEVTLg0KDQpbMV0gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMTgtMTEvbXNnMDMwNzAuaHRtbA0KDQoNCkdyZWF0LCBpdCBtYWtl
cyB0aGUgdGFzayB2ZXJ5IHNpbXBsZS4gdGhhbmtzDQoNClRoYW5rcw0KS2lkZA0K
