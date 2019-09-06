Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80762C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37557206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YyIRp3cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37557206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JmU-00023c-Na
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jei-0002V5-G1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jeg-0004Bo-Vr
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:24 -0400
Received: from mail-co1nam04on0610.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::610]:48565
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jeg-0004BG-Ir
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNqgs0b/cZ7Oz57hLZbCcrhapQ1ergF7GUZT5ygO9npzGyIjE6YFKz//ZNvRsXz8GD5h8NlI2oPecGj74W28L0yGumR8MLRYhoZn3MNvwVJr2mTEfHJ0LsbCUfFlYPHoP30pgRlRV16lhviKt18BqyvqA/IMFJyRhEhmCr/Nbbqh6WCjNFZ/rfbpHcCBS8jEk5Db2igLVFXGPD3yqDlOxr8C3QQc25HZmGTrlZ88gdXmz+dY6fBd0lGAYCu8lRZnP2SFZHXaHXUtnfnlYD02VLki98XyOZByQ4TPuOdDEw0SzXnqmG4El6DkS8sEeQc6mc2ZoacOt91K1jent/D8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSYSzV68VT/JKcPdzCP+s2mgj9ovKqzmkED9ddim1/8=;
 b=h02/l075vgmH3uEcl7PNUfoFP6lMH3owwlQIfcQIhadDJ7nYU7NKXO/SpVRUDAhUeKeNUnIfGX7YPxappLQ6Q0EQY7jsyXmJ/EqaxWiaSTX/1lT5OAawtosV5ZyzCWvgO6nvYxVqMdHlxVJTrnIdy6qYY7/Epx3kE6P4q8FFSbwW0BpyLlvOMTaTWvAmgaCYY2OyZH5U6cpC5bFEsFwK8/RQqKa5+Kd++3GLrvaeVmg+l0KXAW83C9WbCFMxb/dgofJKNDgDf/3QF4MOKN+TUxVZmeClpxJN4NIsf/rh5wFR35dvGu18tvrwttdQi/SfB84bpKWfLwm0bMU3UQMnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSYSzV68VT/JKcPdzCP+s2mgj9ovKqzmkED9ddim1/8=;
 b=YyIRp3cHYvY0r6sruHi5j4fc8CtTCgPyyUdl/uZWqbRupB9s9Ki8vW2qRXT0tY4A9o6Ci/M0SlpEmD2r+UWFvwrqTURKFaYdLtpQpNHUFXuca87Xy990kXXGrqYCDsisuyx4z2qsE2hY4BbS80BwvWgQ49QsMyUmtqZWoQcu/cE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:12:18 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:12:18 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 06/16] hw/core: Add core complex id in X86CPU
 topology
Thread-Index: AQHVZOcAvXBgYAx8v0mIeU+F8XEfTA==
Date: Fri, 6 Sep 2019 19:12:18 +0000
Message-ID: <156779713686.21957.6192568272184346850.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:805:8e::15) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b0ad94e-efe7-46c0-b1cc-08d732fe22cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11451AFF2483FC5F41D88D8D95BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(14444005)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m2tiSjboBFbv3l0lFPUCa/vb4cUjZpuoaPFUwMPciTyb79LhXzDrYHfDTLCK/WIyEgyk8r3c78XzNGPr4jvdRy8OKCtKkGExVruvh7M1//4Xzvyj27zbgu+CA+fAhm0YsMVfdzQ/+ZxoEVAFQuJDxZLOPqUsHgD5fsymfJWShiXmMWQ7Uz40xxOQVvTHqw2CL8tN3Gl52DRelDeJ8B8ZPaOxLMzolN+YPrD2zxqWzd3OLRRMkf8fW+UzL6LrDKEWKbDESne7DKb5nQolX/4tzqJGdj5ImMcPGRuh5PQFXeg/zTVhBoPSvHeu7DrECTgGbk0QWiqlv2mbQahO/tTfByuChICN6GBNsptXsrki18Ynn1MGI51ZmG8N+ykTUIPQElrzu3y6xt/w7QpSg2WCOd2nOqGkrzhxcwRW946hDUk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA0A58A91545D14784022548024ECBDC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0ad94e-efe7-46c0-b1cc-08d732fe22cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:12:18.4350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsiGtlpk94F3QX445J1WKikjCVLFB1FVDZV0fY+0Q0Yi/tHto8cIM0K5kuqrwqwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::610
Subject: [Qemu-devel] [RFC 2 PATCH 06/16] hw/core: Add core complex id in
 X86CPU topology
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

