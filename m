Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D522083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gspS93sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D522083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lQv-0001sQ-G9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0lQ9-0001QD-KE
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:42:57 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com
 ([40.107.20.108]:37697 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0lQ6-000362-10
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:42:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoxOfdT5bwrn0RFMKPlMhMHKu09MiBbNoh1oUWZgIisWFpzVRyARFQmu26Cj0Us/+XdqZHscn9pu5keZpzkbRQ6jVwyEwtnc/OUCsSsPWRrZIwzijIn6i2uyQseje36r9rbab/1ZIp9igxatWc0XAFFEkzdWMFeAK2HI6DpUoIr2onfoUrzYKRBwfS0QP7tf+U4KiEaB6EuVH+pwdXKslsrcKGz96D0Wf4W/gfukGVv14lsBEvEAOBTukRuB+d8P6QpHacyxRuA8z3GkZeZK3CWxYtKS0rodkroOxmx7YoCZ8nBNzVouARJtaPajuJKKm2hh9Q1EcyAOpsR7fIXHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL59fhA7dsHV9Pi8KEkSSGO0tdsOFHmY7ZsJrEDSmAA=;
 b=hzJju8PNf7pYTfSRsxMvPkkD1BYAfdhVAbzRw2Aqg5UXPBt/OfTq7Ds4WtYbQ7OmoWfYi+IOurof3lemmUV3ClQcVcWVMHRCLI16SLd8Jcldl9FWiUmtjd2avGNgqiJvegTwyMqLGdINn4f6t1YyYJpAc+5/oEYswa6qhA1NI366nwEZaIodghNPbqK/hqHouBEJ2EfbicG/x1Z5y/BjML8f0zHBTfhE89JPT0BU9TvSXZCqUPRbm0Wrx+zjdFvamVPM7UHSFOmCcuFMrIviB3N/5ZJoLTxB7Zqyk3xyjXqEXyBC25M/tWupQvaWEFJ6LAP1PFsX51w/hfNkgCJBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL59fhA7dsHV9Pi8KEkSSGO0tdsOFHmY7ZsJrEDSmAA=;
 b=gspS93slX342NM+SoU+7R8g7EuI8OIXhBXYFHphuhPhYPXFccf/U1OnDiHyp25crKGaGOkrorJZi54iZvZJQuYCTPqFlGl3jEhVLDxDPlcSaUm4K8jEej9Lna1vGxwKxCrWcSTmM+fMktqSE+xbwE3kt4pnZypYywvCPHGO8Qls=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4227.eurprd08.prod.outlook.com (2603:10a6:208:13d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 12:27:47 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 12:27:47 +0000
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
To: Peter Xu <peterx@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
 <20200723221544.GC831087@xz-x1>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <dcbb0760-1221-3f75-0f1a-27560dc073f7@virtuozzo.com>
Date: Wed, 29 Jul 2020 15:27:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200723221544.GC831087@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0100.eurprd05.prod.outlook.com
 (2603:10a6:207:1::26) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (178.34.161.51) by
 AM3PR05CA0100.eurprd05.prod.outlook.com (2603:10a6:207:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 12:27:46 +0000
X-Originating-IP: [178.34.161.51]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022e24ac-b873-427f-4403-08d833bacd3a
X-MS-TrafficTypeDiagnostic: AM0PR08MB4227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4227DAEE908C8593F4604343CF700@AM0PR08MB4227.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUpGIlODhdRcyUghl2ZqypDvNJ+Vb6nARl6jmPV+oflrnLwd51tRrXoXKjdv11g9GYMyR6CmxxO9Nn2H9L1CWzV28mlwVVUC5gq+2dmb+CGGFvoDZL63XOhbr+WBdNQdudo1LKz/N4Fox6QF7C3IBNT3Z+010DDXdfqFWPQcqqSM0q4+y6qS2y3a31tXXbXzGGcZzHjk0Ku0tiLVyt5Z4zai2qAu/k+4Sv/C14R+Gr5MSsduT0HlDCHcGqNP2pImS2gwDFm5QMpQJVw2wNrMABeKMqT9Dz/Duc/gFJ7Es7pOjHFa1TUfMf0rAI6y/wAfzFUDrlNYvjLs+anWvFiTpYf5K9KO4FcfiXlHyqWzI6bpVbbZ7p9XPWX5MYbp/RCH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39830400003)(396003)(136003)(366004)(346002)(31686004)(66946007)(36756003)(86362001)(6486002)(8676002)(8936002)(6916009)(2906002)(66476007)(66556008)(956004)(2616005)(83380400001)(53546011)(16526019)(478600001)(52116002)(4326008)(31696002)(186003)(16576012)(316002)(26005)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CXi8t0xMn19Ho0rOLduLSnkUTBcRjSCeYH0VugLmk/x7uMwkgOywQiSSEmu2MMq1zdx4wkn47an8TI8GcTwe7+9TfqHrQLzTRSr1uT2l1/6DqdcJ3mEHiZrll/IbLppdkiWzLZ7Onw6GN0YnhWO9L77BDJDWMeTtAvluiKsLpl8gFJSA5txRCHhC5a2gSiN+JZBXANb5YefUayxghw2sOag6k9lI+nCKILd9mZb4Shb+JkAjm+NECHIUt1ht0xUoNXjVzVfzfcoRnji14N4A/EgVMUzk7XWqRPBwBvzVyTLiyk0na9mB7owQxO6spZbgvXs46JzhT0U903Q3gEr5i/xqB8P9pab2no1dRszRJiX6Bch6FKTyY5lx4+m8ap/XmS3oviRNev3xYsOirAqJrjVpHmzEOWE4bT40b1iBfjdDEHUbeDCWPZtv+/OhiTFwzM7bvS4A56hEt1PD/u2LXmuZwWKUhxsgexf9NRLPyY4hYwNBKf1L3Py8LxNul2GV+A67r3cOPMt6S7PxBKSoBmYqYYrs9PkE0KL9uJ0c+osRR9FZqog23OW9Sn+3QiOl0RRAJWUI2cHq1YWAa15jWELM0Kun+SvcFcHGaPb3cTo7Q6zVHtXoN9XQPq4QW4fgKSTzKfy/jDN6Oumxcjy8tw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022e24ac-b873-427f-4403-08d833bacd3a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 12:27:47.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT+8wOMhOHiQnjfDiYKTg7qiF8hkROh1ar57PRgQS2/Z6T311IpJMaW5Hv++QVh0TT8k2ypMgDsRwva7YXZt3Qvuapx8yzhScjRflj9sZcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4227
Received-SPF: pass client-ip=40.107.20.108;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 08:42:51
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 24.07.2020 01:15, Peter Xu wrote:
> On Wed, Jul 22, 2020 at 11:11:32AM +0300, Denis Plotnikov wrote:
>> +static void *background_snapshot_thread(void *opaque)
>> +{
>> +    MigrationState *m = opaque;
>> +    QIOChannelBuffer *bioc;
>> +    QEMUFile *fb;
>> +    int res = 0;
>> +
>> +    rcu_register_thread();
>> +
>> +    qemu_file_set_rate_limit(m->to_dst_file, INT64_MAX);
>> +
>> +    qemu_mutex_lock_iothread();
>> +    vm_stop(RUN_STATE_PAUSED);
>> +
>> +    qemu_savevm_state_header(m->to_dst_file);
>> +    qemu_mutex_unlock_iothread();
>> +    qemu_savevm_state_setup(m->to_dst_file);
> Is it intended to skip bql for the setup phase?  IIUC the main thread could
> start the vm before we take the lock again below if we released it...

Good point!
>
>> +    qemu_mutex_lock_iothread();
>> +
>> +    migrate_set_state(&m->state, MIGRATION_STATUS_SETUP,
>> +                      MIGRATION_STATUS_ACTIVE);
>> +
>> +    /*
>> +     * We want to save the vm state for the moment when the snapshot saving was
>> +     * called but also we want to write RAM content with vm running. The RAM
>> +     * content should appear first in the vmstate.
>> +     * So, we first, save non-ram part of the vmstate to the temporary, buffer,
>> +     * then write ram part of the vmstate to the migration stream with vCPUs
>> +     * running and, finally, write the non-ram part of the vmstate from the
>> +     * buffer to the migration stream.
>> +     */
>> +    bioc = qio_channel_buffer_new(4096);
>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vmstate-buffer");
>> +    fb = qemu_fopen_channel_output(QIO_CHANNEL(bioc));
>> +    object_unref(OBJECT(bioc));
>> +
>> +    if (ram_write_tracking_start()) {
>> +        goto failed_resume;
>> +    }
>> +
>> +    if (global_state_store()) {
>> +        goto failed_resume;
>> +    }
> Is this needed?  We should be always in stopped state here, right?
Yes, seems it isn't needed
>
>> +
>> +    cpu_synchronize_all_states();
>> +
>> +    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false, false)) {
>> +        goto failed_resume;
>> +    }
>> +
>> +    vm_start();
>> +    qemu_mutex_unlock_iothread();
>> +
>> +    while (!res) {
>> +        res = qemu_savevm_state_iterate(m->to_dst_file, false);
>> +
>> +        if (res < 0 || qemu_file_get_error(m->to_dst_file)) {
>> +            goto failed;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * By this moment we have RAM content saved into the migration stream.
>> +     * The next step is to flush the non-ram content (vm devices state)
>> +     * right after the ram content. The device state was stored in
>> +     * the temporary buffer prior to the ram saving.
>> +     */
>> +    qemu_put_buffer(m->to_dst_file, bioc->data, bioc->usage);
>> +    qemu_fflush(m->to_dst_file);
>> +
>> +    if (qemu_file_get_error(m->to_dst_file)) {
>> +        goto failed;
>> +    }
>> +
>> +    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
>> +                                 MIGRATION_STATUS_COMPLETED);
>> +    goto exit;
>> +
>> +failed_resume:
>> +    vm_start();
>> +    qemu_mutex_unlock_iothread();
>> +failed:
>> +    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
>> +                      MIGRATION_STATUS_FAILED);
>> +exit:
>> +    ram_write_tracking_stop();
>> +    qemu_fclose(fb);
>> +    qemu_mutex_lock_iothread();
>> +    qemu_savevm_state_cleanup();
>> +    qemu_mutex_unlock_iothread();
>> +    rcu_unregister_thread();
>> +    return NULL;
>> +}
>> +
>>   void migrate_fd_connect(MigrationState *s, Error *error_in)
>>   {
>>       Error *local_err = NULL;
>> @@ -3599,8 +3694,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>           migrate_fd_cleanup(s);
>>           return;
>>       }
>> -    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
>> -                       QEMU_THREAD_JOINABLE);
>> +    if (migrate_background_snapshot()) {
>> +        qemu_thread_create(&s->thread, "bg_snapshot",
> Maybe the name "live_snapshot" suites more (since the other one is
> "live_migration")?

looks like it, another good name is async_snapshot and all the related 
function and properties should be rename accordingly
>
>> +                           background_snapshot_thread, s,
>> +                           QEMU_THREAD_JOINABLE);
>> +    } else {
>> +        qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
>> +                           QEMU_THREAD_JOINABLE);
>> +    }
>>       s->migration_thread_running = true;
>>   }
>>   
> [...]
>
>> @@ -1151,9 +1188,11 @@ static int save_normal_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
>>       ram_counters.transferred += save_page_header(rs, rs->f, block,
>>                                                    offset | RAM_SAVE_FLAG_PAGE);
>>       if (async) {
>> -        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE,
>> -                              migrate_release_ram() &
>> -                              migration_in_postcopy());
>> +        bool may_free = migrate_background_snapshot() ||
>> +                        (migrate_release_ram() &&
>> +                         migration_in_postcopy());
> Does background snapshot need to free the memory?  /me confused..
Yes, for the page copies. No, for the rest of the pages.
>
>> +
>> +        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE, may_free);
>>       } else {
>>           qemu_put_buffer(rs->f, buf, TARGET_PAGE_SIZE);
>>       }
> [...]
>
>> +void ram_block_list_create(void)
>> +{
>> +    RAMBlock *block = NULL;
>> +    RamBlockList *block_list = ram_bgs_block_list_get();
>> +
>> +    qemu_mutex_lock_ramlist();
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        memory_region_ref(block->mr);
>> +        QLIST_INSERT_HEAD(block_list, block, bgs_next);
>> +    }
>> +    qemu_mutex_unlock_ramlist();
> This kind of duplicate with ram_list.blocks itself...
>
>> +}
>> +
>> +static int page_fault_fd;
>> +static int thread_quit_fd;
>> +static QemuThread page_fault_thread;
>> +
>> +static int mem_change_wp(void *addr, uint64_t length, bool protect)
>> +{
>> +    struct uffdio_writeprotect wp = { 0 };
>> +
>> +    assert(page_fault_fd);
>> +
>> +    if (protect) {
>> +        struct uffdio_register reg = { 0 };
>> +
>> +        reg.mode = UFFDIO_REGISTER_MODE_WP;
>> +        reg.range.start = (uint64_t) addr;
>> +        reg.range.len = length;
>> +
>> +        if (ioctl(page_fault_fd, UFFDIO_REGISTER, &reg)) {
>> +            error_report("Can't register memeory at %p len: %"PRIu64
>> +                         " for page fault interception", addr, length);
>> +            return -1;
>> +        }
> IMHO it's better to move the register out of mem_change_wp().  mem_change_wp()
> should be in page granularity, while we should be clear in the code that the
> registeration is happening per-ramblock.

so, will move it
>
> Btw, is UFFDIO_UNREGISTER missing in the whole process?

yeah
>
>> +
>> +        wp.mode = UFFDIO_WRITEPROTECT_MODE_WP;
>> +    }
> [...]
>
>> @@ -2338,6 +2881,11 @@ static void ram_list_init_bitmaps(void)
>>               bitmap_set(block->bmap, 0, pages);
>>               block->clear_bmap_shift = shift;
>>               block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
>> +
>> +            if (migrate_background_snapshot()) {
>> +                block->touched_map = bitmap_new(pages);
>> +                block->copied_map = bitmap_new(pages);
>> +            }
> We should be able to avoid allocating bmap & clear_bmap for snapshots.Or we
> can also directly reuse the two bitmaps?
>
Probably, yes

