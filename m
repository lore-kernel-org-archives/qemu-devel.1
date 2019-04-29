Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5891C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5A42075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GYJJoS4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5A42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9Ol-0007sY-Ju
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:44:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hL9Nu-0007b3-81
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hL9Nq-0005Su-DU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:44:06 -0400
Received: from mail-eopbgr680047.outbound.protection.outlook.com
	([40.107.68.47]:44045
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hL9No-0005RQ-EP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TYyWNcu7FCggw4Uv8bWgg9K/2sSIp4hmI7hYXCtC/oQ=;
	b=GYJJoS4IoQIuhvXAMFkWjr33iHetlcX0PL6OiO2T6oPdp1pbwQ2AiuCW/eoaOrDZP0BVn83IL9NkpabdubTr7gEUb8BOoIQNuNWwGMEUA/porm+nAyL3rSj1Ig72Jkpo6+jJ96d9kiLymQyWNiZmH9UzPbT8rDTVHmx/HoMYZII=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2619.namprd12.prod.outlook.com (20.176.116.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Mon, 29 Apr 2019 16:43:53 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1835.016;
	Mon, 29 Apr 2019 16:43:53 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Borislav Petkov <bp@alien8.de>
Thread-Topic: [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV SEND_START command
Thread-Index: AQHU+rgqsjyUQYD5ekOPbYup8IOCm6ZOfjkAgAAFPwCAAGh9gIAEA5iAgABuRgCAAAIvgA==
Date: Mon, 29 Apr 2019 16:43:53 +0000
Message-ID: <9d330734-02cf-9d21-e26f-56fe9d16fa03@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
	<e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
	<20190426204327.GM4608@zn.tnic>
	<2b63d983-a622-3bec-e6ac-abfd024e19c0@amd.com>
	<20190429163602.GE2324@zn.tnic>
In-Reply-To: <20190429163602.GE2324@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0117.namprd05.prod.outlook.com
	(2603:10b6:803:42::34) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd3823a-da8c-41b6-5580-08d6ccc1dd59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2619; 
x-ms-traffictypediagnostic: DM6PR12MB2619:
x-microsoft-antispam-prvs: <DM6PR12MB261911E3119BC80F557977B2E5390@DM6PR12MB2619.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(102836004)(68736007)(53936002)(26005)(31686004)(6512007)(2906002)(8676002)(81166006)(186003)(81156014)(4326008)(36756003)(25786009)(53546011)(14454004)(6506007)(6246003)(8936002)(7736002)(54906003)(2616005)(446003)(386003)(11346002)(316002)(476003)(66066001)(305945005)(99286004)(478600001)(76176011)(229853002)(6916009)(52116002)(6486002)(66476007)(6436002)(66556008)(486006)(66946007)(7416002)(6116002)(558084003)(97736004)(14444005)(256004)(31696002)(66446008)(73956011)(3846002)(71200400001)(93886005)(71190400001)(86362001)(5660300002)(64756008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2619;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lWnzl1C+vEhEIaX/9nXFaDmdYF06yuhz2+BT05ysgtekrkyuk5xt3/hfBeFmjKyCwMtX6dNVt22DgEqBB2TUo7R/C2qKZiuRZ0WbZ9io5TfuJIWP+PJpld/RJQ/xMIH8M+hkOHYVFvNCkkhlRpOdEeg6PlSu96T2J+Gajwotr59uXJ/IONFx+jRHVulc7sr3l0wJ2GnpGq/UtYvyJQ2+W8yx0bler+U7bE6M94o4CLNYS8QMB9aQx9X2o6U4NNNZyF5yn8EOYyeOroQsZ5ApqMcGgs/SPICSgD79zKmbJJd6uhOF/QE3wuPvshCn8QXOp6h1NddND19hqDQsCioG1PGpPrs29ZS9GZW7HjcTONy0+dzLRkw+xT8SfDXSW/UD8mAp2aZF/m6XEE7czdTwUEq2xQmsrnjid/lR/6LF8TM=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <47D67942F49E49489E04543939504C08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd3823a-da8c-41b6-5580-08d6ccc1dd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 16:43:53.8070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.47
Subject: Re: [Qemu-devel] [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV
 SEND_START command
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H.
	Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429164353.fTMye-Zom3hWXVrZaMra1V-DdMAEfzTIo7uMfl_SXnw@z>

DQoNCk9uIDQvMjkvMTkgMTE6MzYgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gU28gd2hh
dCBhYm91dCB0aGlzPyBMaW1pdGluZyB0byBhIHNhbmUgbGVuZ3RoLi4uDQoNClN1cmUsIHdlIGhh
dmUgZGVmaW5lZCBhIFNFVl9GV19CTE9CX01BWF9TSVpFIGFuZCBjYW4gdXNlIGl0IHRvIGxpbWl0
DQp0aGUgYmxvYiBjb3B5IHNpemUuIEkgd2lsbCBkbyB0aGlzIGluIG5leHQgcmV2LiB0aGFua3MN
Cg0KLUJyaWplc2gNCg==

