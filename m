Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1598C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1AB2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1AB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46853 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyMGt-0002nG-PG
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 16:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eajames@linux.ibm.com>) id 1hyMGF-0002HQ-8I
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.ibm.com>) id 1hyMGC-0003DP-RU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37226
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
 id 1hyMGC-0003CG-H2; Thu, 15 Aug 2019 16:22:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7FKHRG3095390; Thu, 15 Aug 2019 16:21:54 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uda2vtkef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Aug 2019 16:21:54 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7FKHhUO007503;
 Thu, 15 Aug 2019 20:21:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02wdc.us.ibm.com with ESMTP id 2u9nj65hbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Aug 2019 20:21:52 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7FKLq1c54657348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 20:21:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BB38136053;
 Thu, 15 Aug 2019 20:21:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4935F13604F;
 Thu, 15 Aug 2019 20:21:51 +0000 (GMT)
Received: from [9.85.177.247] (unknown [9.85.177.247])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 15 Aug 2019 20:21:51 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <1565814456-1264-1-git-send-email-eajames@linux.ibm.com>
 <ca560d31-25ca-5d48-a16a-4fdf74f4779b@kaod.org>
 <24e21dd0-55b8-a5df-57da-2d68bee204a0@linux.ibm.com>
Message-ID: <cb2d52b2-65ef-41d6-0e3f-6aefb78f4d34@linux.ibm.com>
Date: Thu, 15 Aug 2019 15:21:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <24e21dd0-55b8-a5df-57da-2d68bee204a0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-15_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=659 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150192
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0b-001b2d01.pphosted.com id
 x7FKHRG3095390
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC v2] hw/sd/aspeed_sdhci: New device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiA4LzE1LzE5IDM6MTMgUE0sIEVkZGllIEphbWVzIHdyb3RlOg0KPg0KPiBPbiA4LzE1
LzE5IDM6MDUgQU0sIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPj4gSGVsbG8gRWRkaWUs
DQo+Pg0KPj4gT24gMTQvMDgvMjAxOSAyMjoyNywgRWRkaWUgSmFtZXMgd3JvdGU6DQo+Pj4N
Cj4+PiArwqDCoMKgwqDCoMKgwqAgc2RoY2ktPnNsb3RzWzBdLmNhcGFyZWcgPSAodWludDY0
X3QpKHVpbnQzMl90KXZhbDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+Pj4gK8Kg
wqDCoCBjYXNlIEFTUEVFRF9TREhDSV9TRElPXzE0ODoNCj4+PiArwqDCoMKgwqDCoMKgwqAg
c2RoY2ktPnNsb3RzWzBdLm1heGN1cnIgPSAodWludDY0X3QpKHVpbnQzMl90KXZhbDsNCj4+
PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+Pj4gK8KgwqDCoCBjYXNlIEFTUEVFRF9TREhD
SV9TRElPXzI0MDoNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2RoY2ktPnNsb3RzWzFdLmNhcGFy
ZWcgPSAodWludDY0X3QpKHVpbnQzMl90KXZhbDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgYnJl
YWs7DQo+Pj4gK8KgwqDCoCBjYXNlIEFTUEVFRF9TREhDSV9TRElPXzI0ODoNCj4+PiArwqDC
oMKgwqDCoMKgwqAgc2RoY2ktPnNsb3RzWzFdLm1heGN1cnIgPSAodWludDY0X3QpKHVpbnQz
Ml90KXZhbDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiBJIHRoaW5rIHRoZXNl
IHJlZ3MgYXJlIHJlYWRvbmx5Lg0KPg0KPg0KPiBXZWxsIHRoZSBhY3R1YWwgcmVncyBhdCBz
bG90ICsgMHg0MC8weDQ4IGFyZSBpbmRlZWQsIGJ1dCBub3QgdGhlIA0KPiBBc3BlZWQtc3Bl
Y2lmaWMgb25lcyB0aGF0IG1pcnJvciB0aGVyZS4gSSB0aGluayB0aGUgaWRlYSBpcyB0aGF0
IA0KPiBBc3BlZWQtc3BlY2lmaWMgY29kZSBjYW4gc2V0IGl0J3MgY2FwYWJpbGl0aWVzIGRp
ZmZlcmVudGx5IGlmIGRlc2lyZWQuIA0KPiBUaGlzIG1heSBwcmV2ZW50IHRoZSB1c2Ugb2Yg
YWxpYXMgcmVnaW9ucyBoZXJlLg0KDQoNCkFjdHVhbGx5IEkgY291bGQgYmUgd3JvbmcgYWZ0
ZXIgcmVhZGluZyB0aGUgc3BlY3MgYWdhaW4uIEl0J3MgYSBsaXR0bGUgDQpjb25mdXNpbmcu
IEknbSBmaW5lIHdpdGggbWFraW5nIGl0IHJlYWQtb25seSBhbnl3YXksIEkgZG91YnQgdGhl
cmUgd2lsbCANCmJlIGFueSBjb2RlIHRoYXQgbmVlZHMgdG8gd3JpdGUgaXQuDQoNCg0KPg0K
Pg0KPj4NCj4+PiArwqDCoMKgIGRlZmF1bHQ6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChh
ZGRyIDwgQVNQRUVEX1NESENJX1JFR19TSVpFKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2RoY2ktPnJlZ3NbVE9fUkVHKGFkZHIpXSA9ICh1aW50MzJfdCl2YWw7DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0NCj4+PiArwqDCoMKgIH0NCj4+PiArfQ0KPj4+ICsNCj4+PiAr
c3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBhc3BlZWRfc2RoY2lfb3BzID0gew0KPj4+
ICvCoMKgwqAgLnJlYWQgPSBhc3BlZWRfc2RoY2lfcmVhZCwNCj4+PiArwqDCoMKgIC53cml0
ZSA9IGFzcGVlZF9zZGhjaV93cml0ZSwNCj4+PiArwqDCoMKgIC5lbmRpYW5uZXNzID0gREVW
SUNFX05BVElWRV9FTkRJQU4sDQo+Pj4gK8KgwqDCoCAudmFsaWQubWluX2FjY2Vzc19zaXpl
ID0gNCwgDQo=

