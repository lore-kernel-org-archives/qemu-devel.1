Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86927C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57755206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57755206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inPwj-0003qh-LE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1inPvu-00038N-7Y
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1inPvs-0003Qj-Ts
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:36:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14278
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1inPvs-0003Kh-LL
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:36:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 003GWFkF080132; Fri, 3 Jan 2020 11:36:15 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x9y3p0cba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2020 11:36:15 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 003GXfXD083578;
 Fri, 3 Jan 2020 11:36:14 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x9y3p0cb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2020 11:36:14 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 003Ga0qk003305;
 Fri, 3 Jan 2020 16:36:14 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2x5xp76rus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2020 16:36:14 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 003GaDCX23331084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jan 2020 16:36:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33917AE066;
 Fri,  3 Jan 2020 16:36:13 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24F39AE05F;
 Fri,  3 Jan 2020 16:36:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jan 2020 16:36:13 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] misc: use QEMU_IS_ALIGNED
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-2-marcandre.lureau@redhat.com>
 <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <7e27574c-e3fc-ea8f-7c66-c47bcbc20c1f@linux.ibm.com>
Date: Fri, 3 Jan 2020 11:36:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030152
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-001b2d01.pphosted.com id
 003GWFkF080132
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMS8zLzIwIDI6NDMgQU0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAxLzMvMjAgODozOSBBTSwgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3RlOg0KPj4gU2lnbmVk
LW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20+DQo+PiAtLS0NCj4+IMKgIGV4ZWMuY8KgwqDCoCB8IDQgKystLQ0KPj4gwqAgcm9tcy9T
TE9GIHwgMiArLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2V4ZWMuYyBiL2V4ZWMuYw0KPj4g
aW5kZXggZDRiNzY5ZDBkNC4uMWZlZGE0OWNhMSAxMDA2NDQNCj4+IC0tLSBhL2V4ZWMuYw0K
Pj4gKysrIGIvZXhlYy5jDQo+PiBAQCAtMzg5NSw3ICszODk1LDcgQEAgaW50IHJhbV9ibG9j
a19kaXNjYXJkX3JhbmdlKFJBTUJsb2NrICpyYiwgDQo+PiB1aW50NjRfdCBzdGFydCwgc2l6
ZV90IGxlbmd0aCkNCj4+IMKgIMKgwqDCoMKgwqAgdWludDhfdCAqaG9zdF9zdGFydGFkZHIg
PSByYi0+aG9zdCArIHN0YXJ0Ow0KPj4gwqAgLcKgwqDCoCBpZiAoKHVpbnRwdHJfdClob3N0
X3N0YXJ0YWRkciAmIChyYi0+cGFnZV9zaXplIC0gMSkpIHsNCj4+ICvCoMKgwqAgaWYgKCFR
RU1VX1BUUl9JU19BTElHTkVEKGhvc3Rfc3RhcnRhZGRyLCByYi0+cGFnZV9zaXplKSkgew0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgicmFtX2Jsb2NrX2Rpc2NhcmRf
cmFuZ2U6IFVuYWxpZ25lZCBzdGFydCANCj4+IGFkZHJlc3M6ICVwIiwNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhvc3Rfc3RhcnRhZGRyKTsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4+IEBAIC0zOTAzLDcgKzM5MDMs
NyBAQCBpbnQgcmFtX2Jsb2NrX2Rpc2NhcmRfcmFuZ2UoUkFNQmxvY2sgKnJiLCANCj4+IHVp
bnQ2NF90IHN0YXJ0LCBzaXplX3QgbGVuZ3RoKQ0KPj4gwqAgwqDCoMKgwqDCoCBpZiAoKHN0
YXJ0ICsgbGVuZ3RoKSA8PSByYi0+dXNlZF9sZW5ndGgpIHsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBib29sIG5lZWRfbWFkdmlzZSwgbmVlZF9mYWxsb2NhdGU7DQo+PiAtwqDCoMKgwqDC
oMKgwqAgaWYgKGxlbmd0aCAmIChyYi0+cGFnZV9zaXplIC0gMSkpIHsNCj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoIVFFTVVfSVNfQUxJR05FRChsZW5ndGgsIHJiLT5wYWdlX3NpemUpKSB7
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoInJhbV9ibG9j
a19kaXNjYXJkX3JhbmdlOiBVbmFsaWduZWQgDQo+PiBsZW5ndGg6ICV6eCIsDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlbmd0
aCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4+IGRpZmYg
LS1naXQgYS9yb21zL1NMT0YgYi9yb21zL1NMT0YNCj4+IGluZGV4IDk1NDY4OTJhODAuLjhl
YmYyZjU1ZTEgMTYwMDAwDQo+PiAtLS0gYS9yb21zL1NMT0YNCj4+ICsrKyBiL3JvbXMvU0xP
Rg0KPj4gQEAgLTEgKzEgQEANCj4+IC1TdWJwcm9qZWN0IGNvbW1pdCA5NTQ2ODkyYTgwZDVh
NGM3M2RlZWE2NzE5ZGU0NjM3MmYwMDdmNGE2DQo+PiArU3VicHJvamVjdCBjb21taXQgOGVi
ZjJmNTVlMWJhMTQ5MmI5NDJiYTRiNjgyMTYwZTY0NGZjMGY5OA0KPg0KPiBXaXRob3V0IHRo
ZSBTTE9GIHN1Ym1vZHVsZSB1cGRhdGU6DQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+DQpSZXZpZXdlZC1ieTogU3RlZmFu
IEJlcmdlciA8c3RlZmFuYkBsaW51eC5pYm0uY29tPg0KDQo=

