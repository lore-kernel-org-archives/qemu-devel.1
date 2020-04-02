Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D582C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C320208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NN/LzJXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C320208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJuVI-00021Z-67
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 03:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJuUd-0001Q8-C4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJuUc-0005nG-7x
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:42:27 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com
 ([40.107.2.113]:59265 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJuUV-0005Xv-8x; Thu, 02 Apr 2020 03:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ4FaJspVR9RVDK1FmW5QINGBvkKxHUm+ohJbTdSe6WTFw+EFgpNGW413oY8/BuYC7JoCN3JljV6MB7PvQvORA4vFtnET0WYERCUgpq1sPLuf+AHZCTx2v3M4G/mY+Emj64X4r9Vea3OqQW0ciU5xbF3Qkc3iLJ0708HVFV+WR15KBhj6OKdQhTWo0mNbDMJbyoJX4fuXpXF46q34HbLlZXnJtcaXlXkjjpHSDs/EmU3BVOAptq3wwwzzBTMpZnErjTAEWPQeWo2Ra714NZ8gCZroYokE4r1GF1CVQzse0JsmGLabHblvy9Non1nV3bwKnUQkEoV/f38yYPc4NT3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gou/4LO68+sabwiEaBMfTU57ug7iMqI4ZpZdRn3rfJc=;
 b=WcOX2RogLecExD8Hnlkf/rhLtdkreF2FKG1yrwAVivMrSyPeePoSODAbcwYn0TYVziB26B19GX/BJtzCvX2u3CHPlgG9q4uW3dW/KSwQwv2QCo/X5nRmlsylXWrKjqO65AE1VpYO7qsKybfA9RqR+gJltQAMeF66Fr62PxCPC85oyxlXwMwyUzoeZXiAUTWd5jDCznFPJUFr16Z49VMACVsdLtxikA0dLHizCNPxrsR/Gbmg3TEzC9zyuFg8DKqad0trfYlKcTiEGEDHpdTOdgXBrobAnuLiLmFodY7C5+BPvQHA2kgQJgVftn9hDQaeqJY/ZUV7jtYOp01Rt6xFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gou/4LO68+sabwiEaBMfTU57ug7iMqI4ZpZdRn3rfJc=;
 b=NN/LzJXzbp44Y6WyMKr4MaQx5FZK0dOF2NwuvIyDvK0tI3bb4lhRMkYkbqdv/OsDPFdUXDmGW2SmZdeivfHcc4tBgMdqTtoit2KuUSQ8wwh9BTtfPZvwHRDd/ul2U92KxfXr3sv7ndulFQ2FN34qTSVRqEQLyZp//1FsUTrrH98=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5463.eurprd08.prod.outlook.com (10.141.172.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 07:42:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 07:42:15 +0000
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402104212040
Message-ID: <0bfccf62-30e4-8ef7-7f26-1af3a3824a6d@virtuozzo.com>
Date: Thu, 2 Apr 2020 10:42:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0097.eurprd02.prod.outlook.com
 (2603:10a6:208:154::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR02CA0097.eurprd02.prod.outlook.com (2603:10a6:208:154::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Thu, 2 Apr 2020 07:42:14 +0000
X-Tagtoolbar-Keys: D20200402104212040
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ade308-c41d-445e-82bf-08d7d6d95cc3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463CCBE3B67F53AC750A17AC1C60@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(136003)(366004)(396003)(39840400004)(956004)(26005)(66476007)(31686004)(478600001)(54906003)(2616005)(5660300002)(52116002)(66946007)(81156014)(66556008)(6486002)(8936002)(81166006)(7416002)(186003)(6916009)(31696002)(4326008)(16576012)(16526019)(2906002)(316002)(36756003)(8676002)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Vbzrza2IlAxe9B9vIYkSWv7OhNeHs94WZFKKPdEcnxFFMGVH3mGClbSuWBoOlAfkqBg1YXfUb9+yRsTO+oIn7302XzHoKAxuWWlW4kcbMnQPJN873+2qnVA4IeVbv9Z9zLbJV0AuAnsgpR8Y/3MakGnXm/xPszNwONafOs1ktB3fFtgCVm7EyUXzWQHD6X+h+v5ugzI9jL0UrvixRVT15UruOBk1CvYGwgU4vDwz6wwULzuYkiYRHVc9ei8lGSWgSHFvUYadUMgKgmJJNB4V+5DQ9TNESa3SNRUOY5Xebv3g82E6WqHMbW+Zc+/pFpDkKhQc3iRjgPddwABwPS+6l9rcQ1PNc+gqOGUfGOONs9sVXgvavpLTKyfxaCy+O7gf137qHy6n7OJudu8K7B90BLcFs8wtoCelmAL7TaSNeDfW7Fz+FBxP9fTyIdA6YMu
X-MS-Exchange-AntiSpam-MessageData: txCxFE+d5oMxv5X9+G5900/Z3LsDfa2eDdZzseItOlH5M1MtbfGzmrQDVwtaUEUaL/M+MjhvuvD2NDexkpHN0R2eiMNs3QR1v5ler/1omTqaeNfrf7mq4uB5WEpre0JOF9gFiLUZN+s0md8MK/5A6g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ade308-c41d-445e-82bf-08d7d6d95cc3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 07:42:15.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTfIbjFm/CL8KsmNLaq1UIn53LxMHonty6VxFsjiX5sqob9HUsN2r/EEj4Do/l5C4IR59h9w77GD5GrsOcPO7EvHEE3ZjbwARVfvTx4T8M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.2.113
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, andrey.shinkevich@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping!

It's a fix, but not a degradation and I'm afraid too big for 5.0.

Still, I think I should ping it anyway. John, I'm afraid, that this all is for your branch :)


17.02.2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Original idea of bitmaps postcopy migration is that bitmaps are non
> critical data, and their loss is not serious problem. So, using postcopy
> method on any failure we should just drop unfinished bitmaps and
> continue guest execution.
> 
> However, it doesn't work so. It crashes, fails, it goes to
> postcopy-recovery feature. It does anything except for behavior we want.
> These series fixes at least some problems with error handling during
> bitmaps migration postcopy.
> 
> v1 was "[PATCH 0/7] Fix crashes on early shutdown during bitmaps postcopy"
> 
> v2:
> 
> Most of patches are new or changed a lot.
> Only patches 06,07 mostly unchanged, just rebased on refactorings.
> 
> Vladimir Sementsov-Ogievskiy (22):
>    migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
>    migration/block-dirty-bitmap: rename state structure types
>    migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
>    migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
>    migration/block-dirty-bitmap: refactor state global variables
>    migration/block-dirty-bitmap: rename finish_lock to just lock
>    migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
>    migration/block-dirty-bitmap: keep bitmap state for all bitmaps
>    migration/block-dirty-bitmap: relax error handling in incoming part
>    migration/block-dirty-bitmap: cancel migration on shutdown
>    migration/savevm: don't worry if bitmap migration postcopy failed
>    qemu-iotests/199: fix style
>    qemu-iotests/199: drop extra constraints
>    qemu-iotests/199: better catch postcopy time
>    qemu-iotests/199: improve performance: set bitmap by discard
>    qemu-iotests/199: change discard patterns
>    qemu-iotests/199: increase postcopy period
>    python/qemu/machine: add kill() method
>    qemu-iotests/199: prepare for new test-cases addition
>    qemu-iotests/199: check persistent bitmaps
>    qemu-iotests/199: add early shutdown case to bitmaps postcopy
>    qemu-iotests/199: add source-killed case to bitmaps postcopy
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Cleber Rosa <crosa@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> Cc: qemu-stable@nongnu.org # for patch 01
> 
>   migration/migration.h          |   3 +-
>   migration/block-dirty-bitmap.c | 444 +++++++++++++++++++++------------
>   migration/migration.c          |  15 +-
>   migration/savevm.c             |  37 ++-
>   python/qemu/machine.py         |  12 +-
>   tests/qemu-iotests/199         | 244 ++++++++++++++----
>   tests/qemu-iotests/199.out     |   4 +-
>   7 files changed, 529 insertions(+), 230 deletions(-)
> 


-- 
Best regards,
Vladimir

