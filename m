Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633D4C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2795120838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IZ0l6Q3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2795120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jrx-0000TL-VV
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JfV-0003Kk-FL
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JfU-0004Sh-Bg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:13 -0400
Received: from mail-co1nam05on060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe50::60b]:37952
 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6JfU-0004SN-2b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh6bZB88rlp7GzrwYEDAv2NB3pbMuow9xkk+z/EQhSyEd+ngIpeWtP+9qDasfVn3uNjUQIBCPXGbNtmjpFOdus2kzhivLhN3a69jKTQpIiEoTPJTRXZWinw+1QG0fwiewbGEwEtlm5O7PWHQHLfToUHgVrlcWgGhFLleX5PY6/AjSh7m7+wUBVUTA56sR2+tMoUhQE0zMhk5pTlIRNJh9UZxfp0RdX4evzjm2cBIfQVUXlbzYDDCDGLzxojZxnQDrJGUUIDPqeIGnnkE8Slr6GSdfWT5B0/OQ0QCwFesTiJPRE9PRa4QEjOvZ1OqIdNwZAsTWy7iGGx9HC9l5eVVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIs8QuXOl0YxiPe9vchE7TRrwCsQMczUUijzLQBEAJ4=;
 b=Pvow49BFDFsMpCfPVYvCw34fRMeoIbg5Gusd3me81yHcloW8KjX0chT9b+v0MAIAy6FjdbBr9EYS9Sdb8rT235L/RkNNVwvwOUF2Dkf2Wi3qSfIMDeZyY9hLyOSPuYjL5+VZTywgpQhHn+F7fs0fnGOdGS4kycQ8paCwjignkYwE/kaTrkcrVlhLHriuWLVCGT7iYqbu96YCmwt9GYXveDS5nWJ1NWQg39DCzPM7Sfi+5ACARvtb6VcXoGk0GhQu38+e2pruLkNazHuBQ5vOIgzHuS5m9bE1CnDghmYmy2qTpFtfro/mE5P2ns/lzYVw68b5qewvpYdyED3gkmpd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIs8QuXOl0YxiPe9vchE7TRrwCsQMczUUijzLQBEAJ4=;
 b=IZ0l6Q3In8/8LrJz3uRAWw1cxkB/HW4CHMbDxiqYu3i+iRB+5i+s34aJHS3Fyzf3+LG5mZNDaZBG7FolVWVqerNb53RBSDZAhyPDSW5CgBIcATe/cZ9tzUuOsgpuiRa5sYGKw0Jzr9lOf1ZBDNjUD6qDcweL74cDmWdecDjhLBw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1179.namprd12.prod.outlook.com (10.168.234.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:13:09 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:13:09 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 13/16] machine: Add new epyc property in
 PCMachineState
