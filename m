Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE0C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 07:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F015620730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yi61G3OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izFU3-00056d-10
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 02:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izFSt-0004Jf-07
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 02:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izFSr-0005mk-PT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 02:51:14 -0500
Received: from mail-db8eur05on2122.outbound.protection.outlook.com
 ([40.107.20.122]:61793 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izFSm-00050k-8b; Wed, 05 Feb 2020 02:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrK5qddULCi8Qv56Vilo6QEWEa0xMCAja5gClVDqhriMP/Sl/0wHuIknVB/UBD807TYLjULLqlGK47E4hzZ9200rxqMat3MdXUa2gMfJrZ5UGnvkeEm2Ncd48kSnsuvnTnWC+S+Lz8Hctk5cyOAwLjQj6RMPO7dIlkDWdY7o8CwNuA2z0evOeW/75QrmpsQ8oyREJZgCuA5aEmFsisi02gfPmGsMNitOWBzW9JOCVOyzOVr7e4sK16so6+E6gsXHVhKD43Po+BIX3deqwOWJ14I1WdD5/fUzu6woMk10qmvEebpQH47SjOy8xTQQvtFxJG915vm3P9z4HGLlFDz88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZYrlvuA3NXgrMKG2D8Cg5lBLiWTVGY5S1EMR2T3bvA=;
 b=g5+imwCOdxizFpzkedaxYIU+FJ4ZQrhV11NNaU7B/6OFYmDWGXJLQfrLkzxGs7Il/9/vsSw2nzgWdW9ruV6/Wt1QihgxFieDPwDJG254iCVSidWlIqjmGKW0wkQAtWFgHFZSCcy4yTPnVfodHJ8Q0BNk9txQreyYShcEZVoSilOQroGN+Gc8dAUJjpT5Hs1jdGwHAOgJK/jqQD/wXQusLrrhyma3l+QObumoW9ZOwzNc0/L265EOFbkOzyq0PVv9V06BK/xGDxvYzMuUOb0E6zmEcZu+E3zjDh15iw3TCEKtyFjNZccth2rfJzVyCfYoO0odh1fTohI3qi+bMxeumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZYrlvuA3NXgrMKG2D8Cg5lBLiWTVGY5S1EMR2T3bvA=;
 b=Yi61G3OUVAS6d7yyjjOirNO1ZQ5U6TKwlOfKzdqju46JYAe5LExGwMun2FkxWjFZg7IkLUTeBR9cVmVTyMAq5+ie2STW6/5z6bdOX48F07yXNU8ThO7+aZhd5ChpbsH4Lg4WLaUV0AHRUBvUf4jDAPE/Zu1ESHE0ZzREikHpQRE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3533.eurprd08.prod.outlook.com (20.177.61.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 07:51:05 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 07:51:05 +0000
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205105101809
Message-ID: <8debd8e0-52bd-a962-0877-53dd0e610f1d@virtuozzo.com>
Date: Wed, 5 Feb 2020 10:51:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR09CA0074.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::18) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0074.eurprd09.prod.outlook.com (2603:10a6:7:3d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30 via Frontend Transport; Wed, 5 Feb 2020 07:51:03 +0000
X-Tagtoolbar-Keys: D20200205105101809
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35901507-f218-43d2-89c0-08d7aa10272c
X-MS-TrafficTypeDiagnostic: VI1PR08MB3533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB35331D1E3E7764BF631D7977C1020@VI1PR08MB3533.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39850400004)(199004)(189003)(53546011)(26005)(16526019)(7416002)(186003)(52116002)(31686004)(5660300002)(956004)(478600001)(2616005)(66476007)(66556008)(66946007)(2906002)(6486002)(36756003)(86362001)(31696002)(8936002)(316002)(16576012)(81166006)(4326008)(54906003)(110136005)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3533;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0UUg/S7zEA3Xy/ZoBij7THVBgJ6+nvKrgNYXHf5Vr4kqYUWISEjzUi5FCDjW90mpgMR6tjTrfZZ8hUVh1B1uteeRH4nkvGzmb/0dy5q1cMmaLHZ/bbr8NKsACxfYFBVd1UCW5fBSU99kG9In2PbMhghmktWg9jobeqAjS+fQc4eYwLMukFM1FXj4SVUFyPY19yeq7Y46YI9ejykoFnf3hl2qndN+uWsRA+DIMe3Jl63BdB4b3aAlctsrbxn/NsbsSIIagZfqAg7qDhqebhRZfbBwrdT2LCRcCEM90+Vbth5klYXcCwLFMDAg+DXRQjfrhPeK2gt9erSA1QyjL/1/b4ECOOtBXJoIDb74T7ee6FQEvYv5ASExlqU2I4gTHaU/bkEKQkOCZi5HAOZ/uClnKztU78iB0JZU9lHQXH/4vmehTuWYBiyhYOnQpTfnyXa
X-MS-Exchange-AntiSpam-MessageData: +ZT7uTVailPQjrwxQQTl3cK8uwkNqkLgY6lVCdKGx7RJoY/OiEiyqnI3SDk5jd9JArnSYNQETCn+x1oPwpvrvL3bYfnMGrNPr3iTg9VXqmK7aQ7pGO8lLpgdV5XuxTnz1k9QqgD/7cktuUAe+7Cyxw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35901507-f218-43d2-89c0-08d7aa10272c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 07:51:05.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAJMDLRMljvzA75TJldBPjB8VnVTfhvdkJIVCEqPcQgSyM5VYt49vj2VfB1GJC+SLD+tE15bVhtmIgnV7+mGkKObOUL4t01tgRVoG1RVvJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3533
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.122
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.02.2020 20:42, Max Reitz wrote:
> On 04.02.20 16:35, Vladimir Sementsov-Ogievskiy wrote:
>> 31.01.2020 20:44, Eric Blake wrote:
>>> Having two slightly-different function names for related purposes is
>>> unwieldy, especially since I envision adding yet another notion of
>>> zero support in an upcoming patch.=C2=A0 It doesn't help that
>>> bdrv_has_zero_init() is a misleading name (I originally thought that a
>>> driver could only return 1 when opening an already-existing image
>>> known to be all zeroes; but in reality many drivers always return 1
>>> because it only applies to a just-created image).=C2=A0 Refactor all us=
es
>>> to instead have a single function that returns multiple bits of
>>> information, with better naming and documentation.
>>
>> Sounds good
>>
>>>
>>> No semantic change, although some of the changes (such as to qcow2.c)
>>> require a careful reading to see how it remains the same.
>>>
>>
>> ...
>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index 6cd566324d95..a6a227f50678 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>
>> Hmm, header file in the middle of the patch, possibly you don't use
>> [diff]
>>  =C2=A0=C2=A0=C2=A0 orderFile =3D scripts/git.orderfile
>>
>> in git config.. Or it is broken.
>>
>>> @@ -85,6 +85,28 @@ typedef enum {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3ff,
>>>  =C2=A0 } BdrvRequestFlags;
>>>
>>> +typedef enum {
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit=
 if the contents of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing fil=
e reads as all
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=A0=
 If .bdrv_co_truncate is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO_T=
RUNCATE is clear.
>>
>> I understand that this is preexisting logic, but could I ask: why?
>> What's wrong
>> if driver can guarantee that created file is all-zero, but is not sure
>> about
>> file resizing? I agree that it's normal for these flags to have the same
>> value,
>> but what is the reason for this restriction?..
>=20
> If areas added by truncation (or growth, rather) are always zero, then
> the file can always be created with size 0 and grown from there.  Thus,
> images where truncation adds zeroed areas will generally always be zero
> after creation.

This means, that if truncation bit is set, than create bit should be set.. =
But
here we say that if truncation is clear, than create bit must be clear.

>=20
>> So, the only possible combination of flags, when they differs, is
>> create=3D0 and
>> truncate=3D1.. How is it possible?
>=20
> For preallocated qcow2 images, it depends on the storage whether they
> are actually 0 after creation.  Hence qcow2_has_zero_init() then defers
> to bdrv_has_zero_init() of s->data_file->bs.
>=20
> But when you truncate them (with PREALLOC_MODE_OFF, as
> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), th=
e new
> area is always going to be 0, regardless of initial preallocation.

ah yes, due to qcow2 zero clusters.

>=20
>=20
> I just noticed a bug there, though: Encrypted qcow2 images will not see
> areas added through growth as 0.  Hence, qcow2=E2=80=99s
> bdrv_has_zero_init_truncate() implementation should not return true
> unconditionally, but only for unencrypted images.
>=20
> Max
>=20


--=20
Best regards,
Vladimir

