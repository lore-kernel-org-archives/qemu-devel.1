Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ACD2176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nwfa5QFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ACD2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagrC-0001db-II
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iagkB-0006ui-7K
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iagk4-00018f-GL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:55:32 -0500
Received: from mail-he1eur02on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::707]:55938
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iagk2-0000hD-Hu; Fri, 29 Nov 2019 08:55:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAnF2k8RAHQtTBLPg1FOtqi7mW/VNBld9konkf9vwOtyMqsPDCe5qeTN8+5svRUqp/yMgLz5n3f1Q3Azkbc/h59AdMFJwkN+HmUr4Y9iDrIif92Bs16wqDaQM6oqX7kT4hK50VOiMbKHW0qg1HU9BFqhQ08gtljCdLzrgpc2JhROM6Ypm5vxNYZuwsOXVU/TO6yTGubOhSBtuwBYoQXIOVwth8Y9DHJji5Y74Hltf7/W+HML/9rqPbMKalA6KA+MunwUsTlstU3a48J79Mc+WSUtyYKZr8xR5UtnCZLbY46rx1Vt0XeY118sATs1ObYkH38eCZLhRW8gyQTQdTFphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33LbCLJ26cb9mYd6B4xaMEJTAt2Cl8UgsjpebNhLvh0=;
 b=BNdRk5K+5JYzS6gKMlH2WSPUfXdrZ1M7pebtwW5jwpRccIzGZ+pVroEad3g8Hz9TeY/Dtr60cHjzT9GMEaQ9jS0qn2sIojzEiIlZBcck8gqs1xw6xH8sNMy1iA6h1/2PThFfza8fXssy+J24GmAcPLjkZXisQpRzhBHq4xORWa2StxVd231bcZiVtm0nDdrtbIXz9R9poUKSSLAnmwvCT+wYRZE+SBGcYFf/S78wM6Y/Gq56zcSfhqjusUPzwq5X+vkNvpmI+LevjlOG23q3FGvwo3ZzAE4a0S8zR3qT/C5YXt6HjfJw9bqXCSYIGIRaoqvu1a5lSmUnJM3obxARVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33LbCLJ26cb9mYd6B4xaMEJTAt2Cl8UgsjpebNhLvh0=;
 b=nwfa5QFnuiZfiB2lKPX8ns2kKvEPEuF83guybCncVQOq7+N6pp7/oSw7WUn32X5P2M+hpgYfU2WfnYKpptK+yRB+1hzamta6Z3xn+CANk+VRTPYY5IBmNjefgqf8qJScq2pw8QbqamAKm0iDM47Ex0F7keIcelrxjymg02TUKIo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3877.eurprd08.prod.outlook.com (20.178.89.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Fri, 29 Nov 2019 13:55:19 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 13:55:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Topic: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Index: AQHVmKmF9vX+IDkOrkmVWASxqmj2taeiKDmAgAAdTYCAAAJpgA==
Date: Fri, 29 Nov 2019 13:55:19 +0000
Message-ID: <c85c5101-2b88-5fb7-1d32-09261646b57c@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <2c47c1be-e633-c769-88fe-684fe1ebe80f@virtuozzo.com>
 <88baa19f-1433-178e-33eb-16c275dec909@redhat.com>
In-Reply-To: <88baa19f-1433-178e-33eb-16c275dec909@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129165517685
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e506d495-139d-4429-ff89-08d774d3c557
x-ms-traffictypediagnostic: AM6PR08MB3877:
x-microsoft-antispam-prvs: <AM6PR08MB387713EE99677A1215D2E8D5C1460@AM6PR08MB3877.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(39840400004)(376002)(136003)(199004)(189003)(66446008)(66556008)(64756008)(66476007)(102836004)(386003)(66946007)(6506007)(478600001)(6116002)(305945005)(7736002)(25786009)(3846002)(8936002)(446003)(53546011)(11346002)(2616005)(4326008)(6246003)(316002)(110136005)(8676002)(54906003)(81156014)(81166006)(99286004)(6486002)(14454004)(229853002)(86362001)(256004)(31696002)(31686004)(66066001)(6436002)(76176011)(52116002)(36756003)(5660300002)(2906002)(186003)(26005)(2501003)(6512007)(71190400001)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3877;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/7NGtfCXC8KF3T/qAONEYHVB2wEHC62cj3jAcM3fA9WRqK3pUrJyOqgWARWPtKm5aNdF8B2eilCAK1xxiQCIIKUx4mv2BoUg+UHGlccZMzL0/+cATq8C+kMtvt1QqJwhkIqCuAB+4FgoKtflsw/LeoCi7JrBAm1EhXCgd2tk80J0FiV2nS0MdX30MXXSXMwe2RBkKnNdx4wKGiPsWWyXCDBjDtmhla4GHOnlO+1e4bGv1F4JhYbS0Qx+xEQyoceZCkEzt+tTm9t6Rkq7zC89U7piR50aTLfxo82RQ4yO2hGuGKAdGcn022BoaYEjyB2QeRLQESYxG1rTL4sZoOrwuFqziDhFDf8nadIa65gEDeugZgl9Da55PVIQ3Cc03kZ6Wep/NqX/ieFD85T8/tNQHjTZWuGnLHVOD7WX4RW6brH8tIHQhAs5337cz/bM2W1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EAE7A5691D122D4089919DE51E882036@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e506d495-139d-4429-ff89-08d774d3c557
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 13:55:19.5553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V29ZvCwpbosqRY/fpbBsLCXhiU3r+ZYsOILQcOjOCLS5HO8nRW/P+rDGj7VkUf3UEiGW9332UMyzqKzrZqjzSUMrhjewqZ86gl1kojsIGDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3877
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::707
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

29.11.2019 16:46, Max Reitz wrote:
> On 29.11.19 13:01, Vladimir Sementsov-Ogievskiy wrote:
>> 11.11.2019 19:02, Max Reitz wrote:
>>> While bdrv_replace_node() will not follow through with it, a specific
>>> @replaces asks the mirror job to create a loop.
>>>
>>> For example, say both the source and the target share a child where the
>>> source is a filter; by letting @replaces point to the common child, you
>>> ask for a loop.
>>>
>>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must poi=
nt
>>> to a child of the source, and sync=3Dnone makes the source the backing
>>> file of the target after the job).
>>>
>>> bdrv_replace_node() will not create those loops, but by doing so, it
>>> ignores the user-requested configuration, which is not ideally either.
>>> (In the first example above, the target's child will remain what it was=
,
>>> which may still be reasonable.  But in the second example, the target
>>> will just not become a child of the source, which is precisely what was
>>> requested with @replaces.)
>>>
>>> So prevent such configurations, both before the job, and before it
>>> actually completes.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block.c                   | 30 ++++++++++++++++++++++++
>>>    block/mirror.c            | 19 +++++++++++++++-
>>>    blockdev.c                | 48 +++++++++++++++++++++++++++++++++++++=
+-
>>>    include/block/block_int.h |  3 +++
>>>    4 files changed, 98 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block.c b/block.c
>>> index 0159f8e510..e3922a0474 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -6259,6 +6259,36 @@ out:
>>>        return to_replace_bs;
>>>    }
>>>   =20
>>> +/*
>>> + * Return true iff @child is a (recursive) child of @parent, with at
>>> + * least @min_level edges between them.
>>> + *
>>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  For
>>> + * @min_level =3D=3D 1, @child needs to be at least a real child; for
>>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and so =
on.)
>>> + */
>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *paren=
t,
>>> +                      int min_level)
>>> +{
>>> +    BdrvChild *c;
>>> +
>>> +    if (child =3D=3D parent && min_level <=3D 0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    if (!parent) {
>>> +        return false;
>>> +    }
>>> +
>>> +    QLIST_FOREACH(c, &parent->children, next) {
>>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>    /**
>>>     * Iterates through the list of runtime option keys that are said to
>>>     * be "strong" for a BDS.  An option is called "strong" if it change=
s
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 68a4404666..b258c7e98b 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>>             * there.
>>>             */
>>>            if (bdrv_recurse_can_replace(src, to_replace)) {
>>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>>> +            /*
>>> +             * It is OK for @to_replace to be an immediate child of
>>> +             * @target_bs, because that is what happens with
>>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target_=
bs's
>>> +             * backing file will be the source node, which is also
>>> +             * to_replace (by default).
>>> +             * bdrv_replace_node() handles this case by not letting
>>> +             * target_bs->backing point to itself, but to the source
>>> +             * still.
>>> +             */
>>
>> Hmm.. So, we want the following valid case:
>>
>> (other parents of source) ----> source =3D to_replace <--- backing --- t=
arget
>>
>> becomes
>>
>> (other parents of source) ----> target --- backing ---> source
>>
>> But it seems for me, that the following is not less valid:
>>
>> (other parents of source) ----> source =3D to_replace <--- backing --- X=
 <--- backing --- target
>>
>> becomes
>>
>> (other parents of source) ----> target --- backing ---> X --- backing --=
-> source
>=20
> I think it is less valid.  The first case works with sync=3Dnone, because
> target is initially empty and then you just copy all new data, so the
> target keeps looking like the source.
>=20
> But in the second case, there are intermediate nodes that mean that
> target may well not look like the source.

Maybe, it's valid if target node is a filter? Or, otherwise, it's backing i=
s a filter,
but this seems less useful.

>=20
> (Yes, you have the same problem if you use sync=3Dnone or sync=3Dfull to =
a
> completely independent node.  But that still means that while the first
> case is always valid, the second may be problematic.)
>=20
>> And what we actually want to prevent, is when to_replace is not source, =
but child (may be not direct)
>> of source..
>>
>> Also, with your check you still allow silent no-change in the following =
case:
>>
>> source --- backing --> to_replace <-- backing -- target
>=20
> You mean if source is a filter on to_replace?  (Because otherwise you
> can=92t replace that node.)
>=20
> Is that really a no-change?  Shouldn=92t we get
>=20
> source --> target --> to_replace

Ah, yes, it's OK.

>=20
> ?  (And what else would you expect?)
>=20
> So maybe we don=92t want to prevent that, because I think it can make sen=
se.
>=20
> Max
>=20
>> =3D=3D=3D=3D
>>
>> In other words, replacing make sense, only if to_replace has some other =
parents, which are not
>> children (may be not direct) of target.. And the only known such case is=
 when in the same time
>> to_replace =3D=3D source.
>>
>> so, shouldn't the following be
>>
>> if (to_replace =3D=3D src || !bdrv_is_child_of(to_replace, target_bs, 1)=
 {
>>
>> or, may be, to allow also replace filters above src, keeping backing lin=
k :
>>
>> if (bdrv_is_child_of(src, to_replace, 0) || !bdrv_is_child_of(to_replace=
, target_bs, 1) {
>>
>>> +            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
>>> +                bdrv_replace_node(to_replace, target_bs, &local_err);
>>> +            } else {
>>> +                error_setg(&local_err, "Can no longer replace '%s' by =
'%s', "
>>> +                           "because the former is now a child of the l=
atter, "
>>> +                           "and doing so would thus create a loop",
>>> +                           to_replace->node_name, target_bs->node_name=
);
>>> +            }
>>>            } else {
>>>                error_setg(&local_err, "Can no longer replace '%s' by '%=
s', "
>>>                           "because it can no longer be guaranteed that =
doing so "
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 9dc2238bf3..d29f147f72 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -3824,7 +3824,7 @@ static void blockdev_mirror_common(const char *jo=
b_id, BlockDriverState *bs,
>>>        }
>>>   =20
>>>        if (has_replaces) {
>>> -        BlockDriverState *to_replace_bs;
>>> +        BlockDriverState *to_replace_bs, *target_backing_bs;
>>>            AioContext *replace_aio_context;
>>>            int64_t bs_size, replace_size;
>>>   =20
>>> @@ -3839,6 +3839,52 @@ static void blockdev_mirror_common(const char *j=
ob_id, BlockDriverState *bs,
>>>                return;
>>>            }
>>>   =20
>>> +        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
>>> +            error_setg(errp, "Replacing %s by %s would result in a loo=
p, "
>>> +                       "because the former is a child of the latter",
>>> +                       to_replace_bs->node_name, target->node_name);
>>> +            return;
>>> +        }
>>> +
>>> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
>>> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
>>> +        {
>>> +            /*
>>> +             * While we do not quite know what OPEN_BACKING_CHAIN
>>> +             * (used for mode=3Dexisting) will yield, it is probably
>>> +             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
>>> +             * because that is our best guess.
>>> +             */
>>> +            switch (sync) {
>>> +            case MIRROR_SYNC_MODE_FULL:
>>> +                target_backing_bs =3D NULL;
>>> +                break;
>>> +
>>> +            case MIRROR_SYNC_MODE_TOP:
>>> +                target_backing_bs =3D backing_bs(bs);
>>> +                break;
>>> +
>>> +            case MIRROR_SYNC_MODE_NONE:
>>> +                target_backing_bs =3D bs;
>>> +                break;
>>> +
>>> +            default:
>>> +                abort();
>>> +            }
>>> +        } else {
>>> +            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
>>> +            target_backing_bs =3D backing_bs(target);
>>> +        }
>>> +
>>> +        if (bdrv_is_child_of(to_replace_bs, target_backing_bs, 0)) {
>>> +            error_setg(errp, "Replacing '%s' by '%s' with this sync mo=
de would "
>>> +                       "result in a loop, because the former would be =
a child "
>>> +                       "of the latter's backing file ('%s') after the =
mirror "
>>> +                       "job", to_replace_bs->node_name, target->node_n=
ame,
>>> +                       target_backing_bs->node_name);
>>> +            return;
>>> +        }
>>> +
>>>            replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
>>>            aio_context_acquire(replace_aio_context);
>>>            replace_size =3D bdrv_getlength(to_replace_bs);
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 589a797fab..7064a1a4fa 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -1266,6 +1266,9 @@ void bdrv_format_default_perms(BlockDriverState *=
bs, BdrvChild *c,
>>>    bool bdrv_recurse_can_replace(BlockDriverState *bs,
>>>                                  BlockDriverState *to_replace);
>>>   =20
>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *paren=
t,
>>> +                      int min_level);
>>> +
>>>    /*
>>>     * Default implementation for drivers to pass bdrv_co_block_status()=
 to
>>>     * their file.
>>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

