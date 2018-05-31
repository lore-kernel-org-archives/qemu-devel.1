Received: from eggs.gnu.org ([2001:4830:134:3::10]:34446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fORNj-00084U-77
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fORNf-0000j7-6a
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:28:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fORNe-0000hz-Ui
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:28:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4VHSdrX088511
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:28:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jakr54kjm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:28:53 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 31 May 2018 13:28:51 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 31 May 2018 13:28:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <10f6e1a1-ad16-9877-4b71-14b9cc46a58f@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] [PATCH] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

UGxlYXNlIGFwcGx5IHRoZSBmb2xsb3dpbmcgY29tbWl0IHRvIFFFTVUgMi4xMjoNCg0KDQpj
b21taXQgNzY0N2Q1YzZiNWUzYjNmMzZhNmUwNDQxYzgxYWUzZmU3OTdlYjIzMw0KQXV0aG9y
OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCkRh
dGU6wqDCoCBUdWUgTWF5IDggMTE6Mjk6MzUgMjAxOCAtMDQwMA0KDQogwqDCoMKgIHRlc3Rz
OiBmaXggdHBtLWNyYiB0cG0tdGlzIHRlc3RzIHJhY2UNCg0KIMKgwqDCoCBObyBuZWVkIHRv
IGNsb3NlIHRoZSBUUE0gZGF0YSBzb2NrZXQgb24gdGhlIGVtdWxhdG9yIGVuZCwgcWVtdSB3
aWxsDQogwqDCoMKgIGNsb3NlIGl0IGFmdGVyIGEgU0hVVERPV04uIFRoaXMgYXZvaWRzIGEg
cmFjZSBiZXR3ZWVuIGNsb3NlKCkgYW5kDQogwqDCoMKgIHJlYWQoKSBpbiB0aGUgVFBNIGRh
dGEgdGhyZWFkLg0KDQogwqDCoMKgIFJlcG9ydGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+DQogwqDCoMKgIFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5k
csOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KIMKgwqDCoCBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbT4N
CiDCoMKgwqAgUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJl
ZGhhdC5jb20+DQogwqDCoMKgIFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgVG9rYXJldiA8bWp0
QHRscy5tc2sucnU+DQoNCmRpZmYgLS1naXQgYS90ZXN0cy90cG0tZW11LmMgYi90ZXN0cy90
cG0tZW11LmMNCmluZGV4IDRkYWRhNzY4MzQuLjhjMmJkNTNjYWQgMTAwNjQ0DQotLS0gYS90
ZXN0cy90cG0tZW11LmMNCisrKyBiL3Rlc3RzL3RwbS1lbXUuYw0KQEAgLTEyNSw3ICsxMjUs
NyBAQCB2b2lkICp0cG1fZW11X2N0cmxfdGhyZWFkKHZvaWQgKmRhdGEpDQogwqDCoMKgwqDC
oMKgwqDCoCBjYXNlIENNRF9TSFVURE9XTjogew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwdG1fcmVzIHJlcyA9IDA7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFpb19jaGFu
bmVsX3dyaXRlKGlvYywgKGNoYXIgKikmcmVzLCBzaXplb2YocmVzKSwgDQomZXJyb3JfYWJv
cnQpOw0KLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWlvX2NoYW5uZWxfY2xvc2Uocy0+dHBt
X2lvYywgJmVycm9yX2Fib3J0KTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHRoZSB0
cG0gZGF0YSB0aHJlYWQgaXMgZXhwZWN0ZWQgdG8gZmluaXNoIG5vdyAqLw0KIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnX3RocmVhZF9qb2luKHMtPmVtdV90cG1fdGhyZWFkKTsNCiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQogwqDCoMKgwqDCoMKgwqDCoCB9DQoN
Cg==
