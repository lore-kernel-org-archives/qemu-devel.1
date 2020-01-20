Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FA4C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1292A2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="gKgSq63a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1292A2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQ6n-0004jX-Jf
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1N-0006ly-B7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1M-0006FN-7l
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:45 -0500
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com
 ([40.107.92.90]:54177 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1M-0006Eg-3P
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrXa9D2zQ2zNUYUNZyPXb0SLjdkXAGI2v0BxwZhscI7v2jeZfAxSD06hGxur6upE6Sc8O7SZ+pFVZ4E0M1pmjVwsSxf11VFZ0PYkuldgJcAkropHNFqvr1lITG+hyXSCSp7bef9LWsb3B3ce7+BvCiPKKdm3z8ImXWwR4i1i7yG/npoLzSfPk3a4pONYR2h/AgjywMWH2jRh0ddIhr4oijGuUERmD7Vf0GzelraQIUPDi87F4MkGPnq2W1mF5Z+V324VGKLMl44eqvsOj4DCasSRSM7MamUF+/kyceSuaFpmtSNtIaNmbUDYVpTLxgywfZeRh8Z3KhtlwD9TLdSC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns3uR7r40f3Hn5it1jv0Pcc2ZA1fNyAHsn2M9Jhx4kw=;
 b=kuzeANqUz8wNY6z5ALIhzxdcMD5pMsEbXIycGpj/ZrBBq3IgDNexx9GVfkcB/LNtJd1aG1vlQU3goXc5mgmUwuqU46KCo75gNXh4eBZY8ivKAjy67WPwKH9Jh5jFt1j8V0144L8N7hMzrGS5dds7tzrvcA9e4yjT2lomBWojP4kBxh/m87if7CeUc0E0T8z7k0Hn7YzJyJVNAcclILNi8dVilgQMspkPFPoiQoY9Y8xfBg9uIl+MZ9itU0PYiRlwJT9cgJm//dZXdZVeKZxxkATaElqOWaSG37Ld1GeXTTr2MttxP3msla6EnMiv4YrU8Fk2ItZY61ZAouQcNDoXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns3uR7r40f3Hn5it1jv0Pcc2ZA1fNyAHsn2M9Jhx4kw=;
 b=gKgSq63ag/22ulKjXTq9Hqo3RinJe2AOQzo7a/pz0HP5lplafg2lJBu9HGqsZk+5r7EiXwS/jkolHwo5M8Xy3aUtjo2rFDJr3oVn/6UKkqp2RoOmvoEN+oF0E9eDdSxJsRe2j734gtBjRB3RJALX6rrJZ93MVFaRORC6VfViWWc=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:43 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:42 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 02/20] module: check module wasn't already initialized
Thread-Topic: [PATCH v7 02/20] module: check module wasn't already initialized
Thread-Index: AQHVz1YcPf+wM7ctiEW7xpS4IV/MpQ==
Date: Mon, 20 Jan 2020 05:54:42 +0000
Message-ID: <20200120055410.22322-4-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7955975-704e-4d48-6719-08d79d6d3ed9
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399716B4BB2B7E08AA1CF60BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvk5NEe1LIqrsptet8oKLeR01+59hCHclFkQA7bEHyl3yVCPu7jvaF9/7V9gN9ePjOqKRkm8WZRSMj1umgPEV8Mimb3qkB7CiZuOUeCV4BXfCKyWhQKtohQDvzLUMNpra2MIoGv/AtfPIRaweM3WhrPWs1Bnm3M5EYKSY3mzlOgvTpmtjLjiVz3B6Cs38fVfyvTjoXnh1++/AmajwAhhO6v3wDAXZmPOU1Qh9xoqcvVqV+VAgsx2afArpQut91aY9W5jb/0NmHd+ParMxiGyL87IRtgaYEVkkYKJceM1GDBKCqWcxcJVbIWIEq0X5uqy7hTWXE7H27WoTvBwNyuhX8jWxsIXn7b2RJu1Wla08fRKdDh+ublHj4Xj1DmdGfc/QXJ3P0dVnns52ON0gmvg155UeoQcNdiyeSwcOME5zxKkDVRZRSnQxfXu3qpbdTYQ
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE27E998CE269044A25EDE080C34FE30@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f7955975-704e-4d48-6719-08d79d6d3ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:42.9954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYMAuPIyRVO1jNBmLHrLDAMXgbArM/xdZevdxGpdWiwcl9C3B07nHf87A78Qi54I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.90
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
Cc: "Bulekov,
 Alexander" <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHZpcnR1YWwtZGV2aWNlIGZ1enplciBtdXN0IGluaXRpYWxpemUgUU9NLCBwcmlvciB0byBy
