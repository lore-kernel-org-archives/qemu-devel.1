Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82455C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D00F23428
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LmD6tyhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D00F23428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lqZ-0006IP-DB
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lpK-0005F8-7K
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lpJ-0007Yw-9q
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:40:50 -0400
Received: from mail-eopbgr40101.outbound.protection.outlook.com
 ([40.107.4.101]:3077 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3lpF-0007XZ-EA; Fri, 30 Aug 2019 14:40:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr6PnjFYK25s5Ev1pf9SXDUAWy5NXwsQN+ivBp+DUj9ZIaTwmvUB/Mv4Hwt+TbEYs5HW82AfzSqbMgdRWmLI1cc9RqywlJajlObxzQWS9ukkj5qzUUUyDhbTa0FaUgPj6Cw3oTGsnpQ0GpFqnRjw3bd3sv01aJnPukgfiv4064ZcpdWXy/1K5EjQSVg3xR/PBhAyNxP0sAYLVw4npNAz6/8ODSgbvi3j1BgHjCc62EeM9DVhEOw6ffuNDGEgEV8AahISoM/udW8VYTOXgKWIyJe+KLInlzh5woFV4FUxHNEEiHryRrnJC9CVomSUyWYDYe/qyxKilWRg2ZenBwsErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iVSoOysQd9zQdlJwjdWCEaYDPSjnezO6MZ8TNuq0+g=;
 b=Hro/Mxe5XYp4qVmXRSlyr2PBYFIm35FzMLaEcCVquyaoylGWhRBMscuYNqRolLQHLojv/g7IP6OJcHpeSo04abzk9QixONpqkpSrs9C5d2Zuo6s026TqNa2chXFnylxxzBJbLLVlUuSPVSV8XOT/Fr1uV00KX9s+1sF8q5bEdvItLldfD6LQH8p3MvsDZk2GuMPYcOznO3/YIHe1Br7bTg4czbWWFh+fLPOtPkDcBLEUS2Yq9V/U5qsXw/xpUtHzKoKmC3RzgMD1hiBZW+yIL9FDHR6k1NVQAYM4RoY/Y+V0Ing0RWZHM5qVK0bGCG/xXRVJqWSxVW5SRN8zJl5mHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iVSoOysQd9zQdlJwjdWCEaYDPSjnezO6MZ8TNuq0+g=;
 b=LmD6tyhk7vs6ToXGZH0/IvG0q/SJhvx5YgqPdOAxSnXQ7VRX4fxsr8cScB4kz+lnL8K+0Qo+xS7agPuBazWKA9UB/6NBu4R3RdTYcVGl+p/ETtVD2SVNt7aIzZPJMX8sD1XbScwqxTcG1hCVfiCkQZ10UdWL3Iy1F/pZmyBD3nw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5145.eurprd08.prod.outlook.com (10.255.18.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 18:40:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:40:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 4/5] nbd: Implement server use of NBD
 FAST_ZERO
Thread-Index: AQHVWcHryXvzVKpm1EKM/5k0Yzo5DKcUEVQA
Date: Fri, 30 Aug 2019 18:40:42 +0000
Message-ID: <e01f047a-33c5-1fee-d335-c1e1ae04284c@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-5-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-5-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0049.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190830214040587
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81da1a65-0c0a-4947-40d7-08d72d798ffd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5145; 
x-ms-traffictypediagnostic: DB8PR08MB5145:
x-microsoft-antispam-prvs: <DB8PR08MB51458160732CEC510FE0C681C1BD0@DB8PR08MB5145.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(376002)(396003)(346002)(136003)(189003)(199004)(256004)(316002)(66946007)(4744005)(81156014)(2501003)(81166006)(31686004)(66446008)(14454004)(66556008)(8936002)(36756003)(66066001)(66476007)(64756008)(6116002)(6512007)(71190400001)(6436002)(110136005)(52116002)(71200400001)(5660300002)(476003)(486006)(6246003)(54906003)(76176011)(3846002)(4326008)(53936002)(102836004)(99286004)(229853002)(2906002)(478600001)(6486002)(86362001)(2616005)(446003)(11346002)(26005)(386003)(186003)(31696002)(7736002)(14444005)(8676002)(305945005)(6506007)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5145;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p6wTPYuEziLSNKPEGg+LtlNRwqpE4umVGE1sOTO3kvTOsqDVKoh7XZipLf/ppBawXhidamRyXbQBCEvGhE8NvwBIkGzawRMiAk2MVXIhTu69sYsi/40RZNKz3d7QMetKfYGRxLb6Mbr2g5lSfNd1wS1aiZv/VeiynV7iw3E7wdixmmrLm0hSmER5csRJ70YfOcXxqoE2I/L1W+i7BUKEsC9zFKJGBMw+evM48lEpChPzqjDe7H/bzfT7fflnmspKc2BlGKUxZcQrR7vJCHKqsPVZaPSbiRM1LnCOjdXWiwSWNBsj8BASUUu9CEe99h/7eKxstjBFA35TK7BjOUHPcPD8bU5o6GY2A2fIKh6g0MW1wBnoK+iyw/Mub7AQWeRuxjk0cp9LS7BNYo8Z7UuTkBgqkZsvg/b5bSngYbvA8eY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <65E0C72F1C53C24F9AA50D9478411356@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81da1a65-0c0a-4947-40d7-08d72d798ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:40:42.8407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtsZC0vp3/gN+0C34rKPvW99ig/cDDs5U7hhLMJcWDNIkDk2eUeoaNbbEW3KmEtxkiZctMSn6wMbd6u63dKe1PkvvJHOC+BGlrGR+z2V5ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.101
Subject: Re: [Qemu-devel] [PATCH 4/5] nbd: Implement server use of NBD
 FAST_ZERO
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
Cc: "libguestfs@redhat.com" <libguestfs@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gVGhlIHNlcnZlciBzaWRlIGlz
IGZhaXJseSBzdHJhaWdodGZvcndhcmQ6IHdlIGNhbiBhbHdheXMgYWR2ZXJ0aXNlDQo+IHN1cHBv
cnQgZm9yIGRldGVjdGlvbiBvZiBmYXN0IHplcm8sIGFuZCBpbXBsZW1lbnQgaXQgYnkgbWFwcGlu
ZyB0aGUNCj4gcmVxdWVzdCB0byB0aGUgYmxvY2sgbGF5ZXIgQkRSVl9SRVFfTk9fRkFMTEJBQ0su
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlPGVibGFrZUByZWRoYXQuY29tPg0KDQpS
ZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0
dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

