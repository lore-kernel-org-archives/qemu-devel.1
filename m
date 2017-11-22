Received: from eggs.gnu.org ([2001:4830:134:3::10]:37429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eHNNm-0000F3-6F
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eHNNj-0004C1-1P
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:15:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35214
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eHNNi-0004BY-RD
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:15:30 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAM5E01r062445
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 00:15:28 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ed2hfgqvm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 00:15:28 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 22:15:27 -0700
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121114243.7ac15767.cohuck@redhat.com>
	<cd7b7f6e-dbb3-3d9a-bd3d-a5fb7d7b9d2b@linux.vnet.ibm.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 13:15:21 +0800
MIME-Version: 1.0
In-Reply-To: <cd7b7f6e-dbb3-3d9a-bd3d-a5fb7d7b9d2b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d0e6d96e-f35a-17fb-2714-3fbbb95c38a3@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/pci: rework PCI STORE BLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com

DQoNCuWcqCAyMDE3LzExLzIyIOS4iuWNiDI6MDcsIFBpZXJyZSBNb3JlbCDlhpnpgZM6DQo+
IE9uIDIxLzExLzIwMTcgMTE6NDIsIENvcm5lbGlhIEh1Y2sgd3JvdGU6DQo+PiBPbiBUaHUs
IDE2IE5vdiAyMDE3IDE4OjUxOjUyICswMTAwDQo+PiBQaWVycmUgTW9yZWwgPHBtb3JlbEBs
aW51eC52bmV0LmlibS5jb20+IHdyb3RlOg0KPj4NCj4+PiBFbmhhbmNlIHRoZSBmYXVsdCBk
ZXRlY3Rpb24uDQo+Pj4NCj4+PiBGaXh1cCB0aGUgcHJlY2VkZW5jZSB0byBjaGVjayB0aGUg
ZGVzdGluYXRpb24gcGF0aCBleGlzdGFuY2UNCj4+PiBiZWZvcmUgY2hlY2tpbmcgZm9yIHRo
ZSBzb3VyY2UgYWNjZXNzaWJpbGl0eS4NCj4+Pg0KPj4+IEFkZCB0aGUgbWF4c3RibCBlbnRy
eSB0byBib3RoIHRoZSBRdWVyeSBQQ0kgRnVuY3Rpb24gR3JvdXANCj4+PiByZXNwb25zZSBh
bmQgdGhlIFBDSUJ1c0RldmljZSBzdHJ1Y3R1cmUuDQo+Pj4NCj4+PiBJbml0aWFsaXplIHRo
ZSBtYXhzdGJsIHRvIDEyOCBwZXIgZGVmYXVsdCB1bnRpbCB3ZSBnZXQNCj4+PiB0aGUgYWN0
dWFsIGRhdGEgZnJvbSB0aGUgaGFyZHdhcmUuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBQ
aWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC52bmV0LmlibS5jb20+DQo+Pj4gUmV2aWV3ZWQt
Ynk6IFlpIE1pbiBaaGFvIDx6eWltaW5AbGludXgudm5ldC5pYm0uY29tPg0KPj4+IC0tLQ0K
Pj4+IMKgIGh3L3MzOTB4L3MzOTAtcGNpLWJ1cy5owqAgfMKgIDEgKw0KPj4+IMKgIGh3L3Mz
OTB4L3MzOTAtcGNpLWluc3QuYyB8IDYyIA0KPj4+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IMKgIGh3L3MzOTB4L3MzOTAtcGNpLWlu
c3QuaCB8wqAgMiArLQ0KPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygr
KSwgMjUgZGVsZXRpb25zKC0pDQo+Pg0KPj4+IEBAIC03MDAsOCArNjg1LDMzIEBAIGludCBw
Y2lzdGJfc2VydmljZV9jYWxsKFMzOTBDUFUgKmNwdSwgdWludDhfdCANCj4+PiByMSwgdWlu
dDhfdCByMywgdWludDY0X3QgZ2FkZHIsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Ow0KPj4+IMKgwqDCoMKgwqAgfQ0KPj4+IMKgICvCoMKgwqAgaWYgKHBjaWFzID4gNSkgew0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCBEUFJJTlRGKCJwY2lzdGIgaW52YWxpZCBzcGFjZVxuIik7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNldGNjKGNwdSwgWlBDSV9QQ0lfTFNfRVJSKTsNCj4+
PiArwqDCoMKgwqDCoMKgwqAgczM5MF9zZXRfc3RhdHVzX2NvZGUoZW52LCByMSwgWlBDSV9Q
Q0lfU1RfSU5WQUxfQVMpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+PiAr
wqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoCAvKiBWZXJpZnkgdGhlIGFkZHJlc3MsIG9m
ZnNldCBhbmQgbGVuZ3RoICovDQo+Pj4gK8KgwqDCoCAvKiBvZmZzZXQgbXVzdCBiZSBhIG11
bHRpcGxlIG9mIDggKi8NCj4+PiArwqDCoMKgIGlmIChvZmZzZXQgJSA4KSB7DQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGdvdG8gYWRkcmVzc2luZ19lcnJvcjsNCj4+PiArwqDCoMKgIH0NCj4+
PiArwqDCoMKgIC8qIExlbmd0aCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiA4LCBhIG11bHRpcGxl
IG9mIDgsIG5vdCBncmVhdGVyIA0KPj4+IG1heHN0YmwgKi8NCj4+DQo+PiAibm90IGdyZWF0
ZXIgdGhhbiBtYXhzdGxiIg0KPg0KPiBCZXR0ZXIgSSBrbm93IGJ1dCBncmVhdGVyIHRoYXQg
ODAgY2hhcmFjdGVycywgdGhpcyBpcyB3aHkgSSBwcmVmZXJyZWQgDQo+IGJyb2tlbiBFbmds
aXNoLg0KPiBXaGF0IGRvIEkgZG8gPyBicmVhayB0aGUgbGluZSBvciBFbmdsaXNoID8NCmxl
c3MgdGhhbj8NCj4NCj4+DQo+Pj4gK8KgwqDCoCBpZiAoKGxlbiA8PSA4KSB8fCAobGVuICUg
OCkgfHwgKGxlbiA+IHBiZGV2LT5tYXhzdGJsKSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBn
b3RvIGFkZHJlc3NpbmdfZXJyb3I7DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gK8KgwqDCoCAvKiBE
byBub3QgY3Jvc3MgYSA0Sy1ieXRlIGJvdW5kYXJ5ICovDQo+Pj4gK8KgwqDCoCBpZiAoKChv
ZmZzZXQgJiAweGZmZikgKyBsZW4pID4gMHgxMDAwKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGdvdG8gYWRkcmVzc2luZ19lcnJvcjsNCj4+PiArwqDCoMKgIH0NCj4+PiArwqDCoMKgIC8q
IEd1ZXN0IGFkZHJlc3MgbXVzdCBiZSBkb3VibGUgd29yZCBhbGlnbmVkICovDQo+Pj4gK8Kg
wqDCoCBpZiAoZ2FkZHIgJiAweDA3VUwpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgZ290byBh
ZGRyZXNzaW5nX2Vycm9yOw0KPj4+ICvCoMKgwqAgfQ0KPj4+ICsNCj4+PiDCoMKgwqDCoMKg
IG1yID0gcGJkZXYtPnBkZXYtPmlvX3JlZ2lvbnNbcGNpYXNdLm1lbW9yeTsNCj4+PiAtwqDC
oMKgIGlmICghbWVtb3J5X3JlZ2lvbl9hY2Nlc3NfdmFsaWQobXIsIGVudi0+cmVnc1tyM10s
IGxlbiwgdHJ1ZSkpIHsNCj4+PiArwqDCoMKgIGlmICghbWVtb3J5X3JlZ2lvbl9hY2Nlc3Nf
dmFsaWQobXIsIG9mZnNldCwgbGVuLCB0cnVlKSkgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBwcm9ncmFtX2ludGVycnVwdChlbnYsIFBHTV9PUEVSQU5ELCA2KTsNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+Pj4gwqDCoMKgwqDCoCB9DQo+Pg0KPj4gTG9va3Mg
Z29vZC4NCj4+DQo+DQo+DQoNCg==
