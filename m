Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA5C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A96206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A96206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO284-0005rz-5M
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:35:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hO240-0003Ng-C0
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hO23z-00052W-8C
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:31:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hO23z-000514-01
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:31:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x47FTbkp092574
	for <qemu-devel@nongnu.org>; Tue, 7 May 2019 11:31:23 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sb9uu0327-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 11:31:23 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Tue, 7 May 2019 16:31:22 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 7 May 2019 16:31:19 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x47FVHSS27000846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 7 May 2019 15:31:17 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0713AAE068;
	Tue,  7 May 2019 15:31:17 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03EAAE062;
	Tue,  7 May 2019 15:31:16 +0000 (GMT)
Received: from [9.80.218.140] (unknown [9.80.218.140])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2019 15:31:16 +0000 (GMT)
To: pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190507081251.24307-1-cohuck@redhat.com>
	<ee335c4c-468a-3e70-fe7e-02d0d77ef9d1@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 7 May 2019 11:31:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ee335c4c-468a-3e70-fe7e-02d0d77ef9d1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19050715-0040-0000-0000-000004EC6339
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01199927; UDB=6.00629556;
	IPR=6.00980810; 
	MB=3.00026771; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-07 15:31:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050715-0041-0000-0000-000008F86BF3
Message-Id: <42ffdd81-7bbd-1a46-c4f9-3771ea26a84b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-07_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905070100
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-001b2d01.pphosted.com id
	x47FTbkp092574
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH RFC v2] s390/css: handle CCW_FLAG_SKIP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDUvNy8xOSA1OjA4IEFNLCBQaWVycmUgTW9yZWwgd3JvdGU6DQo+IE9uIDA3LzA1
LzIwMTkgMTA6MTIsIENvcm5lbGlhIEh1Y2sgd3JvdGU6DQo+PiBJZiBhIGNjdyBoYXMgQ0NX
X0ZMQUdfU0tJUCBzZXQsIGFuZCB0aGUgY29tbWFuZCBpcyBvZiB0eXBlDQo+PiByZWFkLCBy
ZWFkIGJhY2t3YXJkcywgb3Igc2Vuc2UsIG5vIGRhdGEgc2hvdWxkIGJlIHdyaXR0ZW4NCj4+
IHRvIHRoZSBndWVzdCBmb3IgdGhhdCBjb21tYW5kLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPg0KPj4gLS0tDQo+Pg0KPj4gdjEg
LT4gdjI6IGZpeGVkIGNoZWNrcyBmb3IgY29tbWFuZCB0eXBlIFtFcmljXQ0KPj4NCj4+IFN0
aWxsIG9ubHkgbGlnaHRseSB0ZXN0ZWQgKGl0IGJvb3RzKTsgSSBkb24ndCB0aGluayBJIGhh
dmUgYSB0b29sDQo+PiBnZW5lcmF0aW5nIGNoYW5uZWwgcHJvZ3JhbXMgd2l0aCB0aGUgc2tp
cCBmbGFnIGhhbmR5Lg0KDQpGV0lXLCBteSB0ZXN0IHByb2dyYW0gaGl0cyB0aGlzIGNvZGUg
b25jZSAocmVhZCBvZiBhIHNpbmdsZSBwYWdlLCB3aXRoIA0KU0xJIGFuZCBTS0lQIGZsYWdz
IHNldCkgYmVmb3JlIGdldHRpbmcgaW50byB0aGUgcGFzc3Rocm91Z2ggY29kZXBhdGguDQoN
Cj4+DQo+PiAtLS0NCj4+IMKgIGh3L3MzOTB4L2Nzcy5jwqDCoMKgwqDCoMKgwqDCoCB8IDIy
ICsrKysrKysrKysrKysrKysrKy0tLS0NCj4+IMKgIGluY2x1ZGUvaHcvczM5MHgvY3NzLmgg
fMKgIDEgKw0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9zMzkweC9jc3MuYyBiL2h3L3Mz
OTB4L2Nzcy5jDQo+PiBpbmRleCA4ZmM5ZTM1YmE1ZDMuLjA4MGFjN2U1YmMwYiAxMDA2NDQN
Cj4+IC0tLSBhL2h3L3MzOTB4L2Nzcy5jDQo+PiArKysgYi9ody9zMzkweC9jc3MuYw0KPj4g
QEAgLTgzMCw4ICs4MzAsMTIgQEAgc3RhdGljIGludCBjY3dfZHN0cmVhbV9yd19ub2ZsYWdz
KENjd0RhdGFTdHJlYW0gDQo+PiAqY2RzLCB2b2lkICpidWZmLCBpbnQgbGVuLA0KPj4gwqDC
oMKgwqDCoCBpZiAob3AgPT0gQ0RTX09QX0EpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIGluY3I7DQo+PiDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAgcmV0ID0gYWRkcmVzc19z
cGFjZV9ydygmYWRkcmVzc19zcGFjZV9tZW1vcnksIGNkcy0+Y2RhLA0KPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTUVNVFhBVFRS
U19VTlNQRUNJRklFRCwgYnVmZiwgbGVuLCBvcCk7DQo+PiArwqDCoMKgIGlmICghY2RzLT5k
b19za2lwKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gYWRkcmVzc19zcGFjZV9ydygm
YWRkcmVzc19zcGFjZV9tZW1vcnksIGNkcy0+Y2RhLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNRU1UWEFUVFJT
X1VOU1BFQ0lGSUVELCBidWZmLCBsZW4sIG9wKTsNCj4+ICvCoMKgwqAgfSBlbHNlIHsNCj4+
ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAwOw0KPj4gK8KgwqDCoCB9DQo+PiDCoMKgwqDCoMKg
IGlmIChyZXQgIT0gTUVNVFhfT0spIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjZHMtPmZs
YWdzIHw9IENEU19GX1NUUkVBTV9CUk9LRU47DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FSU5WQUw7DQo+PiBAQCAtOTI4LDggKzkzMiwxMyBAQCBzdGF0aWMgaW50IGNjd19k
c3RyZWFtX3J3X2lkYShDY3dEYXRhU3RyZWFtICpjZHMsIA0KPj4gdm9pZCAqYnVmZiwgaW50
IGxlbiwNCj4+IMKgwqDCoMKgwqAgZG8gew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGl0ZXJf
bGVuID0gTUlOKGxlbiwgY29udF9sZWZ0KTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
b3AgIT0gQ0RTX09QX0EpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGFk
ZHJlc3Nfc3BhY2VfcncoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBjZHMtPmNkYSwNCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBidWZmLCANCj4+IGl0ZXJf
bGVuLCBvcCk7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWNkcy0+ZG9fc2tp
cCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBhZGRyZXNz
X3NwYWNlX3J3KCZhZGRyZXNzX3NwYWNlX21lbW9yeSwgY2RzLT5jZGEsDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBidWZmLCANCj4+IGl0
ZXJfbGVuLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3ApOw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0ID0gMDsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgIT0gTUVNVFhfT0spIHsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogYXNzdW1lIGluYWNjZXNzaWJsZSBh
ZGRyZXNzICovDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IC1FSU5WQUw7IC8qIGNoYW5uZWwgcHJvZ3JhbSBjaGVjayAqLw0KPj4gQEAgLTk2OCw2ICs5
NzcsMTEgQEAgdm9pZCBjY3dfZHN0cmVhbV9pbml0KENjd0RhdGFTdHJlYW0gKmNkcywgQ0NX
MSANCj4+IGNvbnN0ICpjY3csIE9SQiBjb25zdCAqb3JiKQ0KPj4gwqDCoMKgwqDCoCBjZHMt
PmNvdW50ID0gY2N3LT5jb3VudDsNCj4+IMKgwqDCoMKgwqAgY2RzLT5jZGFfb3JpZyA9IGNj
dy0+Y2RhOw0KPj4gK8KgwqDCoCAvKiBza2lwIGlzIG9ubHkgZWZmZWN0aXZlIGZvciByZWFk
LCByZWFkIGJhY2t3YXJkcywgb3Igc2Vuc2UgDQo+PiBjb21tYW5kcyAqLw0KPj4gK8KgwqDC
oCBjZHMtPmRvX3NraXAgPSAoY2N3LT5mbGFncyAmIENDV19GTEFHX1NLSVApICYmDQo+PiAr
wqDCoMKgwqDCoMKgwqAgKChjY3ctPmNtZF9jb2RlICYgQ0NXX0NNRF9CQVNJQ19TRU5TRSkg
PT0gQ0NXX0NNRF9CQVNJQ19TRU5TRSB8fA0KPj4gK8KgwqDCoMKgwqDCoMKgwqAgKGNjdy0+
Y21kX2NvZGUgJiAweDAyKSA9PSAweDAyIC8qIHJlYWQgKi8gfHwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgIChjY3ctPmNtZF9jb2RlICYgMHgwYykgPT0gMHgwYyAvKiByZWFkIGJhY2t3YXJk
cyAqLyk7DQo+IA0KPiBJIHRoaW5rIHlvdSBzaG91bGQgdXNlIG1hc2tzIGxpa2UNCj4gKChj
b2RlICYgMHgzKSA9PSAyKSA9PiBSRUFEDQo+ICgoY29kZSAmIDB4ZikgPT0gMHhjKSA9PiBS
RUFEIEJBQ0tXQVJEDQo+ICgoY29kZSAmIDB4ZikgPT0gMHg0KSA9PiBTRU5TRQ0KDQpJIHRo
aW5rIFBpZXJyZSBpcyByaWdodC4gIEluIHRoZSB2MiBjb2RlLCBhIGNvbnRyb2wgQ0NXIChs
aWtlIE5PUCkgd291bGQgDQpzdGlsbCBiZSBmbGFnZ2VkIGFzIGEgUkVBRC4NCg0KPiANCj4g
UmVnYXJkcywNCj4gUGllcnJlDQo+IA0KPiANCj4gDQo+IA0KPj4gwqDCoMKgwqDCoCBjY3df
ZHN0cmVhbV9yZXdpbmQoY2RzKTsNCj4+IMKgwqDCoMKgwqAgaWYgKCEoY2RzLT5mbGFncyAm
IENEU19GX0lEQSkpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjZHMtPm9wX2hhbmRsZXIg
PSBjY3dfZHN0cmVhbV9yd19ub2ZsYWdzOw0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
czM5MHgvY3NzLmggYi9pbmNsdWRlL2h3L3MzOTB4L2Nzcy5oDQo+PiBpbmRleCBhYWUxOWM0
MjcyMjkuLjdjYzE4M2VmNDM2NiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvczM5MHgv
Y3NzLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvczM5MHgvY3NzLmgNCj4+IEBAIC05Nyw2ICs5
Nyw3IEBAIHR5cGVkZWYgc3RydWN0IENjd0RhdGFTdHJlYW0gew0KPj4gwqDCoMKgwqDCoCBp
bnQgKCpvcF9oYW5kbGVyKShzdHJ1Y3QgQ2N3RGF0YVN0cmVhbSAqY2RzLCB2b2lkICpidWZm
LCBpbnQgbGVuLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBDY3dEYXRhU3RyZWFtT3Agb3ApOw0KPj4gwqDCoMKgwqDCoCBod2FkZHIgY2Rh
Ow0KPj4gK8KgwqDCoCBib29sIGRvX3NraXA7DQo+PiDCoCB9IENjd0RhdGFTdHJlYW07DQo+
PiDCoCAvKg0KPj4NCj4gDQo+IA0KDQo=

