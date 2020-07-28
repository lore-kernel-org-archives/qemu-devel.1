Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F484C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088632074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fI1Ih1UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088632074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MGB-00008X-7k
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0MF3-0007Mx-1m
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:49:49 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:1974 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0MEz-0004AQ-V0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZymozHT9d/7KBlicKjs0TIHJ3V9Asm9JUA9H7ToI2TDtKLuNdupNN4xRCamSdrKu8Knio+ZtaCyeguaVwsvfi15CQBLUD0dF2OPzSoqJQ/UAok2QL2g+P7kqFvwX3L6SJZuypaxf8BonTzaveHSghJDojuxdbOLdcsQNpUCTx1Uxc0aoHs6Us0RSti/5MKDaJOWdGtPt93zuyQf2zkpixxMN9LV7VU/xCrMLruVbv1M2i5X+IZOpq0cXLGRZ991nMUAlnrmpajvSLCBu1hlsdtOEhi4+tmXdtSXaRWGohstNWWHrtmm0Ck+AKnhfK3hW1TGEwU8wIntiVrzH6Y7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anPZ7t3cGvtb4IvvAGHgOQoF8f4AU5pHmQJ+X3rrV04=;
 b=Sk+v/LCuhMxvI0DK0OTmJr/bzC6QIDlHNkpE4wLw2oTNcbI1yQgJ/hxiMXfKCO7Zk7C/9o0+OqwxOzNW6yvN+o76Rr2bWfKedXq1CfRFoVX7+wP0H9kXdT05nLP9EbAJzJKvJFRoYtCual/i88cH3tzPwtocZRGff1rYTz0huZ41TV6Tg1m9blCLo6Og+cXGIYA+pUtWyCPUAo1j3QI5Rp0tNJVmOeax1/AZhGLUftVZ/e4xs6to+im1F4tZrRoG/sL4zvhYYgDjv1WDzFT7fMDq2H6w72kD7lCB26701w/K0tUd68IvDzodU1sRsUGfHJRiT2vFDndoge78wP7ooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anPZ7t3cGvtb4IvvAGHgOQoF8f4AU5pHmQJ+X3rrV04=;
 b=fI1Ih1UYHQzBvBodA7BZE/eaqnymD/JeKdWAqJpBUvhITIaljvknwuIBbGiCKfjw9l8V3ENgP/HjcoOSlj546c6ZcN43I7foDUIyDsJx8dG+YrXEfwKuQFzDKFbeq5p4eS4zJ8CT6VNI8dwUXTq7XOPNrcphA+zKsRthH3r/9a0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3058.eurprd08.prod.outlook.com (2603:10a6:208:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 28 Jul
 2020 09:34:39 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 09:34:39 +0000
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
 <20200727164848.GR3040@work-vm>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <092ca853-d4ec-788d-6f26-7361714b8dea@virtuozzo.com>
Date: Tue, 28 Jul 2020 12:34:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727164848.GR3040@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:3:76::28) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (178.34.150.43) by
 HE1PR0301CA0018.eurprd03.prod.outlook.com (2603:10a6:3:76::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 09:34:37 +0000
X-Originating-IP: [178.34.150.43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e82b824-dd56-4452-4cb5-08d832d972d6
X-MS-TrafficTypeDiagnostic: AM0PR08MB3058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3058936B1074E47075AEFBF8CF730@AM0PR08MB3058.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQXukdVWkMhLyxJaDSTmyuIxhfq+qnHN7n/2r7nChausYddE/jhvxZeoiKk05s9nVRJoRVGNttaLaElCzKp6JiDtMKm1uUBEPf7vVPkydx1E+DDBbMlPeSkDV+TXnimRtss/vVFr30edtWgsnubEda0FXcIOeGE7iGRm/Bi2YM9DA1YnltDm5FiCC5yUG3WT5jmBUjYPmiOjFwEEjUgpXQb3ZKuDuuVF1JJKrT2EX+49ljmzsGUaTo8FNA2ipTQkp2s73SxqqNeHk2sYtGAC68/ha+SkxGCDvCwiGnc6dhCUMLVKbSDS1TFK9VWLBxXiIIvOwp/MfPgA8N0qOF47jN3CUSL6JfD8bhx7mf0KG5eCRA99JIzWq3DEbB7olOrd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(66946007)(66476007)(66556008)(478600001)(16576012)(316002)(5660300002)(2906002)(6916009)(6486002)(86362001)(83380400001)(31686004)(6666004)(186003)(16526019)(8676002)(107886003)(36756003)(26005)(8936002)(956004)(2616005)(52116002)(53546011)(4326008)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NXZ2eoEgNRV5ChtUZdAxNpJPqH7Ngi3jqY9+wBSCNw5zRlH9Z+hfjqI9h3nyHSuRew7C9mPNWZYEsAmKk9HkNCZfaen1yqorCeF/wPw//IkucB1ZR4Zuw1XPkvzMtKj3N4P57IJAlWiHcSVNqzjINyfEFTwpbR7StV88Y/0KyNiAz0EnMI8A0jvT4ufMPnZwIlLfRTw67IbTfIBBR/Jv/fMPetEjqxRViZ1/FlXzpqKDQ69FDhylBKWM/ZX04YIgoAd83aitEj/mtYJdCQyEgOIviRTfsphijjA9ygeMiqzaRKBmYI5f8ZJYFYlI1H4YRxbJ1Fc4yc6HgyIHnKihDtOj5iGn5k5gAFzv4qX3lugKHGcU7Fsr0dsl7qBHggsVGxSu3XJmP/oDzTl0bGIPpFJXempnyakxM8lGKX9tmKmK3qrOEfyArPViDK/RVsxC1ETmkWBtd2XGNB7t88t++Mm5dpcKObpj5kejGC5JC1m5yw8cyhqyedE+SO8iwTl3ArCeg0NHe8cuAtXoSH2mPL3JqcfdhlBYJ56iYFxJvP/GQpZZZnz2Yt1dmHYk/wWy6hq8DYUoenVlfRZAl9TgCjUp0WYeY5SI4OAT4V4ouvd+eaO2dOliTjcIW0EhdJdZ3YcpUre6KVJQswVJZEg8ow==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e82b824-dd56-4452-4cb5-08d832d972d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:34:39.0203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3J0kjUXwgEyVS++dJpU80uif/MHD6sZkPPxMY6x7FQRUhk/Aj1A10GtJChI/49dPJzMNzf7u3X98UJ8K20LSQrebazY5gx5QKA4JXgkVrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3058
Received-SPF: pass client-ip=40.107.8.111;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 05:49:43
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.07.2020 19:48, Dr. David Alan Gilbert wrote:
> * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
...
>> +static void page_fault_thread_stop(void)
>> +{
>> +    if (page_fault_fd) {
>> +        close(page_fault_fd);
>> +        page_fault_fd = 0;
>> +    }
> I think you need to do that after you've done the quit and join,
> otherwise the fault thread might still be reading this.

Seems to be so
>
>> +    if (thread_quit_fd) {
>> +        uint64_t val = 1;
>> +        int ret;
>> +
>> +        ret = write(thread_quit_fd, &val, sizeof(val));
>> +        assert(ret == sizeof(val));
>> +
>> +        qemu_thread_join(&page_fault_thread);
>> +        close(thread_quit_fd);
>> +        thread_quit_fd = 0;
>> +    }
>> +}
...
>>   /**
>>    * ram_find_and_save_block: finds a dirty page and sends it to f
>>    *
>> @@ -1782,6 +2274,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>>       pss.block = rs->last_seen_block;
>>       pss.page = rs->last_page;
>>       pss.complete_round = false;
>> +    pss.page_copy = NULL;
>>   
>>       if (!pss.block) {
>>           pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
>> @@ -1794,11 +2287,30 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>>           if (!found) {
>>               /* priority queue empty, so just search for something dirty */
>>               found = find_dirty_block(rs, &pss, &again);
>> +
>> +            if (found && migrate_background_snapshot()) {
>> +                /*
>> +                 * make a copy of the page and
>> +                 * pass it to the page search status
>> +                 */
>> +                int ret;
>> +                ret = ram_copy_page(pss.block, pss.page, &pss.page_copy);
> I'm a bit confused about why we hit this; the way I'd thought about your
> code was we turn on the write faulting, do one big save and then fixup
> the faults as the save is happening (doing the copies) as the writes
> hit; so when does this case hit?

To make it more clear, let me draw the whole picture:

When we do background snapshot, the vm is paused untill all vmstate 
EXCEPT ram is saved.
RAM isn't written at all. That vmstate part is saved in the temporary 
buffer.

Then all the RAM is marked as read-only and the vm is un-paused. Note 
that at this moment all vm's vCPUs are
running and can touch any part of memory.
After that, the migration thread starts writing the ram content. Once a 
memory chunk is written, the write protection is removed for that chunk.
If a vCPU wants to write to a memory page which is write protected 
(hasn't been written yet), this write is intercepted, the memory page is 
copied
and queued for writing, the memory page write access is restored. The 
intention behind of that, is to allow vCPU to work with a memory page as 
soon as possible.

Once all the RAM has been written, the rest of the vmstate is written 
from the buffer. This needs to be so because some of the emulated 
devices, saved in that
buffered vmstate part, expects the RAM content to be available first on 
its loading.

I hope this description will make things more clear.
If not, please let me know, so I could add more details.

Denis

> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>


