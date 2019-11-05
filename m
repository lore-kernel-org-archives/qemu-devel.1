Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8AFC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21A72087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kiZ+rNCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21A72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6kD-0006S1-Te
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iS6Ce-0005oS-P5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iS6Cd-0006CY-H0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:17:28 -0500
Received: from mail-eopbgr720070.outbound.protection.outlook.com
 ([40.107.72.70]:13920 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iS6Cd-0006CA-7H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:17:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcxAP7y+7TsZfCj6VDlAscALxrWIjQU/JaC0imgIuFtunEduV9Arfeb94HnBp3SmM/WVzqABvxJRsZ5doZ+5llYECLfP2RPETTExd+8aImPWuQi5pQ9tN0PCqZHgGjvx6fj/GMwvlMI1RlDQn8wbESAmzQTpsMaTxPgEjkqE5K2Peb3E/LVVv0joOU0hat/BG8OiXsgq0nyAZ7/2x7bMivhTSwtSM/HlgOvpRQIj7kpVyRbzeT6BecJbDqtd0RGkoBqRHgwk0jYB6smuCMxXaFNS31n9qHI87fXr/4c1lidzcpNJErw+JcBKnDDvm9j5icXbKLXdzYdVvqYNv3R1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyHIoEnCc1pD18CH88ctTbRAC01Ki17JRl95Hxh2UXE=;
 b=KCEPtslC00TpLqWXm6QRMNf9XUacFiVT+wNDG/4lsAG7bjzZLYfKcJFyLv16BesJWqJpOx9KulHlbmEbbjC+BUDz0I5CezZexxSdN2epEZCHhouZPj11DqJnbQ+3N314DSsCtLHEHDdCA4abe4jtMPmGA64LZz2EdIfU0krn1sPQYpeMFiqZIh19VZJ/qDx3UltOEF8HZFiWzY3ZjE8GM9Gej7XGGcq+Di5qpaxaWlkcz4P+M0afn5xYKBfdMJNANiu7h5sxxb3T3CPyRjO1DBiuxbFUFubmE1wVUsr9YwK+XsOBVPGduIAK7HjsbukwcMoqvkhTDZyOL395yYo/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyHIoEnCc1pD18CH88ctTbRAC01Ki17JRl95Hxh2UXE=;
 b=kiZ+rNCQr6NXwJvO25XJakoJ5TRJlYKXHsF1cbq6+QXRDpD20U+iTyA/QkdGhc2fHMUwvzRcFaYeZ8/dN9hpP53WuCawOvhOkz3yTS21q8eiV5ArBFQ5MxWOxkMXZyD6yVNW2Yw/NFUXlkMZP/3hOKXNv/dXzj36Z5i7/t2gtj4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 21:17:23 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c5a3:6a2e:8699:1999]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c5a3:6a2e:8699:1999%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 21:17:23 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>
Subject: [PATCH 0/2] Add support for 2nd generation AMD EPYC processors
Thread-Topic: [PATCH 0/2] Add support for 2nd generation AMD EPYC processors
Thread-Index: AQHVlB5qtfeCh8am30yqQOnwVMWRdg==
Date: Tue, 5 Nov 2019 21:17:23 +0000
Message-ID: <157298859935.17394.17194072829278152009.stgit@naples-babu.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8891f8b2-0417-4129-8a94-08d762358ce0
x-ms-traffictypediagnostic: DM5PR12MB1323:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1323EFFCB877F8CAF7E182F1957E0@DM5PR12MB1323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(5660300002)(6116002)(2501003)(8936002)(486006)(71190400001)(71200400001)(6512007)(52116002)(86362001)(6306002)(14454004)(6436002)(186003)(103116003)(26005)(3846002)(6486002)(2906002)(6506007)(102836004)(256004)(386003)(66556008)(64756008)(4326008)(316002)(99286004)(305945005)(7736002)(66946007)(478600001)(66066001)(66446008)(8676002)(66476007)(476003)(81166006)(110136005)(81156014)(25786009)(966005)(4744005)(2201001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9aY1lVM4xpxJmhhhstxcpWFcAHO87htFYJ3OwsKVGv2ylG4cuvcHOXtDt89K0Ppg43Pp8oX5AIfPeFDQ9Soxm5VzgY2M5GXlLpq40jkKPSZX9wOpDjdsbTnVJETs1KFKKGv1Frlh+xEylz8aetiedSUMmxjEt77ypT1qbAS1isCnKJ6odC6ioK7rERtmccoQ9ucJXHnn6T1cha85i85CGZkOqRDI8OYr7n3ZgsGaKk+UlWHvTMa4g50S7jOkw0k3NAazU2jVNXEx64E+I5HdUhN5nq3tGDJF6NC17vWRZ6H60ViM0rVh7XBFuf+qH9isyHbbTxyDyVGZyLQoC5EyIXZsxYoGymcyBt6q0THAscyJeQ3gdaS/AOa4RVPLp8D5CN8wqMsQ1IpmblURdJ/XZaprv8OPnNkjr2gbs6Jrg4kgaYP1e3OS7ofNyUx6Wux2lgNIZWsKJw0/BiM9uCsohOQEgwssttCTqY3yVWDg4E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FA4919DECC9AF43A2235B8293D93F29@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8891f8b2-0417-4129-8a94-08d762358ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 21:17:23.4327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHgJl+bQrUpFuMH80ulfBTvVjs33A3AMBFCM25kLkZwJAK4SNIkJ2RZrGZfVO1db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.70
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

VGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkcyB0aGUgc3VwcG9ydCBmb3IgMm5kIGdlbmVyYXRpb24g
QU1EIEVQWUMgUHJvY2Vzc29ycw0Kb24gcWVtdSBndWVzdHMuIFRoZSBtb2RlbCBkaXNwbGF5IG5h
bWUgZm9yIHdpbGwgYmUgRVBZQy1Sb21lLg0KDQpBbHNvIGZpeGVzIGZldyBtaXNzZWQgY3B1IGZl
YXR1cmUgYml0cyBpbiAxc3QgZ2VuZXJhdGlvbiBFUFlDIG1vZGVscy4NCg0KVGhlIFJlZmVyZW5j
ZSBkb2N1bWVudHMgYXJlIGF2YWlsYWJsZSBhdA0KaHR0cHM6Ly9kZXZlbG9wZXIuYW1kLmNvbS93
cC1jb250ZW50L3Jlc291cmNlcy81NTgwM18wLjU0LVBVQi5wZGYNCmh0dHBzOi8vd3d3LmFtZC5j
b20vc3lzdGVtL2ZpbGVzL1RlY2hEb2NzLzI0NTk0LnBkZg0KDQotLS0NCg0KQmFidSBNb2dlciAo
Mik6DQogICAgICBpMzg2OiBBZGQgbWlzc2luZyBjcHUgZmVhdHVyZSBiaXRzIGluIEVQWUMgbW9k
ZWwNCiAgICAgIGkzODY6IEFkZCAybmQgR2VuZXJhdGlvbiBBTUQgRVBZQyBwcm9jZXNzb3JzDQoN
Cg0KIGh3L2kzODYvcGMuYyAgICAgIHwgICAgOCArKystDQogdGFyZ2V0L2kzODYvY3B1LmMgfCAg
MTEzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
DQogdGFyZ2V0L2kzODYvY3B1LmggfCAgICAyICsNCiAzIGZpbGVzIGNoYW5nZWQsIDExNSBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQotLQ0K

