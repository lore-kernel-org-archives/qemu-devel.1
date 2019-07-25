Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DCFC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F08321901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O+i5VcS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F08321901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqepZ-0005Mk-H3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hqepE-0004ns-Ob
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hqepD-00013E-7k
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:34:32 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com
 ([40.107.77.89]:32382 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hqepC-00012F-Qk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPmmAyIHVUzpJK4Bp9T4yCSziEVftllQ8btZPPCSSDHFz74rMGYXFulyv8WjUnyZZ0Evt/00m6wZPBkCprmv2qYJ7Iow0Lj5RTAfXdbcMojzhLKaLERZOC7UOsCFi0zf5jGMh/OHCIFs5PSwudafBxeF/u/q/omVN5AUUPlhyhrxomrC8RDnOSGEMuTJbQjSxgeLkxX5ro5jzFLGdDGk9qNeGB8eJPxEav56FLVoQ1tz59U0ViOSqguD3W/koGS1Pm1iPoDkQRzB6jy7i28RDumdu5wIYHWHvgsFtr2BPQMaBhUh8Ls7aCVCP/VrwK6qhYvvbf7fXbEV2OmP9njFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xlxlp9VwSgHKvN/oqMUL9IwOSpLwZh0de9JTF7Vc3k=;
 b=GbWuq/vY+eTcq3qX6Ddc5ukBijO9R3kvo/Tia8WlaBy6Cngq0xZEpNvIMcI44MsdIM3LgofUgKxToa7Y/jw4XCATE+ZeFf1nqg3H092nZqr4lajGdoE5QC6/mG2fOyrZe9MB7ixnXzRoV6PleLK8bB/7BP5P1vN0wrqk/fMibWiSN+E+CVHCJRdv8sa2REgBssGzhrTocjLz7zGrUNrmlkYOF32IZdBkzH4c2+/zrACrmB71La9gbzkZbiEFV/H68qIIp/mPz3ps73v9h0489QIwCl2E9FpK7OfoIh3Db7JmaORINP2yBGAgVHZUwGI1tnMqIpZM/JSs8YMrLc1aKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xlxlp9VwSgHKvN/oqMUL9IwOSpLwZh0de9JTF7Vc3k=;
 b=O+i5VcS9WIFU+zP7lPdoaGDHuslayarbP/asVEO1luP0DW4saIRka94iQco1PkHm9p5fER0eFOpQOkwqDS9Nse8I0Z6g1PZbF+rI2cxqAiY94m5bb2kuVh3HG61ILFjaQ6K3vUHsHOXzA2X2lfQiVThgb+9rmilkVYiKE9C8xm4=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB3514.namprd12.prod.outlook.com (20.179.106.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 14:34:24 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2094.017; Thu, 25 Jul 2019
 14:34:24 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC PATCH] pci: Use PCI aliases when determining device IOMMU
 address space
Thread-Index: AQHU5k9cRin7QSuYLkGerwzvalJ636YnAM8AgLIqCwCAAOdwgIAAKG8AgAAGwICAAE5XgIAAU4GAgAE8KIA=
Date: Thu, 25 Jul 2019 14:34:24 +0000
Message-ID: <5ec9b21e-cf89-5d28-7671-aa84e9a4f360@amd.com>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
 <20190724100331.GA14454@xz-x1> <20190724084355.627d44cf@x1.home>
 <20190724134247.61c2104a@x1.home>
In-Reply-To: <20190724134247.61c2104a@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0135.namprd05.prod.outlook.com
 (2603:10b6:803:2c::13) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:42::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af44972b-5f50-4e63-ef87-08d7110d302c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3514; 
x-ms-traffictypediagnostic: DM6PR12MB3514:
x-microsoft-antispam-prvs: <DM6PR12MB3514B0FA128C9803C1D76B8AE5C10@DM6PR12MB3514.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(36756003)(386003)(6506007)(53546011)(2906002)(486006)(14454004)(102836004)(6246003)(71190400001)(316002)(68736007)(71200400001)(476003)(86362001)(31696002)(81156014)(8676002)(5660300002)(81166006)(8936002)(54906003)(6116002)(64756008)(66476007)(66556008)(6486002)(66446008)(66946007)(6436002)(229853002)(256004)(110136005)(6512007)(3846002)(4326008)(186003)(66066001)(53936002)(478600001)(305945005)(7736002)(11346002)(99286004)(26005)(446003)(2616005)(52116002)(76176011)(25786009)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3514;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0nSkeSgHFy48o1ez+2RW2+gn/vQ7fwdH/OfB8d0bZF1zA7Qlpqy4RVo2dAKtM/kuO96rxxfAVYo9krinqaylKfpCya9JviyXN4D144reYlFCe6FxBwfWLFJw5RlegrQW1JolwO52yZKIBrvVNQcYK2b/r2gFa1a1OHh4pWT+cIT8yNP0HGcW8WeSjN5dC5HtCh7B0X6o5uRd8hMHhJA8GfOVD21rpZ4rBmJZknbkfVCbZaTX7FBgl+f1p7M2IEMH0EuM4DFxxlhWiV3mh5eUcFlpUIQiDkuId0wHwMjMHJ2I60p1+ETIV/nbHfagehRXUQoYSZmq91goimG1S99rtdultpEPoegp/c5UwqnrHZkmWu+qrWyibQAWgGvxoEpK9fIPhFQv9Zfc9+GrXQMRE0slGCciXoPregwvbAGHLGY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <875C95533D931E408EA313064247BFCE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af44972b-5f50-4e63-ef87-08d7110d302c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 14:34:24.4968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.89
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDcvMjQvMTkgMjo0MiBQTSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOg0KPiBPbiBXZWQs
IDI0IEp1bCAyMDE5IDA4OjQzOjU1IC0wNjAwDQo+IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxs
aWFtc29uQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4+IE9uIFdlZCwgMjQgSnVsIDIwMTkgMTg6
MDM6MzEgKzA4MDANCj4+IFBldGVyIFh1IDx6aGV4dUByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+
Pj4gT24gV2VkLCBKdWwgMjQsIDIwMTkgYXQgMDU6Mzk6MjJBTSAtMDQwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOg0KPj4+PiBPbiBXZWQsIEp1bCAyNCwgMjAxOSBhdCAwMzoxNDozOVBNICsw
ODAwLCBQZXRlciBYdSB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgSnVsIDIzLCAyMDE5IGF0IDExOjI2
OjE4QU0gLTA2MDAsIEFsZXggV2lsbGlhbXNvbiB3cm90ZToNCj4+Pj4+Pj4gT24gMy8yOS8xOSAx
MTo0OSBBTSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOg0KPj4+Pj4+Pj4gW0NjICtCcmlqZXNoXQ0K
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IEhpIEJyaWplc2gsIHdpbGwgdGhlIGNoYW5nZSBiZWxvdyByZXF1
aXJlIHRoZSBJVlJTIHRvIGJlIHVwZGF0ZWQgdG8NCj4+Pj4+Pj4+IGluY2x1ZGUgYWxpYXNlcyBm
b3IgYWxsIEJERiByYW5nZXMgYmVoaW5kIGEgY29udmVudGlvbmFsIGJyaWRnZT8gIEkNCj4+Pj4+
Pj4+IHRoaW5rIHRoZSBMaW51eCBjb2RlIGhhbmRsZXMgdGhpcyByZWdhcmRsZXNzIG9mIHRoZSBm
aXJtd2FyZSBwcm92aWRlZA0KPj4+Pj4+Pj4gYWxpYXNlcywgYnV0IGlzIGl0IHJlcXVpcmVkIHBl
ciBzcGVjIGZvciB0aGUgQUNQSSB0YWJsZXMgdG8gaW5jbHVkZQ0KPj4+Pj4+Pj4gYnJpZGdlIGFs
aWFzZXM/ICBUaGFua3MsDQo+IFtzbmlwXQ0KPiANCj4gRm9yIGEgZGF0YSBwb2ludCwgSSBmaXJl
ZCB1cCBhbiBvbGQgOTkwRlggc3lzdGVtIHdoaWNoIGluY2x1ZGVzIGENCj4gUENJZS10by1QQ0kg
YnJpZGdlIGFuZCBJIGFkZGVkIGEgcGx1Z2luIFBDSWUtdG8tUENJIGJyaWRnZSBqdXN0IHRvIGtl
ZXANCj4gdGhpbmdzIGludGVyZXN0aW5nLi4uIGd1ZXNzIGhvdyBtYW55IGFsaWFzIHJhbmdlcyBh
cmUgaW4gdGhlIElWUlMuLi4NCj4gWWVwLCBqdXN0IHRoZSBvbmUgYnVpbHQgaW50byB0aGUgbW90
aGVyYm9hcmQ6DQo+IA0KPiBBTUQtVmk6IFVzaW5nIElWSEQgdHlwZSAweDEwDQo+IEFNRC1WaTog
ZGV2aWNlOiAwMDowMC4yIGNhcDogMDA0MCBzZWc6IDAgZmxhZ3M6IDNlIGluZm8gMTMwMA0KPiBB
TUQtVmk6ICAgICAgICBtbWlvLWFkZHI6IDAwMDAwMDAwZmVjMzAwMDANCj4gQU1ELVZpOiAgIERF
Vl9TRUxFQ1RfUkFOR0VfU1RBUlQJIGRldmlkOiAwMDowMC4wIGZsYWdzOiAwMA0KPiBBTUQtVmk6
ICAgREVWX1JBTkdFX0VORAkJIGRldmlkOiAwMDowMC4yDQo+IEFNRC1WaTogICBERVZfU0VMRUNU
CQkJIGRldmlkOiAwMDowOS4wIGZsYWdzOiAwMA0KPiBBTUQtVmk6ICAgREVWX1NFTEVDVAkJCSBk
ZXZpZDogMDE6MDAuMCBmbGFnczogMDANCj4gQU1ELVZpOiAgIERFVl9TRUxFQ1QJCQkgZGV2aWQ6
IDAwOjBhLjAgZmxhZ3M6IDAwDQo+IEFNRC1WaTogICBERVZfU0VMRUNUCQkJIGRldmlkOiAwMjow
MC4wIGZsYWdzOiAwMA0KPiBBTUQtVmk6ICAgREVWX1NFTEVDVAkJCSBkZXZpZDogMDA6MTEuMCBm
bGFnczogMDANCj4gQU1ELVZpOiAgIERFVl9TRUxFQ1RfUkFOR0VfU1RBUlQJIGRldmlkOiAwMDox
Mi4wIGZsYWdzOiAwMA0KPiBBTUQtVmk6ICAgREVWX1JBTkdFX0VORAkJIGRldmlkOiAwMDoxMi4y
DQo+IEFNRC1WaTogICBERVZfU0VMRUNUX1JBTkdFX1NUQVJUCSBkZXZpZDogMDA6MTMuMCBmbGFn
czogMDANCj4gQU1ELVZpOiAgIERFVl9SQU5HRV9FTkQJCSBkZXZpZDogMDA6MTMuMg0KPiBBTUQt
Vmk6ICAgREVWX1NFTEVDVAkJCSBkZXZpZDogMDA6MTQuMCBmbGFnczogZDcNCj4gQU1ELVZpOiAg
IERFVl9TRUxFQ1QJCQkgZGV2aWQ6IDAwOjE0LjIgZmxhZ3M6IDAwDQo+IEFNRC1WaTogICBERVZf
U0VMRUNUCQkJIGRldmlkOiAwMDoxNC4zIGZsYWdzOiAwMA0KPiBBTUQtVmk6ICAgREVWX1NFTEVD
VAkJCSBkZXZpZDogMDA6MTQuNCBmbGFnczogMDANCj4gQU1ELVZpOiAgIERFVl9BTElBU19SQU5H
RQkJIGRldmlkOiAwMzowMC4wIGZsYWdzOiAwMCBkZXZpZF90bzogMDA6MTQuNA0KPiBBTUQtVmk6
ICAgREVWX1JBTkdFX0VORAkJIGRldmlkOiAwMzoxZi43DQo+IA0KPiBbRXZlcnl0aGluZyBvbiBi
dXMgMDM6eHgueCBpcyBhbGlhc2VkIHRvIGRldmljZSAwMDoxNC40LCB0aGUgYnVpbHRpbiBQQ0ll
LXRvLVBDSSBicmlkZ2VdDQo+IA0KPiBBTUQtVmk6ICAgREVWX1NFTEVDVAkJCSBkZXZpZDogMDA6
MTQuNSBmbGFnczogMDANCj4gQU1ELVZpOiAgIERFVl9TRUxFQ1QJCQkgZGV2aWQ6IDAwOjE1LjAg
ZmxhZ3M6IDAwDQo+IEFNRC1WaTogICBERVZfU0VMRUNUX1JBTkdFX1NUQVJUCSBkZXZpZDogMDQ6
MDAuMCBmbGFnczogMDANCj4gQU1ELVZpOiAgIERFVl9SQU5HRV9FTkQJCSBkZXZpZDogMDQ6MWYu
Nw0KPiBBTUQtVmk6ICAgREVWX1NFTEVDVAkJCSBkZXZpZDogMDA6MTUuMSBmbGFnczogMDANCj4g
QU1ELVZpOiAgIERFVl9TRUxFQ1RfUkFOR0VfU1RBUlQJIGRldmlkOiAwNTowMC4wIGZsYWdzOiAw
MA0KPiBBTUQtVmk6ICAgREVWX1JBTkdFX0VORAkJIGRldmlkOiAwNToxZi43DQo+IEFNRC1WaTog
ICBERVZfU0VMRUNUCQkJIGRldmlkOiAwMDoxNS4yIGZsYWdzOiAwMA0KPiBBTUQtVmk6ICAgREVW
X1NFTEVDVF9SQU5HRV9TVEFSVAkgZGV2aWQ6IDA2OjAwLjAgZmxhZ3M6IDAwDQo+IEFNRC1WaTog
ICBERVZfUkFOR0VfRU5ECQkgZGV2aWQ6IDA2OjFmLjcNCj4gQU1ELVZpOiAgIERFVl9TRUxFQ1QJ
CQkgZGV2aWQ6IDAwOjE1LjMgZmxhZ3M6IDAwDQo+IEFNRC1WaTogICBERVZfU0VMRUNUX1JBTkdF
X1NUQVJUCSBkZXZpZDogMDg6MDAuMCBmbGFnczogMDANCj4gQU1ELVZpOiAgIERFVl9SQU5HRV9F
TkQJCSBkZXZpZDogMDg6MWYuNw0KPiBBTUQtVmk6ICAgREVWX1NFTEVDVF9SQU5HRV9TVEFSVAkg
ZGV2aWQ6IDAwOjE2LjAgZmxhZ3M6IDAwDQo+IEFNRC1WaTogICBERVZfUkFOR0VfRU5ECQkgZGV2
aWQ6IDAwOjE2LjINCj4gQU1ELVZpOiAgIERFVl9TUEVDSUFMKElPQVBJQ1s4XSkJCWRldmlkOiAw
MDoxNC4wDQo+IEFNRC1WaTogICBERVZfU1BFQ0lBTChIUEVUWzBdKQkJZGV2aWQ6IDAwOjE0LjAN
Cj4gQU1ELVZpOiAgIERFVl9TUEVDSUFMKElPQVBJQ1s4XSkJCWRldmlkOiAwMDowMC4xDQo+IA0K
PiAtWzAwMDA6MDBdLSstMDAuMCAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FU
SV0gUkQ5eDAvUlg5ODAgSG9zdCBCcmlkZ2UNCj4gICAgICAgICAgICAgKy0wMC4yICBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXSBSRDg5MFMvUkQ5OTAgSS9PIE1lbW9yeSBN
YW5hZ2VtZW50IFVuaXQgKElPTU1VKQ0KPiAgICAgICAgICAgICArLTA5LjAtWzAxXS0tLS0wMC4w
ICBFdHJvbiBUZWNobm9sb2d5LCBJbmMuIEVKMTY4IFVTQiAzLjAgSG9zdCBDb250cm9sbGVyDQo+
ICAgICAgICAgICAgICstMGEuMC1bMDJdLS0tLTAwLjAgIE1hcnZlbGwgVGVjaG5vbG9neSBHcm91
cCBMdGQuIDg4U0U5MTcyIFNBVEEgNkdiL3MgQ29udHJvbGxlcg0KPiAgICAgICAgICAgICArLTEx
LjAgIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIFNCN3gwL1NCOHgwL1NC
OXgwIFNBVEEgQ29udHJvbGxlciBbQUhDSSBtb2RlXQ0KPiAgICAgICAgICAgICArLTEyLjAgIEFk
dmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIFNCN3gwL1NCOHgwL1NCOXgwIFVT
QiBPSENJMCBDb250cm9sbGVyDQo+ICAgICAgICAgICAgICstMTIuMiAgQWR2YW5jZWQgTWljcm8g
RGV2aWNlcywgSW5jLiBbQU1EL0FUSV0gU0I3eDAvU0I4eDAvU0I5eDAgVVNCIEVIQ0kgQ29udHJv
bGxlcg0KPiAgICAgICAgICAgICArLTEzLjAgIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4g
W0FNRC9BVEldIFNCN3gwL1NCOHgwL1NCOXgwIFVTQiBPSENJMCBDb250cm9sbGVyDQo+ICAgICAg
ICAgICAgICstMTMuMiAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0gU0I3
eDAvU0I4eDAvU0I5eDAgVVNCIEVIQ0kgQ29udHJvbGxlcg0KPiAgICAgICAgICAgICArLTE0LjAg
IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIFNCeDAwIFNNQnVzIENvbnRy
b2xsZXINCj4gICAgICAgICAgICAgKy0xNC4yICBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMu
IFtBTUQvQVRJXSBTQngwMCBBemFsaWEgKEludGVsIEhEQSkNCj4gICAgICAgICAgICAgKy0xNC4z
ICBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXSBTQjd4MC9TQjh4MC9TQjl4
MCBMUEMgaG9zdCBjb250cm9sbGVyDQo+ICAgICAgICAgICAgICstMTQuNC1bMDNdLS0rLTA2LjAg
IE5WaWRpYSAvIFNHUyBUaG9tc29uIChKb2ludCBWZW50dXJlKSBSaXZhMTI4DQo+ICAgICAgICAg
ICAgIHwgICAgICAgICAgICBcLTBlLjAgIFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ2MzA2Lzcv
OCBbRmlyZSBJSShNKV0gSUVFRSAxMzk0IE9IQ0kgQ29udHJvbGxlcg0KPiAgICAgICAgICAgICAr
LTE0LjUgIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIFNCN3gwL1NCOHgw
L1NCOXgwIFVTQiBPSENJMiBDb250cm9sbGVyDQo+ICAgICAgICAgICAgICstMTUuMC1bMDRdLS0t
LTAwLjAgIFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gUlRMODExMS84MTY4Lzg0MTEg
UENJIEV4cHJlc3MgR2lnYWJpdCBFdGhlcm5ldCBDb250cm9sbGVyDQo+ICAgICAgICAgICAgICst
MTUuMS1bMDVdLS0tLTAwLjAgIEV0cm9uIFRlY2hub2xvZ3ksIEluYy4gRUoxNjggVVNCIDMuMCBI
b3N0IENvbnRyb2xsZXINCj4gICAgICAgICAgICAgKy0xNS4yLVswNi0wN10tLS0tMDAuMC1bMDdd
LS0tLTAwLjAgIFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gRGV2aWNlIDgxNDkNCj4g
ICAgICAgICAgICAgKy0xNS4zLVswOF0tLQ0KPiAgICAgICAgICAgICArLTE2LjAgIEFkdmFuY2Vk
IE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIFNCN3gwL1NCOHgwL1NCOXgwIFVTQiBPSENJ
MCBDb250cm9sbGVyDQo+ICAgICAgICAgICAgICstMTYuMiAgQWR2YW5jZWQgTWljcm8gRGV2aWNl
cywgSW5jLiBbQU1EL0FUSV0gU0I3eDAvU0I4eDAvU0I5eDAgVVNCIEVIQ0kgQ29udHJvbGxlcg0K
PiAgICAgICAgICAgICArLTE4LjAgIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0g
RmFtaWx5IDEwaCBQcm9jZXNzb3IgSHlwZXJUcmFuc3BvcnQgQ29uZmlndXJhdGlvbg0KPiAgICAg
ICAgICAgICArLTE4LjEgIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRmFtaWx5
IDEwaCBQcm9jZXNzb3IgQWRkcmVzcyBNYXANCj4gICAgICAgICAgICAgKy0xOC4yICBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIEZhbWlseSAxMGggUHJvY2Vzc29yIERSQU0gQ29u
dHJvbGxlcg0KPiAgICAgICAgICAgICArLTE4LjMgIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIElu
Yy4gW0FNRF0gRmFtaWx5IDEwaCBQcm9jZXNzb3IgTWlzY2VsbGFuZW91cyBDb250cm9sDQo+ICAg
ICAgICAgICAgIFwtMTguNCAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBGYW1p
bHkgMTBoIFByb2Nlc3NvciBMaW5rIENvbnRyb2wNCj4gDQo+IDAwOjE0LjQgUENJIGJyaWRnZTog
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0gU0J4MDAgUENJIHRvIFBDSSBC
cmlkZ2UgKHJldiA0MCkgKHByb2ctaWYgMDEgW1N1YnRyYWN0aXZlIGRlY29kZV0pDQo+IAlCdXM6
IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMywgc3Vib3JkaW5hdGU9MDMsIHNlYy1sYXRlbmN5PTY0
DQo+IA0KPiAwNjowMC4wIFBDSSBicmlkZ2U6IEFTTWVkaWEgVGVjaG5vbG9neSBJbmMuIEFTTTEw
ODMvMTA4NSBQQ0llIHRvIFBDSSBCcmlkZ2UgKHJldiAwMykgKHByb2ctaWYgMDAgW05vcm1hbCBk
ZWNvZGVdKQ0KPiAJQnVzOiBwcmltYXJ5PTA2LCBzZWNvbmRhcnk9MDcsIHN1Ym9yZGluYXRlPTA3
LCBzZWMtbGF0ZW5jeT0zMg0KPiAJQ2FwYWJpbGl0aWVzOiBbODBdIEV4cHJlc3MgKHYxKSBQQ0kt
RXhwcmVzcyB0byBQQ0kvUENJLVggQnJpZGdlLCBNU0kgMDANCj4gDQo+IEkgcmVhbGl6ZWQgYXMg
SSB3YXMgd3JpdGluZywgdGhhdCB0aGUgYWxpYXMgY2F1c2VkIGJ5IDA2OjAwLjAgd291bGQgYmUN
Cj4gZGV2Zm4gMDAuMCBvbiB0aGUgc2Vjb25kYXJ5IGJ1cyAwNywgaWUuIDA3OjAwLjAgd291bGQg
YWxpYXMgdG8NCj4gMDc6MDAuMCwgc28gdGVjaG5pY2FsbHkgdGhlcmUncyByZWFsbHkgbm90IGFu
IGFsaWFzIGZvciB0aGlzIHNtYWxsDQo+IGNhc2UuICBTbyBJIHJlcGxhY2VkIHRoZSBOSUMgd2l0
aCB0aGlzOg0KPiANCj4gICAgICAgICAgICAgKy0xNS4yLVswNi0wN10tLS0tMDAuMC1bMDddLS0r
LTAwLjAgIE5FQyBDb3Jwb3JhdGlvbiBPSENJIFVTQiBDb250cm9sbGVyDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0wMC4xICBORUMgQ29ycG9yYXRpb24gT0hD
SSBVU0IgQ29udHJvbGxlcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwtMDAuMiAgTkVDIENvcnBvcmF0aW9uIHVQRDcyMDEweCBVU0IgMi4wIENvbnRyb2xsZXIN
Cj4gDQo+IE5vdyBmdW5jdGlvbnMgMDc6MDAuWzEyXSBhbHNvIGFsaWFzIHRvIDA3OjAwLjAuICBU
aGUgSVZSUyB0YWJsZSBpcw0KPiB1bmFmZmVjdGVkLg0KPiANCj4gSSdtIHRlbXB0ZWQgdG8gc2F5
IHRoYXQgUUVNVSB3b3VsZCBiZSBubyB3b3JzZSB0aGFuIGJhcmUgbWV0YWwgaWYgd2UNCj4gc2lt
cGx5IGlnbm9yZSBJVkhEIGRldmljZSBhbGlhcyBlbnRyaWVzLiAgSSBrbm93IHRoYXQgTGludXgg
d2lsbCBmaWd1cmUNCj4gb3V0IHRoZSBhbGlhc2luZyByZWdhcmRsZXNzIG9mIHRoZSBJVlJTLiAg
V2lsbCBXaW5kb3dzIGd1ZXN0cz8gIEknZA0KPiBsb3ZlIHRvIGhlYXIgZnJvbSBCaWplc2ggb3Ig
U3VyYXZlZSByZWdhcmRpbmcgdGhlIGJlaGF2aW9yIGFib3ZlIHZlcnN1cw0KPiB3aGF0IEFNRCBl
eHBlY3RzIGZyb20gc3lzdGVtIHZlbmRvcnMuICBUaGFua3MsDQo+IA0KDQpBbGV4LA0KDQpJIGFt
IG5vdCB3ZWxsIHZlcnNlZCBvbiB0aGUgZXhwZWN0ZWQgSU9NTVUgYWRkcmVzcyBzcGFjZSBiZWhh
dmlvciB5ZXQsDQpTdXJhdmVlIHdpbGwga25vdyBtb3JlIGFib3V0LiBJIHdpbGwgYXNrIGhpbSB0
byB0YWtlIGEgbG9vayBhdCB0aGlzDQp0aHJlYWQuDQoNCnRoYW5rcw0KDQo+IEFsZXgNCj4gDQo=

