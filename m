Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD3C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162BF206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iOu1Y+QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162BF206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jiq-0006pJ-LZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JeZ-0002Hp-Md
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JeY-0004AI-B5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:15 -0400
Received: from mail-eopbgr690045.outbound.protection.outlook.com
 ([40.107.69.45]:54799 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6JeY-00049w-2N
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUigJfDDHpPDHaxobHl2i3gnAkp5c8A5qG/qDJBZOcA9g+VOXGuIgUU/PXWp2j3PGY+TE0dakMcsJirv9JEuypPqKQ/Cr2GZgdKiVPwVyqBE0aoI2YRgdr6qMVvyqnf/ihc7Vn7FDuOkIg3khqDbsmZUiA87lj9gLjcb6/OnTbvJD6hI+zOZLKSxnpGfftehSsJupl7K+BV+au4rx5OknMQdkPAyGfFwkh2N1V3Mc30iHs0rCPMOnnnYDAntyoo91ZOae7wzmMpyUlSVPDbdiaZvzN13ZQqDWUZ94lAS4NpifJL/EnNkQkT2Dp/hNnEMbCmDPIJmmOEX3uVeCc9I2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14QLFjvQBrNxUaohTnVwAQR+VjaFhSqb3YwVUHKmKhE=;
 b=i4Lf95nWBj8ate66kwjensnzgbWkbs5/3WnwpIm44t5jLgmIAVg7cq3SB+kldvtP/0tNCZJ5cbAoMyXY//WRu0Fftz944FRTVF8vZiJTDAQDmEfDurDb+v+Kzd3B/f2Ug1Iwf4OiDcqLfg+LTb20BSSFTgvi1rO9igh8S/7YeyVg8RRtiV/q/8SeTSI4tQps6VDZSKW8Y3Qpw4CGKwtVz06QoMOqQ8FXbtIFmM2ZtXVacFztMUGfAfj4oMk2xcixCMUWO5HI4u3gsZ7E2BMe/xG6QdjVUWk1dVyOBR6rbBjg7AS1B+4llDp2plqjp3EAugN8Fbactp+Imr+2Av4QTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14QLFjvQBrNxUaohTnVwAQR+VjaFhSqb3YwVUHKmKhE=;
 b=iOu1Y+QO6WKsqGbOOM8OzgCnKJSFLfk0UBV+9oUxand3CDFIJSYRH9Wjwxpwn/Sg/lL2zJ1tvdC0N5AncjHuP+VAhVlBlqIBiTvlUuaoLtO6E1OH59LoycUL2GJbnkLINQLtVZDHxK3n5ZijRmh1p+V0Iv7fZuoAvOIPl4a/36o=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:12:11 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:12:11 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 05/16] hw/i386: Simplify topology Offset/width
 Calculation
Thread-Index: AQHVZOb89qmGH/MzAkO4cTQpzupvOA==
Date: Fri, 6 Sep 2019 19:12:11 +0000
Message-ID: <156779713027.21957.5884599223662351252.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0015.namprd06.prod.outlook.com
 (2603:10b6:803:2f::25) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7641158-64bb-4190-3b93-08d732fe1ec7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1145BEC0824D0068916FB11595BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pk2AoBckym3iYEZaiGZIEvUZALThVcF/HzIrb4cDSd71qmqWAynwBGHvoLc47FxB6Y8khMlVKj1SwjE7QsF50GdcpVyg5lRnUt3i9PeYFtq7lY7JwPbTD2GXQdkO0dd33bqOPBTs9fJOo3Mnl0nUrY502V+Fb4kq8CmnqDsvB5IgKCgQYf5vWbjt1u/ulpQtupjmtswJAP7umVrfwIguSGPRp/UpUHWQkUx0xEIBEioCwaCcqYoi0UM/ymP1IziIUggVYbYOjwMdt/ZnOibdJZjRIo0kYp4UOGuXJL0msShEABjjC0ZmTD7wp7ZTMgS2Q26mFYEr3LnskkvtUvjnUM1Mr79qH76LdJ2sl+dsnUxpTaAse9i2tIY59D9T9sjt3FheJD4Q3lVRKDCGEjTRs+ePu/BRZUYTfD9Nqu86tHQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E22E9CBBC317849A6482A2B7F00F961@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7641158-64bb-4190-3b93-08d732fe1ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:12:11.6929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMLEvSU0+QPGJnzYed0rawAxwV7SiOSeI3avgf4dSEK4xpJHhf7XKnZWVjcZlPbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.45
