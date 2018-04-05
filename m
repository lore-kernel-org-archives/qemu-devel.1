Received: from eggs.gnu.org ([2001:4830:134:3::10]:33571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f48WQ-0001MY-OP
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f48WN-0007zr-Gv
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:18:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f48WN-0007zd-8h
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:17:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35HFbbl115271
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 13:17:57 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5ms5j8m2-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 13:17:57 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 5 Apr 2018 18:17:54 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 19:17:47 +0200
MIME-Version: 1.0
In-Reply-To: <dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <ee3b89cf-c260-361f-3eb6-71371bbe827f@linux.vnet.ibm.com>
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

DQoNCk9uIDA0LzA1LzIwMTggMDY6MzggUE0sIFRvbnkgS3Jvd2lhayB3cm90ZToNCj4+IEhh
cmTCoHRvwqByZWFsbHnCoGdpdmXCoGdvb2TCoGFkdmljZcKgd2l0aG91dMKgYWNjZXNzwqB0
b8KgdGhlwqBkb2N1bWVudGF0aW9uLMKgYnV0Og0KPj4gLcKgSWbCoHdlwqB0ZWxswqB0aGXC
oGd1ZXN0wqB0aGF0wqB0aGXCoGZlYXR1cmXCoGlzwqBhdmFpbGFibGUswqBidXTCoGl0wqBk
b2VzwqBub3QNCj4+IMKgwqDCoGdldMKgYW55wqBjYXJkc8KgdG/CoHVzZSzCoHJldHVybmlu
Z8KgYW7CoGVtcHR5wqBtYXRyaXjCoG1ha2VzwqB0aGXCoG1vc3TCoHNlbnNlDQo+PiDCoMKg
wqB0b8KgbWUuDQo+PiAtwqBJwqB3b3VsZMKgbm90wqB0aWXCoHN0YXJ0aW5nwqB0aGXCoGd1
ZXN0wqB0b8KgdGhlwqBwcmVzZW5jZcKgb2bCoGHCoHZmaW8tYXANCj4+IMKgwqDCoGRldmlj
ZS7CoEhhdmluZ8KgdGhlwqBmZWF0dXJlwqBhdmFpbGFibGXCoGluwqB0aGVvcnnCoGJ1dMKg
d2l0aG91dMKgYW55DQo+PiDCoMKgwqBkZXZpY2VzwqBhY3R1YWxsecKgYmVpbmfCoHVzYWJs
ZcKgYnnCoHRoZcKgZ3Vlc3TCoGRvZXPCoG5vdMKgcmVhbGx5wqBzb3VuZA0KPj4gwqDCoMKg
d3JvbmfCoChjYW7CoHdlwqBob3RwbHVnwqB0aGlzwqBsYXRlcj8pDQo+IEZvciB0aGlzIHBo
YXNlIG9mIGRldmVsb3BtZW50LCBpdCBpcyBteSBvcGluaW9uIHRoYXQgaW50cm9kdWNpbmcg
QVAgaW5zdHJ1Y3Rpb24NCj4gaW50ZXJjZXB0aW9uwqBoYW5kbGVyc8KgaXPCoHN1cGVyZmx1
b3VzwqBmb3LCoHRoZcKgZm9sbG93aW5nwqByZWFzb25zOg0KPiANCj4gMS4gSW50ZXJjZXB0
aW9uIGhhbmRsaW5nIHdhcyBpbnRyb2R1Y2VkIHNvbGVseSB0byBlbnN1cmUgYW4gb3BlcmF0
aW9uIGV4Y2VwdGlvbsKgd291bGQNCj4gwqDCoCBub3QgYmUgaW5qZWN0ZWQgaW50byB0aGUg
Z3Vlc3Qgd2hlbiBDUFUgbW9kZWwgZmVhdHVyZSBmb3IgQVAgKGkuZS4sIGFwPW9uKQ0KPiDC
oMKgIGlzIHNwZWNpZmllZCBidXQgYSBWRklPIEFQIGRldmljZSAoaS5lLiwgLWRldmljZSB2
ZmlvLWFwLHN5c2ZzZGV2PSRwYXRoKQ0KPiDCoMKgwqBpc8Kgbm90Lg0KPiANCj4gMi4gVGhl
IGltcGxlbWVudGF0aW9uIG9mIGd1ZXN0IGRlZGljYXRlZCBjcnlwdG8gYWRhcHRlcnMgdXNl
cyBBUCBpbnN0cnVjdGlvbg0KPiDCoMKgwqBpbnRlcnByZXRhdGlvbsKgdG/CoHZpcnR1YWxp
emXCoEFQwqBkZXZpY2VzwqBmb3LCoGHCoGd1ZXN0LsKgQXPCoHN1Y2gswqB0aGXCoE5RQVAs
DQo+IMKgwqDCoERRQVDCoGFuZMKgbW9zdMKgdmFyaWFudHPCoG9mwqB0aGXCoFBRQVDCoGlu
c3RydWN0aW9uc8Kgd2lsbMKgbm90wqBiZQ0KPiDCoMKgwqBpbnRlcmNlcHRlZC4NCj4gDQo+
IDMuIEhvdCBwbHVnZ2luZyBBUCBkZXZpY2VzIGlzIG5vdCBiZWluZyBzdXBwb3J0ZWQgZm9y
IHRoaXMgcGhhc2Ugb2YgZGV2ZWxvcG1lbnQuDQo+IA0KPiBJdCBpcyBteSBvcGluaW9uIHRo
YXQgaW50cm9kdWNpbmcgdGhlc2UgaW50ZXJjZXB0aW9uIGhhbmRsZXJzIGF0IHRoaXMgdGlt
ZcKgaXMNCj4gdW5uZWNlc3NhcnnCoGFuZMKgcmlza3PCoG9wZW5pbmfCoGHCoGNhbsKgb2bC
oHdvcm1zwqB0aGF0wqB3b3VsZMKgYmUNCj4gYmV0dGVyIGRlYWx0IHdpdGggaW4gYSBzdWJz
ZXF1ZW50IHBoYXNlLiBGb3IgdGhhdCByZWFzb24gYW5kIHRoZSByZWFzb25zIHN0YXRlZA0K
PiBhYm92ZSzCoEnCoHRoaW5rwqB0aGXCoGJldHRlcsKgb3B0aW9uwqBpc8KgdG/CoHRlcm1p
bmF0ZcKgc3RhcnRpbmfCoHRoZcKgZ3Vlc3TCoGlmwqB0aGUNCj4gQ1BVwqBtb2RlbMKgZmVh
dHVyZcKgZm9ywqBBUMKgaXPCoGVuYWJsZWTCoGJ1dMKgYW7CoEFQwqBkZXZpY2XCoGlzwqBu
b3TCoGRlZmluZWTCoGZvcsKgdGhlDQo+IGd1ZXN0LiBUaGlzIHJlc3RyaWN0aW9uLCBvZiBj
b3Vyc2UsIHdpbGwgYmUgcmVtb3ZlZCB3aGVuIGhvdCBwbHVnIGlzIGltcGxlbWVudGVkDQo+
IGluwqBhwqBzdWJzZXF1ZW50wqBkZXZlbG9wbWVudMKgcGhhc2UuDQoNCkkgc2Vjb25kIHRo
YXQhIEkgYWdyZWUgdGhhdCBoYXZpbmcgYXAgaW5zdHJ1Y3Rpb25zIGJ1dCBub3QgaGF2aW5n
IHRoZQ0KcG9zc2liaWxpdHkgdG8gYWN0dWFsbHkgZG8gQVAgY3J5cHRvIGlzIHByb2JhYmx5
IG5vdCB3aGF0IHRoZSB1c2VyIHdhbnRzLg0KUHJldmVudGluZyBzdWNoIGEgZ3Vlc3QgZm9y
bSBzdGFydGluZyAod2l0aCBhIG5pY2UgbWVzc2FnZSkgc291bmRzIHJlYXNvbmFibGUNCnRv
IG1lLg0KDQpJIGFncmVlIHdpdGggQ29ubmllLCB0aGUgYXBwcm9hY2ggJ2hvbGQgdGhlIGxp
bmUnICh1bnRpbCBmdXR1cmUgaG90cGx1Z3MpDQppcyB0aGUgbW9zdCByZWFzb25hYmxlIHRo
aW5nIHRvIGRvICppbiB0aGUgbG9uZyBydW4qLiBCdXQgSSB0aGluayBpdCdzIGJldHRlcg0K
dG8gbGltaXQgb3Vyc2VsdmVzIHRvIHRoZSBzaW1wbGVzdCBjYXNlIGZvciBub3csIEkgZG9u
J3Qgc2VlIGFueSBwcm9ibGVtcw0Kd2l0aCBkb2luZyB0aGUgaG90cGx1ZyBzdXBwb3J0IGxh
dGVyLg0KDQpSZWdhcmRzLA0KSGFsaWwNCg0K
