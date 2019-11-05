Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF1C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586642087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="McARwzEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586642087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6n4-0000kC-CZ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iS6Cj-0005v3-Eq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iS6Ci-0006Dw-Bh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:17:33 -0500
Received: from mail-eopbgr720060.outbound.protection.outlook.com
 ([40.107.72.60]:6464 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iS6Ci-0006DO-43
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:17:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVzG9xyLkE+JScwUaXHvhefH61DyzokeQUOyT/lXsTBMdybnSqTHa8enVUMYAJ7cy+i05bqscdCAYvb2A/U+/A73TxrC6cwbL8vQCuXMXrey3T9CkoODyL0l1h+VZ6QJTLdiipPQsrQ/g1nw4BGtBMAPvii0ZVHJhpmKbDtZckEcw2ERT2CyhZuaU+VrY6rzDfGAvsfCSR6sm68ren0BrhrmilGJOabm9BEdbiSUWCyvGqyrwL84XGFohMOrQPEt3wpAQSDkCcghtrlEctFim8mmKUFwO4UKUUssIQTvqVrIbk6iIKboszs6lN1L1eGhpH14nBvAhPQp9LF11IowaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/6V9e69wwS3YRHpyTsTLECGsF04XPio6t7FqHfy6m8=;
 b=XvTUe10jyHSiqN0VfWXGtM4aD5MG5SaHENjOB5XVI2Rfe8uMP3+BFZglIRX4CHn2aDZCHLLvY5ypq0lS5OBN5Sl+47aKNTl9MuQEMME+wX6iXjt1crmfgSyFnEiJqanRrpNcL/ZntLeCH0DTiyIb2YO4ivD5EG4AvGajndKbYDD5FGAl+Z2FSzzHmPr8Uh1zoVwsWWL00Kf4eLbPTI8HDUMkpoqt0CKr+pXM5HbUD7+H2WI7R3E62kP+j2ZqWKt7ySdZoe9qtfamRAHeeXbVacAxoYF5KV1hJs7KaMRshUGdKzW5OTqWmCLKJeHmeRIaelWcNXvJQvx18J4X5XN4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/6V9e69wwS3YRHpyTsTLECGsF04XPio6t7FqHfy6m8=;
 b=McARwzEE3uFgjep6GtMvsE83VB+8P81HP0teL1iwHZnlecoi0o1fhoVdJukmkj+QWJNOosIiV61mW+ywvqasmSHn+szWS2A902D6khl+Y0UpsaWvpO/HxTujiAFa2ojjFLkeKGRJQUJZZ/XclvhoWa+gZ1pnXu8umzdMzWDMUmI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 21:17:30 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c5a3:6a2e:8699:1999]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c5a3:6a2e:8699:1999%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 21:17:30 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>
