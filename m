Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48BDC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDA821927
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UjuyrDSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDA821927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izMOl-0005Bj-R6
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izMNj-00040v-2b
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izMNh-0001cA-Tb
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:14:23 -0500
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:36481 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izMNe-0001Fp-1u; Wed, 05 Feb 2020 10:14:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBZ8HzvieMyW3359uhevi4Aejh4lvBnRjRJs2OWOUs5wLFGI52XqQtH850T4zQ5S7OFdiMoNx0yPZhRUfaccXZvS6VdIp0VlqfhdWde+uXQz50MFfiM/CUAm2SInHRI88oJ4JuWUzvL5MdU3mYfPfh5BAmNPEzf4NBIY3jo0yuJ3+0GFepwDtwR3HgEoGEU4vgP1Gg1RWMNW8MDGf7b1DoOgIvUivRKiPRtCIinMxhYUj6t0Jgk7IKX/wSs7JXVy67K4/CPmOU8VJUvIN9+m+igp7KajZIgbOqb3jtQb+GARybzO6rQa5uNmKV0mpGdnQsq7g9Zg4QL+3t+9ZzeS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrOJIkQ5CUAuwXJKadhDcN/cegdBChY+4CV9/PKKnKE=;
 b=JJvVd7hSInIRH/lrIFrK2O3kSb0R344+RicSC0WxC29hWZRDVHzCSu+BcuGJmU9e90iF9yl9vt3s09K1XR6LIzM0xiQ/9VJ4XqaAzD/FOcUp2+EdoFDbA0+teDcyiauZDVIa9AZ/iAoAquhwuz5p87SHJxoYzWNLgP+aS9DdlLWchGp4qpFA4XxNXGltDEJX3FoEGalutAAFFRx7MYwXZNP1/QuNMWKfW4bkc9U1Gm+U/z02fDjWJX8yt5iSZMNlDG5yh022Cr8iJWXSPR9yKV1JftEVzbqS/xkMOiS4BHNNlgBZA+hiBzmfJjzOItn90EviVMroSIlI57nbLq2SXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrOJIkQ5CUAuwXJKadhDcN/cegdBChY+4CV9/PKKnKE=;
 b=UjuyrDSFhsOMHCHG44VBzBSp7g+CiOotmEMt9+wtLPcbYBFUZzrR4jTSJ7wn7IyLAS7GahJ7Ot//88bEAxWiXu9CXDN0KAueo1VZTwYbbWHEXD6CUh0RyTwjfQWjbcMohZl0zCyBbPh47AE+tHWn7ihM9cAnFTy+6Oo9YdGDzyA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2878.eurprd08.prod.outlook.com (10.170.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 15:14:15 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 15:14:15 +0000
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
 <99576c66-00d2-14a3-5f1f-6d7cebfa6553@virtuozzo.com>
 <8b650616-ff80-c430-5d4e-6c9311bec2f6@redhat.com>
 <5494fd19-3dbe-8878-628b-20b3c0a0c6cd@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205181412366
