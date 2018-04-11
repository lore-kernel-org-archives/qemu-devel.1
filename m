Received: from eggs.gnu.org ([2001:4830:134:3::10]:33594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f6G8z-0000PV-G5
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f6G8w-0005Tc-BW
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:50:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57754
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f6G8w-0005TR-6C
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:50:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3BDkQtZ052333
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 09:50:33 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h9gj9h0de-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 09:50:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 11 Apr 2018 14:50:13 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<3cb8a831-325e-2e1a-3dae-30864df27a75@linux.vnet.ibm.com>
	<20180409113244.380a32c4.cohuck@redhat.com>
	<1b0c08f8-c98c-c79c-574f-5c75229decf4@linux.vnet.ibm.com>
	<20180409125104.1103d650.cohuck@redhat.com>
	<ab2f7f24-2c97-943e-ca36-cc2561ef9119@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 15:50:07 +0200
MIME-Version: 1.0
In-Reply-To: <ab2f7f24-2c97-943e-ca36-cc2561ef9119@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <067a35b6-3eeb-313b-b4ed-685078953f0b@linux.vnet.ibm.com>
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
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, eskultet@redhat.com, David Hildenbrand <david@redhat.com>, peter.maydell@linaro.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

DQoNCk9uIDA0LzExLzIwMTggMDM6MjAgUE0sIFRvbnkgS3Jvd2lhayB3cm90ZToNCj4+Pj4g
ScKgbWF5wqBiZcKgYWxswqB3cm9uZyzCoHRob3VnaC4uLsKgY2FuwqB3ZcKgYXTCoGxlYXN0
wqBoYXZlwqBhwqB0cmFuc2xhdGlvbsKgb2YNCj4+Pj4gRUNBLjI4wqBhbmTCoEVFQ0EuMjjC
oCh0aGXCoCJhcMKgaXPCoHRoZXJlIsKgYml0wqBhbmTCoHRoZcKgImFwwqBpbnN0cnVjdGlv
bnPCoGFyZQ0KPj4+PiBpbnRlcnByZXRlZCLCoGJpdD8pDQo+Pj4+IMKgwqAgDQo+Pj4gScKg
dGhpbmvCoHdlwqBoYXZlwqBhwqBtaXN1bmRlcnN0YW5kaW5nwqBoZXJlLsKgScKgd2lsbMKg
d2FpdMKgZm9ywqBUb255LsKgTWF5YmUNCj4+PiBoZcKgY2FuwqB1bmRlcnN0YW5kwqB0aGlz
wqBiZXR0ZXLCoG9ywqBleHBsYWluwqBpbsKgbW9yZcKgYWNjZXNzaWJsZcKgd2F5Lg0KPj4g
wqBGcm9twqB3aGF0wqBJwqBnZXTCoGZyb23CoHlvdXLCoGV4cGxhbmF0aW9uLMKgdGhpc8Kg
YXBwcm9hY2jCoHNvdW5kc8KgbGlrZcKgYcKgZ29vZA0KPj4gd2F5wqBmb3J3YXJkLsKgQnV0
wqBsZXQnc8Kgd2FpdMKgZm9ywqBUb255Lg0KPiANCj4gScKgYWdyZWUswqB0aGlzwqBzb2x2
ZXPCoHRoZcKgcHJvYmxlbcKgd2l0aMKgc3BlY2lmeWluZ8KgaW5zdGFsbGluZ8KgQVDCoGZh
Y2lsaXRpZXMNCj4gb27CoHRoZcKgZ3Vlc3TCoCgtY3B1wqB4eHgsYXA9b24pwqBhbmTCoG5v
dMKgY29uZmlndXJpbmfCoGHCoHZmaW8tYXDCoGRldmljZQ0KPiAoLWRldmljZcKgdmZpby1h
cCxzeXNmc2Rldj0kcGF0aC10by1tZWRpYXRlZC1kZXZpY2UpLg0KPiANCj4gVG/CoHJlY2Fw
Og0KPiBUaGXCoHJlYWxpemUoKcKgZnVuY3Rpb27CoGZvcsKgdGhlwqB2ZmlvLWFwwqBkZXZp
Y2XCoG9wZW5zwqB0aGXCoG1lZGlhdGVkwqBtYXRyaXgNCj4gZGV2aWNlwqBmaWxlwqBkZXNj
cmlwdG9ywqB0b8Kgc2V0wqB1cMKgdGhlwqBjb21tdW5pY2F0aW9uwqBwYXRod2F5wqB3aXRo
wqB0aGXCoHZmaW9fYXANCj4ga2VybmVsIGRyaXZlci4gV2hlbiB0aGUgZmQgaXMgb3BlbmVk
LCB0aGUgdmZpb19hcCBkcml2ZXIgc2V0cyBFQ0EuMjggZm9yIHRoZQ0KPiBndWVzdMKgdG/C
oGluc3RydWN0wqBTSUXCoHRvwqBpbnRlcnByZXTCoEFQwqBpbnN0cnVjdGlvbnMuwqBUaGXC
oGRyaXZlcsKgYWxzbw0KPiBjb25maWd1cmVzIHRoZSBBUCBtYXRyaXggZm9yIHRoZSBndWVz
dCBpbiBpdHMgU0lFIHN0YXRlIGRlc2NyaXB0aW9uLiBDb25zZXF1ZW50bHksDQo+IGlmwqBh
wqB2ZmlvLWFwwqBkZXZpY2XCoGlzwqBub3TCoGNvbmZpZ3VyZWTCoGZvcsKgdGhlwqBndWVz
dCzCoGJ1dMKgQVDCoGZhY2lsaXRpZXPCoGFyZQ0KPiBpbnN0YWxsZWQsIGFsbCBBUCBpbnN0
cnVjdGlvbnMgd2lsbCBiZSBpbnRlcmNlcHRlZCBhbmQgcm91dGVkIHRvIFFFTVUuIElmwqB0
aGVyZQ0KPiBhcmUgbm8gaW50ZXJjZXB0aW9uIGhhbmRsZXJzIGZvciB0aGUgQVAgaW5zdHJ1
Y3Rpb25zLCBRRU1VIGluamVjdHMgYW4gb3BlcmF0aW9uDQo+IGV4Y2VwdGlvbiBpbnRvIHRo
ZSBndWVzdC4gVGhpcyByZXN1bHRzIGluIGluaXRpYWxpemF0aW9uIG9mIHRoZSBBUCBidXMg
b27CoHRoZQ0KPiBndWVzdMKgdG/CoHRlcm1pbmF0ZS7CoFRoaXPCoHBhdGNowqB3YXPCoGlu
dGVuZGVkwqB0b8KgY2lyY3VtdmVudMKgdGhhdMKgcHJvYmxlbS4NCj4gDQo+IFdpdGggSGFs
aWwncyBzdWdnZXN0aW9uLCB0aGVyZSBpcyBubyBuZWVkIHRvIHByb3ZpZGUgdGhlc2UgaGFu
ZGxlcnMuIElmIEVDQS4yOA0KPiBpcyBzZXQgZm9yIHRoZSBndWVzdCBieSBkZWZhdWx0IHdo
ZW4gdGhlIEFQIGZhY2lsaXRpZXMgYXJlIGluc3RhbGxlZCwgdGhlbsKgdGhlwqBBUA0KPiBp
bnN0cnVjdGlvbnPCoHdpbGzCoGJlwqBpbnRlcnByZXRlZMKgYW5kwqB0aGXCoEFQwqBidXPC
oHdpbGzCoGdldMKgaW5pdGlhbGl6ZWTCoG9uwqB0aGUNCj4gZ3Vlc3QuIFNpbmNlIHRoZXJl
IGlzIG5vIHZmaW8tYXAgZGV2aWNlIHRvIHByb3ZpZGUgdGhlIEFQIG1hdHJpeCBjb25maWd1
cmF0aW9uDQo+IGZvcsKgdGhlwqBndWVzdCzCoHRoZcKgQVDCoGJ1c8Kgd2lsbMKgbm90wqBk
ZXRlY3TCoGFuecKgZGV2aWNlcyzCoGJ1dMKgdGhhdCdzwqBva2F5LsKgQVANCj4gaW5zdHJ1
Y3Rpb25zIHRhcmdldGluZyBhdCBhbiBBUFFOIHdpbGwgZXhlY3V0ZSBzdWNjZXNzZnVsbHkg
YW5kIHNldCBhIHJlc3BvbnNlDQo+IGNvZGXCoGluwqB0aGXCoHN0YXR1c8KgYmxvY2vCoHJl
dHVybmVkwqBmcm9twqB0aGXCoGluc3RydWN0aW9uwqBpbmRpY2F0aW5nwqB0aGUNCj4gQVBR
TsKgaXPCoGludmFsaWTCoC4uLi7CoGJ1dMKgdGhlcmXCoHdpbGzCoGJlwqBub8KgZXhjZXB0
aW9uwqB1bmxlc3PCoHRoZXJlwqBpc8KgdHJ1bHkNCj4gYW7CoGV4Y2VwdGlvbsKgY29uZGl0
aW9uwqBjYXVzZWTCoGJ5wqB0aGXCoGV4ZWN1dGlvbsKgb2bCoHRoZcKgaW5zdHJ1Y3Rpb24u
DQoNClRoYXQncyBleGFjdGx5IHRoZSBpZGVhLCBidXQgaXQgd2lsbCBvbmx5IHdvcmsgb3V0
IHRoaXMgd2F5IGlmIHRoZSBlZmZlY3RpdmUNCkVDQS4yOCBiaXQgKGkuZS4gRUVDQS4yOCkg
aXMgYWxzbyBzZXQuDQoNCkNvdWxkIHlvdSBwbGVhc2UgY29tbWVudCB0aGUgZmlyc3QgcGFy
YWdyYXBoIHF1b3RlZCBpbiB0aGlzIGVtYWlsPw0KDQpIYWxpbA0KDQo=