Subject: [Qemu-devel] [RFC 2 PATCH 05/16] hw/i386: Simplify topology
 Offset/width Calculation
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

U29tZSBwYXJhbWV0ZXJzIGFyZSB1bm5lY2Vzc2FyaWx5IHBhc3NlZCBmb3Igb2Zmc2V0L3dpZHRo
DQpjYWxjdWxhdGlvbi4gUmVtb3ZlIHRob3NlIHBhcmFtZXRlcnMgZnJvbSBmdW5jdGlvbiBwcm90
b3R5cGVzLg0KTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQoNClNpZ25lZC1vZmYtYnk6IEJhYnUgTW9n
ZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCi0tLQ0KIGluY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5o
IHwgICA0NSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIHRh
cmdldC9pMzg2L2NwdS5jICAgICAgICAgIHwgICAxMiArKysrLS0tLS0tLS0NCiAyIGZpbGVzIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody9pMzg2L3RvcG9sb2d5LmggYi9pbmNsdWRlL2h3L2kzODYvdG9wb2xvZ3kuaA0K
aW5kZXggOTA2MDE3ZThlMy4uZmIxMDg2M2E2NiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvaTM4
Ni90b3BvbG9neS5oDQorKysgYi9pbmNsdWRlL2h3L2kzODYvdG9wb2xvZ3kuaA0KQEAgLTczLDQ2
ICs3MywzNyBAQCBzdGF0aWMgdW5zaWduZWQgYXBpY2lkX2JpdHdpZHRoX2Zvcl9jb3VudCh1bnNp
Z25lZCBjb3VudCkNCiANCiAvKiBCaXQgd2lkdGggb2YgdGhlIFNNVF9JRCAodGhyZWFkIElEKSBm
aWVsZCBvbiB0aGUgQVBJQyBJRA0KICAqLw0KLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgYXBpY2lk
X3NtdF93aWR0aCh1bnNpZ25lZCBucl9kaWVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBucl9jb3JlcywNCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbnJfdGhyZWFkcykNCitzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGFwaWNpZF9zbXRfd2lkdGgodW5zaWduZWQgbnJfdGhyZWFkcykNCiB7DQogICAgIHJl
dHVybiBhcGljaWRfYml0d2lkdGhfZm9yX2NvdW50KG5yX3RocmVhZHMpOw0KIH0NCiANCiAvKiBC
aXQgd2lkdGggb2YgdGhlIENvcmVfSUQgZmllbGQNCiAgKi8NCi1zdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGFwaWNpZF9jb3JlX3dpZHRoKHVuc2lnbmVkIG5yX2RpZXMsDQotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBucl9jb3JlcywNCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIG5yX3RocmVhZHMpDQorc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBhcGljaWRfY29yZV93aWR0aCh1bnNpZ25lZCBucl9jb3JlcykN
CiB7DQogICAgIHJldHVybiBhcGljaWRfYml0d2lkdGhfZm9yX2NvdW50KG5yX2NvcmVzKTsNCiB9
DQogDQogLyogQml0IHdpZHRoIG9mIHRoZSBEaWVfSUQgZmllbGQgKi8NCi1zdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGFwaWNpZF9kaWVfd2lkdGgodW5zaWduZWQgbnJfZGllcywNCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbnJfY29yZXMsDQotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIG5yX3RocmVhZHMpDQor
c3RhdGljIGlubGluZSB1bnNpZ25lZCBhcGljaWRfZGllX3dpZHRoKHVuc2lnbmVkIG5yX2RpZXMp
DQogew0KICAgICByZXR1cm4gYXBpY2lkX2JpdHdpZHRoX2Zvcl9jb3VudChucl9kaWVzKTsNCiB9
DQogDQogLyogQml0IG9mZnNldCBvZiB0aGUgQ29yZV9JRCBmaWVsZA0KICAqLw0KLXN0YXRpYyBp
bmxpbmUgdW5zaWduZWQgYXBpY2lkX2NvcmVfb2Zmc2V0KHVuc2lnbmVkIG5yX2RpZXMsDQotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbnJfY29yZXMs
DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbnJf
dGhyZWFkcykNCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGFwaWNpZF9jb3JlX29mZnNldCh1bnNp
Z25lZCBucl90aHJlYWRzKQ0KIHsNCi0gICAgcmV0dXJuIGFwaWNpZF9zbXRfd2lkdGgobnJfZGll
cywgbnJfY29yZXMsIG5yX3RocmVhZHMpOw0KKyAgICByZXR1cm4gYXBpY2lkX3NtdF93aWR0aChu
cl90aHJlYWRzKTsNCiB9DQogDQogLyogQml0IG9mZnNldCBvZiB0aGUgRGllX0lEIGZpZWxkICov
DQotc3RhdGljIGlubGluZSB1bnNpZ25lZCBhcGljaWRfZGllX29mZnNldCh1bnNpZ25lZCBucl9k
aWVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IG5yX2NvcmVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBucl90aHJlYWRzKQ0KK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgYXBpY2lkX2RpZV9v
ZmZzZXQodW5zaWduZWQgbnJfY29yZXMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBucl90aHJlYWRzKQ0KIHsNCi0gICAgcmV0dXJuIGFwaWNpZF9j
b3JlX29mZnNldChucl9kaWVzLCBucl9jb3JlcywgbnJfdGhyZWFkcykgKw0KLSAgICAgICAgICAg
YXBpY2lkX2NvcmVfd2lkdGgobnJfZGllcywgbnJfY29yZXMsIG5yX3RocmVhZHMpOw0KKyAgICBy
ZXR1cm4gYXBpY2lkX2NvcmVfb2Zmc2V0KG5yX3RocmVhZHMpICsNCisgICAgICAgICAgIGFwaWNp
ZF9jb3JlX3dpZHRoKG5yX2NvcmVzKTsNCiB9DQogDQogLyogQml0IG9mZnNldCBvZiB0aGUgUGtn
X0lEIChzb2NrZXQgSUQpIGZpZWxkDQpAQCAtMTIxLDggKzExMiw4IEBAIHN0YXRpYyBpbmxpbmUg
dW5zaWduZWQgYXBpY2lkX3BrZ19vZmZzZXQodW5zaWduZWQgbnJfZGllcywNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIG5yX2NvcmVzLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbnJfdGhyZWFkcykN
CiB7DQotICAgIHJldHVybiBhcGljaWRfZGllX29mZnNldChucl9kaWVzLCBucl9jb3JlcywgbnJf
dGhyZWFkcykgKw0KLSAgICAgICAgICAgYXBpY2lkX2RpZV93aWR0aChucl9kaWVzLCBucl9jb3Jl
cywgbnJfdGhyZWFkcyk7DQorICAgIHJldHVybiBhcGljaWRfZGllX29mZnNldChucl9jb3Jlcywg
bnJfdGhyZWFkcykgKw0KKyAgICAgICAgICAgYXBpY2lkX2RpZV93aWR0aChucl9kaWVzKTsNCiB9
DQogDQogLyogTWFrZSBBUElDIElEIGZvciB0aGUgQ1BVIGJhc2VkIG9uIFBrZ19JRCwgQ29yZV9J
RCwgU01UX0lEDQpAQCAtMTM3LDggKzEyOCw4IEBAIHN0YXRpYyBpbmxpbmUgYXBpY19pZF90IGFw
aWNpZF9mcm9tX3RvcG9faWRzKFg4NkNQVVRvcG9JbmZvICp0b3BvX2luZm8sDQogICAgIHVuc2ln
bmVkIG5yX3RocmVhZHMgPSB0b3BvX2luZm8tPm5yX3RocmVhZHM7DQogDQogICAgIHJldHVybiAo
dG9wb19pZHMtPnBrZ19pZCAgPDwgYXBpY2lkX3BrZ19vZmZzZXQobnJfZGllcywgbnJfY29yZXMs
IG5yX3RocmVhZHMpKSB8DQotICAgICAgICAgICAodG9wb19pZHMtPmRpZV9pZCAgPDwgYXBpY2lk
X2RpZV9vZmZzZXQobnJfZGllcywgbnJfY29yZXMsIG5yX3RocmVhZHMpKSB8DQotICAgICAgICAg
ICAodG9wb19pZHMtPmNvcmVfaWQgPDwgYXBpY2lkX2NvcmVfb2Zmc2V0KG5yX2RpZXMsIG5yX2Nv
cmVzLCBucl90aHJlYWRzKSkgfA0KKyAgICAgICAgICAgKHRvcG9faWRzLT5kaWVfaWQgIDw8IGFw
aWNpZF9kaWVfb2Zmc2V0KG5yX2NvcmVzLCBucl90aHJlYWRzKSkgfA0KKyAgICAgICAgICAgKHRv
cG9faWRzLT5jb3JlX2lkIDw8IGFwaWNpZF9jb3JlX29mZnNldChucl90aHJlYWRzKSkgfA0KICAg
ICAgICAgICAgdG9wb19pZHMtPnNtdF9pZDsNCiB9DQogDQpAQCAtMTcxLDEzICsxNjIsMTMgQEAg
c3RhdGljIGlubGluZSB2b2lkIHg4Nl90b3BvX2lkc19mcm9tX2FwaWNpZChhcGljX2lkX3QgYXBp
Y2lkLA0KICAgICB1bnNpZ25lZCBucl90aHJlYWRzID0gdG9wb19pbmZvLT5ucl90aHJlYWRzOw0K
IA0KICAgICB0b3BvX2lkcy0+c210X2lkID0gYXBpY2lkICYNCi0gICAgICAgICAgICB+KDB4RkZG
RkZGRkZVTCA8PCBhcGljaWRfc210X3dpZHRoKG5yX2RpZXMsIG5yX2NvcmVzLCBucl90aHJlYWRz
KSk7DQorICAgICAgICAgICAgfigweEZGRkZGRkZGVUwgPDwgYXBpY2lkX3NtdF93aWR0aChucl90
aHJlYWRzKSk7DQogICAgIHRvcG9faWRzLT5jb3JlX2lkID0NCi0gICAgICAgICAgICAoYXBpY2lk
ID4+IGFwaWNpZF9jb3JlX29mZnNldChucl9kaWVzLCBucl9jb3JlcywgbnJfdGhyZWFkcykpICYN
Ci0gICAgICAgICAgICB+KDB4RkZGRkZGRkZVTCA8PCBhcGljaWRfY29yZV93aWR0aChucl9kaWVz
LCBucl9jb3JlcywgbnJfdGhyZWFkcykpOw0KKyAgICAgICAgICAgIChhcGljaWQgPj4gYXBpY2lk
X2NvcmVfb2Zmc2V0KG5yX3RocmVhZHMpKSAmDQorICAgICAgICAgICAgfigweEZGRkZGRkZGVUwg
PDwgYXBpY2lkX2NvcmVfd2lkdGgobnJfY29yZXMpKTsNCiAgICAgdG9wb19pZHMtPmRpZV9pZCA9
DQotICAgICAgICAgICAgKGFwaWNpZCA+PiBhcGljaWRfZGllX29mZnNldChucl9kaWVzLCBucl9j
b3JlcywgbnJfdGhyZWFkcykpICYNCi0gICAgICAgICAgICB+KDB4RkZGRkZGRkZVTCA8PCBhcGlj
aWRfZGllX3dpZHRoKG5yX2RpZXMsIG5yX2NvcmVzLCBucl90aHJlYWRzKSk7DQorICAgICAgICAg
ICAgKGFwaWNpZCA+PiBhcGljaWRfZGllX29mZnNldChucl9jb3JlcywgbnJfdGhyZWFkcykpICYN
CisgICAgICAgICAgICB+KDB4RkZGRkZGRkZVTCA8PCBhcGljaWRfZGllX3dpZHRoKG5yX2RpZXMp
KTsNCiAgICAgdG9wb19pZHMtPnBrZ19pZCA9IGFwaWNpZCA+PiBhcGljaWRfcGtnX29mZnNldChu
cl9kaWVzLCBucl9jb3JlcywgbnJfdGhyZWFkcyk7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL3Rhcmdl
dC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kzODYvY3B1LmMNCmluZGV4IDE5NzUxZTM3YTcuLjZkN2Y5
YjZiOGIgMTAwNjQ0DQotLS0gYS90YXJnZXQvaTM4Ni9jcHUuYw0KKysrIGIvdGFyZ2V0L2kzODYv
Y3B1LmMNCkBAIC00MjYwLDggKzQyNjAsNyBAQCB2b2lkIGNwdV94ODZfY3B1aWQoQ1BVWDg2U3Rh
dGUgKmVudiwgdWludDMyX3QgaW5kZXgsIHVpbnQzMl90IGNvdW50LA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVheCwgZWJ4LCBlY3gsIGVkeCk7DQogICAgICAgICAgICAg
ICAgIGJyZWFrOw0KICAgICAgICAgICAgIGNhc2UgMzogLyogTDMgY2FjaGUgaW5mbyAqLw0KLSAg
ICAgICAgICAgICAgICBkaWVfb2Zmc2V0ID0gYXBpY2lkX2RpZV9vZmZzZXQoZW52LT5ucl9kaWVz
LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcy0+bnJfY29yZXMs
IGNzLT5ucl90aHJlYWRzKTsNCisgICAgICAgICAgICAgICAgZGllX29mZnNldCA9IGFwaWNpZF9k
aWVfb2Zmc2V0KGNzLT5ucl9jb3JlcywgY3MtPm5yX3RocmVhZHMpOw0KICAgICAgICAgICAgICAg
ICBpZiAoY3B1LT5lbmFibGVfbDNfY2FjaGUpIHsNCiAgICAgICAgICAgICAgICAgICAgIGVuY29k
ZV9jYWNoZV9jcHVpZDQoZW52LT5jYWNoZV9pbmZvX2NwdWlkNC5sM19jYWNoZSwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDEgPDwgZGllX29mZnNldCksIGNzLT5u
cl9jb3JlcywNCkBAIC00MzQ2LDggKzQzNDUsNyBAQCB2b2lkIGNwdV94ODZfY3B1aWQoQ1BVWDg2
U3RhdGUgKmVudiwgdWludDMyX3QgaW5kZXgsIHVpbnQzMl90IGNvdW50LA0KIA0KICAgICAgICAg
c3dpdGNoIChjb3VudCkgew0KICAgICAgICAgY2FzZSAwOg0KLSAgICAgICAgICAgICplYXggPSBh
cGljaWRfY29yZV9vZmZzZXQoZW52LT5ucl9kaWVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY3MtPm5yX2NvcmVzLCBjcy0+bnJfdGhyZWFkcyk7DQorICAgICAgICAg
ICAgKmVheCA9IGFwaWNpZF9jb3JlX29mZnNldChjcy0+bnJfdGhyZWFkcyk7DQogICAgICAgICAg
ICAgKmVieCA9IGNzLT5ucl90aHJlYWRzOw0KICAgICAgICAgICAgICplY3ggfD0gQ1BVSURfVE9Q
T0xPR1lfTEVWRUxfU01UOw0KICAgICAgICAgICAgIGJyZWFrOw0KQEAgLTQzNzcsMTQgKzQzNzUs
MTIgQEAgdm9pZCBjcHVfeDg2X2NwdWlkKENQVVg4NlN0YXRlICplbnYsIHVpbnQzMl90IGluZGV4
LCB1aW50MzJfdCBjb3VudCwNCiAgICAgICAgICplZHggPSBjcHUtPmFwaWNfaWQ7DQogICAgICAg
ICBzd2l0Y2ggKGNvdW50KSB7DQogICAgICAgICBjYXNlIDA6DQotICAgICAgICAgICAgKmVheCA9
IGFwaWNpZF9jb3JlX29mZnNldChlbnYtPm5yX2RpZXMsIGNzLT5ucl9jb3JlcywNCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3MtPm5yX3RocmVh
ZHMpOw0KKyAgICAgICAgICAgICplYXggPSBhcGljaWRfY29yZV9vZmZzZXQoY3MtPm5yX3RocmVh
ZHMpOw0KICAgICAgICAgICAgICplYnggPSBjcy0+bnJfdGhyZWFkczsNCiAgICAgICAgICAgICAq
ZWN4IHw9IENQVUlEX1RPUE9MT0dZX0xFVkVMX1NNVDsNCiAgICAgICAgICAgICBicmVhazsNCiAg
ICAgICAgIGNhc2UgMToNCi0gICAgICAgICAgICAqZWF4ID0gYXBpY2lkX2RpZV9vZmZzZXQoZW52
LT5ucl9kaWVzLCBjcy0+bnJfY29yZXMsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY3MtPm5yX3RocmVhZHMpOw0KKyAgICAgICAgICAgICplYXgg
PSBhcGljaWRfZGllX29mZnNldChjcy0+bnJfY29yZXMsIGNzLT5ucl90aHJlYWRzKTsNCiAgICAg
ICAgICAgICAqZWJ4ID0gY3MtPm5yX2NvcmVzICogY3MtPm5yX3RocmVhZHM7DQogICAgICAgICAg
ICAgKmVjeCB8PSBDUFVJRF9UT1BPTE9HWV9MRVZFTF9DT1JFOw0KICAgICAgICAgICAgIGJyZWFr
Ow0KDQo=