Message-ID: <d5bed92b-0351-7ae7-6b18-f814fe1533ba@virtuozzo.com>
Date: Wed, 5 Feb 2020 18:14:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5494fd19-3dbe-8878-628b-20b3c0a0c6cd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR02CA0098.eurprd02.prod.outlook.com (10.170.249.27) To
 VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR02CA0098.eurprd02.prod.outlook.com (10.170.249.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 15:14:14 +0000
X-Tagtoolbar-Keys: D20200205181412366
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3891c185-6388-4017-6a86-08d7aa4e101b
X-MS-TrafficTypeDiagnostic: VI1PR08MB2878:
X-Microsoft-Antispam-PRVS: <VI1PR08MB2878DA6E522499FE03CDD2C5C1020@VI1PR08MB2878.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(26005)(956004)(2616005)(316002)(186003)(16526019)(6486002)(2906002)(53546011)(8676002)(36756003)(81156014)(81166006)(8936002)(31696002)(86362001)(478600001)(66946007)(31686004)(66556008)(66476007)(4326008)(52116002)(16576012)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2878;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYrWfHr2tDk99N5Cqf38g19UOxtqL/8XhC+dnA2QIRBbinbFZZbRMqsE0j5tcxpBIvl5lg4mvrQUI39eTvuv/koNrPHrRcUczfDfhKQQIhe+W/fQjDXrLu7aPdVWCnHMEHACv5V+pRS8LczmejFPsSV5SKHX/mFMLrcahFsIAYmIirjFmNlc8nntI+lcfPiM8RsvDC0rG97f33Vw75gxY5m/Z5uJE6eokhERGwwMiq6/7bM9y+W+EnC3bdxhobdVlDfSWYhof39Xtvo5cdpc0NtXGxX1qOtyX/Wux8VzPwypCwUWVKVp4KLgUgfWukOVW60QzGi9J0gXTZmExqEucU/ftFQzSLIqbqx76zCvjOFAflDtLBuJxTgvXBCtoj3jQf0zPjHmBF61bMuGjCZJ99Sz9b6uJpI7CUSqaonKhWHYwjO/2tCOusQ16+xoImnl
X-MS-Exchange-AntiSpam-MessageData: FN7WfEJC7jbYxf9HOsfH8yn/OjksHVKBEu+zP8QDFS8sGYizT7YtvFvMSQLt0LI8cWeXwH3cStinSIZwUGTPqhVkoe0rFmyz7lO19Xs2zjY+VtpWRYGkPBK/vjcV7DXeibdLZulN6WOgTUT5Se41aA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3891c185-6388-4017-6a86-08d7aa4e101b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 15:14:15.1437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0sGNpF8DPYAq+5HzUvJDj0YL9AbNRm4QxdVlTzCudyftFNgI4yV4xG4OOj59iAVJm23qeZFrGv1IMaBZHCzD16hN1YvSYjgcI2eqZrUYMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2878
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.117
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

05.02.2020 17:47, Vladimir Sementsov-Ogievskiy wrote:
> 05.02.2020 17:26, Eric Blake wrote:
>> On 2/5/20 3:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>>> 3. For qcow2
>>>> Hmm. Here, as I understand, than main case is freshly created qcow2,
>>>> which is fully-unallocated. To understand that it is empty, we
>>>> need only to check all L1 entries. And for empty L1 table it is fast.
>>>> So we don't need any qcow2 format improvement to check it.
>>>>
>>>
>>> Ah yes, I forget about preallocated case. Hmm. For preallocated cluster=
s,
>>> we have zero bits in L2 entries. And with them, we even don't need
>>> preallocated to be filled by zeros, as we never read them (but just ret=
urn
>>> zeros on read)..
>>
>> Scanning all L2 entries is O(n), while an autoclear bit properly maintai=
ned is O(1).
>>
>>>
>>> Then, may be we want similar flag for L1 entry (this will enable large
>>> fast write-zero). And may be we want flag which marks the whole image
>>> as read-zero (it's your flag). So, now I think, my previous idea
>>> of "all allocated is zero" is worse. As for fully-preallocated images
>>> we are sure that all clusters are allocated, and it is more native to
>>> have flags similar to ZERO bit in L2 entry.
>>
>> Right now, we don't have any L1 entry flags.=C2=A0 Adding one would requ=
ire adding an incompatible feature flag (if older qemu would choke to see u=
nexpected flags in an L1 entry), or at best an autoclear feature flag (if t=
he autoclear bit gets cleared because an older qemu opened the image and co=
uldn't maintain L1 entry flags correctly, then newer qemu knows it cannot t=
rust those L1 entry flags).=C2=A0 But as soon as you are talking about addi=
ng a feature bit, then why add one that still requires O(n) traversal to ch=
eck (true, the 'n' in an O(n) traversal of L1 tables is much smaller than t=
he 'n' in an O(n) traversal of L2 tables), when you can instead just add an=
 O(1) autoclear bit that maintains all_zero status for the image as a whole=
?
>>
>=20
> My suggestion about L1 entry flag is side thing, I understand difference =
between O(n) and O(1) :) Still additional L1 entry will help to make effici=
ent large block-status and write-zero requests.
>=20
> And I agree that we need top level flag.. I just try to say, that it seem=
s good to make it similar with existing L2 flag. But yes, it would be incom=
aptible change, as it marks all clusters as ZERO, and older Qemu can't unde=
rstand it and may treat all clusters as unallocated.
>=20

Still, how long is this O(n) ? We load the whole L1 into memory anyway. For=
 example, 16Tb disk with 64K granularity, we'll have 32768 L1 entries. Will=
 we get sensible performance benefit with an extension? I doubt in it now. =
And anyway, if we have an extension, we should fallback to this O(n) if we =
don't have the flag set.

So, I think the flag is beneficial only for preallocated images.

Hmm. and for such images, if we want, we can define this flag as 'all clust=
ers are allocated zeroes', if we want. Which will prove that image reads as=
 zero independently of any backing relations.


--=20
Best regards,
Vladimir

