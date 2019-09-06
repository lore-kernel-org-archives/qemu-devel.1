Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96E1C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A94220838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WR/Ug7e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A94220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JpZ-0005mv-8N
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jfo-0003tA-QF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jfn-0004Zj-LI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:32 -0400
Received: from mail-eopbgr700062.outbound.protection.outlook.com
 ([40.107.70.62]:10552 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jfn-0004ZH-Fa
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOEb2mnDsN+irN1znsOAkSeUxcHHH/uE0OXOG6iY0gN0Y1gHIMqxibCambAhiii8Mu9cztKs4o9Epwm3SpL2M8OsxXOiSbQK5Rtx8Pg7qfkTnYbIFAUhVcmnSE4wFVnrhxKlzmiYHkH63WMjjmds57gljFQHNVMZHXP5HTMveHqbMi7uVV5os3yJ4ZP6Yrv80z0CaHycJIHclsEjy0wWklaHoVf5WtnAthv6w2N3AOP6lZ8g+NEvQSa803PLfrtzNsQ44FMb5d22Lkfya1RGkjEQDbMcfBPVVDP93d4c6Ki4dv0gjg/lUSdg/ZugirmjprToMJBaRsPOWuNhKp8gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1PIcKzOCO1p1zNeOrGP8T7QDfn+OE+3K39YM6SXfbE=;
 b=YQBaoLfQEsWFATHhzHtOOYm+ySAlzZXlT2xOaJt6b9I4VTso3UdZQGMHlPHk50MzyVcu1W9yMmlH0bf40Bn0V+RLRxgUtRbwCm6ogTLR4aWjpCD/kpHXhHyxaJRhh/t+PnQYxDi5jwfYmM3018SGFZmoIZRkR1ZjRU4VJ1XjBBaE5eiS43F2fVx84dW2QmrFIMmW7AGg0hVl8G/133ln92ne6Uy2jTFw0znRIvVYubhzPgQ63le4pkBQdP1sLEEUxcbB6Q8TMNFGcrWkqSzjaIpmdDjhvc5rJ2tsOLvKe6SuslhosIGpqBBMSupBuGoBZpWjKUx2eFNY6EIAD1jang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1PIcKzOCO1p1zNeOrGP8T7QDfn+OE+3K39YM6SXfbE=;
 b=WR/Ug7e1KMLkKF/+WT9NerPktGYDvFVdAF7HV/NQpam31W+lhcWkx7DTfA2W0QEoKoOYUurnClKfuDcG1SZCWYFuJa926FqVEp6uZh8kHb2TTBzIxDiWo1MdomPeTH+pLOmp1xvR7iMGk1+EGo/vVBnjE/rYlYwmTMwK8Qt7FgM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:13:29 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:13:29 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 16/16] hw/core: Fix up the
 machine_set_cpu_numa_node for epyc
Thread-Index: AQHVZOcq5DENcdpQ5EuQmZjh98ITLw==
Date: Fri, 6 Sep 2019 19:13:29 +0000
Message-ID: <156779720803.21957.8389712174989601936.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f7e3218-fe2d-4c6f-8d16-08d732fe4d25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11452EA4A2D847EA2994330995BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(14444005)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Vv6gNO/CrEZ4v1xI45DXm3EIBMNyYSwztSZ69oEPpdNfG+3Z9aDJ/BNhjSSKAIFOuxDkoF2ZKO3L2EIpZnl0K5WgBblUveMUOgyZpv7EwfaMbGfjwREGhjJCIKFVswTIR3YH2jsubKw4F+X3hq+WEqXEoPy7DjMRDLqWSddow0IE9aRIT5//8kF+Y3YJ77JSaL7efDdNG+jJ6dTY+kNMGQZJBPM4DcTABT1pgI77VvoKjXPeFV9Gzw4vWgElkX0HI4ps9pfHMYt09I8+jONuhgTvDbxq6NVCfT1bP8Y+dAzGnBT39eUjSq9HQIRjK0a13NYBizgd4A6ZyjllBMz+APPSX2otGPlVd/dDTwf2MvRmQn75R68Aob6UrJvi2duko1sLzGB261olxEXvtwkkjhyUJ3b8Z8C6RoLKkNHRCM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E998BDA3D2D64447A0649B460A9382C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e3218-fe2d-4c6f-8d16-08d732fe4d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:13:29.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaAgdygmr9HRTs6tnhnw1ej2q+XPWi0yI5O7y78IHRxKbrMUHINe0bjlkDh7jQx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.62
Subject: [Qemu-devel] [RFC 2 PATCH 16/16] hw/core: Fix up the
 machine_set_cpu_numa_node for epyc
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

