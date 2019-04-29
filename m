Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1CC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55E020651
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qyi3aW+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55E020651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58869 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7pI-0002Um-5w
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:04:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hL7mt-0000s4-23
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hL7mr-0001nR-Nx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:01:46 -0400
Received: from mail-dm3nam05on060a.outbound.protection.outlook.com
	([2a01:111:f400:fe51::60a]:25248
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hL7mn-0001i9-1T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Cr3+tWmFLwR0qdTCksEmUpGS6djx6hBM3fM0KhhnE78=;
	b=qyi3aW+pcnnFFktcr7BU1mye3hX1Ikqxk00qXdXlgF/HoqB8NKs7e6fTgVjms4yyB8CpBX7cobMB9qoPGEZrC66hjAKiG9tfnbNE6PKSAHrGXfTg4+8jk9bJ6W+yT0rS3+YXLQBUYVHObSu3d+M8BGuW3hKPfy1cU4hRo7vzdtg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2955.namprd12.prod.outlook.com (20.179.104.97) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.18; Mon, 29 Apr 2019 15:01:25 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1835.016;
	Mon, 29 Apr 2019 15:01:25 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Borislav Petkov <bp@alien8.de>
Thread-Topic: [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV SEND_START command
Thread-Index: AQHU+rgqsjyUQYD5ekOPbYup8IOCm6ZOfjkAgAAFPwCAAGh9gIAEV2qA
Date: Mon, 29 Apr 2019 15:01:24 +0000
Message-ID: <2b63d983-a622-3bec-e6ac-abfd024e19c0@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
	<e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
	<20190426204327.GM4608@zn.tnic>
In-Reply-To: <20190426204327.GM4608@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0006.namprd06.prod.outlook.com
	(2603:10b6:803:2f::16) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e1e40a0-e527-42da-4704-08d6ccb38c4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2955; 
x-ms-traffictypediagnostic: DM6PR12MB2955:
x-microsoft-antispam-prvs: <DM6PR12MB29554FE6F98110C905B5DA94E5390@DM6PR12MB2955.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(71190400001)(71200400001)(486006)(476003)(2616005)(11346002)(68736007)(446003)(5660300002)(66476007)(8936002)(66946007)(64756008)(66446008)(6116002)(3846002)(73956011)(81166006)(8676002)(81156014)(31686004)(36756003)(66556008)(31696002)(93886005)(4326008)(316002)(478600001)(25786009)(7736002)(2906002)(54906003)(305945005)(14454004)(229853002)(6436002)(97736004)(6486002)(7416002)(386003)(14444005)(256004)(53546011)(6506007)(102836004)(66066001)(186003)(26005)(6916009)(76176011)(52116002)(99286004)(6512007)(53936002)(86362001)(6246003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2955;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iPXgRz0zYrPuuQGvT6rOlcPabI4WV9mSnzmg/rj2NpnDZ6t6cfG45Gfd9NCD530NJsXGm9isXhaOpT/Va8r5ogzZjAGFygrQz9FXztgQmBmudaO/ebjOscGnsmmJsMo+SWDp0c20eZuhZLlOmeXFusOI2Dn3aohjXqV/3pqoTScls7i1KHywQRXXwWBxBabFT6Q6KtImQat2r9j/AxuuW7JbnrTJGJb0DYPNPsm0KycQt+tr3g8EhkjT/llSiKPIlU/SGxDDTE7rKZ9lXVdWLC+Zs/nB+Kvshs+ZciHmOC2b29g/gUCxLevivck7mXzUmtjb5soacr0xonr4ygRJho8tsFx4dwR58OOuiwCYalVQ6IRcfJTsV54wsurDMIMwXuZyLDxyPIm/M/LqviiS5K+baDK7gn0U13q3JY4eCFY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <E3227EC2AE78DB4BAA12F54AF5A7CF89@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1e40a0-e527-42da-4704-08d6ccb38c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 15:01:24.8948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2955
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe51::60a
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
Message-ID: <20190429150124.9STGQj-xon60PG2pOON30lLlGMpGZwVNi-HPQZHsqSo@z>

DQoNCk9uIDQvMjYvMTkgMzo0MyBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBGcmks
IEFwciAyNiwgMjAxOSBhdCAwMjoyOTozMVBNICswMDAwLCBTaW5naCwgQnJpamVzaCB3cm90ZToN
Cj4+IFllcyB0aGF0J3MgZG9hYmxlIGJ1dCBJIGFtIGFmcmFpZCB0aGF0IGNhY2hpbmcgdGhlIHZh
bHVlIG1heSBsZWFkIHVzIHRvDQo+PiB3cm9uZyBwYXRoIGFuZCBhbHNvIGRpdmVyZ2VuY2UgZnJv
bSB0aGUgU0VWIEFQSSBzcGVjLiBUaGUgc3BlYyBzYXlzIHRoZQ0KPj4gcmV0dXJuZWQgbGVuZ3Ro
IGlzIGEgbWluaW11bSBsZW5ndGggYnV0IGl0cyBwb3NzaWJsZSB0aGF0IGNhbGxlciBjYW4NCj4+
IGdpdmUgYSBiaWdnZXIgYnVmZmVyIGFuZCBGVyB3aWxsIHN0aWxsIHdvcmsgd2l0aCBpdC4NCj4g
DQo+IERvZXMgdGhlIGNhbGxlciBldmVuIGhhdmUgYSB2YWxpZCByZWFzb24gdG8gZ2l2ZSBhIGJp
Z2dlciBidWZmZXIgbGVuPw0KPiANCg0KDQpQcmFjdGljYWxseSBJIGRvbid0IHNlZSBhbnkgcmVh
c29uIHdoeSBjYWxsZXIgd291bGQgZG8gdGhhdCBidXQNCnRoZW9yZXRpY2FsbHkgaXQgY2FuLiBJ
ZiB3ZSBjYWNoZSB0aGUgbGVuIHRoZW4gd2UgYWxzbyBuZWVkIHRvIGNvbnNpZGVyDQphZGRpbmcg
YW5vdGhlciBmbGFnIHRvIGhpbnQgd2hldGhlciB1c2Vyc3BhY2UgZXZlciByZXF1ZXN0ZWQgbGVu
Z3RoLg0KZS5nIGFuIGFwcGxpY2F0aW9uIGNhbiBjb21wdXRlIHRoZSBsZW5ndGggb2Ygc2Vzc2lv
biBibG9iIGJ5IGxvb2tpbmcgYXQNCnRoZSBBUEkgdmVyc2lvbiBhbmQgc3BlYyBhbmQgbWF5IG5l
dmVyIHF1ZXJ5IHRoZSBsZW5ndGguDQoNCg0KPiBJIG1lYW4gSSdtIHN0aWxsIHRoaW5raW5nIGRl
ZmVuc2l2ZWx5IGhlcmUgYnV0IG1heWJlIHRoZSBvbmx5IHRoaW5nIHRoYXQNCj4gd291bGQgaGFw
cGVuIGhlcmUgd2l0aCBhIGJpZ2dlciBidWZmZXIgaXMgaWYgdGhlIGttYWxsb2MoKSB3b3VsZCBm
YWlsLA0KPiBsZWFkaW5nIHRvIGV2ZW50dWFsIGZhaWx1cmUgb2YgdGhlIG1pZ3JhdGlvbi4NCj4g
DQo+IElmIHRoZSBjb2RlIGxpbWl0cyB0aGUgYWxsb2NhdGlvbiB0byBzb21lIHNhbmUgbWF4IGxl
bmd0aCwgdGhlIG1pZ3JhdGlvbg0KPiB3b24ndCBmYWlsIGV2ZW4gaWYgdXNlcnNwYWNlIGdpdmVz
IGl0IHRvbyBiaWcgdmFsdWVzLi4uDQo+IA0K

