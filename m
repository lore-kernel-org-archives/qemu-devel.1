Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6BC206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Klw3RYDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6BC206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ld9-0007jg-08
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0lbj-0006wT-Qh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:54:56 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com
 ([40.107.6.91]:9344 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0lbh-0004eM-9x
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH5b0/f3tQNy6opawY7vW9gK29Ov6IuxrSK5yroFfqbgNZ72K5mevgIkiPX24ulxRxA/dEiT8WAMjDypXUqPplIQxMmQZ0Ee/xgUUEklIQusfAeMMYzzWLMJI05zdQi1U0ymy3ggdTVel1TT3lKWktTdTHAbQTjtPtBWQlhBGdIM4FBqKBnpcmZ0CQCcX2UPxrJ16LDAcIsea4jA8VtqaT94EleD/TFOP8O77ALt20vcv+9YBpDgtc6cOhVpuvFoKumCrP1hTx5OmAe8UrVEOLJcsxCMt/GFjk0x0yUOMzBLg8iKnebQuSXcmWkjZgVL/uUFZlOuRqvpkWWzHj3K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXzQRyNsB+FnvjVKKu1k1CE9fjLTYKlkVKF9vm9aiD4=;
 b=R02MxXJ0tRMDLssvc4/R5p0dW9NC+FqvNhZf9Ss2NRmOkJLZRlUtehCjYXCfxcahc/H5oZoUQBZu9uc3hpvE09EYa5ET5Jw3aT/C1XeSTHJsLAnp9fhKUrsnwO7PtXRW0P/mVU+lgIbhlrTXhDlpbplec+AVqZTU3t4kd6/F3CUfBfwPvBE9lqUjQ6SgUTvUtLDaaoAOBmz+aEzPfXaIK7iF5cQx7lI+PuMCGU7Qg7Z1QQdCoBmX6+1d6eDQQ7BcuB4RWnv8czUX0gfuh8J68+Y+ODfYeiRjdVemqERw4ABVCtgK0IooBkDoQm3JdWRQxkVvUYwildc4yid9pF4/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXzQRyNsB+FnvjVKKu1k1CE9fjLTYKlkVKF9vm9aiD4=;
 b=Klw3RYDSQ/KivMT0Saj3IjYdt9m/NSdC4sez+TK8rgxqzsfPf3PqG4d1uEcwzHmZV5tcEwETURZpq8KtvBU9X8wstWcZaCaDZHUud8oZIbu5oozTUzeQIWMBlCWqd9Jry9bxkkPneMUNJHF8FtAYveoDGNcG62Fej9x9VzN4qRM=
Authentication-Results: mail.ru; dkim=none (message not signed)
 header.d=none;mail.ru; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3252.eurprd08.prod.outlook.com (2603:10a6:208:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 12:54:50 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 12:54:50 +0000
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
To: Peter Xu <peterx@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
 <20200724000826.GA865413@xz-x1>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <f025a2c9-fe4e-5d0d-5fb8-bed35da77952@virtuozzo.com>
Date: Wed, 29 Jul 2020 15:54:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200724000826.GA865413@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (178.34.161.51) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Wed, 29 Jul 2020 12:54:49 +0000
X-Originating-IP: [178.34.161.51]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f358315-50c2-4593-926c-08d833be9453
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3252CC3CB2953347B9C31BD3CF700@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7BxdahwHMEQhkIBSZQRvPeEPhfBrOBFyj/romSBvOKE63VUJsgecux1SicIp69k9qdYlM1IpnlfxR9MEaHblo/bYAGgEjgtSXH4WBanrQEdyG9DlHrL9P5OHlqI6oj/Bry5vfUCvLd4RuIxsABDThilZ3D7fxRS/8OTvTA9jYs38DELMQscgGrKGZPC4ZDQbR2ywlCUuISEHG+fB31CAWI5hzxzFQ1VnhpT6ZP0+U0oFX2MoELdRGsoKmujIwYlYO9NfON16Itq+SAmFEZ9ZWrJ+ljtCJfO6DEaeLu3yUjXTuKoBHYCbdeQSN8fvZx4oDTiQ6a3bxnwOvOst6OEHVLozaZfRV1gX089eQeZpqzsFhSOGCnW1fGRe59ldGbT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39830400003)(86362001)(53546011)(2906002)(2616005)(956004)(52116002)(31686004)(6916009)(478600001)(6486002)(26005)(16576012)(5660300002)(36756003)(4326008)(83380400001)(8936002)(31696002)(8676002)(316002)(66946007)(66476007)(16526019)(186003)(6666004)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: L+xh15KC6Nb4dWwkmYUcSggbxf7wcBnO4q2oPDwx1zUbTt0dwGFb36lpbN28aPvnGVOYkzQ3MwMqT95/z4iLrRz54F5B+liZc4u7vlkwatSsVL8g0LaOM6pTVyHPPqn0PLLMphaxn07bV9dNUR16SYQfI7gSMPlvMfHi3zhnvlsQ6GpqXJQC/AS5kEyG/7s5z0you0pMe6LmwsJyedBMyhA38/yADvnbcDJ264rpSsSNpKuC+6gCCnQTcXdYZcYWOM8+PNmNWY004X/oEcTrgBLAQVUHj++vr3uhP7m2OGg7wGiMoG9Y7BElTyGyN5ChOBwpQa4gLZ1zfpaRidDdhDXNWIt73/zC/8u6Sv/dIw5j6CdGJnGLA8rwLnvrauuYPQPDeM90QfFdc1MLDjBHOEoq1k+UwjrA9Cv+ZVobcNj8NzVGZOPMFYHuY87cLtJKOm4pfBKta65dlkZ4BxBwTl9fpRb5tp04LhroZaM4OOE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f358315-50c2-4593-926c-08d833be9453
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 12:54:49.9612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+78NQ5OeCsYHUCAeHrceOMZ9eM0vWAwUm+yJ6owSXK30Slt2oQmt2njpvnlQo4Yy3nIaBtsxPP84qyyHVSDFHYEiZNjZuCGMxELdwaIZjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
Received-SPF: pass client-ip=40.107.6.91;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 08:54:51
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
Cc: den_plotnic@mail.ru, quintela@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, den@openvz.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 24.07.2020 03:08, Peter Xu wrote:
> On Wed, Jul 22, 2020 at 11:11:32AM +0300, Denis Plotnikov wrote:
>> +/**
>> + * ram_copy_page: make a page copy
>> + *
>> + * Used in the background snapshot to make a copy of a memeory page.
>> + * Ensures that the memeory page is copied only once.
>> + * When a page copy is done, restores read/write access to the memory
>> + * page.
>> + * If a page is being copied by another thread, wait until the copying
>> + * ends and exit.
>> + *
>> + * Returns:
>> + *   -1 - on error
>> + *    0 - the page wasn't copied by the function call
>> + *    1 - the page has been copied
>> + *
>> + * @block:     RAM block to use
>> + * @page_nr:   the page number to copy
>> + * @page_copy: the pointer to return a page copy
>> + *
>> + */
>> +int ram_copy_page(RAMBlock *block, unsigned long page_nr,
>> +                          void **page_copy)
>> +{
>> +    void *host_page;
>> +    int res = 0;
>> +
>> +    atomic_inc(&ram_state->page_copier_cnt);
>> +
>> +    if (test_and_set_bit_atomic(page_nr, block->touched_map)) {
>> +        while (!test_bit_atomic(page_nr, block->copied_map)) {
>> +            /* the page is being copied -- wait for the end of the copying */
>> +            qemu_event_wait(&ram_state->page_copying_done);
>> +        }
>> +        goto out;
>> +    }
>> +
>> +    *page_copy = ram_page_buffer_get();
>> +    if (!*page_copy) {
>> +        res = -1;
>> +        goto out;
>> +    }
>> +
>> +    host_page = block->host + (page_nr << TARGET_PAGE_BITS);
>> +    memcpy(*page_copy, host_page, TARGET_PAGE_SIZE);
>> +
>> +    if (ram_set_rw(host_page, TARGET_PAGE_SIZE)) {
>> +        ram_page_buffer_free(*page_copy);
>> +        *page_copy = NULL;
>> +        res = -1;
>> +        goto out;
>> +    }
>> +
>> +    set_bit_atomic(page_nr, block->copied_map);
>> +    qemu_event_set(&ram_state->page_copying_done);
>> +    qemu_event_reset(&ram_state->page_copying_done);
>> +
>> +    res = 1;
>> +out:
>> +    atomic_dec(&ram_state->page_copier_cnt);
>> +    return res;
>> +}
> Is ram_set_rw() be called on the page only if a page fault triggered?
> Shouldn't we also do that even in the background thread when we proactively
> copying the pages?
Yes, we should. It's a bug.
>
> Besides current solution, do you think we can make it simpler by only deliver
> the fault request to the background thread?  We can let the background thread
> to do all the rests and IIUC we can drop all the complicated sync bitmaps and
> so on by doing so.  The process can look like:
>
>    - background thread runs the general precopy migration, and,
>
>      - it only does the ram_bulk_stage, which is the first loop, because for
>        snapshot no reason to send a page twice..
>
>      - After copy one page, do ram_set_rw() always, so accessing of this page
>        will never trigger write-protect page fault again,
>
>      - take requests from the unqueue_page() just like what's done in this
>        series, but instead of copying the page, the page request should look
>        exactly like the postcopy one.  We don't need copy_page because the page
>        won't be changed before we unprotect it, so it shiould be safe.  These
>        pages will still be with high priority because when queued it means vcpu
>        writed to this protected page and fault in userfaultfd.  We need to
>        migrate these pages first to unblock them.
>
>    - the fault handler thread only needs to do:
>
>      - when get a uffd-wp message, translate into a postcopy-like request
>        (calculate ramblock and offset), then queue it.  That's all.
>
> I believe we can avoid the copy_page parameter that was passed around, and we
> can also save the two extra bitmaps and the complicated synchronizations.
>
> Do you think this would work?

Yes, it would. This scheme is much simpler. I like it, in general.

I use such a complicated approach to reduce all possible vCPU delays:
if the storage where the snapshot is being saved is quite slow, it could 
lead
to vCPU freezing until the page is fully written to the storage.
So, with the current approach, if not take into account a number of page 
copies limitation,
the worst case is all VM's ram is copied and then written to the storage.
Other words, the current scheme provides minimal vCPU delays and thus 
minimal VM cpu
performance slowdown with the cost of host's memory consumption.
The new scheme is simple, doesn't consume extra host memory but can 
freeze vCPUs for
longer time r because:
* usually memory page coping is faster then memory page writing to a 
storage (think of HDD disk)
* writing page to a disk depends on disk performance and current disk load

So it seems that we have two different strategies:
1. lower CPU delays
2. lower memory usage

To be honest I would start from the yours scheme as it much simler and 
the other if needed in the future.

What do you think?

Denis

> Besides, have we disabled dirty tracking of memslots?  IIUC that's not needed
> for background snapshot too, so neither do we need dirty tracking nor do we
> need to sync the dirty bitmap from outside us (kvm/vhost/...).
>


