Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D50C352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D421B217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l6r1A/KL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D421B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLuV-0001z5-2G
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izLti-0001OQ-Sn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izLth-0006b3-C3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:43:22 -0500
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:51168 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izLtc-0006Lk-Ge; Wed, 05 Feb 2020 09:43:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBXnwXjXuF5/CQOtolxGY6GQYdKVzHjqp7Jt2vnQzY8fP601W6+edhSWLUerx7aamoX3Ge1Gs0qoonxPH7NmRHBoApL7Fup7KdlcHv3kfwuZb8K9pcZHBABPskQaFWWvmRuFbz2wB5t9nEcmYvvQpkYZd4K03cgNTE/Uxo+bUR1I/Rhs5A8LHxb7/75gXHE1yNt9scS2kVoc5X8meOnLZiKs+iRdV5EXoyaMRhPlzC2y0JGWvwVsCl/96F1F6EaxK/drP4HoA7w89NUe03sA7Nb02+qgFMgZAPP8zn1IB4o4s23fjYAcYBFx/c2GpId2RScfQherQLieNuTyC7W6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+8Eptl02ZzWxl39nZWtt/mPrThCuT/KLss8b12h/go=;
 b=RMGI105O0hbjSYSxrI+TQIN+L1+y/DXU8CNEpdcfUgkaQhherJWXkiRcVJOWMozDOlezprBK8cZpVvnQGbY4i+EyDXVb54NORgQS2XIoNFtheF12pl6cCMSsB9K0FeS67Cwajg6RQK8UrNlGROXDKCxTFC2hDYnugMz5ENCaUN1+Bu8yiUM0uc7I1y1aw7WyMmvfH9py8dlwDkBFeDMY2gk4La78ViRkn1TKPiSwUq2TLjhUKfVyJvjG/eYyDQi9/BS6joChviHnwpuF5Ktu8WbEvFhBoZIZ2HYBvc3ZFHocbUco3BoF+ks2+VIZ8oBQ3SR/MHlmRVzrlhKhsflcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+8Eptl02ZzWxl39nZWtt/mPrThCuT/KLss8b12h/go=;
 b=l6r1A/KLuhcyfqdV1jNys4HUuaA8n9fqvWW8QAArIUj3GL7RS33f7IMPkmFcgWhQ9KicSghH0Bpxt0V7co9UuIYlT/d/4WN99cznf+FaePS0A80pjy/YMbmZzYYMh/NZLe4JJUdrx4XIDuiOLMC3RTbFgCi2hVQ0U2vzAMIOQFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB4062.eurprd08.prod.outlook.com (20.178.127.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 14:43:14 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 14:43:14 +0000
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
 <9f2d8730-23ca-f070-52dd-0cbcbb08913b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205174311995
Message-ID: <c7ff64b0-2916-aa51-f655-44adccee40e2@virtuozzo.com>
Date: Wed, 5 Feb 2020 17:43:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <9f2d8730-23ca-f070-52dd-0cbcbb08913b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0036.eurprd09.prod.outlook.com
 (2603:10a6:7:15::25) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0902CA0036.eurprd09.prod.outlook.com (2603:10a6:7:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34 via Frontend Transport; Wed, 5 Feb 2020 14:43:13 +0000
X-Tagtoolbar-Keys: D20200205174311995
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c138e4bc-1bd5-458b-1656-08d7aa49bb01
X-MS-TrafficTypeDiagnostic: VI1PR08MB4062:
X-Microsoft-Antispam-PRVS: <VI1PR08MB4062E6AFD8196076CCFF98E0C1020@VI1PR08MB4062.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(396003)(136003)(366004)(189003)(199004)(36756003)(2616005)(956004)(81156014)(81166006)(66476007)(66556008)(316002)(16526019)(52116002)(53546011)(26005)(8676002)(6486002)(2906002)(16576012)(31696002)(186003)(86362001)(8936002)(4326008)(5660300002)(66946007)(966005)(31686004)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4062;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAWZs1TpTWFa6boDZUZDEVFsQCItLqYMfnFoyAslU8djx9h3j/+ZF+0Z/9PbDdqAl+2HraA+BF4vQL0EUHqClFH8ptyiV0cMG+BpPYpdDM0+6lpraZmha4Y0JPVpo3ueJfSERdtpkQI3jt0apUUkuXiKGDU2dpuYNzs/zN1KZq0FU6At/lndnxtqPKM30ij3WYnjhBrof/noKGXPCxl/eyPa7esRyC6hqV6aq+yxXbJnWmGGBHUPh6111C8eriaji0yV3XWS0rVrrSeWxE2Kacvs9h7ZT+TLs3QOfpIdSahwIz3Io6v4YqHBBkqDmatIid6WeO/65HhOYjS7W9yoC/DpkhkYhZ+az/FNQmEUWG1cNtMWtOpw10M5BD8oEdaJ/g9n4CcIcui2kbr/EodHSe94g9OKI0wvOr2Askgrt2gzv5AFXz/gaWfmx75Y6d/ChP4ox5wpdVNVl64SBZjgNnlge14iwY/oKjDfwc/wL5SQsAU85zANcbGK8wvcV+gjpvrIxopfUK6ats3nB3fXXg==
X-MS-Exchange-AntiSpam-MessageData: 5Ht6AIHa08MCEIb/fGtYZqLC4bPcxXQHX4qUXL42WjaJykNcscTTtWW7sF02TS+z6LVZxvgqpkOYu/tEwc1pkJ5SVuSZgKgqReUg5tGGiPQbIowVp2VOpR/Su4CUfSvYYzLAYX/SAVvbDtmei2+TsQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c138e4bc-1bd5-458b-1656-08d7aa49bb01
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:43:14.4538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuP6WZsVAekuBh82lVA06l/iV0zx+n3VJw5PzlVgApsvtPtPRejHLKJp9tR6AK3gbBbItsTgxiL6lROzXrsR4RTy9Gll/Nynl48kXhI5dFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4062
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.129
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.02.2020 17:22, Eric Blake wrote:
> On 2/5/20 3:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>> [repo.or.cz appears to be down as I type this; I'll post a link to a
>>> repository later when it comes back up]
>=20
> Now up
> https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qcow2-all-zero-v1
>=20
>>>
>>
>> I have several ideas around it.
>>
>> 1. For generic block layer.
>> Did you consider as alternative to BDRV_ZEO_OPEN, to export the
>> information through normal block_status? So, if we have the
>> information, that disk is all-zero, we can always add _ZERO
>> flag to block-status result.
>=20
> Makes sense.
>=20
>> And in generic bdrv_is_all_zeroes(),
>> we can just call block_status(0, disk_size), which will return
>> ZERO and n=3Ddisk_size if driver supports all-zero feature and is
>> all-zero now.
>=20
> Less obvious.=C2=A0 block_status is not required to visit the entire disk=
, even if the entire disk is all zero.=C2=A0 For example, qcow2 visits at m=
ost one L2 page in a call (if the request spans L1 entries, it will be trun=
cated at the boundary, even if the region before and after the boundary hav=
e the same status).=C2=A0 I'm also worried if we still have 32-bit limitati=
ons in block_status (ideally, we've fixed things to support 64-bit status w=
here possible, but I'm not counting on it).

Not required, but why not doing it? If we have information that all disk is=
 of the same ZERO status, no reasons to not reply on block_status(0, disk_s=
ize) with smaller n.

>=20
>> I think block-status is a native way for such information, and I
>> think that we anyway want to come to support of 64bit block-status
>> for qcow2 and nbd.
>=20
> Block status requires an O(n) loop over the disk, where n is the number o=
f distinct extents possible.=C2=A0 If you get lucky, and block_status(0,siz=
e) returns a single extent, then yes that can feed the 'is_zeroes' request.=
=C2=A0 Similarly, a single return of non-zero data can instantly tell you t=
hat 'is_zeroes' is false.=C2=A0 But given that drivers may break up their r=
esponse on convenient boundaries, such as qcow2 on L1 entry granularity, yo=
u cannot blindly assume that a return of zero data for smaller than the req=
uested size implies non-zero data, only that there is insufficient informat=
ion to tell if the disk is all_zeroes without querying further block_status=
 calls, and that's where you lose out on the speed compared to just being t=
old up-front from an 'is_zero' call.

Yes. But how is it worse than BDRV_ZERO_OPEN? With one block_status call we=
 have the same information. If on block_status(0, disk_size) driver replies=
 with ZERO but smaller than disk_size, it means that either disk is not all=
-zero, or driver doesn't support 'fast whole-disk zero check' feature, whic=
h is equal to not supporting BDRV_ZERO_OPEN.

>=20
>>
>> 2. For NBD
>> Again, possible alternative is BLOCK_STATUS, but we need 64bit
>> commands for it. I plan to send a proposal anyway. Still, nothing
>> bad in two possible path of receiving all-zero information.
>> And even with your NBD extension, we can export this information
>> through block-status [1.]
>=20
> Yes, having 64-bit BLOCK_STATUS in NBD is orthogonal to this, but both id=
eas are independently useful, and as the level of difficulty in implementin=
g things may vary, it is conceivable to have both a server that provides 'i=
s_zero' but not BLOCK_STATUS, and a server that provides 64-bit BLOCK_STATU=
S but not 'is_zero'.
>=20
>>
>> 3. For qcow2
>> Hmm. Here, as I understand, than main case is freshly created qcow2,
>> which is fully-unallocated. To understand that it is empty, we
>> need only to check all L1 entries. And for empty L1 table it is fast.
>> So we don't need any qcow2 format improvement to check it.
>=20
> The benefit of this patch series is that it detects preallocated qcow2 im=
ages as all_zero.=C2=A0 What's more, scanning all L1 entries is O(n), but d=
etecting an autoclear all_zero bit is O(1).=C2=A0 Your proposed L1 scan is =
accurate for fewer cases, and costs more time.

Ah yes, somehow I thought that L1 is not allocated for fresh image..

Hmm, than possibly we need two new top-level flags: "all-zero" and "all-una=
llocated"..


--=20
Best regards,
Vladimir

