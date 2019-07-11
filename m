Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F0CC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE7820863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mL91eNhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE7820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlf1i-0000ox-DN
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlf1V-0000Nh-9X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlf1T-0008Qs-Qb
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:46:33 -0400
Received: from mail-eopbgr740042.outbound.protection.outlook.com
 ([40.107.74.42]:30458 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlf1T-0008Ok-Jv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:46:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=issxbp6OUyVuDE5K25bcLWzJnmgYXAU09Vrwrs4twiz9Ur9PFy4O6MViKxwCLT8/8BYbPmkdHxhOJZy9vj8/OpTKjWk1N0NApyKyuFqmXxXx63B3InrV7bP5j1HBgAkN2MILZFugSX42Ok+JVgHqTG+gY1WfK1qqNZgEs0YO6Quy1Tp8n51IzebjZuBmr336g4arQvYiEZlkSAROH+m+F8L7torRi3tYdxwCYsGVtA/J5C2TYoe1RU6tjlKYXj4S37Wfh2eI0xi9JyOtZ5fcaukewWMztkQmCAYNlXsmgDo11PSBH2xYFBA04vDXT7+PTjOBYlyjQ9QGpuFfdCe1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq4IpZj28lgOY/62djWDX8+uAkdyEMxrU10AI6V0zB8=;
 b=gvtGFcWzqMZarKnV/UmeamiZ/of2fXIz+YPbv2IRbfS84iXL1U5VtzX82orirPILHLPigGwu+sZ7JhNtv0VCVJhnnbUeGQIMnAKNr88UMuOKx5BcwfP5wweQeSZbPuE13ghw2Xga3U1orYehxJ8G+zlNqn9v7DPfB52zqag8k3uwqapRA5aHXalaivliBka2bF8R5bygp7oG3eYwFWHVFCaIi9+ru4nnQYyKb5yo8i97jRnaCvtlYsPeXzqSFNwefeBspsR6AaZAJeOll3K7BSM6I2SmgvdJ91ZXxNmCeh0E28wpwxEiOneytZIUOWEB/tDbHnoKoN6HhbXgZAhZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq4IpZj28lgOY/62djWDX8+uAkdyEMxrU10AI6V0zB8=;
 b=mL91eNhcNMzpwR00qsz+iD3z8R0Gzb6e8QxRY03K30TnVII0OVXTPIpw9Kwvs9jRfKcUKMXIDCJSdNVp1wMNsV7GDCYaz068QzGq/fo5g005NpZIAbbagEgVRk7zG+pWZy+se8hDtJu6idLc0i3k7kZnDaC/n9xTd2WeSmIZYcY=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3164.namprd12.prod.outlook.com (20.179.104.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 11 Jul 2019 19:46:29 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 19:46:29 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v2 02/13] kvm: introduce high-level API to support
 encrypted page migration
Thread-Index: AQHVN11E6BDm0AOVHUu1X3S27NYERabFsrSAgAAhOYA=
Date: Thu, 11 Jul 2019 19:46:28 +0000
Message-ID: <09dcf4cb-8d1a-8443-1c6d-2900e8aeafca@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-3-brijesh.singh@amd.com>
 <20190711174733.GS3971@work-vm>
In-Reply-To: <20190711174733.GS3971@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:805::49) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c76678b-2719-4ebb-0c67-08d706387765
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3164; 
x-ms-traffictypediagnostic: DM6PR12MB3164:
x-microsoft-antispam-prvs: <DM6PR12MB316438D11EAC3A609F60DE94E5F30@DM6PR12MB3164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(52116002)(68736007)(6512007)(7736002)(53936002)(6436002)(6116002)(99286004)(186003)(3846002)(5660300002)(305945005)(81166006)(86362001)(25786009)(54906003)(476003)(2616005)(446003)(11346002)(81156014)(31696002)(76176011)(31686004)(316002)(66066001)(8936002)(8676002)(64756008)(66446008)(66556008)(66946007)(486006)(6486002)(6246003)(14444005)(2906002)(256004)(478600001)(6916009)(6506007)(53546011)(386003)(26005)(102836004)(229853002)(4326008)(71190400001)(14454004)(66476007)(71200400001)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3164;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8nVuI/MLfXlE7Oj5m+B1t56UsxEyiy/zZg+9UijKyl8aListGBAMj66wagXG31grj9rWu6HqMtEBca3oXskp8IZKr69X5yjsicmjqAsIp5ou/za4zaxQVFjOa72XWHMEJJmt5mvsFcCKPKU/rhWkisyXJT0hOVaKsosxqa0y2IZdHr8N4OSY6OVAVgOQFCh6jIF2aIhBCFmKNi3taHASC6ynqdXtDik4tIRBx5InXR9S5kgflITmYnZ7of2E2QvSXTGpiw5+8N2ZZA0biTWU3Zmc2tEIKVNrFsc4ORz/wC/NvkCQz1bYH5N2M7fxw26ldpmj+XNp+nbBEUXuXzQZfyYW7+cPHfTlOkMc9SwLr5FDD68ezfJB1mPLHkLEl75cxHyv9WeIskyfiFo3v4EE6yS1vBGCDatMFLdMEuBWMgU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB1409F178985A4FBA53967E0E5F2020@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c76678b-2719-4ebb-0c67-08d706387765
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 19:46:28.8769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.42
Subject: Re: [Qemu-devel] [PATCH v2 02/13] kvm: introduce high-level API to
 support encrypted page migration
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

