Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3BC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1585020679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dXN4QELj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1585020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsxvQ-0001Iv-Cq
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 19:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtr-0006pr-A2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtq-0008Kp-4J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:51 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com
 ([40.107.76.58]:41104 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1hsxtp-0008JS-Sv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDzCfWD5/VJj8iPTasySUF2B+nMi/AauYYPqlhw/+VY/TYSuHtStpsNVO7+liBsfdtU2nfKd2i6qCuMr88gZ95jxZbTSYGsNOVRk1+r9VNBc+oK5Vcwy4F74M5lVVWLStM5xM8PWJvOM35S+xOrZk6luNKF33uIVVaBHogpIqTFcCHTsMQBtWe8VAhBqxOYnG8PrrN4KAWl9D3NX6z1/00In9of4Iu5Nz8WRD6WyiW267gB0SSf6dUUZWEzqmD9VSIxW6RqUcD0caMxeJ4jpMNY+Ykviray9rAQwcOcEHY4YYuBHrNCTLxcTU3kvg6ioDPpDlRD4ruY6oql8KO7z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwgqcEl97aWBH/tj1IxBHauRHj/VkYQvoKQpsnFQmjA=;
 b=msHpIflW4zKm+JmsqBuOYwpqza5ghcXahqopT670dN7srUOw6DzdJAMTNxhU6HFSHyHCF7qY4Tzotd82H/vR4XNmwXHzQy6bZIJJSjPutTqicWlrwfdu6psxJFXh7JqOWqd7QsGtV60BNgUr4fbzTt0/qlbLoSIO6STwSwoDMbBEMwwEXx5CEl+rT6V48o5GRevQW8Mof9pQyVSBfxJ3VIvBt9cX5AfLSofgh9LqhKXl68Pova25emvRiWmvX9QEAaiiKn+nHQdG3UCUxs/my2CqM0MqEGP6fkABXaVGvcK+U4Qte7zLzLQrXWsq4u2t8cu/eg79WFQ7pmGWVTpFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwgqcEl97aWBH/tj1IxBHauRHj/VkYQvoKQpsnFQmjA=;
 b=dXN4QELjYEELZzn0HUl8A2V2ew9q+DbY3afKzOUq72zh5/E1m2dcZnCzDQuevilOE0Flr0AosvBVjkhrg0hz8fV9ACLr0q7p5x3eZTemkG80k/+UpbXsTrF4W22dy/KbQU+3LTls8QvmAX4vK5aL9diE9HPz2jW+tKAhtL0yioE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2550.namprd12.prod.outlook.com (52.132.141.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 23:20:45 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67%7]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:20:45 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "imammedo@redhat.com" <imammedo@redhat.com>
Thread-Topic: [RFC PATCH 0/5] APIC ID fixes for AMD EPYC CPU models
Thread-Index: AQHVR/aUBPth5pgLK0Sh25LtH2BkXw==
Date: Wed, 31 Jul 2019 23:20:45 +0000
Message-ID: <20190731232032.51786-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:802:20::21) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f332b9ea-bdf7-478a-c2c8-08d7160db6f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB2550; 
x-ms-traffictypediagnostic: DM5PR12MB2550:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM5PR12MB2550EE7FC297E9410D6DE2B795DF0@DM5PR12MB2550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(8936002)(7736002)(2501003)(50226002)(36756003)(1076003)(8676002)(6436002)(81166006)(81156014)(305945005)(68736007)(54906003)(110136005)(53936002)(6486002)(66066001)(478600001)(64756008)(2906002)(316002)(5660300002)(14454004)(66556008)(102836004)(386003)(14444005)(256004)(71200400001)(6506007)(71190400001)(86362001)(486006)(26005)(99286004)(186003)(66476007)(3846002)(66946007)(4326008)(6512007)(966005)(66446008)(6116002)(2201001)(25786009)(2616005)(476003)(52116002)(6306002)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2550;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FSA7Q8FeetkQsmuwCSxu2mGD4qm+j0S/VJlOZPkh6hbb3+28nXa8NMzaZZztzYrf1a3jCpWNFDF19ndGYYZreNEc0eD9fl0IRR0/WZezU7VXnbJqI+oxFYHyhl7VssEOdomczQss0RKo5kK1Ad06P3NDHsrX3NxiCI9c4dNHdyEn3Yfj8H+kdn+QS51qpI7GqollwMjc4DdWFdiA17KtiS7bd5DbPI36jbgr6MxE2LngkThmKWE9uURxchs4Dy0hTb3ydPbka1jOffqTPD59/pYxN2PskCOHRYJFauXCcPzduqq6TvrLfUXxLJx+Om1555biNGxjiNyCdRnjSi0emRwJEiCjxrxi+6Texe/JVAKQHWukGBlmYOozC8U4sv5vV07bAx2SO+JSO16TCp3xyOf6XqTqMpG4n9rbKAyCrQ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2598662BDF007D46826237B9003B6D08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f332b9ea-bdf7-478a-c2c8-08d7160db6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:20:45.8591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2550
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.58
Subject: [Qemu-devel] [RFC PATCH 0/5] APIC ID fixes for AMD EPYC CPU models
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
Cc: "Moger, Babu" <Babu.Moger@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlc2Ugc2VyaWVzIGZpeGVzIHRoZSBwcm9ibGVtcyBlbmNvZGluZyBBUElDIElEIGZvciBBTUQg
RVBZQyBjcHUgbW9kZWxzLg0KaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNn
aT9pZD0xNzI4MTY2DQoNClRoaXMgaXMgdGhlIGZpcnN0IHBhc3MgdG8gZ2l2ZSBhbiBpZGVhIG9m
IHRoZSBjaGFuZ2VzIHJlcXVpcmVkIHRvIGFkZHJlc3MNCnRoZSBpc3N1ZS4gUGxlYXNlIGZlZWwg
ZnJlZSB0byBjb21tZW50Lg0KDQpDdXJyZW50bHksIGFwaWMgaWQgaXMgZGVjb2RlZCBiYXNlZCBv
biBzb2NrZXRzL2RpZXMvY29yZXMvdGhyZWFkcy4gVGhpcyBhcHBlYXJzDQp0byB3b3JrIGZvciBt
b3N0IHN0YW5kYXJkIGNvbmZpZ3VyYXRpb25zIGZvciBBTUQgYW5kIG90aGVyIHZlbmRvcnMuIEJ1
dCB0aGlzDQpkZWNvZGluZyBkb2VzIG5vdCBmb2xsb3cgQU1EJ3MgQVBJQyBJRCBlbnVtZXJhdGlv
bi4gSW4gc29tZSBjYXNlcyB0aGlzDQpjYXVzZXMgQ1BVIHRvcG9sb2d5IGluY29uc3RhbmN5LiBX
aGlsZSBib290aW5nIGd1ZXN0IEtlcm5lbCBpcyB0cnlpbmcgdG8NCnZhbGlkYXRlIHRvcG9sb2d5
LiBJdCBmaW5kcyB0aGUgdG9wb2xvZ3kgbm90IGFsaWduaW5nIHRvIEVQWUMgbW9kZWxzLg0KDQpU
byBmaXggdGhlIHByb2JsZW0gd2UgbmVlZCB0byBidWlsZCB0aGUgdG9wb2xvZ3kgYXMgcGVyIHRo
ZSANClByb2Nlc3NvciBQcm9ncmFtbWluZyBSZWZlcmVuY2UgKFBQUikgZm9yIEFNRCBGYW1pbHkg
MTdoIE1vZGVsIDAxaCwgUmV2aXNpb24gQjENClByb2Nlc3NvcnMuIEl0IGlzIGF2YWlsYWJsZSBh
dCBodHRwczovL3d3dy5hbWQuY29tL2VuL3N1cHBvcnQvdGVjaC1kb2NzDQoNCkhlcmUgaXMgdGhl
IHRleHQgZnJvbSB0aGUgUFBSLg0KMi4xLjEwLjIuMS4zDQpBcGljSWQgRW51bWVyYXRpb24gUmVx
dWlyZW1lbnRzDQpPcGVyYXRpbmcgc3lzdGVtcyBhcmUgZXhwZWN0ZWQgdG8gdXNlDQpDb3JlOjpY
ODY6OkNwdWlkOjpTaXplSWRbQXBpY0lkQ29yZUlkU2l6ZV0sIHRoZSBudW1iZXIgb2YgbGVhc3QN
CnNpZ25pZmljYW50IGJpdHMgaW4gdGhlIEluaXRpYWwgQVBJQyBJRCB0aGF0IGluZGljYXRlIGNv
cmUgSUQgd2l0aGluIGENCnByb2Nlc3NvciwgaW4gY29uc3RydWN0aW5nIHBlci1jb3JlIENQVUlE
DQptYXNrcy4gQ29yZTo6WDg2OjpDcHVpZDo6U2l6ZUlkW0FwaWNJZENvcmVJZFNpemVdIGRldGVy
bWluZXMgdGhlIG1heGltdW0gbnVtYmVyDQpvZiBjb3JlcyAoTU5DKSB0aGF0IHRoZQ0KcHJvY2Vz
c29yIGNvdWxkIHRoZW9yZXRpY2FsbHkgc3VwcG9ydCwgbm90IHRoZSBhY3R1YWwgbnVtYmVyIG9m
IGNvcmVzIHRoYXQgYXJlDQphY3R1YWxseSBpbXBsZW1lbnRlZCBvciBlbmFibGVkIG9uDQp0aGUg
cHJvY2Vzc29yLCBhcyBpbmRpY2F0ZWQgYnkgQ29yZTo6WDg2OjpDcHVpZDo6U2l6ZUlkW05DXS4N
CkVhY2ggQ29yZTo6WDg2OjpBcGljOjpBcGljSWRbQXBpY0lkXSByZWdpc3RlciBpcyBwcmVzZXQg
YXMgZm9sbG93czoNCuKAoiBBcGljSWRbNl0gPSBTb2NrZXQgSUQuDQrigKIgQXBpY0lkWzU6NF0g
PSBOb2RlIElELg0K4oCiIEFwaWNJZFszXSA9IExvZ2ljYWwgQ0NYIEwzIGNvbXBsZXggSUQNCuKA
oiBBcGljSWRbMjowXT0gKFNNVCkgPyB7TG9naWNhbENvcmVJRFsxOjBdLFRocmVhZElkfSA6DQp7
MSdiMCxMb2dpY2FsQ29yZUlEWzE6MF19Lg0KIiIiDQoNCkJhYnUgTW9nZXIgKDUpOg0KICBody9i
b2FyZHM6IEFkZCBzb2NrZXRzIGluIENwdVRvcG9sb2d5IHN0cnVjdHVyZQ0KICBody9pMzg2OiBB
ZGQgQU1EIEVQWUMgdG9wb2xvZ3kgZW5jb2RpbmcNCiAgaTM4NjogVXNlIHRvcG9sb2d5IGZ1bmN0
aW9ucyBmcm9tIHRvcG9sb2d5LmgNCiAgaHcvaTM4NjogR2VuZXJhdGUgYXBpY2lkIGJhc2VkIG9u
IGNwdV90eXBlDQogIGkzODY6IEZpeCBwa2dfaWQgb2Zmc2V0IEVQWUMNCg0KIGh3L2NvcmUvbWFj
aGluZS5jICAgICAgICAgIHwgICAxICsNCiBody9pMzg2L3BjLmMgICAgICAgICAgICAgICB8ICA4
MiArKysrKysrKysrKysrKysrLS0tDQogaW5jbHVkZS9ody9ib2FyZHMuaCAgICAgICAgfCAgIDIg
Kw0KIGluY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5oIHwgMTQwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQogdGFyZ2V0L2kzODYvY3B1LmMgICAgICAgICAgfCAxNjAgKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIHZsLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgICAxICsNCiA2IGZpbGVzIGNoYW5nZWQsIDI1MSBpbnNlcnRpb25zKCspLCAxMzUgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi4yMC4xDQoNCg==

