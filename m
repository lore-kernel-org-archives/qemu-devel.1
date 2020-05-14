Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED2E20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m3s7huzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED2E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCJq-0001vq-Kj
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZCIq-0000yD-5I; Thu, 14 May 2020 07:45:28 -0400
Received: from mail-eopbgr60136.outbound.protection.outlook.com
 ([40.107.6.136]:44622 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZCIm-0002in-UJ; Thu, 14 May 2020 07:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqbV0Bvaci4NuQxzwkLmXktiCmydwXDgkuw8/MdIh9CM55ZYWExjzND/Sbw1O0WNUMZrnU761WnIUYQKRLk1d2FRyNc+zpRlTvF89A5D3HbmRY1Tohc/qFoAWJ4MDa1cfpFFKW+VrcW2gzqEY84653RjxPhkQDxA65QiQ7JhH+ppkhlAFAWVe4aoEI0kgDCh9EkO+PBr9RS3EJ6UkLsuwNdx9P7dgElUUdHeFOJs4JNd8A1me5lbo//ijw3HZQjED6chapUHsPti7BGPwcq9z3hdugwz38zP4386EFecuyq+FtjEnhLfLEtRGN2joD8ui2YoZvHFIoYYZb8o4URXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR2vot9XRzgAaHEBB9Cer7740RQox/NwtVxmNKE6vAk=;
 b=lyhVVd/nMsQ1EKO3RuEtVkG24e2ebUW2RFvKKklHc8YkSKMDHhdKAoO+u708Atav1QGOqOSqeCmU3z5CrGxuvAZWYrCq9dzmklwvgW09q5qu2EEd0930TtE0L5DOANz2ZNbJM0AG3BbrCoQklvLrhqq5yh+imgKxgDRbNG2//4WlkV/vtVoqqvs9wuqzMQVtczrSx2pmV9g8kiRAF+B7NGhhPfZhks93M1YLwgE/H7f1KYjB3qn5/go9xjfRKimTslCp+1WR9pPYsZaW+7bnwYKhySe25qWjN2DT/L7ukA4h2vq8BNSe5DYmUwnm/DQmE3xi+JWwVOwEu2ZV3qeM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR2vot9XRzgAaHEBB9Cer7740RQox/NwtVxmNKE6vAk=;
 b=m3s7huzjTf4b4CkYo8/eVlkM6FSxvT0odm5RgsMiPASectigBY059m85ajZEj/caNNt7Q6/plwgYzOoXTKk5e266/h3evxFxGWi7fkDGAWdgngYiXJ7gBTFQPW4QxE+p8WHHy+2D6d6lW8tiy1D6xdTh90vYcy/iLY9ZDNUwjJU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 14 May
 2020 11:45:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 11:45:21 +0000
Subject: Re: [PATCH v4 4/9] blockdev: Promote several bitmap functions to
 non-static
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d47772a1-7d95-74fb-4dab-fa0bad02a0cf@virtuozzo.com>
Date: Thu, 14 May 2020 14:45:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0062.eurprd03.prod.outlook.com
 (2603:10a6:207:5::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM3PR03CA0062.eurprd03.prod.outlook.com (2603:10a6:207:5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 11:45:20 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f5d7d2-9594-47c6-287b-08d7f7fc4867
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-Microsoft-Antispam-PRVS: <AM7PR08MB541500D9F82146F4D30A3EC6C1BC0@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArAnvuut20P7WEsffFDMicYp4h92yit+IO/aqta+UjX0Z3esbPsMqa9cjPbvRn46VVhMThgOcjBfLfY4F+V7MxM/xws8AMEGNZHsXL0DqE3PPNg0ysEWAI8xZkP+62ZrUvaD7nj6NYzPYRoLe0nDQidA5bgIoya71nk7MIDoZo/xOxA5CweZgu3a3XynYVHTeEQs/2U61q8Yfp4qvt8OxNEDrABZneMEMt0ytk/P3TVjKRWk3YcMCjZbm/W5ruw3/kfcbW1BQ6j5QFWtGDMxTAtNO4oXdK3FBxn+7Xean/YqbsaLqdgJ3lg1IDbk9iEE/SRNwtDOlSSkB68gWgcI/+fISvNyHNLw8vZlzlaw8qdtePSxdhbwOrVGq9fZ6mzKcM6faSq/HK7Hx424xqum2zPxApn6ERRctkR/hu6Fd7MEdueU0gDaQfVx7K76h+FTCCvvyruM+ncoowmB63If8EGLmlferDMDNs5Qd0TSsDTSJnaH9sF/NptNdZ3FEm8l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(66556008)(66946007)(478600001)(5660300002)(26005)(8676002)(956004)(16576012)(8936002)(16526019)(4744005)(6486002)(316002)(186003)(2906002)(31686004)(31696002)(86362001)(2616005)(66476007)(52116002)(36756003)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5ouEPUV3Ghh7lO/00IHULWCAW+bBqnKYnX2KStMwPUcJEo666hj6i0wWEn/znby42K6MBei3RcXtqaRoTZsRVgbfgKavsB2SlwLxSEogeu3+9dMLy7suglXhDHLJ0Qe/M7eGsI2C1J6opikFUgVUQ9a3y0YkUQQoVHLiPUxdyptnH9/c6JOTi3qPV68CeBS38gRaUOYG7CEEvtN+Kg3worFzvEQEf02GDisH3jDHMX+ck/Q9TPBfxwkzgiCK9U3XpH7GHCQ1iWl+mo/O/axA4pCwm7SztuEB/bcHfCHuacfRRUYt9/FA1vJhxyOd5i9qlFvkAfQ12SggIypvdle+0Hv2sbTfHIfmTlTC0FJJwDeImLoxmyXY69iGyvrdPz7blrkX4HqqyPUUqA4J8mpssDvZIoxgP4D0C5ClZl8r5NTVKV7W6aUKhu8NQY/T3QJR4/dKT1tSAdkzMnI8iQ+5S1RFJ2LLOQUrF4Jta38SXbnRhla0qp+zB7Mk1SqR/I+b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f5d7d2-9594-47c6-287b-08d7f7fc4867
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 11:45:21.6546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMQSyPQqhT8+Hbr4U4SUFozFTa+sX8q+snABNCFk0NK/cl6orerIlRMoIw/inSvFfG+WfGT+15ldJxHl5N6ktmnqLTsXzSo8onVc1Lmewto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.6.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 07:45:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> -        HBitmap **backup, Error **errp)
> +BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
> +                                          BlockDirtyBitmapMergeSourceList *bitmaps,
> +                                          HBitmap **backup, Error **errp)
>   {
>       BlockDriverState *bs;

s/bitmaps/bms/ to match declaration and fit into 80 characters

-- 
Best regards,
Vladimir

