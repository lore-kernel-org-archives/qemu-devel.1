Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF31FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B076206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yek2ma7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B076206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JlA-0000hs-Ok
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JfQ-0003DI-MN
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JfP-0004RO-ED
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:08 -0400
Received: from mail-co1nam04on062a.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::62a]:33435
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6JfN-0004Qd-OS
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyswW4EfQR23jAHUZ41veKGYteEfBxO7i44r8U5TihGIL6EniE4HmjLDCU58XCnO5xjOKZPo33L1AgIghS72lzOARjVRFffuIDi14k0U531mPjedaacto9T91I26sDC/7NWofwlcltlR9s7A0h6VbC0FS+soHLrOEmnlB3N9pVAtNHpm8xD0VHo4s1fLmzJVunE+lq+5rR66v/C88wMmOyLIxt6I/WhQL2PIq3DrHyGwsKLYnNhsWdgWPTDNtxia3gYerF6Xoxh5xqz3gB5nKFYHKnRzKI9tL5b03+lJEoHtE15dGsKo2Yxb3Cw5ajDikHBe7qdcyZ+DydmstPHYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lk9i52IXa7cTPHDgznIIL4vW6w2thRKXFNd/NEINbY=;
 b=dnfNjBhCgCKZOow5BLSuOWB925IfVmUvftFUbgn2HzfFjc4QM5lR7IBi9yKwXUH5Qr4Knfm80FysjP7pZYXDycQlmKuvX+Q4zc7K80eHA5tyiWkhV8zl3MFuL8BbYtwSC7+XzLoXUlJj+b9SFofpHbwqE3nTIn0NDAw118qmdd8jxQ5uyySskYqc7NjPy40N7pN908fCqgjMOAW+XcR/12MGoF4pFvLZdARLSsr8obj75c5JZbeW7k0aqmOTRZaNztNwMoL4KttUI6EC+7X/47i0lR3cRIAcpf07ibcGa92ZDg5sw7IFRn4APnmQXJWr0ve6PD0mGx2vxXV8MSZGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lk9i52IXa7cTPHDgznIIL4vW6w2thRKXFNd/NEINbY=;
 b=yek2ma7+zA6v8r1aJ+zvvIrKZsX6MsREyn12OKrE5gL8wUqDHLaz2PS6srUK/BHjlevLXCvfWi/XFWF5Ib5tsfRnW9fx5PLHGcRwu4Mmx72WzkRwD+LyBgILqgPyDCAirhYaO4IEGEzQi0b1Y7Bbp9ZItAPB7EAuk3vccTE0GYU=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:13:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:13:02 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 12/16] hw/i386: Introduce apic_id_from_topo_ids
 handler in PCMachineState
Thread-Index: AQHVZOcaItEosya+MEKaCAT2nutfDg==
Date: Fri, 6 Sep 2019 19:13:02 +0000
Message-ID: <156779718115.21957.699621482515468870.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0009.namprd06.prod.outlook.com
 (2603:10b6:803:2f::19) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a6f11a-352c-4c8d-6856-08d732fe3d2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB114551809E61D2382D15A41B95BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kgSQG/Qk4jKYR/QNAy0AqByZ8ycEyWXe9GvO2qbUMc3C0mVwEgFw8Qd8EP4397uB2zwK6zPj5d6USgcjbG/eTJJuWwzuZEgx9SdTCYq7lKnnDpp2G65vxUUpv32b40YHhHR6oqucc7fw4h/5084KtJJJJrqdexNI+jIkMQd/dF/xATWsZKBhD/9Y77K6fCQXhOq/rINFd5UXXVwYjurHJXQiYckVJHIUl2/msGKoxOG1jPMnskx7qLKUGoAfu/9LlS9WxSdnKob30WMmcBqeU7oyrpPuYAH0yPzIsI5WiPVNlGTMNXEjNXfkIziLmYOpu+RLuGCuLN6jKUHlqd48CkmHENSL0z3/HUeX3OAf63dPksRRp0xoy7u2UItCR5h7WhcpC4fkuC1UYd3OIz8Q8QZyxPJGXOa9xtIoJ5TTh+k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72118726988BF64CBE69A5D1E53A9C88@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a6f11a-352c-4c8d-6856-08d732fe3d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:13:02.6886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNBLapWs3Pw8W2qdNj5ejbwmU7RWAbSZ1HSQxxqzwGpVzzIDxEULwB7UopaFSx/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::62a
