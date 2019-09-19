Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A40C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE5521D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="VttxfIBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE5521D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwor-0003d3-Dr
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAwT4-00051d-U8
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAwT2-0000VO-PI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:27:30 -0400
Received: from mail-co1nam05on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe50::72e]:33856
 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAwT1-0000TP-1g
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh1AcWex7hmmcKvcVwY5WPUPzOEsx3k6Xw0gTGEuphYdNUUlmrzUfRSqQFimrMvsAjdFYOmnEeONQagoCfQw+r9NQFgGvPSBColZU3SOUdYFDx7BOHvswPxLfuGlfuteyAy5lSgNjV3c81cFwosVBdiVPtMk4WkmaFv0BipviCWkHRILzKpos2IyslC4rN4nBL6brLPvWwa2ZgUyGjX/Z663iTpJyIA9OEnE12rZSCXK7GR39wpxJSy4fgKnRv43p7KbnlfzlxgK1KBseycn3mdNpQekwwagdS+Y14FPIUPf2OsTbX3wY88MVEFjsfLi4lG3nQjWwhUR7T4pD269zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBBs/HEo/SBd5hVGyWSQdvpbTX+9MFc5Flxvp3+ZTWM=;
 b=GieVIDMmRJEAxOLP4PVrOjY8VwbUuLB+DBV6EDWFAJp6XftvjbXkHjYhaHL5bGwcQCRF7xQ1vhSXLbv3bkvn2etKfDexQGKYjM2iEvQjqZ0NXKw93RMhCH9CUHw/6x8AtqgyrP7WgiqcGm1L0aBAOx8yuVRtMClD29JLSQ73/fejzES3vx/tDykWLkF3BcDeVaZwt1nUfhtLh0RiHsXqoUd1M/Qyvj+bDFnh7wNqL74yC5Ig0K3dEd7yqH05Dvp9Nm1BBgB4pmu6ATjjwr+hV1pZN9nn0D0mkCgvmAmfqJrk0jflSbrkDM/rG4HPm10ZJ3B9XcG+vw+KgjC+05Zrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBBs/HEo/SBd5hVGyWSQdvpbTX+9MFc5Flxvp3+ZTWM=;
 b=VttxfIBKBysmA5zHVDP8kCpCU3l11nSt/HGB+jKwqVs+jFFFdHmHMA2+IMI7OoB+OaEZJPEAmG2VFFrlzJQZt/9zW20DnOyH3DgmCABp+yL0L+hKm4aubNx7PrPOWXZEs04ROU4Utf9Nj9rzZlt4/JGKeIZaIAtLnU+wvJFIg3c=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2933.namprd03.prod.outlook.com (10.175.115.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Thu, 19 Sep 2019 13:27:24 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:27:24 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 05/22] libqtest: Add a layer of abstraciton to
 send/recv
Thread-Index: AQHVbneHp+c4RlezBUGXNefN9Lzx6qcy2xcAgAAj5wA=
Date: Thu, 19 Sep 2019 13:27:24 +0000
Message-ID: <60437a730d3df6a3248cd944eacd4555b40d00bc.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-6-alxndr@bu.edu>
 <a2ac1b44-8a93-8b81-c44d-133f7eefe944@redhat.com>
In-Reply-To: <a2ac1b44-8a93-8b81-c44d-133f7eefe944@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4ae3e5d-0898-43d8-f7a3-08d73d051bbe
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB2933; 
x-ms-traffictypediagnostic: CY4PR03MB2933:
x-microsoft-antispam-prvs: <CY4PR03MB2933CAEF2C22E3349FEA464ABA890@CY4PR03MB2933.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(76116006)(76176011)(476003)(229853002)(305945005)(99286004)(3846002)(2906002)(2501003)(186003)(26005)(88552002)(6436002)(71200400001)(6116002)(7736002)(6512007)(118296001)(6486002)(8676002)(102836004)(6506007)(91956017)(71190400001)(36756003)(86362001)(786003)(256004)(8936002)(14454004)(66446008)(4326008)(110136005)(2616005)(81156014)(81166006)(66066001)(66556008)(75432002)(486006)(4744005)(316002)(66476007)(5660300002)(6246003)(446003)(11346002)(64756008)(478600001)(66946007)(54906003)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2933;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WY/wgMw3A/4TJR0imALZrghwQzq8jAgW2pjIeHC/2OkCX4NRpWrojej36mO903w2s8QrZ2dVVN6FZ0UZob0s2Bhn/kqE8OcsH81TwS2Xn45EbiOSKkS3MCX4jJdnEyAAgFKwuHb4xLLv94fBXBEXiR+pKWJYm9Zr+DvNTsUfgZ00KIckoMCB7ZUtf7fwonUtgtxZsp104bWE/HhbQY/EtDqjOnRnRQirvIR4Lt/9IPpHUbevR1vFMltPVZvwDChiCSPYhJcm9zZr46ERDsfRNeXbgOnWjqoVIBTWzUJ3p4KkrUAUrOHC6ZfhkzcsqJY6jbJQRsjS4XG7ujA5cZzoAX/zo8JD6jVlzbev0He+3iEdxEtJCNFuhRkBATV5r8Sw+QKUJWFrl1cdsnTaAhjW1VqvohcDV09AOZnz9fMoWHs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A84C238F1E8442A2879E6C9236BF53@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae3e5d-0898-43d8-f7a3-08d73d051bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:27:24.4376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hV0WNT1onELulCqOW7h34GjvXOga8x+7+t7Pw6F8gcrwAp9PZmFcRe5QcoIlz2Zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2933
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe50::72e
Subject: Re: [Qemu-devel] [PATCH v3 05/22] libqtest: Add a layer of
 abstraciton to send/recv
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDEzOjE4ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBJIHRoaW5rIHlvdSBjYW4gcGFzcyAicyIgdG8gdGhlIHR4IGhhbmRsZXIgYXMgd2VsbCwgYW5k
IHJlbW92ZSB0aGUNCj4gc2VuZF9vcGFxdWUgYW5kIHJlY3Zfb3BhcXVlIGZpZWxkcz8NCg0KUXRl
c3QgYWxzbyB1c2VzIHRoaXMgZnVuY3Rpb24gdG8gY29tbXVuaWNhdGUgb3ZlciBxbXAgIChkaWZm
ZXJlbnQgZmQpLg0KSSBjYW4gcHJvYmFibHkgbWFrZSB0aGUgdHggaGFuZGxlciBhIHdyYXBwZXIg
d2hpY2ggYWNjZXB0cyAicyIsIGFuZA0KcGFzc2VzIHMtPmZkIHRvIHRoZSByZWFsIHNvY2tldF9z
ZW5kLg0KDQo=

