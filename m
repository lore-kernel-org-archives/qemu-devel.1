Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0CC00307
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A020838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x0Fxmn0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jgh-0004QP-Nm
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JeR-00026m-T2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JeQ-00048M-Lj
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:07 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com
 ([40.107.75.85]:14086 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6JeQ-00048A-Gi
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edoL2oLk+SBbcOQg7BYJhU9lMKgC401+bXNL/qlcbq0vyvmAvW+3zYBAT1Fmwg+1m1jxBuyz49ZZLaCRD2bkTQv9rq7eheXHV/z7E/67zq+90raZoJBFsM7qP7FqxmjvjBf0dha4SsWjiMy7sXMRZ099pAn2PblUDpBcunjSS4tfVxdR3M4YVIDhenqCcvboomLnGLvMCj3+0nOpy7cUncLoRfqxI8EKPpD5yakqU8dh0tfugQsVGwOE44ObXWqcmArGXVIyvql7jVZ4P9YMKiO9Bd2v92NteZAHCSrtT5S6wWBVohubalF3Av21RGgjshogxn5AzLj5WHeVM8wV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwwieKg40gAfHsI/mULnbGH/hRQnzyM1XxmktU7VWiY=;
 b=BUvD3YrI4mkbdvi+j3BgqTnFNz93BqMdfte+pdQlHSikKmQazLWiNeza4t3DesFQE0Cv+hlfeVytY8M2KeD8d7Geu9fsc4zPjTdVdD0nhlYjeztEaiWlxApJfQqymvEask3PD2LlTPPuJ5zjNAPIikupvDscct+MlJ/Rvvaw1cmcvoQa9xI/fa5O5fvPiCU+MzU3rLGAZA10ueNEfrAfsDyw+3DyncNAA7x4ntRSJjzuRIGAuNih8m6bqkrbuJ2wp1CSCcWQpyusSslRcLrr340vTby/7L6ORX+bUESh9b2wkvRyPOs7Ll9f39F2naRUcPii61OuKshS/gn6IVuS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwwieKg40gAfHsI/mULnbGH/hRQnzyM1XxmktU7VWiY=;
 b=x0Fxmn0A/MypXUJVHNyl6jkF6pDr2xtGmqknP6IFgwdnq9EhhGNP0cwxXlgFm1GVnxqmbt0nN+E+z6dwzDdEaF7rtVatBNUOjw8adI9mbOgafvBseFe0K9oSoxarYxjuGnyUKYT/7hqZzyMWTmJoEeRymbf2AaQKL/YSWW7GfpY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:12:05 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:12:05 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 04/16] machine: Add SMP Sockets in CpuTopology
