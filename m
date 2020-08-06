Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3139C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16452177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kt3jjGa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16452177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3i40-0001Jf-Lu
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3i2s-0000a7-HN; Thu, 06 Aug 2020 11:43:06 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:9727 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3i2p-0005Yu-5F; Thu, 06 Aug 2020 11:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiaSqNOQSpDt1k89Xf1lmtSWiwvz5ylRJs18bI6hg3wiI6u9p4Hy/Zveo7Ns54C+ti8hPZL/4WHc125yAIzErUBhj0XgGXuCUL8APaHICwzRXe1kEJi0WaNETXoCaCDGF2A4cJT/sna1mURPbDHuycEY82heTwpsB9oJzx5459M7A/RAKbTSxJ0XUCpv+nWLMGbmsAK2UmTac6PSm2Jb+gVzyA6icoSzgfOgFG0FZZUcSQNzaZnzl98sacj/wHsNXZQSCJDBnXuBb/TY4gRI9RfWIErilwDfFPvvNPgoJ69h240azbaB8x9Q6m2XYQ+YeOHpXc4AK9Lj/yMpyZTegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMACDudW8YCKFXM8/YWhKJwC4hTG6voOwZSjMI4M+3U=;
 b=cPQCsTyf2LzP5k+OPNRzH1uR09q1P4SSxsM7AmpvOqkcjVc9jV6aJvjsaWXC4u+eSbem9loOfUYggigqw9baT+tCMGaCrOATv/we47NJAyUuRI/yZqpfuDZlLaxvYAt8GCtbIGI+eMLIiCj/WKuIUXSKBFlHV31c5SRMHPMdvhbvRKxSnudpkqGr59S+TQy6DZpBkcyfhQ/xusroB9kRPo+Cj4TManHTmzPiHIRz+xhLpcDvTNf9lL147XOysjTOliTuyqft2umYmM8hjcACLJpPL237jg3UzJXqUO86E5dnhQ5JP8tm8slyxgR44/TFl3w+21ZjKY7xKDOsPg96Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMACDudW8YCKFXM8/YWhKJwC4hTG6voOwZSjMI4M+3U=;
 b=Kt3jjGa12rDpNWGpAWlItOdj+3cIHBuGXqjArQqLUWUQ7ednDGdIi6zld6zDQOGbbIo0LT8UpLPA2kbfe1OJnM/WsTHQCqoK6Ir+H7OtJg9qmr275HrS2DvM7WH6CNKpcN5k/VTS9GatfN+YjkkXCbXU2OmtL//3T4XSO05pWjc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Thu, 6 Aug
 2020 15:43:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Thu, 6 Aug 2020
 15:43:00 +0000
