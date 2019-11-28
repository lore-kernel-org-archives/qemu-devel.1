Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F81C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29B021741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29B021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJWd-0004Et-Qq
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaJUR-0003PI-OW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaJUP-0000AT-ER
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:05:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3060
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iaJUP-00006V-5Y
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:05:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASCxQRg019758
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:05:39 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wjb8vqraw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:05:39 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 28 Nov 2019 13:05:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 13:05:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xASD5Y1359179224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 13:05:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69BAA52059
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 13:05:34 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.185.119])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4841D52050
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 13:05:34 +0000 (GMT)
Subject: Re: [PATCH v1 1/1] s390x: protvirt: SCLP interpretation
To: qemu-devel@nongnu.org
References: <1574935984-16910-1-git-send-email-pmorel@linux.ibm.com>
 <1574935984-16910-2-git-send-email-pmorel@linux.ibm.com>
 <e73fcc10-14cd-512e-56c7-ca17bcbefff8@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 28 Nov 2019 14:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e73fcc10-14cd-512e-56c7-ca17bcbefff8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19112813-4275-0000-0000-00000387814A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112813-4276-0000-0000-0000389B1338
Message-Id: <77551bc9-d81c-4c56-e754-84ad44b8e2bd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 suspectscore=1 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280114
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0b-001b2d01.pphosted.com id
 xASCxQRg019758
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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

