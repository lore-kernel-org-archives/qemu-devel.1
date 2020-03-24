Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821CC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D23420658
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pWTtBl5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D23420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGfmr-0006NY-NH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGflw-0005ld-Oe
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGflv-0000bn-JP
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:22:56 -0400
Received: from mail-eopbgr80123.outbound.protection.outlook.com
 ([40.107.8.123]:64753 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGflr-0000Zi-Cj; Tue, 24 Mar 2020 05:22:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP0stFi9W0qggAQvtNTSYtiKYsboqOorxbjjfxeL53ZXKFMJlGNL64pM49idJhdTVI7hANXvpaXLFNHRtjHg5kS/Gw/F5mnK866YkhpNSwnVuT5bUuTroq/0hpK+dQ07fdfp6PWdcrVDUXia19ha9Qq11vmRYWjy4hsQIfezAb3Ki9uVRPEGNDhdbRr2/2PIcKvJQWwqskdwb43WXSIbXNk07pZ1KuX4H+uXi9Bj2os9aHo1tO/kakHzLAdZXoVHbOSpnGEoD7GzDeKimH30GKZjMwiNnflFZIUBJeVziFOn2us5eiLUEJ5fpmzbQGoFCB2hjmHjRaOutBC6ncs2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aU8E96j3swQKa+mCqL5RWB9mlYIzfW68kvT/0ZebbU=;
 b=VuikIwWa2VAARV1Gjh5ps7AvUMEX2G0/YKF+y9pQ2efpItP178qaiNRt35BVY1ARBphky+aRmUk01DClfPGctspqe5IE73rpy3PV26SIctyItlAKC2Mqad16if2iQwnrwC2kMsOpZqBydv4h1sa9HmKCllYm637wQJ4jzc6f8aEBi6HQwNko95VnZyZN58wMLmJy2PfDdEq3tDgL7EeEkxQnBDiBy3q/GFHkd4c6wThqd89x6RtGph1x0R/lPN9Xs9+0aTPmpraLBs68Iy+LfwiyGokt9vTIPFR54O+uQKbyWjnfmqlaLEKrxJxwdUBsKObE+GZcLDs4FedRmY/trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aU8E96j3swQKa+mCqL5RWB9mlYIzfW68kvT/0ZebbU=;
 b=pWTtBl5xu024Ws+z0msiLn/7zvSMQ90cIHd7+cGORk6eGKqKfrpr1OsQ1aLiLphZvrlNlLuQJYPRY38SbAcSfH3q77pKDgtYCinYpAGVGexPn/tgBOl2riBCZSIa9H+vWibf5drqXkm/Vb9fwzW4TMxKRLFl6HY1q2MawA1QJhM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5350.eurprd08.prod.outlook.com (10.255.191.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 09:22:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 09:22:49 +0000
Subject: Re: [PATCH 4/5] block/io: fix bdrv_co_do_pwrite_zeroes head
 calculation
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-5-vsementsov@virtuozzo.com>
 <67a739c0-61c2-2134-50d5-559ed5f3a7e0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324122246405
Message-ID: <2968733a-e559-5b4a-7f86-cbbd25080715@virtuozzo.com>
Date: Tue, 24 Mar 2020 12:22:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <67a739c0-61c2-2134-50d5-559ed5f3a7e0@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0341.eurprd05.prod.outlook.com
 (2603:10a6:7:92::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR05CA0341.eurprd05.prod.outlook.com (2603:10a6:7:92::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 09:22:48 +0000
X-Tagtoolbar-Keys: D20200324122246405
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a575b187-7bc7-455e-1618-08d7cfd4ebcd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB535044F8C3ADEF4DAB9C0047C1F10@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(366004)(136003)(376002)(346002)(316002)(186003)(31686004)(2616005)(478600001)(66476007)(956004)(6486002)(66556008)(81156014)(8676002)(5660300002)(2906002)(81166006)(66946007)(8936002)(26005)(16576012)(31696002)(16526019)(52116002)(36756003)(4326008)(86362001)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5350;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sp2uKKjF2AOO6kvzoVNG7Q9lcYtNHZ3GZn4ZE/+W+NDQmMcUzDn0joYrYuXSo2fDfdEQ1mvlwpfWJRbeQxj8lWNuw3jHHFzizkKFaGFhhOwVv3KHA0tyHnsTN7o6d40GLh3de858SPbNGHhERMf7sbuKZyPRWD1+wJPkE9xWja3S2AolG17Bue0aJul89PTYQtkkJXl4XoGSFvWtP10kjJQ901S/EPJM95WZMpiBQb9IpIsWz1KO6bGAql/nvBgOvv4ZvcXUbtXPvJ1rDaF5YU7sd5A986qkB0dDp0qejhQ2bV4Wi0MvbRuJJIhCd7EhurniRXQc/ZmpBX+efqu9SqZlU9/Gbe2w3mgcrQ8g5WVuMnVL1lKOjn02JG+Mb9at2VzJFb9zOjp8wGMfreuQvKqv0iMQPBqvfw70G0UR1uQM+jRFRuahnOYy0qA3EKu
X-MS-Exchange-AntiSpam-MessageData: ZYKhh+RIN02IIVfDQe9qdmSdtEYEC/pLOm22tCaNUMupeXAYKpzWu2jGsKz6CfMKSRPicwdRTXa3r8vc6PdsxcUlAp50UnziOBgJlkS1FgIt+ZprJ7N27dh3cSvkubE98fsWrhgZC5KX3f8bOnPRaQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a575b187-7bc7-455e-1618-08d7cfd4ebcd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 09:22:49.4169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC1RzrA1zrR5qLi3C5H0Slurb6tUBNn1LptgXtGphFnKBc3S0+Z9aQrrH1RHB1aPnY0VmHieDj1vN1mePAZvG22yHcZY90bTmsvX/u5jx8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.123
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.03.2020 0:47, Eric Blake wrote:
> On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It's wrong to update head using num in this place, as num may be
>> reduced during the iteration, and we'll have wrong head value on next
>> iteration.
>>
>> Instead update head at iteration end.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 block/io.c | 4 +++-
>> =A0 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> Offhand, I don't see how this fixes any bug....
> /me reads on
>=20
>>
>> diff --git a/block/io.c b/block/io.c
>> index 75fd5600c2..c64566b4cf 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1785,7 +1785,6 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(B=
lockDriverState *bs,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * convenience, limit this req=
uest to max_transfer even if
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * we don't need to fall back =
to writes.=A0 */
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num =3D MIN(MIN(bytes, max_trans=
fer), alignment - head);
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 head =3D (head + num) % alignment;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(num < max_write_zeroes);
>=20
> Here, we've asserted that if head was non-zero, num was already smaller t=
han max_write_zeroes.=A0 The rest of the loop does indeed have code that ap=
pears like it can reduce num, but that code is guarded:
>=20
>  =A0=A0=A0=A0=A0=A0=A0 /* limit request size */
>  =A0=A0=A0=A0=A0=A0=A0 if (num > max_write_zeroes) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num =3D max_write_zeroes;
>  =A0=A0=A0=A0=A0=A0=A0 }
> ...
>  =A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_F=
ALLBACK)) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Fall back to bounce buffer if write=
 zeroes is unsupported */
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BdrvRequestFlags write_flags =3D flags=
 & ~BDRV_REQ_ZERO_WRITE;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((flags & BDRV_REQ_FUA) &&
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(bs->supported_write_flag=
s & BDRV_REQ_FUA)) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* No need for bdrv_driver=
_pwrite() to do a fallback
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * flush on each chunk; =
use just one at the end */
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 write_flags &=3D ~BDRV_REQ=
_FUA;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 need_flush =3D true;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num =3D MIN(num, max_transfer);

Now I think that this is impossible. If we updated head above, than num is =
already less or equal to max_transfer, so is not updated by this line. Or d=
o I now miss something?

So, the patch may be good as refactoring but not really needed for 5.0.

>=20
> Oh. Now I see.=A0 If max_write_zeroes is > max_transfer, but we fall back=
 to a bounce buffer, it is indeed possible that a misaligned request that f=
orces fallbacks to writes may indeed require more than one write to get to =
the point where it is then using a buffer aligned to max_write_zeroes.
>=20
> Do we have an iotest provoking this, or is it theoretical?=A0 With an iot=
est, this one is material for 5.0 even if the rest of the series misses sof=
t freeze.
>=20
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (tail && num > alignment) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Shorten the request to the la=
st aligned sector.=A0 */
>> @@ -1844,6 +1843,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(B=
lockDriverState *bs,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 offset +=3D num;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes -=3D num;
>> +=A0=A0=A0=A0=A0=A0=A0 if (head) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 head =3D offset % alignment;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--=20
Best regards,
Vladimir

