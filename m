Received: from eggs.gnu.org ([209.51.188.92]:44566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghK2k-00045P-Ka
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghK2j-0000FJ-Cu
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:01:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37194
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1ghK2j-0000CV-6s
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:01:37 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09JwvjN056117
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 15:01:28 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn4qq60e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 15:01:27 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 9 Jan 2019 20:01:25 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
	<729790ec-a74a-2e6e-89ed-3d450c95f54f@linux.ibm.com>
	<20190109193406.616fcf66.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 9 Jan 2019 15:01:19 -0500
MIME-Version: 1.0
In-Reply-To: <20190109193406.616fcf66.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <18c1ba75-84f6-e928-64a9-ccf5044d92b5@linux.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

T24gMS85LzE5IDE6MzQgUE0sIENvcm5lbGlhIEh1Y2sgd3JvdGU6DQo+IE9uIFdlZCwgOSBK
YW4gMjAxOSAxMzoxMDoyNiAtMDUwMA0KPiAiSmFzb24gSi4gSGVybmUiIDxqamhlcm5lQGxp
bnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDEvNy8xOSAyOjAyIFBNLCBKYXNvbiBK
LiBIZXJuZSB3cm90ZToNCj4+Pj4+ICsNCj4+Pj4+ICDCoMKgLyoNCj4+Pj4+ICDCoMKgwqAq
wqBzZW5zZS1pZMKgcmVzcG9uc2XCoGJ1ZmZlcsKgbGF5b3V0DQo+Pj4+PiAgwqDCoMKgKi8N
Cj4+Pj4+IEBAwqAtMjA1LDbCoCsyNjUsNjHCoEBAwqB0eXBlZGVmwqBzdHJ1Y3TCoHNlbnNl
aWTCoHsNCj4+Pj4+ICDCoMKgwqDCoMKgwqBzdHJ1Y3TCoGNpd8KgY2l3WzYyXTsNCj4+Pj4+
ICDCoMKgfcKgwqBfX2F0dHJpYnV0ZV9fwqAoKHBhY2tlZCzCoGFsaWduZWQoNCkpKcKgU2Vu
c2VJZDsNCj4+Pj4+ICsvKsKgYXJjaGl0ZWN0ZWTCoHZhbHVlc8KgZm9ywqBmaXJzdMKgc2Vu
c2XCoGJ5dGXCoCovDQo+Pj4+PiArI2RlZmluZcKgU05TMF9DTURfUkVKRUNUwqDCoMKgwqDC
oMKgwqDCoMKgMHg4MA0KPj4+Pj4gKyNkZWZpbmXCoFNOUzBfSU5URVJWRU5USU9OX1JFUcKg
wqDCoDB4NDANCj4+Pj4+ICsjZGVmaW5lwqBTTlMwX0JVU19PVVRfQ0hFQ0vCoMKgwqDCoMKg
wqAweDIwDQo+Pj4+PiArI2RlZmluZcKgU05TMF9FUVVJUE1FTlRfQ0hFQ0vCoMKgwqDCoDB4
MTANCj4+Pj4+ICsjZGVmaW5lwqBTTlMwX0RBVEFfQ0hFQ0vCoMKgwqDCoMKgwqDCoMKgwqAw
eDA4DQo+Pj4+PiArI2RlZmluZcKgU05TMF9PVkVSUlVOwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgMHgwNA0KPj4+Pj4gKyNkZWZpbmXCoFNOUzBfSU5DT01QTF9ET01BSU7CoMKgwqDCoMKg
MHgwMQ0KPj4+Pg0KPj4+PiBJSVJDLMKgb25secKgYnl0ZcKgMMKgaXPCoGRldmljZcKgaW5k
ZXBlbmRlbnQswqBhbmTCoHRoZcKgb3RoZXJzwqBiZWxvd8KgYXJlDQo+Pj4+IChFQ0tEKcKg
ZGFzZMKgc3BlY2lmaWM/DQo+Pj4+ICAgDQo+Pj4+PiArDQo+Pj4+PiArLyrCoGFyY2hpdGVj
dHVyZWTCoHZhbHVlc8KgZm9ywqBzZWNvbmTCoHNlbnNlwqBieXRlwqAqLw0KPj4+Pj4gKyNk
ZWZpbmXCoFNOUzFfUEVSTV9FUlLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHg4MA0KPj4+Pj4g
KyNkZWZpbmXCoFNOUzFfSU5WX1RSQUNLX0ZPUk1BVMKgwqDCoDB4NDANCj4+Pj4+ICsjZGVm
aW5lwqBTTlMxX0VPQ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgyMA0KPj4+
Pj4gKyNkZWZpbmXCoFNOUzFfTUVTU0FHRV9UT19PUEVSwqDCoMKgwqAweDEwDQo+Pj4+PiAr
I2RlZmluZcKgU05TMV9OT19SRUNfRk9VTkTCoMKgwqDCoMKgwqDCoDB4MDgNCj4+Pj4+ICsj
ZGVmaW5lwqBTTlMxX0ZJTEVfUFJPVEVDVEVEwqDCoMKgwqDCoDB4MDQNCj4+Pj4+ICsjZGVm
aW5lwqBTTlMxX1dSSVRFX0lOSElCSVRFRMKgwqDCoMKgMHgwMg0KPj4+Pj4gKyNkZWZpbmXC
oFNOUzFfSU5QUkVDSVNFX0VORMKgwqDCoMKgwqDCoDB4MDENCj4+Pj4+ICsNCj4+Pj4+ICsv
KsKgYXJjaGl0ZWN0dXJlZMKgdmFsdWVzwqBmb3LCoHRoaXJkwqBzZW5zZcKgYnl0ZcKgKi8N
Cj4+Pj4+ICsjZGVmaW5lwqBTTlMyX1JFUV9JTkhfV1JJVEXCoMKgwqDCoMKgwqAweDgwDQo+
Pj4+PiArI2RlZmluZcKgU05TMl9DT1JSRUNUQUJMRcKgwqDCoMKgwqDCoMKgwqAweDQwDQo+
Pj4+PiArI2RlZmluZcKgU05TMl9GSVJTVF9MT0dfRVJSwqDCoMKgwqDCoMKgMHgyMA0KPj4+
Pj4gKyNkZWZpbmXCoFNOUzJfRU5WX0RBVEFfUFJFU0VOVMKgwqDCoDB4MTANCj4+Pj4+ICsj
ZGVmaW5lwqBTTlMyX0lOUFJFQ0lTRV9FTkTCoMKgwqDCoMKgwqAweDA0DQo+Pj4+PiArDQo+
Pj4+PiArLyrCoDI0LWJ5dGXCoFNlbnNlwqBmbXQvbXNnwqBjb2Rlc8KgKi8NCj4+Pj4+ICsj
ZGVmaW5lwqBTRU5TRTI0X0ZNVF9QUk9HX1NZU8KgwqDCoMKgMHgwDQo+Pj4+PiArI2RlZmlu
ZcKgU0VOU0UyNF9GTVRfRVFVSVBNRU5UwqDCoMKgMHgyDQo+Pj4+PiArI2RlZmluZcKgU0VO
U0UyNF9GTVRfQ09OVFJPTExFUsKgwqAweDMNCj4+Pj4+ICsjZGVmaW5lwqBTRU5TRTI0X0ZN
VF9NSVNDwqDCoMKgwqDCoMKgwqDCoDB4Rg0KPj4+Pj4gKw0KPj4+Pj4gKyNkZWZpbmXCoFNF
TlNFMjRfRk1UMF9NU0dfUkVTRVRfTk9USUZJQ0FUSU9OwqAweDE2DQo+Pj4+PiArDQo+Pj4+
PiArLyrCoGJhc2ljwqBzZW5zZcKgcmVzcG9uc2XCoGJ1ZmZlcsKgbGF5b3V0wqAqLw0KPj4+
Pj4gK3R5cGVkZWbCoHN0cnVjdMKgc2Vuc2VEYXRhwqB7DQo+Pj4+PiArwqDCoMKgwqB1aW50
OF90wqBzdGF0dXNbM107DQo+Pj4+PiArwqDCoMKgwqB1aW50OF90wqByZXNfY291bnQ7DQo+
Pj4+PiArwqDCoMKgwqB1aW50OF90wqBwaHlzX2RyaXZlX2lkOw0KPj4+Pj4gK8KgwqDCoMKg
dWludDhfdMKgbG93X2N5bF9hZGRyOw0KPj4+Pj4gK8KgwqDCoMKgdWludDhfdMKgaGVhZF9o
aWdoX2N5bF9hZGRyOw0KPj4+Pj4gK8KgwqDCoMKgdWludDhfdMKgZm10X21zZzsNCj4+Pj4+
ICvCoMKgwqDCoHVpbnQ2NF90wqBmbXRfZGVwZW5kZW50X2luZm9bMl07DQo+Pj4+PiArwqDC
oMKgwqB1aW50OF90wqByZXNlcnZlZDsNCj4+Pj4+ICvCoMKgwqDCoHVpbnQ4X3TCoHByb2dy
YW1fYWN0aW9uX2NvZGU7DQo+Pj4+PiArwqDCoMKgwqB1aW50MTZfdMKgY29uZmlnX2luZm87
DQo+Pj4+PiArwqDCoMKgwqB1aW50OF90wqBtY29kZV9oaWN5bDsNCj4+Pj4+ICvCoMKgwqDC
oHVpbnQ4X3TCoGN5bF9oZWFkX2FkZHJbM107DQo+Pj4+PiArfcKgwqBfX2F0dHJpYnV0ZV9f
wqAoKHBhY2tlZCzCoGFsaWduZWQoNCkpKcKgU2Vuc2VEYXRhOw0KPj4+Pg0KPj4+PiBBbmTC
oHRoaXPCoGxvb2tzIF9yZWFsbHlfwqBkYXNkwqBzcGVjaWZpYy4NCj4+Pj4gICANCj4+Pg0K
Pj4+IFllcCwgSSBnbG9zc2VkIG92ZXIgdGhvc2UgZGV0YWlscyB3aGlsZSBJIHdhcyBmdXJp
b3VzbHkgdHJhY2tpbmcgZG93biB0aGUgcmVzZXQgYnVnLiBJJ2xsDQo+Pj4gdGFrZcKgYcKg
bG9va8KgYXTCoHJlZGVzaWduaW5nwqB0aGlzLg0KPj4NCj4+IEFsbCBvZiBteSBpbmZvcm1h
dGlvbiBmb3IgY3JlYXRpbmcgdGhlc2UgZGF0YSBzdHJ1Y3R1cmVzIGNhbWUgZnJvbSBhbiBp
bnRlcm5hbCBFQ0tEIERBU0QNCj4+IHJlZmVyZW5jZS4gVGhlcmUgYXJlIHByb2JhYmx5IHNv
bWUgdGhpbmdzIHRoYXQgY291bGQgc3RhbmQgYSBiaXQgb2YgY2xlYW51cCBvciByZW5hbWlu
Zy4NCj4+IEFzaWRlIGZyb20gdGhhdCwgY29uc2lkZXJpbmcgdGhpcyBpcyBpbiBhIERBU0Qg
b25seSAoRUNLRCBEQVNEIG9ubHkgYXQgdGhlIG1vbWVudCkgY29kZQ0KPj4gcGF0aCBhcmUg
eW91IG9rYXkgd2l0aCBteSByZW5hbWluZyB0aGUgc3RydWN0IHRvIHNlbnNlRGF0YUVDS0Qg
b3Igc29tZXRoaW5nIHNpbWlsYXI/DQo+IA0KPiBSZW5hbWluZyB0aGlzIG1ha2VzIHNlbnNl
Lg0KPiANCj4+IEknbSBub3Qgc3VyZSB3aGF0IHZhbHVlIHRoZXJlIGlzIGluIGFic3RyYWN0
aW5nIHNlbnNlIGF0IHRoZSBtb21lbnQuIEknbSBub3QgZXZlbiBzdXJlDQo+PiB3aGF0IG90
aGVyIGRldmljZSdzIHNlbnNlIGRhdGEgbG9va3MgbGlrZS4gU2luY2UgbXkgZGVzY3JpcHRp
b24gb2YgdGhlIFNFTlNFIENDVyBjb21lcw0KPj4gZnJvbSBhbiBFQ0tEIHJlZmVyZW5jZSBJ
IGhhdmUgbm90IGJlZW4gYWJsZSB0byB2ZXJpZnkgYW55IGFyZWFzIG9mIHRoZSBkYXRhIHRo
YXQgYXJlDQo+PiBjb21tb24gYWNyb3NzIGRldmljZSB0eXBlcy4gVGhvdWdodHM/DQo+IA0K
PiBUaGVyZSdzIFNBMjItNzIwNC0wMSAoIkNvbW1vbiBJL08gRGV2aWNlIENvbW1hbmRzIiks
IHdoaWNoIGlzIGZyb20gMTk5Mg0KPiAodGhpcyBpcyB3aGF0IEkgaGF2ZSBvbiBteSBkaXNr
IC0tIGlzIHRoZXJlIGFueXRoaW5nIG5ld2VyPykuIEl0DQo+IHNwZWNpZmllcyB3aGF0IGJp
dHMgMC01IG9mIGJ5dGUgMCBtZWFuIGFuZCBzdGF0ZXMgdGhhdCBieXRlcyAxLTMxIGFyZQ0K
PiBvcHRpb25hbCBhbmQgZGV2aWNlLXNwZWNpZmljLg0KPiANCj4gTWF5YmUgc29tZSBvdGhl
ciBiaXRzIGhhdmUgYmVlbiBzcGVjaWZpZWQgYWZ0ZXIgMTk5MiwgYnV0IEkgaGF2ZSBub3QN
Cj4gY29tZSBhY3Jvc3MgZG9jdW1lbnRhdGlvbiBmb3IgdGhlbS4NCg0KVGhhdCBwdWJsaWNh
dGlvbiBpcyBubyBsb25nZXIgYXZhaWxhYmxlLiBBY2NvcmRpbmcgdG8gbXkgcXVpY2sgcmVz
ZWFyY2ggaXQgaGFzIGJlZW4gDQpyZXBsYWNlZCBieSBhbiBpbnRlcm5hbCBvbmx5IHB1Ymxp
Y2F0aW9uLiBJJ2xsIHNlZSB3aGF0IEkgY2FuIGZpbmQuDQoNCg0KLS0gDQotLSBKYXNvbiBK
LiBIZXJuZSAoampoZXJuZUBsaW51eC5pYm0uY29tKQ0KDQo=
