Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCACAC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 21:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934592074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 21:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rksemorris.onmicrosoft.com header.i=@rksemorris.onmicrosoft.com header.b="MoSdSbGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934592074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rkmorris.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMHyF-00070C-NR
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 17:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rmorris@rkmorris.us>) id 1jMFqj-0004S9-Ap
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rmorris@rkmorris.us>) id 1jMFqg-00072w-Ii
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:54:56 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com
 ([40.107.244.48]:31201 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rmorris@rkmorris.us>) id 1jMFqg-00071A-6t
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj/4ZapyhzlImbl7394lBoVFIts5KM/x5JG06ItfChrX7Jg/O3ppK4uwj+Dk7NkKxEue2vJa5g6yYdA8zd79Xf/owEHG4CKGjJHmfOxjGStER37jDo7StZtW6oK/i8fy2XKiaoPJQvs7YPaqAq0B68bwtPMoePCEDoViDKrTh6f+3NqSDQuOfuEkQ5ecseniDTcPplKlt9kAXKRRCnRKxxSZykffKoZprZd6hsiWB28k3BHeaKfSTqV7SEUoi0KAYszuASJn5hfi2k4zNj3OPBV8W9wDBBgKCNIpX5yfJcOiYfU4FNrsSacnRymGJG3U7Wovu95FeyDqOQHAVJsppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxs0WFOpinvzuW6J/i8qFTlJJqYclDIXrsmfkEOxif4=;
 b=SE4V/3sWvS132os+Cecvt/2JUKYMtNionz3JcOJqDAKmTy9Mdd42tpway3z9cOwEf/1aJB/Ggxb0fRvkzkEKxUoauYPrN7dLJVKmul0YzijeheOTi1O29rZAPKILtXJvc2h7oda+svM2cdin+9+ZZvqxzuToN5At4CrSxL+2whVLl69gd1eAnNqPt/CG/yuEomDYKup1dSrK6/gyk4ZZjms/ZpClcyG+XcdHiOI1AXkNmvEdvUdYXrlHn440xZ+AOz1GR/rXVRehgZ0EW424lW9BEIX8ttG0iUtZ+uBgbdvqCJY4cERJPFPn9EsxMHasXI4U4BDm8xvExe/IDGljbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rkmorris.us; dmarc=pass action=none header.from=rkmorris.us;
 dkim=pass header.d=rkmorris.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rksemorris.onmicrosoft.com; s=selector2-rksemorris-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxs0WFOpinvzuW6J/i8qFTlJJqYclDIXrsmfkEOxif4=;
 b=MoSdSbGnyvaXwMwhIy5q/YvT14MUFwQyCU/JsBp3wz+fmaaVWHl7O12BJlHQSJE4GndxogTa15+ze6Mrt6qttEgqTkAM32VsD9k9T+xhm6fBycq4BI4HHnKs9TyjK7BGrEA6FOFjpQQRwlYeB4UPDkDZbIwYWzj19x5pcyQG0v8=