Subject: [Qemu-devel] [RFC 2 PATCH 12/16] hw/i386: Introduce
 apic_id_from_topo_ids handler in PCMachineState
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

QWRkIGZ1bmN0aW9uIHBvaW50ZXIgYXBpY19pZF9mcm9tX3RvcG9faWRzIGluIFBDTWFjaGluZVN0
YXRlLg0KSW5pdGlhbGl6ZSB3aXRoIGNvcnJlY3QgaGFuZGxlciBiYXNlZCBvbiB0aGUgbW9kZSBz
ZWxlY3RlZC4NCkFsc28gcmVuYW1lIHRoZSBoYW5kbGVyIGFwaWNpZF9mcm9tX3RvcG9faWRzIHRv
IHg4Nl9hcGljaWRfZnJvbV90b3BvX2lkcw0KZm9yICBjb25zaXN0ZW5jeS4geDg2X2FwaWNpZF9m
cm9tX3RvcG9faWRzIHdpbGwgYmUgdGhlIGRlZmF1bHQgaGFuZGxlci4NCg0KU2lnbmVkLW9mZi1i
eTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KLS0tDQogaHcvaTM4Ni9wYy5jICAg
ICAgICAgICAgICAgfCAgICAzICsrLQ0KIGluY2x1ZGUvaHcvaTM4Ni9wYy5oICAgICAgIHwgICAg
MiArKw0KIGluY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5oIHwgICAgNCArKy0tDQogMyBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9o
dy9pMzg2L3BjLmMgYi9ody9pMzg2L3BjLmMNCmluZGV4IGM4OGRlMDkzNTAuLjk1OWJkMzgyMWIg
MTAwNjQ0DQotLS0gYS9ody9pMzg2L3BjLmMNCisrKyBiL2h3L2kzODYvcGMuYw0KQEAgLTI0NTQs
NyArMjQ1NCw3IEBAIHN0YXRpYyB2b2lkIHBjX2NwdV9wcmVfcGx1ZyhIb3RwbHVnSGFuZGxlciAq
aG90cGx1Z19kZXYsDQogICAgICAgICB0b3BvX2lkcy5jY3hfaWQgPSBjcHUtPmNjeF9pZDsNCiAg
ICAgICAgIHRvcG9faWRzLmNvcmVfaWQgPSBjcHUtPmNvcmVfaWQ7DQogICAgICAgICB0b3BvX2lk
cy5zbXRfaWQgPSBjcHUtPnRocmVhZF9pZDsNCi0gICAgICAgIGNwdS0+YXBpY19pZCA9IGFwaWNp
ZF9mcm9tX3RvcG9faWRzKCZ0b3BvX2luZm8sICZ0b3BvX2lkcyk7DQorICAgICAgICBjcHUtPmFw
aWNfaWQgPSBwY21zLT5hcGljaWRfZnJvbV90b3BvX2lkcygmdG9wb19pbmZvLCAmdG9wb19pZHMp
Ow0KICAgICB9DQogDQogICAgIGNwdV9zbG90ID0gcGNfZmluZF9jcHVfc2xvdChNQUNISU5FKHBj
bXMpLCBjcHUtPmFwaWNfaWQsICZpZHgpOw0KQEAgLTI4MzEsNiArMjgzMSw3IEBAIHN0YXRpYyB2
b2lkIHBjX21hY2hpbmVfaW5pdGZuKE9iamVjdCAqb2JqKQ0KICAgICAvKiBJbml0aWFsaXplIHRo
ZSBhcGljIGlkIHJlbGF0ZWQgaGFuZGxlcnMgKi8NCiAgICAgcGNtcy0+YXBpY2lkX2Zyb21fY3B1
X2lkeCA9IHg4Nl9hcGljaWRfZnJvbV9jcHVfaWR4Ow0KICAgICBwY21zLT50b3BvX2lkc19mcm9t
X2FwaWNpZCA9IHg4Nl90b3BvX2lkc19mcm9tX2FwaWNpZDsNCisgICAgcGNtcy0+YXBpY2lkX2Zy
b21fdG9wb19pZHMgPSB4ODZfYXBpY2lkX2Zyb21fdG9wb19pZHM7DQogDQogICAgIHBjX3N5c3Rl
bV9mbGFzaF9jcmVhdGUocGNtcyk7DQogfQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9w
Yy5oIGIvaW5jbHVkZS9ody9pMzg2L3BjLmgNCmluZGV4IDlhNDBmMTIzZDAuLmQ2ZjExODk5OTcg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L2kzODYvcGMuaA0KKysrIGIvaW5jbHVkZS9ody9pMzg2
L3BjLmgNCkBAIC03MSw2ICs3MSw4IEBAIHN0cnVjdCBQQ01hY2hpbmVTdGF0ZSB7DQogICAgIHVp
bnQzMl90ICgqYXBpY2lkX2Zyb21fY3B1X2lkeCkoWDg2Q1BVVG9wb0luZm8gKnRvcG9faW5mbywg
dW5zaWduZWQgY3B1X2luZGV4KTsNCiAgICAgdm9pZCAoKnRvcG9faWRzX2Zyb21fYXBpY2lkKShh
cGljX2lkX3QgYXBpY2lkLCBYODZDUFVUb3BvSW5mbyAqdG9wb19pbmZvLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFg4NkNQVVRvcG9JRHMgKnRvcG9faWRzKTsNCisgICAgYXBp
Y19pZF90ICgqYXBpY2lkX2Zyb21fdG9wb19pZHMpKFg4NkNQVVRvcG9JbmZvICp0b3BvX2luZm8s
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBYODZDUFVUb3Bv
SURzICp0b3BvX2lkcyk7DQogDQogICAgIC8qIEFkZHJlc3Mgc3BhY2UgdXNlZCBieSBJT0FQSUMg
ZGV2aWNlLiBBbGwgSU9BUElDIGludGVycnVwdHMNCiAgICAgICogd2lsbCBiZSB0cmFuc2xhdGVk
IHRvIE1TSSBtZXNzYWdlcyBpbiB0aGUgYWRkcmVzcyBzcGFjZS4gKi8NCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L2kzODYvdG9wb2xvZ3kuaCBiL2luY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5oDQpp
bmRleCA2ZmQ0MTg0ZjA3Li43NDBlNjY5NzBkIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9pMzg2
L3RvcG9sb2d5LmgNCisrKyBiL2luY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5oDQpAQCAtMjk0LDcg
KzI5NCw3IEBAIHN0YXRpYyBpbmxpbmUgYXBpY19pZF90IHg4Nl9hcGljaWRfZnJvbV9jcHVfaWR4
X2VweWMoWDg2Q1BVVG9wb0luZm8gKnRvcG9faW5mbywNCiAgKg0KICAqIFRoZSBjYWxsZXIgbXVz
dCBtYWtlIHN1cmUgY29yZV9pZCA8IG5yX2NvcmVzIGFuZCBzbXRfaWQgPCBucl90aHJlYWRzLg0K
ICAqLw0KLXN0YXRpYyBpbmxpbmUgYXBpY19pZF90IGFwaWNpZF9mcm9tX3RvcG9faWRzKFg4NkNQ
VVRvcG9JbmZvICp0b3BvX2luZm8sDQorc3RhdGljIGlubGluZSBhcGljX2lkX3QgeDg2X2FwaWNp
ZF9mcm9tX3RvcG9faWRzKFg4NkNQVVRvcG9JbmZvICp0b3BvX2luZm8sDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgWDg2Q1BVVG9wb0lEcyAqdG9w
b19pZHMpDQogew0KICAgICB1bnNpZ25lZCBucl9kaWVzID0gdG9wb19pbmZvLT5ucl9kaWVzOw0K
QEAgLTM1Niw3ICszNTYsNyBAQCBzdGF0aWMgaW5saW5lIGFwaWNfaWRfdCB4ODZfYXBpY2lkX2Zy
b21fY3B1X2lkeChYODZDUFVUb3BvSW5mbyAqdG9wb19pbmZvLA0KIHsNCiAgICAgWDg2Q1BVVG9w
b0lEcyB0b3BvX2lkczsNCiAgICAgeDg2X3RvcG9faWRzX2Zyb21faWR4KHRvcG9faW5mbywgY3B1
X2luZGV4LCAmdG9wb19pZHMpOw0KLSAgICByZXR1cm4gYXBpY2lkX2Zyb21fdG9wb19pZHModG9w
b19pbmZvLCAmdG9wb19pZHMpOw0KKyAgICByZXR1cm4geDg2X2FwaWNpZF9mcm9tX3RvcG9faWRz
KHRvcG9faW5mbywgJnRvcG9faWRzKTsNCiB9DQogDQogI2VuZGlmIC8qIEhXX0kzODZfVE9QT0xP
R1lfSCAqLw0KDQo=