Subject: Re: [PATCH] block/block-copy: always align copied region to cluster
 size
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-block@nongnu.org
References: <20200806135740.24420-1-s.reiter@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ccf522d6-eb40-f999-5d5a-9a267d62d6ed@virtuozzo.com>
Date: Thu, 6 Aug 2020 18:42:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200806135740.24420-1-s.reiter@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.13 via Frontend Transport; Thu, 6 Aug 2020 15:42:59 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88754c9c-9029-4d54-e50a-08d83a1f65c0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-Microsoft-Antispam-PRVS: <AM7PR08MB533389D8E5E0AC4C234FD99FC1480@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoUScuSS3GFQXhNnTCfwjPUbapl5KG6ZP1nD2hOfO7Kxa5f8onURb+cMbjuG7MIA3iCmlN2Hk4+l1w+ITjKWsQIEcL+cOhNkJasjIdCZTYXiv6ZvjTB98zsXR6gHeOmTWWs6KLyE+dazBit+Jw+wW9PLw5xJ2W0PYXuRF8ZmwPfu06zxQUhNk3mBsEMMgkwUEKMMQvaqPpgwAA2yfRpbwkBoXJP/YFFlEtc1h/xBLvDD4uGhsoW65WziQCamp1/ZllcWuqo89SaGS1D/swINuKbsX85sh46hKKDzIc9Eti04M/MpuveN/NvMNCXXKvUPRqvaZe9FUsA/m5voxd8X3hUulzmM/lQQG8GIu7JTj3ee7Oodzpe/obVWhx8rwwKE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(8676002)(31696002)(31686004)(4326008)(186003)(16526019)(8936002)(86362001)(478600001)(26005)(6486002)(16576012)(316002)(2906002)(36756003)(956004)(2616005)(83380400001)(66556008)(66946007)(66476007)(52116002)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UC1zAM4psKgMpGoBIJgYNBWn3OuYmii69KYe3JXL2PuZUDN+Vajb15dMFapoJMMeLU6ftfgKPGsFaF26UX8x5WDwALWl2EwHspreJJvQxSir6tvfyx2wwPj6olOJcCUQYN16Aq5BGzR0RJ7C8kg+8vLcRO81INMtP2VPvRMwN3StHJIix+/nVxNxhnJy4a4fN+2P3n8lEUZh30/HZVtpw3+eC3+waDWEW0nBGNKrlEc2eryI4rhauX5kIFaZrVEMgXUdfVDQbTMIhuzFFRrwExrRM+gZN16DSQ9VhTxMrURW9JNew4nrHmrFT5cBLa/ld0KhPLWCuKfid49w6zcCSql2kBdaP5J6mbBJMO9t1GW9maFN0awL6LrKZdhx5KnX2FCTYOtovBrr0Uki5nJvEBcKhTdDLBY87iHOUGRImdoSoh4DrLGyJ5XrgAvjtRYJ8sMYwKjYwEZPB67Ivt6fZrcuED6j7fd+PkOQJ2QR5k2pAW11hdPplshd3Mf4cEQTW8ybAF/VzZzE1LOfz1WjGtV2xXtBTDurcmqS1STVktqWbwonJoY5gCzGxqa5FkrrNutkv1jT4OjwU4HRewsLYQgfoyOlhsrecCq4uebeURyhcZSrq/hb2y8JnKu/rKbXZyHciUojoDWTAs+pAD7uRQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88754c9c-9029-4d54-e50a-08d83a1f65c0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 15:43:00.0165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoYKHshxSKW025X7GHGnlp2j5IIXz59NZusc5FgoKn/aH2dmZfS2dT6OysgxbyM1/5mOG/wr2SgxRmY7wBzd+kGrxJWfZ3obwJa/zMiVnoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 11:43:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.08.2020 16:57, Stefan Reiter wrote:
> Since commit 42ac214406e0 (block/block-copy: refactor task creation)
> block_copy_task_create calculates the area to be copied via
> bdrv_dirty_bitmap_next_dirty_area, but that can return an unaligned byte
> count if the backing image's last cluster end is not aligned to the

Hmm, I assume you mean not "backing image" but just "image"? Backing seems unrelated, the problem is just unaligned image

> bitmap's granularity.
> 
> Always ALIGN_UP the resulting bytes value to satisfy block_copy_do_copy,
> which requires the 'bytes' parameter to be aligned to cluster size.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
> 
> This causes backups with unaligned image sizes to fail on the last block in my
> testing (e.g. a backup job with 4k cluster size fails on a drive with 4097
> bytes).

Ohh. Sorry for this :(

I think, we want this case covered by some iotest.. Are you going to add a test? Or I can do it..

> 
> Alternatively one could remove the
>    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
> from block_copy_do_copy, but I'd wager that's there for a reason?

Looking at the code I think, that the reason is just a convention. It may be changed, but it will need an audit of the code. For me your fix looks the correct thing to do.

> 
>   block/block-copy.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index f7428a7c08..023cb03200 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -142,6 +142,8 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>           return NULL;
>       }
>   

For readability, I'd also add an assertion:

       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));

> +    bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);
> +
>       /* region is dirty, so no existent tasks possible in it */
>       assert(!find_conflicting_task(s, offset, bytes));
>   
> 

Thanks for fixing!
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

