Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7C923697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pv8J/6g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7C923697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59ii-0005Rx-2p
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i59hz-0004x2-A3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i59hy-0005F7-Bg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:22:59 -0400
Received: from mail-ve1eur01on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::72d]:8367
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i59hu-0005Cj-Hd; Tue, 03 Sep 2019 10:22:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMHXFP0GUz8qPS5I/2hdQs5fT0zcvsCfR5+IrPwOOmuhTBxVkFWhUvf0K1Ot7F0TyAHBS0L4srEc4U/RflL6KMLvjgmD1LCN4RZ2ELBojpSn1l3Dll69xbebpzZ3bw11vXKCvERltGysIJI4YnVyhdedMEb3o/mSZLGuRFn4lXPTk4xGRC9U6sTKOwtpptucnJDaaR4SQsPU17nAcGp8Tq0YH8ZYLazBFbf73yQW9EFTmNOLod8wZSD8Tush5bFeQp8G6J45nMWPHNKiOdDXrbuJjHKKt4hBgbg84THL+S8MVWYnDOugAogBeKoHva6npu8/q2tAAvidOqbZ1tzCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5E47N4Sz/1zbY0QmOvfxHLfUgiWVkfGo2ET588wQ4c=;
 b=keRa92zX/q0sun49qNa3yJ9OBJwbe3O/CHvsGTSAxiiILzjOCPGm1bnGJksyQyvZ03crPXU5WUVG6DO6UeIWEfvzjZP0odIljbUjeLsIi1REbzTZcUeG6yHvUaZ2x44z3zmReG3SHBEURYNbYpgIKrlIZo9cjgsW0ODfZ73krGanXs9bodha9S4fIvooRHpba3NlZjgKPYpWb9T17z4xaZP2ye6XsuSFJBrfUxSajz/2RqpxWuraRQNlTdJwINrL+7BptniOK8Z02I1YvUCpiJMnT4lIrr2emiYCDWamBpXPaqj1NWO7ZxZsH1NGgwhbeKr8Zw4dQpCemss5W0NUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5E47N4Sz/1zbY0QmOvfxHLfUgiWVkfGo2ET588wQ4c=;
 b=Pv8J/6g+1IolgBiNAu1D3p86syg9tK4xPyAaN7OcAu4jTITRzdqp8CsvFERArHXvhRmgSIgWyGIlOPFqSbvAmQAcwXRI+kHDsLC4v9D0RBIiVq9+2UxNrEXvCN1W9mLlRuUgCHqDdCXsTQPJlKRw5g6b/t52H1esk4dKwwS03Os=
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com (52.134.95.154) by
 AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 14:22:51 +0000
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51]) by AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51%6]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 14:22:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v7 0/6] Allow Valgrind checking all QEMU processes
Thread-Index: AQHVYLvcme1P621GcUCyi7aLGgh+kacZu+yAgABIvIA=
Date: Tue, 3 Sep 2019 14:22:50 +0000
Message-ID: <0d46c5d2-8dac-c2fe-941e-4cd993a96d88@virtuozzo.com>
References: <1567338786-586124-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190903100229.GD4582@localhost.localdomain>
In-Reply-To: <20190903100229.GD4582@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To AM0PR08MB3027.eurprd08.prod.outlook.com
 (2603:10a6:208:61::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5025f97f-af19-417c-a822-08d7307a33c0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB2961; 
x-ms-traffictypediagnostic: AM0PR08MB2961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB29618CBEEA20E3C5A4F07741F4B90@AM0PR08MB2961.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(102836004)(476003)(36756003)(229853002)(26005)(4326008)(8936002)(66946007)(99286004)(6436002)(31686004)(54906003)(107886003)(316002)(66476007)(66556008)(64756008)(6246003)(81166006)(81156014)(53936002)(8676002)(66446008)(52116002)(3846002)(6486002)(76176011)(4744005)(5660300002)(186003)(25786009)(486006)(44832011)(446003)(31696002)(6916009)(86362001)(478600001)(6116002)(14454004)(386003)(66066001)(53546011)(6506007)(14444005)(2906002)(6512007)(305945005)(256004)(11346002)(2616005)(71190400001)(71200400001)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2961;
 H:AM0PR08MB3027.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F3SQNOgN1fjpxbPl9FGolLaCUR7GWF4rpDlmlL/DuDzimd11jjvLWD4RAKIw1DfjBhXw7OYyinzaBC7PqXUMowUFdSp8+9s/gTuflj8qJjByE1uE+4XrcOoNjBjgt9g4r5Lu17cZmdP5sZN3nETZwHttYnippt3fd55yhKuxSUqBmQWQnecM6LAq21ZgWYuxCssb8XujIQNWx12e+XuNiqF1Uu4AlpOe9d22ivg0+hjT+ZHyNlV2e2DR/avhxFTYMPdP/JKM0GUoWuREsWt+4dXNRyPqY6Hpd5YjxUa7IjivgNQkCLZgT5W1AXMjdKpe1jFv+EPOCpZMllGVYEoMwHoXH4mUlHdL/YJhKgeWW/aqbHZwlT7H5oSZMGiMXhaNdZTxLP07v9cNdlJcefYqE7pC0uUtw/GVHb7suGjbH3g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3532563083767242BD10E2283830473E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5025f97f-af19-417c-a822-08d7307a33c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 14:22:50.9991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lsa8US7uJx8CZGQygL5lajHAEgUUJO4hCuslJ1QTKnh2qs7YCEJv/OZTyiCC60tz02LBL1QCfKfV36LEzYHIXKwf2cc5WVxxX7hbtQCRffA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2961
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::72d
Subject: Re: [Qemu-devel] [PATCH v7 0/6] Allow Valgrind checking all QEMU
 processes
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAzLzA5LzIwMTkgMTM6MDIsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDAxLjA5LjIw
MTkgdW0gMTM6NTMgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gSW4gdGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhlIFFFTVUgYmFzaCBpb3Rlc3RzLCBvbmx5IHFl
bXUtaW8NCj4+IHByb2Nlc3NlcyBtYXkgYmUgcnVuIHVuZGVyIHRoZSBWYWxncmluZCB3aXRoIHRo
ZSBzd2l0Y2ggJy12YWxncmluZCcuDQo+PiBMZXQncyBhbGxvdyB0aGUgY29tbW9uLnJjIGJhc2gg
c2NyaXB0IHJ1bm5pbmcgYWxsIG90aGVyIFFFTVUgcHJvY2Vzc2VzLA0KPj4gc3VjaCBhcyBxZW11
LWt2bSwgcWVtdS1pbWcsIHFlbXUtbmRiIGFuZCBxZW11LXZ4aHMsIHVuZGVyIHRoZSBWYWxncmlu
ZC4NCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byB0aGUgYmxvY2sgYnJhbmNoLg0KPiANCj4gS2V2
aW4NCj4gDQoNCktldmluIQ0KUGxlYXNlIHBvc3Rwb25lIHRoZSBwdWxsIHJlcXVlc3QhDQpUaGUg
bGFzdCBvcHRpbWl6YXRpb24gaW4gdGhlIHBhdGNoIDEvNiBicm9rZSB0aGUgbG9naWMgaW4gdGhl
IHBhdGNoIDIvMy4gDQpTbywgdGhlIHRlc3QgMDM5IGhhbmdzIHVuZGVyIHRoZSBWYWxncmluZCwg
YXMgaXQgd2FzLg0KVGhlIHBhdGNoIDIvNiBtdXN0IGJlIG9wdGltaXplZCB0b28uDQpJIGFtIGFi
b3V0IHRvIG1ha2UgYSBsaXR0bGUgY2hhbmdlIGluIHRoZSBwYXRjaCAyLzYgYW5kIHdpbGwgc2Vu
ZCB2OCANCnRvZGF5Li4uDQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpB
bmRyZXkgU2hpbmtldmljaA0K

