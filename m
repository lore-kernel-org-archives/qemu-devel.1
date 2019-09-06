Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B60C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D63020838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CEoNzp9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jq4-0006FK-6S
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jf9-000380-T2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jf8-0004M2-Nq
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:51 -0400
Received: from mail-eopbgr750082.outbound.protection.outlook.com
 ([40.107.75.82]:59016 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jf8-0004LZ-IS
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbzxCXQqmWBSPb/fG/dVZqkuzF6axRtnMi632zqB48HEJImSEhmy3U6vAcagsygUFuwQAB6iKiexbcvDocwurnP+9U4z8NLLobjWH0ZZkBPJDIRCsb8QqpEmgHKMuAyaTM2u2iOYBjZaD9LOdGRwmd/r0WwHL9sUjcJ3PlPqZ/jrXwBELMcMO/6D11rFkOajYduTA/rWIfKrLNGKPuVghwvLGhitESaGO/He0muTM0teDKFqea+sur4C8yGDQ4ThZ7hbKmm2C9wtxRCMgqgk3xWHaeqeXOO6weY12dLYXY6D5m5myrTjuJcnLc7bIRFZit4lIjdt+408mHLbnyz+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxsJhqLR+BfQ+IqEOrYydyQCvANIoJcfhC7kDyB/VLY=;
 b=j49pNs0rphfSByLhUNVqx4t62mcgZX2S6t++V3+2HuDENvdrktXmCuH1UhBnRdSqe3s25r5c1ioxGDXSnInnzsqPh1iFSVbeyng8FYNPWux/U7Ta9gW6QXqcBdg7kSBeB/zf+KS0L71rTttHgNVQaKJ4s24VV7ueS4mawPWGeGmpLRREXMZDP8jUMVghXkqNNSmGMIdQ/oAlmaw+6nseic8MuQr6onIQGjqccxwjQZgF+RjBOBSGbUESXd/RoRSa+kNKsgoI80dc4dD96tmkeeG55hQxMkPTqpEUBxkoFpQrgOjnfVIPGrd21idCmkgPCCJAtnu/60MfUvqD/Lvc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxsJhqLR+BfQ+IqEOrYydyQCvANIoJcfhC7kDyB/VLY=;
 b=CEoNzp9KNuLn0DppWHA0vlDzMJaMGu39q/cRVDamq4XrC37wVF7Jke14AZCeIvqAIluE5CRWBOYqrfXb5TFY2HNsFp78pzMU4txnpb7AOi7V6PQhJh2ZFJRlxbseMS3hUgrgM5UjNXLlI7UHUuNmZZF5XcnocF8dz+IAcxM42B0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:12:48 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:12:48 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 10/16] hw/i386: Introduce apicid_from_cpu_idx in
 PCMachineState
