Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2AEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5698C20838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x8heuH+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5698C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Ju5-0002ZY-In
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jfi-0003hx-Hx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jfh-0004XU-DT
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:26 -0400
Received: from mail-eopbgr710070.outbound.protection.outlook.com
 ([40.107.71.70]:19249 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jfh-0004XM-6u
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYDqToygJHOTObI/8SgdWdHKyC6MSDbnX6bop9ORDmLrnH/b1pu6TOdvmF5B0z2jgVFp6D0h2GZFT4FaqGGcn5CacJwxE9LOiZ6brJzX5S03gRHdfDL2c+4EokhBMrXOZOuRL++0UwlNy6mdGKwUlLk8kEEz3xBVHZM1bMKHsv57r1HdsocONv9snWOxYSKs4b5pGWQPexxsUjyOJ0TfQYvvmuP+S3ZZ8Cjmq1uEX596svkb9HNlfDGYGw4VMnG0bIkapMqfHfkD13yYxQDM16FU693vB4uJof/kv6LnXuafvNEcQJoDySzBV3LDQiAq/+08NBieUZhWGHjPJk2FOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlCmWhuijPG2rF3zJbY0bSW/5BrsiZWaBsW8NlWgxDk=;
 b=eZZbaShJxCIEcPSpKclGJxYxkHSPD1r/y3GxyhAV6b2z/wkPcwkqmIQQ+ZNjLOtqmLwbLFKlu9agvH5vQMHrOzbB6PNTbnzhgflM+N2fATh8GnS+axx8K69Gbli/jq/bRHFoCYgdEySn4qP0ofTPMwh0YIP6ro5u9OimgS5MmzOH6MuxuEJcIJ8rjAowjxpu+Zmh8q81PBQ5oBo2LGA/M9Lie2NJpuO71sQ9Hf0u1+lnwA2GZ3ajipSUv4lY+DAG9YqnKxeSksszMmywdUiTvN1J+KjHrFXv69W+42urH3fxvO+n/JkrMz0+6jC8un+r20QdACFrQiduVnI6Iu8L+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlCmWhuijPG2rF3zJbY0bSW/5BrsiZWaBsW8NlWgxDk=;
 b=x8heuH+Ap/oT5HY1igz1SpYuInri83pw/ViXnmx5dZlU6JnaVagRd8kTKFuZcB9oVkDUwgpVG/XAt7ll1pytVeqZVHtymIQTd9Pf3T5hbb8amTzSqUKxN4lGQOQmsfj8lri39hF2stosqX/7aBN7Tn2IMDy7vo1pZktlH+sNvFI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1930.namprd12.prod.outlook.com (10.175.88.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 6 Sep 2019 19:13:23 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:13:22 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 15/16] i386: Fix pkg_id offset for epyc mode
Thread-Index: AQHVZOcmbebOiftiVUCaGUSkVpMtgg==
Date: Fri, 6 Sep 2019 19:13:22 +0000
Message-ID: <156779720146.21957.9036938076017885210.stgit@localhost.localdomain>
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
x-ms-office365-filtering-correlation-id: 56c4b1fe-1041-4e74-2a9f-08d732fe493b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1930; 
x-ms-traffictypediagnostic: DM5PR12MB1930:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB193005AF10D035E0778B6A1595BA0@DM5PR12MB1930.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(3846002)(14444005)(99286004)(8936002)(256004)(7736002)(71200400001)(71190400001)(6116002)(66446008)(66476007)(14454004)(64756008)(66556008)(66946007)(53936002)(2501003)(8676002)(478600001)(6506007)(386003)(9686003)(5660300002)(486006)(446003)(6486002)(26005)(110136005)(2906002)(6512007)(103116003)(316002)(476003)(11346002)(6436002)(186003)(102836004)(81156014)(76176011)(66066001)(81166006)(25786009)(52116002)(4326008)(86362001)(305945005)(2201001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1930;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XX3W+epJzeSzFIZqPNwN2Vm5N0+PuNFSlfK5QUIlPX2J3UMjRBD5xYDY/BEebGKPnXZxdrkf3EioaanjXsPGhaOHw49pYf54640Lp9hLseSdhVhYq39H5ZljZPZ/5hiWKKhXHautA+UD6J94j5K6YQRaoGcqFrmYkuLXCWrpJtUuVxAq19JOYNOCyrlwii+HZy/+Ao32PrqME/SkWhpTfM4gEflQNlx9sAtOuPGNBXMnJhYgSg2+e2iVSDU/zjaVW0QB1q5zGlBjze9csk6LcnAeb5vgLXjoxlQ9DUJtiTgk6t6rhz1mthmcc1BNO4FrbBubzFjeubbsJoQ8fDHcebDH9k2mJNk9c/htUHvm0pOfcFH+qVhhBaDC/90jJz0PALRgxs97EQlFIyjQJEsU7VghZmmtMMYqKdfCdB7rNBM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <751AC802B34CAE449F8922185A98C7FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c4b1fe-1041-4e74-2a9f-08d732fe493b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:13:22.8690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUlccFwgLfO13YmOfIGzuRT9/2UvRPrRVpYBP0hhPg5BuZP7ZMWGWqwWowmmqt6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1930
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.70
Subject: [Qemu-devel] [RFC 2 PATCH 15/16] i386: Fix pkg_id offset for epyc
 mode
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

U2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KLS0tDQogdGFy
Z2V0L2kzODYvY3B1LmMgfCAgIDI0ICsrKysrKysrKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2kzODYvY3B1LmMgYi90YXJnZXQvaTM4Ni9jcHUuYw0KaW5kZXggZjI1NDkxYTAyOS4u
ZjhiMWZjNWMwNyAxMDA2NDQNCi0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQorKysgYi90YXJnZXQv
aTM4Ni9jcHUuYw0KQEAgLTQwOTQsOSArNDA5NCwxMCBAQCB2b2lkIGNwdV94ODZfY3B1aWQoQ1BV
WDg2U3RhdGUgKmVudiwgdWludDMyX3QgaW5kZXgsIHVpbnQzMl90IGNvdW50LA0KICAgICAgICAg
ICAgICAgICAgICB1aW50MzJfdCAqZWF4LCB1aW50MzJfdCAqZWJ4LA0KICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCAqZWN4LCB1aW50MzJfdCAqZWR4KQ0KIHsNCisgICAgTWFjaGluZVN0YXRl
ICptcyA9IE1BQ0hJTkUocWRldl9nZXRfbWFjaGluZSgpKTsNCiAgICAgWDg2Q1BVICpjcHUgPSBl
bnZfYXJjaGNwdShlbnYpOw0KICAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7DQotICAg
IHVpbnQzMl90IGRpZV9vZmZzZXQ7DQorICAgIHVpbnQzMl90IGRpZV9vZmZzZXQsIHBrZ19vZmZz
ZXQ7DQogICAgIHVpbnQzMl90IGxpbWl0Ow0KICAgICB1aW50MzJfdCBzaWduYXR1cmVbM107DQog
DQpAQCAtNDExOSw2ICs0MTIwLDIxIEBAIHZvaWQgY3B1X3g4Nl9jcHVpZChDUFVYODZTdGF0ZSAq
ZW52LCB1aW50MzJfdCBpbmRleCwgdWludDMyX3QgY291bnQsDQogICAgICAgICBpbmRleCA9IGVu
di0+Y3B1aWRfbGV2ZWw7DQogICAgIH0NCiANCisgICAgaWYgKG1zLT5lcHljKSB7DQorICAgICAg
ICBYODZDUFVUb3BvSW5mbyB0b3BvX2luZm8gPSB7DQorICAgICAgICAgICAgLm51bWFfbm9kZXMg
PSBuYl9udW1hX25vZGVzLA0KKyAgICAgICAgICAgIC5ucl9zb2NrZXRzID0gbXMtPnNtcC5zb2Nr
ZXRzLA0KKyAgICAgICAgICAgIC5ucl9jb3JlcyA9IG1zLT5zbXAuY29yZXMsDQorICAgICAgICAg
ICAgLm5yX3RocmVhZHMgPSBtcy0+c21wLnRocmVhZHMsDQorICAgICAgICB9Ow0KKyAgICAgICAg
dW5zaWduZWQgbm9kZXMgPSBub2Rlc19pbl9wa2coJnRvcG9faW5mbyk7DQorICAgICAgICBwa2df
b2Zmc2V0ID0gYXBpY2lkX3BrZ19vZmZzZXRfZXB5Yyhub2RlcywgTUFYX0NDWCwgTUFYX0NPUkVT
X0lOX0NDWCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNz
LT5ucl90aHJlYWRzKTsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIHBrZ19vZmZzZXQgPSBhcGlj
aWRfcGtnX29mZnNldChlbnYtPm5yX2RpZXMsIGNzLT5ucl9jb3JlcywNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjcy0+bnJfdGhyZWFkcyk7DQorICAgIH0NCisNCiAg
ICAgc3dpdGNoKGluZGV4KSB7DQogICAgIGNhc2UgMDoNCiAgICAgICAgICplYXggPSBlbnYtPmNw
dWlkX2xldmVsOw0KQEAgLTQyNzUsOCArNDI5MSw3IEBAIHZvaWQgY3B1X3g4Nl9jcHVpZChDUFVY
ODZTdGF0ZSAqZW52LCB1aW50MzJfdCBpbmRleCwgdWludDMyX3QgY291bnQsDQogICAgICAgICAg
ICAgKmVjeCB8PSBDUFVJRF9UT1BPTE9HWV9MRVZFTF9TTVQ7DQogICAgICAgICAgICAgYnJlYWs7
DQogICAgICAgICBjYXNlIDE6DQotICAgICAgICAgICAgKmVheCA9IGFwaWNpZF9wa2dfb2Zmc2V0
KGVudi0+bnJfZGllcywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Mt
Pm5yX2NvcmVzLCBjcy0+bnJfdGhyZWFkcyk7DQorICAgICAgICAgICAgKmVheCA9IHBrZ19vZmZz
ZXQ7DQogICAgICAgICAgICAgKmVieCA9IGNzLT5ucl9jb3JlcyAqIGNzLT5ucl90aHJlYWRzOw0K
ICAgICAgICAgICAgICplY3ggfD0gQ1BVSURfVE9QT0xPR1lfTEVWRUxfQ09SRTsNCiAgICAgICAg
ICAgICBicmVhazsNCkBAIC00MzEwLDggKzQzMjUsNyBAQCB2b2lkIGNwdV94ODZfY3B1aWQoQ1BV
WDg2U3RhdGUgKmVudiwgdWludDMyX3QgaW5kZXgsIHVpbnQzMl90IGNvdW50LA0KICAgICAgICAg
ICAgICplY3ggfD0gQ1BVSURfVE9QT0xPR1lfTEVWRUxfQ09SRTsNCiAgICAgICAgICAgICBicmVh
azsNCiAgICAgICAgIGNhc2UgMjoNCi0gICAgICAgICAgICAqZWF4ID0gYXBpY2lkX3BrZ19vZmZz
ZXQoZW52LT5ucl9kaWVzLCBjcy0+bnJfY29yZXMsDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3MtPm5yX3RocmVhZHMpOw0KKyAgICAgICAgICAg
ICplYXggPSBwa2dfb2Zmc2V0Ow0KICAgICAgICAgICAgICplYnggPSBlbnYtPm5yX2RpZXMgKiBj
cy0+bnJfY29yZXMgKiBjcy0+bnJfdGhyZWFkczsNCiAgICAgICAgICAgICAqZWN4IHw9IENQVUlE
X1RPUE9MT0dZX0xFVkVMX0RJRTsNCiAgICAgICAgICAgICBicmVhazsNCg0K

