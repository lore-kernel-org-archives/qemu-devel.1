Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C2C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537BE206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sc+mE+QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537BE206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxLy-0006YE-KL
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlxLl-000699-5Y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlxLj-0008Nx-Nw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:20:41 -0400
Received: from mail-eopbgr820058.outbound.protection.outlook.com
 ([40.107.82.58]:38866 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlxLj-0008Ly-G2
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:20:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP8v2ik8KUY4j7mvrUV2yd15eRRA/PW/W6S1s6f9xgpCucCKKhuvWXDEqffgTfr8tkGKzSvK6gWaJjAKz6CMsb7GQmY2rG86/bYHF2hdZAv8iL6K8dd7j4eOf83mOihjAW6k6RBkacmDBEsQXGRibSIbfvQSuUhYy6+CTi6SrZPvqUsVRMjPepMVgosb6aXKw0UoQ/KKEA4VbtPxMFn968x5LB4+GCCyU/YN2zrvaQn+dXQFImqh93164WfDzJzv8vsZdN+gcz0Gbm1bbTg268ozHDGFaeyHL4AZ1cPdV4lYtpFRV9sOHo7wDwbc1BiQ3GB9SgmenojVCbCBHMz7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Nngvs/zwYXDRHMNXnvPICgeCr0cEUmfaLP0tX2/uk=;
 b=Sxl9nfOD9S73LCfK+0mq16Gwn1pTFvWDTwyrfATH1kamsPCwGD/YEi/UFLQSWzx/X8jUnDazFNOlkQBVm3j+Eof/wnJvJ1EuUpbxQgJkG1VTEE1ctu6UcQ1tAnCgLSGs880SctdVqPhlSlZVutloSR5YbgG1IW4bDleXasBIHSV6Zl2XTU4bBW4/u6Yw3klwtdD7oqcKpuYCpKQEl+KaNHp6k3DrZEDh9HygcnXACH9d0wyW8tSUuj2vYlJ8gMnppcEZEDODBtv2pfLjQgM9pbSCn0aczHdeOlO8AI5cFmnKSpipkYlSk/MSFCr4lsW6QDa9FVxecMnEHK3Xn6GGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Nngvs/zwYXDRHMNXnvPICgeCr0cEUmfaLP0tX2/uk=;
 b=Sc+mE+QMwxYtT4wKBbOHJUQesbeMIva0i8y9bj1xOlCcT/ZhrUpkACvpIJDaa0QdJUTO3egVh3qedjaNyyb4RSgmvyq6HihkCEIOx4M4QFPNR3VcTLIQVLyBAWRaeq7KbuDeOVQcD72Aqakp9tUtNcmYtdoQPj8Q4eE21yLamSo=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3484.namprd12.prod.outlook.com (20.178.199.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 15:20:36 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 15:20:36 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v2 10/13] target/i386: sev: add support to load incoming
 encrypted page
Thread-Index: AQHVN11Ji+wliLaTF0elg6lb5gX0sqbG09+AgABIGoA=
Date: Fri, 12 Jul 2019 15:20:36 +0000
Message-ID: <a566ca31-87fa-bf1a-456a-a2b497a26cf0@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-11-brijesh.singh@amd.com>
 <20190712110231.GE2730@work-vm>
In-Reply-To: <20190712110231.GE2730@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:805:a2::39) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9040999c-834d-4826-e5a9-08d706dc7d73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3484; 
x-ms-traffictypediagnostic: DM6PR12MB3484:
x-microsoft-antispam-prvs: <DM6PR12MB348467B6D41046C1DCB44085E5F20@DM6PR12MB3484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(4326008)(7736002)(305945005)(25786009)(36756003)(66066001)(52116002)(76176011)(31686004)(316002)(186003)(102836004)(2906002)(53546011)(6506007)(386003)(26005)(54906003)(6116002)(3846002)(66946007)(5660300002)(8676002)(11346002)(446003)(229853002)(66556008)(66446008)(66476007)(6512007)(486006)(86362001)(6916009)(478600001)(6246003)(81166006)(81156014)(64756008)(8936002)(256004)(14444005)(6486002)(476003)(2616005)(31696002)(6436002)(71190400001)(71200400001)(14454004)(68736007)(99286004)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3484;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cEAj3SpeOYmhbbjaXnvy5pKZdqPd4EBNmQMsowT9q07FaI3LB4zthAQ5yTqbOptqaCM4Bhd5SS9YLtLbZ6UNVWUNe8rEqllhj8iXgeIHbXx6/bAwTn8tSKG3IOWOr2xXzfiz2NJAiLmfNXc+Pp0XP9zAaiANI/BLUJt8l11OrLifZxrVIFkYEyizieAr6ixXvLs9HQUZp4SxjZndkgjtWZ/97ZOMvlmYgQoZ2LpYSbmjj+Ob2+dLVIBo4ia8XYMQ5beIPPA9cds/pPCB8ox21Pc8tBdfZM0+uNgT6WWFFWTYtvAADUzbNlYTSwhHG9MckWaPO9U29oKdONyy5j+gHY8cF8vfw8vutvc9zZmxscusrOFHq43oFm2Y0wnpWBr4DnpWz6iGbl4vESu+pM1h90kAFaTCAWz3e7UNh67AGIw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94F1E0E2C22D954C9D0EACB352AD1AAC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9040999c-834d-4826-e5a9-08d706dc7d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 15:20:36.6931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.58
Subject: Re: [Qemu-devel] [PATCH v2 10/13] target/i386: sev: add support to
 load incoming encrypted page
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDcvMTIvMTkgNjowMiBBTSwgRHIuIERhdmlkIEFsYW4gR2lsYmVydCB3cm90ZToNCj4g
KiBTaW5naCwgQnJpamVzaCAoYnJpamVzaC5zaW5naEBhbWQuY29tKSB3cm90ZToNCj4+IFRoZSBz
ZXZfbG9hZF9pbmNvbWluZ19wYWdlKCkgcHJvdmlkZSB0aGUgaW1wbGVtZW50YXRpb24gdG8gcmVh
ZCB0aGUNCj4+IGluY29taW5nIGd1ZXN0IHByaXZhdGUgcGFnZXMgZnJvbSB0aGUgc29ja2V0IGFu
ZCBsb2FkIGl0IGludG8gdGhlIGd1ZXN0DQo+PiBtZW1vcnkuIFRoZSByb3V0aW5lcyB1c2VzIHRo
ZSBSRUNFSVZFX1NUQVJUIGNvbW1hbmQgdG8gY3JlYXRlIHRoZQ0KPj4gaW5jb21pbmcgZW5jcnlw
dGlvbiBjb250ZXh0IG9uIHRoZSBmaXJzdCBjYWxsIHRoZW4gdXNlcyB0aGUNCj4+IFJFQ0VJRVZF
X1VQREFURV9EQVRBIGNvbW1hbmQgdG8gbG9hZCB0aGUgZW5jcnlwdGVkIHBhZ2VzIGludG8gdGhl
IGd1ZXN0DQo+PiBtZW1vcnkuIEFmdGVyIG1pZ3JhdGlvbiBpcyBjb21wbGV0ZWQsIHdlIGlzc3Vl
IHRoZSBSRUNFSVZFX0ZJTklTSCBjb21tYW5kDQo+PiB0byB0cmFuc2l0aW9uIHRoZSBTRVYgZ3Vl
c3QgdG8gdGhlIHJ1bm5hYmxlIHN0YXRlIHNvIHRoYXQgaXQgY2FuIGJlDQo+PiBleGVjdXRlZC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5j
b20+DQo+PiAtLS0NCj4+ICAgYWNjZWwva3ZtL2t2bS1hbGwuYyAgICAgIHwgICAxICsNCj4+ICAg
dGFyZ2V0L2kzODYvc2V2LmMgICAgICAgIHwgMTI2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPj4gICB0YXJnZXQvaTM4Ni90cmFjZS1ldmVudHMgfCAgIDMgKw0KPj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FjY2VsL2t2bS9rdm0tYWxsLmMgYi9hY2NlbC9rdm0va3ZtLWFsbC5j
DQo+PiBpbmRleCBhOWZiNDQ3MjQ4Li43Zjk0ZGJhNmY5IDEwMDY0NA0KPj4gLS0tIGEvYWNjZWwv
a3ZtL2t2bS1hbGwuYw0KPj4gKysrIGIvYWNjZWwva3ZtL2t2bS1hbGwuYw0KPj4gQEAgLTE3OTMs
NiArMTc5Myw3IEBAIHN0YXRpYyBpbnQga3ZtX2luaXQoTWFjaGluZVN0YXRlICptcykNCj4+ICAg
DQo+PiAgICAgICAgICAga3ZtX3N0YXRlLT5tZW1jcnlwdF9lbmNyeXB0X2RhdGEgPSBzZXZfZW5j
cnlwdF9kYXRhOw0KPj4gICAgICAgICAgIGt2bV9zdGF0ZS0+bWVtY3J5cHRfc2F2ZV9vdXRnb2lu
Z19wYWdlID0gc2V2X3NhdmVfb3V0Z29pbmdfcGFnZTsNCj4+ICsgICAgICAgIGt2bV9zdGF0ZS0+
bWVtY3J5cHRfbG9hZF9pbmNvbWluZ19wYWdlID0gc2V2X2xvYWRfaW5jb21pbmdfcGFnZTsNCj4+
ICAgICAgIH0NCj4+ICAgDQo+PiAgICAgICByZXQgPSBrdm1fYXJjaF9pbml0KG1zLCBzKTsNCj4+
IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9zZXYuYyBiL3RhcmdldC9pMzg2L3Nldi5jDQo+PiBp
bmRleCAyOGIzNmM4MDM1Li4wOWE2MmQ2Zjg4IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L2kzODYv
c2V2LmMNCj4+ICsrKyBiL3RhcmdldC9pMzg2L3Nldi5jDQo+PiBAQCAtNzA4LDEzICs3MDgsMzQg
QEAgc2V2X2xhdW5jaF9maW5pc2goU0VWU3RhdGUgKnMpDQo+PiAgICAgICB9DQo+PiAgIH0NCj4+
ICAgDQo+PiArc3RhdGljIGludA0KPj4gK3Nldl9yZWNlaXZlX2ZpbmlzaChTRVZTdGF0ZSAqcykN
Cj4+ICt7DQo+PiArICAgIGludCBlcnJvciwgcmV0ID0gMTsNCj4+ICsNCj4+ICsgICAgdHJhY2Vf
a3ZtX3Nldl9yZWNlaXZlX2ZpbmlzaCgpOw0KPj4gKyAgICByZXQgPSBzZXZfaW9jdGwocy0+c2V2
X2ZkLCBLVk1fU0VWX1JFQ0VJVkVfRklOSVNILCAwLCAmZXJyb3IpOw0KPj4gKyAgICBpZiAocmV0
KSB7DQo+PiArICAgICAgICBlcnJvcl9yZXBvcnQoIiVzOiBSRUNFSVZFX0ZJTklTSCByZXQ9JWQg
ZndfZXJyb3I9JWQgJyVzJyIsDQo+PiArICAgICAgICAgICAgICAgIF9fZnVuY19fLCByZXQsIGVy
cm9yLCBmd19lcnJvcl90b19zdHIoZXJyb3IpKTsNCj4+ICsgICAgICAgIGdvdG8gZXJyOw0KPj4g
KyAgICB9DQo+PiArDQo+PiArICAgIHNldl9zZXRfZ3Vlc3Rfc3RhdGUoU0VWX1NUQVRFX1JVTk5J
TkcpOw0KPj4gK2VycjoNCj4+ICsgICAgcmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiArDQo+
PiAgIHN0YXRpYyB2b2lkDQo+PiAgIHNldl92bV9zdGF0ZV9jaGFuZ2Uodm9pZCAqb3BhcXVlLCBp
bnQgcnVubmluZywgUnVuU3RhdGUgc3RhdGUpDQo+PiAgIHsNCj4+ICAgICAgIFNFVlN0YXRlICpz
ID0gb3BhcXVlOw0KPj4gICANCj4+ICAgICAgIGlmIChydW5uaW5nKSB7DQo+PiAtICAgICAgICBp
ZiAoIXNldl9jaGVja19zdGF0ZShTRVZfU1RBVEVfUlVOTklORykpIHsNCj4+ICsgICAgICAgIGlm
IChzZXZfY2hlY2tfc3RhdGUoU0VWX1NUQVRFX1JFQ0VJVkVfVVBEQVRFKSkgew0KPj4gKyAgICAg
ICAgICAgIHNldl9yZWNlaXZlX2ZpbmlzaChzKTsNCj4+ICsgICAgICAgIH0gZWxzZSBpZiAoIXNl
dl9jaGVja19zdGF0ZShTRVZfU1RBVEVfUlVOTklORykpIHsNCj4+ICAgICAgICAgICAgICAgc2V2
X2xhdW5jaF9maW5pc2gocyk7DQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4gQEAgLTEw
NjUsNiArMTA4NiwxMDkgQEAgaW50IHNldl9zYXZlX291dGdvaW5nX3BhZ2Uodm9pZCAqaGFuZGxl
LCBRRU1VRmlsZSAqZiwgdWludDhfdCAqcHRyLA0KPj4gICAgICAgcmV0dXJuIHNldl9zZW5kX3Vw
ZGF0ZV9kYXRhKHMsIGYsIHB0ciwgc3osIGJ5dGVzX3NlbnQpOw0KPj4gICB9DQo+PiAgIA0KPj4g
K3N0YXRpYyBpbnQNCj4+ICtzZXZfcmVjZWl2ZV9zdGFydChRU2V2R3Vlc3RJbmZvICpzZXYsIFFF
TVVGaWxlICpmKQ0KPj4gK3sNCj4+ICsgICAgaW50IHJldCA9IDE7DQo+PiArICAgIGludCBmd19l
cnJvcjsNCj4+ICsgICAgc3RydWN0IGt2bV9zZXZfcmVjZWl2ZV9zdGFydCAqc3RhcnQ7DQo+PiAr
ICAgIGdjaGFyICpzZXNzaW9uID0gTlVMTCwgKnBkaF9jZXJ0ID0gTlVMTDsNCj4+ICsNCj4+ICsg
ICAgc3RhcnQgPSBnX25ldzAoc3RydWN0IGt2bV9zZXZfcmVjZWl2ZV9zdGFydCwgMSk7DQo+IA0K
PiBTYW1lIGFzIHRoZSBzZW5kIHBhdGNoOyB0aGVzZSBhcmUgdGlueSBzbyBtYXkgYXMgd2VsbCBi
ZSBvbiB0aGUgc3RhY2sNCj4gDQo+PiArICAgIC8qIGdldCBTRVYgZ3Vlc3QgaGFuZGxlICovDQo+
PiArICAgIHN0YXJ0LT5oYW5kbGUgPSBvYmplY3RfcHJvcGVydHlfZ2V0X2ludChPQkpFQ1Qoc2V2
KSwgImhhbmRsZSIsDQo+PiArICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4+ICsNCj4+ICsg
ICAgLyogZ2V0IHRoZSBzb3VyY2UgcG9saWN5ICovDQo+PiArICAgIHN0YXJ0LT5wb2xpY3kgPSBx
ZW11X2dldF9iZTMyKGYpOw0KPj4gKw0KPj4gKyAgICAvKiBnZXQgc291cmNlIFBESCBrZXkgKi8N
Cj4+ICsgICAgc3RhcnQtPnBkaF9sZW4gPSBxZW11X2dldF9iZTMyKGYpOw0KPiANCj4gWW91IG1p
Z2h0IHdhbnQgdG8gYm91bmQgdGhlIHNpemVzIG9mIHBkaF9sZW4gYW5kIHNlc3Npb25fbGVuDQo+
IG9uIHJlYWRpbmc7IGlmIHRoZSBtaWdyYXRpb24gc3RyZWFtIGlzIGJhZGx5IGNvcnJ1cHQgeW91
IGNvdWxkDQo+IGVuZCB1cCBhbGxvY2F0aW5nIGFuZCB0aGVuIHRyeWluZyB0byByZWFkIGEgZmV3
IEdCIG9manVuayBvZmYgdGhlIHdpcmUuDQo+IA0KDQpHb29kIHBvaW50LiBOb3RlZC4NCg0KDQo+
PiArICAgIHBkaF9jZXJ0ID0gZ19uZXcoZ2NoYXIsIHN0YXJ0LT5wZGhfbGVuKTsNCj4+ICsgICAg
cWVtdV9nZXRfYnVmZmVyKGYsICh1aW50OF90ICopcGRoX2NlcnQsIHN0YXJ0LT5wZGhfbGVuKTsN
Cj4+ICsgICAgc3RhcnQtPnBkaF91YWRkciA9ICh1bnNpZ25lZCBsb25nKXBkaF9jZXJ0Ow0KPj4g
Kw0KPj4gKyAgICAvKiBnZXQgc291cmNlIHNlc3Npb24gZGF0YSAqLw0KPj4gKyAgICBzdGFydC0+
c2Vzc2lvbl9sZW4gPSBxZW11X2dldF9iZTMyKGYpOw0KPj4gKyAgICBzZXNzaW9uID0gZ19uZXco
Z2NoYXIsIHN0YXJ0LT5zZXNzaW9uX2xlbik7DQo+PiArICAgIHFlbXVfZ2V0X2J1ZmZlcihmLCAo
dWludDhfdCAqKXNlc3Npb24sIHN0YXJ0LT5zZXNzaW9uX2xlbik7DQo+PiArICAgIHN0YXJ0LT5z
ZXNzaW9uX3VhZGRyID0gKHVuc2lnbmVkIGxvbmcpc2Vzc2lvbjsNCj4+ICsNCj4+ICsgICAgdHJh
Y2Vfa3ZtX3Nldl9yZWNlaXZlX3N0YXJ0KHN0YXJ0LT5wb2xpY3ksIHNlc3Npb24sIHBkaF9jZXJ0
KTsNCj4+ICsNCj4+ICsgICAgcmV0ID0gc2V2X2lvY3RsKHNldl9zdGF0ZS0+c2V2X2ZkLCBLVk1f
U0VWX1JFQ0VJVkVfU1RBUlQsIHN0YXJ0LCAmZndfZXJyb3IpOw0KPj4gKyAgICBpZiAocmV0IDwg
MCkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJvciBSRUNFSVZFX1NUQVJUIHJldD0l
ZCBmd19lcnJvcj0lZCAnJXMnIiwNCj4+ICsgICAgICAgICAgICAgICAgcmV0LCBmd19lcnJvciwg
ZndfZXJyb3JfdG9fc3RyKGZ3X2Vycm9yKSk7DQo+PiArICAgICAgICBnb3RvIGVycjsNCj4+ICsg
ICAgfQ0KPj4gKw0KPj4gKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpFQ1Qoc2V2KSwg
c3RhcnQtPmhhbmRsZSwgImhhbmRsZSIsICZlcnJvcl9hYm9ydCk7DQo+PiArICAgIHNldl9zZXRf
Z3Vlc3Rfc3RhdGUoU0VWX1NUQVRFX1JFQ0VJVkVfVVBEQVRFKTsNCj4+ICtlcnI6DQo+PiArICAg
IGdfZnJlZShzdGFydCk7DQo+PiArICAgIGdfZnJlZShzZXNzaW9uKTsNCj4+ICsgICAgZ19mcmVl
KHBkaF9jZXJ0KTsNCj4+ICsNCj4+ICsgICAgcmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIGludCBzZXZfcmVjZWl2ZV91cGRhdGVfZGF0YShRRU1VRmlsZSAqZiwgdWludDhfdCAq
cHRyKQ0KPj4gK3sNCj4+ICsgICAgaW50IHJldCA9IDEsIGZ3X2Vycm9yID0gMDsNCj4+ICsgICAg
Z2NoYXIgKmhkciA9IE5VTEwsICp0cmFucyA9IE5VTEw7DQo+PiArICAgIHN0cnVjdCBrdm1fc2V2
X3JlY2VpdmVfdXBkYXRlX2RhdGEgKnVwZGF0ZTsNCj4+ICsNCj4+ICsgICAgdXBkYXRlID0gZ19u
ZXcwKHN0cnVjdCBrdm1fc2V2X3JlY2VpdmVfdXBkYXRlX2RhdGEsIDEpOw0KPiANCj4gU2ltaWxh
ciBjb21tZW50cyB0byB0aGUgX3N0YXJ0IGZ1bmN0aW9uDQo+IA0KDQpOb3RlZC4NCg0KDQo+PiAr
ICAgIC8qIGdldCBwYWNrZXQgaGVhZGVyICovDQo+PiArICAgIHVwZGF0ZS0+aGRyX2xlbiA9IHFl
bXVfZ2V0X2JlMzIoZik7DQo+PiArICAgIGhkciA9IGdfbmV3KGdjaGFyLCB1cGRhdGUtPmhkcl9s
ZW4pOw0KPj4gKyAgICBxZW11X2dldF9idWZmZXIoZiwgKHVpbnQ4X3QgKiloZHIsIHVwZGF0ZS0+
aGRyX2xlbik7DQo+PiArICAgIHVwZGF0ZS0+aGRyX3VhZGRyID0gKHVuc2lnbmVkIGxvbmcpaGRy
Ow0KPj4gKw0KPj4gKyAgICAvKiBnZXQgdHJhbnNwb3J0IGJ1ZmZlciAqLw0KPj4gKyAgICB1cGRh
dGUtPnRyYW5zX2xlbiA9IHFlbXVfZ2V0X2JlMzIoZik7DQo+PiArICAgIHRyYW5zID0gZ19uZXco
Z2NoYXIsIHVwZGF0ZS0+dHJhbnNfbGVuKTsNCj4+ICsgICAgdXBkYXRlLT50cmFuc191YWRkciA9
ICh1bnNpZ25lZCBsb25nKXRyYW5zOw0KPj4gKyAgICBxZW11X2dldF9idWZmZXIoZiwgKHVpbnQ4
X3QgKil1cGRhdGUtPnRyYW5zX3VhZGRyLCB1cGRhdGUtPnRyYW5zX2xlbik7DQo+PiArDQo+PiAr
ICAgIHVwZGF0ZS0+Z3Vlc3RfdWFkZHIgPSAodW5zaWduZWQgbG9uZykgcHRyOw0KPj4gKyAgICB1
cGRhdGUtPmd1ZXN0X2xlbiA9IHVwZGF0ZS0+dHJhbnNfbGVuOw0KPj4gKw0KPj4gKyAgICB0cmFj
ZV9rdm1fc2V2X3JlY2VpdmVfdXBkYXRlX2RhdGEodHJhbnMsIHB0ciwgdXBkYXRlLT5ndWVzdF9s
ZW4sDQo+PiArICAgICAgICAgICAgaGRyLCB1cGRhdGUtPmhkcl9sZW4pOw0KPj4gKw0KPj4gKyAg
ICByZXQgPSBzZXZfaW9jdGwoc2V2X3N0YXRlLT5zZXZfZmQsIEtWTV9TRVZfUkVDRUlWRV9VUERB
VEVfREFUQSwNCj4+ICsgICAgICAgICAgICAgICAgICAgIHVwZGF0ZSwgJmZ3X2Vycm9yKTsNCj4+
ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJvciBSRUNFSVZF
X1VQREFURV9EQVRBIHJldD0lZCBmd19lcnJvcj0lZCAnJXMnIiwNCj4+ICsgICAgICAgICAgICAg
ICAgcmV0LCBmd19lcnJvciwgZndfZXJyb3JfdG9fc3RyKGZ3X2Vycm9yKSk7DQo+PiArICAgICAg
ICBnb3RvIGVycjsNCj4+ICsgICAgfQ0KPj4gK2VycjoNCj4+ICsgICAgZ19mcmVlKHRyYW5zKTsN
Cj4+ICsgICAgZ19mcmVlKHVwZGF0ZSk7DQo+PiArICAgIGdfZnJlZShoZHIpOw0KPj4gKyAgICBy
ZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICtpbnQgc2V2X2xvYWRfaW5jb21pbmdfcGFnZSh2
b2lkICpoYW5kbGUsIFFFTVVGaWxlICpmLCB1aW50OF90ICpwdHIpDQo+PiArew0KPj4gKyAgICBT
RVZTdGF0ZSAqcyA9IChTRVZTdGF0ZSAqKWhhbmRsZTsNCj4+ICsNCj4+ICsgICAgLyogSWYgdGhp
cyBpcyBmaXJzdCBidWZmZXIgYW5kIFNFViBpcyBub3QgaW4gcmVjaWVpdmluZyBzdGF0ZSB0aGVu
DQo+PiArICAgICAqIHVzZSBSRUNFSVZFX1NUQVJUIGNvbW1hbmQgdG8gY3JlYXRlIGEgZW5jcnlw
dGlvbiBjb250ZXh0Lg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaWYgKCFzZXZfY2hlY2tfc3RhdGUo
U0VWX1NUQVRFX1JFQ0VJVkVfVVBEQVRFKSAmJg0KPj4gKyAgICAgICAgc2V2X3JlY2VpdmVfc3Rh
cnQocy0+c2V2X2luZm8sIGYpKSB7DQo+PiArICAgICAgICByZXR1cm4gMTsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICByZXR1cm4gc2V2X3JlY2VpdmVfdXBkYXRlX2RhdGEoZiwgcHRyKTsNCj4+
ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkDQo+PiAgIHNldl9yZWdpc3Rlcl90eXBlcyh2b2lk
KQ0KPj4gICB7DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvdHJhY2UtZXZlbnRzIGIvdGFy
Z2V0L2kzODYvdHJhY2UtZXZlbnRzDQo+PiBpbmRleCBiNDE1MTZjZjlmLi42MDk3NTJjY2E3IDEw
MDY0NA0KPj4gLS0tIGEvdGFyZ2V0L2kzODYvdHJhY2UtZXZlbnRzDQo+PiArKysgYi90YXJnZXQv
aTM4Ni90cmFjZS1ldmVudHMNCj4+IEBAIC0xOCwzICsxOCw2IEBAIGt2bV9zZXZfbGF1bmNoX2Zp
bmlzaCh2b2lkKSAiIg0KPj4gICBrdm1fc2V2X3NlbmRfc3RhcnQodWludDY0X3QgcGRoLCBpbnQg
bDEsIHVpbnQ2NF90IHBsYXQsIGludCBsMiwgdWludDY0X3QgYW1kLCBpbnQgbDMpICJwZGggMHgl
IiBQUkl4NjQgIiBsZW4gJWQgcGxhdCAweCUiIFBSSXg2NCAiIGxlbiAlZCBhbWQgMHglIiBQUkl4
NjQgIiBsZW4gJWQiDQo+PiAgIGt2bV9zZXZfc2VuZF91cGRhdGVfZGF0YSh2b2lkICpzcmMsIHZv
aWQgKmRzdCwgaW50IGxlbikgImd1ZXN0ICVwIHRyYW5zICVwIGxlbiAlZCINCj4+ICAga3ZtX3Nl
dl9zZW5kX2ZpbmlzaCh2b2lkKSAiIg0KPj4gK2t2bV9zZXZfcmVjZWl2ZV9zdGFydChpbnQgcG9s
aWN5LCB2b2lkICpzZXNzaW9uLCB2b2lkICpwZGgpICJwb2xpY3kgMHgleCBzZXNzaW9uICVwIHBk
aCAlcCINCj4+ICtrdm1fc2V2X3JlY2VpdmVfdXBkYXRlX2RhdGEodm9pZCAqc3JjLCB2b2lkICpk
c3QsIGludCBsZW4sIHZvaWQgKmhkciwgaW50IGhkcl9sZW4pICJndWVzdCAlcCB0cmFucyAlcCBs
ZW4gJWQgaGRyICVwIGhkcl9sZW4gJWQiDQo+PiAra3ZtX3Nldl9yZWNlaXZlX2ZpbmlzaCh2b2lk
KSAiIg0KPj4gLS0gDQo+PiAyLjE3LjENCj4+DQo+IC0tDQo+IERyLiBEYXZpZCBBbGFuIEdpbGJl
cnQgLyBkZ2lsYmVydEByZWRoYXQuY29tIC8gTWFuY2hlc3RlciwgVUsNCj4gDQo=

