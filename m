Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118BE21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fDLyqs9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118BE21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwhj-000533-9D
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAwO7-0006cT-Ds
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAwO6-0004xD-4w
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:22:22 -0400
Received: from mail-eopbgr750129.outbound.protection.outlook.com
 ([40.107.75.129]:23422 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAwO5-0004vm-Tq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTPEEJrsSgxBBDI3V8jxqm6P2IjdWcytYQ6qD+d3NJvCS6eEq5i3b6eVu216Mcd+Vucd6LXXrYgF75B4YrqB+yYJ8Ql5N42iFYcaZ4uU3UPef60Rji4vnakt6dAnh8Hf49YDoJ5+dg4YKVYUjSdYLx0zKYXFWCBSoMG1PtXiTmV5d/PUIn1wSQd5PS5V3xZWzCQKIBhyCs3AkFL2hm+N/pd83rRnJBSnp7ZQttA0O1YleBCF+iKLx/3MMMkAJLzYTUqcMRn7wj15HEY7Bk3qtXaKfCdcz/U3aJxXYMvZ/7MDoPN2fwJG7UIor2s710XoJQRpZLhxtQWboVFTqyoDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+yjTVFj9IMtFZfwMEf8RQzD7L7ofxA38hocboGgxKY=;
 b=KASjeFLdB2TJM18XTqGk7t+qTepDdve4kUmI9RerSuVIf/UfTXEl8QV0zh42CTpDHMkiVnAUr9SD1FdcE5CRKL9eWj2J+g0zZS8N629JVgzgw2Zz3GlIV9HPWU1RqFmZA4tF8Mj4W6EqsflP5vW38QDnhnQ/D1le6+3F9qAmcHRExbFWdQ5GCngwC1PkmQA7RwOdA+qi0lO/yO3RrSeuTQGgQAHJZpGwektEOrUQz9lwlT/afUh8K2a344zfBmKz4XWYzFJ8bsM5kOOBmo1G0ipoiQFMafuaUHjmpUKfGrIrg1HoabZf+XjIMOu0th6oj8waGcNGXtozyG1y2U2Mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+yjTVFj9IMtFZfwMEf8RQzD7L7ofxA38hocboGgxKY=;
 b=fDLyqs9KYC8isbkryxMZFP8+3J7eWUimLsnYTxktOCP19dDfy9TUn9A2onUeEY2Fuw1Tg7jM2poM6qYu6ErT0KwagDj1S0a6Dsu+58XDPSwvHNGGNSieH6dWZLIHZhtVYr/twbzu+xWAXBtlkRKLNdxMG1R/xgMkJkV2+ZQlLi4=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 13:22:20 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:22:20 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "stefanha@redhat.com" <stefanha@redhat.com>
Thread-Topic: [PATCH v3 14/22] libqtest: add in-process qtest.c tx/rx handlers
Thread-Index: AQHVbneM5DHTVNsf2EWK27C25kPhHKcy0M4AgAAsxQA=
Date: Thu, 19 Sep 2019 13:22:20 +0000
Message-ID: <7cb180b719c4ce154ce5000f526fd083b7672f77.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-15-alxndr@bu.edu>
 <20190919104202.GP3606@stefanha-x1.localdomain>
In-Reply-To: <20190919104202.GP3606@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6ca60f-32c3-4576-970a-08d73d0466b1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB2872; 
x-ms-traffictypediagnostic: CY4PR03MB2872:
x-microsoft-antispam-prvs: <CY4PR03MB287265E42B640333D98F4BBBBA890@CY4PR03MB2872.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(66066001)(6916009)(81166006)(81156014)(1730700003)(8676002)(786003)(6512007)(446003)(14454004)(2616005)(99286004)(11346002)(118296001)(36756003)(2501003)(6116002)(6246003)(6486002)(2906002)(3846002)(88552002)(6436002)(54906003)(229853002)(7736002)(305945005)(8936002)(316002)(5640700003)(66946007)(91956017)(75432002)(64756008)(256004)(66446008)(66556008)(86362001)(186003)(2351001)(76116006)(4326008)(66476007)(5660300002)(26005)(4744005)(76176011)(71200400001)(71190400001)(478600001)(476003)(102836004)(6506007)(25786009)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2872;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nNw+AYkgXNgBZ11MBIeN8glmPbH6TQIgAzf6y0Cur2TAhRWXc3a+r4hYob/Sedv9ETnYbTBoZ6NQS3KcsKM12/vwSmNg1pr8ff4Kp2vrxFigqZLahZJMGZpj2bEBAUYjwPwTce+CMsTTAZ4u3MP96MEudAZVERU+wuY312Ymmi7r3y944ZDKBlVcxAmZCEqlRqaWFnjlJqfeD1lTSabb2FmtJ+raKUEv/oTMe9PWmmwP/WU5GZUMklXuWjCLRtkYnjbZsyPpviSfjDSKaelY3ArwF/Hz/1NoVuZSx6jOrBb86pEOzBWxKJNldS5HnDFloyis4iIEL9toOzDU+Z5SYStIeS4XLqUucf/DfGtN36AhxduVc2UJ7DYbR1NsyZg22RLGcGfQzwSTpA14o8yE5nbQG/+WEYyHFdFU4kq1T4o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E55A5D127A8824A81E60CB0321B3ACD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6ca60f-32c3-4576-970a-08d73d0466b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:22:20.7582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnzkgkxLBV3Q6Zb5aub01tFDimItOakvGCySZ0CBxhFQsvu8pCB+Fzu3HKFd2xeG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2872
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.129
Subject: Re: [Qemu-devel] [PATCH v3 14/22] libqtest: add in-process qtest.c
 tx/rx handlers
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDExOjQyICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDE4LCAyMDE5IGF0IDExOjE5OjQxUE0gKzAwMDAsIE9sZWluaWssIEFs
ZXhhbmRlciB3cm90ZToNCj4gPiBAQCAtODMwLDYgKzgzMiw5IEBAIGNoYXIgKnF0ZXN0X2htcChR
VGVzdFN0YXRlICpzLCBjb25zdCBjaGFyICpmbXQsDQo+ID4gLi4uKQ0KPiA+ICANCj4gPiAgY29u
c3QgY2hhciAqcXRlc3RfZ2V0X2FyY2godm9pZCkNCj4gDQo+IE1heWJlIHRoaXMgc2hvdWxkIGJl
IHBlciBRVGVzdFN0YXRlIGp1c3QgbGlrZSBiaWdfZW5kaWFuLCBidXQgdGhlDQo+IGdsb2JhbA0K
PiBxdGVzdF9hcmNoIHZhcmlhYmxlIGlzIG9rYXkgZm9yIG5vdy4NCj4gDQoNCkkgd2FzIHdvcnJp
ZWQgdGhhdCB0aGUgc2FtZSBRVGVzdFN0YXRlIG1heSBiZSByZXVzZWQgdG8gcnVuIHRlc3RzIGZv
cg0KZGlmZmVyZW50IGZvciBxZW11LXN5c3RlbSBiaW5hcmllcywgYnV0IEkgY2FuIHNlZSB0aGF0
IHRoaXMgaXMgbm90DQpwb3NzaWJsZS4gSSdsbCBtYWtlIHRoaXMgY2hhbmdlLg0K