SW50cm9kdWNlIGNwdSBjb3JlIGNvbXBsZXggaWQoY2N4X2lkKSBpbiB4ODZDUFUgdG9wb2xvZ3ku
DQpFYWNoIENDWCBjYW4gaGF2ZSB1cHRvIDQgY29yZXMgYW5kIHNoYXJlIHNhbWUgTDMgY2FjaGUu
DQpUaGlzIGluZm9ybWF0aW9uIGlzIHJlcXVpcmVkIHRvIGJ1aWxkIHRoZSB0b3BvbG9neSBpbg0K
bmV3IGFweWMgbW9kZS4NCg0KU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBh
bWQuY29tPg0KLS0tDQogaHcvY29yZS9tYWNoaW5lLWhtcC1jbWRzLmMgfCAgICAzICsrKw0KIGh3
L2NvcmUvbWFjaGluZS5jICAgICAgICAgIHwgICAxMyArKysrKysrKysrKysrDQogaHcvaTM4Ni9w
Yy5jICAgICAgICAgICAgICAgfCAgIDEwICsrKysrKysrKysNCiBpbmNsdWRlL2h3L2kzODYvdG9w
b2xvZ3kuaCB8ICAgIDEgKw0KIHFhcGkvbWFjaGluZS5qc29uICAgICAgICAgIHwgICAgNCArKyst
DQogdGFyZ2V0L2kzODYvY3B1LmMgICAgICAgICAgfCAgICAyICsrDQogdGFyZ2V0L2kzODYvY3B1
LmggICAgICAgICAgfCAgICAxICsNCiA3IGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2NvcmUvbWFjaGluZS1obXAtY21kcy5j
IGIvaHcvY29yZS9tYWNoaW5lLWhtcC1jbWRzLmMNCmluZGV4IDFmNjZiZGEzNDYuLjZjNTM0Nzc5
YWYgMTAwNjQ0DQotLS0gYS9ody9jb3JlL21hY2hpbmUtaG1wLWNtZHMuYw0KKysrIGIvaHcvY29y
ZS9tYWNoaW5lLWhtcC1jbWRzLmMNCkBAIC04OSw2ICs4OSw5IEBAIHZvaWQgaG1wX2hvdHBsdWdn
YWJsZV9jcHVzKE1vbml0b3IgKm1vbiwgY29uc3QgUURpY3QgKnFkaWN0KQ0KICAgICAgICAgaWYg
KGMtPmhhc19kaWVfaWQpIHsNCiAgICAgICAgICAgICBtb25pdG9yX3ByaW50Zihtb24sICIgICAg
ZGllLWlkOiBcIiUiIFBSSXU2NCAiXCJcbiIsIGMtPmRpZV9pZCk7DQogICAgICAgICB9DQorICAg
ICAgICBpZiAoYy0+aGFzX2NjeF9pZCkgew0KKyAgICAgICAgICAgIG1vbml0b3JfcHJpbnRmKG1v
biwgIiAgICBjY3gtaWQ6IFwiJSIgUFJJdTY0ICJcIlxuIiwgYy0+Y2N4X2lkKTsNCisgICAgICAg
IH0NCiAgICAgICAgIGlmIChjLT5oYXNfY29yZV9pZCkgew0KICAgICAgICAgICAgIG1vbml0b3Jf
cHJpbnRmKG1vbiwgIiAgICBjb3JlLWlkOiBcIiUiIFBSSXU2NCAiXCJcbiIsIGMtPmNvcmVfaWQp
Ow0KICAgICAgICAgfQ0KZGlmZiAtLWdpdCBhL2h3L2NvcmUvbWFjaGluZS5jIGIvaHcvY29yZS9t
YWNoaW5lLmMNCmluZGV4IDQwMzRiN2U5MDMuLjlhODU4NmNmMzAgMTAwNjQ0DQotLS0gYS9ody9j
b3JlL21hY2hpbmUuYw0KKysrIGIvaHcvY29yZS9tYWNoaW5lLmMNCkBAIC02OTQsNiArNjk0LDEx
IEBAIHZvaWQgbWFjaGluZV9zZXRfY3B1X251bWFfbm9kZShNYWNoaW5lU3RhdGUgKm1hY2hpbmUs
DQogICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICAgfQ0KIA0KKyAgICAgICAgaWYgKHByb3Bz
LT5oYXNfY2N4X2lkICYmICFzbG90LT5wcm9wcy5oYXNfY2N4X2lkKSB7DQorICAgICAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiY2N4LWlkIGlzIG5vdCBzdXBwb3J0ZWQiKTsNCisgICAgICAgICAg
ICByZXR1cm47DQorICAgICAgICB9DQorDQogICAgICAgICAvKiBza2lwIHNsb3RzIHdpdGggZXhw
bGljaXQgbWlzbWF0Y2ggKi8NCiAgICAgICAgIGlmIChwcm9wcy0+aGFzX3RocmVhZF9pZCAmJiBw
cm9wcy0+dGhyZWFkX2lkICE9IHNsb3QtPnByb3BzLnRocmVhZF9pZCkgew0KICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCkBAIC03MDcsNiArNzEyLDEwIEBAIHZvaWQgbWFjaGluZV9zZXRfY3B1
X251bWFfbm9kZShNYWNoaW5lU3RhdGUgKm1hY2hpbmUsDQogICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KICAgICAgICAgfQ0KIA0KKyAgICAgICAgaWYgKHByb3BzLT5oYXNfY2N4X2lkICYmIHBy
b3BzLT5jY3hfaWQgIT0gc2xvdC0+cHJvcHMuY2N4X2lkKSB7DQorICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KKyAgICAgICAgfQ0KKw0KICAgICAgICAgaWYgKHByb3BzLT5oYXNfc29ja2V0X2lk
ICYmIHByb3BzLT5zb2NrZXRfaWQgIT0gc2xvdC0+cHJvcHMuc29ja2V0X2lkKSB7DQogICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KICAgICAgICAgfQ0KQEAgLTEwNDEsNiArMTA1MCwxMCBAQCBz
dGF0aWMgY2hhciAqY3B1X3Nsb3RfdG9fc3RyaW5nKGNvbnN0IENQVUFyY2hJZCAqY3B1KQ0KICAg
ICBpZiAoY3B1LT5wcm9wcy5oYXNfZGllX2lkKSB7DQogICAgICAgICBnX3N0cmluZ19hcHBlbmRf
cHJpbnRmKHMsICJkaWUtaWQ6ICUiUFJJZDY0LCBjcHUtPnByb3BzLmRpZV9pZCk7DQogICAgIH0N
CisNCisgICAgaWYgKGNwdS0+cHJvcHMuaGFzX2NjeF9pZCkgew0KKyAgICAgICAgZ19zdHJpbmdf
YXBwZW5kX3ByaW50ZihzLCAiY2N4LWlkOiAlIlBSSWQ2NCwgY3B1LT5wcm9wcy5jY3hfaWQpOw0K
KyAgICB9DQogICAgIGlmIChjcHUtPnByb3BzLmhhc19jb3JlX2lkKSB7DQogICAgICAgICBpZiAo
cy0+bGVuKSB7DQogICAgICAgICAgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihzLCAiLCAiKTsN
CmRpZmYgLS1naXQgYS9ody9pMzg2L3BjLmMgYi9ody9pMzg2L3BjLmMNCmluZGV4IDllMWMzZjlm
NTcuLmY3MTM4OWFkOWYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L3BjLmMNCisrKyBiL2h3L2kzODYv
cGMuYw0KQEAgLTI0NDQsNiArMjQ0NCw3IEBAIHN0YXRpYyB2b2lkIHBjX2NwdV9wcmVfcGx1ZyhI
b3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQogDQogICAgICAgICB0b3BvX2lkcy5wa2dfaWQg
PSBjcHUtPnNvY2tldF9pZDsNCiAgICAgICAgIHRvcG9faWRzLmRpZV9pZCA9IGNwdS0+ZGllX2lk
Ow0KKyAgICAgICAgdG9wb19pZHMuY2N4X2lkID0gY3B1LT5jY3hfaWQ7DQogICAgICAgICB0b3Bv
X2lkcy5jb3JlX2lkID0gY3B1LT5jb3JlX2lkOw0KICAgICAgICAgdG9wb19pZHMuc210X2lkID0g
Y3B1LT50aHJlYWRfaWQ7DQogICAgICAgICBjcHUtPmFwaWNfaWQgPSBhcGljaWRfZnJvbV90b3Bv
X2lkcygmdG9wb19pbmZvLCAmdG9wb19pZHMpOw0KQEAgLTI0ODksNiArMjQ5MCwxMyBAQCBzdGF0
aWMgdm9pZCBwY19jcHVfcHJlX3BsdWcoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KICAg
ICB9DQogICAgIGNwdS0+ZGllX2lkID0gdG9wb19pZHMuZGllX2lkOw0KIA0KKyAgICBpZiAoY3B1
LT5jY3hfaWQgIT0gLTEgJiYgY3B1LT5jY3hfaWQgIT0gdG9wb19pZHMuY2N4X2lkKSB7DQorICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJwcm9wZXJ0eSBjY3gtaWQ6ICV1IGRvZXNuJ3QgbWF0Y2gg
c2V0IGFwaWMtaWQ6Ig0KKyAgICAgICAgICAgICIgMHgleCAoY2N4LWlkOiAldSkiLCBjcHUtPmNj
eF9pZCwgY3B1LT5hcGljX2lkLCB0b3BvX2lkcy5jY3hfaWQpOw0KKyAgICAgICAgcmV0dXJuOw0K
KyAgICB9DQorICAgIGNwdS0+Y2N4X2lkID0gdG9wb19pZHMuY2N4X2lkOw0KKw0KICAgICBpZiAo
Y3B1LT5jb3JlX2lkICE9IC0xICYmIGNwdS0+Y29yZV9pZCAhPSB0b3BvX2lkcy5jb3JlX2lkKSB7
DQogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJwcm9wZXJ0eSBjb3JlLWlkOiAldSBkb2Vzbid0
IG1hdGNoIHNldCBhcGljLWlkOiINCiAgICAgICAgICAgICAiIDB4JXggKGNvcmUtaWQ6ICV1KSIs
IGNwdS0+Y29yZV9pZCwgY3B1LT5hcGljX2lkLCB0b3BvX2lkcy5jb3JlX2lkKTsNCkBAIC0yODk2
LDYgKzI5MDQsOCBAQCBzdGF0aWMgY29uc3QgQ1BVQXJjaElkTGlzdCAqcGNfcG9zc2libGVfY3B1
X2FyY2hfaWRzKE1hY2hpbmVTdGF0ZSAqbXMpDQogICAgICAgICBtcy0+cG9zc2libGVfY3B1cy0+
Y3B1c1tpXS5wcm9wcy5zb2NrZXRfaWQgPSB0b3BvX2lkcy5wa2dfaWQ7DQogICAgICAgICBtcy0+
cG9zc2libGVfY3B1cy0+Y3B1c1tpXS5wcm9wcy5oYXNfZGllX2lkID0gdHJ1ZTsNCiAgICAgICAg
IG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2ldLnByb3BzLmRpZV9pZCA9IHRvcG9faWRzLmRpZV9p
ZDsNCisgICAgICAgIG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2ldLnByb3BzLmhhc19jY3hfaWQg
PSB0cnVlOw0KKyAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0ucHJvcHMuY2N4X2lk
ID0gdG9wb19pZHMuY2N4X2lkOw0KICAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0u
cHJvcHMuaGFzX2NvcmVfaWQgPSB0cnVlOw0KICAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNw
dXNbaV0ucHJvcHMuY29yZV9pZCA9IHRvcG9faWRzLmNvcmVfaWQ7DQogICAgICAgICBtcy0+cG9z
c2libGVfY3B1cy0+Y3B1c1tpXS5wcm9wcy5oYXNfdGhyZWFkX2lkID0gdHJ1ZTsNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L2kzODYvdG9wb2xvZ3kuaCBiL2luY2x1ZGUvaHcvaTM4Ni90b3BvbG9n
eS5oDQppbmRleCBmYjEwODYzYTY2Li41YTYxZDUzZjA1IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9o
dy9pMzg2L3RvcG9sb2d5LmgNCisrKyBiL2luY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5oDQpAQCAt
MTcwLDYgKzE3MCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB4ODZfdG9wb19pZHNfZnJvbV9hcGlj
aWQoYXBpY19pZF90IGFwaWNpZCwNCiAgICAgICAgICAgICAoYXBpY2lkID4+IGFwaWNpZF9kaWVf
b2Zmc2V0KG5yX2NvcmVzLCBucl90aHJlYWRzKSkgJg0KICAgICAgICAgICAgIH4oMHhGRkZGRkZG
RlVMIDw8IGFwaWNpZF9kaWVfd2lkdGgobnJfZGllcykpOw0KICAgICB0b3BvX2lkcy0+cGtnX2lk
ID0gYXBpY2lkID4+IGFwaWNpZF9wa2dfb2Zmc2V0KG5yX2RpZXMsIG5yX2NvcmVzLCBucl90aHJl
YWRzKTsNCisgICAgdG9wb19pZHMtPmNjeF9pZCA9IDA7DQogfQ0KIA0KIC8qIE1ha2UgQVBJQyBJ
RCBmb3IgdGhlIENQVSAnY3B1X2luZGV4Jw0KZGlmZiAtLWdpdCBhL3FhcGkvbWFjaGluZS5qc29u
IGIvcWFwaS9tYWNoaW5lLmpzb24NCmluZGV4IDZkYjhhN2UyZWMuLmJiNzYyN2U2OTggMTAwNjQ0
DQotLS0gYS9xYXBpL21hY2hpbmUuanNvbg0KKysrIGIvcWFwaS9tYWNoaW5lLmpzb24NCkBAIC01
OTcsOSArNTk3LDEwIEBADQogIyBAbm9kZS1pZDogTlVNQSBub2RlIElEIHRoZSBDUFUgYmVsb25n
cyB0bw0KICMgQHNvY2tldC1pZDogc29ja2V0IG51bWJlciB3aXRoaW4gbm9kZS9ib2FyZCB0aGUg
Q1BVIGJlbG9uZ3MgdG8NCiAjIEBkaWUtaWQ6IGRpZSBudW1iZXIgd2l0aGluIG5vZGUvYm9hcmQg
dGhlIENQVSBiZWxvbmdzIHRvIChTaW5jZSA0LjEpDQorIyBAY2N4LWlkOiBjb3JlIGNvbXBsZXgg
bnVtYmVyIHdpdGhpbiBub2RlL2JvYXJkIHRoZSBDUFUgYmVsb25ncyB0byAoU2luY2UgNC4xKQ0K
ICMgQGNvcmUtaWQ6IGNvcmUgbnVtYmVyIHdpdGhpbiBkaWUgdGhlIENQVSBiZWxvbmdzIHRvIyBA
dGhyZWFkLWlkOiB0aHJlYWQgbnVtYmVyIHdpdGhpbiBjb3JlIHRoZSBDUFUgYmVsb25ncyB0bw0K
ICMNCi0jIE5vdGU6IGN1cnJlbnRseSB0aGVyZSBhcmUgNSBwcm9wZXJ0aWVzIHRoYXQgY291bGQg
YmUgcHJlc2VudA0KKyMgTm90ZTogY3VycmVudGx5IHRoZXJlIGFyZSA2IHByb3BlcnRpZXMgdGhh
dCBjb3VsZCBiZSBwcmVzZW50DQogIyBidXQgbWFuYWdlbWVudCBzaG91bGQgYmUgcHJlcGFyZWQg
dG8gcGFzcyB0aHJvdWdoIG90aGVyDQogIyBwcm9wZXJ0aWVzIHdpdGggZGV2aWNlX2FkZCBjb21t
YW5kIHRvIGFsbG93IGZvciBmdXR1cmUNCiAjIGludGVyZmFjZSBleHRlbnNpb24uIFRoaXMgYWxz
byByZXF1aXJlcyB0aGUgZmlsZWQgbmFtZXMgdG8gYmUga2VwdCBpbg0KQEAgLTYxMSw2ICs2MTIs
NyBAQA0KICAgJ2RhdGEnOiB7ICcqbm9kZS1pZCc6ICdpbnQnLA0KICAgICAgICAgICAgICcqc29j
a2V0LWlkJzogJ2ludCcsDQogICAgICAgICAgICAgJypkaWUtaWQnOiAnaW50JywNCisgICAgICAg
ICAgICAnKmNjeC1pZCc6ICdpbnQnLA0KICAgICAgICAgICAgICcqY29yZS1pZCc6ICdpbnQnLA0K
ICAgICAgICAgICAgICcqdGhyZWFkLWlkJzogJ2ludCcNCiAgIH0NCmRpZmYgLS1naXQgYS90YXJn
ZXQvaTM4Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5jDQppbmRleCA2ZDdmOWI2YjhiLi5jYTAy
YmMyMWVjIDEwMDY0NA0KLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMNCisrKyBiL3RhcmdldC9pMzg2
L2NwdS5jDQpAQCAtNTgxMSwxMiArNTgxMSwxNCBAQCBzdGF0aWMgUHJvcGVydHkgeDg2X2NwdV9w
cm9wZXJ0aWVzW10gPSB7DQogICAgIERFRklORV9QUk9QX0lOVDMyKCJ0aHJlYWQtaWQiLCBYODZD
UFUsIHRocmVhZF9pZCwgMCksDQogICAgIERFRklORV9QUk9QX0lOVDMyKCJjb3JlLWlkIiwgWDg2
Q1BVLCBjb3JlX2lkLCAwKSwNCiAgICAgREVGSU5FX1BST1BfSU5UMzIoImRpZS1pZCIsIFg4NkNQ
VSwgZGllX2lkLCAwKSwNCisgICAgREVGSU5FX1BST1BfSU5UMzIoImNjeC1pZCIsIFg4NkNQVSwg
Y2N4X2lkLCAwKSwNCiAgICAgREVGSU5FX1BST1BfSU5UMzIoInNvY2tldC1pZCIsIFg4NkNQVSwg
c29ja2V0X2lkLCAwKSwNCiAjZWxzZQ0KICAgICBERUZJTkVfUFJPUF9VSU5UMzIoImFwaWMtaWQi
LCBYODZDUFUsIGFwaWNfaWQsIFVOQVNTSUdORURfQVBJQ19JRCksDQogICAgIERFRklORV9QUk9Q
X0lOVDMyKCJ0aHJlYWQtaWQiLCBYODZDUFUsIHRocmVhZF9pZCwgLTEpLA0KICAgICBERUZJTkVf
UFJPUF9JTlQzMigiY29yZS1pZCIsIFg4NkNQVSwgY29yZV9pZCwgLTEpLA0KICAgICBERUZJTkVf
UFJPUF9JTlQzMigiZGllLWlkIiwgWDg2Q1BVLCBkaWVfaWQsIC0xKSwNCisgICAgREVGSU5FX1BS
T1BfSU5UMzIoImNjeC1pZCIsIFg4NkNQVSwgY2N4X2lkLCAtMSksDQogICAgIERFRklORV9QUk9Q
X0lOVDMyKCJzb2NrZXQtaWQiLCBYODZDUFUsIHNvY2tldF9pZCwgLTEpLA0KICNlbmRpZg0KICAg
ICBERUZJTkVfUFJPUF9JTlQzMigibm9kZS1pZCIsIFg4NkNQVSwgbm9kZV9pZCwgQ1BVX1VOU0VU
X05VTUFfTk9ERV9JRCksDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvY3B1LmggYi90YXJnZXQv
aTM4Ni9jcHUuaA0KaW5kZXggOGIzZGM1NTMzZS4uZGI5NDBjZGIyYSAxMDA2NDQNCi0tLSBhL3Rh
cmdldC9pMzg2L2NwdS5oDQorKysgYi90YXJnZXQvaTM4Ni9jcHUuaA0KQEAgLTE1MDgsNiArMTUw
OCw3IEBAIHN0cnVjdCBYODZDUFUgew0KICAgICBpbnQzMl90IG5vZGVfaWQ7IC8qIE5VTUEgbm9k
ZSB0aGlzIENQVSBiZWxvbmdzIHRvICovDQogICAgIGludDMyX3Qgc29ja2V0X2lkOw0KICAgICBp
bnQzMl90IGRpZV9pZDsNCisgICAgaW50MzJfdCBjY3hfaWQ7DQogICAgIGludDMyX3QgY29yZV9p
ZDsNCiAgICAgaW50MzJfdCB0aHJlYWRfaWQ7DQogDQoNCg==