Received: from SN6PR08MB6157.namprd08.prod.outlook.com (2603:10b6:805:f5::33)
 by SN6PR08MB5310.namprd08.prod.outlook.com (2603:10b6:805:a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 18:54:51 +0000
Received: from SN6PR08MB6157.namprd08.prod.outlook.com
 ([fe80::cc2f:935f:2b93:2408]) by SN6PR08MB6157.namprd08.prod.outlook.com
 ([fe80::cc2f:935f:2b93:2408%5]) with mapi id 15.20.2878.023; Wed, 8 Apr 2020
 18:54:51 +0000
From: "Morris, Russell" <rmorris@rkmorris.us>
To: =?utf-8?B?Vm9sa2VyIFLDvG1lbGlu?= <vr_qemu@t-online.de>, Bug 1871250
 <1871250@bugs.launchpad.net>
Subject: RE: [Bug 1871250] Failed to create HAX VM
Thread-Topic: [Bug 1871250] Failed to create HAX VM
Thread-Index: AQHWDRE21KdqIhLgiUWLHejvk18zr6hvkgZQ
Date: Wed, 8 Apr 2020 18:54:51 +0000
Message-ID: <SN6PR08MB61575186842D0C9EC1551E9AB9C00@SN6PR08MB6157.namprd08.prod.outlook.com>
References: <158621521246.22866.8297146941622716788.malonedeb@wampee.canonical.com>
 <0cf58bb6-c3f0-45d7-d37f-561dddf5f457@t-online.de>
In-Reply-To: <0cf58bb6-c3f0-45d7-d37f-561dddf5f457@t-online.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmorris@rkmorris.us; 
x-originating-ip: [47.185.43.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bd9a06e-cfc4-49c5-f92a-08d7dbee5184
x-ms-traffictypediagnostic: SN6PR08MB5310:
x-microsoft-antispam-prvs: <SN6PR08MB531079802CA76E735AC1E3B2B9C00@SN6PR08MB5310.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR08MB6157.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39830400003)(66446008)(53546011)(966005)(110136005)(81156014)(508600001)(316002)(86362001)(8676002)(81166007)(8936002)(2906002)(76116006)(7696005)(26005)(33656002)(66574012)(9686003)(55016002)(66476007)(66946007)(5660300002)(66556008)(4326008)(6506007)(52536014)(64756008)(186003)(71200400001)(80162005)(80862006)(460985005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: rkmorris.us does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fl0dIih+Z9eB5H46wWXH/IlCasgyYgm1OGRZXzlqBD53FlRxa30gAe/IHkNYnniOUyXoopHexo1lqFBq/fLRCEor5uyp1mJ7vmmlpH1lmJLKy0lfmnHB1fV0TMJWDDdeiL3EgK2ld8Ns/ZlPvxDfZCO/u0jlfWdqeHRiHkknnz2SkPYOvD7mlW95Ky+GbCY11TFs1ibZjFKACT9xjh40J2dVkTSx6/MYXNQ8bRxrsixkp55UJJqBVC2s+1SoSKpCFs62Ko15ZzSFAsUzS59pP2T5wYoIxd+jZU3X2eKpcHOgt11WUmu+hz4wBvw5tKJopQGdvv6qHive0/xAUxJOro+e7vdi0+/aXFBF8LoujatMHp7eeNJ3wv+/zHEbTpvcH6G/5zo8GnetqpiWFdAQlmPVw87Ix3f45+Qx7of7llSS26O21m9VlRfzUM1y6BwejYGeS3FXO9xdi0Jq2EbD5u7bTOIIL7U/dD1CxDwBr58DHqTL6xuASgM8dpCE1ZWx2XrbB+NCUR3Jpg3BsPvp4P3rvI/eSMDM1jpIcqw9blB6pakM9pjBycmILId3wna99tzeiBcheJmdO9S+mNgx/2KDxMwylQx98hzyAbI4Equ2Thc1B4BlSC6qdtMEr0T
x-ms-exchange-antispam-messagedata: NPChtn75dArZbjqevQVZaHwbpN/r4tj++/vns4TNmyoRJuXxoqVxiwOGnt9wLBV2lBBU0GSUFHZlIDpubSIqWLjY3jQpoJt1H83nNzntNdQILg6GK8Uc+GdgQ4fF7DZ+0RKTIV6sFH0H2m/1R4xUrQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rkmorris.us
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd9a06e-cfc4-49c5-f92a-08d7dbee5184
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 18:54:51.1933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: badb3d2e-7336-48c8-a8df-ad80a9a80dd0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8W+7nvn9EM4O58r3oYDi0len1rj/PmHfjGc96BawfeHBPkN0KAzTn7431b3DauchAGOJlY1jL0ZtWgay2CF7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5310
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.48
X-Mailman-Approved-At: Wed, 08 Apr 2020 17:10:09 -0400
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

SGkgVm9sa2VyLA0KDQpJIG5lZWQgdG8gdGFrZSBiYWNrIHNvbWV0aGluZyBJIHNhaWQgLSBteSBl
cnJvciEg8J+Yii4gSSBnb3QgZm9vbGVkIGEgYml0LCBsZXQgbWUgdHJ5IHRvIGV4cGxhaW4uDQoN
CkkgcmFuIHRoZSAic3RvY2siIGRvd25sb2FkLCB0aGUgV2luZG93cyB2ZXJzaW9uIHRoYXQgUUVN
VSBwb2ludHMgdG8gKHdlYiBzaXRlKS4gSXQgZG9lcyBzYXkgaXQncyB2NC4yLjAsIGJ1dCBzZWVt
cyBpdCdzIG5vdCBxdWl0ZSwgaXQncyB2NC4yLjAgd2l0aCBzb21lIG1vcmUgcmVjZW50IHVwZGF0
ZXMgKGJ1dCB2ZXJzaW9uIG51bWJlciBub3Qgc2hvd2luZyB0aGF0KS4gSXQgZmFpbHMgd2hlbiB0
cnlpbmcgdG8gdXNlIGhheG0uDQoNClNvIEkgd2VudCBiYWNrLCBidWlsdCAicmVhbCIgdjQuMi4w
IG15c2VsZiAoZnJvbSBzY3JhdGNoLCB0byBtYWtlIHN1cmUpIC4uLiBhbmQgaGF4bSB3b3Jrcywg
anVzdCBsaWtlIHlvdSBzYWlkLiBJIGFsc28gdXBkYXRlZCB0byB0aGUgbWFzdGVyLCBhbmQgYXBw
bGllZCB0aGUgcGF0Y2ggZnJvbSBiZWxvdyAuLi4gbm93IHRoYXQgd29ya3MgYXMgd2VsbC4gVGhh
bmtzIQ0KDQpJIGNhbiBjbG9zZSBvdXQgdGhpcyBidWcgcmVwb3J0IGlmIHlvdSB3YW50LCBvciBs
ZWF2ZSBpdCBvcGVuIHVudGlsIHRoaXMgcGF0Y2ggaXMgaW4gdGhlIG1hc3RlciAtIHdoYXRldmVy
IHlvdSBwcmVmZXIuIEFuZCBJIGNhbiB1cGRhdGUgdGhlIGJ1ZyByZXBvcnQgaWYgeW91IHdhbnQu
IFBsZWFzZSBqdXN0IGxldCBtZSBrbm93IGhvdyB5b3Ugd2FudCBpdCBoYW5kbGVkLg0KDQpUaGFu
a3MgYWdhaW4gZm9yIHRoZSBoZWxwIQ0KDQouLi4gUnVzc2VsbA0KDQoNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFZvbGtlciBSw7xtZWxpbiA8dnJfcWVtdUB0LW9ubGluZS5k
ZT4gDQpTZW50OiBUdWVzZGF5LCBBcHJpbCA3LCAyMDIwIDI6MTggUE0NClRvOiBCdWcgMTg3MTI1
MCA8MTg3MTI1MEBidWdzLmxhdW5jaHBhZC5uZXQ+OyBNb3JyaXMsIFJ1c3NlbGwgPHJtb3JyaXNA
cmttb3JyaXMudXM+DQpDYzogcWVtdS1kZXZlbEBub25nbnUub3JnDQpTdWJqZWN0OiBSZTogW0J1
ZyAxODcxMjUwXSBGYWlsZWQgdG8gY3JlYXRlIEhBWCBWTQ0KDQo+IEhpLA0KPg0KPiBJJ20gcnVu
bmluZyB0aGUgbGF0ZXN0IChtYXN0ZXIpIG9mIFFFTVUsIHRob3VnaCB0aGUgdmVyc2lvbiBkb2Vz
bid0IA0KPiBzZWVtIHRvIG1hdHRlciAtIEkgYWxzbyBjaGVja2VkIGJhY2sgdG8gdjQuMi4wLCBl
eGFjdGx5IHRoZSBzYW1lIA0KPiBpc3N1ZS4gQW5kIHRoaXMgaXNuJ3QgYWJvdXQgdGhlIFZNIChn
dWVzdCksIGlmIEkgZXZlbiBqdXN0IHRyeSB0byBydW4sDQo+DQo+PiAiYzpcUHJvZ3JhbSBGaWxl
c1xxZW11XHFlbXUtc3lzdGVtLXg4Nl82NC5leGUiIC1hY2NlbCBoYXgNCg0KSGkgUnVzc2VsbCwN
Cg0KYXQgdGhlIG1vbWVudCB5b3UgbmVlZCB0aGlzIHBhdGNoIGF0DQpodHRwczovL2xpc3RzLm5v
bmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMC0wMy9tc2cwNjgzMS5odG1sDQoN
CkJ1dCBJIGNhbid0IHNlZSB3aHkgdjQuMi4wIGRvZXNuJ3Qgd29yayBvbiB5b3VyIHN5c3RlbS4g
VGhlIGJ1ZyB3YXMgaW50cm9kdWNlZCBsYXRlci4NCg0KPiBCYXNpY2FsbHksIGp1c3QgZ2V0IGEg
d2luZG93IHRvIG9wZW4sIHdpdGggYWNjZWxlcmF0aW9uIGVuYWJsZWQgLi4uIEkgDQo+IGdldCwg
T3BlbiB0aGUgdm0gZGV2aWNlIGVycm9yOi9kZXYvaGF4X3ZtL3ZtMDAsIGVjOjMgRmFpbGVkIHRv
IG9wZW4gdm0gDQo+IDAgRmFpbGVkIHRvIGNyZWF0ZSBIQVggVk0gTm8gYWNjZWxlcmF0b3IgZm91
bmQuDQo+DQoNCmVjOjMgaXMgRVJST1JfUEFUSF9OT1RfRk9VTkQNCg0KV2l0aCBiZXN0IHJlZ2Fy
ZHMsDQpWb2xrZXINCg0KDQo=