Q3VycmVudCB0b3BvbG9neSBpZCBtYXRjaCB3aWxsIG5vdCB3b3JrIGZvciBlcHljIG1vZGUgd2hl
biBzZXR0aW5nDQp0aGUgbm9kZSBpZC4gSW4gZXB5YyBtb2RlLCBpZHMgbGlrZSBzbXRfaWQsIHRo
cmVhZF9pZCwgY29yZV9pZCwNCmNjeF9pZCwgc29ja2V0X2lkIGNhbiBiZSBzYW1lIGZvciBtb3Jl
IHRoYW4gb25lIENQVXMgd2l0aCBhY3Jvc3MNCnR3byBudW1hIG5vZGVzLg0KDQpGb3IgZXhhbXBs
ZSwgd2UgY2FuIGhhdmUgdHdvIENQVXMgd2l0aCBmb2xsb3dpbmcgaWRzIG9uIHR3byBkaWZmZXJl
bnQgbm9kZS4NCjEuIHNtdF9pZD0wLCB0aHJlYWRfaWQ9MCwgY29yZV9pZD0wLCBjY3hfaWQ9MCwg
c29ja2V0X2lkPTAsIG5vZGVfaWQ9MA0KMi4gc210X2lkPTAsIHRocmVhZF9pZD0wLCBjb3JlX2lk
PTAsIGNjeF9pZD0wLCBzb2NrZXRfaWQ9MCwgbm9kZV9pZD0xDQoNClRoZSBmdW5jdGlvbiBtYWNo
aW5lX3NldF9jcHVfbnVtYV9ub2RlIHdpbGwgZmFpbCB0byBmaW5kIGEgbWF0Y2ggdG8gYXNzaWdu
DQp0aGUgbm9kZS4gQWRkZWQgbmV3IGZ1bmN0aW9uIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGVf
ZXB5YyB0byBzZXQgdGhlIG5vZGVfaWQNCmRpcmVjdGx5IGluIGVweWMgbW9kZS4NCg0KU2lnbmVk
LW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KLS0tDQogaHcvY29yZS9t
YWNoaW5lLmMgICB8ICAgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQogaHcvY29yZS9udW1h
LmMgICAgICB8ICAgIDYgKysrKystDQogaW5jbHVkZS9ody9ib2FyZHMuaCB8ICAgIDQgKysrKw0K
IDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0KaW5kZXggOWE4
NTg2Y2YzMC4uNmJjZWVmYzZmMyAxMDA2NDQNCi0tLSBhL2h3L2NvcmUvbWFjaGluZS5jDQorKysg
Yi9ody9jb3JlL21hY2hpbmUuYw0KQEAgLTc0MSw2ICs3NDEsMzAgQEAgdm9pZCBtYWNoaW5lX3Nl
dF9jcHVfbnVtYV9ub2RlKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwNCiAgICAgfQ0KIH0NCiANCit2
b2lkIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGVfZXB5YyhNYWNoaW5lU3RhdGUgKm1hY2hpbmUs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgQ3B1SW5zdGFuY2VQ
cm9wZXJ0aWVzICpwcm9wcywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBpbmRleCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJv
ciAqKmVycnApDQorew0KKyAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9HRVRfQ0xBU1Mo
bWFjaGluZSk7DQorICAgIENQVUFyY2hJZCAqc2xvdDsNCisNCisgICAgaWYgKCFtYy0+cG9zc2li
bGVfY3B1X2FyY2hfaWRzKSB7DQorICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJtYXBwaW5nIG9m
IENQVXMgdG8gTlVNQSBub2RlIGlzIG5vdCBzdXBwb3J0ZWQiKTsNCisgICAgICAgIHJldHVybjsN
CisgICAgfQ0KKw0KKyAgICAvKiBkaXNhYmxpbmcgbm9kZSBtYXBwaW5nIGlzIG5vdCBzdXBwb3J0
ZWQsIGZvcmJpZCBpdCAqLw0KKyAgICBhc3NlcnQocHJvcHMtPmhhc19ub2RlX2lkKTsNCisNCisg
ICAgLyogZm9yY2UgYm9hcmQgdG8gaW5pdGlhbGl6ZSBwb3NzaWJsZV9jcHVzIGlmIGl0IGhhc24n
dCBiZWVuIGRvbmUgeWV0ICovDQorICAgIG1jLT5wb3NzaWJsZV9jcHVfYXJjaF9pZHMobWFjaGlu
ZSk7DQorDQorICAgIHNsb3QgPSAmbWFjaGluZS0+cG9zc2libGVfY3B1cy0+Y3B1c1tpbmRleF07
DQorICAgIHNsb3QtPnByb3BzLm5vZGVfaWQgPSBwcm9wcy0+bm9kZV9pZDsNCisgICAgc2xvdC0+
cHJvcHMuaGFzX25vZGVfaWQgPSBwcm9wcy0+aGFzX25vZGVfaWQ7DQorfQ0KKw0KIHN0YXRpYyB2
b2lkIHNtcF9wYXJzZShNYWNoaW5lU3RhdGUgKm1zLCBRZW11T3B0cyAqb3B0cykNCiB7DQogICAg
IGlmIChvcHRzKSB7DQpkaWZmIC0tZ2l0IGEvaHcvY29yZS9udW1hLmMgYi9ody9jb3JlL251bWEu
Yw0KaW5kZXggMjdmYTZiNWUxZC4uYTllODM1YWVhNiAxMDA2NDQNCi0tLSBhL2h3L2NvcmUvbnVt
YS5jDQorKysgYi9ody9jb3JlL251bWEuYw0KQEAgLTI0Nyw3ICsyNDcsMTEgQEAgdm9pZCBzZXRf
bnVtYV9ub2RlX29wdGlvbnMoTWFjaGluZVN0YXRlICptcywgTnVtYU9wdGlvbnMgKm9iamVjdCwg
RXJyb3IgKiplcnJwKQ0KICAgICAgICAgIHByb3BzID0gbWMtPmNwdV9pbmRleF90b19pbnN0YW5j
ZV9wcm9wcyhtcywgY3B1cy0+dmFsdWUpOw0KICAgICAgICAgIHByb3BzLm5vZGVfaWQgPSBub2Rl
bnI7DQogICAgICAgICAgcHJvcHMuaGFzX25vZGVfaWQgPSB0cnVlOw0KLSAgICAgICAgIG1hY2hp
bmVfc2V0X2NwdV9udW1hX25vZGUobXMsICZwcm9wcywgJmVycik7DQorICAgICAgICAgaWYgKG1z
LT5lcHljKSB7DQorICAgICAgICAgICAgIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGVfZXB5Yyht
cywgJnByb3BzLCBjcHVzLT52YWx1ZSwgJmVycik7DQorICAgICAgICAgfSBlbHNlIHsNCisgICAg
ICAgICAgICAgbWFjaGluZV9zZXRfY3B1X251bWFfbm9kZShtcywgJnByb3BzLCAmZXJyKTsNCisg
ICAgICAgICB9DQogICAgICAgICAgaWYgKGVycikgew0KICAgICAgICAgICAgIGVycm9yX3Byb3Bh
Z2F0ZShlcnJwLCBlcnIpOw0KICAgICAgICAgICAgIHJldHVybjsNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L2JvYXJkcy5oIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KaW5kZXggMDAwMWQ0MmU1MC4u
ZWMxYjFjNWE4NSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvYm9hcmRzLmgNCisrKyBiL2luY2x1
ZGUvaHcvYm9hcmRzLmgNCkBAIC03NCw2ICs3NCwxMCBAQCBIb3RwbHVnZ2FibGVDUFVMaXN0ICpt
YWNoaW5lX3F1ZXJ5X2hvdHBsdWdnYWJsZV9jcHVzKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk7DQog
dm9pZCBtYWNoaW5lX3NldF9jcHVfbnVtYV9ub2RlKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgQ3B1SW5zdGFuY2VQcm9wZXJ0aWVz
ICpwcm9wcywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsN
Cit2b2lkIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGVfZXB5YyhNYWNoaW5lU3RhdGUgKm1hY2hp
bmUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgQ3B1SW5zdGFu
Y2VQcm9wZXJ0aWVzICpwcm9wcywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbmRleCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
cnJvciAqKmVycnApOw0KIA0KIHZvaWQgbWFjaGluZV9jbGFzc19hbGxvd19keW5hbWljX3N5c2J1
c19kZXYoTWFjaGluZUNsYXNzICptYywgY29uc3QgY2hhciAqdHlwZSk7DQogDQoNCg==

