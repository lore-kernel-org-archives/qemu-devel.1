Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1419C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB9E20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bjKhti6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB9E20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08nn-00068l-T8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08n9-0005RC-Rj; Mon, 27 Jul 2020 15:28:07 -0400
Received: from mail-eopbgr20110.outbound.protection.outlook.com
 ([40.107.2.110]:19050 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08n6-00022O-BR; Mon, 27 Jul 2020 15:28:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABbdoN6SkBtLPTeP/aiaeEtC3Qhj6gyudcsajD84AKYXndVqdiFAh7mGbrvAkyPVs6arWYMq35RvYZEjd9IUzh7t+nWmHvxWLzVrsApB+iCyRys0t/tsZqepfv05J0rITrhKj94ptjEfY57+mTccZiJfotImt0PJQr7o8+bTzM2zj9h7lFV5xD+YpC9Divi+F4dZe6g8S6UysvshEpcTntr8/Ynea/jhqc8EXDe0wbpK65b407Ex3KqY8ojVTfKvhfx8ejTFjsHHKdeOx6zi9AI5kbI17gO2eBdoe6uHGS3vWVP1MwFuHHfpLl5RvuR7h9xtJc4Lo1HsVhRcrqjYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3crDLWD7wn4H5P5VPUkSr498Ii2nZOi2IU2VAcE2i4Y=;
 b=cTlDxL6O0gEw6XELOsFapTpdFeINLOft+4tawcNm8QGABm8H+WjFN11dpuWeLkT8QCGBotbYMfHllpAB/BH81ddlqcaLMehR/T4ey+Rj0hMpdEzHpBzI5aEcV1BoQi3T6h1TM2fdLGCwphvi6PaYhnSo2tYaX/glMP8/A05842ekNwq++RJEJa7s46pXB4zHZ3ZQv5NUEJ7V+U1nsmFzRbrRjEKFkDcKvP+5qAYEy5OJMrPznI9nxHzzBxFtp2I8UxS8Su3Aj8gy4AG2uVJNFLFY4GRD1rAmiaLEN4xwYAoQG8SbYJyBB6JrD8mRJEWF9+PyyWxRA/YhKryYcXWlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3crDLWD7wn4H5P5VPUkSr498Ii2nZOi2IU2VAcE2i4Y=;
 b=bjKhti6YSbk4ysktZcp2HyCDYkN1/F7wKqmSOYTN63xRAGMAM5GsFtN2ITem6IQh+gFhTmlN8GG4prOhqGRXPXqyLvfU+T0bvh/xjwacKSl+k4vJ89ffklxVNK8bZzAvxfeb0YTbcc2c+up06rq/uHYgOlIrsnzPHJuLSW+8+Is=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1649.eurprd08.prod.outlook.com (2603:10a6:203:38::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 19:28:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:28:00 +0000
Subject: Re: [PATCH v3 16/21] migration/block-dirty-bitmap: cancel migration
 on shutdown
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-17-vsementsov@virtuozzo.com>
 <20200727132105.GM3040@work-vm>
 <e027202c-7d9f-1abe-c895-29b240ca0474@virtuozzo.com>
Message-ID: <dea581f1-2129-976d-bebc-1d6f57d4409b@virtuozzo.com>
Date: Mon, 27 Jul 2020 22:27:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e027202c-7d9f-1abe-c895-29b240ca0474@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM4P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 19:27:59 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5e9d3a3-3949-4808-a562-08d832632c3d
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1649BEAF59DBAD1907BB38C4C1720@AM5PR0801MB1649.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVZ/FHPceF0vjubJ9isu2uedn13XKrbwbxzrxkPJlJh/0Sbl8MDAspnZY6mT6Lu+EtmjBd+aDWxprPi6nC+xJmQ3t3tkXcAGTPQYDWWy+3q7hyMjF9DxqGFphzS1o062FFqJUK8cTmKkDYH4ASDkonFPkK3rGks3506SCED/xDccOxsI7L1JV5BqP4wa7KEn2+4aaLu97du6nxHD94E+WHbThNilBxtxbdUEyQqo3OAsTweZ7WqqvTO6+brLS1IcmFaSW6UdOarUExXBh3lKg6V6uxh2j9V4NbBZHm6bIvZjPQ7aH7f8KcbHM/31Ovtk92mvL32fCijrJPVI/o8AM0SgyhSFve2Gu0MzkIzY1AfsaXqvQrt91X/T5mYisBKUzUa97FnMauvda0t72liFBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(478600001)(52116002)(956004)(4326008)(6916009)(16526019)(107886003)(2616005)(6486002)(8676002)(316002)(31686004)(8936002)(83380400001)(186003)(16576012)(86362001)(5660300002)(26005)(66946007)(31696002)(2906002)(7416002)(66556008)(66476007)(36756003)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cN1ZGxLea1+EJFugW8os4361gueaKupY7lNpOxhVWBGKDnhXtgkh1iFfYIhIGAeStXdiyzEXgUdb3irxMFL7qc9c+13Khw5gfDvqup4ZxDwj/+t88kVIRyfB8/VcEcrj4uvcHhledZmST/aHavneSXny2WvVhuTTjuIAvOFOVDeZNFGcwz7v+qTUtSGzuhtFLvy1TEZ1CSRV1iKUfkU04ihe338NVyPZQskrQngFQ/DGbZR89qDpG3LO5Can84Knxh32BM2uKEgyOQCsyBIJW7bAK01T1WtjlIepfI4d17NUzmhaAN6P46uqDkd8BbMxVtxNXD60pgV4D6ES22WPvVPRP28uq+jyUgn+Tj/uVsXUL31ksBbVAczDko90HFEQnfw+qaTsppKRZPsr9BapGeD3dQU1Nk/De+z49Ey8JU5xfBLuDEY+0i+TGqk3sCFANg2GsmlQJstbyzG4KcBil3/rCfFJzGbhf27qA6NUbfV/IX0hNQTJgJUJeI7OJzmP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e9d3a3-3949-4808-a562-08d832632c3d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:28:00.0036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dnwwcVwmBEcDwe7jeo7FGM3yN25qorzomB6I7Wb3pMGflJAk+FcGAjbLBxIlbK1bR4SpJYKhyHbk848dVZCvplbW86RkQGe7QgfCppPIRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1649
Received-SPF: pass client-ip=40.107.2.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:28:02
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 20:06, Vladimir Sementsov-Ogievskiy wrote:
> 27.07.2020 16:21, Dr. David Alan Gilbert wrote:
>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>> If target is turned off prior to postcopy finished, target crashes
>>> because busy bitmaps are found at shutdown.
>>> Canceling incoming migration helps, as it removes all unfinished (and
>>> therefore busy) bitmaps.
>>>
>>> Similarly on source we crash in bdrv_close_all which asserts that all
>>> bdrv states are removed, because bdrv states involved into dirty bitmap
>>> migration are referenced by it. So, we need to cancel outgoing
>>> migration as well.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   migration/migration.h          |  2 ++
>>>   migration/block-dirty-bitmap.c | 16 ++++++++++++++++
>>>   migration/migration.c          | 13 +++++++++++++
>>>   3 files changed, 31 insertions(+)
>>>
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index ab20c756f5..6c6a931d0d 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -335,6 +335,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>>>   void dirty_bitmap_mig_before_vm_start(void);
>>> +void dirty_bitmap_mig_cancel_outgoing(void);
>>> +void dirty_bitmap_mig_cancel_incoming(void);
>>>   void migrate_add_address(SocketAddress *address);
>>>   int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index c24d4614bf..a198ec7278 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -657,6 +657,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
>>>       s->bitmaps = NULL;
>>>   }
>>> +void dirty_bitmap_mig_cancel_outgoing(void)
>>> +{
>>> +    dirty_bitmap_do_save_cleanup(&dbm_state.save);
>>> +}
>>> +
>>> +void dirty_bitmap_mig_cancel_incoming(void)
>>> +{
>>> +    DBMLoadState *s = &dbm_state.load;
>>> +
>>> +    qemu_mutex_lock(&s->lock);
>>> +
>>> +    cancel_incoming_locked(s);
>>> +
>>> +    qemu_mutex_unlock(&s->lock);
>>> +}
>>> +
>>>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>>>   {
>>>       GSList *item;
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 1c61428988..8fe36339db 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -188,6 +188,19 @@ void migration_shutdown(void)
>>>        */
>>>       migrate_fd_cancel(current_migration);
>>>       object_unref(OBJECT(current_migration));
>>> +
>>> +    /*
>>> +     * Cancel outgoing migration of dirty bitmaps. It should
>>> +     * at least unref used block nodes.
>>> +     */
>>> +    dirty_bitmap_mig_cancel_outgoing();
>>> +
>>> +    /*
>>> +     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
>>> +     * are non-critical data, and their loss never considered as
>>> +     * something serious.
>>> +     */
>>> +    dirty_bitmap_mig_cancel_incoming();
>>
>> Are you sure this is the right place to put them - I'm thinking that
>> perhaps the object_unref of current_migration should still be after
>> them?
> 
> Hmm, looks strange, I will check.

It's OK. These functions are operate on global bitmap migration state
which is separate from  current_migration, and do post-processing of
dirty bitmaps, so it's seems OK to do it at last.

> 
>>
>>>   }
>>>   /* For outgoing */
>>> -- 
>>> 2.21.0
>>>
>> -- 
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
> 
> 


-- 
Best regards,
Vladimir

