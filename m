Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C1C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7A4206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yrl2PgxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7A4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictHm-00081Y-IB
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ict8e-0005a4-4X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ict8b-0003Kx-PR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:33:55 -0500
Received: from mail-eopbgr80120.outbound.protection.outlook.com
 ([40.107.8.120]:7909 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ict8a-0003HC-99
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:33:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UutLvHh8xVknHsUPQoyZ7D+qk5pyo2D8eNnFFBQRjz9hZudO4UtFGR2ZH1loEgYc86GG5mYtjjKNNV8m0O08qzO3UQfxH8boEiNi8Tt9gGUVt3bEOp+fGvO7bPPbIG2LSHq5rd95+qXerO+04RrDKa/YWILUURUi12qZqd+FkNBMPa5CoUGn/THVPw2D6ylzhklB2Lbj9nXeSdwyN11EjNEukJfZL4jOXRHQqWXMRSIKzVQOgW4vDFDd2YKI2l+w4gfA3moJHiLS1AbLt5jgMX3xri57Ttn4f2ReFiAg43NNH/qBKGBHcjuwfjzqbVIUfrCWB26BxJPFQx3HO2aTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNaHGC5B4vt/YKevaqsmg08RhLf6QF4S9yXxBJviV94=;
 b=KyfLnCq0FjU+nHcjyCq/WLIq8fac4+L4L8WIDjPtIOoiNvPI+jA8H1W7WHWPv7NxFFf0v2UIe1UpmhL1Nv7Q0bgmdYZW0UzAi5359kFXqEZuNFikBksJlA1AgGhfenA9QXoameEkbtATL25soovq8a81h6cy87Xr/AIogMhdyulzqYcYb7rKLYUJ44E/9T847or8MQO7vtrVgcYOWnXVhBsYjS+MRf0OfbyI0s0h6YQFyENyrDfy8114YqmatBn8BW/aiHODJ8ik+Vg09PuqYKmk8Gmh4tM/+x34Y7AzeLmqYZ5N3XY1dw8fl3bSqOToPh8+bLW4H+hRJy2b17dllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNaHGC5B4vt/YKevaqsmg08RhLf6QF4S9yXxBJviV94=;
 b=Yrl2PgxYeZlvH3ltT6X+3gvOpPp98SnE9oXgxaZ2N4yJu9HYdldzBZf6/Y/udLNOH7XYxmcglFkq5e/1AytEpdQTghFNBJEn65mOkFCvJpvxHuG5z8M4gDHHxopeXsMmhF27xMDIuJgMZEPrPfRLAVwinNF/C5V03ZVerweuQfw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 15:33:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:33:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 07/21] tests: Clean up initialization of Error *err
 variables
Thread-Topic: [PATCH 07/21] tests: Clean up initialization of Error *err
 variables
Thread-Index: AQHVp7ZbqWTtZkQfwUyNSUfy/B/p36ers1cA
Date: Thu, 5 Dec 2019 15:33:48 +0000
Message-ID: <8b82d0a6-f72d-32a0-1b98-02508eae3c0e@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-8-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-8-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0235.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205183346817
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3005f2-6433-4fe8-59d0-08d779988615
x-ms-traffictypediagnostic: AM6PR08MB3797:
x-microsoft-antispam-prvs: <AM6PR08MB3797BCEDBEA8FB115D428CA4C15C0@AM6PR08MB3797.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(6486002)(36756003)(6512007)(14444005)(478600001)(31686004)(25786009)(110136005)(52116002)(71190400001)(316002)(76176011)(99286004)(2616005)(11346002)(6506007)(31696002)(71200400001)(86362001)(102836004)(186003)(229853002)(26005)(8936002)(66556008)(64756008)(66446008)(66476007)(66946007)(14454004)(81156014)(81166006)(8676002)(2906002)(558084003)(305945005)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02R+UcJtMNEMlIjaVihoxpYBkX8eA58xkCsJGKM6aVBkgx8LH83QdkYREQv371iHUiCERxVbywS7YP3FmEMTj4D/MR+UtwGd7Rmb3zABETs+R/hKqgdSTrWcJkkCJtQqIWsFStU2WgbeywFfdjt1XGL1dWntJxEvQnyAHs0FLaUOf31Zk3WfK4jWUi0SfBATq1SqNvEWUfe2zrQ+nKISSIk212wjKsomiw/swYRU4Ny1kY8x51G4yUk7zVj25Fjgd+V50HMXbuRLJatFdB1hA77OlnZluQ3Vzw2aGZu/vN0HdoJYxwYhzxVNOVES/WAB4qamK/MShIFfZQ6A8e0uOwuSF+DPdxPCr72nX6uKO4ZrfB2SeXWgS6dc+f1k2TEkujI+MqlTnAy/bycTeKg8IZKud4VAvHvo8kk451xZ3ccFytLpnoOqFt5rGc90rQFn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D648051E8563E4699AE9F53B58251A3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3005f2-6433-4fe8-59d0-08d779988615
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:33:48.8600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjHdaQ5X+Hk3EmqLQOUjzwr3HVLkRjsuKDPcM1Zt6ClqpYUPLcmKpaA1AIEQR/cEa3IxDI0aP4hJDBPaG2EvkQTLNcXKMRoMoF1eHolUYDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IERlY2xhcmluZyBh
IGxvY2FsIEVycm9yICplcnIgd2l0aG91dCBpbml0aWFsaXplciBsb29rcyBzdXNwaWNpb3VzLg0K
PiBGdXNlIHRoZSBkZWNsYXJhdGlvbiB3aXRoIHRoZSBpbml0aWFsaXphdGlvbiB0byBhdm9pZCB0
aGF0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRo
YXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

