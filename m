Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF228C04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DFB20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bQr3TmbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DFB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58919 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHIP-0002rb-Nb
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:23:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hRHHR-0002GM-Tx
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hRHHP-0007G6-VH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:22:45 -0400
Received: from mail-eopbgr720081.outbound.protection.outlook.com
	([40.107.72.81]:47232
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hRHHO-0007Br-4A
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bLGpBMGjx0ZzcjSWpL6ESX5HXTN7KYrgCXwvm9ai69I=;
	b=bQr3TmbTiQbDVFMHVWBj9RHtctRquQRSVmc1dW31ICUuLHBsDOGrbMmvv8HNINzr0tLiRoAuOk9MaENv5dy7IUVJL2pTohRd0LNCG9ZwQp8HKFiYu+IgEZQf6EELWNZiFCzPw5QcZopZ1SGjZwcdOreONt8JdnExeC7Q30SMOyU=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
	SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Thu, 16 May 2019 14:22:37 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::7d7e:725a:3bbc:a512]) by
	SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::7d7e:725a:3bbc:a512%4]) with mapi id 15.20.1900.010;
	Thu, 16 May 2019 14:22:37 +0000
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Thread-Topic: [PATCH 1/3] ram-encrypted-notifier: Introduce a RAM block
	encrypted notifier
Thread-Index: AQHU+7pfUbGsMaOONk2PjUweDqC9XqZOX9QA///OvYCAC5U9gIAUKfiA
Date: Thu, 16 May 2019 14:22:37 +0000
Message-ID: <4d318829-435c-fd0c-9d7c-8efec7b0a205@amd.com>
References: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
	<20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
	<20190426142908.5d63d530@Igors-MacBook-Pro.local>
	<3d272b2b-67ba-de54-9683-d3361ecbe276@amd.com>
	<20190503182549.GS28722@habkost.net>
In-Reply-To: <20190503182549.GS28722@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1101CA0011.namprd11.prod.outlook.com
	(2603:10b6:405:4a::21) To SN6PR12MB2736.namprd12.prod.outlook.com
	(2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.233.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adcffb6e-bf8b-41f1-5432-08d6da09f1ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:SN6PR12MB2608; 
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-microsoft-antispam-prvs: <SN6PR12MB2608689C2FF243DD879B3586E70A0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(2616005)(476003)(36756003)(4744005)(3846002)(66066001)(11346002)(6116002)(446003)(486006)(2906002)(8936002)(256004)(66946007)(71200400001)(71190400001)(316002)(73956011)(66446008)(66476007)(66556008)(64756008)(6512007)(81156014)(81166006)(102836004)(8676002)(54906003)(386003)(6506007)(53546011)(6436002)(72206003)(53936002)(99286004)(25786009)(26005)(7736002)(31696002)(6246003)(76176011)(14454004)(52116002)(86362001)(31686004)(6916009)(6486002)(186003)(305945005)(5660300002)(229853002)(68736007)(478600001)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2608;
	H:SN6PR12MB2736.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H3lW2zNxZkYZYTDMlz6SNF7gyvYLMMLVtJFAD3ouit88BA6wicaqQja/5IwOT2RqKnZO58YyLsWPn4lUEvfb8N473Z2JkgAeQk9R2QMpZIwcwilZohe4kfkxbCGM5CaPnbjoi6hof9Q+sXTYuYKUmp+GjeMH5zXbgnQrbgwwdAp5UlP5hWC0ozxpLmgYwZ2oSSQ2qc2VSFIgc+DVDSttin9yBtfsWVebrF85mKOAAYMXkA/XAaojEm6jBzH2i+QDJgWKv3zzKWrCvABpGhqKhuT61DLzi/QglNddkBKKCqG6VI5sMFVGFse9YNMHvH1rmgnefhukSWrfksDIy9Ha0c9dwzil28OEN9pDbAZi8urxLYUKz4iWRZTL3q9qWkp1br8nyNHE5FFzBmGbYnAez3sxTix+gGt2wuZeDz3EDz0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F267C127B626A4AB1667154ED46053F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcffb6e-bf8b-41f1-5432-08d6da09f1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 14:22:37.1099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.81
Subject: Re: [Qemu-devel] [PATCH 1/3] ram-encrypted-notifier: Introduce a
 RAM block encrypted notifier
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
Cc: Fam Zheng <fam@euphon.net>, "Singh, Brijesh" <brijesh.singh@amd.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNS8zLzIwMTkgMToyNSBQTSwgRWR1YXJkbyBIYWJrb3N0IHdyb3RlOg0KPiBbQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWxdDQo+DQo+IE9uIEZyaSwgQXByIDI2LCAyMDE5IGF0IDAyOjMyOjUxUE0g
KzAwMDAsIEphbmFrYXJhamFuIE5hdGFyYWphbiB3cm90ZToNCj4+IE9uIDQvMjYvMTkgNzoyOSBB
TSwgSWdvciBNYW1tZWRvdiB3cm90ZToNCj4gWy4uLl0NCj4+Pj4gZGlmZiAtLWdpdCBhL251bWEu
YyBiL251bWEuYw0KPj4+PiBpbmRleCAzODc1ZTFlZmRhLi4wODYwMTM2NmM1IDEwMDY0NA0KPj4+
PiAtLS0gYS9udW1hLmMNCj4+Pj4gKysrIGIvbnVtYS5jDQo+Pj4gbG9va3MgbGlrZSB3cm9uZyBm
aWxlIHRvIHB1dCBSQU1CbG9jayBjb2RlIGluLiBJIHRob3VnaCB0aGF0IHdlIHNob3VsZCBwdXQg
aXQgaW4gZXhlYy5jDQo+Pg0KPj4gSSBwbGFjZWQgdGhlIFJBTUJsb2NrRW5jcnlwdGVkIE5vdGlm
aWVyIGNvZGUgYWxvbmcgd2l0aCB0aGUgUkFNQmxvY2sNCj4+IE5vdGlmaWVyIGNvZGUuDQo+IFBh
b2xvLCBGYW0sIGRvIHlvdSByZW1lbWJlciB3aHkgd2FzIHRoZSByYW0gYmxvY2sgbm90aWZpZXIg
Y29kZQ0KPiBhZGRlZCB0byBudW1hLmMgaW5zdGVhZCBvZiBtZW1vcnkuYyBvciBleGVjLmM/DQoN
Cg0KQW55IHVwZGF0ZXMgb24gdGhpcz8NCg0KDQo+DQo+IC0tDQo+IEVkdWFyZG8NCg==

