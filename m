Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D962074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W+nDghit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D962074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedxu-0007ji-5o
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 08:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jedwg-0006w5-Lu; Fri, 29 May 2020 08:17:06 -0400
Received: from mail-eopbgr140122.outbound.protection.outlook.com
 ([40.107.14.122]:50987 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jedwe-0005i9-2S; Fri, 29 May 2020 08:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCBBejhqQgxX0xKJO1nlWdD/nVaRiPHWfoBWXiu8rzvUpJXQRlr/Z+agb8m3PUxZH1VON5K/QHNI2S8kw2k+/rmnA1j4Lo8ox1rhejgYDLVi/gIJQ1/ybjX2pMmTNKGi31quIQTR+KQDIwW9GdCaCabTtVW9P+Xe9sdBbg6TckJJBDs0pIx95eQT/Y9GuA6e16BSbgW+hhH5Da1TK1C1d7cz6uHYi3tt5i26EfUAfGQJModiVJJEpyFGiVxctZg6UPu85VQJtaOl/ifkGGwsMyCyzJAv2S2xonlESpNFfq2+VDMTa8lMcaLVzgpk0SWrffDXvZl9yXlIw8W/OzAGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycLYpJgCOV+5trUunNZl9OF7idcc3MhXcSAW9rRpEnc=;
 b=kMWLsLgnQEecdD+PS/n/YQ9aGAICOIJ2WGo4BIE0NnyRTXykzL4GrqOkwmak71lnV7TkVu4DCDVMqhf0J9K0YYfh159bbC5cXai/5i2XqvSXXKQkBNEfB5IOoewlC/eB+jFGCiIGLLn6d8fXh5a0NqtWgSuQOAFQngmNKHAxhQ7VacQyjATT/vWCxahT/Qrt+N4PtC0eOwHNGIxqGFcM25al4H2ZqPTntc3zmSz5JDnW4X0x9RDmHEygSAQMrZMr5gOj8RrB2CFzD5hU4sk0Rkc54DwBBcKSe7gq8gjc+YKv+zi/Ag8Ne4jFYBgnTGx06wDDxWtOMXT6mWHHqY2F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycLYpJgCOV+5trUunNZl9OF7idcc3MhXcSAW9rRpEnc=;
 b=W+nDghitjiKGB1k74MLfDID8d6vRLtYSA/nkZHYFhgKfvQ9PhtYJnOWu2wcQeAdlGzm586ADc0z35Gvkf/2ka99fsvCufgNOJFjjiZCQOG8zmK25frhrbPKjXwNpBkSy8DEZEIUldMWK7OIA3SPRXqJ2ga4ZhJK2fOqNxNze0Hc=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 12:16:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 12:16:59 +0000
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <0bfccf62-30e4-8ef7-7f26-1af3a3824a6d@virtuozzo.com>
 <090c8382-192e-bbb3-749e-d83a7df7fba3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b359557d-1fd6-e30b-97bd-55d46c021696@virtuozzo.com>
Date: Fri, 29 May 2020 15:16:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <090c8382-192e-bbb3-749e-d83a7df7fba3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0PR06CA0133.eurprd06.prod.outlook.com (2603:10a6:208:ab::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 12:16:58 +0000
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c4ddc0b-15fe-4bd3-3c51-08d803ca2f9a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399FDAECB794EE0130CCE58C18F0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLqBpxZ3JT88OERhAEuHOqOUfkMNNdj1kceAV5J1SeasrW3T7P7nhzSK/vBl9diwkId6RQNtf38M7M5fl/trByLT8wO4k1ZcpglWjmfc4aGJktryAd/Kjc5t8LU4ocuDf40Viwmni7GCUbwO5vS62M9ZtFB9ZiYAr6IU2aRPXfN0GvNa7GpNRCaNKLOlSUx7iDo0Llk9z9DeqLWfMLd3Pv0i3y4NA9wIzyGOfsgcXknLUm/haxPfyZvCuSySIL7BTArj7JWE3i9+QiR2Mmny2y2u0jQm1sHde4kJxWgB/HT6HCrODzfcdgguCdhwBhDB5OAu+t3Dic1AMO/WRG2V3A5eKKImr6R9uWNMnwPuJcWtZj7rX9ujwCmrT+bgidDn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39840400004)(478600001)(107886003)(83380400001)(36756003)(53546011)(16576012)(316002)(54906003)(86362001)(31686004)(2616005)(8936002)(956004)(66556008)(66946007)(2906002)(52116002)(186003)(16526019)(5660300002)(26005)(4326008)(8676002)(31696002)(66476007)(6486002)(7416002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qHX5hvcXOZaAFgPkQlwQjnbDZlFsNpotYt0ke3DXw8YRoDnSYLfRPquW16uoq+SDt0+4vk6rwbo83xCWWPG2TO+jYiTIuezV528K4lR+lH1DEOly5BWkwqn88rO6SCptnDDoqBoacCPuOhpSLecczujDp3Vomau6yqFV8Y+HIBEydIcPAyNHFtX8twEOA5E9R6gm8MS+GWo3eHv53Mc36iF5EM9n73xJmq2vw1qYfr6Byx/e1TU85yb937uDSoZi/t8sOJiaMPfb/MMiIV2D5TftI55h43p5ebWjwgQ3VCbIfOhP7JRNaK/0rEk7VKwfj8q98ENBzIiBqLEfk25dIHiKw4iP2dj/xuZ2C2NSS46GyJ7ovYmKybYrmqDse4QV8qnABiEAd6XCorIgP1kOU3SgwCY7NfuMUV3T3vOqG+dRKm8ffdw01OSDxz73gAO1usvJxP0BHM7G/InwW6vZpcbbYsuqOh3DLRf5goI8pNjoq7K0Fx8A21ASIQ0DMLmC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4ddc0b-15fe-4bd3-3c51-08d803ca2f9a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 12:16:59.2542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kuUCdFdbGZcmcXF+Pna7J5p2cL9O/61GbaXFUnkswjF1Al2JU2De1f1Jc6QC8ERb/16mZ1QzHJ1rQQDCQ/oVCG3h2OECazRCmhfD0/Ix1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.14.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 08:17:00
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 andrey.shinkevich@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.05.2020 14:58, Eric Blake wrote:
> On 4/2/20 2:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Ping!
>>
>> It's a fix, but not a degradation and I'm afraid too big for 5.0.
>>
>> Still, I think I should ping it anyway. John, I'm afraid, that this all is for your branch :)
> 
> Just noticing this thread, now that we've shuffled bitmaps maintainers. Is there anything here that we still need to include in 5.1?

Yes, we need the whole series.

> 
>>
>>
>> 17.02.2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>>> Original idea of bitmaps postcopy migration is that bitmaps are non
>>> critical data, and their loss is not serious problem. So, using postcopy
>>> method on any failure we should just drop unfinished bitmaps and
>>> continue guest execution.
>>>
>>> However, it doesn't work so. It crashes, fails, it goes to
>>> postcopy-recovery feature. It does anything except for behavior we want.
>>> These series fixes at least some problems with error handling during
>>> bitmaps migration postcopy.
>>>
>>> v1 was "[PATCH 0/7] Fix crashes on early shutdown during bitmaps postcopy"
>>>
>>> v2:
>>>
>>> Most of patches are new or changed a lot.
>>> Only patches 06,07 mostly unchanged, just rebased on refactorings.
>>>
>>> Vladimir Sementsov-Ogievskiy (22):
>>>    migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
>>>    migration/block-dirty-bitmap: rename state structure types
>>>    migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
>>>    migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
>>>    migration/block-dirty-bitmap: refactor state global variables
>>>    migration/block-dirty-bitmap: rename finish_lock to just lock
>>>    migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
>>>    migration/block-dirty-bitmap: keep bitmap state for all bitmaps
>>>    migration/block-dirty-bitmap: relax error handling in incoming part
>>>    migration/block-dirty-bitmap: cancel migration on shutdown
>>>    migration/savevm: don't worry if bitmap migration postcopy failed
>>>    qemu-iotests/199: fix style
>>>    qemu-iotests/199: drop extra constraints
>>>    qemu-iotests/199: better catch postcopy time
>>>    qemu-iotests/199: improve performance: set bitmap by discard
>>>    qemu-iotests/199: change discard patterns
>>>    qemu-iotests/199: increase postcopy period
>>>    python/qemu/machine: add kill() method
>>>    qemu-iotests/199: prepare for new test-cases addition
>>>    qemu-iotests/199: check persistent bitmaps
>>>    qemu-iotests/199: add early shutdown case to bitmaps postcopy
>>>    qemu-iotests/199: add source-killed case to bitmaps postcopy
>>>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: Fam Zheng <fam@euphon.net>
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: Cleber Rosa <crosa@redhat.com>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Cc: qemu-block@nongnu.org
>>> Cc: qemu-devel@nongnu.org
>>> Cc: qemu-stable@nongnu.org # for patch 01
>>>
>>>   migration/migration.h          |   3 +-
>>>   migration/block-dirty-bitmap.c | 444 +++++++++++++++++++++------------
>>>   migration/migration.c          |  15 +-
>>>   migration/savevm.c             |  37 ++-
>>>   python/qemu/machine.py         |  12 +-
>>>   tests/qemu-iotests/199         | 244 ++++++++++++++----
>>>   tests/qemu-iotests/199.out     |   4 +-
>>>   7 files changed, 529 insertions(+), 230 deletions(-)
>>>
>>
>>
> 


-- 
Best regards,
Vladimir