DQpPbiAyMDE5LTExLTI4IDEzOjEwLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gT24gMjgvMTEv
MjAxOSAxMS4xMywgUGllcnJlIE1vcmVsIHdyb3RlOg0KPj4gVGhlIFNDTFAgcHJvdGVjdGlv
biBoYW5kbGUgc29tZSBvZiB0aGUgZXhjZXB0aW9ucyBkdWUgdG8NCj4+IG1pcy1jb25zdHJ1
Y3Rpb25zIG9mIHRoZSBTQ0xQIENvbnRyb2wgQmxvY2sgKFNDQ0IpIGJ5IHRoZSBndWVzdCBh
bmQNCj4+IHByb3ZpZGVzIG5vdGlmaWNhdGlvbnMgdG8gdGhlIGhvc3Qgd2hlbiBzb21ldGhp
bmcgZ2V0cyB3cm9uZy4NCj4+IFdlIGN1cnJlbnRseSBkbyBub3QgaGFuZGxlIHRoZXNlIGV4
Y2VwdGlvbnMsIGxldHRpbmcgYWxsIHRoZSB3b3JrIHRvIHRoZQ0KPj4gZmlybXdhcmUgdGhl
cmVmb3IsIHdlIG9ubHkgbmVlZCB0byBpbmplY3QgYW4gZXh0ZXJuYWwgaW50ZXJydXB0IHRv
IHRoZQ0KPj4gZ3Vlc3QuDQo+Pg0KPj4gV2hlbiB0aGUgU0NDQiBpcyBjb3JyZWN0LCB0aGUg
UzM5MHggdmlydHVhbGlzYXRpb24gcHJvdGVjdGlvbiBjb3BpZXMNCj4+IHRoZSBTQ0xQIENv
bnRyb2wgQmxvY2sgKFNDQ0IpIGZyb20gdGhlIGd1ZXN0IGluc2lkZSB0aGUga2VybmVsIHRv
IGF2b2lkDQo+PiBvcGVuaW5nIGEgZGlyZWN0IGFjY2VzcyB0byB0aGUgZ3Vlc3QgbWVtb3J5
Lg0KPj4gV2hlbiBhY2Nlc3NpbmcgdGhlIGtlcm5lbCBtZW1vcnkgd2l0aCBzdGFuZGFyZCBz
MzkwX2NwdV92aXJ0X21lbV8qDQo+PiBmdW5jdGlvbnMgdGhlIGhvc3Qgb3BlbnMgYWNjZXNz
IHRvIHRoZSBTQ0NCIHNoYWRvdyBhdCBhZGRyZXNzIDAuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogUGllcnJlIE1vcmVsIDxwbW9yZWxAbGludXguaWJtLmNvbT4NCj4+IC0tLQ0KPj4gwqAg
aHcvczM5MHgvc2NscC5jwqDCoMKgwqDCoMKgwqDCoCB8IDE4ICsrKysrKysrKysrKysNCj4+
IMKgIGluY2x1ZGUvaHcvczM5MHgvc2NscC5oIHzCoCAyICsrDQo+PiDCoCB0YXJnZXQvczM5
MHgva3ZtLmPCoMKgwqDCoMKgIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9zMzkweC9zY2xwLmMgYi9o
dy9zMzkweC9zY2xwLmMNCj4+IGluZGV4IGY1N2NlN2I3MzkuLjAyZTRlMDE0NmYgMTAwNjQ0
DQo+PiAtLS0gYS9ody9zMzkweC9zY2xwLmMNCj4+ICsrKyBiL2h3L3MzOTB4L3NjbHAuYw0K
Pj4gQEAgLTE5Myw2ICsxOTMsMjQgQEAgc3RhdGljIHZvaWQgc2NscF9leGVjdXRlKFNDTFBE
ZXZpY2UgKnNjbHAsIFNDQ0IgDQo+PiAqc2NjYiwgdWludDMyX3QgY29kZSkNCj4+IMKgwqDC
oMKgwqAgfQ0KPj4gwqAgfQ0KPj4gwqAgK2ludCBzY2xwX3NlcnZpY2VfY2FsbF9wcm90ZWN0
ZWQoQ1BVUzM5MFhTdGF0ZSAqZW52LCB1aW50NjRfdCBzY2NiLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVp
bnQzMl90IGNvZGUpDQo+PiArew0KPj4gK8KgwqDCoCBTQ0xQRGV2aWNlICpzY2xwID0gZ2V0
X3NjbHBfZGV2aWNlKCk7DQo+PiArwqDCoMKgIFNDTFBEZXZpY2VDbGFzcyAqc2NscF9jID0g
U0NMUF9HRVRfQ0xBU1Moc2NscCk7DQo+PiArwqDCoMKgIFNDQ0Igd29ya19zY2NiOw0KPj4g
K8KgwqDCoCBod2FkZHIgc2NjYl9sZW4gPSBzaXplb2YoU0NDQik7DQo+PiArDQo+PiArwqDC
oMKgIC8qIFByb3RlY3RlZCBndWVzdCBTQ0NCIGlzIGFsd2F5cyBzZWVuIGF0IGFkZHJlc3Mg
MCAqLw0KPg0KPiBXZWxsLCBhcyBmYXIgYXMgSSd2ZSB1bmRlcnN0b29kIGl0LCB0aGUgYWRk
cmVzcyBpcyByYXRoZXIgaWdub3JlZCAoYW5kIA0KPiB5b3UgY2FuIG9ubHkgc3BlY2lmeSBh
biBvZmZzZXQgaW50byB0aGUgNGsgcGFnZSk/DQoNCg0KWW91IGNhbiBzZWUgaXQgbGlrZSB0
aGlzLCB0aGVuIHRoZSBvZmZzZXQgaXMgMC4gSG93ZXZlciB3ZSBnaXZlIGhlcmUgYW4gDQph
ZGRyZXNzIGFzIGFyZ3VtZW50Lg0KDQoNCj4NCj4+ICsgczM5MF9jcHVfdmlydF9tZW1fcmVh
ZChlbnZfYXJjaGNwdShlbnYpLCAwLCAwLCAmd29ya19zY2NiLCBzY2NiX2xlbik7DQo+PiAr
wqDCoMKgIHNjbHBfYy0+ZXhlY3V0ZShzY2xwLCAmd29ya19zY2NiLCBjb2RlKTsNCj4+ICvC
oMKgwqAgczM5MF9jcHVfdmlydF9tZW1fd3JpdGUoZW52X2FyY2hjcHUoZW52KSwgMCwgMCwg
Jndvcmtfc2NjYiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYmUxNl90b19jcHUod29ya19zY2NiLmgubGVuZ3RoKSk7DQo+
PiArDQo+PiArwqDCoMKgIHNjbHBfYy0+c2VydmljZV9pbnRlcnJ1cHQoc2NscCwgKHVpbnQ2
NF90KSZ3b3JrX3NjY2IpOw0KPj4gK8KgwqDCoCByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+
PiDCoCBpbnQgc2NscF9zZXJ2aWNlX2NhbGwoQ1BVUzM5MFhTdGF0ZSAqZW52LCB1aW50NjRf
dCBzY2NiLCB1aW50MzJfdCANCj4+IGNvZGUpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIFND
TFBEZXZpY2UgKnNjbHAgPSBnZXRfc2NscF9kZXZpY2UoKTsNCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L3MzOTB4L3NjbHAuaCBiL2luY2x1ZGUvaHcvczM5MHgvc2NscC5oDQo+PiBp
bmRleCBjNTQ0MTNiNzhjLi5jMGEzZmFhMzdkIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9o
dy9zMzkweC9zY2xwLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvczM5MHgvc2NscC5oDQo+PiBA
QCAtMjE3LDUgKzIxNyw3IEBAIHZvaWQgczM5MF9zY2xwX2luaXQodm9pZCk7DQo+PiDCoCB2
b2lkIHNjbHBfc2VydmljZV9pbnRlcnJ1cHQodWludDMyX3Qgc2NjYik7DQo+PiDCoCB2b2lk
IHJhaXNlX2lycV9jcHVfaG90cGx1Zyh2b2lkKTsNCj4+IMKgIGludCBzY2xwX3NlcnZpY2Vf
Y2FsbChDUFVTMzkwWFN0YXRlICplbnYsIHVpbnQ2NF90IHNjY2IsIHVpbnQzMl90IA0KPj4g
Y29kZSk7DQo+PiAraW50IHNjbHBfc2VydmljZV9jYWxsX3Byb3RlY3RlZChDUFVTMzkwWFN0
YXRlICplbnYsIHVpbnQ2NF90IHNjY2IsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgY29kZSk7
DQo+PiDCoCDCoCAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvczM5MHgva3ZtLmMg
Yi90YXJnZXQvczM5MHgva3ZtLmMNCj4+IGluZGV4IDBjOWQxNGI0YjEuLjU1OWY0NzBmNTEg
MTAwNjQ0DQo+PiAtLS0gYS90YXJnZXQvczM5MHgva3ZtLmMNCj4+ICsrKyBiL3RhcmdldC9z
MzkweC9rdm0uYw0KPj4gQEAgLTExNzAsNyArMTE3MCwxNCBAQCBzdGF0aWMgaW50IGt2bV9z
Y2xwX3NlcnZpY2VfY2FsbChTMzkwQ1BVICpjcHUsIA0KPj4gc3RydWN0IGt2bV9ydW4gKnJ1
biwNCj4+IMKgwqDCoMKgwqAgc2NjYiA9IGVudi0+cmVnc1tpcGJoMCAmIDB4Zl07DQo+PiDC
oMKgwqDCoMKgIGNvZGUgPSBlbnYtPnJlZ3NbKGlwYmgwICYgMHhmMCkgPj4gNF07DQo+PiDC
oCAtwqDCoMKgIHIgPSBzY2xwX3NlcnZpY2VfY2FsbChlbnYsIHNjY2IsIGNvZGUpOw0KPj4g
K8KgwqDCoCBzd2l0Y2ggKHJ1bi0+czM5MF9zaWVpYy5pY3B0Y29kZSkgew0KPj4gK8KgwqDC
oCBjYXNlIElDUFRfUFZfSU5TVFI6DQo+PiArwqDCoMKgwqDCoMKgwqAgciA9IHNjbHBfc2Vy
dmljZV9jYWxsX3Byb3RlY3RlZChlbnYsIHNjY2IsIGNvZGUpOw0KPj4gK8KgwqDCoMKgwqDC
oMKgIGJyZWFrOw0KPj4gK8KgwqDCoCBkZWZhdWx0Og0KPj4gK8KgwqDCoMKgwqDCoMKgIHIg
PSBzY2xwX3NlcnZpY2VfY2FsbChlbnYsIHNjY2IsIGNvZGUpOw0KPj4gK8KgwqDCoMKgwqDC
oMKgIGJyZWFrOw0KPj4gK8KgwqDCoCB9DQo+DQo+IFdoeSBub3Qgc2ltcGx5DQo+DQo+IMKg
wqDCoCBpZiAocnVuLT5zMzkwX3NpZWljLmljcHRjb2RlID09IElDUFRfUFZfSU5TVFIpIHsN
Cj4gwqDCoMKgwqDCoMKgwqAgciA9IHNjbHBfc2VydmljZV9jYWxsX3Byb3RlY3RlZChlbnYs
IHNjY2IsIGNvZGUpOw0KPiDCoMKgwqAgfSBlbHNlIHsNCj4gwqDCoMKgwqDCoMKgwqAgciA9
IHNjbHBfc2VydmljZV9jYWxsKGVudiwgc2NjYiwgY29kZSk7DQo+IMKgwqDCoCB9DQo+DQo+
IC4uLiB0aGF0J3Mgd2F5IHNob3J0IGFuZCBlYXNpZXIgdG8gcmVhZC4gT3IgZG8geW91IGV4
cGVjdCBvdGhlciANCj4gaWNwdGNvZGVzIGluIHRoZSBuZWFyIGZ1dHVyZT8NCg0KDQpObyB5
b3UgYXJlIHJpZ2h0LCBpdCBpcyBiZXR0ZXIsIEkganVzdCBsaWtlIHN3aXRjaGVzIDopDQoN
Cg0KPg0KPj4gwqDCoMKgwqDCoCBpZiAociA8IDApIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBrdm1fczM5MF9wcm9ncmFtX2ludGVycnVwdChjcHUsIC1yKTsNCj4+IMKgwqDCoMKgwqAg
fSBlbHNlIHsNCj4+IEBAIC0xNTc1LDYgKzE1ODIsNDcgQEAgc3RhdGljIGludCBrdm1fczM5
MF9oYW5kbGVfc2lncChTMzkwQ1BVICpjcHUsIA0KPj4gdWludDhfdCBpcGExLCB1aW50MzJf
dCBpcGIpDQo+PiDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gwqAgfQ0KPj4gwqAgK3N0YXRp
YyBpbnQgaGFuZGxlX3NlY3VyZV9ub3RpZmljYXRpb24oUzM5MENQVSAqY3B1LCBzdHJ1Y3Qg
a3ZtX3J1biANCj4+ICpydW4pDQo+PiArew0KPj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgaXBh
MCA9IChydW4tPnMzOTBfc2llaWMuaXBhICYgMHhmZjAwKTsNCj4+ICvCoMKgwqAgdWludDhf
dCBpcGExID0gcnVuLT5zMzkwX3NpZWljLmlwYSAmIDB4MDBmZjsNCj4+ICsNCj4+ICvCoMKg
wqAgc3dpdGNoIChpcGEwKSB7DQo+PiArwqDCoMKgIGNhc2UgSVBBMF9TSUdQOiAvKiBXZSBn
ZXQgdGhlIG5vdGlmaWNhdGlvbiB0aGF0IHRoZSBndWVzdCBzdG9wICovDQo+PiArwqDCoMKg
wqDCoMKgwqAga3ZtX3MzOTBfaGFuZGxlX3NpZ3AoY3B1LCBpcGExLCBydW4tPnMzOTBfc2ll
aWMuaXBiKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+ICvCoMKgwqAgY2FzZSBJ
UEEwX0IyOiAvKiBXZSBhY2NlcHQgYnV0IGRvIG5vdGhpbmcgZm9yIEIyIG5vdGlmaWNhdGlv
bnMgKi8NCj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+ICvCoMKgwqAgZGVmYXVsdDog
LyogV2UgZG8gbm90IGV4cGVjdCBvdGhlciBpbnN0cnVjdGlvbidzIG5vdGlmaWNhdGlvbiAq
Lw0KPj4gK8KgwqDCoMKgwqDCoMKgIGt2bV9zMzkwX3Byb2dyYW1faW50ZXJydXB0KGNwdSwg
UEdNX09QRVJBVElPTik7DQo+DQo+IE1heWJlIGFkZCBhIHRyYWNlcG9pbnQgb3IgcWVtdV9s
b2dfbWFzayhMT0dfVU5JTVAsIC4uLikgb3IgQ1BVX0xPR19JTlQgDQo+IGhlcmUsIHNvIHdl
IGNhbiBzcG90IHRoaXMgY29uZGl0aW9uIG1vcmUgZWFzaWx5Pw0KPg0KPj4gK8KgwqDCoMKg
wqDCoMKgIGJyZWFrOw0KPj4gK8KgwqDCoCB9DQo+PiArwqDCoMKgIHJldHVybiAwOw0KPj4g
K30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGhhbmRsZV9zZWN1cmVfaW5zdHJ1Y3Rpb24oUzM5
MENQVSAqY3B1LCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKQ0KPj4gK3sNCj4+ICvCoMKgwqAgdW5z
aWduZWQgaW50IGlwYTAgPSAocnVuLT5zMzkwX3NpZWljLmlwYSAmIDB4ZmYwMCk7DQo+PiAr
wqDCoMKgIHVpbnQ4X3QgaXBhMSA9IHJ1bi0+czM5MF9zaWVpYy5pcGEgJiAweDAwZmY7DQo+
PiArwqDCoMKgIGludCByID0gLTE7DQo+PiArDQo+PiArwqDCoMKgIHN3aXRjaCAoaXBhMCkg
ew0KPj4gK8KgwqDCoCBjYXNlIElQQTBfQjI6DQo+PiArwqDCoMKgwqDCoMKgwqAgciA9IGhh
bmRsZV9iMihjcHUsIHJ1biwgaXBhMSk7DQo+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+
PiArwqDCoMKgIGNhc2UgSVBBMF9ESUFHOg0KPj4gK8KgwqDCoMKgwqDCoMKgIHIgPSBoYW5k
bGVfZGlhZyhjcHUsIHJ1biwgcnVuLT5zMzkwX3NpZWljLmlwYik7DQo+PiArwqDCoMKgwqDC
oMKgwqAgYnJlYWs7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgaWYgKHIgPCAw
KSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgciA9IDA7DQo+PiArwqDCoMKgwqDCoMKgwqAga3Zt
X3MzOTBfcHJvZ3JhbV9pbnRlcnJ1cHQoY3B1LCBQR01fT1BFUkFUSU9OKTsNCj4+ICvCoMKg
wqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gcjsNCj4+ICt9DQo+PiArDQo+PiDCoCBz
dGF0aWMgaW50IGhhbmRsZV9pbnN0cnVjdGlvbihTMzkwQ1BVICpjcHUsIHN0cnVjdCBrdm1f
cnVuICpydW4pDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpcGEwID0g
KHJ1bi0+czM5MF9zaWVpYy5pcGEgJiAweGZmMDApOw0KPj4gQEAgLTE2NjUsNiArMTcxMywx
MiBAQCBzdGF0aWMgaW50IGhhbmRsZV9pbnRlcmNlcHQoUzM5MENQVSAqY3B1KQ0KPj4gwqDC
oMKgwqDCoCBEUFJJTlRGKCJpbnRlcmNlcHQ6IDB4JXggKGF0IDB4JWx4KVxuIiwgaWNwdF9j
b2RlLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGxvbmcpY3MtPmt2bV9ydW4t
PnBzd19hZGRyKTsNCj4+IMKgwqDCoMKgwqAgc3dpdGNoIChpY3B0X2NvZGUpIHsNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgIGNhc2UgSUNQVF9QVl9JTlNUUl9OT1Q6DQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByID0gaGFuZGxlX3NlY3VyZV9ub3RpZmljYXRpb24oY3B1LCBydW4p
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiArwqDCoMKgwqDCoMKg
wqAgY2FzZSBJQ1BUX1BWX0lOU1RSOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9
IGhhbmRsZV9zZWN1cmVfaW5zdHJ1Y3Rpb24oY3B1LCBydW4pOw0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBJQ1BUX0lO
U1RSVUNUSU9OOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGhhbmRsZV9p
bnN0cnVjdGlvbihjcHUsIHJ1bik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsNCj4+DQo+DQo+IMKgVGhvbWFzDQo+DQo+DQotLSANClBpZXJyZSBNb3JlbA0KSUJN
IExhYiBCb2VibGluZ2VuDQoNCg==

