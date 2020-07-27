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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B44C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1E0206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m/bneLmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1E0206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k06bF-0002sn-KZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k06aa-0002QE-Io; Mon, 27 Jul 2020 13:07:00 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:32398 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k06aX-0001Dr-UU; Mon, 27 Jul 2020 13:07:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkZVLH15N5hD94uwWLJ+4QYbfi2pa7wqXCW28WYVOhdte1V04w5lf4BIvdJk55YyRhkY4EIDwbC/yRaCCwQ2zy1tSilDWLZQQQW9zfYzQHiJuATWfvlXiImacbbbnVpp8EGYOKQwpz9boCNq5jhW6a5O+o9la6spnsNr1TrekTUjxVummKoSnE25mAD8wBVqwOQh9Z8BNLR2aZI4EZEzhUjR60jLzZEc1VQOPfBcNc0Xa6DgeOJEFBWYy87FzP0HWvvt/hte2apDwzkOCshLSo8W6gXLYGE/MlC3uXlDiMJVwcY88M6N1qYFwFUK0nnpobDvucyaqiNc3jVkmsKT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKUyr/7vDSiImCWDdgW4NnEf75xmovbmQwvYXmf5nK8=;
 b=ZE7EDhqs8dY0KL33ztnXrX+HkD0/quFxkUi7xxnDif09hm8GxrCLE7zKO1Z05t9fyyzQaiZ/Un/mxYNcAsXlOBNpLni0/CmcZQL5GnVp4Fg/xfNKNeXtZnoTmx0dWkMYFEUElWrJyWy6qkMeRR5p6arLbzky6oA2JeWl8AqZ8iGjv4/N+0ZbJ2DdMwMcpLJ7lZWOPN1kDs9vwKabLrThToUMRd/WFmycQUmVpMjAW8kYIzJu0rYbkpVfCJJLICQdWx7zyfV+rHO6ZrPyvHgR9V15AneqCdLW3zMOPq1D8XtZyKQiQ8gAc0czQeL9S98ekpEny+V82hsFaM7gEdKtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKUyr/7vDSiImCWDdgW4NnEf75xmovbmQwvYXmf5nK8=;
 b=m/bneLmLvbQp0pxRBwxqqr8zZTp4qClTuWSjfJl1IECe+jSmCHA4VDsSqyb9F9qYVYMrjhWzdrJLsXkIBj+lVMl85b70DvFyMrT8bg5/6Mn96MaJ9VpUCk5XATsKpGqjyiZPv7hNbbjlRmn6J317ScJVkVZWO78Q4tXoXnIpP6Y=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5127.eurprd08.prod.outlook.com (2603:10a6:20b:e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 17:06:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 17:06:53 +0000
Subject: Re: [PATCH v3 16/21] migration/block-dirty-bitmap: cancel migration
 on shutdown
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-17-vsementsov@virtuozzo.com>
 <20200727132105.GM3040@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e027202c-7d9f-1abe-c895-29b240ca0474@virtuozzo.com>
Date: Mon, 27 Jul 2020 20:06:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727132105.GM3040@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0132.eurprd05.prod.outlook.com
 (2603:10a6:207:2::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM3PR05CA0132.eurprd05.prod.outlook.com (2603:10a6:207:2::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 17:06:52 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef52fc6-4644-4ae2-0036-08d8324f75d4
X-MS-TrafficTypeDiagnostic: AM6PR08MB5127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5127079F9E1A4EE52849493AC1720@AM6PR08MB5127.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ST5YWLX5FJEt80WnDFgFVGah9EY8dbZf4RFaq7NAZ08z6MkBYvwNa6qQ7tpH008IE4Jvk4cwJdh7V4hlCMHjpSdoJnCX4+dZ0S4n0YUYrWeG5Vhu/ySrdwu/ebtPQeYdRf3TiF9RXn30cobDTXmRwSR7oB9tjaSxfvoIEqXHu66TM/kJdKqgHqYzdB5A6H4WTJcHF6AxeJM4Ei+To2TSHINgh2dcGICPVV5C1mXs8nQIeRVgoYE5P3H9ktUbM483btvfHOFtZ3ytlHwnsQ8ndvKEfp3BatiqFKkQOlzGqRA9XKdwTAiE5fgx/GDE84i4SlODASQZg56ncZPIK7ysqFpMlkXuQJjSfFeg6ax9wYtvrKF/yCfWzgK3DSVrybsZa7bW5VNmds7BDQFW2Zwdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(346002)(396003)(366004)(136003)(8676002)(4326008)(5660300002)(107886003)(316002)(16576012)(956004)(36756003)(7416002)(31686004)(186003)(2616005)(83380400001)(16526019)(52116002)(6916009)(8936002)(31696002)(6486002)(478600001)(66946007)(86362001)(2906002)(26005)(66476007)(66556008)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iw60RhT4kHYROAHEQOPeHK9AkqqhhJ3/ESQVTFcUDANryUtnmPVodR6t7P1gJyTUctC1jrKCys9zyfUu3TMwWdbJIdMjKi7QcBOPxLn4x/RYAszcPVTBAClBKx1Zdt+pmZRIfevw9COn+MaqqkyjqF2LA4kH2N7j93/EMSkO8WHtX/tsGipPGyZPbR4OGtHgMstOw631LCenX6gu03f76ZC9+fWo8IDaGCyZChD6zvo3Ef/rvdo/GeZK0P59a6A4ne1iqu1GRBS6ZV0yqK4U6yTmxBH6uQXArrjLztO9/bTN3TfPXVbWCBfJQkdt65TAeBXUJwvbDT5QwHnbGzQXKITCOc19s3ksA4VMB6bYtr1ZaGFrMwmc3Noc65vhZLjBvJ4hjfzYSA85u3m93+IW6gRxaVMAMRkmvGSQxcpOCXpOgEShJgus7ZdZOKLI0xg1SudM0O5KIYO52XhNb696jDUqzkXUEzNlrC00uA/9diu3ODfcQChoyLYT1Xj8fzmT
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef52fc6-4644-4ae2-0036-08d8324f75d4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 17:06:53.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKEPFEHDVmwyv2IOQyRminGXCLaA6+ruOUVj3Xf5iPT0aQMxMngjkcP+iOSsioYZt8hkxoEFX1V7/EcFQK6iTbgLIV2HH9x4HZFKnvxdCOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5127
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 13:06:55
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

27.07.2020 16:21, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> If target is turned off prior to postcopy finished, target crashes
>> because busy bitmaps are found at shutdown.
>> Canceling incoming migration helps, as it removes all unfinished (and
>> therefore busy) bitmaps.
>>
>> Similarly on source we crash in bdrv_close_all which asserts that all
>> bdrv states are removed, because bdrv states involved into dirty bitmap
>> migration are referenced by it. So, we need to cancel outgoing
>> migration as well.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   migration/migration.h          |  2 ++
>>   migration/block-dirty-bitmap.c | 16 ++++++++++++++++
>>   migration/migration.c          | 13 +++++++++++++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index ab20c756f5..6c6a931d0d 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -335,6 +335,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>>   
>>   void dirty_bitmap_mig_before_vm_start(void);
>> +void dirty_bitmap_mig_cancel_outgoing(void);
>> +void dirty_bitmap_mig_cancel_incoming(void);
>>   void migrate_add_address(SocketAddress *address);
>>   
>>   int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index c24d4614bf..a198ec7278 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -657,6 +657,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
>>       s->bitmaps = NULL;
>>   }
>>   
>> +void dirty_bitmap_mig_cancel_outgoing(void)
>> +{
>> +    dirty_bitmap_do_save_cleanup(&dbm_state.save);
>> +}
>> +
>> +void dirty_bitmap_mig_cancel_incoming(void)
>> +{
>> +    DBMLoadState *s = &dbm_state.load;
>> +
>> +    qemu_mutex_lock(&s->lock);
>> +
>> +    cancel_incoming_locked(s);
>> +
>> +    qemu_mutex_unlock(&s->lock);
>> +}
>> +
>>   static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>>   {
>>       GSList *item;
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 1c61428988..8fe36339db 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -188,6 +188,19 @@ void migration_shutdown(void)
>>        */
>>       migrate_fd_cancel(current_migration);
>>       object_unref(OBJECT(current_migration));
>> +
>> +    /*
>> +     * Cancel outgoing migration of dirty bitmaps. It should
>> +     * at least unref used block nodes.
>> +     */
>> +    dirty_bitmap_mig_cancel_outgoing();
>> +
>> +    /*
>> +     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
>> +     * are non-critical data, and their loss never considered as
>> +     * something serious.
>> +     */
>> +    dirty_bitmap_mig_cancel_incoming();
> 
> Are you sure this is the right place to put them - I'm thinking that
> perhaps the object_unref of current_migration should still be after
> them?

Hmm, looks strange, I will check.

> 
>>   }
>>   
>>   /* For outgoing */
>> -- 
>> 2.21.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


-- 
Best regards,
Vladimir