DQoNCk9uIDcvMTEvMTkgMTI6NDcgUE0sIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+
ICogU2luZ2gsIEJyaWplc2ggKGJyaWplc2guc2luZ2hAYW1kLmNvbSkgd3JvdGU6DQo+PiBXaGVu
IG1lbW9yeSBlbmNyeXB0aW9uIGlzIGVuYWJsZWQgaW4gVk0sIHRoZSBndWVzdCBwYWdlcyB3aWxs
IGJlDQo+PiBlbmNyeXB0ZWQgd2l0aCB0aGUgZ3Vlc3Qtc3BlY2lmaWMga2V5LCB0byBwcm90ZWN0
IHRoZSBjb25maWRlbnRpYWxpdHkNCj4+IG9mIGRhdGEgaW4gdHJhbnNpdC4gVG8gc3VwcG9ydCB0
aGUgbGl2ZSBtaWdyYXRpb24gd2UgbmVlZCB0byB1c2UNCj4+IHBsYXRmb3JtIHNwZWNpZmljIGhv
b2tzIHRvIGFjY2VzcyB0aGUgZ3Vlc3QgbWVtb3J5Lg0KPj4NCj4+IFRoZSBrdm1fbWVtY3J5cHRf
c2F2ZV9vdXRnb2luZ19wYWdlKCkgY2FuIGJlIHVzZWQgYnkgdGhlIHNlbmRlciB0byB3cml0ZQ0K
Pj4gdGhlIGVuY3J5cHRlZCBwYWdlcyBhbmQgbWV0YWRhdGEgYXNzb2NpYXRlZCB3aXRoIGl0IG9u
IHRoZSBzb2NrZXQuDQo+Pg0KPj4gVGhlIGt2bV9tZW1jcnlwdF9sb2FkX2luY29taW5nX3BhZ2Uo
KSBjYW4gYmUgdXNlZCBieSByZWNlaXZlciB0byByZWFkIHRoZQ0KPj4gaW5jb21pbmcgZW5jcnlw
dGVkIHBhZ2VzIGZyb20gdGhlIHNvY2tldCBhbmQgbG9hZCBpbnRvIHRoZSBndWVzdCBtZW1vcnku
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8PGJyaWplc2guc2luZ2hAYW1k
LmNvbT4+DQo+PiAtLS0NCj4+ICAgYWNjZWwva3ZtL2t2bS1hbGwuYyAgICB8IDI3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gICBhY2NlbC9rdm0vc2V2LXN0dWIuYyAgIHwgMTEgKysr
KysrKysrKysNCj4+ICAgYWNjZWwvc3R1YnMva3ZtLXN0dWIuYyB8IDEyICsrKysrKysrKysrKw0K
Pj4gICBpbmNsdWRlL3N5c2VtdS9rdm0uaCAgIHwgMTIgKysrKysrKysrKysrDQo+PiAgIGluY2x1
ZGUvc3lzZW11L3Nldi5oICAgfCAgMyArKysNCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FjY2VsL2t2bS9rdm0tYWxsLmMgYi9hY2Nl
bC9rdm0va3ZtLWFsbC5jDQo+PiBpbmRleCAzZDg2YWU1MDUyLi4xNjJhMmQ1MDg1IDEwMDY0NA0K
Pj4gLS0tIGEvYWNjZWwva3ZtL2t2bS1hbGwuYw0KPj4gKysrIGIvYWNjZWwva3ZtL2t2bS1hbGwu
Yw0KPj4gQEAgLTExMCw2ICsxMTAsMTAgQEAgc3RydWN0IEtWTVN0YXRlDQo+PiAgICAgICAvKiBt
ZW1vcnkgZW5jcnlwdGlvbiAqLw0KPj4gICAgICAgdm9pZCAqbWVtY3J5cHRfaGFuZGxlOw0KPj4g
ICAgICAgaW50ICgqbWVtY3J5cHRfZW5jcnlwdF9kYXRhKSh2b2lkICpoYW5kbGUsIHVpbnQ4X3Qg
KnB0ciwgdWludDY0X3QgbGVuKTsNCj4+ICsgICAgaW50ICgqbWVtY3J5cHRfc2F2ZV9vdXRnb2lu
Z19wYWdlKSh2b2lkICplaGFuZGxlLCBRRU1VRmlsZSAqZiwNCj4+ICsgICAgICAgICAgICB1aW50
OF90ICpwdHIsIHVpbnQzMl90IHN6LCB1aW50NjRfdCAqYnl0ZXNfc2VudCk7DQo+PiArICAgIGlu
dCAoKm1lbWNyeXB0X2xvYWRfaW5jb21pbmdfcGFnZSkodm9pZCAqZWhhbmRsZSwgUUVNVUZpbGUg
KmYsDQo+PiArICAgICAgICAgICAgdWludDhfdCAqcHRyKTsNCj4+ICAgfTsNCj4+ICAgDQo+PiAg
IEtWTVN0YXRlICprdm1fc3RhdGU7DQo+PiBAQCAtMTY1LDYgKzE2OSwyOSBAQCBpbnQga3ZtX21l
bWNyeXB0X2VuY3J5cHRfZGF0YSh1aW50OF90ICpwdHIsIHVpbnQ2NF90IGxlbikNCj4+ICAgICAg
IHJldHVybiAxOw0KPj4gICB9DQo+PiAgIA0KPj4gK2ludCBrdm1fbWVtY3J5cHRfc2F2ZV9vdXRn
b2luZ19wYWdlKFFFTVVGaWxlICpmLCB1aW50OF90ICpwdHIsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc2l6ZSwgdWludDY0X3QgKmJ5dGVzX3NlbnQp
DQo+PiArew0KPj4gKyAgICBpZiAoa3ZtX3N0YXRlLT5tZW1jcnlwdF9oYW5kbGUgJiYNCj4+ICsg
ICAgICAgIGt2bV9zdGF0ZS0+bWVtY3J5cHRfc2F2ZV9vdXRnb2luZ19wYWdlKSB7DQo+PiArICAg
ICAgICByZXR1cm4ga3ZtX3N0YXRlLT5tZW1jcnlwdF9zYXZlX291dGdvaW5nX3BhZ2Uoa3ZtX3N0
YXRlLT5tZW1jcnlwdF9oYW5kbGUsDQo+PiArICAgICAgICAgICAgICAgICAgICBmLCBwdHIsIHNp
emUsIGJ5dGVzX3NlbnQpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiAxOw0KPiAN
Cj4gVGhpcyBuZWVkcyB0byBiZSBjb21tZW50ZWQgc2F5aW5nIHdoYXQgdGhlIHJldHVybiB2YWx1
ZXMgbWVhbi4NCj4gSSdtIG5vdCBzdXJlIHdoYXQgJzEnIG1lYW5zIGZvciB0aGUgY2FzZSB3aGVu
IHRoaXMgZGlkbid0IGhhdmUNCj4gZW5jcnlwdGlvbiBzdXBwb3J0Lg0KPiANCg0KQWdyZWVkLCBJ
IHdpbGwgYWRkIGNvbW1lbnQgaW4gQVBJIGhlYWRlciBhYm91dCB0aGlzLiBUaGUgdmFsdWUgb2Yg
emVybw0KbWVhbnMgc3VjY2VzcyBhbmQgYW55dGhpbmcgZWxzZSBpcyBmYWlsdXJlLg0KDQoNCj4+
ICt9DQo+PiArDQo+PiAraW50IGt2bV9tZW1jcnlwdF9sb2FkX2luY29taW5nX3BhZ2UoUUVNVUZp
bGUgKmYsIHVpbnQ4X3QgKnB0cikNCj4+ICt7DQo+PiArICAgIGlmIChrdm1fc3RhdGUtPm1lbWNy
eXB0X2hhbmRsZSAmJg0KPj4gKyAgICAgICAga3ZtX3N0YXRlLT5tZW1jcnlwdF9sb2FkX2luY29t
aW5nX3BhZ2UpIHsNCj4+ICsgICAgICAgIHJldHVybiBrdm1fc3RhdGUtPm1lbWNyeXB0X2xvYWRf
aW5jb21pbmdfcGFnZShrdm1fc3RhdGUtPm1lbWNyeXB0X2hhbmRsZSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgIGYsIHB0cik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIDE7DQo+
PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgS1ZNU2xvdCAqa3ZtX2dldF9mcmVlX3Nsb3QoS1ZNTWVt
b3J5TGlzdGVuZXIgKmttbCkNCj4+ICAgew0KPj4gICAgICAgS1ZNU3RhdGUgKnMgPSBrdm1fc3Rh
dGU7DQo+PiBkaWZmIC0tZ2l0IGEvYWNjZWwva3ZtL3Nldi1zdHViLmMgYi9hY2NlbC9rdm0vc2V2
LXN0dWIuYw0KPj4gaW5kZXggNGY5NzQ1MjU4NS4uYzEyYThlMDA1ZSAxMDA2NDQNCj4+IC0tLSBh
L2FjY2VsL2t2bS9zZXYtc3R1Yi5jDQo+PiArKysgYi9hY2NlbC9rdm0vc2V2LXN0dWIuYw0KPj4g
QEAgLTI0LDMgKzI0LDE0IEBAIHZvaWQgKnNldl9ndWVzdF9pbml0KGNvbnN0IGNoYXIgKmlkKQ0K
Pj4gICB7DQo+PiAgICAgICByZXR1cm4gTlVMTDsNCj4+ICAgfQ0KPj4gKw0KPj4gK2ludCBzZXZf
c2F2ZV9vdXRnb2luZ19wYWdlKHZvaWQgKmhhbmRsZSwgUUVNVUZpbGUgKmYsIHVpbnQ4X3QgKnB0
ciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBzaXplLCB1aW50NjRf
dCAqYnl0ZXNfc2VudCkNCj4+ICt7DQo+PiArICAgIHJldHVybiAxOw0KPj4gK30NCj4+ICsNCj4+
ICtpbnQgc2V2X2xvYWRfaW5jb21pbmdfcGFnZSh2b2lkICpoYW5kbGUsIFFFTVVGaWxlICpmLCB1
aW50OF90ICpwdHIpDQo+PiArew0KPj4gKyAgICByZXR1cm4gMTsNCj4+ICt9DQo+PiBkaWZmIC0t
Z2l0IGEvYWNjZWwvc3R1YnMva3ZtLXN0dWIuYyBiL2FjY2VsL3N0dWJzL2t2bS1zdHViLmMNCj4+
IGluZGV4IDZmZWI2NmVkODAuLmUxNGI4Nzk1MzEgMTAwNjQ0DQo+PiAtLS0gYS9hY2NlbC9zdHVi
cy9rdm0tc3R1Yi5jDQo+PiArKysgYi9hY2NlbC9zdHVicy9rdm0tc3R1Yi5jDQo+PiBAQCAtMTE0
LDYgKzExNCwxOCBAQCBpbnQga3ZtX21lbWNyeXB0X2VuY3J5cHRfZGF0YSh1aW50OF90ICpwdHIs
IHVpbnQ2NF90IGxlbikNCj4+ICAgICByZXR1cm4gMTsNCj4+ICAgfQ0KPj4gICANCj4+ICtpbnQg
a3ZtX21lbWNyeXB0X3NhdmVfb3V0Z29pbmdfcGFnZShRRU1VRmlsZSAqZiwgdWludDhfdCAqcHRy
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHNpemUs
IHVpbnQ2NF90ICpieXRlc19zZW50KQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIDE7DQo+PiArfQ0K
Pj4gKw0KPj4gK2ludCBrdm1fbWVtY3J5cHRfbG9hZF9pbmNvbWluZ19wYWdlKFFFTVVGaWxlICpm
LCB1aW50OF90ICpwdHIpDQo+PiArew0KPj4gKyAgICByZXR1cm4gMTsNCj4+ICt9DQo+PiArDQo+
PiArDQo+PiAgICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4gICBpbnQga3ZtX2lycWNoaXBf
YWRkX21zaV9yb3V0ZShLVk1TdGF0ZSAqcywgaW50IHZlY3RvciwgUENJRGV2aWNlICpkZXYpDQo+
PiAgIHsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9rdm0uaCBiL2luY2x1ZGUvc3lz
ZW11L2t2bS5oDQo+PiBpbmRleCBhY2Q5MGFlYmI2Li5iYjZiY2MxNDNjIDEwMDY0NA0KPj4gLS0t
IGEvaW5jbHVkZS9zeXNlbXUva3ZtLmgNCj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11L2t2bS5oDQo+
PiBAQCAtMjQ3LDYgKzI0NywxOCBAQCBib29sIGt2bV9tZW1jcnlwdF9lbmFibGVkKHZvaWQpOw0K
Pj4gICAgKi8NCj4+ICAgaW50IGt2bV9tZW1jcnlwdF9lbmNyeXB0X2RhdGEodWludDhfdCAqcHRy
LCB1aW50NjRfdCBsZW4pOw0KPj4gICANCj4+ICsvKioNCj4+ICsgKiBrdm1fbWVtY3J5cHRfc2F2
ZV9vdXRnb2luZ19idWZmZXIgLSBlbmNyeXB0IHRoZSBvdXRnb2luZyBidWZmZXINCj4+ICsgKiBh
bmQgd3JpdGUgdG8gdGhlIHdpcmUuDQo+PiArICovDQo+PiAraW50IGt2bV9tZW1jcnlwdF9zYXZl
X291dGdvaW5nX3BhZ2UoUUVNVUZpbGUgKmYsIHVpbnQ4X3QgKnB0ciwgdWludDMyX3Qgc2l6ZSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqYnl0ZXNf
c2VudCk7DQo+PiArDQo+PiArLyoqDQo+PiArICoga3ZtX21lbWNyeXB0X2xvYWRfaW5jb21pbmdf
YnVmZmVyIC0gcmVhZCB0aGUgZW5jcnlwdCBpbmNvbWluZyBidWZmZXIgYW5kIGNvcHkNCj4+ICsg
KiB0aGUgYnVmZmVyIGludG8gdGhlIGd1ZXN0IG1lbW9yeSBzcGFjZS4NCj4+ICsgKi8NCj4+ICtp
bnQga3ZtX21lbWNyeXB0X2xvYWRfaW5jb21pbmdfcGFnZShRRU1VRmlsZSAqZiwgdWludDhfdCAq
cHRyKTsNCj4+ICAgDQo+PiAgICNpZmRlZiBORUVEX0NQVV9IDQo+PiAgICNpbmNsdWRlICJjcHUu
aCINCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9zZXYuaCBiL2luY2x1ZGUvc3lzZW11
L3Nldi5oDQo+PiBpbmRleCA5OGMxZWM4ZDM4Li43NTJhNzFiMWMwIDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS9zeXNlbXUvc2V2LmgNCj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11L3Nldi5oDQo+PiBA
QCAtMTgsNCArMTgsNyBAQA0KPj4gICANCj4+ICAgdm9pZCAqc2V2X2d1ZXN0X2luaXQoY29uc3Qg
Y2hhciAqaWQpOw0KPj4gICBpbnQgc2V2X2VuY3J5cHRfZGF0YSh2b2lkICpoYW5kbGUsIHVpbnQ4
X3QgKnB0ciwgdWludDY0X3QgbGVuKTsNCj4+ICtpbnQgc2V2X3NhdmVfb3V0Z29pbmdfcGFnZSh2
b2lkICpoYW5kbGUsIFFFTVVGaWxlICpmLCB1aW50OF90ICpwdHIsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3Qgc2l6ZSwgdWludDY0X3QgKmJ5dGVzX3NlbnQpOw0KPj4g
K2ludCBzZXZfbG9hZF9pbmNvbWluZ19wYWdlKHZvaWQgKmhhbmRsZSwgUUVNVUZpbGUgKmYsIHVp
bnQ4X3QgKnB0cik7DQo+PiAgICNlbmRpZg0KPj4gLS0gDQo+PiAyLjE3LjENCj4+DQo+IC0tDQo+
IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgLyBkZ2lsYmVydEByZWRoYXQuY29tIC8gTWFuY2hlc3Rl
ciwgVUsNCj4gDQo=

