Received: from eggs.gnu.org ([2001:4830:134:3::10]:38842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dv4qs-0003ln-To
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dv4qo-0000kR-KH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:01:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55412
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dv4qo-0000jW-99
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:01:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LGsCoi085795
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 13:01:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4f62751c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 13:01:17 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 18:01:15 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-4-pasic@linux.vnet.ibm.com>
	<de7b0939-df06-333f-28ce-cd9d3fe58eb2@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 19:01:12 +0200
MIME-Version: 1.0
In-Reply-To: <de7b0939-df06-333f-28ce-cd9d3fe58eb2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <f276a79a-9fc7-551a-7148-8c9e8b821e82@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v3 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

DQoNCk9uIDA5LzIxLzIwMTcgMTE6NDQgQU0sIFBpZXJyZSBNb3JlbCB3cm90ZToNCj4gT24g
MTkvMDkvMjAxNyAyMDoyNywgSGFsaWwgUGFzaWMgd3JvdGU6DQo+PiBSZXBsYWNlIGRpcmVj
dCBhY2Nlc3Mgd2hpY2ggaW1wbGljaXRseSBhc3N1bWVzIG5vIElEQQ0KPj4gb3IgTUlEQSB3
aXRoIHRoZSBuZXcgY2N3IGRhdGEgc3RyZWFtIGludGVyZmFjZSB3aGljaCBzaG91bGQNCj4+
IGNvcGUgd2l0aCB0aGVzZSB0cmFuc3BhcmVudGx5IGluIHRoZSBmdXR1cmUuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogSGFsaWwgUGFzaWMgPHBhc2ljQGxpbnV4LnZuZXQuaWJtLmNvbT4N
Cj4+IFJldmlld2VkLWJ5OiBQaWVycmUgTW9yZWw8cG1vcmVsQGxpbnV4LnZuZXQuaWJtLmNv
bT4NCj4+IC0tLQ0KPj4gwqAgaHcvczM5MHgvdmlydGlvLWNjdy5jIHwgMTU3ICsrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTExIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody9zMzkweC92aXJ0aW8tY2N3LmMgYi9ody9zMzkweC92aXJ0aW8t
Y2N3LmMNCj4+IGluZGV4IGIxOTc2ZmRkMTkuLmQwMjRmOGIyZDMgMTAwNjQ0DQo+PiAtLS0g
YS9ody9zMzkweC92aXJ0aW8tY2N3LmMNCj4+ICsrKyBiL2h3L3MzOTB4L3ZpcnRpby1jY3cu
Yw0KPj4gQEAgLTI4Nyw0OSArMjg3LDE5IEBAIHN0YXRpYyBpbnQgdmlydGlvX2Njd19oYW5k
bGVfc2V0X3ZxKFN1YmNoRGV2ICpzY2gsIENDVzEgY2N3LCBib29sIGNoZWNrX2xlbiwNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVGQVVMVDsNCj4+IMKgwqDCoMKgwqAgfQ0K
Pj4gwqDCoMKgwqDCoCBpZiAoaXNfbGVnYWN5KSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAgbGlu
Zm8ucXVldWUgPSBhZGRyZXNzX3NwYWNlX2xkcV9iZSgmYWRkcmVzc19zcGFjZV9tZW1vcnks
IGNjdy5jZGEsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1FTVRYQVRU
UlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIGxpbmZvLmFsaWdu
ID0gYWRkcmVzc19zcGFjZV9sZGxfYmUoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0KPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjY3cuY2RhICsgc2l6ZW9mKGxpbmZvLnF1
ZXVlKSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTUVNVFhBVFRSU19V
TlNQRUNJRklFRCwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCk7
DQo+PiAtwqDCoMKgwqDCoMKgwqAgbGluZm8uaW5kZXggPSBhZGRyZXNzX3NwYWNlX2xkdXdf
YmUoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNjdy5jZGEgKyBzaXplb2YobGluZm8ucXVldWUpDQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKyBzaXplb2YobGluZm8uYWxpZ24pLA0KPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQs
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCk7DQo+PiAtwqDC
oMKgwqDCoMKgwqAgbGluZm8ubnVtID0gYWRkcmVzc19zcGFjZV9sZHV3X2JlKCZhZGRyZXNz
X3NwYWNlX21lbW9yeSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNjdy5j
ZGEgKyBzaXplb2YobGluZm8ucXVldWUpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCArIHNpemVvZihsaW5mby5hbGlnbikNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICsgc2l6ZW9mKGxpbmZvLmluZGV4KSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsDQo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBOVUxMKTsNCj4gDQo+IEhlcmUgYWdhaW4sIEkgb3ZlcnNhdyB0aGlz
Lg0KPiBTb3JyeS4NCj4gDQo+PiArwqDCoMKgwqDCoMKgwqAgY2N3X2RzdHJlYW1fcmVhZCgm
c2NoLT5jZHMsIGxpbmZvKTsNCj4gDQo+IFNhbWUgYXMgZm9yIHBhdGNoIDIvNToNCj4gU2hv
dWxkbid0IHlvdSB0ZXN0IHRoZSByZXR1cm4gdmFsdWUgaGVyZT8NCj4gDQoNCkl0J3Mga2Vl
cCB0aGUgY2hhbmdlIG1pbmltYWwgcG9saWN5LiBMYXRlciB3ZSBjYW4gZGlzY3Vzcw0KdGln
aHRlbmluZyB0aGUgY2hlY2tzLiBGb3Igbm93IEkgZG9uJ3Qgd2FudCB0byBpbnRyb2R1Y2UN
CmFueSBuZXcgb25lcy4NCg0KSGFsaWwNCg0K
