Received: from eggs.gnu.org ([209.51.188.92]:60204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gs8h3-0007ha-P3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gs8h2-0005rE-Lo
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:07:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32850
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gs8h2-0005bH-Gd
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:07:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18G3gX1133684
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 11:07:29 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qhbay5au5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 11:07:29 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 8 Feb 2019 16:07:28 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<18fcb6cc-01aa-3461-6595-85e946b77bc7@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 8 Feb 2019 11:07:23 -0500
MIME-Version: 1.0
In-Reply-To: <18fcb6cc-01aa-3461-6595-85e946b77bc7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <863ebc1f-e9c8-1513-27ea-d65fed789e8e@linux.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 01/15] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com

T24gMS8zMC8xOSA1OjIxIFBNLCBGYXJoYW4gQWxpIHdyb3RlOg0KPj4gLi4uDQo+PiBkaWZm
IC0tZ2l0IGEvaHcvczM5MHgvaXBsLmMgYi9ody9zMzkweC9pcGwuYw0KPj4gaW5kZXggMjFm
NjRhZC4uYTk5M2Y2NSAxMDA2NDQNCj4+IC0tLSBhL2h3L3MzOTB4L2lwbC5jDQo+PiArKysg
Yi9ody9zMzkweC9pcGwuYw0KPj4gQEAgLTE5LDYgKzE5LDcgQEANCj4+IMKgICNpbmNsdWRl
ICJody9sb2FkZXIuaCINCj4+IMKgICNpbmNsdWRlICJody9ib2FyZHMuaCINCj4+IMKgICNp
bmNsdWRlICJody9zMzkweC92aXJ0aW8tY2N3LmgiDQo+PiArI2luY2x1ZGUgImh3L3MzOTB4
L3ZmaW8tY2N3LmgiDQo+PiDCoCAjaW5jbHVkZSAiaHcvczM5MHgvY3NzLmgiDQo+PiDCoCAj
aW5jbHVkZSAiaHcvczM5MHgvZWJjZGljLmgiDQo+PiDCoCAjaW5jbHVkZSAiaXBsLmgiDQo+
PiBAQCAtMzExLDggKzMxMiwxMiBAQCBzdGF0aWMgQ2N3RGV2aWNlICpzMzkwX2dldF9jY3df
ZGV2aWNlKERldmljZVN0YXRlICpkZXZfc3QpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgVmly
dGlvQ2N3RGV2aWNlICp2aXJ0aW9fY2N3X2RldiA9IChWaXJ0aW9DY3dEZXZpY2UgKikNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNU
KHFkZXZfZ2V0X3BhcmVudF9idXMoZGV2X3N0KS0+cGFyZW50KSwNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBUWVBFX1ZJUlRJT19DQ1dfREVWSUNFKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBWRklPQ0NX
RGV2aWNlICp2ZmlvX2Njd19kZXYgPSAoVkZJT0NDV0RldmljZSAqKQ0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoZGV2X3N0KSwgVFlQ
RV9WRklPX0NDVyk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZpcnRpb19jY3dfZGV2
KSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjY3dfZGV2ID0gQ0NXX0RFVklD
RSh2aXJ0aW9fY2N3X2Rldik7DQo+PiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmICh2Zmlv
X2Njd19kZXYpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNjd19kZXYgPSBDQ1df
REVWSUNFKHZmaW9fY2N3X2Rldik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNDU0lEZXZpY2UgKnNkID0gKFNDU0lE
ZXZpY2UgKikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2JqZWN0
X2R5bmFtaWNfY2FzdChPQkpFQ1QoZGV2X3N0KSwNCj4+IEBAIC0zNDcsNiArMzUyLDggQEAg
c3RhdGljIGJvb2wgczM5MF9nZW5faW5pdGlhbF9pcGxiKFMzOTBJUExTdGF0ZSAqaXBsKQ0K
Pj4gwqDCoMKgwqDCoCBpZiAoY2N3X2Rldikgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIFND
U0lEZXZpY2UgKnNkID0gKFNDU0lEZXZpY2UgKikgb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpF
Q1QoZGV2X3N0KSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRZUEVfU0NTSV9ERVZJQ0UpOw0KPj4g
K8KgwqDCoMKgwqDCoMKgIFZGSU9DQ1dEZXZpY2UgKnZjID0gKFZGSU9DQ1dEZXZpY2UgKikN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNU
KGRldl9zdCksIFRZUEVfVkZJT19DQ1cpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChz
ZCkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXBsLT5pcGxiLmxlbiA9IGNw
dV90b19iZTMyKFMzOTBfSVBMQl9NSU5fUUVNVV9TQ1NJX0xFTik7DQo+PiBAQCAtMzU4LDYg
KzM2NSwxMyBAQCBzdGF0aWMgYm9vbCBzMzkwX2dlbl9pbml0aWFsX2lwbGIoUzM5MElQTFN0
YXRlICppcGwpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcGwtPmlwbGIuc2Nz
aS5jaGFubmVsID0gY3B1X3RvX2JlMTYoc2QtPmNoYW5uZWwpOw0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaXBsLT5pcGxiLnNjc2kuZGV2bm8gPSBjcHVfdG9fYmUxNihjY3df
ZGV2LT5zY2gtPmRldm5vKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlwbC0+
aXBsYi5zY3NpLnNzaWQgPSBjY3dfZGV2LT5zY2gtPnNzaWQgJiAzOw0KPj4gK8KgwqDCoMKg
wqDCoMKgIH0gZWxzZSBpZiAodmMpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENj
d0RldmljZSAqY2N3X2RldiA9IENDV19ERVZJQ0UodmMpOw0KPiANCj4gRG8gd2UgbmVlZCB0
aGlzIGxpbmUgaGVyZT8gSSB0aG91Z2ggY2N3X2RldiB3YXMgYWxyZWFkeSBjb3JyZWN0bHkg
Y2FzdGVkIGluIA0KPiBzMzkwX2dldF9jY3dfZGV2aWNlPw0KPiANCj4+ICsNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlwbC0+aXBsYi5sZW4gPSBjcHVfdG9fYmUzMihTMzkwX0lQ
TEJfTUlOX0NDV19MRU4pOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXBsLT5pcGxi
LnBidCA9IFMzOTBfSVBMX1RZUEVfQ0NXOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aXBsLT5pcGxiLmNjdy5kZXZubyA9IGNwdV90b19iZTE2KGNjd19kZXYtPnNjaC0+ZGV2bm8p
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXBsLT5pcGxiLmNjdy5zc2lkID0gY2N3
X2Rldi0+c2NoLT5zc2lkICYgMzsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVmlydElPTmV0ICp2biA9IChWaXJ0SU9O
ZXQgKikgb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoZGV2X3N0KSwNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBUWVBFX1ZJUlRJT19ORVQpOw0KPiANCg0KR29vZCBjYXRjaCwgd2UgZG9u
J3QgbmVlZCB0aGUgZXh0cmEgY2FzdC4gVGhpcyBpcyBhIHJlbGljIG9mIGFuIG9sZGVyIHdh
eSBvZiBoYW5kbGluZyB0aGUgDQpkYXRhLiBJIHNob3VsZCBoYXZlIHJlbW92ZWQgaXQgd2hl
biBJIHNpbXBsaWZpZWQgdGhlIGNvZGUgYWZ0ZXIgdGhlIFJGQyB2ZXJzaW9uLg0KDQotLSAN
Ci0tIEphc29uIEouIEhlcm5lIChqamhlcm5lQGxpbnV4LmlibS5jb20pDQoNCg==
