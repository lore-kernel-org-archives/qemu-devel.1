Received: from eggs.gnu.org ([2001:4830:134:3::10]:58723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f0Qpn-00064S-8z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f0Qpi-0006l2-ES
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:02:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60232
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f0Qpi-0006kt-9I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:02:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2QBxnHD131810
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 08:02:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gy07y8svn-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 08:02:32 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 26 Mar 2018 13:01:45 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 14:01:39 +0200
MIME-Version: 1.0
In-Reply-To: <ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <bc9bf25d-6bf2-67ec-539b-8a0220f5f1b5@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

DQoNCk9uIDAzLzI2LzIwMTggMTE6MDMgQU0sIFBpZXJyZSBNb3JlbCB3cm90ZToNCj4+PiAr
aW50wqBhcF9kZXZpY2VfaGFuZGxlX3BxYXAoUzM5MENQVcKgKmNwdSkNCj4+PiArew0KPj4+
ICvCoMKgwqDCoENQVVMzOTBYU3RhdGXCoCplbnbCoD3CoCZjcHUtPmVudjsNCj4+PiArwqDC
oMKgwqBpbnTCoGZjwqA9wqA0wqAmwqAoZW52LT5yZWdzWzBdwqA+PsKgMjQpOw0KPj4+ICsN
Cj4+PiArwqDCoMKgwqAvKg0KPj4+ICvCoMKgwqDCoMKgKsKgVGhlwqBRdWVyecKgQ29uZmln
dXJhdGlvbsKgSW5mb3JtYXRpb27CoChRQ0kpwqBmdW5jdGlvbsKgKGZjwqA9PcKgNCnCoGRv
ZXPCoG5vdA0KPj4+ICvCoMKgwqDCoMKgKsKgc2V0wqBhwqByZXNwb25zZcKgY29kZcKgaW7C
oHJlZ8KgMSzCoHNvwqBjaGVja8KgZm9ywqB0aGF0wqBhbG9uZ8Kgd2l0aMKgdGhlDQo+Pj4g
K8KgwqDCoMKgwqAqwqBBUMKgZmVhdHVyZS4NCj4+PiArwqDCoMKgwqDCoCovDQo+Pj4gK8Kg
wqDCoMKgaWbCoCgoZmPCoCE9wqA0KcKgJibCoHMzOTBfaGFzX2ZlYXQoUzM5MF9GRUFUX0FQ
KSnCoHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoGVudi0+cmVnc1sxXcKgPcKgMHgxMDAwMDsN
Cj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqByZXR1cm7CoDA7DQo+Pj4gK8KgwqDCoMKg
fQ0KPj4gVGhpc8Kgd291bGTCoGltcGx5wqBhbsKgb3BlcmF0aW9uwqBleGNlcHRpb27CoGlu
wqBjYXNlwqBmYz09NCzCoHdoaWNowqBzb3VuZHPCoHZlcnkNCj4+IHdyb25nLg0KDQpZZXMs
IG9wZXJhdGlvbiBleGNlcHRpb24gaXMgYSB3cm9uZyByZXNwb25zZSB1bmRlciB0aGUgY29u
ZGl0aW9uDQooZmMgPT0gNCkgJiYgczM5MF9oYXNfZmVhdChTMzkwX0ZFQVRfQVApLg0KDQpA
RGF2aWQ6DQpGWUkgVG9ueSBpcyBsaWtlbHkgdG8gcmVzcG9uZCBhZnRlciBXZWRuZXNkYXkg
YXMgaGUgaXMgb24gdmFjYXRpb24gcmlnaHQNCm5vdy4NCg0KPiANCj4gSXQgZGVwZW5kcyBi
dXQgSSB0aGluayB0aGF0IHRoZSBTMzkwX0ZFQVRfQVBfUVVFUllfQ09ORklHX0lORk8gbXVz
dCBiZSB0ZXN0ZWQNCj4gdG/CoGtub3fCoHdoYXTCoHRvwqBhbnN3ZXIuDQo+IElmwqB0aGXC
oGZlYXR1cmXCoGlzwqB0aGVyZSzCoFFDScKgbXVzdMKgYmXCoGFuc3dlcmVkwqBjb3JyZWN0
bHkuDQo+IA0KPiB0aGVyZcKgYXJlwqBhbHNvwqBzb21lwqBlcnJvcsKgc2l0dWF0aW9uc8Kg
dG/CoGhhbmRsZcKgaW7CoGFsbMKgdGhyZWXCoGZ1bmN0aW9ucy4NCj4NCg0KSSBhZ3JlZS4g
DQogDQpSZWdhcmRzLA0KSGFsaWwNCg0K
