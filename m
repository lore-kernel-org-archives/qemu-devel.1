Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9103C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867942145D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RgnjxmiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867942145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSWD-0001JC-Ib
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flosch@nutanix.com>) id 1jQSVJ-0008R1-Km
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:14:14 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <flosch@nutanix.com>) id 1jQSVE-0001GN-Kj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:14:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:37792)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1jQSVE-0001DJ-0E
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:14:08 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03K9CNbF012119
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:14:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Wl/6Rg4aAuGAR5qC9JVJhO3sbMBYIIuechwPACACUU0=;
 b=RgnjxmiJVXksS2iWHkPpQT4pvaCCw0ajKU1RCUzY7fqOYN7kl+8XFYidUSKzs5taOT88
 bUtckSRYM3R7RgUr4A8tE/Oq4YMaL55b97jnA/aguyy/oA0A061TdIblEiWQ0rHeGp0K
 nQ6dvXmC2gEDtHfHrOy97AtUTIzdFg6OhQkueAcRPS6aO8M8GE0qOunEIivWn8u6lFYg
 OcVPsANx8azRY51mOEsTYgumYfB3eP+lircnv3TV0z8sl4s6QW4AKz4TEQ2QtqYWG00/
 CSFitwt/AEInvI9C9Wcip/PnyGcWaMRn8DAGhOd1lYUGcuz9lgb6z9noocQDKmnMkvoV nA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30fwf8u5pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRBSDu4lwTEEg9rUq3PsICi7ZO38Nqx4bKeSPcjVaFj+IisV2dzup2qwXcC3H1H+8OkEqI2b+WUgmGzqGZ6ISZFn5QfQSfcFRjhIyX9eNoev+xPqq1U8XasRuBPAsOlWzEpG1UA0k63a7FIeCVhzbOrj1UAyYE1vYiWLqIxo0laIuVuFRZ8OHeP5d/ymZZa3JISIjio4oP97MKmCOvYDaFoZTKOjYAy/T0ItOrdSFr3CaUqDMwj9DddYi49CJh3FSvIYBr0Q8QK/FGLP3NUoa7UmmZqqKbzOq5FViHEXdTv+6OeHIa+CPZeMch12y199nvGqforVEf8sRPWfGtBD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl/6Rg4aAuGAR5qC9JVJhO3sbMBYIIuechwPACACUU0=;
 b=BkJCBgEKkPMI8um80d8FHD2+3ZM4R7+pvnjnchPfSWhj+IsctiyrYhQnqIWvdyB6KfD8ZF7nVT/2JbKTMr+TmGqbo6C4bPi4dmnLfT+tfub+rmfVdXyDI7hxnFQyLCLGycFzo6ru6+oOW9Qrr3lPr9SJdy/OQOE3UNEkrRidOL/9/xvm5xxFqy0Y8iNsi40Fz46ccx3B20n4dOTfctDBhpG4T1RqL1uWNGcx+tzclID3uOxHHv4gfouzowuxxWdL6ubEX19ALN1L9u1BOkmol/fQqWnCxCQKcLQoaNe7ZKg9agrrENjaFYE95rEqrOwsn4pe1DrstGxnaWUtT+e84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB3976.namprd02.prod.outlook.com (2603:10b6:a02:ff::28)
 by BYAPR02MB5544.namprd02.prod.outlook.com (2603:10b6:a03:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 09:14:01 +0000
Received: from BYAPR02MB3976.namprd02.prod.outlook.com
 ([fe80::c91f:9a1a:2f57:715e]) by BYAPR02MB3976.namprd02.prod.outlook.com
 ([fe80::c91f:9a1a:2f57:715e%5]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 09:14:01 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Postcopy with different page sizes on source and destination
Thread-Topic: Postcopy with different page sizes on source and destination
Thread-Index: AQHWFvQHltlWlbypFkKdwAXcIZ7pnw==
Date: Mon, 20 Apr 2020 09:14:01 +0000
Message-ID: <3fd5a3b0-5b1c-e123-b3d7-e8f91e3871c1@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [81.106.30.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a903c5e7-0814-4310-abf0-08d7e50b2a58
x-ms-traffictypediagnostic: BYAPR02MB5544:
x-microsoft-antispam-prvs: <BYAPR02MB554440D25B64FE3BF0A8C5C7D9D40@BYAPR02MB5544.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB3976.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(81156014)(8676002)(76116006)(91956017)(66946007)(26005)(5660300002)(316002)(64756008)(66556008)(66446008)(8936002)(478600001)(66476007)(6916009)(71200400001)(6486002)(31696002)(86362001)(36756003)(2616005)(186003)(31686004)(55236004)(6506007)(2906002)(6512007);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bC+T3jfbzt8UpaF8KnmjlZTBXWKxqaJzxyicMvVY1E38Y9RfIHXTo89s9sfMgBIVElOl6L8wmTBncz3NvthDyihOfrAMr4Y3ExnnnK9eIiWg7zlu2CdTbO6819kLPcMaS7BCI1AzXCrAtOvLKrWAjPloeBcRGM4WALTfjaaDkjoM8FGjfDYgEvSnhU8fewqwvrqXa+cK7Vayony/MsqPyROxF0584AGFjWKPi9E1d+dTgGzhmacd8P0Jw38RVc0Fmd/l1RWlWsomVDVoI34aC9wo2tz84hvhGMFdlNFtxQnwg9ClMBLRRh9r/GIaXeLQjgl/SDxiT7bHAbIz7xxVR7UpKQlx5+gO2F5/xtRf81vfwBasJhHDnvdbgFNQMdf8Par7eBTZvXs7DuCLs9aP0/5csPiyYD/etBcpbN/tgBuZ9Ye7RGabKfy/GoKmeGBN
x-ms-exchange-antispam-messagedata: kdVLxs/iuQxR5/dfbwMW7Q+FvGokqcvgp0zd7qNoaQxVXwD4oNVuzYvD4JqFmE5TmhE3kvGfCAvPYHknR1jnHlQGjFQAE7vaxKSSVr/r7Npl+S0YrLo29BNSlHpE8tND7FE5etWnNuxV/OFiBEu8eQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E8B0368DB8DF4498E7C6BB8FDB4AEB4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a903c5e7-0814-4310-abf0-08d7e50b2a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 09:14:01.0511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7gZg1q+vo+111PAUbv6To8T0nIIaXtGH97/7IN3HEhF/jMJdIfxY/mTqEgp0RhUfiKSBP1wmI92mUp2sH9jJZktoRrekPIogsXZz2eAAyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5544
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_03:2020-04-17,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 05:14:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.151.68
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

SGksDQoNCndpdGggcHJlY29weSBsaXZlIG1pZ3JhdGlvbiwgY2hhbmdlIGluIHBhZ2Ugc2l6ZSBv
biBzb3VyY2UgYW5kIA0KZGVzdGluYXRpb24gaXMgcG9zc2libGU6IHVzaW5nIGh1Z2V0bGJmcyBt
ZW1vcnkgYmFja2luZyBmb3IgdGhlIFZNIG9uIA0KdGhlIHNvdXJjZSBhbmQgYW5vbnltb3VzIG1l
bW9yeSBvbiB0aGUgZGVzdGluYXRpb24sIGFuZCB2aWNlIHZlcnNhLiBGb3IgDQpwb3N0Y29weSBt
aWdyYXRpb24sIHRoaXMgaXMgbm90IGFsbG93ZWQsIGFuZCBpbiBmYWN0IGNoZWNrZWQgZHVyaW5n
IHRoZSANCmFkdmlzZSBzdGFnZS4NCg0KSXMgdGhlcmUgYW55IGZ1bmRhbWVudGFsIGxpbWl0YXRp
b24gaW4gdGhlIGRlc2lnbiB0aGF0IHByZXZlbnRzIHRoaXMsIG9yIA0KaXMgaXQgbW9yZSB0aGF0
IHRoaXMgaXMgYW4gYWRkaXRpb25hbCBjb21wbGljYXRpb24gdGhhdCBub2JvZHkgaGFzIA0KaW1w
bGVtZW50ZWQgc28gZmFyIGJlY2F1c2UgdGhlcmUgd2FzIG5vIHN0cm9uZyBuZWVkIGZvciBpdD8N
Cg0KSXQgc2VlbXMgdG8gbWUgbGlrZSB0aGlzIHNob3VsZCBiZSBwb3NzaWJsZSwgYW5kIHRoZSBj
b21tZW50IGluIA0KbG9hZHZtX3Bvc3Rjb3B5X2hhbmRsZV9hZHZpc2UoKSAobWlncmF0aW9uL3Nh
dmV2bS5jOjE2ODEpIGFsc28gc2VlbXMgdG8gDQpzdWdnZXN0IHRoYXQ7IHNvIEknbGwgYWRkIGEg
KHZlcnkgcm91Z2gpIGZpcnN0IGlkZWEuIFBsZWFzZSB0ZWxsIG1lIGlmIA0KSSdtIG1pc3Npbmcg
c29tZXRoaW5nIGltcG9ydGFudC4gVGhlICJiYWNrZ3JvdW5kIiBjb3B5IGlzIHNpbWlsYXIgdG8g
DQpwcmVjb3B5LCBzbyB0aGUgbWFpbiBkaWZmZXJlbmNlIGlzIHRoZSB1c2VyZmF1bHRmZCBwYWdl
IGZhdWx0IGhhbmRsaW5nIA0Kb24gdGhlIGRlc3RpbmF0aW9uLCBhbmQgcmVxdWVzdGluZyB0aGUg
Y29ycmVjdCBtZW1vcnkgZnJvbSB0aGUgc291cmNlLg0KDQoxLiBJZiB0aGUgc291cmNlIGhhcyBo
dWdlcGFnZXMgYW5kIHRoZSBkZXN0aW5hdGlvbiBkb2Vzbid0LCB0aGVuIGEgcGFnZSANCmZhdWx0
IHdvdWxkIGxlYWQgdGhlIGRlc3RpbmF0aW9uIHRvIGFzayAiSSBuZWVkIHRoZXNlIDRrIG9mIG1l
bW9yeSBmcm9tIA0KeW91IHRvIGZpbGwgbXkgcGFnZSBhbmQgaGFuZGxlIHRoZSBwYWdlIGZhdWx0
Ii4gVGhlIHNvdXJjZSBjb3VsZCB0aGVuIA0KYW5zd2VyICJoZXJlIHlvdSBhcmUsIGFuZCBoZXJl
IGFyZSB0aGVzZSBvdGhlciA1MTEgNGsgcGFnZXMgYXJvdW5kIGl0IA0KKHdoaWNoIGZvcm0gbXkg
Mk0gcGFnZTsgc2ltaWxhcmx5IGZvciAxRyBwYWdlcyksIHBsZWFzZSBkZWFsIHdpdGggdGhlbSAN
Cm5vdyIuIFRoYXQgd2F5LCBldmVuICJyZWxlYXNlLXJhbSIgd291bGQgc3RpbGwgd29yayBvbiBh
IChodWdlKXBhZ2UgDQpncmFudWxhcml0eS4NCg0KMi4gSWYgdGhlIGRlc3RpbmF0aW9uIGhhcyBo
dWdlcGFnZXMgYW5kIHRoZSBzb3VyY2UgZG9lc24ndCwgdGhlbiB0aGUgDQphYm92ZSB3b3JrcyBz
aW1pbGFybHk6IG5vdyB0aGUgZGVzdGluYXRpb24sIG9uIGEgcGFnZSBmYXVsdCwgYXNrcyBmb3Ig
YSANCmxhcmdlciBtZW1vcnkgYXJlYSB0aGF0IGNvcnJlc3BvbmRzIHRvIDUxMiAob3IgbW9yZSkg
cGFnZXMgb24gdGhlIA0Kc291cmNlLiBUaGUgb25seSBpc3N1ZSBJIGNvdWxkIHNlZSBoZXJlIGlz
IGR1cmluZyB0aGUgaW5pdGlhbCBwaGFzZSwgDQp3aGVuIHBvc3Rjb3B5IGlzIHN3aXRjaGVkIG9u
LCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgc291cmNlIGRvZXNuJ3QgDQpyZWxlYXNlIFJBTSB0aGF0
IGl0IGhhcyBjb3BpZWQgYW5kIHRoaW5rcyBpcyBjbGVhbiwgYnV0IGl0IHBhcnQgb2YgYSANCmh1
Z2VwYWdlIG9uIHRoZSBvdGhlciBzaWRlLiBUaGF0IHNlZW1zIGVhc3kgZW5vdWdoIHRvIHNvbHZl
IHRob3VnaD8gQW5kIA0KaW5kZWVkIGlzIHByb2JhYmx5IGFscmVhZHkgaW1wbGVtZW50ZWQgZm9y
IHByZWNvcHkgbWlncmF0aW9uIHRvIHdvcmsgDQp3aXRoIGRpZmZlcmVudCBwYWdlIHNpemVzIG9u
IHNvdXJjZSBhbmQgZGVzdGluYXRpb24gYW5kIGNvdWxkIGJlIGFkYXB0ZWQgDQpoZXJlLg0KDQpD
aGVlcnMsDQpGbG9yaWFuDQo=

