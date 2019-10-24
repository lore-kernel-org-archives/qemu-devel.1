Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E33CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6A021925
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PS2PBUGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6A021925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdvy-0001GI-Bc
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNclj-0007D7-7F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNclh-0003ht-Kr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:03:11 -0400
Received: from mail-eopbgr140125.outbound.protection.outlook.com
 ([40.107.14.125]:57347 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNcle-0003fz-0r; Thu, 24 Oct 2019 09:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMrDAtqfv1/Tdcz159SEwX0Ph28Iw74Tc4vpe49dol6pjUjuMEK8ROfjmwjFXU0jrp57xDNoAMdK/PpnCGYw4PlcybJgyBgR818iv70MoMTjsbekKCvb+awRsup9rzzVdH+vk0RLgdVZeZqQSKYHmm8jd/QcSxJfC5j8u6XNpaJrKudzYSSUdB8tkg1muq8+rMRI7ePtzMDI6d6kGOLnS8uU5e8kRZWISef1/YDQSYdHg+K6YvL5CoXk9iYsPjAJ1xsKdVlrUJeDDri0Freh48kSObxFwxrX/BzLSIeR4RJ1tZqzXrGDOC2AxpdqonP1YfWPEP03qu5IaKSWtpHIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yacGPRWU9MYLS0+/J7IaAQDZemZcXVpU+7TOHacuQ9k=;
 b=Ix1z9St+m1SHqcwm0X0t3AHfkIOAGuoR7dXv8zyKI6p0v+UYY5OXMBYy+zarKyL0+Y27F5IktkbTvdBcIWfoa++NhR8KqFZu1MuSGT7jf1EBP+69hLmW37Exiex4x/UqqtS92xmXLe0fI1AjzI59zT/m5JM0tbaBGvoTGAMd3I7TFzgxxPhUoMsW+RUSXXX0vcDckNIxRFCB4vgjv18j16yMtrK33OWyd7UjByUuTswXd5Z9qZ5cd5XCrC9sDoWy1E8yJUdSQAUpgpCHOrTFPZPNtieifGjrwn8xpbSyf/Zpd0rHcvO+HxoCZm3+jHKYQNBLR/GvylJNjs/p1kw6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yacGPRWU9MYLS0+/J7IaAQDZemZcXVpU+7TOHacuQ9k=;
 b=PS2PBUGTtYU4g/fWfhrpe5TaQoaHQ9KCMf1GQsd0FssTcGFsUUETbY0FKWVabFNJp9xCPdy9GjyAnjOZ5i6Rk8Kq8yW7aox3qn+l5SFGxumARfgi5o6pnomm+rmNZJesWimBIPbJK8BOIhfYhU719ykwo4AUAn7iQMjHNm2q8ZQ=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3938.eurprd08.prod.outlook.com (20.178.117.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 13:03:03 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 13:03:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Thread-Topic: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Thread-Index: AQHVibZR6fc2tpZq4EaFSnKTSW5YwadpkIYAgAAPyQCAACL/gA==
Date: Thu, 24 Oct 2019 13:03:03 +0000
Message-ID: <a27c197e-c73f-e92f-8e28-1422cf313507@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-3-kwolf@redhat.com>
 <3600fb84-e1f1-c70a-4b83-e7a379f50614@virtuozzo.com>
 <20191024105746.GB6200@linux.fritz.box>
In-Reply-To: <20191024105746.GB6200@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0046.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::35)
 To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191024160301695
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c723b30-b9da-455a-f8eb-08d758828157
x-ms-traffictypediagnostic: AM0PR08MB3938:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB393849EF0F64F261BA07CBECC16A0@AM0PR08MB3938.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(7736002)(386003)(6246003)(6506007)(305945005)(99286004)(53546011)(3846002)(6116002)(6512007)(52116002)(6306002)(966005)(14454004)(478600001)(6636002)(66066001)(31686004)(76176011)(2906002)(6436002)(229853002)(6486002)(316002)(81156014)(81166006)(31696002)(54906003)(8676002)(86362001)(4326008)(8936002)(110136005)(186003)(476003)(2616005)(5660300002)(11346002)(446003)(14444005)(256004)(486006)(71200400001)(66446008)(71190400001)(36756003)(64756008)(66946007)(26005)(25786009)(66556008)(66476007)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3938;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwqgKLgDxWJuYcDGhn9RFnZLODKVVxcxaqd7ph8XLn+SNy1EZQCg2sihuyb2CJpT43IMWzoEjMO7QxmkSjihmD2Ds6KefgMxaRt3kfw3NZMF9u2ZH7qWegaScxcbNmCjPuXMy9zpaB8sBaq0Bdy94uuzCOtSA7VARIUwDsSCPSVycTFdxVLXgXHqb/AYEfQZXjbC8nTAeQocNUEYs9u5BdqdmoLsVjA+9MHJ4IFXPUhuEAVPxZnyqhdjwuvb7Vnjozyk7NbCffI/CShrxjuX976nH+xFs/vdi4qKQEvTDD4f2f/UbSu0cMweH5BwLFKe37Jw+2RhkceXEJnDxCq80nStRbjpzEWPnlRzy3TgvW+r/JP4ZJBTq6xY1NV3dqgJ6u1b08spXgpqf9pjs/Ht60JdBxe3FnsdYyFtPNLc9sjd2uBKqOzlW6AqX6W6iR89UryMsADfpfzNzQJxr0YNsXbHBtgo6sbmSv728mFAVHs=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F86B32CDA1C3DD4A8D33EEDC204A3BBD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c723b30-b9da-455a-f8eb-08d758828157
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 13:03:03.6812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fi1pT88BCs/Uysd6NQskiFjknn0LVSsmtlu1SVF+eTUKVFoz5cS6NABUFCku0VzuQdub6jHwIeTSte4cI+WgWSNjXmSis8Ix4XoDOplGc9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3938
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.125
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.10.2019 13:57, Kevin Wolf wrote:
> Am 24.10.2019 um 12:01 hat Denis Lunev geschrieben:
>> On 10/23/19 6:26 PM, Kevin Wolf wrote:
>>> qcow2_cache_do_get() requires that s->lock is locked because it can
>>> yield between picking a cache entry and actually taking ownership of it
>>> by setting offset and increasing the reference count.
>>>
>>> Add an assertion to make sure the caller really holds the lock. The
>>> function can be called outside of coroutine context, where bdrv_pread
>>> and flushes become synchronous operations. The lock cannot and need not
>>> be taken in this case.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>   block/qcow2-cache.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
>>> index d29b038a67..75b13dad99 100644
>>> --- a/block/qcow2-cache.c
>>> +++ b/block/qcow2-cache.c
>>> @@ -327,6 +327,9 @@ static int qcow2_cache_do_get(BlockDriverState *bs,=
 Qcow2Cache *c,
>>>       int min_lru_index =3D -1;
>>>  =20
>>>       assert(offset !=3D 0);
>>> +    if (qemu_in_coroutine()) {
>>> +        qemu_co_mutex_assert_locked(&s->lock);
>>> +    }
>>
>> that is looking not good to me. If this is really requires lock, we shou=
ld
>> check for the lock always. In the other hand we could face missed
>> lock out of coroutine.
>=20
> As the commit message explains, outside of coroutine context, we can't
> yield and bdrv_pread and bdrv_flush become synchronous operations
> instead, so there is nothing else that we need to protect against.
>=20

Recently we discussed similar problems about block-dirty-bitmap-* qmp comma=
nds,
which wanted to update qcow2 metadata about bitmaps from non-coroutine cont=
ext.
"qcow2 lock"
<135df452-397a-30bb-7518-2184fa5971aa@virtuozzo.com>
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01419.html

And, as I understand, the correct way is to convert to coroutine and lock m=
utex
appropriately. Or we want to lock aio context and to be in drained section =
to
avoid parallel requests accessing critical section. Should we assert such
conditions in case of !qemu_in_coroutine() ?

--
Final commit to fix bug about bitmaps:

commit d2c3080e41fd2c9bc36c996cc9d33804462ba803
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Fri Sep 20 11:25:43 2019 +0300

     block/qcow2: proper locking on bitmap add/remove paths




--=20
Best regards,
Vladimir

