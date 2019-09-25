Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114EC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB72F21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t/Ig+RKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB72F21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5nY-0002rH-Oe
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5kk-0000UF-Oe
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5kj-0003XE-Nd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:46:38 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com
 ([40.107.4.96]:36228 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD5ki-0003V2-CX; Wed, 25 Sep 2019 07:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXV1/vKqFZ8rPSIRfzszkSdVU53GDl/93fOxXKlD9HU0xMObF7cvZYOniC+cU0pC1u4dqgTBq3ZEItLzjEUaEUovca17LYol/LAjlJgT0cOVsVOWzhcrLbsDo9lQJZtBKkEj4ITd5tmVqE5U/De2BawnmExPbCJUK9BdwgEYyC2V3P0MXQlS2jskBmUVtMyLZYVehcAuiRkrLBUtymWOng0RYxNrgT3Vx74+/ztCkS6oV/ThYSJoObRZffaHsr6vp1vMOkAej898n6RAjjd2P/7wRfduU6uNJKbwIGw7SfIcR3V81mbVi2rl6MFKUL8YfdUDI4vtpm2m/Igxu+h24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daWoY9rybQBphIIqDOXo3sLWHmqfsZ0FBhJfNv6jB8c=;
 b=F3C+2VA3fweCu20RdoXOWSXVLZJLENTNcFRuZnow4MFwimtgS4bgOmkfMSxa0ESiqU9pYHVcUs2DOI1xIPOOKwSANplByDIMZGmYNqdTWU474ZM1wDo4tmGBawdviVQXgqK1B7KSC4NSSKgZ3jrRUa8akVvwkcgU2w60tOF3kLOs0+RELxs1o4ntVmCa6U1QbvSjRo21fFqTeI/HLEu3XTKP+CtFRsh2+DVDdjunBCq/6j3XSdp8uNCH3MA1oZBNckxZ9j6AhAWOfknAwCp7xYnvZ7G2tLb2wHBuEY3ZXvuCaBm4ITlJguJIg8Z05IGiOPNv02UE2AE+jMHouuLJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daWoY9rybQBphIIqDOXo3sLWHmqfsZ0FBhJfNv6jB8c=;
 b=t/Ig+RKZsq9xPjOkWNaFn3F2RF4rVufhOppH76MCqL+rww13czcvXFESQjj8eV6ncCcGaxeb4EVgY3Cww0ZSJFa21cKEnOCseijWaZJXeJVddBjCiGLIEzItvrO7XPPrb+fPNMQocNdzy+oChKhkf+yDiJLdxMOoJ4AmyQt9WM0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5066.eurprd08.prod.outlook.com (10.255.17.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 11:46:31 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:46:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 03/22] block: Drop bdrv_is_first_non_filter()
Thread-Topic: [PATCH 03/22] block: Drop bdrv_is_first_non_filter()
Thread-Index: AQHVb8i/rbhDvx+Buk+rHjts4NsxVqc8TiuA
Date: Wed, 25 Sep 2019 11:46:31 +0000
Message-ID: <2000d71e-8a08-48be-1909-a44ff4ad630c@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-4-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925144629082
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c36e2d4-64f9-4f1b-7673-08d741ae020b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5066; 
x-ms-traffictypediagnostic: DB8PR08MB5066:
x-microsoft-antispam-prvs: <DB8PR08MB50663C65E9BBA68174C01AABC1870@DB8PR08MB5066.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:353;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(396003)(136003)(39850400004)(346002)(376002)(366004)(189003)(199004)(7736002)(6512007)(14454004)(71200400001)(66066001)(2501003)(66446008)(25786009)(186003)(6246003)(305945005)(99286004)(446003)(3846002)(6116002)(66556008)(26005)(11346002)(478600001)(71190400001)(36756003)(8936002)(66476007)(64756008)(558084003)(81166006)(81156014)(256004)(31686004)(6436002)(66946007)(31696002)(2906002)(6486002)(5660300002)(476003)(54906003)(86362001)(102836004)(52116002)(2616005)(4326008)(229853002)(486006)(76176011)(8676002)(6506007)(386003)(316002)(110136005)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5066;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MkcRDvNG3lrUVDTfYCo/u9heZzuI2jbIldKbXygm8WwynvHEzCnOrxWwWBRcXiRoxy5UKUYTjbB8NuVuhdb0DJrqHRf3w7XRoia9tHmggRu2FCw5jW4txMrHKI21jycU/rgs6kVMQtafiJwxyRHV7RtL+uCB/2GrM/sX5SDVxZ1TTq/h5yv03klUKycjJw2Qx1I3pBC73qtW5LDZq2aFUyJPPbehuUnqhhuag3RthlBaEevlPiYsGEnL7GHpyAffe655dfW/Mz6vO2jGFFnLjegOd6LctDWJlZOFUeu/kM8B+gV1QPqFI2f/JKf459Oh/cCAN5f+TSmaPzoBrhWjUqLQPmsdmU57k0ar9gfhUej60P4mgRVl90rIJPEQ7ajHM/PLyGE27g228OSGAN+9FWJX8uH3iF9qix8DGVzM6HY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F4D0812133394DA9E5DCE1259E9497@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c36e2d4-64f9-4f1b-7673-08d741ae020b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:46:31.3227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6ppuiy3X0UeB8FVB8m1J4/oI01g/dfaJSxvWbVtpiNnxNF/KhThyUF98VEyDAOfqeMpKVEAYzfvEYHimhyG27a8Pjpwwe9trF0NjZeD0L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5066
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.96
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBJdCBpcyB1bnVzZWQgbm93LiAg
KEFuZCBpdCB3YXMgdWdseSBiZWNhdXNlIGl0IG5lZWRlZCB0byBleHBsb3JlIGFsbCBCRFMNCj4g
Y2hhaW5zIGZyb20gdGhlIHRvcC4pDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHo8bXJl
aXR6QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