Subject: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
Thread-Topic: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
Thread-Index: AQHVlB5u/QshhXRmbESG6YL51EBKfQ==
Date: Tue, 5 Nov 2019 21:17:30 +0000
Message-ID: <157298864859.17394.12763030347823834590.stgit@naples-babu.amd.com>
References: <157298859935.17394.17194072829278152009.stgit@naples-babu.amd.com>
In-Reply-To: <157298859935.17394.17194072829278152009.stgit@naples-babu.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0020.namprd04.prod.outlook.com
 (2603:10b6:803:21::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 515f1f5b-09be-45cd-185a-08d7623590d7
x-ms-traffictypediagnostic: DM5PR12MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13239BC5040B9453AB2451F8957E0@DM5PR12MB1323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(5660300002)(6116002)(2501003)(8936002)(486006)(71190400001)(71200400001)(6512007)(52116002)(76176011)(86362001)(14454004)(6436002)(186003)(103116003)(26005)(3846002)(6486002)(2906002)(6506007)(102836004)(11346002)(446003)(256004)(386003)(66556008)(14444005)(64756008)(4326008)(316002)(99286004)(305945005)(7736002)(66946007)(478600001)(66066001)(66446008)(8676002)(66476007)(476003)(81166006)(110136005)(81156014)(25786009)(2201001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fj9F87a4R8u0lQ/D6OVPPKs6bxrwdiYu+VaU7DSCTzYHL2RqADw602RgA82fw5Ah0YX5SidL1nk2b5jF/mplO1kBettfNZSw/p5onXJajjeHwMabfK7N5Ua1NyQjsoWFtaMroAgeoIi6N9DqDalRHooctLvrbShCHIHuItXOcDoDkdnU9nMnYuYOHSTHTrTWCOxKcV4Nlo6/uOyOMYfg2mTLojW3Wp+LU3PU74ys0zbiL0rD/7sZph9hpfxcVHet68BZXNKy30lUDeuzg17gExvXdVeNCnFfJl05HJSzVY5+2+n/mVnUjSM/oYLcOSOetqqWlh+SALo5ZjB8PAZK1BJUGpZTtT5Q8HmTtpNApVOnWAxvisT6/x+JVrF6PqWOs7tU5zSE2vn7BdCwZsxLeysj591hroThx+stJDEYpmmHv14MGhcoQZW9v74W4Rsy
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E4E8DB7E0B1884891F2F2A66EA69617@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515f1f5b-09be-45cd-185a-08d7623590d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 21:17:30.0637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbQGt1LV8xre1RurXNfKS9vluC4WyK99GqXu8vqJz+ZJaP0hL+KLXh4WHYakG4o9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.60
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

QWRkcyB0aGUgZm9sbG93aW5nIG1pc3NpbmcgQ1BVSUQgYml0czoNCnBlcmZjdHItY29yZSA6IGNv
cmUgcGVyZm9ybWFuY2UgY291bnRlciBleHRlbnNpb25zIHN1cHBvcnQuIEVuYWJsZXMgdGhlIFZN
DQogICAgICAgICAgICAgICB0byB1c2UgZXh0ZW5kZWQgcGVyZm9ybWFuY2UgY291bnRlciBzdXBw
b3J0LiBJdCBlbmFibGVzIHNpeA0KICAgICAgICAgICAgICAgcHJvZ3JhbW1hYmxlIGNvdW50ZXJz
IGluc3RlYWQgb2YgNCBjb3VudGVycy4NCmNsemVybyAgICAgICA6IGluc3RydWN0aW9uIHplcm9l
cyBvdXQgdGhlIDY0IGJ5dGUgY2FjaGUgbGluZSBzcGVjaWZpZWQgaW4gUkFYLg0KeHNhdmVlcnB0
ciAgIDogWFNBVkUsIFhTQVZFLCBGWFNBVkVPUFQsIFhTQVZFQywgWFNBVkVTIGFsd2F5cyBzYXZl
IGVycm9yDQogICAgICAgICAgICAgICBwb2ludGVycyBhbmQgRlhSU1RPUiwgWFJTVE9SLCBYUlNU
T1JTIGFsd2F5cyByZXN0b3JlIGVycm9yDQogICAgICAgICAgICAgICBwb2ludGVycy4NCmlicGIg
ICAgICAgICA6IEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0aW9uIEJhcnJpZS4NCnhzYXZlcyAgICAg
ICA6IFhTQVZFUywgWFJTVE9SUyBhbmQgSUEzMl9YU1Mgc3VwcG9ydGVkLg0KDQpEZXBlbmRzIG9u
Og0KNDBiYzQ3YjA4YjZlICgia3ZtOiB4ODY6IEVudW1lcmF0ZSBzdXBwb3J0IGZvciBDTFpFUk8g
aW5zdHJ1Y3Rpb24iKQ0KNTA0Y2UxOTU0ZmJhICgiS1ZNOiB4ODY6IEV4cG9zZSBYU0FWRUVSUFRS
IHRvIHRoZSBndWVzdCIpDQo1MjI5NzQzNjE5OWQgKCJrdm06IHN2bTogVXBkYXRlIHN2bV94c2F2
ZXNfc3VwcG9ydGVkIikNCg0KU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBh
bWQuY29tPg0KLS0tDQogaHcvaTM4Ni9wYy5jICAgICAgfCAgICA4ICsrKysrKystDQogdGFyZ2V0
L2kzODYvY3B1LmMgfCAgIDExICsrKysrLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9wYy5jIGIv
aHcvaTM4Ni9wYy5jDQppbmRleCA1MWI3MjQzOWI0Li5hNzJmZTFkYjMxIDEwMDY0NA0KLS0tIGEv
aHcvaTM4Ni9wYy5jDQorKysgYi9ody9pMzg2L3BjLmMNCkBAIC0xMDUsNyArMTA1LDEzIEBAIHN0
cnVjdCBocGV0X2Z3X2NvbmZpZyBocGV0X2NmZyA9IHsuY291bnQgPSBVSU5UOF9NQVh9Ow0KIC8q
IFBoeXNpY2FsIEFkZHJlc3Mgb2YgUFZIIGVudHJ5IHBvaW50IHJlYWQgZnJvbSBrZXJuZWwgRUxG
IE5PVEUgKi8NCiBzdGF0aWMgc2l6ZV90IHB2aF9zdGFydF9hZGRyOw0KIA0KLUdsb2JhbFByb3Bl
cnR5IHBjX2NvbXBhdF80XzFbXSA9IHt9Ow0KK0dsb2JhbFByb3BlcnR5IHBjX2NvbXBhdF80XzFb
XSA9IHsNCisgICAgeyAiRVBZQyIgIi0iIFRZUEVfWDg2X0NQVSwgInBlcmZjdHItY29yZSIsICJv
ZmYiIH0sDQorICAgIHsgIkVQWUMiICItIiBUWVBFX1g4Nl9DUFUsICJjbHplcm8iLCAib2ZmIiB9
LA0KKyAgICB7ICJFUFlDIiAiLSIgVFlQRV9YODZfQ1BVLCAieHNhdmVlcnB0ciIsICJvZmYiIH0s
DQorICAgIHsgIkVQWUMiICItIiBUWVBFX1g4Nl9DUFUsICJpYnBiIiwgIm9mZiIgfSwNCisgICAg
eyAiRVBZQyIgIi0iIFRZUEVfWDg2X0NQVSwgInhzYXZlcyIsICJvZmYiIH0sDQorfTsNCiBjb25z
dCBzaXplX3QgcGNfY29tcGF0XzRfMV9sZW4gPSBHX05fRUxFTUVOVFMocGNfY29tcGF0XzRfMSk7
DQogDQogR2xvYmFsUHJvcGVydHkgcGNfY29tcGF0XzRfMFtdID0ge307DQpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2kzODYvY3B1LmMgYi90YXJnZXQvaTM4Ni9jcHUuYw0KaW5kZXggMDdjZjU2MmQ4OS4u
NzEyMzNlNjMxMCAxMDA2NDQNCi0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQorKysgYi90YXJnZXQv
aTM4Ni9jcHUuYw0KQEAgLTMxMTAsMTkgKzMxMTAsMTggQEAgc3RhdGljIFg4NkNQVURlZmluaXRp
b24gYnVpbHRpbl94ODZfZGVmc1tdID0gew0KICAgICAgICAgICAgIENQVUlEX0VYVDNfT1NWVyB8
IENQVUlEX0VYVDNfM0ROT1dQUkVGRVRDSCB8DQogICAgICAgICAgICAgQ1BVSURfRVhUM19NSVNB
TElHTlNTRSB8IENQVUlEX0VYVDNfU1NFNEEgfCBDUFVJRF9FWFQzX0FCTSB8DQogICAgICAgICAg
ICAgQ1BVSURfRVhUM19DUjhMRUcgfCBDUFVJRF9FWFQzX1NWTSB8IENQVUlEX0VYVDNfTEFIRl9M
TSB8DQotICAgICAgICAgICAgQ1BVSURfRVhUM19UT1BPRVhULA0KKyAgICAgICAgICAgIENQVUlE
X0VYVDNfVE9QT0VYVCB8IENQVUlEX0VYVDNfUEVSRkNPUkUsDQorICAgICAgICAuZmVhdHVyZXNb
RkVBVF84MDAwXzAwMDhfRUJYXSA9DQorICAgICAgICAgICAgQ1BVSURfODAwMF8wMDA4X0VCWF9D
TFpFUk8gfCBDUFVJRF84MDAwXzAwMDhfRUJYX1hTQVZFRVJQVFIgfA0KKyAgICAgICAgICAgIENQ
VUlEXzgwMDBfMDAwOF9FQlhfSUJQQiwNCiAgICAgICAgIC5mZWF0dXJlc1tGRUFUXzdfMF9FQlhd
ID0NCiAgICAgICAgICAgICBDUFVJRF83XzBfRUJYX0ZTR1NCQVNFIHwgQ1BVSURfN18wX0VCWF9C
TUkxIHwgQ1BVSURfN18wX0VCWF9BVlgyIHwNCiAgICAgICAgICAgICBDUFVJRF83XzBfRUJYX1NN
RVAgfCBDUFVJRF83XzBfRUJYX0JNSTIgfCBDUFVJRF83XzBfRUJYX1JEU0VFRCB8DQogICAgICAg
ICAgICAgQ1BVSURfN18wX0VCWF9BRFggfCBDUFVJRF83XzBfRUJYX1NNQVAgfCBDUFVJRF83XzBf
RUJYX0NMRkxVU0hPUFQgfA0KICAgICAgICAgICAgIENQVUlEXzdfMF9FQlhfU0hBX05JLA0KLSAg
ICAgICAgLyogTWlzc2luZzogWFNBVkVTIChub3Qgc3VwcG9ydGVkIGJ5IHNvbWUgTGludXggdmVy
c2lvbnMsDQotICAgICAgICAgKiBpbmNsdWRpbmcgdjQuMSB0byB2NC4xMikuDQotICAgICAgICAg
KiBLVk0gZG9lc24ndCB5ZXQgZXhwb3NlIGFueSBYU0FWRVMgc3RhdGUgc2F2ZSBjb21wb25lbnQu
DQotICAgICAgICAgKi8NCiAgICAgICAgIC5mZWF0dXJlc1tGRUFUX1hTQVZFXSA9DQogICAgICAg
ICAgICAgQ1BVSURfWFNBVkVfWFNBVkVPUFQgfCBDUFVJRF9YU0FWRV9YU0FWRUMgfA0KLSAgICAg
ICAgICAgIENQVUlEX1hTQVZFX1hHRVRCVjEsDQorICAgICAgICAgICAgQ1BVSURfWFNBVkVfWEdF
VEJWMSB8IENQVUlEX1hTQVZFX1hTQVZFUywNCiAgICAgICAgIC5mZWF0dXJlc1tGRUFUXzZfRUFY
XSA9DQogICAgICAgICAgICAgQ1BVSURfNl9FQVhfQVJBVCwNCiAgICAgICAgIC5mZWF0dXJlc1tG
RUFUX1NWTV0gPQ0KDQo=

