Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B93F205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y0WE9kZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B93F205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn3IX-0008Sp-AM
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hn3IL-0007kE-B3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hn3IJ-0000lC-Kp
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:53:41 -0400
Received: from mail-bl2nam02on062d.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::62d]:21550
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hn3IJ-0000k4-2K
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:53:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itY2VRDSihb5evKP/ht6oRBKlAO0ISF88pT4yeUnqBVYYOUR8q2K3npxhFG32iv25vPh2KX6zOVkFtIXm8TItzYvhIVYd+rPN5zxMtVk+aAvI9FE+3MhCiIFv+Cl5CSfb17CL3ak9l6WbjojnVTZQbSOrM+c9+rsF1xQuRi3e2qp96j+9bAd3hayx/Wox6+GplIMyakLG0n8m3ahzyTPdJ7iZNfHmYjPtrivENoTpelhNOV/im+ksG6ncd0bLcinlqRzLy8XQt+ONP2lCcRi2dHbLz2T5gW6RsUgYjn64FGX3Y+F9HLL0JLq8BWzOmcaVbTVDUeguMnvIS3KzE3JgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agH0OgSHbhE/pcYQYBIr2csroj6QWjDQJ13HWODu3Qc=;
 b=QQFsFOB5kIbWqn2vyM7iSS1G7TxC074wBBrFVcyzHEev0WkjuBkkNPU69yxCsX6WPu9JAPIa9u/5z+5Ht4Eocc6kF0YQqf+6sYGyp/LZtb3TIamJUJysYpr+leo56NSwswPkG6PTHZazHTwbAMV5WaalMhtRwV31w8cUTZA88QfzZH6CMrJokY5lUPnNXhmUiAH/M0J1MV90+npFQ8ia4hbJ8WrtFstwu1F/Dvo6tdqOYOdtJHYni8ov8IVRYn0O/RHyAFjHf1OCwFb8cdE9dPjK7AhtGQLcaqVZBfj9uCKQdYLb5bAElDLZdqbyVbwApamM4tClRJ5yN2NZNfZYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agH0OgSHbhE/pcYQYBIr2csroj6QWjDQJ13HWODu3Qc=;
 b=y0WE9kZABBa5brvVA+NQ2GPDsg9k+5hZLvORZTzC6daAO2D8ggh9y+ey7fH2XTNgLRf9jmYna+ffZhIyKPY3VhbfCb0V5oZoTa1/ttCre9Qh5flpFnZ32aB/Oj8R1Bm/2yiew79FIAWa4O0Rl/SU5ZBmnDq0pKG71fDffkX/qkk=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB3866.namprd12.prod.outlook.com (10.255.173.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 15:53:35 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 15:53:35 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH for-4.1] target/i386: sev: Do not unpin ram device memory
 region
Thread-Index: AQHVOxmbrsd/BHkiqk6goTK9xVTScabL1LWA
Date: Mon, 15 Jul 2019 15:53:34 +0000
Message-ID: <94eb3076-c089-9155-6559-481a06d2a96b@amd.com>
References: <156320087103.2556.10983987500488190423.stgit@gimli.home>
In-Reply-To: <156320087103.2556.10983987500488190423.stgit@gimli.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:805::46) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:42::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33689363-d591-41a9-ada5-08d7093c97ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3866; 
x-ms-traffictypediagnostic: DM6PR12MB3866:
x-microsoft-antispam-prvs: <DM6PR12MB38663A31A9BBEBAF041F867CE5CF0@DM6PR12MB3866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(316002)(53936002)(76176011)(6436002)(99286004)(66066001)(81166006)(6246003)(386003)(6506007)(53546011)(6512007)(229853002)(52116002)(86362001)(5660300002)(31696002)(81156014)(68736007)(8936002)(8676002)(4326008)(4744005)(26005)(478600001)(486006)(2501003)(186003)(25786009)(31686004)(256004)(476003)(7736002)(2616005)(11346002)(446003)(305945005)(64756008)(3846002)(66446008)(6116002)(6486002)(2906002)(54906003)(110136005)(36756003)(66946007)(66556008)(71190400001)(71200400001)(66476007)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3866;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OQ85yDY6wwSDx4yEq3Y7iH9cr1OHzhBPvoovnEJXNmKQbHZtzXQKUafT9nu2ZVdmTU3zmzIGUXC7yNi9Aig1wcvez5rGN28ncqC0jLsBc4ftrIyn7rZfAeGaE/zx1OHDuktN5KB3pBSC9UxCTkpwfwHgsD+4i7B20me0rFSrEHgUvYUQgqmmfs8PMsjzE+hMYC2aK1e31IqZ3/m0HM3jzqSEThP2hJkQX6exvIJVo+4DrxGDf8LkSDiFDFu9LO7nGw3I8DuckXoMOrMEwN+EoEIfJZns/Mk4P8MnyMuF0ROOKlQ939F/RRAF11HuIR3uwV+xBc5Rtg4XAEAavdbqJgf+LByyy+YJxGiQWQZd4SvusNcX5la6e4rN6rPuH0XPoLgw1Ygkv05C/iQDtHorjp8udAvVRfLuqVACDjut0ps=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E387A96740037242B8DF906AB478E640@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33689363-d591-41a9-ada5-08d7093c97ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 15:53:34.8971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe46::62d
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/i386: sev: Do not unpin ram
 device memory region
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDcvMTUvMTkgOToyOCBBTSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOg0KPiBUaGUgY29t
bWl0IHJlZmVyZW5jZWQgYmVsb3cgc2tpcHBlZCBwaW5uaW5nIHJhbSBkZXZpY2UgbWVtb3J5IHdo
ZW4NCj4gcmFtIGJsb2NrcyBhcmUgYWRkZWQsIHdlIG5lZWQgdG8gZG8gdGhlIHNhbWUgd2hlbiB0
aGV5J3JlIHJlbW92ZWQuDQo+IA0KPiBDYzogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBh
bWQuY29tPg0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gRml4
ZXM6IGNlZGMwYWQ1MzlhZiAoInRhcmdldC9pMzg2OiBzZXY6IERvIG5vdCBwaW4gdGhlIHJhbSBk
ZXZpY2UgbWVtb3J5IHJlZ2lvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggV2lsbGlhbXNvbiA8
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIHRhcmdldC9pMzg2L3Nldi5j
IHwgICAxMSArKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
DQo+IA0KDQp0aGFua3MNCg0KUmV2aWV3ZWQtYnk6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2lu
Z2hAYW1kLmNvbT4NCg==

