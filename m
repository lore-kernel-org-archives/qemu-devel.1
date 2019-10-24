Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C2D20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MBlCA0DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C2D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbRU-0001OU-J6
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNb1R-0008GC-JS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNb1Q-0000ty-GI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:11:17 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com
 ([40.107.1.99]:36755 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iNb1F-0000hy-Au; Thu, 24 Oct 2019 07:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4LyLjDPUCdwLcpN9nW1fmiSdN60dJadBvKSstUQfNAoynGbEKjsJrTLAdPUb1bZP3xIyhKDdTnsgNnk1ff4Tv+nlBax+DdnwdK6q156AXRpAtKzUsaOZ+7xFXITWZUM+fIWOTtO+Tpx8FYyS6MXG/7bzpbqsns5NGyaONL0w5zsCWTA6ULKiBRGkXmyov0YsYmibLJXOTAZTE+H5vh8rcCwlm9joLnV2ezh0SO+rEUVkumemFYQUtVRA1P7Yis7dMtT/PGQwyyu3Tpr+u0pEc/g50SJ4HYJO+D48zNzH7CDc2poTMSaf1vsn8WYH0H2SOWPXlF3HklfIK/MXq0EGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEQfNH3h2tnJ+aR7GrAkDszx8iRVY97MhZ8IYvXqP/M=;
 b=WHt6eMdys2yoEZLg7y1OT7Xbkxd89IreAkXSONGti5FCxgwFIpzSeC4+OpuU/2pL8gLChn6cvUzzhX0R3WldsK9SGSD2/syABxTze7BaPA3teZrNgltzHGGxC1Zh9Z2RumOz8EvGN5lMjzwH790oH0r+bYaZUBERE9d0bqhAmu9ftQ/15YH+4Wm1RIkr6Hui7yyoQeyJqIHqSFMbbLH20AAMKFLeFapdKJN9d+DQ8XS07KBDDv3PTKcoy0a00FoCPjFrwieEvkQbeoWaXFpWaSTGbPIkkHOwk3Ww6lKF/h+TsjIvoYAe/MupGkJrCYrjF5scx8/4vkFtPZV+VJPJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEQfNH3h2tnJ+aR7GrAkDszx8iRVY97MhZ8IYvXqP/M=;
 b=MBlCA0DUqeeOc+XQD7P3EiVBV6l5tGrgsYFCNN7FZKnYK6Uvn5tx3TFYDuAd2X6W2op1hX+1GCPdOmhQUNGdsjTCnEVdY9+4fefPFMlTokdl9t7vP8IlDstURzbKgOW8vXGnFl5OzJT+kbYK8DnPvZhw/sPAo0NIaVOBdGqNmmw=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB1685.eurprd08.prod.outlook.com (10.169.225.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 11:11:02 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 11:11:02 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/3] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Topic: [PATCH 1/3] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Index: AQHVibZNfmcmX5bV50OrRXkOJjjwradpwjeA///dGICAAASxgA==
Date: Thu, 24 Oct 2019 11:11:02 +0000
Message-ID: <e73b225e-f44b-de40-34fa-bb58495c1141@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-2-kwolf@redhat.com>
 <173e0a00-34e3-522a-4e9b-a33661e3f5ba@virtuozzo.com>
 <20191024105411.GA6200@linux.fritz.box>
In-Reply-To: <20191024105411.GA6200@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0265.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::17) To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9462717a-0cc1-48e6-8c39-08d75872dade
x-ms-traffictypediagnostic: DB6PR0801MB1685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB168521977838F4BE711C1C27B66A0@DB6PR0801MB1685.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39840400004)(346002)(376002)(189003)(199004)(51444003)(86362001)(8936002)(2906002)(99286004)(486006)(476003)(2616005)(11346002)(446003)(66446008)(6512007)(66476007)(66556008)(64756008)(25786009)(66946007)(6246003)(31696002)(8676002)(71200400001)(71190400001)(6486002)(386003)(81156014)(76176011)(52116002)(81166006)(53546011)(6506007)(36756003)(6436002)(14454004)(305945005)(229853002)(54906003)(316002)(7736002)(3846002)(5660300002)(6116002)(66066001)(256004)(14444005)(186003)(6916009)(4326008)(102836004)(26005)(31686004)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB1685;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIonf850ne/fhOvrz6PNGU5eSdOoyUpJccELfalpBbQIMb1hjx7G3b7OTm0aIa9JQ0+PcZohU3C8LfuwywMhq6A9WDLWfgg7FUDHEaSzzUGO/FWGeVIhBATF0CUQyx0h/z2oeAb3jvSANuvzUf19b/jcj+s8bMwH7HEqjzkNt61m+w3Z/vgO8twwncRGBKvE0B/JWDtoOWdnCVVjnZ/K1ySd1YOYiVzUKtOvunCWn/ckIeIEzoWemtLfrZW/RtJ8eBSJ5PI0fKNCEuLXWmsqG5CAEU+wwATjnWZe9+04Kng17WzOGu2f9m6JeZj0CkzcII1FH+awhpL3KS+H3u6m67MYKNFZqXlNca1ux9LBhk3q6zka9TKGV9u8N/4ktIkmMmkb8OyhW+w7107biW7lIpLIQpizusd0cr7/t0jssC9xeO2qwrkJmeNpMXbi0G0Q
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D7F9ECD226617349B9427F0689F26954@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9462717a-0cc1-48e6-8c39-08d75872dade
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 11:11:02.0508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07hg6gvOZaBRk8GTmFMyag/kAboI4ifCycS7Kt9bp4Xr5ymWhfURBcxHUi0HoIrB/RfhuygZyKKEkc12/1R4QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1685
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.99
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 1:54 PM, Kevin Wolf wrote:
> Am 24.10.2019 um 11:59 hat Denis Lunev geschrieben:
>> On 10/23/19 6:26 PM, Kevin Wolf wrote:
>>> Some functions require that the caller holds a certain CoMutex for them
>>> to operate correctly. Add a function so that they can assert the lock i=
s
>>> really held.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/qemu/coroutine.h | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
>>> index 9801e7f5a4..a36bcfe5c8 100644
>>> --- a/include/qemu/coroutine.h
>>> +++ b/include/qemu/coroutine.h
>>> @@ -167,6 +167,13 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mute=
x);
>>>   */
>>>  void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
>>> =20
>>> +/**
>>> + * Assert that the current coroutine holds @mutex.
>>> + */
>>> +static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *m=
utex)
>>> +{
>>> +    assert(mutex->locked && mutex->holder =3D=3D qemu_coroutine_self()=
);
>>> +}
>>> =20
>>>  /**
>>>   * CoQueues are a mechanism to queue coroutines in order to continue e=
xecuting
>> I think that we should use atomic_read(&mutex->locked) and require barri=
ers
>> working with holder.
> Hm, this would only be necessary for the case that the assertion doesn't
> hold true. I'll do the atomic_read() because it's easy enough, but I
> don't think we need or want barriers here. If another thread modifies
> this concurrently, the condition is false either way.
>
> Kevin
>
It looks like you are correct. We will see either NULL or something other
if we are in the process of lock taking. Does this worth a comment? :)

Den