Thread-Index: AQHVZOceIuce90DAyEeExN49RF5ewg==
Date: Fri, 6 Sep 2019 19:13:09 +0000
Message-ID: <156779718791.21957.9675425538561156773.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:805:8e::45) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 183874bd-4453-4508-a1d3-08d732fe4131
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1179; 
x-ms-traffictypediagnostic: DM5PR12MB1179:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11796A37A6DC5341FAB827EE95BA0@DM5PR12MB1179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(6116002)(103116003)(76176011)(305945005)(86362001)(256004)(2201001)(71190400001)(71200400001)(81156014)(81166006)(2906002)(476003)(3846002)(446003)(8676002)(11346002)(486006)(102836004)(7736002)(6506007)(386003)(6486002)(26005)(8936002)(5660300002)(186003)(4326008)(66066001)(6436002)(14454004)(25786009)(52116002)(9686003)(6512007)(53936002)(99286004)(2501003)(110136005)(478600001)(316002)(66476007)(64756008)(66446008)(66556008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1179;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZjMoGxUnGZD2toZVCYgyQouS/3nMU4pnp2RbSAnbtzftKEwHPjoosfbiZvpwXfVrU8JoPUHCJLQTuFRHzRw7prG6TQ0nI2lxbGNahuqBrYsBztPRCLYe/2PNeSknSRCmuvQ2ArIkIHLiOJxe1i0AOw1227JOdkW5VY6QcoEyXLgSeYu2YCmIBZTnF/eGXl16ViwzeIMpgio5epZdGuu5CmLUMygMy7lr/BDf4rGOmEPjfYXw9Lo5qf2IvnQORRJjDO8wk3D5FMye1eLPABI2TKqDUDq317y7S073rm7GZespRojFiVhVsbZqoqEu28mBwiyWDleMO1LpNNv/GXKHAiK4nc/Mc50sfXURYMkeVd4AbQf1n74qUkq5Fi/vMpo4/24dnO3G3GIy+CMPDW94JkljJtb9sl6izF1XCIP/fr8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <709F257EA469B94A9F057026B129A31C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183874bd-4453-4508-a1d3-08d732fe4131
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:13:09.4997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeEQMjyzcpsb2Ou9CVYnvi5dUWnh367HcEy/Scv1B5mTvZnLQhG5dp7kf7n7PcSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe50::60b
Subject: [Qemu-devel] [RFC 2 PATCH 13/16] machine: Add new epyc property in
 PCMachineState
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

QWRkcyBuZXcgZXB5YyBwcm9wZXJ0eSBpbiBQQ01hY2hpbmVTdGF0ZSBhbmQgYWxzbyBpbiBNYWNo
aW5lU3RhdGUuDQpUaGlzIHByb3BlcnR5IHdpbGwgYmUgdXNlZCB0byBpbml0aWFsaXplIHRoZSBt
b2RlIHNwZWNpZmljIGhhbmRsZXJzDQp0byBnZW5lcmF0ZSBhcGljIGlkcy4NCg0KU2lnbmVkLW9m
Zi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KLS0tDQogaHcvaTM4Ni9wYy5j
ICAgICAgICAgfCAgIDIzICsrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9ib2Fy
ZHMuaCAgfCAgICAyICsrDQogaW5jbHVkZS9ody9pMzg2L3BjLmggfCAgICAxICsNCiAzIGZpbGVz
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvcGMuYyBi
L2h3L2kzODYvcGMuYw0KaW5kZXggOTU5YmQzODIxYi4uMTQ3NjA1MjNhOSAxMDA2NDQNCi0tLSBh
L2h3L2kzODYvcGMuYw0KKysrIGIvaHcvaTM4Ni9wYy5jDQpAQCAtMjgxMCw2ICsyODEwLDIyIEBA
IHN0YXRpYyB2b2lkIHBjX21hY2hpbmVfc2V0X3BpdChPYmplY3QgKm9iaiwgYm9vbCB2YWx1ZSwg
RXJyb3IgKiplcnJwKQ0KICAgICBwY21zLT5waXRfZW5hYmxlZCA9IHZhbHVlOw0KIH0NCiANCitz
dGF0aWMgYm9vbCBwY19tYWNoaW5lX2dldF9lcHljKE9iamVjdCAqb2JqLCBFcnJvciAqKmVycnAp
DQorew0KKyAgICBQQ01hY2hpbmVTdGF0ZSAqcGNtcyA9IFBDX01BQ0hJTkUob2JqKTsNCisNCisg
ICAgcmV0dXJuIHBjbXMtPmVweWM7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIHBjX21hY2hpbmVfc2V0
X2VweWMoT2JqZWN0ICpvYmosIGJvb2wgdmFsdWUsIEVycm9yICoqZXJycCkNCit7DQorICAgIFBD
TWFjaGluZVN0YXRlICpwY21zID0gUENfTUFDSElORShvYmopOw0KKyAgICBNYWNoaW5lU3RhdGUg
Km1zID0gTUFDSElORShwY21zKTsNCisNCisgICAgcGNtcy0+ZXB5YyA9IHZhbHVlOw0KKyAgICBt
cy0+ZXB5YyA9IHZhbHVlOw0KK30NCisNCiBzdGF0aWMgdm9pZCBwY19tYWNoaW5lX2luaXRmbihP
YmplY3QgKm9iaikNCiB7DQogICAgIFBDTWFjaGluZVN0YXRlICpwY21zID0gUENfTUFDSElORShv
YmopOw0KQEAgLTMwMTUsNiArMzAzMSwxMyBAQCBzdGF0aWMgdm9pZCBwY19tYWNoaW5lX2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KIA0KICAgICBvYmplY3RfY2xhc3Nf
cHJvcGVydHlfYWRkX2Jvb2wob2MsIFBDX01BQ0hJTkVfUElULA0KICAgICAgICAgcGNfbWFjaGlu
ZV9nZXRfcGl0LCBwY19tYWNoaW5lX3NldF9waXQsICZlcnJvcl9hYm9ydCk7DQorDQorICAgIG9i
amVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfYm9vbChvYywgImVweWMiLA0KKyAgICAgICAgcGNfbWFj
aGluZV9nZXRfZXB5YywgcGNfbWFjaGluZV9zZXRfZXB5YywgJmVycm9yX2Fib3J0KTsNCisNCisg
ICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X3NldF9kZXNjcmlwdGlvbihvYywgImVweWMiLA0KKyAg
ICAgICAgIlNldCBvbi9vZmYgdG8gdXNlIGVweWMgbW9kZSIsICZlcnJvcl9hYm9ydCk7DQorDQog
fQ0KIA0KIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBwY19tYWNoaW5lX2luZm8gPSB7DQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody9ib2FyZHMuaCBiL2luY2x1ZGUvaHcvYm9hcmRzLmgNCmluZGV4IDEy
ZWI1MDMyYTUuLjAwMDFkNDJlNTAgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L2JvYXJkcy5oDQor
KysgYi9pbmNsdWRlL2h3L2JvYXJkcy5oDQpAQCAtMjk5LDYgKzI5OSw4IEBAIHN0cnVjdCBNYWNo
aW5lU3RhdGUgew0KICAgICBBY2NlbFN0YXRlICphY2NlbGVyYXRvcjsNCiAgICAgQ1BVQXJjaElk
TGlzdCAqcG9zc2libGVfY3B1czsNCiAgICAgQ3B1VG9wb2xvZ3kgc21wOw0KKyAgICBib29sIGVw
eWM7DQorDQogICAgIHN0cnVjdCBOVkRJTU1TdGF0ZSAqbnZkaW1tc19zdGF0ZTsNCiB9Ow0KIA0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9wYy5oIGIvaW5jbHVkZS9ody9pMzg2L3BjLmgN
CmluZGV4IGQ2ZjExODk5OTcuLmNmOWU3YjAwNDUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L2kz
ODYvcGMuaA0KKysrIGIvaW5jbHVkZS9ody9pMzg2L3BjLmgNCkBAIC02OCw2ICs2OCw3IEBAIHN0
cnVjdCBQQ01hY2hpbmVTdGF0ZSB7DQogICAgIHVpbnQ2NF90ICpub2RlX21lbTsNCiANCiAgICAg
LyogQXBpYyBpZCBzcGVjaWZpYyBoYW5kbGVycyAqLw0KKyAgICBib29sIGVweWM7DQogICAgIHVp
bnQzMl90ICgqYXBpY2lkX2Zyb21fY3B1X2lkeCkoWDg2Q1BVVG9wb0luZm8gKnRvcG9faW5mbywg
dW5zaWduZWQgY3B1X2luZGV4KTsNCiAgICAgdm9pZCAoKnRvcG9faWRzX2Zyb21fYXBpY2lkKShh
cGljX2lkX3QgYXBpY2lkLCBYODZDUFVUb3BvSW5mbyAqdG9wb19pbmZvLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFg4NkNQVVRvcG9JRHMgKnRvcG9faWRzKTsNCg0K

