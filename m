Received: from eggs.gnu.org ([2001:4830:134:3::10]:58373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqOhj-000405-3t
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 14:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqOhf-0004a4-4u
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 14:44:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50156
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eqOhf-0004Zn-0B
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 14:44:51 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1QJiIQf028209
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:44:50 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gcn3rh0m2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:44:49 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 26 Feb 2018 14:44:49 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
	<1519641757-12396-7-git-send-email-thuth@redhat.com>
	<20180226194857.01ce4a8c.cohuck@redhat.com>
	<b6664df2-eec4-7e35-1498-be27b5cc3e79@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 14:44:45 -0500
MIME-Version: 1.0
In-Reply-To: <b6664df2-eec4-7e35-1498-be27b5cc3e79@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <dcfd4bf5-fd36-52cc-8b66-87a68e80cc48@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL-for-s390x 06/14] s390-ccw:
 parse and set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

T24gMDIvMjYvMjAxOCAwMjoyOSBQTSwgQ29sbGluIEwuIFdhbGxpbmcgd3JvdGU6DQo+IE9u
IDAyLzI2LzIwMTggMDE6NDggUE0sIENvcm5lbGlhIEh1Y2sgd3JvdGU6DQo+PiBPbiBNb24s
IDI2IEZlYiAyMDE4IDExOjQyOjI5ICswMTAwDQo+PiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+Pg0KPj4gWy4uLl0NCj4+DQo+Pj4gwqAgMyBmaWxlcyBjaGFu
Z2VkLCA2NiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4+ICtzdGF0aWMgdm9p
ZCBzMzkwX2lwbF9zZXRfYm9vdF9tZW51KFMzOTBJUExTdGF0ZSAqaXBsKQ0KPj4+ICt7DQo+
Pj4gK8KgwqDCoCBRZW11T3B0c0xpc3QgKnBsaXN0ID0gcWVtdV9maW5kX29wdHMoImJvb3Qt
b3B0cyIpOw0KPj4+ICvCoMKgwqAgUWVtdU9wdHMgKm9wdHMgPSBRVEFJTFFfRklSU1QoJnBs
aXN0LT5oZWFkKTsNCj4+PiArwqDCoMKgIHVpbnQ4X3QgKmZsYWdzID0gJmlwbC0+cWlwbC5x
aXBsX2ZsYWdzOw0KPj4+ICvCoMKgwqAgdWludDMyX3QgKnRpbWVvdXQgPSAmaXBsLT5xaXBs
LmJvb3RfbWVudV90aW1lb3V0Ow0KPj4+ICvCoMKgwqAgY29uc3QgY2hhciAqdG1wOw0KPj4+
ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBzcGxhc2hfdGltZSA9IDA7DQo+Pj4gKw0KPj4+ICvC
oMKgwqAgaWYgKCFnZXRfYm9vdF9kZXZpY2UoMCkpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKGJvb3RfbWVudSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Jl
cG9ydCgiYm9vdCBtZW51IHJlcXVpcmVzIGEgYm9vdGluZGV4IHRvIGJlIA0KPj4+IHNwZWNp
ZmllZCBmb3IgIg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgInRoZSBJUEwgZGV2aWNlLiIpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+PiArwqDCoMKgIH0NCj4+PiArDQo+
Pj4gK8KgwqDCoCBzd2l0Y2ggKGlwbC0+aXBsYi5wYnQpIHsNCj4+PiArwqDCoMKgIGNhc2Ug
UzM5MF9JUExfVFlQRV9DQ1c6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4+ICvC
oMKgwqAgZGVmYXVsdDoNCj4+PiArwqDCoMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJib290
IG1lbnUgaXMgbm90IHN1cHBvcnRlZCBmb3IgdGhpcyBkZXZpY2UgDQo+Pj4gdHlwZS4iKTsN
Cj4+IElmIEkgc3BlY2lmeSBib3RoIGEgYm9vdGluZGV4IGZvciBhIGRldmljZSBhbmQgYSAt
a2VybmVsIHBhcmFtZXRlciwgSQ0KPj4gZ2V0IHRoaXMgZXJyb3IgbWVzc2FnZS4gTG9va3Mg
YSB0YWQgb2RkLCBidXQgbm90IHN1cmUgaG93IHRvIGF2b2lkIGl0Lg0KPg0KPiBIbW0uLi4g
cGVyaGFwcyBhbiBhZGRpdGlvbmFsIGNoZWNrIGlmIG5vIElQTEIsIHRoZW4gc2tpcCB0cnlp
bmcgdG8gc2V0DQo+IGFueSBib290IG1lbnUgZGF0YT8NCj4NCj4+IFsuLi5dDQo+DQo+DQpT
b21ldGhpbmcgbGlrZToNCg0KIMKgwqDCoCBpZiAoIWlwbC0+aXBsYi5sZW4pIHsNCiDCoMKg
wqDCoMKgwqDCoCByZXR1cm47DQogwqDCoMKgIH0NCg0KcGxhY2VkIGp1c3QgYmVsb3cgdGhl
IGlmICghZ2V0X2Jvb3RfZGV2aWNlKDApKSBjaHVuayBmaXhlZCBpdCBmb3IgbWUuSWYgDQpu
byBJUExCIHdhcyBzZXQsDQp0aGVuIHRoZSBJUExCIGZpZWxkcyBzaG91bGQganVzdCBhbGwg
YmUgemVyb3MuwqAgV2h5IG5vdCBqdXN0IGNoZWNrIGlmIA0KdGhlIGxlbmd0aCBpcyAwIHRv
DQpkZXRlcm1pbmUgdGhhdCB3ZSBkaWQgbm90IHNldCBhbiBJUExCIGF0IGFsbD8NCg0KYWxz
bzoNCg0KIMKgwqDCoCBpZiAoIWlwbC0+aXBsYi5sZW4pIHsNCiDCoMKgwqAgwqDCoMKgIGlm
IChib290X21lbnUpIHsNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCBlcnJvcl9yZXBvcnQoImJv
b3QgbWVudSByZXF1aXJlcyBhbiBJUExCIHRvIGZ1bmN0aW9uIik7DQogwqDCoMKgIMKgwqDC
oCB9DQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KIMKgwqDCoCB9DQoNCmlmIHlvdSB0aGlu
ayBhbiBlcnJvciBtZXNzYWdlIGlzIG5lZWRlZCAodXNlIGEgYmV0dGVyIG1lc3NhZ2UsIG1p
bmUgaXMgDQpub3QgaGVscGZ1bCBidXQgSQ0KanVzdCB3YW50ZWQgdG8gZGVtb25zdHJhdGUg
dGhhdCB0aGUgaWYgKGJvb3RfbWVudSkgY2hlY2sgc2hvdWxkIGJlIA0KbmVzdGVkIGZpcnN0
KS4NCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcy7CoCBTZWVtcyB0byBiZSBhIGZldyBj
YXNlcyB0aGF0IEkgbWlzc2VkIG9uIG15IGVuZC4NCg0KLS0gDQotIENvbGxpbiBMIFdhbGxp
bmcNCg0K