Thread-Index: AQHVZOb49iqY+dEK7EqEIoezGv+ilw==
Date: Fri, 6 Sep 2019 19:12:04 +0000
Message-ID: <156779712350.21957.6312199085335942636.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:805:8e::33) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85efdba0-9553-4088-e743-08d732fe1acd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11459DF87C10B5D5169CEBC695BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ud8EE0DthP2RVzUiAMqhWIKwxOjxhIBJvQMABzXR7XZGzO7HewpsmvJw/p8LSa2nTDNCLZB3fWr2A93m7GjAhRI6A8+puYvXiBgEqLl319Ur/hCDzkJ46QPR1o7sMGJFGY/R0X2K6hDH66As1wkPaT9eLA2IYP1O9sLhLgAOWn3W+VmeN55sUYnNh6Zn50PnwBqo0ris2n3xL8/oOF8flg/VZTbGL1gmaMzLHdSG67WMpXKYXRioQOnW2SjL3pzPMT8y4LgmaSkkQSJ15KgMkOj87cnDNy5eotHLEo6S5AML3L3vK9CLt4K0afya9Lj+4eB7WsULgq2gF1MP00dv7qNqw0vyY0SmwPtZkIgehPXmevmH9UGb7fVaHRkwHKc3vCEHg8/ztg0yEa2NLnL0Cm8Zfa42RVm6zO7xAnn+aDM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFBDCCB727E2B043AA3C9B4DE171081B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85efdba0-9553-4088-e743-08d732fe1acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:12:05.0147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWbzz1MIzG3R4RJYmRd/bYZMXymqKNHn2x4su72qRppMWkBieDk5QmtybT0ZWXg0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.85
Subject: [Qemu-devel] [RFC 2 PATCH 04/16] machine: Add SMP Sockets in
 CpuTopology
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U3RvcmUgdGhlICBzbXAgU29ja2V0cyBpbiBDcHVUb3BvbG9neS4gU29ja2V0IGluZm9ybWF0aW9u
DQppcyByZXF1aXJlZCB0byBidWlsZCB0aGUgY3B1IHRvcG9sb2d5IGluIG5ldyBlcHljIG1vZGUu
DQoNClNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCi0tLQ0K
IGh3L2NvcmUvbWFjaGluZS5jICAgfCAgICAxICsNCiBody9pMzg2L3BjLmMgICAgICAgIHwgICAg
MSArDQogaW5jbHVkZS9ody9ib2FyZHMuaCB8ICAgIDIgKysNCiB2bC5jICAgICAgICAgICAgICAg
IHwgICAgMSArDQogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2h3L2NvcmUvbWFjaGluZS5jIGIvaHcvY29yZS9tYWNoaW5lLmMNCmluZGV4IGM1OGE4ZTU5
NGUuLjQwMzRiN2U5MDMgMTAwNjQ0DQotLS0gYS9ody9jb3JlL21hY2hpbmUuYw0KKysrIGIvaHcv
Y29yZS9tYWNoaW5lLmMNCkBAIC03OTUsNiArNzk1LDcgQEAgc3RhdGljIHZvaWQgc21wX3BhcnNl
KE1hY2hpbmVTdGF0ZSAqbXMsIFFlbXVPcHRzICpvcHRzKQ0KICAgICAgICAgbXMtPnNtcC5jcHVz
ID0gY3B1czsNCiAgICAgICAgIG1zLT5zbXAuY29yZXMgPSBjb3JlczsNCiAgICAgICAgIG1zLT5z
bXAudGhyZWFkcyA9IHRocmVhZHM7DQorICAgICAgICBtcy0+c21wLnNvY2tldHMgPSBzb2NrZXRz
Ow0KICAgICB9DQogDQogICAgIGlmIChtcy0+c21wLmNwdXMgPiAxKSB7DQpkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9wYy5jIGIvaHcvaTM4Ni9wYy5jDQppbmRleCA5NWFhYjhlNWU3Li45ZTFjM2Y5ZjU3
IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9wYy5jDQorKysgYi9ody9pMzg2L3BjLmMNCkBAIC0xNjA5
LDYgKzE2MDksNyBAQCB2b2lkIHBjX3NtcF9wYXJzZShNYWNoaW5lU3RhdGUgKm1zLCBRZW11T3B0
cyAqb3B0cykNCiAgICAgICAgIG1zLT5zbXAuY3B1cyA9IGNwdXM7DQogICAgICAgICBtcy0+c21w
LmNvcmVzID0gY29yZXM7DQogICAgICAgICBtcy0+c21wLnRocmVhZHMgPSB0aHJlYWRzOw0KKyAg
ICAgICAgbXMtPnNtcC5zb2NrZXRzID0gc29ja2V0czsNCiAgICAgICAgIHBjbXMtPnNtcF9kaWVz
ID0gZGllczsNCiAgICAgfQ0KIA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYm9hcmRzLmggYi9p
bmNsdWRlL2h3L2JvYXJkcy5oDQppbmRleCBhNzFkMWE1M2E1Li4xMmViNTAzMmE1IDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9ody9ib2FyZHMuaA0KKysrIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KQEAg
LTI0NSwxMiArMjQ1LDE0IEBAIHR5cGVkZWYgc3RydWN0IERldmljZU1lbW9yeVN0YXRlIHsNCiAg
KiBAY3B1czogdGhlIG51bWJlciBvZiBwcmVzZW50IGxvZ2ljYWwgcHJvY2Vzc29ycyBvbiB0aGUg
bWFjaGluZQ0KICAqIEBjb3JlczogdGhlIG51bWJlciBvZiBjb3JlcyBpbiBvbmUgcGFja2FnZQ0K
ICAqIEB0aHJlYWRzOiB0aGUgbnVtYmVyIG9mIHRocmVhZHMgaW4gb25lIGNvcmUNCisgKiBAc29j
a2V0czogdGhlIG51bWJlciBvZiBzb2NrZXRzIG9uIHRoZSBtYWNoaW5lDQogICogQG1heF9jcHVz
OiB0aGUgbWF4aW11bSBudW1iZXIgb2YgbG9naWNhbCBwcm9jZXNzb3JzIG9uIHRoZSBtYWNoaW5l
DQogICovDQogdHlwZWRlZiBzdHJ1Y3QgQ3B1VG9wb2xvZ3kgew0KICAgICB1bnNpZ25lZCBpbnQg
Y3B1czsNCiAgICAgdW5zaWduZWQgaW50IGNvcmVzOw0KICAgICB1bnNpZ25lZCBpbnQgdGhyZWFk
czsNCisgICAgdW5zaWduZWQgaW50IHNvY2tldHM7DQogICAgIHVuc2lnbmVkIGludCBtYXhfY3B1
czsNCiB9IENwdVRvcG9sb2d5Ow0KIA0KZGlmZiAtLWdpdCBhL3ZsLmMgYi92bC5jDQppbmRleCA3
MTFkMmFlNWRhLi40NzNhNjg4Nzc5IDEwMDY0NA0KLS0tIGEvdmwuYw0KKysrIGIvdmwuYw0KQEAg
LTM5ODEsNiArMzk4MSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndiwgY2hhciAq
KmVudnApDQogICAgIGN1cnJlbnRfbWFjaGluZS0+c21wLm1heF9jcHVzID0gbWFjaGluZV9jbGFz
cy0+ZGVmYXVsdF9jcHVzOw0KICAgICBjdXJyZW50X21hY2hpbmUtPnNtcC5jb3JlcyA9IDE7DQog
ICAgIGN1cnJlbnRfbWFjaGluZS0+c21wLnRocmVhZHMgPSAxOw0KKyAgICBjdXJyZW50X21hY2hp
bmUtPnNtcC5zb2NrZXRzID0gMTsNCiANCiAgICAgbWFjaGluZV9jbGFzcy0+c21wX3BhcnNlKGN1
cnJlbnRfbWFjaGluZSwNCiAgICAgICAgIHFlbXVfb3B0c19maW5kKHFlbXVfZmluZF9vcHRzKCJz
bXAtb3B0cyIpLCBOVUxMKSk7DQoNCg==

