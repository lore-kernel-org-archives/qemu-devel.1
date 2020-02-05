Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F2C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7215C20659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jWry+xQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7215C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izGxJ-0005dd-KH
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izGwR-00058P-R7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izGwQ-0003c6-Ic
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:25:51 -0500
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:45299 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izGwM-0002pX-Cj; Wed, 05 Feb 2020 04:25:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4/W4FkXBIo4QvkRTERBEF+lOdy5sXpE4JB76pim12ZsnTT0bcRyVtA3TNMfG0CEdQRrJDaeuojyhrC18ujktzsqyL2LGz9JNEKJLnnusspJOXv2db9A3Edn8J4f4gheE6Zd5jXj27WLRMEs5jQBJINM8fRqJDFjxfKYhNAIxnK3nhlCsTMdhlZhuEgCCdSNyeO0COIeYaC5Qz4JcsAW+aVeEiKxZh2Cvuzm7MImat9za7plmsy37BqxDyoduN6BnDqPokLWMW+jXsC7lTWxLNav1U9erHJFjx1T8A/wp5PTCEmm09UFJOv0ULlxWs3Mh1OIWZkn6DFm2e3x4/yF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB0HacEwkdLM8/Wx3l8aXgKTFP3mHdvWj7ioliLHvuQ=;
 b=EUwYZ/5myMArgzJ0eXx1u9Uy9/ub9rbBBxuYGqBZI4mW+vcL9gC9SXTHWcbS6vw60qLcfsImzLxCEqZ7ZNjIGaoSIWs069YxSqrizTyDD/3u6pURswuGpcBGkGgZmBLNhc6012O7kc8L5oy2qd/Oo5RWd0tWavnUl06NRWuX4dl9ekcxRYtRPegkm6Ik3MT0OtKx/Tz8lxfiI0TAaWTYZrvcTUYOSdF33R9rhVZzm0uekZmBUQT+chvupIc8mCdkVTC3QszAe1Chei2F6I6iZfasNJP+GtzAz9J7quPl+KcISMAJHdHUbm5mGx/+gEIqthWIr93prJVaQi1U0GKEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB0HacEwkdLM8/Wx3l8aXgKTFP3mHdvWj7ioliLHvuQ=;
 b=jWry+xQUExuEcFWIb7wZufPoKXy433pUxgphnuiKO6m5HusZQioN3soCGqeiAEijf3418F91Z2TvQh3Z9s3k2+R9jA36+iD4J4izR2Oj1FsbbophcQXkeWoaAlkbrIoUKVOV0hxvuGyw9xe5/TVELRnlgs9ce1sqO7v74FBU/CM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3838.eurprd08.prod.outlook.com (20.178.14.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 09:25:42 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 09:25:42 +0000
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205122540274
Message-ID: <99576c66-00d2-14a3-5f1f-6d7cebfa6553@virtuozzo.com>
Date: Wed, 5 Feb 2020 12:25:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0901CA0056.eurprd09.prod.outlook.com
 (2603:10a6:3:45::24) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0901CA0056.eurprd09.prod.outlook.com (2603:10a6:3:45::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 09:25:42 +0000
X-Tagtoolbar-Keys: D20200205122540274
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b592e48d-c35d-42e6-fadf-08d7aa1d5f4c
X-MS-TrafficTypeDiagnostic: VI1PR08MB3838:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3838A00946E81ECBAFB92739C1020@VI1PR08MB3838.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(396003)(346002)(376002)(189003)(199004)(8676002)(66476007)(316002)(66556008)(16576012)(16526019)(4326008)(6486002)(186003)(52116002)(36756003)(2616005)(26005)(956004)(81166006)(81156014)(2906002)(478600001)(31686004)(86362001)(8936002)(5660300002)(66946007)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3838;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQ1OXhLSA2g2CoCDrXO3qwVotUpdqhtw74pdbkvZdFV/J6qnNbZtS4E9A97x/eVEEuz3VI4QFw5GD0oymeDw+DE7ohmZjQECfVVlHy0rrDoYjvJR02sXR8tPepUBIArpwVb6xY4o0po7rXZ4u1G8pcWE1RMkHHwHH/m2q941RVBMGz/IrAX2pzcyX/98KdG4LBXRVVymtSog3V8aCjEpaeu2tNiR5QD5UTP0YlVideXie6F3aZ/gPT/QaRpWPIkP0rCpwXE+s5xtLomOc4F/jCDykbBF4ZNzdVHy7e4X+12Yht29kJpLliDQRh4x9CcrAYZsYOxncFMhrMc0Oz3OEC7if8UZQG8+nCjJZ6iAtlnIQdzHYyNQFMG7fvnkZV0LF10GVAfdsS7NzLKGiPYM+DH6R+RvxkRnV781X38B1/27r87O+FLnWWjv9KegZu8i
X-MS-Exchange-AntiSpam-MessageData: AmCusIN/kdQjQaHDGdoQIsDISUWTsnD2FdVGgQOK8+RbIMN1aiav4s4Pc11C8AWix5kLLGYw6DUPJdPK8L1pNr8eceCxQD8IwlOnKG/v0JUV9m2zlUeWFRwdckwvH6trHHfzJpJ6oW/n/sBXv71q0Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b592e48d-c35d-42e6-fadf-08d7aa1d5f4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 09:25:42.6917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlUikoQBkVOOUIDd3ztA9uHV7SKNCkrBgK96joku6MzVF564gluVu1+ubbA1pqPv8vhDfnmOYgk/3KDAt4rLFYyGdi6+4aIOtA/WppFQlYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3838
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

05.02.2020 12:04, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2020 20:44, Eric Blake wrote:
>> Based-on: <20200124103458.1525982-2-david.edmondson@oracle.com>
>> ([PATCH v2 1/2] qemu-img: Add --target-is-zero to convert)
>>
>> I'm working on adding an NBD extension that reports whether an image
>> is already all zero when the client first connects.=C2=A0 I initially
>> thought I could write the NBD code to just call bdrv_has_zero_init(),
>> but that turned out to be a bad assumption that instead resulted in
>> this patch series.=C2=A0 The NBD patch will come later (and cross-posted=
 to
>> the NBD protocol, libnbd, nbdkit, and qemu, as it will affect all four
>> repositories).
>>
>> I do have an RFC question on patch 13 - as implemented here, I set a
>> qcow2 bit if the image has all clusters known zero and no backing
>> image.=C2=A0 But it may be more useful to instead report whether all
>> clusters _allocated in this layer_ are zero, at which point the
>> overall image is all-zero only if the backing file also has that
>> property (or even make it two bits).=C2=A0 The tweaks to subsequent patc=
hes
>> based on what we think makes the most useful semantics shouldn't be
>> hard.
>>
>> [repo.or.cz appears to be down as I type this; I'll post a link to a
>> repository later when it comes back up]
>>
>=20
> I have several ideas around it.
>=20
> 1. For generic block layer.
> Did you consider as alternative to BDRV_ZEO_OPEN, to export the
> information through normal block_status? So, if we have the
> information, that disk is all-zero, we can always add _ZERO
> flag to block-status result. And in generic bdrv_is_all_zeroes(),
> we can just call block_status(0, disk_size), which will return
> ZERO and n=3Ddisk_size if driver supports all-zero feature and is
> all-zero now.
> I think block-status is a native way for such information, and I
> think that we anyway want to come to support of 64bit block-status
> for qcow2 and nbd.
>=20
> 2. For NBD
> Again, possible alternative is BLOCK_STATUS, but we need 64bit
> commands for it. I plan to send a proposal anyway. Still, nothing
> bad in two possible path of receiving all-zero information.
> And even with your NBD extension, we can export this information
> through block-status [1.]
>=20
> 3. For qcow2
> Hmm. Here, as I understand, than main case is freshly created qcow2,
> which is fully-unallocated. To understand that it is empty, we
> need only to check all L1 entries. And for empty L1 table it is fast.
> So we don't need any qcow2 format improvement to check it.
>=20

Ah yes, I forget about preallocated case. Hmm. For preallocated clusters,
we have zero bits in L2 entries. And with them, we even don't need
preallocated to be filled by zeros, as we never read them (but just return
zeros on read)..

Then, may be we want similar flag for L1 entry (this will enable large
fast write-zero). And may be we want flag which marks the whole image
as read-zero (it's your flag). So, now I think, my previous idea
of "all allocated is zero" is worse. As for fully-preallocated images
we are sure that all clusters are allocated, and it is more native to
have flags similar to ZERO bit in L2 entry.


--=20
Best regards,
Vladimir

