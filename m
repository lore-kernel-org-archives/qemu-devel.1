Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D06C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332E621D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Vg6Hf1ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332E621D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwnd-0002DY-0J
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAw9f-0006tj-Qx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAw9e-0004lK-NT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:07:27 -0400
Received: from mail-eopbgr820139.outbound.protection.outlook.com
 ([40.107.82.139]:6472 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAw9e-0004ih-Ip
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajKT475yuYJgxTFv7hegO9VJOuETZZ4LfOOAlqvTTv4JK5vtlegvCpQJBW7mWvssLCGxf9SXiWjDSyaKqQFieamJevuYzT4zr44/8Oovjzb7ipXWsfJevBA8xol8r6jACxVsU0kt8n+E9egy8StKkeMjq5zYQZ1iUcEHS/m6KlUydXkfnV/jb0+Jd6T8zOYVXMEhRUYCJsritXcjnKVdB9OTTWo5vHKHRkel0lZo8tQLoMI6ULnzebCIpvBsr8nbARpCqsFDUx/mY7neattRrMmBg68UbyYtUvQ/yt7dWvYUH9u/RX/jYZ64K8MeXs8XbdUdQ1fgDWEe/DFQP0fuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU8DCQ8hAOyxhDPYIUKWVzzKVxXvABRebfsTDp3cHZ8=;
 b=VC4SW0E1Uxr7pcskzCMZxd6InXaPUoysYFJSTfYupgSjN7J8iMcGyo63wAY2tA4YertwPFKKC5KWgp4NOG0ZWvj2vCpkX1DRVL1izpELaOZRaK1bCK1Y4TQP0oBmjfGAfXtznOaFK52XqqSrAM5SxfpXpdOgkdRFsBa2JfZV+4FJ+0JkqQE0zMchVDiuXtFs7ChvPRlmLs2u/zamH5l17UCclvsSFamjdXN0YYY9Q0Wfvx9TiMfRXaK/RUas5k/+3pZMxqc2WZQgLxwNJG2D5gVU7Pg05xjpmRhQTB6dpsirQ1wIkJEA2m8Fdz4HHZcKrN+jNq57auS+eaXRqs3IGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU8DCQ8hAOyxhDPYIUKWVzzKVxXvABRebfsTDp3cHZ8=;
 b=Vg6Hf1kard04GhhR0KpJ2cTSwr+on3lSmdcrh0iOr0r0tuQc6FzfXyt42yjSy88Jlux8r1gm9b9lfJCnps8ST6sdZhWA/Tsu3RgMxcbg/ckpTBVxxgCFY0hAPk1KfbDtUbpknzcl2et+EfwYqrAVrw2cPe/W7MJV4YmFpMDmsyQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2760.namprd03.prod.outlook.com (10.173.39.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 19 Sep 2019 13:07:25 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:07:25 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "stefanha@redhat.com" <stefanha@redhat.com>
Thread-Topic: [PATCH v3 06/22] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHVbneHyovnzJrtBU6Jp3gZ4trMkqcyzSgAgAAsQIA=
Date: Thu, 19 Sep 2019 13:07:25 +0000
Message-ID: <9d95d2b4aea5919efcae052a25efa121d734ca85.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-7-alxndr@bu.edu>
 <20190919102858.GJ3606@stefanha-x1.localdomain>
In-Reply-To: <20190919102858.GJ3606@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86dd5545-1fcb-4ba6-69a4-08d73d0250d1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB2760; 
x-ms-traffictypediagnostic: CY4PR03MB2760:
x-microsoft-antispam-prvs: <CY4PR03MB27607C189AB4F8A42CAD27F6BA890@CY4PR03MB2760.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(66476007)(64756008)(66946007)(66556008)(26005)(91956017)(102836004)(71190400001)(256004)(486006)(4326008)(76116006)(11346002)(2616005)(2351001)(71200400001)(476003)(305945005)(6486002)(6512007)(5640700003)(446003)(75432002)(6246003)(118296001)(2501003)(4744005)(7736002)(229853002)(5660300002)(6436002)(14454004)(186003)(478600001)(66066001)(3846002)(66446008)(6506007)(25786009)(1730700003)(8676002)(36756003)(81166006)(54906003)(88552002)(81156014)(99286004)(786003)(316002)(6116002)(86362001)(6916009)(2906002)(8936002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2760;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mJds7YdrM8MVBg1gFL5fJ4gNI6GfBP1OIZvLWk3g/ShSB2Ch6FKXTgWlKKAaRwlyCgeZUJwnRRiaEzRSReXnRH7ctVETOCwfryPHyjZM4YNNIvQYpYBavl81Lg8i6/grKmFpbC/3fZ8z8xJLpPkqxZekjZWJ/2dI9z5mViHfzbsMca6eR6MrPFbgV8Jly2SPXjS9xvTvQmgZT6lYoAmyF+UDYVibfFmYd4WrtVQgKdNZyKDTxKdtct938DkW4xsXcOARVeRozuc1RIU23quGPJnNrVr90qVJvclDzh4xBry036JScymFSejy/dQJulE1+LGrhkWwl+oRTQ5c2BxeleM3b2YpfybTPslzhwhA1he7Qj/LCy5+WXV4lKyKF7VNXlVSQYKIMBiLH63QLdWnyy+l6R96AfI0ZlQd8L9SQ8s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8922F0043F46FB4BBB60E98EE04C51C8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dd5545-1fcb-4ba6-69a4-08d73d0250d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:07:25.0495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDYDMcCrIoJ12JaR9NXsMKbcz6lXo6XYkSYZI24jTWzPR7Z+CoOY3WHDjqyCIqXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2760
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.139
Subject: Re: [Qemu-devel] [PATCH v3 06/22] fuzz: add configure flag
 --enable-fuzzing
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDExOjI4ICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IElzIC1mc2FuaXRpemU9ZnV6emVyIGEgY2xhbmctb25seSBvcHRpb24/ICBJZiB5ZXMsIHRo
ZW4gcGxlYXNlIGVuc3VyZQ0KPiB0aGF0IHRoZXJlIGlzIGEgZnJpZW5kbHkgZXJyb3IgbWVzc2Fn
ZSB3aGVuIC4vY29uZmlndXJlIGlzIHJ1biB3aXRoDQo+IGdjYy4NCj4gWW91IGNvdWxkIHByb2Jl
IGlmIC1mc2FuaXRpemU9ZnV6emVyIHdvcmtzIGFuZCB0aGVuIGNoZWNrIHRoYXQNCj4gZnV6emlu
Zz1ubyB3aGVuIHRoaXMgZmVhdHVyZSBpcyB1bmF2YWlsYWJsZS4NClllcywgZnNhbnRpemllcj1m
dXp6ZXIgaXMgYSBjbGFuZy1vbmx5IGZlYXR1cmUuIEknbGwgYWRkIGEgcHJvYmUgZm9yDQppdC4N
Cg==

