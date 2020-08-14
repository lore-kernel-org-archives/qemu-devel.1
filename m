Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BDBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AF120771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vVZ8dW2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AF120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e7M-0004pn-Gy
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6e6V-000485-MV; Fri, 14 Aug 2020 14:06:59 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com
 ([40.107.8.104]:46371 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6e6T-0004K2-QV; Fri, 14 Aug 2020 14:06:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLqCQ53udPSjNKOvq/W7pDwru5l7JQfWYntN4b8OxWINLm/IMN2wGDXXbH+1+yMQGsItrepPw0ZXHarK+SRaVFR4lPcA1+7tSugkjNVJ1L0BNR6WpmqnhrjC3Hn7FIclHjtJ5sUbnlDAVb9Z2E6bLjboYrz6+Asywzt+Re+DySv5+qSYPiwE3HMLfehHSup3AxrDY0FnzP49cLGZE2oq9xrzSWN5cpiOnGkNY2xm0fgqtZlt2k4pHHZbMtQHYbJT9gGz+E+MQJdqO34xPxImDlmsT38CVMqbYyo+Ixjai4zwV2H4HJTM9cuiGjDk5peUquIJqD/mNR2k6FwsX6kYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iglXPdk7YfTzfVwQ1SLUvFoWzlYSbmXl61Ci1JF63NE=;
 b=URMMXV1eOI4FmOGh7O2Sjuf9jyreXfpke/BbmsGv+w9RXOkZ2L/wI0HRSLF03HvcJOuG7Rtd7zWnBXLxWlIOK/QkAq9W0yQCsI3i4TeENuDW4UKXcUgcuMnc9viEFosYP1XdwFjBw2B3bOqS5w2R1bnj44WBPNEh6RssGxC3gNN6aQcILWdq3IKEtdE2frCojj3YVXWCiL85TWOs3b8Y25j1taJtR7O2yPmI3p2ZodjB0DSA6lTBn2F+zAJ4TupZC+68llr/pVouk7H8fn9N/SSgoS007H7i/Z+aRwwrKIO6ANZlB7ufW4St2j8jWe5fQs9Qg78vBIcYCWlwj7Mm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iglXPdk7YfTzfVwQ1SLUvFoWzlYSbmXl61Ci1JF63NE=;
 b=vVZ8dW2YGPLgCY6dPGjmczUMQrBLSPS6cfttuY8hh6OVAnb9V+QHbkN/47woQkaQ1CPeJY5dMIjkR/PszkavSUD3IZnzZJJHYcFY4Cu0VYwDVL/3X14KkLgKIghfRGP2VSEv06PM8yK/mDCLeufZqV2OpLIeiJyfwJiMntTVXgs=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 18:06:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 18:06:46 +0000
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1597416317.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <138578a5-b2c6-b0df-ff9f-5c95d8ea895f@virtuozzo.com>
Date: Fri, 14 Aug 2020 21:06:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <cover.1597416317.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0088.eurprd05.prod.outlook.com
 (2603:10a6:207:1::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM3PR05CA0088.eurprd05.prod.outlook.com (2603:10a6:207:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.18 via Frontend Transport; Fri, 14 Aug 2020 18:06:45 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb24cdb5-887f-4c2c-9c6e-08d8407cceb5
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50776FCF4969F5F9671B8CB4C1400@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7B28SPf2MbndQKdhH4WBk2XfEJdx1d3zCa8pT1jAA9+/fzi6KGJH0PwI+F0xf9Zb2f6rGo+wuVKLu5lrEI9p888TrBDVm8Ixi5mbi1sIv+ahDBfldkBNwpNxmDn+I+vxrIg1k+e+04arqtYnX3uToChRhiykkf7WOFAyVXeC/IHBp5/SN4/SSdB39/vGBUt5GYyASl2ZNNAV0SvRMnSPj+sh/yuhsaPdyrGrEfVnkOqs1ujDL0CVx0PohjT5Zt2G6FvIq9BZMVq3m8ir4fmR0l2CuwJ3uR1vrSMeMenuv9SL6VuSBf94vbPg1jAW6qL5E8BhO1lFMIV5zlnXbhwuJfOMLs7z43riu2d9DEUwPnmffR2CekCCav0u98UX6SGpvKw7HEkX4ndKn/o/ixeP5nghaE32kltaLfv8dUcoWJer51796IkLWP64OzKG5nip7Wc6hg+5C8ahtdlIXCHXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39840400004)(31686004)(16576012)(316002)(52116002)(6486002)(54906003)(86362001)(31696002)(107886003)(4326008)(83380400001)(966005)(2906002)(478600001)(66476007)(66556008)(66946007)(36756003)(16526019)(5660300002)(956004)(8676002)(2616005)(8936002)(26005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6bJJdynvOcz2pU9ERhQPpQNDZ6FqH7zmAiX4NubQ2l2fy4AzvOlUidJ4XyuR1ABldiSwBrheWcmsUkFt+H8F0buRHdvzzC8tDspvZt/UTUap6h0k1fZZk+K/EKl+sLa6I86xkzqC5xm3fKlkgRrgiiHLhaRC4L+qHXEZKNqPpnxp+ma1YKbDMw7Av7knqAejVZl1D6eKCEpuSqhZJOHdLsfrDblFQNuv/k/Vk1FLBoGBs904eUQonzJkP/lf9SfozvEB8KmmPy9caZAKsvMNOn+b6zJDlXn/pWh6WJkF91Hbk4Nj/Rzw2290xXnditXby50UzQ3KO926LDaSRoIvoWEmeUPDJb4bdw8zR780wNzHEx/vM0wu05XhmBl2L4V7PvQbcyh9eW3D2Ie/nuQgS5xqp90jv07nmnNtzP12dTVqDiOQ83EfxlDv4UNF7Y/850Uwcz/0RrqdZGAJD7tINDOf+JZLVSHlKcacNSmrzhK2apl06Klr5quIt3pRnX32uPCb4NW58Vy53utUJAn5iE65bc7uI+bv6Gi6IEJlD0ZGh3wYLUXIHHilq3Q+rAZ6Vi+wINSrbA1trrSNxq1ajhqZ6MNsnWGBbF8Y+qZldujgWUa/FCjcILiywLgs7FPUxxnWg+v3F/SgvvhbSHlcSA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb24cdb5-887f-4c2c-9c6e-08d8407cceb5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 18:06:46.2250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAQC7t7qOMVEIVxohZ+zeudY92XLuFtywJoFYRPmeT7o6oD6x6EKP4TEd3/6f53c6rk271x3FIF24EL5GFvV0LAYRbRea8xfZw0jIYfbHBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.8.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 14:06:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

14.08.2020 17:57, Alberto Garcia wrote:
> Hi,
> 
> the patch is self-explanatory, but I'm using the cover letter to raise
> a couple of related questions.
> 
> Since commit c8bb23cbdbe / QEMU 4.1.0 (and if the storage backend
> allows it) writing to an image created with preallocation=metadata can
> be slower (20% in my tests) than writing to an image with no
> preallocation at all.
> 
> So:
> 
> a) shall we include a warning in the documentation ("note that this
>     preallocation mode can result in worse performance")?

I think, the best thing to do is to make it work fast in all cases if possible (I assume, that would be, with your patch + positive answer to [b]? Or not?) :)

Andrey recently added a benchmark, with some cases, where c8bb23cbdbe bring benefits:
[PATCH v6] scripts/simplebench: compare write request performance
<1594741846-475697-1-git-send-email-andrey.shinkevich@virtuozzo.com>
queued in Eduardo's python-next: https://github.com/ehabkost/qemu/commit/9519f87d900b0ef30075c749fa097bd93471553f

So, as a first step, could you post your tests, so we can add it into this benchmark? Or post a patch to simplebench on top of Eduardo's python-next.

> 
> b) why don't we also initialize preallocated clusters with
>     QCOW_OFLAG_ZERO? (at least when there's no subclusters involved,
>     i.e. no backing file). This would make reading from them (and
>     writing to them, after this patch) faster.

Probably, they are not guaranteed to be zero on all filesystems? But I think at least in some cases (99% :) we can mark them as ZERO.. Honestly, I may be not aware of actual reasons.

> 
> Berto
> 
> Alberto Garcia (1):
>    qcow2: Skip copy-on-write when allocating a zero cluster
> 
>   include/block/block.h |  2 +-
>   block/commit.c        |  2 +-
>   block/io.c            | 20 +++++++++++++++++---
>   block/mirror.c        |  3 ++-
>   block/qcow2.c         | 26 ++++++++++++++++----------
>   block/replication.c   |  2 +-
>   block/stream.c        |  2 +-
>   qemu-img.c            |  2 +-
>   8 files changed, 40 insertions(+), 19 deletions(-)
> 


-- 
Best regards,
Vladimir

