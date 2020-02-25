Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D7FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698D721556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698D721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YBJ-0007J8-LC
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1j6YA1-0005xE-Ih
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1j6YA0-0005iS-9d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:13:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44404
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1j6YA0-0005gS-4g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:13:56 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PBAFOT034598
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:13:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb12byhnp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:13:55 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 25 Feb 2020 11:13:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Feb 2020 11:13:52 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01PBDpSX55705616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 11:13:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9049F4C040;
 Tue, 25 Feb 2020 11:13:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FDCD4C046;
 Tue, 25 Feb 2020 11:13:51 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.219])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2020 11:13:51 +0000 (GMT)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
 <bf3f44b5-f0fe-59f4-9152-54edd8c9822e@linux.ibm.com>
 <941cc201-4c33-0ad3-ecc8-eab2709d350d@de.ibm.com>
 <91910082-ffeb-c588-7434-3de5fbfcbfa6@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Tue, 25 Feb 2020 12:13:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <91910082-ffeb-c588-7434-3de5fbfcbfa6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022511-0020-0000-0000-000003AD6616
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022511-0021-0000-0000-000022057C0F
Message-Id: <ab7de201-f466-b95d-50f0-e6f850eee3cd@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_03:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=744
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250091
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-001b2d01.pphosted.com id
 01PBAFOT034598
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI1LjAyLjIwIDExOjIzLCBKYXNvbiBKLiBIZXJuZSB3cm90ZToNCj4gT24gMi8x
My8yMCAxOjI0IFBNLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6DQo+IC4uLg0KPj4+
PiBkaWZmIC0tZ2l0IGEvcGMtYmlvcy9zMzkwLWNjdy9qdW1wMmlwbC5jIGIvcGMtYmlvcy9z
MzkwLWNjdy9qdW1wMmlwbC5jDQo+Pj4+IGluZGV4IGRhMTNjNDNjYzAuLjg4MzkyMjY4MDMg
MTAwNjQ0DQo+Pj4+IC0tLSBhL3BjLWJpb3MvczM5MC1jY3cvanVtcDJpcGwuYw0KPj4+PiAr
KysgYi9wYy1iaW9zL3MzOTAtY2N3L2p1bXAyaXBsLmMNCj4+Pj4gQEAgLTE4LDYgKzE4LDcg
QEANCj4+Pj4gwqDCoCB0eXBlZGVmIHN0cnVjdCBSZXNldEluZm8gew0KPj4+PiDCoMKgwqDC
oMKgwqAgdWludDY0X3QgaXBsX3BzdzsNCj4+Pj4gwqDCoMKgwqDCoMKgIHVpbnQzMl90IGlw
bF9jb250aW51ZTsNCj4+Pj4gK8KgwqDCoCB1aW50MzJfdCBwYWQ7DQo+Pj4+IMKgwqAgfSBS
ZXNldEluZm87DQo+Pj4+IMKgwqAgwqAgc3RhdGljIFJlc2V0SW5mbyBzYXZlOw0KPj4+Pg0K
Pj4+Pg0KPj4+PiBhbHNvIHdvcms/IElmIHllcywgYm90aCB2YXJpYW50cyBhcmUgdmFsaWQu
IEVpdGhlciBwYWNrZWQgb3IgZXhwbGljaXQgcGFkZGluZy4NCj4+Pj4NCj4+Pg0KPj4+IEkg
ZG9uJ3QgYmVsaWV2ZSB0aGlzIHdpbGwgd29yay4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0
aGF0IHdlJ3JlIG92ZXJ3cml0aW5nIHRvbyBtdWNoIG1lbW9yeSB3aGVuIHdlIGNhc3QgYWRk
cmVzcyAwIGFzIGEgUmVzZXRJbmZvIGFuZCB0aGVuIG92ZXJ3cml0ZSBpdCAoKmN1cnJlbnQg
PSBzYXZlKS4gSSB0aGluayB3ZSBuZWVkIHRoZSBzdHJ1Y3QgdG8gYmUgc2l6ZWQgYXQgMTIt
Ynl0ZXMgaW5zdGVhZCBvZiAxNi4NCj4+Pg0KPj4NCj4+IFRoZSBpZGVhIG9mIHRoZSBjb2Rl
IGlzIHRoYXQgd2UgX3NhdmVfIHRoZSBvcmlnaW5hbCBjb250ZW50IGZyb20gYWRkcmVzcyAw
IHRvIHNhdmUgYW5kIF9yZXN0b3JlXyBpdCBiZWZvcmUganVtcGluZyBpbnRvIGZpbmFsIGNv
ZGUuIEkgZG8gbm90IHlldCB1bmRlcnN0YW5kIHdoeSB0aGlzIGRvZXMgbm90IHdvcmsuDQo+
Pg0KPiANCj4gSSd2ZSBmb3VuZCB0aGUgcmVhbCBwcm9ibGVtIGhlcmUuIExlZ2FjeSBvcGVy
YXRpbmcgc3lzdGVtcyB0aGF0IGV4cGVjdCB0byBzdGFydA0KPiBpbiAzMi1iaXQgYWRkcmVz
c2luZyBtb2RlIGNhbiBmYWlsIGlmIHdlIGxlYXZlIGp1bmsgaW4gdGhlIGhpZ2ggaGFsdmVz
IG9mIG91cg0KPiA2NC1iaXQgcmVnaXN0ZXJzLiBUaGlzIGlzIGJlY2F1c2Ugc29tZSBpbnN0
cnVjdGlvbnMgKExBIGZvciBleGFtcGxlKSBhcmUNCj4gYmktbW9kYWwgYW5kIG9wZXJhdGUg
ZGlmZmVyZW50bHkgZGVwZW5kaW5nIG9uIHRoZSBtYWNoaW5lJ3MgY3VycmVudCBhZGRyZXNz
aW5nDQo+IG1vZGUuDQo+IA0KPiBJbiB0aGUgY2FzZSB3aGVyZSB3ZSBwYWNrIHRoZSBzdHJ1
Y3QsIHRoZSBjb21waWxlciBoYXBwZW5zIHRvIHVzZSB0aGUgbXZjDQo+IGluc3RydWN0aW9u
IHRvIGxvYWQvc3RvcmUgdGhlIGN1cnJlbnQvc2F2ZSBtZW1vcnkgYXJlYXMuDQo+IA0KPiDC
oMKgwqDCoMKgICpjdXJyZW50ID0gc2F2ZTsNCj4gwqAgMWZjOsKgwqDCoCBlMyAxMCBiMCBh
OCAwMCAwNMKgwqDCoMKgIGxnwqDCoMKgICVyMSwxNjgoJXIxMSkNCj4gwqAgMjAyOsKgwqDC
oCBjMCAyMCAwMCAwMCAwMCAwMMKgwqDCoMKgIGxhcmzCoMKgwqAgJXIyLDIwMiA8anVtcF90
b19JUExfMisweDMyPg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIwNDogUl8zOTBfUEMz
MkRCTMKgwqDCoCAuYnNzKzB4Mg0KPiDCoCAyMDg6wqDCoMKgIGQyIDBiIDEwIDAwIDIwIDAw
wqDCoMKgwqAgbXZjwqDCoMKgIDAoMTIsJXIxKSwwKCVyMikNCj4gDQo+IEV2ZXJ5dGhpbmcg
d29ya3MgYXMgZXhwZWN0ZWQgaGVyZSwgb3VyIGxlZ2FjeSBPUyBib290cyB3aXRob3V0IGlz
c3VlLg0KPiBIb3dldmVyLCBpbiB0aGUgY2FzZSB3aGVyZSB3ZSd2ZSBwYWNrZWQgdGhpcyBz
dHJ1Y3QgdGhlIGNvbXBpbGVyIG9wdGltaXplcyB0aGUNCj4gY29kZSBhbmQgdXNlcyBsbWcv
c3RtZyBpbnN0ZWFkIG9mIG12YyB0byBjb3B5IHRoZSBkYXRhOg0KPiANCj4gwqDCoMKgwqDC
oCAqY3VycmVudCA9IHNhdmU7DQo+IMKgIDFmYzrCoMKgwqAgZTMgMTAgYjAgYTggMDAgMDTC
oMKgwqDCoCBsZ8KgwqDCoCAlcjEsMTY4KCVyMTEpDQo+IMKgIDIwMjrCoMKgwqAgYzAgMjAg
MDAgMDAgMDAgMDDCoMKgwqDCoCBsYXJswqDCoMKgICVyMiwyMDIgPGp1bXBfdG9fSVBMXzIr
MHgzMj4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyMDQ6IFJfMzkwX1BDMzJEQkzCoMKg
wqAgLmJzcysweDINCj4gwqAgMjA4OsKgwqDCoCBlYiAyMyAyMCAwMCAwMCAwNMKgwqDCoMKg
IGxtZ8KgwqDCoCAlcjIsJXIzLDAoJXIyKQ0KPiDCoCAyMGU6wqDCoMKgIGViIDIzIDEwIDAw
IDAwIDI0wqDCoMKgwqAgc3RtZ8KgwqDCoCAlcjIsJXIzLDAoJXIxKQ0KPiANCj4gRGVwZW5k
aW5nIG9uIHRoZSBkYXRhIGJlaW5nIGNvcGllZCwgdGhlIGhpZ2ggaGFsdmVzIG9mIHRoZSBy
ZWdpc3RlcnMgbWF5IGNvbnRhaW4NCj4gbm9uLXplcm8gdmFsdWVzLiBFeGFtcGxlOg0KPiAN
Cj4gwqDCoMKgIHIywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTA4MDAwMDgwMDAwNzgw
wqDCoMKgwqDCoMKgwqAgNzQzMDkzOTU5OTkwOTg3NTINCj4gwqDCoMKgIHIzwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDB4NjAxMDAxODAwMDA0MzY4wqDCoMKgwqDCoMKgwqAgNDMyNjI3
MTQyMjgzNTEwNjMyDQo+IA0KPiBTbywgYnkgc2hlZXIgbHVjayBvZiB0aGUgZ2VuZXJhdGVk
IGFzc2VtYmxlciwgdGhlIHBhdGNoIGhhcHBlbnMgdG8gImZpeCIgdGhlDQo+IHByb2JsZW0u
wqAgQSByZWFsIGZpeCBtaWdodCBiZSB0byBpbnNlcnQgaW5saW5lIGFzc2VtYmxlciB0aGF0
IGNsZWFycyB0aGUgaGlnaA0KPiBoYWx2ZXMgb2YgdGhlIHJlZ2lzdGVycyBiZWZvcmUgd2Ug
Y2FsbCBpcGwoKSBpbiBqdW1wX3RvX0lQTF8yKCkuIENhbiB3ZSB0aGluayBvZg0KPiBhIGJl
dHRlciB3YXkgdG8gZG8gdGhhdCB0aGFuIDE1IExMR1RSIGluc3RydWN0aW9ucz8gOikgTGV0
IG1lIGtub3cgeW91cg0KPiB0aG91Z2h0cw0KDQpEb2VzIHNhbTMxIGJlZm9yZSB0aGUgaXBs
KCkgd29yaz8NCg0KPiANCj4ganVtcF90b19JUExfMiBmb3IgZWFzeSByZWZlcmVuY2U6DQo+
IMKgwqDCoCBzdGF0aWMgdm9pZCBqdW1wX3RvX0lQTF8yKHZvaWQpDQo+IMKgwqDCoCB7DQo+
IMKgwqDCoMKgwqDCoMKgIFJlc2V0SW5mbyAqY3VycmVudCA9IDA7DQo+IA0KPiDCoMKgwqDC
oMKgwqDCoCB2b2lkICgqaXBsKSh2b2lkKSA9ICh2b2lkICopICh1aW50NjRfdCkgY3VycmVu
dC0+aXBsX2NvbnRpbnVlOw0KPiDCoMKgwqDCoMKgwqDCoCAqY3VycmVudCA9IHNhdmU7DQo+
IMKgwqDCoMKgwqDCoMKgIGlwbCgpOyAvKiBzaG91bGQgbm90IHJldHVybiAqLw0KPiDCoMKg
wqAgfQ0KPiANCj4gDQoNCg==

