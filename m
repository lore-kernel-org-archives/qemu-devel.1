Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duxuf-0000ax-EE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duxua-0001r9-D5
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:36:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duxua-0001p5-40
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:36:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L9ZekW099404
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:36:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d48b586v5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:36:46 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 10:36:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v8L9ag3u22347972
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 09:36:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40E4AE04D
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 10:31:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E16AE051
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 10:31:33 +0100 (BST)
Received: from [9.145.23.132] (unknown [9.145.23.132])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 10:31:33 +0100 (BST)
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-3-pasic@linux.vnet.ibm.com>
	<2bb5705f-eba3-2630-2e57-99242b9abd2a@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:36:42 +0200
MIME-Version: 1.0
In-Reply-To: <2bb5705f-eba3-2630-2e57-99242b9abd2a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <2d1e2604-e983-3a86-6e90-9b0647e5cb9a@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 2/5] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

T24gMjEvMDkvMjAxNyAxMTozMywgUGllcnJlIE1vcmVsIHdyb3RlOg0KPiBPbiAwNS8wOS8y
MDE3IDEzOjE2LCBIYWxpbCBQYXNpYyB3cm90ZToNCj4+IFJlcGxhY2UgZGlyZWN0IGFjY2Vz
cyB3aGljaCBpbXBsaWNpdGx5IGFzc3VtZXMgbm8gSURBDQo+PiBvciBNSURBIHdpdGggdGhl
IG5ldyBjY3cgZGF0YSBzdHJlYW0gaW50ZXJmYWNlIHdoaWNoIHNob3VsZA0KPj4gY29wZSB3
aXRoIHRoZXNlIHRyYW5zcGFyZW50bHkgaW4gdGhlIGZ1dHVyZS4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBIYWxpbCBQYXNpYyA8cGFzaWNAbGludXgudm5ldC5pYm0uY29tPg0KPj4gLS0t
DQo+PiDCoCBody9zMzkweC9jc3MuYyB8IDUgKysrLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L3MzOTB4L2Nzcy5jIGIvaHcvczM5MHgvY3NzLmMNCj4+IGluZGV4IDg3ZDkxM2Y4MWMu
LmMxYmM5OTQ0ZTYgMTAwNjQ0DQo+PiAtLS0gYS9ody9zMzkweC9jc3MuYw0KPj4gKysrIGIv
aHcvczM5MHgvY3NzLmMNCj4+IEBAIC04OTAsNiArODkwLDcgQEAgc3RhdGljIGludCBjc3Nf
aW50ZXJwcmV0X2NjdyhTdWJjaERldiAqc2NoLCBod2FkZHIgDQo+PiBjY3dfYWRkciwNCj4+
IMKgwqDCoMKgwqAgfQ0KPj4NCj4+IMKgwqDCoMKgwqAgLyogTG9vayBhdCB0aGUgY29tbWFu
ZC4gKi8NCj4+ICvCoMKgwqAgY2N3X2RzdHJlYW1faW5pdCgmc2NoLT5jZHMsICZjY3csICYo
c2NoLT5vcmIpKTsNCj4+IMKgwqDCoMKgwqAgc3dpdGNoIChjY3cuY21kX2NvZGUpIHsNCj4+
IMKgwqDCoMKgwqAgY2FzZSBDQ1dfQ01EX05PT1A6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogTm90aGluZyB0byBkby4gKi8NCj4+IEBAIC05MDMsNyArOTA0LDcgQEAgc3RhdGljIGlu
dCBjc3NfaW50ZXJwcmV0X2NjdyhTdWJjaERldiAqc2NoLCBod2FkZHIgDQo+PiBjY3dfYWRk
ciwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbGVuID0gTUlOKGNjdy5jb3VudCwgc2l6
ZW9mKHNjaC0+c2Vuc2VfZGF0YSkpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIGNwdV9waHlzaWNh
bF9tZW1vcnlfd3JpdGUoY2N3LmNkYSwgc2NoLT5zZW5zZV9kYXRhLCBsZW4pOw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGNjd19kc3RyZWFtX3dyaXRlX2J1Zigmc2NoLT5jZHMsIHNjaC0+c2Vu
c2VfZGF0YSwgbGVuKTsNCj4gDQo+IERvbid0IHlvdSBuZWVkIHRvIGNoZWNrIHRoZSByZXR1
cm4gdmFsdWUgPw0KPiANCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzY2gtPmN1cnJfc3RhdHVz
LnNjc3cuY291bnQgPSBjY3cuY291bnQgLSBsZW47DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
bWVtc2V0KHNjaC0+c2Vuc2VfZGF0YSwgMCwgc2l6ZW9mKHNjaC0+c2Vuc2VfZGF0YSkpOw0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IDA7DQo+PiBAQCAtOTMwLDcgKzkzMSw3IEBA
IHN0YXRpYyBpbnQgY3NzX2ludGVycHJldF9jY3coU3ViY2hEZXYgKnNjaCwgaHdhZGRyIA0K
Pj4gY2N3X2FkZHIsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbnNlX2lkLnJlc2VydmVkID0gMDsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB9DQo+PiAtwqDCoMKgwqDCoMKgwqAgY3B1X3BoeXNpY2FsX21lbW9y
eV93cml0ZShjY3cuY2RhLCAmc2Vuc2VfaWQsIGxlbik7DQo+PiArwqDCoMKgwqDCoMKgwqAg
Y2N3X2RzdHJlYW1fd3JpdGVfYnVmKCZzY2gtPmNkcywgJnNlbnNlX2lkLCBsZW4pOw0KPiAN
Cj4gaGVyZSB0b28gPw0KPiANCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzY2gtPmN1cnJfc3Rh
dHVzLnNjc3cuY291bnQgPSBjY3cuY291bnQgLSBsZW47DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0ID0gMDsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+DQo+IA0KPiAN
CkZvcmdldCBpdCBJIHRvb2sgdGhlIHdyb25nIHNlcmllLg0KU29ycnkNCg0KDQotLSANClBp
ZXJyZSBNb3JlbA0KTGludXgvS1ZNL1FFTVUgaW4gQsO2YmxpbmdlbiAtIEdlcm1hbnkNCg0K
