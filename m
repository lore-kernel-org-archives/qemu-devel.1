Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C0FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF5322CF5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JM+/yPSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF5322CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3IZI-00069M-Gs
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 07:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3IYR-0005d3-Ez
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3IYO-00058X-94
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:25:26 -0400
Received: from mail-eopbgr130111.outbound.protection.outlook.com
 ([40.107.13.111]:17794 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3IYN-000557-Fn; Thu, 29 Aug 2019 07:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YefO8PeQBDczzEboJA/5S71UVlq57IVrVVYqkW4V5x2SDW38cA/Hw7Krb53PJY94MPQBe9sUTthN7J1KCHuPGbD7UY8jHNbBKfl9yFTqTvEcuB0I/Yq2RPgNL36aIPFu+Xu+3k8VRtxr8X2ih9ElPFu4b3ZO4T/o2Irs2VfVWqOoiesE1JWkAhk051zyK71Gq3lRtt7aTj05SadH8CAfejYJrhYuQE6CUGmnjX7klVGbz9Grvy5aAsthn2PmqTIruVYc0FwiCsyNhDzRVFsuTIdh7sKSrEl9Hy4ScYm1Ip4DkS1aVC/uqhPliTVsSbo4k6kUopNBXXRTPabkFKqd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB5GfEfuQWIbAYWcYQ4PcjRDbicMfF8ew5WB5zgZGIA=;
 b=TlQ4F0WmRl6/2rhrVXD3KRq//PNgC2be5GU6HAgWpjLyoIBh+euFKEayPlEzfz98I0q5k6z0KoDra+NYO62KC8S5Lf7m3YksFIc3W8Olv3aqbu2Ecn5HaymEX6wYOB04zwVRfM0uwbIF7Nz5KREXeqic/WxUi/axzYQtuvijax+Cio8DPUir4VVn4vQ5NxhnvMlEjpuZPBf+qrHiUzjRT7g4T5lE8doT8JFyxmjasuhpulNZamxKizyZrydRVDwpWxj2pTpUUUckJzznhRzo5nQfEnL1YNHmIF3Yy3wejabiz5S8MeEMLEjfuF53UjyzReTOV+dNyZHV1fmn9zLQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB5GfEfuQWIbAYWcYQ4PcjRDbicMfF8ew5WB5zgZGIA=;
 b=JM+/yPSS66V2i8Ui98N2l9ib0KXVNpO9uIzRwDnAqT30YPMRaJKcXszDKvtFpj1BIFaX7FQ3fhEhK43SD0Vu4Fq0PHqGurAknWqiDcjPokvlZ/U5bnE1uo/oiYbhPbkL5MSPL/Y7X5ZjvdvCeWU/pcHRUuEH2rPsG5jos9NkHwo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5369.eurprd08.prod.outlook.com (52.133.240.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 11:25:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 11:25:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 04/13] block/backup: adjust block-copy functions style
Thread-Index: AQHVXCkzVAUY9dLhiEmawx5hyMuUaacQvMsAgAFDwIA=
Date: Thu, 29 Aug 2019 11:25:20 +0000
Message-ID: <59ad84f2-9cc4-da8e-a61c-10474f10384d@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-5-vsementsov@virtuozzo.com>
 <985a9ae7-8dfd-a59d-0872-85b425100d8a@redhat.com>
In-Reply-To: <985a9ae7-8dfd-a59d-0872-85b425100d8a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:7:66::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829142517625
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c56e7f59-f6a9-47f9-d62e-08d72c739346
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5369; 
x-ms-traffictypediagnostic: DB8PR08MB5369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5369CB27740340AB4AEAD989C1A20@DB8PR08MB5369.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(39840400004)(376002)(199004)(189003)(256004)(316002)(64756008)(71200400001)(8676002)(66946007)(110136005)(66446008)(54906003)(99286004)(66556008)(71190400001)(66476007)(2906002)(7416002)(31686004)(2616005)(86362001)(102836004)(386003)(6506007)(53546011)(26005)(186003)(6116002)(3846002)(7736002)(81166006)(4326008)(81156014)(486006)(36756003)(5660300002)(2501003)(8936002)(25786009)(76176011)(446003)(52116002)(31696002)(11346002)(229853002)(6512007)(305945005)(478600001)(66066001)(6486002)(107886003)(6246003)(4744005)(14454004)(53936002)(476003)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5369;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AO0QYJkm0VR+WR+ELC5Ulv1r/JSorgmL/eFJPa98Xa4DQahV4WYMuj0h5L2RFrNaAuChXcM+J4D5/zi88XVT/TBHTs1OBBfM7h5qQIqMovSb1PEgCy6beCK2zZns/7MRwPNJV37G66nc5uWoBE4JMW43IXf9wHNfzGgYqlY1gENboHxR9kVk+8Z5Mj/gBWZLhFnF9zc5+9t1dY3W4fGaSi4R0GE4lQ5JrKHeoaKy+mw1AQ29v93lGFb5PganHA9FQKzqpnsWVV4uRKwxJoUT2Bc/maGX9E1RD4FCAyqcr7uGFxZ9ksU7MZsT3a167yCWKBGqZLO4bhQqwH4ZQlDnyrnuiDYKpX8XSqLBJpzaezFBUteOAxR4lWhAvqwvhg6WYj7IIQoMgo5JNGa4XhpR6mIDV9FQk1qy/GzRF71aCpo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E72790D7CE206C499506414008259CF5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56e7f59-f6a9-47f9-d62e-08d72c739346
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 11:25:20.1640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR/Jg/B/fqqg58sz51ACRhjDH6tW00eX0QgKMONmLU8bu/g3anW5LiakPWsKRGwWeFQiCLvW4CABoVBnMkYz9lfMKx9IxFaox/PzmDpKReM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.111
Subject: Re: [Qemu-devel] [PATCH v9 04/13] block/backup: adjust block-copy
 functions style
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAxOTowNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNi4wOC4xOSAxODoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEZpeCBjb21tZW50IHN0eWxl
IGFuZCByZWZsb3cgYXJndW1lbnRzIGluIHNhbWUgbWFubmVyIGxpa2UNCj4+IGJsb2NrX2NvcHlf
c3RhdGVfbmV3Lg0KPiANCj4gSSBsaWtlIHRoZSBjdXJyZW50IGZ1bmN0aW9uIGhlYWRlciBzdHls
ZSBiZXR0ZXIuDQo+IA0KDQpPSywgbm90IGNyaXRpY2FsIGF0IGFsbCBmb3IgbWUsIGxldCdzIGtl
ZXAgY3VycmVudC4gSSdsbCBpbnN0ZWFkIGZpeCBhbGwgY29tbWVudHMNCnN0eWxlIGhlcmUuDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

