Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24968C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D53206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DOTNZFz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D53206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKiv-00064c-3H
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOKgv-0004Cp-I3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOKgu-0007oa-Bn
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:29:25 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:18699 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOKgp-0007lB-VS; Tue, 14 Apr 2020 08:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6DfHNWukLIvr1yMrGmtRdQdAjGSiUHEVj+D8vK5fl5vRXpTcQLYlmkCSyoldjNhxEEiZBYKnsz5T9N5D/xhAH5A5uKe0cihENHSekMnv12zrhV73QbA+hCQ9D+EZ4aAlWpFOCXvE3OrDuuPJLl7pAFOakM2vVZK1s8TRlzqS2cDLTUajUQOsTz2mfzHYzQVZOMo12kwz/VT9wPvxe6EIUl7pDU7sohKGzdoNv/pswtogua0kkJuvYVUFmwsXEEE4SRFCcByxQYWaPHVRPP+WvjR7qJBBgh0ZZjazIPUHNV3igbKs+Np0VRqAcl/vxGiZZLem2N55f00iND6SFhXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpfyVbIYkKLTHueyOyHMmTjsELSMoUYRukJ37Lfq5qc=;
 b=EThBhnoS7ZCsgMkA5EScQppEF+qbUzAsr1ZBQM1bZYV1+d0NXqaudS2sw+Gnb99PRPHKbSfhx5DYF7NSE4QP58UhLESjLTmXIoZ+OUobzhYif67BlzzYPOj33ZK3+DQIACY/02fm4tFR+UbnN/EgDT3R9JutGaraobAMVuAD3uHwi3GiblC1SZw4DAKDRSLE8t6fmH0SQCTvk/Ye2OAKVnmUquWnF7l+TuZ/gLAIDkl86S5DbhKRJefmPqeaj7JmZ675tG4cyttwmccRcPZwcvEoAl8CkezUlntb5y3QgCCEv2FvHQG8aXmooyK3iLHkyWe2ZZolpZYXI4w6YNylLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpfyVbIYkKLTHueyOyHMmTjsELSMoUYRukJ37Lfq5qc=;
 b=DOTNZFz1UwM8apelthAWnstwOmCqySAU6D1N93/8cNmqqmr6Wp/MwsHeaB53p7UItR476OEwiIS4aybEMOghWHXCKvtQ+LrrIdI+hxTQVtKq9gaaJEp9MXQeoqyi93OsaJZPrftmN5+JCW59cFjCHMycd4vBLLTb4QEBFDVfHdo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 12:29:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:29:16 +0000
Subject: Re: [PATCH v4 11/30] qcow2: Add l2_entry_size()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <fd0f93353a218ff4518f34ebdbca05c2fc0f1085.1584468723.git.berto@igalia.com>
 <58d1fa17-91ea-9f8d-c39a-4141783d1234@virtuozzo.com>
 <w51y2qy5kd6.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414152913886
