Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A882C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45A421736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="blDJA65/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A421736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahJp-0006Oh-Pq
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iahEI-0002JF-5T
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iahEF-0005Dz-7z
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:26:40 -0500
Received: from mail-eopbgr150127.outbound.protection.outlook.com
 ([40.107.15.127]:55617 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iahEE-0004tK-9k; Fri, 29 Nov 2019 09:26:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAstWvvNktA0jT/nH9p2jO8Av1g/bmtpcGzIsqtX5EpI79rwTxtqnjOf1SuvysP6FzATmZxwwDL+NSS1pbbkCGDhxTyL0F2tI7vKddyW/ZFh0EAjWrHGON/3zg8pZZ8/VAfAXQSXkFLGX5HL2aXuxjDDGf7xjVDF3uWOYSAjkfl6o9Xx/Z7+vqOYXDnOOvEUEtxzCzu2e/jOljvf6ixDOeNY6K8fGZ66EKwY8jE+euWjTQqwlw0fSdwAhSg4sTDFl5xxIAJ7skeKjjM/YoItyl9Py5GPNa9EEbgpMtusOU4RP70j/RmzxyVLVRukzAsF+ERrYEcDuYu7Y8ecWwnRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yKgAOw+levBEH/53aIgLAdw8SDPWPXp5BfuVbu6SNQ=;
 b=ENg0g3jjXAg5lud5CLW3/pvvLDqzEpCLQxELUjZYGVeAwZqlugU6JJYs+zpjDoDxXhjcK/GFJCuAOxDaPM5p52Tv4urg1YUaISQ852EBp9IC6sixRIgvATs8DOgcL/JZ02j7u+QDCmHQgH3qWiRFiKJIK2gCVIg8VNHGeifEfAeaHgDsTfv1JbcJcmTvWtwlH9MrysPClDOLGgI35GIXOTNfDd7FNHNM9MC+ikpj/tHuOuMPjWuD1T5D8xFM9d9j9qxqQ+3tQJXofdq7TbwtrvGx0bELSwdS6QK7aGis0/GpeUS8LcQyl5X0CGmQq9YQF3xm3K+cTtGHIy3FQRYSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yKgAOw+levBEH/53aIgLAdw8SDPWPXp5BfuVbu6SNQ=;
 b=blDJA65/L2CF7e1zfF0ISLYSAWqfTmHOWdPJh4r+BW4LHAlZyLSRYIJxq96RaNjym3Fn7zwsAcGFHf84nUQOuJaMSKFIf0rn5sjEg15K/uYwpLjozlJqCq8TfuA+OVoNt1eeoNGv424MtzixXmsvkWUKbQL4q1iNZ9YCFUhDUFw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3622.eurprd08.prod.outlook.com (20.177.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 14:26:34 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 14:26:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Topic: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Index: AQHVmKmF9vX+IDkOrkmVWASxqmj2taeiKDmAgAAdTYCAAAJpgIAABkqAgAACcgA=
Date: Fri, 29 Nov 2019 14:26:34 +0000
Message-ID: <4249aa4c-0e85-f25c-f1cc-672dd3245878@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <2c47c1be-e633-c769-88fe-684fe1ebe80f@virtuozzo.com>
 <88baa19f-1433-178e-33eb-16c275dec909@redhat.com>
 <c85c5101-2b88-5fb7-1d32-09261646b57c@virtuozzo.com>
 <af704f0a-273e-e4eb-3348-c7bec6936f87@redhat.com>
In-Reply-To: <af704f0a-273e-e4eb-3348-c7bec6936f87@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129172632847
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ee49edd-009d-4592-94c1-08d774d822e0
x-ms-traffictypediagnostic: AM6PR08MB3622:
x-microsoft-antispam-prvs: <AM6PR08MB3622C04B5267F163878C4B85C1460@AM6PR08MB3622.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(396003)(366004)(136003)(346002)(189003)(199004)(66446008)(64756008)(6246003)(66556008)(8676002)(66946007)(66476007)(2501003)(316002)(81166006)(66066001)(81156014)(7736002)(110136005)(54906003)(305945005)(53546011)(102836004)(14454004)(86362001)(186003)(26005)(25786009)(31696002)(386003)(76176011)(478600001)(229853002)(52116002)(6506007)(6512007)(8936002)(446003)(11346002)(2616005)(2906002)(5660300002)(36756003)(4326008)(99286004)(31686004)(6486002)(256004)(3846002)(6116002)(6436002)(71200400001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3622;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nQOxhg2uEYAhk/Pp3YpFWesSxgm/oToJN2j8tTSgcWEQ4vo6zEwbJ/7MZnTHqiKTyZ/8mCSSkmFXneuUMGUESz0g7kTNAEXA0UVLKhIIWewCS4nxXnxSMQqRxNM0KQnISwAs5/ZcPbGlztilyVNmZlML69KY0XaagNHrm9ji04zFaddiB51fb4NQ6EPEQh37Kk3hYfUi+7tlfJHtLw8tL9U89OuIW9n70Mgp3Lsu78LEinGHs3CyaJUurI2udRo1I0fBqYj+6PyXU2DjuYuFw5P5QKAj9fWfq6d8O3ZgCSexydGZDJdQSrXI3ixtd3IyS/0IFH5lIoMG5jDd/c0LcGHzyOYU0+rYZ/V8ONIiW58ni8TO+t/zyNG35ZQwCwRhUcgR7bA/AQYQP7FS6KZXL5Y84tgJ6k+0QKNxfFg6LDaKXlcQk8C/a2hWlSNy9xj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6636F6CDB604CF4C8450B562425B4285@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee49edd-009d-4592-94c1-08d774d822e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 14:26:34.5534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXlEks0fJqEebLjIwUS3y0+Wo30g61/05gvqFnFt3VPsT30lShMob01FDKU3Md9SKAamEw4BeY/NbOrehhuTwB4Pl4MwYHHquAS3//xa64s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3622
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.127
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

29.11.2019 17:17, Max Reitz wrote:
> On 29.11.19 14:55, Vladimir Sementsov-Ogievskiy wrote:
>> 29.11.2019 16:46, Max Reitz wrote:
>>> On 29.11.19 13:01, Vladimir Sementsov-Ogievskiy wrote:
>>>> 11.11.2019 19:02, Max Reitz wrote:
>>>>> While bdrv_replace_node() will not follow through with it, a specific
>>>>> @replaces asks the mirror job to create a loop.
>>>>>
>>>>> For example, say both the source and the target share a child where t=
he
>>>>> source is a filter; by letting @replaces point to the common child, y=
ou
>>>>> ask for a loop.
>>>>>
>>>>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>>>>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must p=
oint
>>>>> to a child of the source, and sync=3Dnone makes the source the backin=
g
>>>>> file of the target after the job).
>>>>>
>>>>> bdrv_replace_node() will not create those loops, but by doing so, it
>>>>> ignores the user-requested configuration, which is not ideally either=
.
>>>>> (In the first example above, the target's child will remain what it w=
as,
>>>>> which may still be reasonable.  But in the second example, the target
>>>>> will just not become a child of the source, which is precisely what w=
as
>>>>> requested with @replaces.)
>>>>>
>>>>> So prevent such configurations, both before the job, and before it
>>>>> actually completes.
>>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>     block.c                   | 30 ++++++++++++++++++++++++
>>>>>     block/mirror.c            | 19 +++++++++++++++-
>>>>>     blockdev.c                | 48 ++++++++++++++++++++++++++++++++++=
++++-
>>>>>     include/block/block_int.h |  3 +++
>>>>>     4 files changed, 98 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block.c b/block.c
>>>>> index 0159f8e510..e3922a0474 100644
>>>>> --- a/block.c
>>>>> +++ b/block.c
>>>>> @@ -6259,6 +6259,36 @@ out:
>>>>>         return to_replace_bs;
>>>>>     }
>>>>>    =20
>>>>> +/*
>>>>> + * Return true iff @child is a (recursive) child of @parent, with at
>>>>> + * least @min_level edges between them.
>>>>> + *
>>>>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  F=
or
>>>>> + * @min_level =3D=3D 1, @child needs to be at least a real child; fo=
r
>>>>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and s=
o on.)
>>>>> + */
>>>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *par=
ent,
>>>>> +                      int min_level)
>>>>> +{
>>>>> +    BdrvChild *c;
>>>>> +
>>>>> +    if (child =3D=3D parent && min_level <=3D 0) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    if (!parent) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    QLIST_FOREACH(c, &parent->children, next) {
>>>>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>>>>> +            return true;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * Iterates through the list of runtime option keys that are said=
 to
>>>>>      * be "strong" for a BDS.  An option is called "strong" if it cha=
nges
>>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>>> index 68a4404666..b258c7e98b 100644
>>>>> --- a/block/mirror.c
>>>>> +++ b/block/mirror.c
>>>>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>>>>              * there.
>>>>>              */
>>>>>             if (bdrv_recurse_can_replace(src, to_replace)) {
>>>>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>>>>> +            /*
>>>>> +             * It is OK for @to_replace to be an immediate child of
>>>>> +             * @target_bs, because that is what happens with
>>>>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: targe=
t_bs's
>>>>> +             * backing file will be the source node, which is also
>>>>> +             * to_replace (by default).
>>>>> +             * bdrv_replace_node() handles this case by not letting
>>>>> +             * target_bs->backing point to itself, but to the source
>>>>> +             * still.
>>>>> +             */
>>>>
>>>> Hmm.. So, we want the following valid case:
>>>>
>>>> (other parents of source) ----> source =3D to_replace <--- backing ---=
 target
>>>>
>>>> becomes
>>>>
>>>> (other parents of source) ----> target --- backing ---> source
>>>>
>>>> But it seems for me, that the following is not less valid:
>>>>
>>>> (other parents of source) ----> source =3D to_replace <--- backing ---=
 X <--- backing --- target
>>>>
>>>> becomes
>>>>
>>>> (other parents of source) ----> target --- backing ---> X --- backing =
---> source
>>>
>>> I think it is less valid.  The first case works with sync=3Dnone, becau=
se
>>> target is initially empty and then you just copy all new data, so the
>>> target keeps looking like the source.
>>>
>>> But in the second case, there are intermediate nodes that mean that
>>> target may well not look like the source.
>>
>> Maybe, it's valid if target node is a filter? Or, otherwise, it's backin=
g is a filter,
>> but this seems less useful.
>=20
> The question to me is whether it=92s really useful.  The thing is that
> maybe bdrv_replace_node() can make sense of it.  But still, from the
> user=92s perspective, they kind of are asking for a loop whenever
> to_replace is a child of target.  It just so happens that we must allow
> one of these cases because it=92s the default case for sync=3Dnone.
>=20
> So I=92d rather forbid all such cases, because it should be understandabl=
e
> to users why...
>=20

Okay, I don't have more arguments:) Honestly, I just feel that relying on e=
xisting
of chains between nodes of some hardcoded length is not good generic criter=
ia...

bdrv_replace_node never creates loops.. Maybe, just document this behavior =
in
qapi? And (maybe) return error, if we see that bdrv_replace_node will be no=
op?

And if it is not noop, may be user don't tries to create a loop, but instea=
d,
user is powerful, knows how bdrv_replace_node works and wants exactly this
behavior?

--=20
Best regards,
Vladimir

