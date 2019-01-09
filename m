Received: from eggs.gnu.org ([209.51.188.92]:45913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghIPo-0007M8-Fs
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghIJK-0004Q7-RI
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:10:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1ghIJK-0004Og-Lo
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:10:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09I3pBn141441
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 13:10:34 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn7pj8fy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 13:10:33 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 9 Jan 2019 18:10:33 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 9 Jan 2019 13:10:26 -0500
MIME-Version: 1.0
In-Reply-To: <bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <729790ec-a74a-2e6e-89ed-3d450c95f54f@linux.ibm.com>
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

T24gMS83LzE5IDI6MDIgUE0sIEphc29uIEouIEhlcm5lIHdyb3RlOg0KPj4+ICsNCj4+PiDC
oMKgLyoNCj4+PiDCoMKgwqAqwqBzZW5zZS1pZMKgcmVzcG9uc2XCoGJ1ZmZlcsKgbGF5b3V0
DQo+Pj4gwqDCoMKgKi8NCj4+PiBAQMKgLTIwNSw2wqArMjY1LDYxwqBAQMKgdHlwZWRlZsKg
c3RydWN0wqBzZW5zZWlkwqB7DQo+Pj4gwqDCoMKgwqDCoMKgc3RydWN0wqBjaXfCoGNpd1s2
Ml07DQo+Pj4gwqDCoH3CoMKgX19hdHRyaWJ1dGVfX8KgKChwYWNrZWQswqBhbGlnbmVkKDQp
KSnCoFNlbnNlSWQ7DQo+Pj4gKy8qwqBhcmNoaXRlY3RlZMKgdmFsdWVzwqBmb3LCoGZpcnN0
wqBzZW5zZcKgYnl0ZcKgKi8NCj4+PiArI2RlZmluZcKgU05TMF9DTURfUkVKRUNUwqDCoMKg
wqDCoMKgwqDCoMKgMHg4MA0KPj4+ICsjZGVmaW5lwqBTTlMwX0lOVEVSVkVOVElPTl9SRVHC
oMKgwqAweDQwDQo+Pj4gKyNkZWZpbmXCoFNOUzBfQlVTX09VVF9DSEVDS8KgwqDCoMKgwqDC
oDB4MjANCj4+PiArI2RlZmluZcKgU05TMF9FUVVJUE1FTlRfQ0hFQ0vCoMKgwqDCoDB4MTAN
Cj4+PiArI2RlZmluZcKgU05TMF9EQVRBX0NIRUNLwqDCoMKgwqDCoMKgwqDCoMKgMHgwOA0K
Pj4+ICsjZGVmaW5lwqBTTlMwX09WRVJSVU7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDA0
DQo+Pj4gKyNkZWZpbmXCoFNOUzBfSU5DT01QTF9ET01BSU7CoMKgwqDCoMKgMHgwMQ0KPj4N
Cj4+IElJUkMswqBvbmx5wqBieXRlwqAwwqBpc8KgZGV2aWNlwqBpbmRlcGVuZGVudCzCoGFu
ZMKgdGhlwqBvdGhlcnPCoGJlbG93wqBhcmUNCj4+IChFQ0tEKcKgZGFzZMKgc3BlY2lmaWM/
DQo+Pg0KPj4+ICsNCj4+PiArLyrCoGFyY2hpdGVjdHVyZWTCoHZhbHVlc8KgZm9ywqBzZWNv
bmTCoHNlbnNlwqBieXRlwqAqLw0KPj4+ICsjZGVmaW5lwqBTTlMxX1BFUk1fRVJSwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoDB4ODANCj4+PiArI2RlZmluZcKgU05TMV9JTlZfVFJBQ0tfRk9S
TUFUwqDCoMKgMHg0MA0KPj4+ICsjZGVmaW5lwqBTTlMxX0VPQ8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgMHgyMA0KPj4+ICsjZGVmaW5lwqBTTlMxX01FU1NBR0VfVE9fT1BF
UsKgwqDCoMKgMHgxMA0KPj4+ICsjZGVmaW5lwqBTTlMxX05PX1JFQ19GT1VORMKgwqDCoMKg
wqDCoMKgMHgwOA0KPj4+ICsjZGVmaW5lwqBTTlMxX0ZJTEVfUFJPVEVDVEVEwqDCoMKgwqDC
oDB4MDQNCj4+PiArI2RlZmluZcKgU05TMV9XUklURV9JTkhJQklURUTCoMKgwqDCoDB4MDIN
Cj4+PiArI2RlZmluZcKgU05TMV9JTlBSRUNJU0VfRU5EwqDCoMKgwqDCoMKgMHgwMQ0KPj4+
ICsNCj4+PiArLyrCoGFyY2hpdGVjdHVyZWTCoHZhbHVlc8KgZm9ywqB0aGlyZMKgc2Vuc2XC
oGJ5dGXCoCovDQo+Pj4gKyNkZWZpbmXCoFNOUzJfUkVRX0lOSF9XUklURcKgwqDCoMKgwqDC
oDB4ODANCj4+PiArI2RlZmluZcKgU05TMl9DT1JSRUNUQUJMRcKgwqDCoMKgwqDCoMKgwqAw
eDQwDQo+Pj4gKyNkZWZpbmXCoFNOUzJfRklSU1RfTE9HX0VSUsKgwqDCoMKgwqDCoDB4MjAN
Cj4+PiArI2RlZmluZcKgU05TMl9FTlZfREFUQV9QUkVTRU5UwqDCoMKgMHgxMA0KPj4+ICsj
ZGVmaW5lwqBTTlMyX0lOUFJFQ0lTRV9FTkTCoMKgwqDCoMKgwqAweDA0DQo+Pj4gKw0KPj4+
ICsvKsKgMjQtYnl0ZcKgU2Vuc2XCoGZtdC9tc2fCoGNvZGVzwqAqLw0KPj4+ICsjZGVmaW5l
wqBTRU5TRTI0X0ZNVF9QUk9HX1NZU8KgwqDCoMKgMHgwDQo+Pj4gKyNkZWZpbmXCoFNFTlNF
MjRfRk1UX0VRVUlQTUVOVMKgwqDCoDB4Mg0KPj4+ICsjZGVmaW5lwqBTRU5TRTI0X0ZNVF9D
T05UUk9MTEVSwqDCoDB4Mw0KPj4+ICsjZGVmaW5lwqBTRU5TRTI0X0ZNVF9NSVNDwqDCoMKg
wqDCoMKgwqDCoDB4Rg0KPj4+ICsNCj4+PiArI2RlZmluZcKgU0VOU0UyNF9GTVQwX01TR19S
RVNFVF9OT1RJRklDQVRJT07CoDB4MTYNCj4+PiArDQo+Pj4gKy8qwqBiYXNpY8Kgc2Vuc2XC
oHJlc3BvbnNlwqBidWZmZXLCoGxheW91dMKgKi8NCj4+PiArdHlwZWRlZsKgc3RydWN0wqBz
ZW5zZURhdGHCoHsNCj4+PiArwqDCoMKgwqB1aW50OF90wqBzdGF0dXNbM107DQo+Pj4gK8Kg
wqDCoMKgdWludDhfdMKgcmVzX2NvdW50Ow0KPj4+ICvCoMKgwqDCoHVpbnQ4X3TCoHBoeXNf
ZHJpdmVfaWQ7DQo+Pj4gK8KgwqDCoMKgdWludDhfdMKgbG93X2N5bF9hZGRyOw0KPj4+ICvC
oMKgwqDCoHVpbnQ4X3TCoGhlYWRfaGlnaF9jeWxfYWRkcjsNCj4+PiArwqDCoMKgwqB1aW50
OF90wqBmbXRfbXNnOw0KPj4+ICvCoMKgwqDCoHVpbnQ2NF90wqBmbXRfZGVwZW5kZW50X2lu
Zm9bMl07DQo+Pj4gK8KgwqDCoMKgdWludDhfdMKgcmVzZXJ2ZWQ7DQo+Pj4gK8KgwqDCoMKg
dWludDhfdMKgcHJvZ3JhbV9hY3Rpb25fY29kZTsNCj4+PiArwqDCoMKgwqB1aW50MTZfdMKg
Y29uZmlnX2luZm87DQo+Pj4gK8KgwqDCoMKgdWludDhfdMKgbWNvZGVfaGljeWw7DQo+Pj4g
K8KgwqDCoMKgdWludDhfdMKgY3lsX2hlYWRfYWRkclszXTsNCj4+PiArfcKgwqBfX2F0dHJp
YnV0ZV9fwqAoKHBhY2tlZCzCoGFsaWduZWQoNCkpKcKgU2Vuc2VEYXRhOw0KPj4NCj4+IEFu
ZMKgdGhpc8KgbG9va3MgX3JlYWxseV/CoGRhc2TCoHNwZWNpZmljLg0KPj4NCj4gDQo+IFll
cCwgSSBnbG9zc2VkIG92ZXIgdGhvc2UgZGV0YWlscyB3aGlsZSBJIHdhcyBmdXJpb3VzbHkg
dHJhY2tpbmcgZG93biB0aGUgcmVzZXQgYnVnLiBJJ2xsIA0KPiB0YWtlwqBhwqBsb29rwqBh
dMKgcmVkZXNpZ25pbmfCoHRoaXMuDQoNCkFsbCBvZiBteSBpbmZvcm1hdGlvbiBmb3IgY3Jl
YXRpbmcgdGhlc2UgZGF0YSBzdHJ1Y3R1cmVzIGNhbWUgZnJvbSBhbiBpbnRlcm5hbCBFQ0tE
IERBU0QgDQpyZWZlcmVuY2UuIFRoZXJlIGFyZSBwcm9iYWJseSBzb21lIHRoaW5ncyB0aGF0
IGNvdWxkIHN0YW5kIGEgYml0IG9mIGNsZWFudXAgb3IgcmVuYW1pbmcuIA0KQXNpZGUgZnJv
bSB0aGF0LCBjb25zaWRlcmluZyB0aGlzIGlzIGluIGEgREFTRCBvbmx5IChFQ0tEIERBU0Qg
b25seSBhdCB0aGUgbW9tZW50KSBjb2RlIA0KcGF0aCBhcmUgeW91IG9rYXkgd2l0aCBteSBy
ZW5hbWluZyB0aGUgc3RydWN0IHRvIHNlbnNlRGF0YUVDS0Qgb3Igc29tZXRoaW5nIHNpbWls
YXI/DQpJJ20gbm90IHN1cmUgd2hhdCB2YWx1ZSB0aGVyZSBpcyBpbiBhYnN0cmFjdGluZyBz
ZW5zZSBhdCB0aGUgbW9tZW50LiBJJ20gbm90IGV2ZW4gc3VyZSANCndoYXQgb3RoZXIgZGV2
aWNlJ3Mgc2Vuc2UgZGF0YSBsb29rcyBsaWtlLiBTaW5jZSBteSBkZXNjcmlwdGlvbiBvZiB0
aGUgU0VOU0UgQ0NXIGNvbWVzIA0KZnJvbSBhbiBFQ0tEIHJlZmVyZW5jZSBJIGhhdmUgbm90
IGJlZW4gYWJsZSB0byB2ZXJpZnkgYW55IGFyZWFzIG9mIHRoZSBkYXRhIHRoYXQgYXJlIA0K
Y29tbW9uIGFjcm9zcyBkZXZpY2UgdHlwZXMuIFRob3VnaHRzPw0KDQoNCi0tIA0KLS0gSmFz
b24gSi4gSGVybmUgKGpqaGVybmVAbGludXguaWJtLmNvbSkNCg0K
