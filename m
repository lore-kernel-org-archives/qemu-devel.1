Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E95CC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043DF21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BDh1kxsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043DF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6szk-0000IB-8v
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6sz7-0008Fh-AX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6sz5-0004YB-KW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:28:04 -0500
Received: from mail-vi1eur05on2128.outbound.protection.outlook.com
 ([40.107.21.128]:3680 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6sz4-0004MO-So; Wed, 26 Feb 2020 04:28:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC6aMA49FmJFZLk+AKDWm9vYe+dqvP9dO/Lqf7SPTzT4tsQ+JtoQo9+oDrGmfhyWAMpDrodvJPic1jBX3SzE2uSQwcUobmmSwkLLFTmMHg/zI0fvnZqpVJ/ftB29JGHhcNf7t+hYFAbDfGEn5PiJwMI84UFdeuM+nNPg4jScmJKoGvpDUniziRqFHXMf6RQKE+zJn/XE5Wayjvc3So4WQ8YWfaRoq6/TjXzgSdeRCs0wZJgZ2/iNNfij+mF0fOebN10YmHjFAb1rxI8s88gAvhLa+DHwjkko1hOcK7s9DhGs56TYiJOY1bre02HIQwPHAvY9EsdpCrB6Mp2CZat99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Z/NYPSa5qGpF3fnp0N2qO8UQqcFHNB4TJA8Qq4NH4=;
 b=IqMp7X0INFcPyRMWohyjBUkFESdIPexN4dvpQqXc+4KGGx5hwSLqh8hfOrDPjjQVD5DWOOSA5OGR8U51RM+F7q46n1wge86L0KPqvcazaSVBS50bKqqMwtuS4ucde1GPfFhNucw4WNWf0BBkUa4RXcsGvPMOE85IEDcSjfxTzwi/VcWL2KKESBgnLuqv+UIShmY4q3b5P+h3dbSAOkm6J6oV8KsqLgcJ/E2/RiWSrDVgeNCVgASegUiKrmHkqwoBLs7412J+o5xqyzQfWe6p6SzGOvwU1dC/CR4vRQhFE+Hu48o+5Xk5rmmaudg4qj9ghsA5TB3loOIMCzxfxmyN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Z/NYPSa5qGpF3fnp0N2qO8UQqcFHNB4TJA8Qq4NH4=;
 b=BDh1kxsPH4zlBSwo/ilW3CXy3ADyJyCCagZpvwWNQqWJnN0SYjyRC2XNZQieXd5mwrjOseRZrWGrhISdqZQnuxiI3219QlLpauyCPUkQIjeOG5e0fchusjHWri2N3P+rtdsHQ9rdQ7g3aNAKrqCh6snk5EqvbDnuZSddt24cgM4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3656.eurprd08.prod.outlook.com (20.177.116.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:28:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:28:00 +0000
Subject: Re: [PATCH v4 00/10] Further bitmaps improvements
To: qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200226122757470
Message-ID: <144fc2b9-1038-1a73-e6cd-b7e64a1812c6@virtuozzo.com>
Date: Wed, 26 Feb 2020 12:27:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200205112041.6003-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:7:16::43) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR06CA0156.eurprd06.prod.outlook.com (2603:10a6:7:16::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 09:27:58 +0000
X-Tagtoolbar-Keys: D20200226122757470
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d797d1-8e90-4103-cfa2-08d7ba9e2b86
X-MS-TrafficTypeDiagnostic: AM6PR08MB3656:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3656F7717796A4FDD3586F36C1EA0@AM6PR08MB3656.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(136003)(396003)(346002)(366004)(189003)(199004)(16576012)(6486002)(16526019)(2906002)(6916009)(5660300002)(66556008)(316002)(36756003)(956004)(478600001)(66946007)(66476007)(4326008)(186003)(26005)(8676002)(31696002)(2616005)(81156014)(8936002)(31686004)(81166006)(52116002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3656;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1aVyJxK1Z7F2yM8+JVGoq6q0qQR3V6a7AJzUuq4GAG7Bv3jaOPdxHo33uDWspPohH1+3fxj5qkSW0qgmTTnSdATdHHrj9oqUXev1aJ3ZYSjxlNtfcXgEw21tUPD9rnRaUGf7PmFpnnSB+R/Vdlq6ymP7Q24jSxGvGqZZ5KtCVMelcWG7dIronGc/YwTi4S2p95NV9uSNSVLLhCS5JsNDGCIOW7c5bNFIC3n4om65EQKTvyZTrvK3/fXmkswl/ZrAxu3W7O0B4RSnwyS5po31W+h8BU7Av+iPdgDyRcbxHmW2Skg2+XHjKqMTKzZc3RJ4LtvutojTZg2Xq4zf1pBbmKf28dDcghK8CrlXy320o5O/IfDMcTVc9Bmry7WZS1kzJLH7p1rNRdHLGAUrHjkuplx5+WO2ar02UYoXucPc88BxzwU8PhfruLiOJLn8k9L
X-MS-Exchange-AntiSpam-MessageData: tf9xlSjBrI33FagVw66xmRsMWqQholAATc+haSziptedeZLuS0e/Y6/xcWH4218KlvD6pOZkc3oRwe/xEC1YPXibrvoXMD7VmXQuQZyy170S/HTXT+0mhDK7tz0EQy7RSBnEIYPbVmmvSvUVYSYuuA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d797d1-8e90-4103-cfa2-08d7ba9e2b86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 09:27:59.9365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RBUuZw/dogj+izHguqSSwaKAJNHejuCuyrOJKBJYABHtETrz7GZQIzvn4UKYN2mTAfHD4xc6Up5NHnjHG2IRO6ILidK4YHpPfVWa9eLnUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.128
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gently ping.. almost all patches has r-b marks (except for 5 and 8)

05.02.2020 14:20, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
> 
> The main feature here is improvement of _next_dirty_area API, which I'm
> going to use then for backup / block-copy.
> 
> Somehow, I thought that it was merged, but seems I even forgot to send
> v4.
> 
> v4:
> 01-04: add Max's r-b
> 05: switch test_hbitmap_next_zero_check_range args to int64_t too
> 06: fix s/UINT64_MAX/INT64_MAX/ in comment to hbitmap_next_dirty
>      s/firt_dirty_off/first_dirty_off/
>      Context changed due to 05 change, but I keep Max's r-b
> 07: simplify parameter check in hbitmap_next_dirty_area
>      drop initialization in hbitmap_sparse_merge
>      add Max's r-b
> 08: commit message tweak
>      refactor converted flag to separated converted_to_be and can_add
>      do not convert to be automatically in nbd_extent_array_add
>      check uint32 overflow in nbd_extent_array_add
> 10: drop extra check from store_bitmap_data, add Max's r-b
> 
> Vladimir Sementsov-Ogievskiy (10):
>    hbitmap: assert that we don't create bitmap larger than INT64_MAX
>    hbitmap: move hbitmap_iter_next_word to hbitmap.c
>    hbitmap: unpublish hbitmap_iter_skip_words
>    hbitmap: drop meta bitmaps as they are unused
>    block/dirty-bitmap: switch _next_dirty_area and _next_zero to int64_t
>    block/dirty-bitmap: add _next_dirty API
>    block/dirty-bitmap: improve _next_dirty_area API
>    nbd/server: introduce NBDExtentArray
>    nbd/server: use bdrv_dirty_bitmap_next_dirty_area
>    block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty
> 
>   include/block/dirty-bitmap.h |   9 +-
>   include/qemu/hbitmap.h       |  97 +++--------
>   block/dirty-bitmap.c         |  16 +-
>   block/qcow2-bitmap.c         |  15 +-
>   nbd/server.c                 | 251 ++++++++++++++--------------
>   tests/test-hbitmap.c         | 314 +++++++++++++----------------------
>   util/hbitmap.c               | 134 +++++++++------
>   7 files changed, 375 insertions(+), 461 deletions(-)
> 


-- 
Best regards,
Vladimir

