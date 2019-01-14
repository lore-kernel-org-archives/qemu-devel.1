Received: from eggs.gnu.org ([209.51.188.92]:37618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gj7EW-00031L-Dz
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gj7EV-0004GI-HF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:45:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gj7EV-0004Fx-5l
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:45:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0EIj6wb146262
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:45:10 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q0t9kt51f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:45:08 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 14 Jan 2019 18:44:16 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
Date: Mon, 14 Jan 2019 13:44:12 -0500
MIME-Version: 1.0
In-Reply-To: <bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <81fc43ea-f141-1c76-d217-6c1880ece901@linux.ibm.com>
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

T24gMS83LzE5IDI6MDIgUE0sIEphc29uIEouIEhlcm5lIHdyb3RlOg0KPj4+IEBAwqAtMTkw
LDbCoCsyNDcsOcKgQEDCoHN0cnVjdMKgY2l3wqB7DQo+Pj4gwqDCoMKgwqDCoMKgX191MTbC
oGNvdW50Ow0KPj4+IMKgwqB9Ow0KPj4+ICsjZGVmaW5lwqBDVV9UWVBFX1ZJUlRJT8KgwqDC
oMKgwqDCoMKgwqDCoMKgMHgzODMyDQo+Pj4gKyNkZWZpbmXCoENVX1RZUEVfREFTRMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDB4Mzk5MA0KPj4NCj4+IE5vwqBvdGhlcsKgZGFzZMKgdHlw
ZXPCoHdlwqB3YW50wqB0b8Kgc3VwcG9ydD8gOinCoChOb3TCoHN1cmXCoGlmwqBvdGhlcnPC
oGFyZcKgb3V0DQo+PiBpbsKgdGhlwqB3aWxkLsKgTWF5YmXCoEZCQT8pDQo+Pg0KPiANCj4g
SSBoYXZlIG5vIGlkZWEuIEkgYXNzdW1lZCAzMzkwIHdhcyB0aGUgb25seSB0aGluZyB3ZSBz
dXBwb3J0ZWQuIFBlcmhhcHMgMzM4MD8gSSdkIG5lZWQgdG8gDQo+IGZpbmTCoGHCoHRlc3TC
oGRldmljZSzCoHdoaWNowqBJwqBjb3VsZMKgcHJvYmFibHnCoGRvwqAuLi7CoEknbGzCoGxv
b2vCoG1vcmXCoGludG/CoHRoaXMuDQoNCkFmdGVyIGEgZmV3IGRpc2N1c3Npb25zIHdpdGgg
Zm9sa3MgaW4gdGhlIGxhYiB3ZSd2ZSBkZWNpZGVkIHRoYXQgd2UgZG9uJ3Qgc2VlIGEgdG9u
IG9mIA0KdmFsdWUgaW4gc3VwcG9ydGluZyBhbnl0aGluZyBvdGhlciB0aGFuIDM5OTAgYXQg
dGhlIG1vbWVudC4gQW55dGhpbmcgZWxzZSB3b3VsZCBiZSBvbGRlciANCigzMzgwKSBhbmQv
b3IgcmFyZSB0byBzZWUgaW4gdGhlIHdpbGQgKGFuZCB2ZXJ5IGRpZmZpY3VsdCB0byB0ZXN0
KS4gQXMgZm9yIGVtdWxhdGVkIHNldHVwcyANCmxpa2Ugei9WTSwgYSB1c2VyIGNhbiBqdXN0
IHVzZSAzMzkwIGluc3RlYWQgb2YgRkJBLiBTbyBJIHJlY29tbWVuZCB3ZSBtb3ZlIGZvcndh
cmQgd2l0aCANCjMzOTAvMzk5MCBzdXBwb3J0IGZvciBub3cuIFdlIGNhbiBhbHdheXMgYWRk
IGluIG90aGVycyB0eXBlcyBpZi93aGVuIHdlIG5lZWQgdGhlbS4NCg0KLS0gDQotLSBKYXNv
biBKLiBIZXJuZSAoampoZXJuZUBsaW51eC5pYm0uY29tKQ0KDQo=