dW5uaW5nDQp2bDpxZW11X2luaXQsIHNvIHRoYXQgaXQgY2FuIHVzZSB0aGUgcW9zX2dyYXBoIHRv
IGlkZW50aWZ5IHRoZSBhcmd1bWVudHMNCnJlcXVpcmVkIHRvIGluaXRpYWxpemUgYSBndWVzdCBm
b3IgbGlicW9zLWFzc2lzdGVkIGZ1enppbmcuIFRoaXMgY2hhbmdlDQpwcmV2ZW50cyBlcnJvcnMg
d2hlbiB2bDpxZW11X2luaXQgdHJpZXMgdG8gKHJlKWluaXRpYWxpemUgdGhlIHByZXZpb3VzbHkN
CmluaXRpYWxpemVkIFFPTSBtb2R1bGUuDQoNClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBCdWxl
a292IDxhbHhuZHJAYnUuZWR1Pg0KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4NClJldmlld2VkLWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJlbi5rZW5ueUBv
cmFjbGUuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
cmVkaGF0LmNvbT4NCi0tLQ0KIHV0aWwvbW9kdWxlLmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS91dGlsL21vZHVsZS5jIGIvdXRp
bC9tb2R1bGUuYw0KaW5kZXggOGM1MzE1YTdhMy4uMjM2YTdiYjUyYSAxMDA2NDQNCi0tLSBhL3V0
aWwvbW9kdWxlLmMNCisrKyBiL3V0aWwvbW9kdWxlLmMNCkBAIC0zMCw2ICszMCw3IEBAIHR5cGVk
ZWYgc3RydWN0IE1vZHVsZUVudHJ5DQogdHlwZWRlZiBRVEFJTFFfSEVBRCgsIE1vZHVsZUVudHJ5
KSBNb2R1bGVUeXBlTGlzdDsNCiANCiBzdGF0aWMgTW9kdWxlVHlwZUxpc3QgaW5pdF90eXBlX2xp
c3RbTU9EVUxFX0lOSVRfTUFYXTsNCitzdGF0aWMgYm9vbCBtb2R1bGVzX2luaXRfZG9uZVtNT0RV
TEVfSU5JVF9NQVhdOw0KIA0KIHN0YXRpYyBNb2R1bGVUeXBlTGlzdCBkc29faW5pdF9saXN0Ow0K
IA0KQEAgLTkxLDExICs5MiwxNyBAQCB2b2lkIG1vZHVsZV9jYWxsX2luaXQobW9kdWxlX2luaXRf
dHlwZSB0eXBlKQ0KICAgICBNb2R1bGVUeXBlTGlzdCAqbDsNCiAgICAgTW9kdWxlRW50cnkgKmU7
DQogDQorICAgIGlmIChtb2R1bGVzX2luaXRfZG9uZVt0eXBlXSkgew0KKyAgICAgICAgcmV0dXJu
Ow0KKyAgICB9DQorDQogICAgIGwgPSBmaW5kX3R5cGUodHlwZSk7DQogDQogICAgIFFUQUlMUV9G
T1JFQUNIKGUsIGwsIG5vZGUpIHsNCiAgICAgICAgIGUtPmluaXQoKTsNCiAgICAgfQ0KKw0KKyAg
ICBtb2R1bGVzX2luaXRfZG9uZVt0eXBlXSA9IHRydWU7DQogfQ0KIA0KICNpZmRlZiBDT05GSUdf
TU9EVUxFUw0KLS0gDQoyLjIzLjANCg0K

