Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4727217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TlEjVI1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4727217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZZv-0000u8-Am
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZYD-0007yR-Gl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZY9-00029Q-6c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:05:16 -0500
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:22595 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itZY8-00028E-Dx; Mon, 20 Jan 2020 11:05:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1vUTVM5oJ0ryKSn7hVXK3yvYAvONiI6/rwkzJaCIjrbNRwN8/YQfGRnnm0pUe7ISeSCHai26pxAWd7NcMvsPBzS2r+QzJNbOV7IWW5X9MyBX15j12PoXS9PAgbjpiQYKON1vBzsifStgjPsBZfhkPJF+S4oVw0bJRANP6mnGoydPTmQVZr/xeyJteph+uyGaAtsQ53BA2ESvWN8e8veNfr6CG2r0fVMeoWatQuXdOLy8bWbbg0SWqd0vu6jKdpoHMrfkvrEjPPZrLpztVReJOMCnp4F4W+2rByfgYqWVc1Od6+V9sa03STBuuQxsNyZ/Hby7nAtHO8YniMhUKMmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZQAKmwg6fgKYwxteGEvfj8Dyi4kooul4BXhT8fPjVU=;
 b=LF56ppLo+80kzTGV5hgLKBkmWQRZ0w5orXTjLRABaISb6k3XIU4viz/XCVumogPm9tQTLT86/jy8X8J2IXh/5ScEbGwCDmkK9HFjPlXTS0S+RqvvlKVz5uF3i08b5gipXOuMeh98IbNGJLWTHmdef3kkIHWSJlShWF0FSTmcZOxmcB4DtofL/NrK5wNdsnF9AZFcSYYamsKsIZUvFI50n1fmvtiDdBYW7ThK0UhXOBe8gpLqdAJnkv4p5xedd/HinjAjhiRAhik+DUrh0PHGZhRixCwo57dO2m8Fkbg9IvrS+t0em2nBe/BmlNuDP0mq9p5jCpT6s010hTMBINEhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZQAKmwg6fgKYwxteGEvfj8Dyi4kooul4BXhT8fPjVU=;
 b=TlEjVI1t41JAo7MVt/klYDmT54JGh99zNRvmA4ZOglRnbF7hmGoDJr6yzsew3CH3AA/disRvr/xCNjDcBJOvZw4g+sZzQeFfWQVPOIZCeCErYbfpQOw2H7F+EoxqaIUvL2TqILYyBjmbPgFqep2G3ep5eJNH/wjhR700W7z7Ubk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4088.eurprd08.prod.outlook.com (20.179.2.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Mon, 20 Jan 2020 16:05:10 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:05:10 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 16:05:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 10/10] block/qcow2-bitmap: use
 bdrv_dirty_bitmap_next_dirty
Thread-Topic: [PATCH v3 10/10] block/qcow2-bitmap: use
 bdrv_dirty_bitmap_next_dirty
Thread-Index: AQHVtlOhvcaeV5Say0ur9RDAvfGtBafzzE+AgAAdzwA=
Date: Mon, 20 Jan 2020 16:05:09 +0000
Message-ID: <9c4c4489-ead1-3587-7f71-ad1d2aa2b9e6@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-11-vsementsov@virtuozzo.com>
 <fcdd14da-b273-a71c-c6f8-f7c8ac3e2bd5@redhat.com>
In-Reply-To: <fcdd14da-b273-a71c-c6f8-f7c8ac3e2bd5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120190508027
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 149a543a-496e-4aa6-e445-08d79dc28620
x-ms-traffictypediagnostic: AM6PR08MB4088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4088AF8F86BF4777470636FFC1320@AM6PR08MB4088.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:143;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(39840400004)(366004)(346002)(189003)(199004)(36756003)(81156014)(81166006)(64756008)(66446008)(4326008)(316002)(16576012)(16526019)(54906003)(110136005)(186003)(66556008)(53546011)(66946007)(66476007)(26005)(8936002)(478600001)(2906002)(6486002)(31696002)(5660300002)(31686004)(71200400001)(4744005)(8676002)(52116002)(107886003)(956004)(86362001)(2616005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4088;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kRg9gLr+lqSZfLs8AcW4R8IbRaf56UVcZKzrZ6VmWcwhy0JW4p97Q25e6+G2RpSUItp7AM2GR4I73i6rcrsnYFqfbjD8XyXVx0x3ALBUFovMYM5IlIKdLXoUnlZy/BMj8gqcF9URqyyMLJyPgiPFrRd6NaBIOUAANKb/yIH6VGqwjjbT8ed7bkvVCRNUqp8LNNK/hKtbVvzQziWlTMU/wKWdScFWjPSaajj/ib5rjzyxCkAiKuCt5PsyTSlahVtFSZtuy9jn/xa+wlx0PhdmC6cM8Z8hGTJQKFUvISvrOJQgPNP7aQOshoV5pIDyLmCD0NZJcvSfD3SSfGJ9G7noOxgDR8F9sBBNvFJ0Hkm7kP11BiZmHtooa/5XxrE1zEjZOML0z+MNjX/6xYXh110gq1lzw4S/lndqjuJbC2JZAzchBHqjMprNiWgC1gHcXJcQodLtNSD/QQHstt2pbruM9sQvWMlkT/uhQLIXxFwL/C/Pk/Bz1nS5c2E27OyUL68p
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E1816918FFF2B742B257A64BF0B47FB5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149a543a-496e-4aa6-e445-08d79dc28620
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:05:09.8931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49XvFWvPJf6RAE5xJoauU7R2UNpzfPiVmqgTrza23EqOj7fS82EmwYjqYg39tOoSzHTLX1TPEm/MjVipehkuhtfj7rmb9gOYMiaRl6/qTCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4088
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.101
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 17:18, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> store_bitmap_data() loop does bdrv_set_dirty_iter() on each iteration,
>> which means that we actually don't need iterator itself and we can use
>> simpler bitmap API.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2-bitmap.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index c6c8ebbe89..015f5d18d2 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>=20
> [...]
>=20
>> @@ -1360,19 +1361,17 @@ static uint64_t *store_bitmap_data(BlockDriverSt=
ate *bs,
>=20
> (One line more context:)
>=20
>>           if (end >=3D bm_size)
>>               break;
>>           }
>=20
> Can we drop this now?

Yes, we can, as hbitmap_next_dirty returns -1 in this case.

>=20
> If so, and with that done:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>>  =20
>> -        bdrv_set_dirty_iter(dbi, end);
>> +        offset =3D end;
>>       }
>=20


--=20
Best regards,
Vladimir

