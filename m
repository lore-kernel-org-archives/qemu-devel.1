Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C4C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA9D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IHLPLbZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA9D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxbw4-0007dp-I4
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 14:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hxbve-0007Dt-TY
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hxbve-0001dG-1o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:53:54 -0400
Received: from mail-eopbgr780123.outbound.protection.outlook.com
 ([40.107.78.123]:6328 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hxbvd-0001cn-N6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:53:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlDZ8vfIUFz/gjetVlPJQUCmDH/xQ1M4gRCRk5yI6EJKYfaxaRDytFYSzcYJXGFfPj2TyTmwCPkL4gRE8I+gUN3P/V9lGnnvD2F7VYi7WkCu4IYBXZoTvXxSEjCqR/RLshStu/MSfYYH7OkzE2HffLPeaA33Dc8aKaEardHSq9WilbVzfBoxbXkEjlIgLnLaEVKrOFxJmrAlmhQZXtKnThodgU/wnHjuMFT8IrQGnO22KM/XrrVsncGkNIaw4AZ9rf7HsVFzdARkI4vZilKUhewf24+49MUE4PoyiWjmh6KM81HYjUY7y0r0Yg3j49TpvGDsneV9JxcSZi+SmFELew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnyriQZH9ZiU2SuCmrRZlCZETGbsX/Guqb12lQ5NGJs=;
 b=ZqAXIUCmP6QNH/tyeS+p0O1nNNhwX4iTo2UozJJOtZWxfhsmd+8Yu80JzZNNPg5ZHOtZg/lIa40Sx0hWPFszJqz0Fnj9bi9aSrW7CSAz4chYh/NrT4dtIqmhL2eMT1EaVNXZNA6PqcNRCnk6lN3sW7kO3Z2HJ1tKCexHT7Te47+WMODRz+HgBulngFC+ivuhBk8CSOPO8snltRdc45c87Xfv/bTRXJTfV+ENYxgrcFBFaJCd4E5be8i34az0Tr1sRXuTBPdvyoIIl0RBYFmV5KUqipbs4RdeeKeB035byJojSyIbvt0mm1t4R9F5lq6siSQx45GogWR5lIWAd/DGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnyriQZH9ZiU2SuCmrRZlCZETGbsX/Guqb12lQ5NGJs=;
 b=IHLPLbZT7tncra85+tRtExrUot/7rQDtwTQs/hjFSXvp05UPEvufU6ZBYCkooQ2Vrec6PQ8nqMIVCNIkiV0kJK2vBDk+W6BumTLpzrZ1nrLbHjPN4D1/AxbdwG+a+89Q5SP8FqSuuru7odtGrQWiYZmnqe5Db1VvwRAc+MQczvo=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2582.namprd03.prod.outlook.com (10.173.41.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 18:53:51 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 18:53:51 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "stefanha@gmail.com" <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [RFC PATCH v2 04/17] fuzz: Skip modules that were
 already initialized
Thread-Index: AQHVS1zyeePe8eajFEyVAJES1NtnGqbyjDUAgAbt8YA=
Date: Tue, 13 Aug 2019 18:53:51 +0000
Message-ID: <6dd76b32f07c5eb620e2a09216d4d329fd609bab.camel@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-5-alxndr@bu.edu>
 <20190809090436.GG25286@stefanha-x1.localdomain>
In-Reply-To: <20190809090436.GG25286@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43bf3225-170d-427a-33a7-08d7201f9517
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2582; 
x-ms-traffictypediagnostic: CY4PR03MB2582:
x-microsoft-antispam-prvs: <CY4PR03MB2582D5375F68E78246979F69BAD20@CY4PR03MB2582.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(76116006)(54906003)(66556008)(256004)(478600001)(66476007)(8936002)(3846002)(66446008)(1730700003)(8676002)(64756008)(6116002)(91956017)(53936002)(81166006)(66946007)(4326008)(81156014)(25786009)(1411001)(1361003)(75432002)(99286004)(118296001)(36756003)(6246003)(66066001)(786003)(316002)(486006)(476003)(2616005)(5660300002)(2501003)(14454004)(186003)(5640700003)(11346002)(102836004)(26005)(76176011)(2906002)(305945005)(6506007)(86362001)(7736002)(2351001)(229853002)(88552002)(6486002)(6512007)(4744005)(6916009)(6436002)(71200400001)(446003)(71190400001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2582;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p04gT9xjIyo0KzI2VX7RSs2i3bYoMNt8Lve1ZYCs4uOzMo2WFVtNr0ehzdtU//FkIO8vF+Y+fhxR8C7F4Ks18tHJl2TEtV24GEEQO1J8V5SwJ7OSL/+MC8odwtk/Bx6UNS1JW/tzWsYlxJCH/Wl5ZSuPBEYbryg2r6FQer/gIWqZTSSA+ZTqGLpORUQsdiWNQ8YVFp/RQ9KaGbfWk0ww70dAJ6exGoljHJOS1vONHD2/O7P3HUn0G0Omq5pClAtmdt1D6AcmLDNv8ox3RGTj0V96Fit00z67DQlBa1u+OWoFjmyDLFHlsz+eX/ARZ5Ax5OSYb27hhXpmDLV1I+n7IiSRwJakOLHTMic9ugewTmwaTVrTPVsA3NX7AaSbZSRHAZ61kgPBxjHtf/swvbiDfxmefuCYnjVBnnEqG87JU0g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8079376CA75434DA0CF10BB8419BC1C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf3225-170d-427a-33a7-08d7201f9517
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 18:53:51.2765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vPjYBX/S+TFuYXpxuUIT4oEngMStBHhYmbM8dgA0+OKoCMYcunS+RKsgNkuFEjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2582
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.123
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/17] fuzz: Skip modules that were
 already initialized
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA4LTA5IGF0IDEwOjA0ICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDA1LCAyMDE5IGF0IDA3OjExOjA1QU0gKzAwMDAsIE9sZWluaWssIEFs
ZXhhbmRlciB3cm90ZToNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgT2xlaW5payA8YWx4
bmRyQGJ1LmVkdT4NCj4gPiAtLS0NCj4gPiAgdXRpbC9tb2R1bGUuYyB8IDcgKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBXaHkgaXMgdGhpcyBuZWNl
c3Nhcnk/ICBFeGlzdGluZyBjYWxsZXJzIG9ubHkgaW52b2tlIHRoaXMgZnVuY3Rpb24NCj4gb25j
ZQ0KPiBmb3IgZWFjaCB0eXBlLg0KVGhpcyB3YXMgc3VnZ2VzdGVkIGJ5IFBhb2xvIGluIE1lc3Nh
Z2UtSUQ6DQpmYWQ5ZDEyYS0zOWRmLWUyZmEtMDY0Yi01MTMyYWRkOWRhZmZAcmVkaGF0LmNvbQ0K
DQpJIG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUgUU9TIG1vZHVsZSBpbiB0aGUgZnV6emVyIG1haW4g
dG8gaWRlbnRpZnkgdGhlDQpxZW11IGFyZ3VtZW50cywgcHJpb3IgdG8gcnVubmluZyB2bC5jOm1h
aW4uDQo+IFBsZWFzZSBpbmNsdWRlIGp1c3RpZmljYXRpb24gaW4gdGhlIGNvbW1pdCBkZXNjcmlw
dGlvbi4NCldpbGwgZG8NCj4gU3RlZmFuDQoNCg==