Message-ID: <9695a347-b490-12b2-8a01-09ad8bdb8eb9@virtuozzo.com>
Date: Tue, 14 Apr 2020 15:29:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51y2qy5kd6.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.23 via Frontend Transport; Tue, 14 Apr 2020 12:29:15 +0000
X-Tagtoolbar-Keys: D20200414152913886
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78bd8a33-9125-4d38-ca29-08d7e06f727d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53671432C9C554A6D05F32C0C1DA0@AM7PR08MB5367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39830400003)(376002)(396003)(366004)(346002)(66946007)(6486002)(478600001)(5660300002)(31686004)(31696002)(8676002)(66556008)(8936002)(81156014)(2906002)(66476007)(16526019)(86362001)(54906003)(52116002)(4326008)(186003)(16576012)(956004)(2616005)(107886003)(316002)(26005)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25jwxh9Ylp7vGT5QUJogiidkR0lkSSk0AufzjZKb/M066ty1j7gh6YgXQTkRrgcQ23GDWwjOWv/arhq/3ReFmJ8jEzqdpAXhR3PzYbP+A2yj+oPsFsXDJpsKNIwtxMHJcuPh+d5Og9C2C1xkpojGxLtXaTCEJBxUmZ7pnHohgLC/Uzr1QekSJ+9TfvHeV2EZrcd9bNJZ8IcLPjmqwZ11Z4zJjvp17mWR7Bi0rJHSbSJAIqhy66SDLPPmdQ11s0DcwleSgjFbd5w5zDJvaqKzyaD/2FSgbYTunLgQKBCemZ+HVSX1Gk68rl3tTeJTAt5Q09rjASgYKjbZccbyy0aSWQJStCzg4iv/uxYqzYW8HtOXF/hRo1tU06ohKtAuuKdBbDEFiGX9Me+HZ8qU8iOsKMi4cfX6eUEB2f0NPFMhPA61+wwavEMcSQ2U9BXk4Dpj
X-MS-Exchange-AntiSpam-MessageData: L4QN7Wj8DpA628tSsQWc0SlXkbM2q8D/wz/BaXDuqMgxFt4WYMPEM/GV8l4slLRgYEFP5vdPSRjcJkCkVw9UwE9j42K/fkehXf9OiVlmnrMNdamo2WMRrskPkgP/f9WuYMvJlyOcoyzqjcqKsYTHzg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bd8a33-9125-4d38-ca29-08d7e06f727d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 12:29:16.4287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr+KkpL61bYME9SnZ+jddliqBwM6J/g8oVG82iL5dMieApcIu4nksrQjwYREzFdzCGDeRswQdP4JGR6V2zqei1YxMVax5Joaum+APFki4Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.95
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.04.2020 15:20, Alberto Garcia wrote:
> On Tue 14 Apr 2020 11:44:57 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>        /* allocate a new l2 entry */
>>>    
>>> -    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * sizeof(uint64_t));
>>> +    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * l2_entry_size(s));
>>
>> hmm. s->l2_size * l2_entry_size, isn't it just s->cluster_size always?
>> Maybe, just refactor these things?
> 
> I think the patch is simpler to follow if I only do the strictly
> necessary changes and don't mix them with other things.
> 
>>>            nb_new_l2_tables = DIV_ROUND_UP(nb_new_data_clusters,
>>> -                                        s->cluster_size / sizeof(uint64_t));
>>> +                                        s->cluster_size / l2_entry_size(s));
>>
>> Isn't it just s->l2_size ?
> 
> Yes, same as before.
> 
>>>            /* The cluster range may not be aligned to L2 boundaries, so add one L2
>>>             * table for a potential head/tail */
>>>            nb_new_l2_tables++;
>>
>> Conversions looks correct, but how to check that we have converted
>> everything?
> 
> I went through all cases, I think I didn't miss any!
> 
>> I found this not converted chunk:
>>
>>       /* total size of L2 tables */
>>       nl2e = aligned_total_size / cluster_size;
>>       nl2e = ROUND_UP(nl2e, cluster_size / sizeof(uint64_t));
>>       meta_size += nl2e * sizeof(uint64_t);
> 
> This is used by qcow2_measure() and is fixed on a later patch because,
> unlike all other cases, it does not use a BlockDriverState to determine
> the size of an L2 entry.
> 
>> Hmm. How to avoid it? Maybe, at least, refactor the code, to drop all
>> sizeof(uint64_t), converting them to L2_ENTRY_SIZE, L1_ENTRY_SIZE,
>> REFTABLE_ENTRY_SIZE etc?
> 
> That wouldn't be a bad thing I guess but, again, for a separate patch or
> series.
> 
>> And all occurrences of pure '8' (not many of them exist)
> 
> I think most/all nowadays only refer to the number of bits per byte.
> 
> Maybe there's a couple that still need to be fixed, but we have been
> removing a lot of numeric literals from the qcow2 code (see for example
> b6c246942b, 3afea40243 or a35f87f50d).
> 


git grep '\<8\>' block/qcow2*

shows at least

qcow2-cluster.c:            s->l1_table_offset + 8 * l1_start_index, bufsize, false);
qcow2-cluster.c:                           s->l1_table_offset + 8 * l1_start_index,


-- 
Best regards,
Vladimir

