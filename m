Received: from eggs.gnu.org ([2001:4830:134:3::10]:50457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVyYw-0005M3-QL
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVyYt-0005x1-Kt
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:19:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fVyYt-0005wp-CQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:19:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LCJ6uq100710
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:19:38 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jrb5rj2j5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:19:38 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Jun 2018 08:19:36 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20180621115530.11069-1-marcandre.lureau@redhat.com>
	<20180621115530.11069-2-marcandre.lureau@redhat.com>
	<f500f7df-3eff-c9d6-2630-0c00f2360d6e@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 08:19:31 -0400
MIME-Version: 1.0
In-Reply-To: <f500f7df-3eff-c9d6-2630-0c00f2360d6e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <3b040c61-f5a4-91e8-10f0-2f9ff403351b@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v4 1/5] tpm: add a "ppi" boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

T24gMDYvMjEvMjAxOCAwODoxMSBBTSwgU3RlZmFuIEJlcmdlciB3cm90ZToNCj4gT24gMDYv
MjEvMjAxOCAwNzo1NSBBTSwgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3RlOg0KPj4gVGhlIGZv
bGxvd2luZyBwYXRjaGVzIGltcGxlbWVudCB0aGUgVFBNIFBoeXNpY2FsIFByZXNlbmNlIElu
dGVyZmFjZSwNCj4+IGFuZCBtYWtlcyB1c2Ugb2YgbmV3IG1lbW9yeSByZWdpb24gYW5kIGZ3
X2NmZyBlbnRyaWVzLiBFbmFibGUgaXQgYnkNCj4+IGRlZmF1bHQgb24gPjIuMTIgbWFjaGlu
ZSB0eXBlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiDCoCBpbmNsdWRlL2h3L2Nv
bXBhdC5oIHwgMTAgKysrKysrKysrKw0KPj4gwqAgaHcvdHBtL3RwbV9jcmIuY8KgwqDCoCB8
wqAgMyArKysNCj4+IMKgIGh3L3RwbS90cG1fdGlzLmPCoMKgwqAgfMKgIDMgKysrDQo+PiDC
oCAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9jb21wYXQuaCBiL2luY2x1ZGUvaHcvY29tcGF0LmgNCj4+IGluZGV4
IDU2MzkwOGI4NzQuLmRhYzg0NzU0OGIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2Nv
bXBhdC5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2NvbXBhdC5oDQo+PiBAQCAtMiw2ICsyLDE2
IEBADQo+PiDCoCAjZGVmaW5lIEhXX0NPTVBBVF9IDQo+PiDCoCDCoCAjZGVmaW5lIEhXX0NP
TVBBVF8yXzEyIFwNCj4+ICvCoMKgwqAge1wNCj4+ICvCoMKgwqDCoMKgwqDCoCAuZHJpdmVy
wqDCoCA9ICJ0cG0tY3JiIixcDQo+PiArwqDCoMKgwqDCoMKgwqAgLnByb3BlcnR5ID0gInBw
aSIsXA0KPj4gK8KgwqDCoMKgwqDCoMKgIC52YWx1ZcKgwqDCoCA9ICJmYWxzZSIsXA0KPj4g
K8KgwqDCoCB9LFwNCj4+ICvCoMKgwqAge1wNCj4+ICvCoMKgwqDCoMKgwqDCoCAuZHJpdmVy
wqDCoCA9ICJ0cG0tdGlzIixcDQo+PiArwqDCoMKgwqDCoMKgwqAgLnByb3BlcnR5ID0gInBw
aSIsXA0KPj4gK8KgwqDCoMKgwqDCoMKgIC52YWx1ZcKgwqDCoCA9ICJmYWxzZSIsXA0KPj4g
K8KgwqDCoCB9LFwNCj4+IMKgwqDCoMKgwqAge1wNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAu
ZHJpdmVywqDCoCA9ICJtaWdyYXRpb24iLFwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAucHJv
cGVydHkgPSAiZGVjb21wcmVzcy1lcnJvci1jaGVjayIsXA0KPj4gZGlmZiAtLWdpdCBhL2h3
L3RwbS90cG1fY3JiLmMgYi9ody90cG0vdHBtX2NyYi5jDQo+PiBpbmRleCBhOTJkZDUwNDM3
Li5kNWIwYWM1OTIwIDEwMDY0NA0KPj4gLS0tIGEvaHcvdHBtL3RwbV9jcmIuYw0KPj4gKysr
IGIvaHcvdHBtL3RwbV9jcmIuYw0KPj4gQEAgLTQxLDYgKzQxLDggQEAgdHlwZWRlZiBzdHJ1
Y3QgQ1JCU3RhdGUgew0KPj4gwqDCoMKgwqDCoCBNZW1vcnlSZWdpb24gY21kbWVtOw0KPj4g
wqAgwqDCoMKgwqDCoCBzaXplX3QgYmVfYnVmZmVyX3NpemU7DQo+PiArDQo+PiArwqDCoMKg
IGJvb2wgcHBpX2VuYWJsZWQ7DQo+PiDCoCB9IENSQlN0YXRlOw0KPj4gwqAgwqAgI2RlZmlu
ZSBDUkIob2JqKSBPQkpFQ1RfQ0hFQ0soQ1JCU3RhdGUsIChvYmopLCBUWVBFX1RQTV9DUkIp
DQo+PiBAQCAtMjIxLDYgKzIyMyw3IEBAIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRp
b24gdm1zdGF0ZV90cG1fY3JiID0gew0KPj4gwqAgwqAgc3RhdGljIFByb3BlcnR5IHRwbV9j
cmJfcHJvcGVydGllc1tdID0gew0KPj4gwqDCoMKgwqDCoCBERUZJTkVfUFJPUF9UUE1CRSgi
dHBtZGV2IiwgQ1JCU3RhdGUsIHRwbWJlKSwNCj4+ICvCoMKgwqAgREVGSU5FX1BST1BfQk9P
TCgicHBpIiwgQ1JCU3RhdGUsIHBwaV9lbmFibGVkLCB0cnVlKSwNCj4+IMKgwqDCoMKgwqAg
REVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4+IMKgIH07DQo+DQo+IFdvdWxkbid0IHdl
IGhhdmUgdG8gYnVtcCB1cCB0aGUgdmVyc2lvbiBvZiB0ZWggVk1TdGF0ZURlc2NyaXB0aW9u
Pw0KDQpBaCwgY29tbWFuZCBsaW5lIG9wdGlvbi4uLg0KDQogwqDCoCBTdGVmYW4NCg0K