Thread-Index: AQHVZOcSApWPC/FakEeb0y+1mx+yAw==
Date: Fri, 6 Sep 2019 19:12:48 +0000
Message-ID: <156779716561.21957.7845498562538992402.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0020.namprd06.prod.outlook.com
 (2603:10b6:803:2f::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b079fc1a-0f2b-4734-367d-08d732fe33ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1145F16F004E5F9B63105E1A95BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(14444005)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2qKJHO0Or4hk7upgUBqQkr1SVP9IuLgjBOsdujBhI4PTynTNUs4weEWsWwga8tudzvypN7rlOn7iW1/W7g4gUACTBIombwaVepDDwUyqobBTU9GMNKiSMSyF8CTokR9y3Kv6UQLDKtKMzbM3/QtSnqB6wXwdoGDIqDCuePca687TL8vxuZGN+sb0E8JlN5s2EDvyj0SESAg01WKNwneZR5gftXW5Gvw56FdKPS6T9zj/jPbRpxWKW7NNycmPs9KvVAY4ILk7aoo7+L8r34n4x+bn+XVumcjidYDZJG2il+PvRThIoDDHcPncyCRBaHUQLxl96VGWuV5jP1DQLiAH5U5duOZrCPWarWxieKTJ3x/8lZxlg81bk+MEVMqeASQB4TO6hCZLqWZ+ttPYc6777tRSSYslYk2p0xdvXlob2r8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2205F9627BE0F9409A6F5DEF4D240172@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b079fc1a-0f2b-4734-367d-08d732fe33ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:12:48.4128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjFmlwqHx1wgfSGSTPmPHSweZdBxRYPzs15oFh9SsQd08I9mUvQkKj/YZ650kNE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.82
Subject: [Qemu-devel] [RFC 2 PATCH 10/16] hw/i386: Introduce
 apicid_from_cpu_idx in PCMachineState
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

QWRkIGZ1bmN0aW9uIHBvaW50ZXJzIGluIFBDTWFjaGluZVN0YXRlIHRvIGhhbmRsZSBhcGljIGlk
IHNwZWNpZmljDQpmdW5jdGlvbmFsaXRpZXMuIFRoaXMgd2lsbCBiZSB1c2VkIHRvIGluaXRpYWxp
emUgd2l0aCBjb3JyZWN0DQpoYW5kbGVycyBiYXNlZCBvbiBtb2RlIHNlbGVjdGVkLg0KDQp4ODZf
YXBpY2lkX2Zyb21fY3B1X2lkeCB3aWxsIGJlIGRlZmF1bHQgaGFuZGxlci4NCg0KU2lnbmVkLW9m
Zi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KLS0tDQogaHcvaTM4Ni9wYy5j
ICAgICAgICAgfCAgICA1ICsrKystDQogaW5jbHVkZS9ody9pMzg2L3BjLmggfCAgICA0ICsrKysN
CiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9wYy5jIGIvaHcvaTM4Ni9wYy5jDQppbmRleCA1MDRlMWFiMDgzLi42
OWE2YjgyMTg2IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9wYy5jDQorKysgYi9ody9pMzg2L3BjLmMN
CkBAIC05NDcsNyArOTQ3LDcgQEAgc3RhdGljIHVpbnQzMl90IHg4Nl9jcHVfYXBpY19pZF9mcm9t
X2luZGV4KFBDTWFjaGluZVN0YXRlICpwY21zLA0KIA0KICAgICBpbml0aWFsaXplX3RvcG9faW5m
bygmdG9wb19pbmZvLCBwY21zLCBtcyk7DQogDQotICAgIGNvcnJlY3RfaWQgPSB4ODZfYXBpY2lk
X2Zyb21fY3B1X2lkeCgmdG9wb19pbmZvLCBjcHVfaW5kZXgpOw0KKyAgICBjb3JyZWN0X2lkID0g
cGNtcy0+YXBpY2lkX2Zyb21fY3B1X2lkeCgmdG9wb19pbmZvLCBjcHVfaW5kZXgpOw0KICAgICBp
ZiAocGNtYy0+Y29tcGF0X2FwaWNfaWRfbW9kZSkgew0KICAgICAgICAgaWYgKGNwdV9pbmRleCAh
PSBjb3JyZWN0X2lkICYmICF3YXJuZWQgJiYgIXF0ZXN0X2VuYWJsZWQoKSkgew0KICAgICAgICAg
ICAgIGVycm9yX3JlcG9ydCgiQVBJQyBJRHMgc2V0IGluIGNvbXBhdGliaWxpdHkgbW9kZSwgIg0K
QEAgLTI4MjgsNiArMjgyOCw5IEBAIHN0YXRpYyB2b2lkIHBjX21hY2hpbmVfaW5pdGZuKE9iamVj
dCAqb2JqKQ0KICAgICBwY21zLT5waXRfZW5hYmxlZCA9IHRydWU7DQogICAgIHBjbXMtPnNtcF9k
aWVzID0gMTsNCiANCisgICAgLyogSW5pdGlhbGl6ZSB0aGUgYXBpYyBpZCByZWxhdGVkIGhhbmRs
ZXJzICovDQorICAgIHBjbXMtPmFwaWNpZF9mcm9tX2NwdV9pZHggPSB4ODZfYXBpY2lkX2Zyb21f
Y3B1X2lkeDsNCisNCiAgICAgcGNfc3lzdGVtX2ZsYXNoX2NyZWF0ZShwY21zKTsNCiB9DQogDQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L3BjLmggYi9pbmNsdWRlL2h3L2kzODYvcGMuaA0K
aW5kZXggODU5YjY0YzUxZC4uNmNlZmVmZGQ1NyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvaTM4
Ni9wYy5oDQorKysgYi9pbmNsdWRlL2h3L2kzODYvcGMuaA0KQEAgLTE3LDYgKzE3LDcgQEANCiAj
aW5jbHVkZSAiaHcvbWVtL3BjLWRpbW0uaCINCiAjaW5jbHVkZSAiaHcvbWVtL252ZGltbS5oIg0K
ICNpbmNsdWRlICJody9hY3BpL2FjcGlfZGV2X2ludGVyZmFjZS5oIg0KKyNpbmNsdWRlICJody9p
Mzg2L3RvcG9sb2d5LmgiDQogDQogI2RlZmluZSBIUEVUX0lOVENBUCAiaHBldC1pbnRjYXAiDQog
DQpAQCAtNjYsNiArNjcsOSBAQCBzdHJ1Y3QgUENNYWNoaW5lU3RhdGUgew0KICAgICB1aW50NjRf
dCBudW1hX25vZGVzOw0KICAgICB1aW50NjRfdCAqbm9kZV9tZW07DQogDQorICAgIC8qIEFwaWMg
aWQgc3BlY2lmaWMgaGFuZGxlcnMgKi8NCisgICAgdWludDMyX3QgKCphcGljaWRfZnJvbV9jcHVf
aWR4KShYODZDUFVUb3BvSW5mbyAqdG9wb19pbmZvLCB1bnNpZ25lZCBjcHVfaW5kZXgpOw0KKw0K
ICAgICAvKiBBZGRyZXNzIHNwYWNlIHVzZWQgYnkgSU9BUElDIGRldmljZS4gQWxsIElPQVBJQyBp
bnRlcnJ1cHRzDQogICAgICAqIHdpbGwgYmUgdHJhbnNsYXRlZCB0byBNU0kgbWVzc2FnZXMgaW4g
dGhlIGFkZHJlc3Mgc3BhY2UuICovDQogICAgIEFkZHJlc3NTcGFjZSAqaW9hcGljX2FzOw0KDQo=

